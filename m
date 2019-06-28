Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90239C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:22:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6476F205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6476F205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgteK-00067d-F8
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 12:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49787)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <wainersm@redhat.com>) id 1hgsOp-0002I0-V0
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:02:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1hgsOg-0004mX-JB
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:02:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39792)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1hgsOX-0004i1-5g
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:02:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7099E811A9
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 15:02:32 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 959995D704;
 Fri, 28 Jun 2019 15:02:25 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 11:02:15 -0400
Message-Id: <20190628150217.32659-2-wainersm@redhat.com>
In-Reply-To: <20190628150217.32659-1-wainersm@redhat.com>
References: <20190628150217.32659-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 28 Jun 2019 15:02:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/3] python/qemu: Allow to launch the VM
 without qmp
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: philmd@redhat.com, jsnow@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMUMachine launches the VM with a monitor enabled, afterwards
a qmp connection is attempted on _post_launch(). In case
the QEMU process exits with an error, qmp.accept() reaches
timeout and raises an exception.

But sometimes you don't need that monitor. As an example,
when a test launches the VM expecting its immediate crash,
and only intend to check the process's return code. In this
case the fact that launch() tries to establish the qmp
connection (ending up in an exception) is troublesome.

So this patch adds the set_qmp_monitor() that allow to
launch the VM without creating the monitor machinery.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 python/qemu/__init__.py | 72 +++++++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 24 deletions(-)

diff --git a/python/qemu/__init__.py b/python/qemu/__init__.py
index dbaf8a5311..dd577e9446 100644
--- a/python/qemu/__init__.py
+++ b/python/qemu/__init__.py
@@ -113,6 +113,7 @@ class QEMUMachine(object):
         self._events =3D []
         self._iolog =3D None
         self._socket_scm_helper =3D socket_scm_helper
+        self._qmp_set =3D True   # Enable QMP monitor by default.
         self._qmp =3D None
         self._qemu_full_args =3D None
         self._test_dir =3D test_dir
@@ -227,15 +228,7 @@ class QEMUMachine(object):
                 self._iolog =3D iolog.read()
=20
     def _base_args(self):
-        if isinstance(self._monitor_address, tuple):
-            moncdev =3D "socket,id=3Dmon,host=3D%s,port=3D%s" % (
-                self._monitor_address[0],
-                self._monitor_address[1])
-        else:
-            moncdev =3D 'socket,id=3Dmon,path=3D%s' % self._vm_monitor
-        args =3D ['-chardev', moncdev,
-                '-mon', 'chardev=3Dmon,mode=3Dcontrol',
-                '-display', 'none', '-vga', 'none']
+        args =3D ['-display', 'none', '-vga', 'none']
         if self._machine is not None:
             args.extend(['-machine', self._machine])
         if self._console_set:
@@ -249,23 +242,33 @@ class QEMUMachine(object):
             else:
                 device =3D '%s,chardev=3Dconsole' % self._console_device=
_type
                 args.extend(['-device', device])
+        if self._qmp_set:
+            if isinstance(self._monitor_address, tuple):
+                moncdev =3D "socket,id=3Dmon,host=3D%s,port=3D%s" % (
+                    self._monitor_address[0],
+                    self._monitor_address[1])
+            else:
+                moncdev =3D 'socket,id=3Dmon,path=3D%s' % self._vm_monit=
or
+            args.extend(['-chardev', moncdev, '-mon', 'chardev=3Dmon,mod=
e=3Dcontrol'])
+
         return args
=20
     def _pre_launch(self):
         self._temp_dir =3D tempfile.mkdtemp(dir=3Dself._test_dir)
-        if self._monitor_address is not None:
-            self._vm_monitor =3D self._monitor_address
-        else:
-            self._vm_monitor =3D os.path.join(self._temp_dir,
-                                            self._name + "-monitor.sock"=
)
         self._qemu_log_path =3D os.path.join(self._temp_dir, self._name =
+ ".log")
         self._qemu_log_file =3D open(self._qemu_log_path, 'wb')
=20
-        self._qmp =3D qmp.QEMUMonitorProtocol(self._vm_monitor,
-                                            server=3DTrue)
-
+        if self._qmp_set:
+            if self._monitor_address is not None:
+                self._vm_monitor =3D self._monitor_address
+            else:
+                self._vm_monitor =3D os.path.join(self._temp_dir,
+                                            self._name + "-monitor.sock"=
)
+            self._qmp =3D qmp.QEMUMonitorProtocol(self._vm_monitor,
+                                                    server=3DTrue)
     def _post_launch(self):
-        self._qmp.accept()
+        if self._qmp:
+            self._qmp.accept()
=20
     def _post_shutdown(self):
         if self._qemu_log_file is not None:
@@ -328,7 +331,8 @@ class QEMUMachine(object):
         Wait for the VM to power off
         """
         self._popen.wait()
-        self._qmp.close()
+        if self._qmp:
+            self._qmp.close()
         self._load_io_log()
         self._post_shutdown()
=20
@@ -337,11 +341,14 @@ class QEMUMachine(object):
         Terminate the VM and clean up
         """
         if self.is_running():
-            try:
-                self._qmp.cmd('quit')
-                self._qmp.close()
-            except:
-                self._popen.kill()
+            if self._qmp:
+                try:
+                    self._qmp.cmd('quit')
+                    self._qmp.close()
+                except:
+                    self._popen.kill()
+            else:
+                self._popen.terminate()
             self._popen.wait()
=20
         self._load_io_log()
@@ -358,6 +365,23 @@ class QEMUMachine(object):
=20
         self._launched =3D False
=20
+    def set_qmp_monitor(self, disabled=3DFalse, monitor_address=3DNone):
+        """
+        Set the QMP monitor.
+
+        @param disabled: if True, qmp monitor options will be removed fr=
om the
+                         base arguments of the resulting QEMU command li=
ne.
+        @param monitor_address: address for the QMP monitor.
+        @note: call this function before launch().
+        """
+        if disabled:
+            self._qmp_set =3D False
+            self._qmp =3D None
+        else:
+            self._qmp_set =3D True
+            if monitor_address:
+                self._monitor_address =3D monitor_address
+
     def qmp(self, cmd, conv_keys=3DTrue, **args):
         """
         Invoke a QMP command and return the response dict
--=20
2.21.0


