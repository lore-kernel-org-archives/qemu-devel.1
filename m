Received: from eggs.gnu.org ([2001:4830:134:3::10]:50919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwywn-0007nm-3I
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 19:07:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwywj-0005OB-SE
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 19:07:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dwywj-0005NP-Jy
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 19:07:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B81C981DFC
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 23:07:20 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 26 Sep 2017 20:07:08 -0300
Message-Id: <20170926230709.22958-6-ehabkost@redhat.com>
In-Reply-To: <20170926230709.22958-1-ehabkost@redhat.com>
References: <20170926230709.22958-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 5/6] device-crash-test: Basic device_add support
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

Add a 'method' testcase argument that will test the device using
device_add instead of -device.  A new device_add_error whitelist
key is now supported, to catch device_add errors.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/device-crash-test | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 4c23ffa449..1245e214a0 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -35,7 +35,7 @@ import argparse
 from itertools import chain
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'scripts'))
-from qemu import QEMUMachine
+from qemu import QEMUMachine, MonitorResponseError
 
 logger = logging.getLogger('device-crash-test')
 dbg = logger.debug
@@ -203,6 +203,11 @@ ERROR_WHITELIST = [
     {'log':r"core 0 already populated"},
     {'log':r"could not find stage1 bootloader"},
 
+    {'exitcode':None, 'device_add_error':r"^Bus '[\w.-]+' does not support hotplugging$"},
+    {'exitcode':None, 'device_add_error':r"^No '[\w-]+' bus found for device '[\w-]+'$"},
+    # There are too many ways device_add can fail, ignore all of them as long as QEMU doesn't crash:
+    {'exitcode':None, 'device_add_error':r".+"},
+
     # other exitcode=1 failures not listed above will just generate INFO messages:
     {'exitcode':1, 'loglevel':logging.INFO},
 
@@ -290,7 +295,10 @@ def whitelistResultMatch(wl, r):
              r.get('exitcode') == wl.get('exitcode', 1)) and
             ('log' not in wl or
              ('log' in r and
-              re.search(wl['log'], r['log'], re.MULTILINE))))
+              re.search(wl['log'], r['log'], re.MULTILINE))) and
+            ('device_add_error' not in wl or
+             ('device_add_error' in r and
+              re.search(wl['device_add_error'], r['device_add_error']))))
 
 
 def checkResultWhitelist(r):
@@ -339,6 +347,7 @@ class QemuBinaryInfo(object):
             self.alldevs = set(qomListTypeNames(vm, implements=devtype, abstract=False))
             self.dev_info = dict((t, vm.command('query-device-type', typename=t)) for t in self.alldevs)
             self.user_devs = set(d for d in self.alldevs if self.dev_info[d]['user-creatable'])
+            self.hotpluggable_devs = set(d for d in self.alldevs if self.dev_info[d]['hotpluggable'])
             self.machines = list(m['name'] for m in vm.command('query-machines'))
             self.kvm_available = vm.command('query-kvm')['enabled']
         finally:
@@ -391,11 +400,14 @@ def checkOneCase(args, testcase):
     accel = testcase['accel']
     machine = testcase['machine']
     device = testcase['device']
+    method = testcase['method']
+    assert method in ['-device', 'device_add']
 
     dbg("will test: %r", testcase)
 
-    args = ['-S', '-machine', '%s,accel=%s' % (machine, accel),
-            '-device', qemuOptsEscape(device)]
+    args = ['-S', '-machine', '%s,accel=%s' % (machine, accel)]
+    if method == '-device':
+        args.extend(['-device', qemuOptsEscape(device)])
     cmdline = ' '.join([binary] + args)
     dbg("will launch QEMU: %s", cmdline)
     vm = QEMUMachine(binary=binary, args=args)
@@ -405,6 +417,12 @@ def checkOneCase(args, testcase):
 
     try:
         vm.launch()
+        if method == 'device_add':
+            dbg('running device_add %s', device)
+            try:
+                vm.command('device_add', driver=device)
+            except MonitorResponseError, e:
+                r['device_add_error'] = e.reply['error']['desc']
     except KeyboardInterrupt:
         raise
     except:
@@ -434,14 +452,22 @@ def machinesToTest(args, testcase):
     return getBinaryInfo(args, testcase['binary']).machines
 
 
+def plugMethods(args, testcase):
+    return ['-device', 'device_add']
+
+
 def devicesToTest(args, testcase):
-    return getBinaryInfo(args, testcase['binary']).user_devs
+    if testcase['method'] == 'device_add':
+        return getBinaryInfo(args, testcase['binary']).hotpluggable_devs
+    else:
+        return getBinaryInfo(args, testcase['binary']).user_devs
 
 
 TESTCASE_VARIABLES = [
     ('binary', binariesToTest),
     ('accel', accelsToTest),
     ('machine', machinesToTest),
+    ('method', plugMethods),
     ('device', devicesToTest),
 ]
 
@@ -494,6 +520,8 @@ def logResult(f, level):
     logger.log(level, "cmdline: %s", f['cmdline'])
     for l in f.get('log', '').strip().split('\n'):
         logger.log(level, "log: %s", l)
+    if 'device_add_error' in f:
+        logger.log(level, "device_add error: %s", f['device_add_error'])
     logger.log(level, "exit code: %r", f.get('exitcode'))
     if 'exc_traceback' in f:
         logger.log(level, "exception:")
-- 
2.13.5
