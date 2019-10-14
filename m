Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF82BC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:12:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A0020854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A0020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK2x9-0005Nh-GS
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iK2p9-0002mq-Oi
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iK2p8-0006OA-CT
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:03:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37642)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iK2p5-0006JE-1u; Mon, 14 Oct 2019 12:03:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4D095309BF21;
 Mon, 14 Oct 2019 16:03:50 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40D2A5C541;
 Mon, 14 Oct 2019 16:03:49 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 01/15] block/vhdx: add check for truncated image files
Date: Mon, 14 Oct 2019 18:03:35 +0200
Message-Id: <20191014160343.8211-2-kwolf@redhat.com>
In-Reply-To: <20191014160343.8211-1-kwolf@redhat.com>
References: <20191014160343.8211-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 14 Oct 2019 16:03:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Lieven <pl@kamp.de>

qemu is currently not able to detect truncated vhdx image files.
Add a basic check if all allocated blocks are reachable at open and
report all errors during bdrv_co_check.

Signed-off-by: Peter Lieven <pl@kamp.de>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vhdx.c | 120 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 103 insertions(+), 17 deletions(-)

diff --git a/block/vhdx.c b/block/vhdx.c
index 6a09d0a55c..371f226286 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -24,6 +24,7 @@
 #include "qemu/option.h"
 #include "qemu/crc32c.h"
 #include "qemu/bswap.h"
+#include "qemu/error-report.h"
 #include "vhdx.h"
 #include "migration/blocker.h"
 #include "qemu/uuid.h"
@@ -235,6 +236,9 @@ static int vhdx_region_check(BDRVVHDXState *s, uint64=
_t start, uint64_t length)
     end =3D start + length;
     QLIST_FOREACH(r, &s->regions, entries) {
         if (!((start >=3D r->end) || (end <=3D r->start))) {
+            error_report("VHDX region %" PRIu64 "-%" PRIu64 " overlaps w=
ith "
+                         "region %" PRIu64 "-%." PRIu64, start, end, r->=
start,
+                         r->end);
             ret =3D -EINVAL;
             goto exit;
         }
@@ -877,6 +881,95 @@ static void vhdx_calc_bat_entries(BDRVVHDXState *s)
=20
 }
=20
+static int vhdx_check_bat_entries(BlockDriverState *bs, int *errcnt)
+{
+    BDRVVHDXState *s =3D bs->opaque;
+    int64_t image_file_size =3D bdrv_getlength(bs->file->bs);
+    uint64_t payblocks =3D s->chunk_ratio;
+    uint64_t i;
+    int ret =3D 0;
+
+    if (image_file_size < 0) {
+        error_report("Could not determinate VHDX image file size.");
+        return image_file_size;
+    }
+
+    for (i =3D 0; i < s->bat_entries; i++) {
+        if ((s->bat[i] & VHDX_BAT_STATE_BIT_MASK) =3D=3D
+            PAYLOAD_BLOCK_FULLY_PRESENT) {
+            uint64_t offset =3D s->bat[i] & VHDX_BAT_FILE_OFF_MASK;
+            /*
+             * Allow that the last block exists only partially. The VHDX=
 spec
+             * states that the image file can only grow in blocksize inc=
rements,
+             * but QEMU created images with partial last blocks in the p=
ast.
+             */
+            uint32_t block_length =3D MIN(s->block_size,
+                bs->total_sectors * BDRV_SECTOR_SIZE - i * s->block_size=
);
+            /*
+             * Check for BAT entry overflow.
+             */
+            if (offset > INT64_MAX - s->block_size) {
+                error_report("VHDX BAT entry %" PRIu64 " offset overflow=
.", i);
+                ret =3D -EINVAL;
+                if (!errcnt) {
+                    break;
+                }
+                (*errcnt)++;
+            }
+            /*
+             * Check if fully allocated BAT entries do not reside after
+             * end of the image file.
+             */
+            if (offset >=3D image_file_size) {
+                error_report("VHDX BAT entry %" PRIu64 " start offset %"=
 PRIu64
+                             " points after end of file (%" PRIi64 "). I=
mage"
+                             " has probably been truncated.",
+                             i, offset, image_file_size);
+                ret =3D -EINVAL;
+                if (!errcnt) {
+                    break;
+                }
+                (*errcnt)++;
+            } else if (offset + block_length > image_file_size) {
+                error_report("VHDX BAT entry %" PRIu64 " end offset %" P=
RIu64
+                             " points after end of file (%" PRIi64 "). I=
mage"
+                             " has probably been truncated.",
+                             i, offset + block_length - 1, image_file_si=
ze);
+                ret =3D -EINVAL;
+                if (!errcnt) {
+                    break;
+                }
+                (*errcnt)++;
+            }
+
+            /*
+             * verify populated BAT field file offsets against
+             * region table and log entries
+             */
+            if (payblocks--) {
+                /* payload bat entries */
+                int ret2;
+                ret2 =3D vhdx_region_check(s, offset, s->block_size);
+                if (ret2 < 0) {
+                    ret =3D -EINVAL;
+                    if (!errcnt) {
+                        break;
+                    }
+                    (*errcnt)++;
+                }
+            } else {
+                payblocks =3D s->chunk_ratio;
+                /*
+                 * Once differencing files are supported, verify sector =
bitmap
+                 * blocks here
+                 */
+            }
+        }
+    }
+
+    return ret;
+}
+
 static void vhdx_close(BlockDriverState *bs)
 {
     BDRVVHDXState *s =3D bs->opaque;
@@ -981,25 +1074,15 @@ static int vhdx_open(BlockDriverState *bs, QDict *=
options, int flags,
         goto fail;
     }
=20
-    uint64_t payblocks =3D s->chunk_ratio;
-    /* endian convert, and verify populated BAT field file offsets again=
st
-     * region table and log entries */
+    /* endian convert populated BAT field entires */
     for (i =3D 0; i < s->bat_entries; i++) {
         s->bat[i] =3D le64_to_cpu(s->bat[i]);
-        if (payblocks--) {
-            /* payload bat entries */
-            if ((s->bat[i] & VHDX_BAT_STATE_BIT_MASK) =3D=3D
-                    PAYLOAD_BLOCK_FULLY_PRESENT) {
-                ret =3D vhdx_region_check(s, s->bat[i] & VHDX_BAT_FILE_O=
FF_MASK,
-                                        s->block_size);
-                if (ret < 0) {
-                    goto fail;
-                }
-            }
-        } else {
-            payblocks =3D s->chunk_ratio;
-            /* Once differencing files are supported, verify sector bitm=
ap
-             * blocks here */
+    }
+
+    if (!(flags & BDRV_O_CHECK)) {
+        ret =3D vhdx_check_bat_entries(bs, NULL);
+        if (ret < 0) {
+            goto fail;
         }
     }
=20
@@ -2072,6 +2155,9 @@ static int coroutine_fn vhdx_co_check(BlockDriverSt=
ate *bs,
     if (s->log_replayed_on_open) {
         result->corruptions_fixed++;
     }
+
+    vhdx_check_bat_entries(bs, &result->corruptions);
+
     return 0;
 }
=20
--=20
2.20.1


