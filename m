Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3E5C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:14:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E528A206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E528A206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9siP-0005tf-G9
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i9ruP-0003Cg-VT
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i9ruL-0000m6-PE
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:23:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54266)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i9ruD-0000ex-9Z; Mon, 16 Sep 2019 10:23:05 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 45BB318CB8F8;
 Mon, 16 Sep 2019 14:23:04 +0000 (UTC)
Received: from localhost (unknown [10.40.205.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69279600F8;
 Mon, 16 Sep 2019 14:23:03 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 16 Sep 2019 16:22:35 +0200
Message-Id: <20190916142246.31474-6-mreitz@redhat.com>
In-Reply-To: <20190916142246.31474-1-mreitz@redhat.com>
References: <20190916142246.31474-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Mon, 16 Sep 2019 14:23:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 05/16] tests/qemu-iotests: Fix qemu-io related
 output in 026.out.nocache
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

qemu-io now prefixes its error and warnings with "qemu-io:".
36b9986b08787019e fixed a lot of iotests output but forget about
026.out.nocache. Fix it too.

Fixes: 99e98d7c9fc1a1639fad ("qemu-io: Use error_[gs]et_progname()")
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190816153015.447957-2-vsementsov@virtuozzo.com
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/026.out.nocache | 168 ++++++++++++++---------------
 1 file changed, 84 insertions(+), 84 deletions(-)

diff --git a/tests/qemu-iotests/026.out.nocache b/tests/qemu-iotests/026.=
out.nocache
index 1ca6cda15c..6dda95dfb4 100644
--- a/tests/qemu-iotests/026.out.nocache
+++ b/tests/qemu-iotests/026.out.nocache
@@ -14,8 +14,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: l1_update; errno: 5; imm: off; once: off; write=20
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
=20
 1 leaked clusters were found on the image.
@@ -23,8 +23,8 @@ This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: l1_update; errno: 5; imm: off; once: off; write -b
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
=20
 1 leaked clusters were found on the image.
@@ -42,8 +42,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: l1_update; errno: 28; imm: off; once: off; write=20
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
=20
 1 leaked clusters were found on the image.
@@ -51,8 +51,8 @@ This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: l1_update; errno: 28; imm: off; once: off; write -b
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
=20
 1 leaked clusters were found on the image.
@@ -136,8 +136,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: l2_update; errno: 5; imm: off; once: off; write=20
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
@@ -146,8 +146,8 @@ This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: l2_update; errno: 5; imm: off; once: off; write -b
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
@@ -168,8 +168,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: l2_update; errno: 28; imm: off; once: off; write=20
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
@@ -178,8 +178,8 @@ This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: l2_update; errno: 28; imm: off; once: off; write -b
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
@@ -198,15 +198,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: l2_alloc_write; errno: 5; imm: off; once: off; write=20
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: l2_alloc_write; errno: 5; imm: off; once: off; write -b
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
=20
 1 leaked clusters were found on the image.
@@ -224,15 +224,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: l2_alloc_write; errno: 28; imm: off; once: off; write=20
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: l2_alloc_write; errno: 28; imm: off; once: off; write -b
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
=20
 1 leaked clusters were found on the image.
@@ -250,15 +250,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: write_aio; errno: 5; imm: off; once: off; write=20
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: write_aio; errno: 5; imm: off; once: off; write -b
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
@@ -274,15 +274,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: write_aio; errno: 28; imm: off; once: off; write=20
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: write_aio; errno: 28; imm: off; once: off; write -b
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
@@ -298,15 +298,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_load; errno: 5; imm: off; once: off; write=20
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_load; errno: 5; imm: off; once: off; write -b
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
@@ -322,15 +322,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_load; errno: 28; imm: off; once: off; write=20
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_load; errno: 28; imm: off; once: off; write -b
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
@@ -346,15 +346,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_update_part; errno: 5; imm: off; once: off; write=20
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_update_part; errno: 5; imm: off; once: off; write -b
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
@@ -370,15 +370,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_update_part; errno: 28; imm: off; once: off; write=20
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_update_part; errno: 28; imm: off; once: off; write -b
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
@@ -394,15 +394,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_alloc; errno: 5; imm: off; once: off; write=20
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_alloc; errno: 5; imm: off; once: off; write -b
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
@@ -418,15 +418,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_alloc; errno: 28; imm: off; once: off; write=20
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_alloc; errno: 28; imm: off; once: off; write -b
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
@@ -485,8 +485,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write=20
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
=20
 55 leaked clusters were found on the image.
@@ -494,8 +494,8 @@ This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write -b
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
=20
 251 leaked clusters were found on the image.
@@ -513,15 +513,15 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_alloc_write; errno: 28; imm: off; once: off; write=20
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_alloc_write; errno: 28; imm: off; once: off; write -b
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
@@ -537,8 +537,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; writ=
e=20
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
=20
 10 leaked clusters were found on the image.
@@ -546,8 +546,8 @@ This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; writ=
e -b
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
=20
 23 leaked clusters were found on the image.
@@ -565,8 +565,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write=
=20
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
=20
 10 leaked clusters were found on the image.
@@ -574,8 +574,8 @@ This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write=
 -b
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
=20
 23 leaked clusters were found on the image.
@@ -593,8 +593,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; writ=
e=20
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
=20
 10 leaked clusters were found on the image.
@@ -602,8 +602,8 @@ This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; writ=
e -b
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
=20
 23 leaked clusters were found on the image.
@@ -639,8 +639,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: l1_grow_write_table; errno: 5; imm: off; once: off
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
@@ -651,8 +651,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: l1_grow_write_table; errno: 28; imm: off; once: off
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
@@ -663,8 +663,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: l1_grow_activate_table; errno: 5; imm: off; once: off
-Failed to flush the L2 table cache: Input/output error
-Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
=20
 96 leaked clusters were found on the image.
@@ -677,8 +677,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: l1_grow_activate_table; errno: 28; imm: off; once: off
-Failed to flush the L2 table cache: No space left on device
-Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
=20
 96 leaked clusters were found on the image.
--=20
2.21.0


