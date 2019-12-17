Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5F0C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:31:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED5E2072B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfUnYW5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED5E2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5ST-0000v9-78
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:31:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ih5DK-0003Lk-Ae
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 00:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ih5DI-0003dY-N6
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 00:16:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57254
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ih5DI-0003cJ-Id
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 00:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576559764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dUlDAtfcVLMRklp8hQ9k0o99XZdShJYWYb9iO1gCBC0=;
 b=NfUnYW5hvCFcgl+TViKGU82Il+NakXC2Yjc/AuxaftKkB2kxEMHKgKAGTTFrnQEAu76lIX
 kNWfVR52+MfZo/tEpQXUVL82SwNsEG8HBNgK7MP3V+mp/JhPZt7st05ny75Jncp1Y8bUwr
 llYBmbVYxu2L0NcVqp1ZYZKcBrEeqss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-6yVa4uJaNRKg78w-vX1snQ-1; Tue, 17 Dec 2019 00:16:02 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DCBF800D4E;
 Tue, 17 Dec 2019 05:16:01 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-6.gru2.redhat.com
 [10.97.116.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 740D019C4F;
 Tue, 17 Dec 2019 05:15:57 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/15] python/qemu: Add set_qmp_monitor() to QEMUMachine
Date: Tue, 17 Dec 2019 00:15:11 -0500
Message-Id: <20191217051521.1239-6-crosa@redhat.com>
In-Reply-To: <20191217051521.1239-1-crosa@redhat.com>
References: <20191217051521.1239-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 6yVa4uJaNRKg78w-vX1snQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-ppc@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wainer dos Santos Moschetta <wainersm@redhat.com>

The QEMUMachine VM has a monitor setup on which an QMP
connection is always attempted on _post_launch() (executed
by launch()). In case the QEMU process immediatly exits
then the qmp.accept() (used to establish the connection) stalls
until it reaches timeout and consequently an exception raises.

That behavior is undesirable when, for instance, it needs to
gather information from the QEMU binary ($ qemu -cpu list) or a
test which launches the VM expecting its failure.

This patch adds the set_qmp_monitor() method to QEMUMachine that
allows turn off the creation of the monitor machinery on VM launch.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20191211185536.16962-2-wainersm@redhat.com>
[Cleber: trivial indentation fix]
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 python/qemu/machine.py | 70 +++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 25 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index a4631d6934..734efd8536 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -104,6 +104,7 @@ class QEMUMachine(object):
         self._events =3D []
         self._iolog =3D None
         self._socket_scm_helper =3D socket_scm_helper
+        self._qmp_set =3D True   # Enable QMP monitor by default.
         self._qmp =3D None
         self._qemu_full_args =3D None
         self._test_dir =3D test_dir
@@ -228,15 +229,16 @@ class QEMUMachine(object):
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
+        if self._qmp_set:
+            if isinstance(self._monitor_address, tuple):
+                moncdev =3D "socket,id=3Dmon,host=3D%s,port=3D%s" % (
+                    self._monitor_address[0],
+                    self._monitor_address[1])
+            else:
+                moncdev =3D 'socket,id=3Dmon,path=3D%s' % self._vm_monitor
+            args.extend(['-chardev', moncdev, '-mon',
+                         'chardev=3Dmon,mode=3Dcontrol'])
         if self._machine is not None:
             args.extend(['-machine', self._machine])
         if self._console_set:
@@ -255,20 +257,21 @@ class QEMUMachine(object):
=20
     def _pre_launch(self):
         self._temp_dir =3D tempfile.mkdtemp(dir=3Dself._test_dir)
-        if self._monitor_address is not None:
-            self._vm_monitor =3D self._monitor_address
-        else:
-            self._vm_monitor =3D os.path.join(self._sock_dir,
-                                            self._name + "-monitor.sock")
-            self._remove_files.append(self._vm_monitor)
         self._qemu_log_path =3D os.path.join(self._temp_dir, self._name + =
".log")
         self._qemu_log_file =3D open(self._qemu_log_path, 'wb')
=20
-        self._qmp =3D qmp.QEMUMonitorProtocol(self._vm_monitor,
-                                            server=3DTrue)
+        if self._qmp_set:
+            if self._monitor_address is not None:
+                self._vm_monitor =3D self._monitor_address
+            else:
+                self._vm_monitor =3D os.path.join(self._sock_dir,
+                                                self._name + "-monitor.soc=
k")
+                self._remove_files.append(self._vm_monitor)
+            self._qmp =3D qmp.QEMUMonitorProtocol(self._vm_monitor, server=
=3DTrue)
=20
     def _post_launch(self):
-        self._qmp.accept()
+        if self._qmp:
+            self._qmp.accept()
=20
     def _post_shutdown(self):
         if self._qemu_log_file is not None:
@@ -330,7 +333,8 @@ class QEMUMachine(object):
         Wait for the VM to power off
         """
         self._popen.wait()
-        self._qmp.close()
+        if self._qmp:
+            self._qmp.close()
         self._load_io_log()
         self._post_shutdown()
=20
@@ -346,12 +350,13 @@ class QEMUMachine(object):
             self._console_socket =3D None
=20
         if self.is_running():
-            try:
-                if not has_quit:
-                    self._qmp.cmd('quit')
-                self._qmp.close()
-            except:
-                self._popen.kill()
+            if self._qmp:
+                try:
+                    if not has_quit:
+                        self._qmp.cmd('quit')
+                    self._qmp.close()
+                except:
+                    self._popen.kill()
             self._popen.wait()
=20
         self._load_io_log()
@@ -368,6 +373,21 @@ class QEMUMachine(object):
=20
         self._launched =3D False
=20
+    def set_qmp_monitor(self, enabled=3DTrue):
+        """
+        Set the QMP monitor.
+
+        @param enabled: if False, qmp monitor options will be removed from
+                        the base arguments of the resulting QEMU command
+                        line. Default is True.
+        @note: call this function before launch().
+        """
+        if enabled:
+            self._qmp_set =3D True
+        else:
+            self._qmp_set =3D False
+            self._qmp =3D None
+
     def qmp(self, cmd, conv_keys=3DTrue, **args):
         """
         Invoke a QMP command and return the response dict
--=20
2.21.0


