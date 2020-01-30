Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C49C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:37:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F7D82083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBEAa3Zl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7D82083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixHVK-0007wY-OO
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 16:37:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ixHRD-0000iC-80
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:33:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ixHRB-0007TO-0V
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:33:23 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52203
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ixHRA-0007OO-TQ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580419996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+uHZ8irsP+n1mN8+V04sGNyPvPznAWy8yeCAASWzUVc=;
 b=NBEAa3ZlQDk7WkAxuANZWETqOLWBKrdTCQwuHhZVShh6jn1rHtzDzJ8XmEqse2Xr+mMv0T
 b6jDIluaxd83oR1O1OK7/U8brMwAnjQZ9czcLrcTYfBahiRYxtJN5176y9yww+061jhZsA
 Z7JvFLYC4i9aBMrTaJm2xD5dUNqFTRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-HAW9hGltPRCEm9owgL-DpA-1; Thu, 30 Jan 2020 16:33:10 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13F49107ACC5;
 Thu, 30 Jan 2020 21:33:09 +0000 (UTC)
Received: from localhost (unknown [10.36.118.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ADBDF1001B23;
 Thu, 30 Jan 2020 21:33:03 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/18] tests/qemu-iotests: use AIOMODE with various tests
Date: Thu, 30 Jan 2020 21:31:14 +0000
Message-Id: <20200130213114.325157-19-stefanha@redhat.com>
In-Reply-To: <20200130213114.325157-1-stefanha@redhat.com>
References: <20200130213114.325157-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: HAW9hGltPRCEm9owgL-DpA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 qemu-block@nongnu.org, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aarushi Mehta <mehta.aaru20@gmail.com>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20200120141858.587874-16-stefanha@redhat.com
Message-Id: <20200120141858.587874-16-stefanha@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/028 |  2 +-
 tests/qemu-iotests/058 |  2 +-
 tests/qemu-iotests/089 |  4 ++--
 tests/qemu-iotests/091 |  4 ++--
 tests/qemu-iotests/109 |  2 +-
 tests/qemu-iotests/147 |  5 +++--
 tests/qemu-iotests/181 |  8 ++++----
 tests/qemu-iotests/183 |  4 ++--
 tests/qemu-iotests/185 | 10 +++++-----
 tests/qemu-iotests/200 |  2 +-
 tests/qemu-iotests/201 |  8 ++++----
 11 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index e2556d8e57..797dae5350 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -108,7 +108,7 @@ echo block-backup
 echo
=20
 qemu_comm_method=3D"monitor"
-_launch_qemu -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},id=3Ddisk
+_launch_qemu -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},aio=3D${AIOM=
ODE},id=3Ddisk
 h=3D$QEMU_HANDLE
 if [ "${VALGRIND_QEMU}" =3D=3D "y" ]; then
     QEMU_COMM_TIMEOUT=3D7
diff --git a/tests/qemu-iotests/058 b/tests/qemu-iotests/058
index d5304bb404..d84740ed9f 100755
--- a/tests/qemu-iotests/058
+++ b/tests/qemu-iotests/058
@@ -65,7 +65,7 @@ nbd_snapshot_img=3D"nbd:unix:$nbd_unix_socket"
 converted_image=3D$TEST_IMG.converted
=20
 # Use -f raw instead of -f $IMGFMT for the NBD connection
-QEMU_IO_NBD=3D"$QEMU_IO -f raw --cache=3D$CACHEMODE"
+QEMU_IO_NBD=3D"$QEMU_IO -f raw --cache=3D$CACHEMODE --aio=3D$AIOMODE"
=20
 echo
 echo "=3D=3D preparing image =3D=3D"
diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
index ad029f1f09..059ad75e28 100755
--- a/tests/qemu-iotests/089
+++ b/tests/qemu-iotests/089
@@ -64,7 +64,7 @@ $QEMU_IO -c 'write -P 42 0 512' -c 'write -P 23 512 512' =
\
=20
 $QEMU_IMG convert -f raw -O $IMGFMT "$TEST_IMG.base" "$TEST_IMG"
