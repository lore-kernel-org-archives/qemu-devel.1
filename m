Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B10C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 13:38:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 317DB21726
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 13:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317DB21726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kamp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Kcz-00047y-A2
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 09:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pl@kamp.de>) id 1i3KbC-0002lz-84
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 09:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pl@kamp.de>) id 1i3KbA-00087B-Nm
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 09:36:25 -0400
Received: from kerio.kamp.de ([195.62.97.192]:36815)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pl@kamp.de>) id 1i3KbA-0007wT-Fq
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 09:36:24 -0400
X-Footer: a2FtcC5kZQ==
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 15:36:13 +0200
Received: (qmail 56887 invoked from network); 29 Aug 2019 13:36:15 -0000
Received: from lieven-pc.kamp-intra.net (HELO lieven-pc)
 (relay@kamp.de@::ffff:172.21.12.60)
 by submission.kamp.de with ESMTPS (DHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPA;
 29 Aug 2019 13:36:15 -0000
Received: by lieven-pc (Postfix, from userid 1060)
 id D72C313DF82; Thu, 29 Aug 2019 15:36:15 +0200 (CEST)
From: Peter Lieven <pl@kamp.de>
To: qemu-block@nongnu.org
Date: Thu, 29 Aug 2019 15:36:15 +0200
Message-Id: <20190829133615.29873-1-pl@kamp.de>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 195.62.97.192
Subject: [Qemu-devel] [PATCH] block/vhdx: add check for truncated image files
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
 qemu-devel@nongnu.org, mreitz@redhat.com, Jan-Hendrik Frintrop <jhf@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu is currently not able to detect truncated vhdx image files.
Add a basic check if all allocated blocks are reachable to vhdx_co_check.

Signed-off-by: Jan-Hendrik Frintrop <jhf@kamp.de>
Signed-off-by: Peter Lieven <pl@kamp.de>
---
 block/vhdx.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/block/vhdx.c b/block/vhdx.c
index 6a09d0a55c..4382b1375d 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -2068,10 +2068,29 @@ static int coroutine_fn vhdx_co_check(BlockDriverState *bs,
                                       BdrvCheckMode fix)
 {
     BDRVVHDXState *s = bs->opaque;
+    VHDXSectorInfo sinfo;
+    int64_t file_size = bdrv_get_allocated_file_size(bs);
+    int64_t sector_num;
 
     if (s->log_replayed_on_open) {
         result->corruptions_fixed++;
     }
+
+    for (sector_num = 0; sector_num < bs->total_sectors;
+         sector_num += s->block_size / BDRV_SECTOR_SIZE) {
+        int nb_sectors = MIN(bs->total_sectors - sector_num,
+                             s->block_size / BDRV_SECTOR_SIZE);
+        vhdx_block_translate(s, sector_num, nb_sectors, &sinfo);
+        if ((s->bat[sinfo.bat_idx] & VHDX_BAT_STATE_BIT_MASK) ==
+            PAYLOAD_BLOCK_FULLY_PRESENT) {
+            if (sinfo.file_offset +
+                sinfo.sectors_avail * BDRV_SECTOR_SIZE > file_size) {
+                /* block is past the end of file, image has been truncated. */
+                result->corruptions++;
+            }
+        }
+    }
+
     return 0;
 }
 
-- 
2.17.1



