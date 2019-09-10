Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6A5C49ED8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CCF8208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CCF8208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kamp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7i36-00046e-Gq
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 11:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pl@kamp.de>) id 1i7i2K-0003Tw-WD
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:26:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pl@kamp.de>) id 1i7i2I-0004kV-Py
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:26:32 -0400
Received: from kerio.kamp.de ([195.62.97.192]:60250)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pl@kamp.de>) id 1i7i2I-0004jU-Fx
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:26:30 -0400
X-Footer: a2FtcC5kZQ==
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 17:26:23 +0200
Received: (qmail 5618 invoked from network); 10 Sep 2019 15:26:25 -0000
Received: from lieven-pc.kamp-intra.net (HELO lieven-pc)
 (relay@kamp.de@::ffff:172.21.12.60)
 by submission.kamp.de with ESMTPS (DHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPA;
 10 Sep 2019 15:26:25 -0000
Received: by lieven-pc (Postfix, from userid 1060)
 id CCE0313D876; Tue, 10 Sep 2019 17:26:25 +0200 (CEST)
From: Peter Lieven <pl@kamp.de>
To: qemu-block@nongnu.org
Date: Tue, 10 Sep 2019 17:26:22 +0200
Message-Id: <20190910152622.5432-1-pl@kamp.de>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 195.62.97.192
Subject: [Qemu-devel] [PATCH V4] block/vhdx: add check for truncated image
 files
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
Cc: kwolf@redhat.com, codyprime@gmail.com, Peter Lieven <pl@kamp.de>,
 qemu-devel@nongnu.org, mreitz@redhat.com, jhf@kamp.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu is currently not able to detect truncated vhdx image files.
Add a basic check if all allocated blocks are reachable at open and
report all errors during bdrv_co_check.

Signed-off-by: Peter Lieven <pl@kamp.de>
---
V4: - allow partial last blocks [Kevin]
    - report offsets in error messages [Kevin]
    - check for start and end offset after eof

V3: - check for bdrv_getlength failure [Kevin]
    - use uint32_t for i [Kevin]
    - check for BAT entry overflow [Kevin]
    - break on !errcnt in second check

V2: - add error reporting [Kevin]
    - use bdrv_getlength instead of bdrv_get_allocated_file_size [Kevin]
    - factor out BAT entry check and add error reporting for region
      overlaps
    - already check on vhdx_open

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
@@ -235,6 +236,9 @@ static int vhdx_region_check(BDRVVHDXState *s, uint64_t start, uint64_t length)
     end = start + length;
     QLIST_FOREACH(r, &s->regions, entries) {
         if (!((start >= r->end) || (end <= r->start))) {
+            error_report("VHDX region %" PRIu64 "-%" PRIu64 " overlaps with "
+                         "region %" PRIu64 "-%." PRIu64, start, end, r->start,
+                         r->end);
             ret = -EINVAL;
             goto exit;
         }
@@ -877,6 +881,95 @@ static void vhdx_calc_bat_entries(BDRVVHDXState *s)
 
 }
 
+static int vhdx_check_bat_entries(BlockDriverState *bs, int *errcnt)
+{
+    BDRVVHDXState *s = bs->opaque;
+    int64_t image_file_size = bdrv_getlength(bs->file->bs);
+    uint64_t payblocks = s->chunk_ratio;
+    uint64_t i;
+    int ret = 0;
+
+    if (image_file_size < 0) {
+        error_report("Could not determinate VHDX image file size.");
+        return image_file_size;
+    }
+
+    for (i = 0; i < s->bat_entries; i++) {
+        if ((s->bat[i] & VHDX_BAT_STATE_BIT_MASK) ==
+            PAYLOAD_BLOCK_FULLY_PRESENT) {
+            uint64_t offset = s->bat[i] & VHDX_BAT_FILE_OFF_MASK;
+            /*
+             * Allow that the last block exists only partially. The VHDX spec
+             * states that the image file can only grow in blocksize increments,
+             * but QEMU created images with partial last blocks in the past.
+             */
+            uint32_t block_length = MIN(s->block_size,
+                bs->total_sectors * BDRV_SECTOR_SIZE - i * s->block_size);
+            /*
+             * Check for BAT entry overflow.
+             */
+            if (offset > INT64_MAX - s->block_size) {
+                error_report("VHDX BAT entry %" PRIu64 " offset overflow.", i);
+                ret = -EINVAL;
+                if (!errcnt) {
+                    break;
+                }
+                (*errcnt)++;
+            }
+            /*
+             * Check if fully allocated BAT entries do not reside after
+             * end of the image file.
+             */
+            if (offset >= image_file_size) {
+                error_report("VHDX BAT entry %" PRIu64 " start offset %" PRIu64
+                             " points after end of file (%" PRIi64 "). Image"
+                             " has probably been truncated.",
+                             i, offset, image_file_size);
+                ret = -EINVAL;
+                if (!errcnt) {
+                    break;
+                }
+                (*errcnt)++;
+            } else if (offset + block_length > image_file_size) {
+                error_report("VHDX BAT entry %" PRIu64 " end offset %" PRIu64
+                             " points after end of file (%" PRIi64 "). Image"
+                             " has probably been truncated.",
+                             i, offset + block_length - 1, image_file_size);
+                ret = -EINVAL;
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
+                ret2 = vhdx_region_check(s, offset, s->block_size);
+                if (ret2 < 0) {
+                    ret = -EINVAL;
+                    if (!errcnt) {
+                        break;
+                    }
+                    (*errcnt)++;
+                }
+            } else {
+                payblocks = s->chunk_ratio;
+                /*
+                 * Once differencing files are supported, verify sector bitmap
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
     BDRVVHDXState *s = bs->opaque;
@@ -981,25 +1074,15 @@ static int vhdx_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
-    uint64_t payblocks = s->chunk_ratio;
-    /* endian convert, and verify populated BAT field file offsets against
-     * region table and log entries */
+    /* endian convert populated BAT field entires */
     for (i = 0; i < s->bat_entries; i++) {
         s->bat[i] = le64_to_cpu(s->bat[i]);
-        if (payblocks--) {
-            /* payload bat entries */
-            if ((s->bat[i] & VHDX_BAT_STATE_BIT_MASK) ==
-                    PAYLOAD_BLOCK_FULLY_PRESENT) {
-                ret = vhdx_region_check(s, s->bat[i] & VHDX_BAT_FILE_OFF_MASK,
-                                        s->block_size);
-                if (ret < 0) {
-                    goto fail;
-                }
-            }
-        } else {
-            payblocks = s->chunk_ratio;
-            /* Once differencing files are supported, verify sector bitmap
-             * blocks here */
+    }
+
+    if (!(flags & BDRV_O_CHECK)) {
+        ret = vhdx_check_bat_entries(bs, NULL);
+        if (ret < 0) {
+            goto fail;
         }
     }
 
@@ -2072,6 +2155,9 @@ static int coroutine_fn vhdx_co_check(BlockDriverState *bs,
     if (s->log_replayed_on_open) {
         result->corruptions_fixed++;
     }
+
+    vhdx_check_bat_entries(bs, &result->corruptions);
+
     return 0;
 }
 
-- 
2.17.1



