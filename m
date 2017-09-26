Received: from eggs.gnu.org ([2001:4830:134:3::10]:50929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwywo-0007qV-RN
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 19:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwywl-0005PI-KN
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 19:07:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dwywl-0005Oi-BK
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 19:07:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 740B07E42E
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 23:07:22 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 26 Sep 2017 20:07:09 -0300
Message-Id: <20170926230709.22958-7-ehabkost@redhat.com>
In-Reply-To: <20170926230709.22958-1-ehabkost@redhat.com>
References: <20170926230709.22958-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 6/6] device-crash-test: Multi-device device_add
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Cleber Rosa <crosa@redhat.com>

When running device_add tests, test all devices in a single run
instead of restarting QEMU every time.

There's a plug_all testcase argument that can be used to make the
test code plug all devices at once.  I'm adding this mode because
there's a crash that was detected while testing the script
without any device_del command, but the crash goes away if we
device_del every device immediately:

  $ ../scripts/device-crash-test ./x86_64-softmmu/qemu-system-x86_64 --quick -t method=device_add  --strict -t plug_all=1
  INFO: running test case: binary=./x86_64-softmmu/qemu-system-x86_64 plug_all=1 accel=kvm machine=pc-0.12 device=* method=device_add
  WARNING: qemu received signal -6: ./x86_64-softmmu/qemu-system-x86_64 -chardev socket,id=mon,path=/var/tmp/qemu-23578-monitor.sock -mon chardev=mon,mode=control -display none -vga none -S -machine pc-0.12,accel=kvm
  ERROR: result: binary=./x86_64-softmmu/qemu-system-x86_64 plug_all=1 accel=kvm machine=pc-0.12 device=* method=device_add
  ERROR: cmdline: ./x86_64-softmmu/qemu-system-x86_64 -S -machine pc-0.12,accel=kvm
  ERROR: log: audio: Could not init `oss' audio driver
  ERROR: log: qemu-system-x86_64: .../qemu/migration/savevm.c:721: vmstate_register_with_alias_id: Assertion `!se->compat || se->instance_id == 0' failed.
  ERROR: last device_add device: usb-net
  ERROR: exit code: -6
  ERROR: exception:
  ERROR:   Traceback (most recent call last):
  ERROR:     File "../scripts/device-crash-test", line 437, in checkOneCase
  ERROR:       vm.command('device_add', driver=device, id=devid)
  ERROR:     File ".../qemu/scripts/qemu.py", line 269, in command
  ERROR:       raise qmp.qmp.QMPError("Monitor is closed")
  ERROR:   QMPError: Monitor is closed
  ERROR:
  INFO: Total: 1 test cases
  ERROR: Fatal failure: binary=./x86_64-softmmu/qemu-system-x86_64 plug_all=1 accel=kvm machine=pc-0.12 device=* method=device_add
  ERROR: Fatal failures on some machine/device combinations

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/device-crash-test | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 1245e214a0..43110fed15 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -404,10 +404,19 @@ def checkOneCase(args, testcase):
     assert method in ['-device', 'device_add']
 
     dbg("will test: %r", testcase)
+    if device == '*':
+        bi = getBinaryInfo(args, binary)
+        if method == '-device':
+            devices = list(bi.user_devs)
+        else:
+            devices = list(bi.hotpluggable_devs)
+    else:
+        devices = [device]
 
     args = ['-S', '-machine', '%s,accel=%s' % (machine, accel)]
     if method == '-device':
-        args.extend(['-device', qemuOptsEscape(device)])
+        for device in devices:
+            args.extend(['-device', qemuOptsEscape(device)])
     cmdline = ' '.join([binary] + args)
     dbg("will launch QEMU: %s", cmdline)
     vm = QEMUMachine(binary=binary, args=args)
@@ -418,11 +427,27 @@ def checkOneCase(args, testcase):
     try:
         vm.launch()
         if method == 'device_add':
-            dbg('running device_add %s', device)
-            try:
-                vm.command('device_add', driver=device)
-            except MonitorResponseError, e:
-                r['device_add_error'] = e.reply['error']['desc']
+            plug_all = int(testcase.get('plug_all', 0))
+            for device in devices:
+                r['device_add_device'] = device
+                dbg('running device_add %s', device)
+                devid = 'test-%s' % (device)
+                try:
+                    vm.command('device_add', driver=device, id=devid)
+                    if not plug_all:
+                        vm.command('device_del', id=devid)
+                except MonitorResponseError, e:
+                    r2 = r.copy()
+                    r2['device_add_error'] = e.reply['error']['desc']
+                    yield r2
+
+            if plug_all:
+                for device in devices:
+                    devid = 'test-%s' % (device)
+                    vm.command('device_del', id=devid)
+
+    except GeneratorExit:
+        raise
     except KeyboardInterrupt:
         raise
     except:
@@ -458,7 +483,7 @@ def plugMethods(args, testcase):
 
 def devicesToTest(args, testcase):
     if testcase['method'] == 'device_add':
-        return getBinaryInfo(args, testcase['binary']).hotpluggable_devs
+        return '*' # will test all devices in a single checkOneCase() call
     else:
         return getBinaryInfo(args, testcase['binary']).user_devs
 
@@ -520,6 +545,8 @@ def logResult(f, level):
     logger.log(level, "cmdline: %s", f['cmdline'])
     for l in f.get('log', '').strip().split('\n'):
         logger.log(level, "log: %s", l)
+    if 'device_add_device' in f:
+        logger.log(level, 'last device_add device: %s', f['device_add_device'])
     if 'device_add_error' in f:
         logger.log(level, "device_add error: %s", f['device_add_error'])
     logger.log(level, "exit code: %r", f.get('exitcode'))
-- 
2.13.5