=20
-$QEMU_IO_PROG --cache $CACHEMODE \
+$QEMU_IO_PROG --cache $CACHEMODE --aio $AIOMODE \
          -c 'read -P 42 0 512' -c 'read -P 23 512 512' \
          -c 'read -P 66 1024 512' "json:{
     \"driver\": \"$IMGFMT\",
@@ -111,7 +111,7 @@ $QEMU_IO -c 'write -P 42 0x38000 512' "$TEST_IMG" | _fi=
lter_qemu_io
=20
 # The "image.filename" part tests whether "a": { "b": "c" } and "a.b": "c"=
 do
 # the same (which they should).
-$QEMU_IO_PROG --cache $CACHEMODE \
+$QEMU_IO_PROG --cache $CACHEMODE --aio $AIOMODE  \
      -c 'read -P 42 0x38000 512' "json:{
     \"driver\": \"$IMGFMT\",
     \"file\": {
diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
index 0874fa84c8..d2a2aca347 100755
--- a/tests/qemu-iotests/091
+++ b/tests/qemu-iotests/091
@@ -60,13 +60,13 @@ echo =3D=3D=3D Starting QEMU VM1 =3D=3D=3D
 echo
=20
 qemu_comm_method=3D"monitor"
-_launch_qemu -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},id=3Ddisk
+_launch_qemu -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},aio=3D${AIOM=
ODE},id=3Ddisk
 h1=3D$QEMU_HANDLE
=20
 echo
 echo =3D=3D=3D Starting QEMU VM2 =3D=3D=3D
 echo
-_launch_qemu -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},id=3Ddisk \
+_launch_qemu -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},aio=3D${AIOM=
ODE},id=3Ddisk \
              -incoming "exec: cat '${MIG_FIFO}'"
 h2=3D$QEMU_HANDLE
=20
diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
index ba638db11f..a51dd84b3d 100755
--- a/tests/qemu-iotests/109
+++ b/tests/qemu-iotests/109
@@ -52,7 +52,7 @@ run_qemu()
     local qmp_format=3D"$3"
     local qmp_event=3D"$4"
=20
-    _launch_qemu -drive file=3D"${source_img}",format=3Draw,cache=3D${CACH=
EMODE},id=3Dsrc
+    _launch_qemu -drive file=3D"${source_img}",format=3Draw,cache=3D${CACH=
EMODE},aio=3D${AIOMODE},id=3Dsrc
     _send_qemu_cmd $QEMU_HANDLE "{ 'execute': 'qmp_capabilities' }" "retur=
n"
=20
     _send_qemu_cmd $QEMU_HANDLE \
diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
index 03fc2fabcf..2b6f859a09 100755
--- a/tests/qemu-iotests/147
+++ b/tests/qemu-iotests/147
@@ -24,7 +24,7 @@ import socket
 import stat
 import time
 import iotests
-from iotests import cachemode, imgfmt, qemu_img, qemu_nbd, qemu_nbd_early_=
pipe
+from iotests import cachemode, aiomode, imgfmt, qemu_img, qemu_nbd, qemu_n=
bd_early_pipe
=20
 NBD_PORT_START      =3D 32768
 NBD_PORT_END        =3D NBD_PORT_START + 1024
@@ -134,7 +134,8 @@ class BuiltinNBD(NBDBlockdevAddBase):
         self.server.add_drive_raw('if=3Dnone,id=3Dnbd-export,' +
                                   'file=3D%s,' % test_img +
                                   'format=3D%s,' % imgfmt +
-                                  'cache=3D%s' % cachemode)
+                                  'cache=3D%s' % cachemode +
+                                  'aio=3D%s' % aiomode)
         self.server.launch()
=20
     def tearDown(self):
diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
index 378c2899d1..438c2dcd80 100755
--- a/tests/qemu-iotests/181
+++ b/tests/qemu-iotests/181
@@ -58,20 +58,20 @@ qemu_comm_method=3D"monitor"
=20
 if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
     _launch_qemu \
