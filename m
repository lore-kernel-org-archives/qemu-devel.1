Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEB4C433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8317206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8317206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kamp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5n6-00032p-3a
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 08:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pl@kamp.de>) id 1kD5lK-0008Mo-Ov
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:51:46 -0400
Received: from kerio.kamp.de ([195.62.97.192]:60820)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pl@kamp.de>) id 1kD5lI-00026E-Hy
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:51:46 -0400
X-Footer: a2FtcC5kZQ==
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
 for qemu-devel@nongnu.org; Tue, 1 Sep 2020 14:51:27 +0200
Received: (qmail 58193 invoked from network); 1 Sep 2020 12:51:34 -0000
Received: from lieven-pc.kamp-intra.net (HELO lieven-pc)
 (relay@kamp.de@::ffff:172.21.12.60)
 by submission.kamp.de with ESMTPS (DHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPA;
 1 Sep 2020 12:51:34 -0000
Received: by lieven-pc (Postfix, from userid 1060)
 id 3D33413D866; Tue,  1 Sep 2020 14:51:34 +0200 (CEST)
From: Peter Lieven <pl@kamp.de>
To: qemu-devel@nongnu.org
Subject: [PATCH] qemu-img: avoid unaligned read requests during convert
Date: Tue,  1 Sep 2020 14:51:29 +0200
Message-Id: <20200901125129.6398-1-pl@kamp.de>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=195.62.97.192; envelope-from=pl@kamp.de;
 helo=kerio.kamp.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 08:51:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

in case of large continous areas that share the same allocation status
it happens that the value of s->sector_next_status is unaligned to the
cluster size or even request alignment of the source. Avoid this by
stripping down the s->sector_next_status position to cluster boundaries.

Signed-off-by: Peter Lieven <pl@kamp.de>
---
 qemu-img.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/qemu-img.c b/qemu-img.c
index 5308773811..ed17238c36 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1665,6 +1665,7 @@ enum ImgConvertBlockStatus {
 typedef struct ImgConvertState {
     BlockBackend **src;
     int64_t *src_sectors;
+    int *src_alignment;
     int src_num;
     int64_t total_sectors;
     int64_t allocated_sectors;
@@ -1731,6 +1732,7 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
     if (s->sector_next_status <= sector_num) {
         uint64_t offset = (sector_num - src_cur_offset) * BDRV_SECTOR_SIZE;
         int64_t count;
+        int tail;
 
         do {
             count = n * BDRV_SECTOR_SIZE;
@@ -1769,6 +1771,16 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
 
         n = DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
 
+        /*
+         * Avoid that s->sector_next_status becomes unaligned to the source
+         * request alignment and/or cluster size to avoid unnecessary read
+         * cycles.
+         */
+        tail = (sector_num - src_cur_offset + n) % s->src_alignment[src_cur];
+        if (n > tail) {
+            n -= tail;
+        }
+
         if (ret & BDRV_BLOCK_ZERO) {
             s->status = post_backing_zero ? BLK_BACKING_FILE : BLK_ZERO;
         } else if (ret & BDRV_BLOCK_DATA) {
@@ -2407,8 +2419,10 @@ static int img_convert(int argc, char **argv)
 
     s.src = g_new0(BlockBackend *, s.src_num);
     s.src_sectors = g_new(int64_t, s.src_num);
+    s.src_alignment = g_new(int, s.src_num);
 
     for (bs_i = 0; bs_i < s.src_num; bs_i++) {
+        BlockDriverState *src_bs;
         s.src[bs_i] = img_open(image_opts, argv[optind + bs_i],
                                fmt, src_flags, src_writethrough, s.quiet,
                                force_share);
@@ -2423,6 +2437,13 @@ static int img_convert(int argc, char **argv)
             ret = -1;
             goto out;
         }
+        src_bs = blk_bs(s.src[bs_i]);
+        s.src_alignment[bs_i] = DIV_ROUND_UP(src_bs->bl.request_alignment,
+                                             BDRV_SECTOR_SIZE);
+        if (!bdrv_get_info(src_bs, &bdi)) {
+            s.src_alignment[bs_i] = MAX(s.src_alignment[bs_i],
+                                        bdi.cluster_size / BDRV_SECTOR_SIZE);
+        }
         s.total_sectors += s.src_sectors[bs_i];
     }
 
@@ -2704,6 +2725,7 @@ out:
         g_free(s.src);
     }
     g_free(s.src_sectors);
+    g_free(s.src_alignment);
 fail_getopt:
     g_free(options);
 
-- 
2.17.1



