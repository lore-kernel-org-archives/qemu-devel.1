Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A968C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 20:45:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 537D920830
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 20:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537D920830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37613 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEK5l-0003fp-I8
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 16:45:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEK4q-0003AK-48
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEK4o-0000QN-De
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:44:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hEK4a-0000HP-HY; Wed, 10 Apr 2019 16:43:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C493D30254A0;
	Wed, 10 Apr 2019 20:43:49 +0000 (UTC)
Received: from blue.redhat.com (ovpn-117-110.phx2.redhat.com [10.3.117.110])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 94C565D9CD;
	Wed, 10 Apr 2019 20:43:46 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 10 Apr 2019 15:42:17 -0500
Message-Id: <20190410204215.5963-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Wed, 10 Apr 2019 20:43:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.0?] iotest: Fix 241 to run in generic
 directory
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
	John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410204217.JyIkGufdmNKDgEyB_AMvs9aJi-x71UvbA4lSrJC8S98@z>

Filter the qemu-nbd server output to get rid of a direct reference
to my build directory.

Fixes: e9dce9cb
Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---

Not worth -rc4 on its own, but if something else pops up that requires
another spin, I plan on a pull request for this one. Otherwise it
slips to 4.1, and 4.0 just has a broken iotest.

 tests/qemu-iotests/241     | 4 +++-
 tests/qemu-iotests/241.out | 6 +++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/241 b/tests/qemu-iotests/241
index 4b196857387..017a736aaba 100755
--- a/tests/qemu-iotests/241
+++ b/tests/qemu-iotests/241
@@ -28,6 +28,7 @@ nbd_unix_socket=3D$TEST_DIR/test_qemu_nbd_socket
 _cleanup()
 {
     _cleanup_test_img
+    rm -f "$TEST_DIR/server.log"
     nbd_server_stop
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
@@ -69,12 +70,13 @@ echo

 # Intentionally omit '-f' to force image probing, which in turn forces
 # sector alignment, here at the server.
-nbd_server_start_unix_socket "$TEST_IMG_FILE"
+nbd_server_start_unix_socket "$TEST_IMG_FILE" 2> "$TEST_DIR/server.log"

 $QEMU_NBD_PROG --list -k $nbd_unix_socket | grep '\(size\|min\)'
 $QEMU_IMG map -f raw --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
 $QEMU_IO -f raw -c map "$TEST_IMG"
 nbd_server_stop
+cat "$TEST_DIR/server.log" | _filter_testdir

 echo
 echo "=3D=3D=3D Exporting unaligned raw image, forced client sector alig=
nment =3D=3D=3D"
diff --git a/tests/qemu-iotests/241.out b/tests/qemu-iotests/241.out
index f481074a02e..75f9f465e52 100644
--- a/tests/qemu-iotests/241.out
+++ b/tests/qemu-iotests/241.out
@@ -10,13 +10,13 @@ QA output created by 241

 =3D=3D=3D Exporting unaligned raw image, forced server sector alignment =
=3D=3D=3D

-WARNING: Image format was not specified for '/home/eblake/qemu/tests/qem=
u-iotests/scratch/t.raw' and probing guessed raw.
-         Automatically detecting the format is dangerous for raw images,=
 write operations on block 0 will be restricted.
-         Specify the 'raw' format explicitly to remove the restrictions.
   size:  1024
   min block: 512
 [{ "start": 0, "length": 1024, "depth": 0, "zero": false, "data": true, =
"offset": OFFSET}]
 1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
+WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing=
 guessed raw.
+         Automatically detecting the format is dangerous for raw images,=
 write operations on block 0 will be restricted.
+         Specify the 'raw' format explicitly to remove the restrictions.

 =3D=3D=3D Exporting unaligned raw image, forced client sector alignment =
=3D=3D=3D

--=20
2.20.1


