Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10047CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5B8208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d40SJIxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5B8208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP4JY-000653-Iz
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3vu-0001ZX-Ao
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3vs-0001NZ-SA
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24862
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3vs-0001NQ-O6
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s+6HHvmXTwLL5Br/Swin1Mm/2hcp4AacjnAi9Rdl8mo=;
 b=d40SJIxXzRFK05QcQM3mDPNfILWA4xfPfomRoltMyAxTQZdkqqum5qMX9S1cCerNnOpJOC
 X1HwJYtV9KOs/+6laKG68libIFD6TAE0aXrUWRzU6Oujm1ivI0IcheilNLho9c5egRTJE1
 Zvcdjo5x+uWGwAtTiEWofoQEOHL6Yh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-zdTHcMUaNiSZKMZjylvSoA-1; Mon, 28 Oct 2019 08:15:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C322E800FF1;
 Mon, 28 Oct 2019 12:15:32 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6672D100164D;
 Mon, 28 Oct 2019 12:15:32 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 14/69] iotests.py: Store socket files in $SOCK_DIR
Date: Mon, 28 Oct 2019 13:14:06 +0100
Message-Id: <20191028121501.15279-15-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: zdTHcMUaNiSZKMZjylvSoA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

iotests.py itself does not store socket files, but machine.py and
qtest.py do.  iotests.py needs to pass the respective path to them, and
they need to adhere to it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20191017133155.5327-3-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 python/qemu/machine.py        | 15 ++++++++++++---
 python/qemu/qtest.py          |  9 ++++++---
 tests/qemu-iotests/iotests.py |  4 +++-
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 128a3d1dc2..2024e8b1b1 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -71,7 +71,7 @@ class QEMUMachine(object):
=20
     def __init__(self, binary, args=3DNone, wrapper=3DNone, name=3DNone,
                  test_dir=3D"/var/tmp", monitor_address=3DNone,
-                 socket_scm_helper=3DNone):
+                 socket_scm_helper=3DNone, sock_dir=3DNone):
         '''
         Initialize a QEMUMachine
=20
@@ -90,6 +90,8 @@ class QEMUMachine(object):
             wrapper =3D []
         if name is None:
             name =3D "qemu-%d" % os.getpid()
+        if sock_dir is None:
+            sock_dir =3D test_dir
         self._name =3D name
         self._monitor_address =3D monitor_address
         self._vm_monitor =3D None
@@ -106,12 +108,14 @@ class QEMUMachine(object):
         self._qemu_full_args =3D None
         self._test_dir =3D test_dir
         self._temp_dir =3D None
+        self._sock_dir =3D sock_dir
         self._launched =3D False
         self._machine =3D None
         self._console_set =3D False
         self._console_device_type =3D None
         self._console_address =3D None
         self._console_socket =3D None
+        self._remove_files =3D []
=20
         # just in case logging wasn't configured by the main script:
         logging.basicConfig()
@@ -236,8 +240,9 @@ class QEMUMachine(object):
         if self._machine is not None:
             args.extend(['-machine', self._machine])
         if self._console_set:
-            self._console_address =3D os.path.join(self._temp_dir,
+            self._console_address =3D os.path.join(self._sock_dir,
                                                  self._name + "-console.so=
ck")
+            self._remove_files.append(self._console_address)
             chardev =3D ('socket,id=3Dconsole,path=3D%s,server,nowait' %
                        self._console_address)
             args.extend(['-chardev', chardev])
@@ -253,8 +258,9 @@ class QEMUMachine(object):
         if self._monitor_address is not None:
             self._vm_monitor =3D self._monitor_address
         else:
-            self._vm_monitor =3D os.path.join(self._temp_dir,
+            self._vm_monitor =3D os.path.join(self._sock_dir,
                                             self._name + "-monitor.sock")
+            self._remove_files.append(self._vm_monitor)
         self._qemu_log_path =3D os.path.join(self._temp_dir, self._name + =
".log")
         self._qemu_log_file =3D open(self._qemu_log_path, 'wb')
=20
@@ -279,6 +285,9 @@ class QEMUMachine(object):
             shutil.rmtree(self._temp_dir)
             self._temp_dir =3D None
=20
+        while len(self._remove_files) > 0:
+            self._remove_if_exists(self._remove_files.pop())
+
     def launch(self):
         """
         Launch the VM and make sure we cleanup and expose the
diff --git a/python/qemu/qtest.py b/python/qemu/qtest.py
index 3f1d2cb325..d24ad04256 100644
--- a/python/qemu/qtest.py
+++ b/python/qemu/qtest.py
@@ -84,14 +84,17 @@ class QEMUQtestMachine(QEMUMachine):
     '''A QEMU VM'''
=20
     def __init__(self, binary, args=3DNone, name=3DNone, test_dir=3D"/var/=
tmp",
-                 socket_scm_helper=3DNone):
+                 socket_scm_helper=3DNone, sock_dir=3DNone):
         if name is None:
             name =3D "qemu-%d" % os.getpid()
+        if sock_dir is None:
+            sock_dir =3D test_dir
         super(QEMUQtestMachine,
               self).__init__(binary, args, name=3Dname, test_dir=3Dtest_di=
r,
-                             socket_scm_helper=3Dsocket_scm_helper)
+                             socket_scm_helper=3Dsocket_scm_helper,
+                             sock_dir=3Dsock_dir)
         self._qtest =3D None
-        self._qtest_path =3D os.path.join(test_dir, name + "-qtest.sock")
+        self._qtest_path =3D os.path.join(sock_dir, name + "-qtest.sock")
=20
     def _base_args(self):
         args =3D super(QEMUQtestMachine, self)._base_args()
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index a4a2238b42..9bfcef1f14 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -57,6 +57,7 @@ qemu_opts =3D os.environ.get('QEMU_OPTIONS', '').strip().=
split(' ')
 imgfmt =3D os.environ.get('IMGFMT', 'raw')
 imgproto =3D os.environ.get('IMGPROTO', 'file')
 test_dir =3D os.environ.get('TEST_DIR')
+sock_dir =3D os.environ.get('SOCK_DIR')
 output_dir =3D os.environ.get('OUTPUT_DIR', '.')
 cachemode =3D os.environ.get('CACHEMODE')
 qemu_default_machine =3D os.environ.get('QEMU_DEFAULT_MACHINE')
@@ -456,7 +457,8 @@ class VM(qtest.QEMUQtestMachine):
         name =3D "qemu%s-%d" % (path_suffix, os.getpid())
         super(VM, self).__init__(qemu_prog, qemu_opts, name=3Dname,
                                  test_dir=3Dtest_dir,
-                                 socket_scm_helper=3Dsocket_scm_helper)
+                                 socket_scm_helper=3Dsocket_scm_helper,
+                                 sock_dir=3Dsock_dir)
         self._num_drives =3D 0
=20
     def add_object(self, opts):
--=20
2.21.0


