Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3827C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:48:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A47423697
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A47423697
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kamp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i59Ae-0008QV-VV
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 09:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pl@kamp.de>) id 1i58y8-0001PX-VL
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pl@kamp.de>) id 1i58y7-0005oV-6G
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:35:36 -0400
Received: from kerio.kamp.de ([195.62.97.192]:47940)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pl@kamp.de>) id 1i58y6-0005ik-Rh
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:35:35 -0400
X-Footer: a2FtcC5kZQ==
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
 for qemu-devel@nongnu.org; Tue, 3 Sep 2019 15:35:23 +0200
Received: (qmail 38703 invoked from network); 3 Sep 2019 13:35:26 -0000
Received: from lieven-pc.kamp-intra.net (HELO lieven-pc)
 (relay@kamp.de@::ffff:172.21.12.60)
 by submission.kamp.de with ESMTPS (DHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPA;
 3 Sep 2019 13:35:26 -0000
Received: by lieven-pc (Postfix, from userid 1060)
 id 4BD4513D85C; Tue,  3 Sep 2019 15:35:26 +0200 (CEST)
From: Peter Lieven <pl@kamp.de>
To: qemu-block@nongnu.org
Date: Tue,  3 Sep 2019 15:35:24 +0200
Message-Id: <20190903133524.11755-1-pl@kamp.de>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 195.62.97.192
Subject: [Qemu-devel] [PATCH V3] block/vhdx: add check for truncated image
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
V3: - check for bdrv_getlength failure [Kevin]
    - use uint32_t for i [Kevin]
    - check for BAT entry overflow [Kevin]
    - break on !errcnt in second check

V2: - add error reporting [Kevin]
    - use bdrv_getlength instead of bdrv_get_allocated_file_size [Kevin]
    - factor out BAT entry check and add error reporting for region
      overlaps
    - already check on vhdx_open

 block/vhdx.c | 102 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 85 insertions(+), 17 deletions(-)

diff --git a/block/vhdx.c b/block/vhdx.c
index 6a09d0a55c..253e32d524 100644
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
@@ -877,6 +881,77 @@ static void vhdx_calc_bat_entries(BDRVVHDXState *s)
 
 }
 
+static int vhdx_check_bat_entries(BlockDriverState *bs, int *errcnt)
+{
+    BDRVVHDXState *s = bs->opaque;
+    int64_t image_file_size = bdrv_getlength(bs->file->bs);
+    uint64_t payblocks = s->chunk_ratio;
+    uint32_t i;
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
+             * Check for BAT entry overflow.
+             */
+            if (offset > INT64_MAX - s->block_size) {
+                error_report("VHDX BAT entry %" PRIu32 " offset overflow.", i);
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
+            if (offset + s->block_size > image_file_size) {
+                error_report("VHDX BAT entry %" PRIu32 " offset points after "
+                             "end of file. Image has probably been truncated.",
+                             i);
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
@@ -981,25 +1056,15 @@ static int vhdx_open(BlockDriverState *bs, QDict *options, int flags,
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
 
@@ -2072,6 +2137,9 @@ static int coroutine_fn vhdx_co_check(BlockDriverState *bs,
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



