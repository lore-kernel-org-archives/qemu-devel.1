Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC82C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:28:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1297B2082F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1297B2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlVJD-00079O-AC
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 06:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <root@localhost>)
 id 1jlVGq-0004GS-77; Wed, 17 Jun 2020 06:26:16 -0400
Received: from [114.255.249.163] (port=49827 helo=localhost)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <root@localhost>)
 id 1jlVGo-0007Ok-EB; Wed, 17 Jun 2020 06:26:15 -0400
Received: by localhost (Postfix, from userid 0)
 id 16553140E50; Wed, 17 Jun 2020 18:20:24 +0800 (CST)
From: Lin Ma <lma@suse.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 1/3] block: Add bdrv_co_get_lba_status
Date: Wed, 17 Jun 2020 18:20:17 +0800
Message-Id: <20200617102019.29652-2-lma@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200617102019.29652-1-lma@suse.com>
References: <20200617102019.29652-1-lma@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 114.255.249.163 (failed)
Received-SPF: none client-ip=114.255.249.163; envelope-from=root@localhost;
 helo=localhost
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 06:20:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: 68
X-Spam_score: 6.8
X-Spam_bar: ++++++
X-Spam_report: (6.8 / 5.0 requ) BAYES_00=-1.9, FSL_HELO_NON_FQDN_1=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, HELO_LOCALHOST=3.828, RCVD_IN_MSPIKE_BL=0.01,
 RCVD_IN_MSPIKE_ZBI=2.7, RCVD_IN_XBL=0.375, RDNS_NONE=0.793,
 SPF_NONE=0.001 autolearn=_AUTOLEARN
X-Spam_action: reject
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, Lin Ma <lma@suse.com>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The get lba status wrapper based on the bdrv_block_status. The following
patches will add GET LBA STATUS 16 support for scsi emulation layer.

Signed-off-by: Lin Ma <lma@suse.com>
---
 block/io.c                | 43 +++++++++++++++++++++++++++++++++++++++
 include/block/block_int.h |  5 +++++
 2 files changed, 48 insertions(+)

diff --git a/block/io.c b/block/io.c
index df8f2a98d4..2064016b19 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2208,6 +2208,49 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
                            BDRV_REQ_ZERO_WRITE | flags);
 }
 
+int coroutine_fn
+bdrv_co_get_lba_status(BdrvChild *child, int64_t offset, int64_t bytes,
+                       uint32_t *num_blocks, uint32_t *is_deallocated)
+{
+    BlockDriverState *bs = child->bs;
+    int ret = 0;
+    int64_t target_size, count = 0;
+    bool first = true;
+    uint8_t wanted_bit1 = 0;
+
+    target_size = bdrv_getlength(bs);
+    if (target_size < 0) {
+        return -EIO;
+    }
+
+    if (offset < 0 || bytes < 0) {
+        return -EIO;
+    }
+
+    for ( ; offset <= target_size - bytes; offset += count) {
+        ret = bdrv_block_status(bs, offset, bytes, &count, NULL, NULL);
+        if (ret < 0) {
+            goto out;
+        }
+        if (first) {
+            if (ret & BDRV_BLOCK_ZERO) {
+                wanted_bit1 = BDRV_BLOCK_ZERO >> 1;
+                *is_deallocated = 1;
+            } else {
+                wanted_bit1 = 0;
+            }
+            first = false;
+        }
+        if ((ret & BDRV_BLOCK_ZERO) >> 1 == wanted_bit1) {
+            (*num_blocks)++;
+        } else {
+            break;
+        }
+    }
+out:
+    return ret;
+}
+
 /*
  * Flush ALL BDSes regardless of if they are reachable via a BlkBackend or not.
  */
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 791de6a59c..43f90591b9 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1296,6 +1296,11 @@ int coroutine_fn bdrv_co_block_status_from_backing(BlockDriverState *bs,
                                                    int64_t *pnum,
                                                    int64_t *map,
                                                    BlockDriverState **file);
+int coroutine_fn bdrv_co_get_lba_status(BdrvChild *child,
+                                        int64_t offset,
+                                        int64_t bytes,
+                                        uint32_t *num_blocks,
+                                        uint32_t *is_deallocated);
 const char *bdrv_get_parent_name(const BlockDriverState *bs);
 void blk_dev_change_media_cb(BlockBackend *blk, bool load, Error **errp);
 bool blk_dev_has_removable_media(BlockBackend *blk);
-- 
2.26.0


