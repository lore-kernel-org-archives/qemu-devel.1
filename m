Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93879C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 18:59:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6471E20836
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 18:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IpMT+5Qi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6471E20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if7DD-0003Ox-4N
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 13:59:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1if79I-00086F-9s
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 13:55:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1if79G-0006UW-21
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 13:55:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55728
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1if79F-0006TO-Ts
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 13:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576090545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3bSEH2MNBHb9zRWEcSfzytTWqVdg55a5Y7VZz2LuXXQ=;
 b=IpMT+5QiVh5Lv1u2vmb8J2LHHwMvFDb9nzAHkTvYJyXiDXZz4lzzXB1sgkoagm/3y7QRu8
 NGHaXvB2omuYDoc2EkwWp00AG02aGZScf+nrmTeEVBK7WlKKfP8Nqr6ITI1LWGcZcDREMA
 MOxY7CgQU69TLT2gsfx0HdIyirx/EJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-RpaXykCiMrmnlXuYoIjfwQ-1; Wed, 11 Dec 2019 13:55:42 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 482D0DB20
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 18:55:41 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A15875D6AE;
 Wed, 11 Dec 2019 18:55:40 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] python/qemu: Add set_qmp_monitor() to QEMUMachine
Date: Wed, 11 Dec 2019 13:55:35 -0500
Message-Id: <20191211185536.16962-2-wainersm@redhat.com>
In-Reply-To: <20191211185536.16962-1-wainersm@redhat.com>
References: <20191211185536.16962-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: RpaXykCiMrmnlXuYoIjfwQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: philmd@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 python/qemu/machine.py | 66 +++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 23 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index a4631d6934..7d4d621a42 100644
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
+        args =3D ['-display', 'none', '-vga', 'none']
+        if self._qmp_set:
+            if isinstance(self._monitor_address, tuple):
+                moncdev =3D "socket,id=3Dmon,host=3D%s,port=3D%s" % (
                 self._monitor_address[0],
                 self._monitor_address[1])
-        else:
-            moncdev =3D 'socket,id=3Dmon,path=3D%s' % self._vm_monitor
-        args =3D ['-chardev', moncdev,
-                '-mon', 'chardev=3Dmon,mode=3Dcontrol',
-                '-display', 'none', '-vga', 'none']
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


