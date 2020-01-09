Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6FEC282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 19:20:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D62232067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 19:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="msGUMMPh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62232067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipdLj-00016w-Fu
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 14:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1ipdGC-0003WS-Rt
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 14:14:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1ipdGB-0007JK-EN
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 14:14:24 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:58346)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1ipdG9-0006BC-FX; Thu, 09 Jan 2020 14:14:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=Clwr8OmkgLClIPLb5A4r0y5WGdUX1DP4zBqunbRF28Y=; 
 b=msGUMMPheY916npCnP2Zv70bYMzo4GHL/NYPrwCZ9/Ho0jpO8QpN6xqTmwJJO0ArsgrgKiCnhQSNUNuGOVhcmb/AqiVGaZTy5GXBOITckdONUt8bDuZRCZ0a5ust0jjBmNXLkZi1godGF3u25ZM1sGY5KglbLnXn8kL55ltUHQPLD2RaZET5Yk4ie1ov+O9fuc+vB9JDj94mKwqka7XeN6gbmJtsCPNZ5I4TiuZjeiiWO4wThuv8cVJQMIVIVxFKKqy41CrSgPW/lRiqLn9BjJVA6rVbngqhPHwciXOwGgUCFhh66QCPnPWd2KuiGg1LyE9tJxyksk8hvmCGxMRrYw==;
Received: from [213.99.255.143] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1ipdFp-0006Mm-P5; Thu, 09 Jan 2020 20:14:01 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1ipdF0-0005R7-Om; Thu, 09 Jan 2020 20:13:10 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] qcow2: Use BDRV_SECTOR_SIZE instead of the hardcoded
 value
Date: Thu,  9 Jan 2020 20:13:02 +0100
Message-Id: <e3982d5118a90db2442c6ac18f339ec8ba006df2.1578596897.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1578596897.git.berto@igalia.com>
References: <cover.1578596897.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This replaces all remaining instances in the qcow2 code.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c |  2 +-
 block/qcow2.c         | 10 ++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 932fc48919..777ca2d409 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -219,7 +219,7 @@ static int l2_load(BlockDriverState *bs, uint64_t offset,
  * Writes one sector of the L1 table to the disk (can't update single entries
  * and we really don't want bdrv_pread to perform a read-modify-write)
  */
-#define L1_ENTRIES_PER_SECTOR (512 / 8)
+#define L1_ENTRIES_PER_SECTOR (BDRV_SECTOR_SIZE / 8)
 int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index)
 {
     BDRVQcow2State *s = bs->opaque;
diff --git a/block/qcow2.c b/block/qcow2.c
index 783d2b9578..c0f3e715ef 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3280,7 +3280,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
 
     /* Validate options and set default values */
     if (!QEMU_IS_ALIGNED(qcow2_opts->size, BDRV_SECTOR_SIZE)) {
-        error_setg(errp, "Image size must be a multiple of 512 bytes");
+        error_setg(errp, "Image size must be a multiple of %u bytes",
+                   (unsigned) BDRV_SECTOR_SIZE);
         ret = -EINVAL;
         goto out;
     }
@@ -3836,7 +3837,7 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
         case QCOW2_CLUSTER_NORMAL:
             child = s->data_file;
             copy_offset += offset_into_cluster(s, src_offset);
-            if ((copy_offset & 511) != 0) {
+            if (!QEMU_IS_ALIGNED(copy_offset, BDRV_SECTOR_SIZE)) {
                 ret = -EIO;
                 goto out;
             }
@@ -3958,8 +3959,9 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
         return -ENOTSUP;
     }
 
-    if (offset & 511) {
-        error_setg(errp, "The new size must be a multiple of 512");
+    if (!QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE)) {
+        error_setg(errp, "The new size must be a multiple of %u",
+                   (unsigned) BDRV_SECTOR_SIZE);
         return -EINVAL;
     }
 
-- 
2.20.1


