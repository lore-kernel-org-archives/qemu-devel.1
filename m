Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4270C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 17:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86FF22067D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 17:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="L1WHH9Fw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86FF22067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipFUj-0006rd-48
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 12:51:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1ipFTL-0005SM-Tb
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 12:50:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1ipFTK-00015t-Nv
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 12:50:23 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:55161)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1ipFTK-0000WN-2V; Wed, 08 Jan 2020 12:50:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=7obi6hyBg9iHOq68BveAS3HpKksoZeB2IapeD+aUG5E=; 
 b=L1WHH9FwDvZ8jxGFAS1TjWgWB+hfQs7L+NLdpAkN552GzvCL5ZAq6AhX6EQWJgjTZZGPk9C5KxpLhYOdARzDQQiTRzZDXMiLbo/gVJfu6QbtFZcxfHpcC0cigq81dMSoHmV0pUibTF6FeBLjFhTYrPPvulEN62dHsegDQQzcsePPEFIymXUwijhZjFezSzXVfgdoZQpRmyT1qBxeoo3uVjDe5fVfHQ4+rHxjlSscJo154rxdfO0u4Tg4Oz7cxjb0Z6xR9c9QrMOjnNHhRJC0B3cNKhYCt93X7guhHtsmHHwMqyRCPPZR6GcfA+8t/eTTRn+TVld5aWTS+u2yhwfdCQ==;
Received: from [213.99.255.143] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1ipFT1-0001HQ-NR; Wed, 08 Jan 2020 18:50:03 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1ipFSD-0000Dd-Ci; Wed, 08 Jan 2020 18:49:13 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] qcow2: Use BDRV_SECTOR_SIZE instead of the hardcoded value
Date: Wed,  8 Jan 2020 18:49:10 +0100
Message-Id: <f6dcb0d7b17cddb475e3a018a5b802490c7bc21d.1578505678.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1578505678.git.berto@igalia.com>
References: <cover.1578505678.git.berto@igalia.com>
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This replaces all remaining instances in the qcow2 code.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c |  2 +-
 block/qcow2.c         | 16 +++++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

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
index e8ce966f7f..6427c75409 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2175,7 +2175,7 @@ static coroutine_fn int qcow2_co_preadv_task(BlockDriverState *bs,
                                           offset, bytes, qiov, qiov_offset);
 
     case QCOW2_CLUSTER_NORMAL:
-        if ((file_cluster_offset & 511) != 0) {
+        if ((file_cluster_offset % BDRV_SECTOR_SIZE) != 0) {
             return -EIO;
         }
 
@@ -2514,7 +2514,7 @@ static coroutine_fn int qcow2_co_pwritev_part(
             goto out_locked;
         }
 
-        assert((cluster_offset & 511) == 0);
+        assert((cluster_offset % BDRV_SECTOR_SIZE) == 0);
 
         ret = qcow2_pre_write_overlap_check(bs, 0,
                                             cluster_offset + offset_in_cluster,
@@ -3283,7 +3283,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
 
     /* Validate options and set default values */
     if (!QEMU_IS_ALIGNED(qcow2_opts->size, BDRV_SECTOR_SIZE)) {
-        error_setg(errp, "Image size must be a multiple of 512 bytes");
+        error_setg(errp, "Image size must be a multiple of %u bytes",
+                   (unsigned) BDRV_SECTOR_SIZE);
         ret = -EINVAL;
         goto out;
     }
@@ -3839,7 +3840,7 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
         case QCOW2_CLUSTER_NORMAL:
             child = s->data_file;
             copy_offset += offset_into_cluster(s, src_offset);
-            if ((copy_offset & 511) != 0) {
+            if ((copy_offset % BDRV_SECTOR_SIZE) != 0) {
                 ret = -EIO;
                 goto out;
             }
@@ -3904,7 +3905,7 @@ qcow2_co_copy_range_to(BlockDriverState *bs,
             goto fail;
         }
 
-        assert((cluster_offset & 511) == 0);
+        assert((cluster_offset % BDRV_SECTOR_SIZE) == 0);
 
         ret = qcow2_pre_write_overlap_check(bs, 0,
                 cluster_offset + offset_in_cluster, cur_bytes, true);
@@ -3961,8 +3962,9 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
         return -ENOTSUP;
     }
 
-    if (offset & 511) {
-        error_setg(errp, "The new size must be a multiple of 512");
+    if (offset % BDRV_SECTOR_SIZE) {
+        error_setg(errp, "The new size must be a multiple of %u",
+                   (unsigned) BDRV_SECTOR_SIZE);
         return -EINVAL;
     }
 
-- 
2.20.1


