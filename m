Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74736C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:20:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D2C9205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2C9205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48481 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO1tS-0000Zu-FI
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:20:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO1rX-0007s1-MT
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:18:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO1rW-0003u1-E1
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:18:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hO1rQ-0003oX-KH; Tue, 07 May 2019 11:18:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CBBC9C04FFF1;
	Tue,  7 May 2019 15:18:26 +0000 (UTC)
Received: from localhost (unknown [10.40.205.217])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6356F5D9CC;
	Tue,  7 May 2019 15:18:26 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  7 May 2019 17:18:10 +0200
Message-Id: <20190507151819.17401-3-mreitz@redhat.com>
In-Reply-To: <20190507151819.17401-1-mreitz@redhat.com>
References: <20190507151819.17401-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Tue, 07 May 2019 15:18:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 02/11] qcow2-refcount: avoid eating RAM
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

qcow2_inc_refcounts_imrt() (through realloc_refcount_array()) can eat
an unpredictable amount of memory on corrupted table entries, which are
referencing regions far beyond the end of file.

Prevent this, by skipping such regions from further processing.

Interesting that iotest 138 checks exactly the behavior which we fix
here. So, change the test appropriately.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190227131433.197063-3-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-refcount.c     | 19 +++++++++++++++++++
 tests/qemu-iotests/138     | 12 +++++-------
 tests/qemu-iotests/138.out |  5 ++++-
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index ed3d8ebd57..21e50dacf4 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1520,12 +1520,31 @@ int qcow2_inc_refcounts_imrt(BlockDriverState *bs=
, BdrvCheckResult *res,
 {
     BDRVQcow2State *s =3D bs->opaque;
     uint64_t start, last, cluster_offset, k, refcount;
+    int64_t file_len;
     int ret;
=20
     if (size <=3D 0) {
         return 0;
     }
=20
+    file_len =3D bdrv_getlength(bs->file->bs);
+    if (file_len < 0) {
+        return file_len;
+    }
+
+    /*
+     * Last cluster of qcow2 image may be semi-allocated, so it may be O=
K to
+     * reference some space after file end but it should be less than on=
e
+     * cluster.
+     */
+    if (offset + size - file_len >=3D s->cluster_size) {
+        fprintf(stderr, "ERROR: counting reference for region exceeding =
the "
+                "end of the file by one cluster or more: offset 0x%" PRI=
x64
+                " size 0x%" PRIx64 "\n", offset, size);
+        res->corruptions++;
+        return 0;
+    }
+
     start =3D start_of_cluster(s, offset);
     last =3D start_of_cluster(s, offset + size - 1);
     for(cluster_offset =3D start; cluster_offset <=3D last;
diff --git a/tests/qemu-iotests/138 b/tests/qemu-iotests/138
index f353ac8219..6a731370db 100755
--- a/tests/qemu-iotests/138
+++ b/tests/qemu-iotests/138
@@ -54,15 +54,13 @@ $QEMU_IO -c 'write 0 512' "$TEST_IMG" | _filter_qemu_=
io
 # Put the data cluster at a multiple of 2 TB, resulting in the image app=
arently
 # having a multiple of 2^32 clusters
 # (To be more specific: It is at 32 PB)
-poke_file "$TEST_IMG" 2048 "\x80\x80\x00\x00\x00\x00\x00\x00"
+poke_file "$TEST_IMG" $((2048 + 8)) "\x00\x80\x00\x00\x00\x00\x00\x00"
=20
 # An offset of 32 PB results in qemu-img check having to allocate an in-=
memory
-# refcount table of 128 TB (16 bit refcounts, 512 byte clusters).
-# This should be generally too much for any system and thus fail.
-# What this test is checking is that the qcow2 driver actually tries to =
allocate
-# such a large amount of memory (and is consequently aborting) instead o=
f having
-# truncated the cluster count somewhere (which would result in much less=
 memory
-# being allocated and then a segfault occurring).
+# refcount table of 128 TB (16 bit refcounts, 512 byte clusters), if qem=
u-img
+# don't check that referenced data cluster is far beyond the end of file=
.
+# But starting from 4.0, qemu-img does this check, and instead of "Canno=
t
+# allocate memory", we have an error showing that l2 entry is invalid.
 _check_test_img
=20
 # success, all done
diff --git a/tests/qemu-iotests/138.out b/tests/qemu-iotests/138.out
index 3fe911f85a..aca7d47a80 100644
--- a/tests/qemu-iotests/138.out
+++ b/tests/qemu-iotests/138.out
@@ -5,5 +5,8 @@ QA output created by 138
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D512
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: Check failed: Cannot allocate memory
+ERROR: counting reference for region exceeding the end of the file by on=
e cluster or more: offset 0x80000000000000 size 0x200
+
+1 errors were found on the image.
+Data may be corrupted, or further writes to the image may corrupt it.
 *** done
--=20
2.20.1