-        -drive "${TEST_IMG}",cache=3D${CACHEMODE},id=3Ddisk
+        -drive "${TEST_IMG}",cache=3D${CACHEMODE},aio=3D$AIOMODE,id=3Ddisk
 else
     _launch_qemu \
-        -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},driver=3D$IMGFMT,=
id=3Ddisk
+        -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},aio=3D$AIOMODE,dr=
iver=3D$IMGFMT,id=3Ddisk
 fi
 src=3D$QEMU_HANDLE
=20
 if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
     _launch_qemu \
-        -drive "${TEST_IMG}",cache=3D${CACHEMODE},id=3Ddisk \
+        -drive "${TEST_IMG}",cache=3D${CACHEMODE},aio=3D$AIOMODE,id=3Ddisk=
 \
         -incoming "unix:${MIG_SOCKET}"
 else
     _launch_qemu \
-        -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},driver=3D$IMGFMT,=
id=3Ddisk \
+        -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},aio=3D$AIOMODE,dr=
iver=3D$IMGFMT,id=3Ddisk \
         -incoming "unix:${MIG_SOCKET}"
 fi
 dest=3D$QEMU_HANDLE
diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index 3f74b9f62d..64621617f5 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -56,12 +56,12 @@ echo
 qemu_comm_method=3D"qmp"
=20
 _launch_qemu \
-    -drive file=3D"${TEST_IMG}",cache=3D$CACHEMODE,driver=3D$IMGFMT,id=3Dd=
isk
+    -drive file=3D"${TEST_IMG}",cache=3D$CACHEMODE,aio=3D$AIOMODE,driver=
=3D$IMGFMT,id=3Ddisk
 src=3D$QEMU_HANDLE
 _send_qemu_cmd $src "{ 'execute': 'qmp_capabilities' }" 'return'
=20
 _launch_qemu \
-    -drive file=3D"${TEST_IMG}.dest",cache=3D$CACHEMODE,driver=3D$IMGFMT,i=
d=3Ddisk \
+    -drive file=3D"${TEST_IMG}.dest",cache=3D$CACHEMODE,aio=3D$AIOMODE,dri=
ver=3D$IMGFMT,id=3Ddisk \
     -incoming "unix:${MIG_SOCKET}"
 dest=3D$QEMU_HANDLE
 _send_qemu_cmd $dest "{ 'execute': 'qmp_capabilities' }" 'return'
diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index e50f19ebf0..fd5e6ebe11 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -54,7 +54,7 @@ echo
 qemu_comm_method=3D"qmp"
=20
 _launch_qemu \
-    -drive file=3D"${TEST_IMG}.base",cache=3D$CACHEMODE,driver=3D$IMGFMT,i=
d=3Ddisk
+    -drive file=3D"${TEST_IMG}.base",cache=3D$CACHEMODE,aio=3D$AIOMODE,dri=
ver=3D$IMGFMT,id=3Ddisk
 h=3D$QEMU_HANDLE
 _send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" 'return'
=20
@@ -125,7 +125,7 @@ echo =3D=3D=3D Start active commit job and exit qemu =
=3D=3D=3D
 echo
=20
 _launch_qemu \
-    -drive file=3D"${TEST_IMG}",cache=3D$CACHEMODE,driver=3D$IMGFMT,id=3Dd=
isk
+    -drive file=3D"${TEST_IMG}",cache=3D$CACHEMODE,aio=3D$AIOMODE,driver=
=3D$IMGFMT,id=3Ddisk
 h=3D$QEMU_HANDLE
 _send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" 'return'
=20
@@ -147,7 +147,7 @@ echo =3D=3D=3D Start mirror job and exit qemu =3D=3D=3D
 echo
=20
 _launch_qemu \
-    -drive file=3D"${TEST_IMG}",cache=3D$CACHEMODE,driver=3D$IMGFMT,id=3Dd=
isk
+    -drive file=3D"${TEST_IMG}",cache=3D$CACHEMODE,aio=3D$AIOMODE,driver=
=3D$IMGFMT,id=3Ddisk
 h=3D$QEMU_HANDLE
 _send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" 'return'
=20
@@ -172,7 +172,7 @@ echo =3D=3D=3D Start backup job and exit qemu =3D=3D=3D
 echo
=20
 _launch_qemu \
-    -drive file=3D"${TEST_IMG}",cache=3D$CACHEMODE,driver=3D$IMGFMT,id=3Dd=
isk
+    -drive file=3D"${TEST_IMG}",cache=3D$CACHEMODE,aio=3D$AIOMODE,driver=
=3D$IMGFMT,id=3Ddisk
 h=3D$QEMU_HANDLE
 _send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" 'return'
=20
@@ -196,7 +196,7 @@ echo =3D=3D=3D Start streaming job and exit qemu =3D=3D=
=3D
 echo
=20
 _launch_qemu \
-    -drive file=3D"${TEST_IMG}",cache=3D$CACHEMODE,driver=3D$IMGFMT,id=3Dd=
isk
+    -drive file=3D"${TEST_IMG}",cache=3D$CACHEMODE,aio=3D$AIOMODE,driver=
=3D$IMGFMT,id=3Ddisk
 h=3D$QEMU_HANDLE
 _send_qemu_cmd $h "{ 'execute': 'qmp_capabilities' }" 'return'
=20
diff --git a/tests/qemu-iotests/200 b/tests/qemu-iotests/200
index a2cdd7f83d..59f7854b9f 100755
--- a/tests/qemu-iotests/200
+++ b/tests/qemu-iotests/200
@@ -67,7 +67,7 @@ echo =3D=3D=3D Starting QEMU VM =3D=3D=3D
 echo
 qemu_comm_method=3D"qmp"
 _launch_qemu -object iothread,id=3Diothread0 $virtio_scsi \
-             -drive file=3D"${TEST_IMG}",media=3Ddisk,if=3Dnone,cache=3D$C=
ACHEMODE,id=3Ddrive_sysdisk,format=3D$IMGFMT \
+             -drive file=3D"${TEST_IMG}",media=3Ddisk,if=3Dnone,cache=3D$C=
ACHEMODE,aio=3D$AIOMODE,id=3Ddrive_sysdisk,format=3D$IMGFMT \
              -device scsi-hd,drive=3Ddrive_sysdisk,bus=3Dscsi0.0,id=3Dsysd=
isk,bootindex=3D0
 h1=3D$QEMU_HANDLE
=20
diff --git a/tests/qemu-iotests/201 b/tests/qemu-iotests/201
index 133ba9f03e..483eb189c5 100755
--- a/tests/qemu-iotests/201
+++ b/tests/qemu-iotests/201
@@ -58,20 +58,20 @@ qemu_comm_method=3D"monitor"
=20
 if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
     _launch_qemu \
-        -drive "${TEST_IMG}",cache=3D${CACHEMODE},id=3Ddisk
+        -drive "${TEST_IMG}",cache=3D${CACHEMODE},aio=3D$AIOMODE,id=3Ddisk
 else
     _launch_qemu \
-        -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},driver=3D$IMGFMT,=
id=3Ddisk
+        -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},aio=3D$AIOMODE,dr=
iver=3D$IMGFMT,id=3Ddisk
 fi
 src=3D$QEMU_HANDLE
=20
 if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
     _launch_qemu \
-        -drive "${TEST_IMG}",cache=3D${CACHEMODE},id=3Ddisk \
+        -drive "${TEST_IMG}",cache=3D${CACHEMODE},aio=3D$AIOMODE,id=3Ddisk=
 \
         -incoming "unix:${MIG_SOCKET}"
 else
     _launch_qemu \
-        -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},driver=3D$IMGFMT,=
id=3Ddisk \
+        -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},aio=3D$AIOMODE,dr=
iver=3D$IMGFMT,id=3Ddisk \
         -incoming "unix:${MIG_SOCKET}"
 fi
 dest=3D$QEMU_HANDLE
--=20
2.24.1


