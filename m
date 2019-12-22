Return-Path: <SRS0=nsQZ=2M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BD7C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 12:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA3A2070A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 12:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="IdeYm4BN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA3A2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iizxQ-0004JD-3s
	for qemu-devel@archiver.kernel.org; Sun, 22 Dec 2019 07:03:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iizZE-0003Vj-Li
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 06:38:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iizZC-00075A-6v
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 06:38:36 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:35048)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iizZB-0004nz-JE; Sun, 22 Dec 2019 06:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=E+SoyxPLvlWargalWgxEbk+TBsEEMcY7UkhPnTR5WLU=; 
 b=IdeYm4BNIW3A/RXjsU5kpk/IYwbTICe1ijNea21/YLu9lsWcs23+QjU1q7CsF675y1GIXUfB7C8FKFrwDpPqDyHjU+tsPemiAI1sLOcfDMTbI3NGdrnEU88h9z0yKqYRV3OpVWYGMMJE+yeNPVM+RIYgMw4zOk/pftbNHPmVxHu++9tNEkd/08O+Rv4xPm7I518cRdJMfU0PxzGxP9oUauhABWT+Ondr9k7eaFrUEGCV0EuQPMYua7iVNBIBUODr7QrRAiUh8AG/IFuxEaluKC7pviNSRJFl4kFRjJLGhe1K+NM4/6/y63q4CuCfdzIgpTaL3AQbDmA7JbKXpZhMxQ==;
Received: from [80.30.182.172] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iizYV-0005dS-41; Sun, 22 Dec 2019 12:37:52 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iizXv-0001WQ-0s; Sun, 22 Dec 2019 12:37:15 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 26/27] qcow2: Add subcluster support to qcow2_measure()
Date: Sun, 22 Dec 2019 12:37:07 +0100
Message-Id: <9fadbca0b9fc6d7a5c8b1dc4cda53d45a4d37c25.1577014346.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1577014346.git.berto@igalia.com>
References: <cover.1577014346.git.berto@igalia.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extended L2 entries are bigger than normal L2 entries so this has an
impact on the amount of metadata needed for a qcow2 file.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 4f26953b1e..62093de1c6 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3162,28 +3162,31 @@ int64_t qcow2_refcount_metadata_size(int64_t clusters, size_t cluster_size,
  * @total_size: virtual disk size in bytes
  * @cluster_size: cluster size in bytes
  * @refcount_order: refcount bits power-of-2 exponent
+ * @extended_l2: true if the image has extended L2 entries
  *
  * Returns: Total number of bytes required for the fully allocated image
  * (including metadata).
  */
 static int64_t qcow2_calc_prealloc_size(int64_t total_size,
                                         size_t cluster_size,
-                                        int refcount_order)
+                                        int refcount_order,
+                                        bool extended_l2)
 {
     int64_t meta_size = 0;
     uint64_t nl1e, nl2e;
     int64_t aligned_total_size = ROUND_UP(total_size, cluster_size);
+    size_t l2e_size = extended_l2 ? L2E_SIZE_EXTENDED : L2E_SIZE_NORMAL;
 
     /* header: 1 cluster */
     meta_size += cluster_size;
 
     /* total size of L2 tables */
     nl2e = aligned_total_size / cluster_size;
-    nl2e = ROUND_UP(nl2e, cluster_size / sizeof(uint64_t));
-    meta_size += nl2e * sizeof(uint64_t);
+    nl2e = ROUND_UP(nl2e, cluster_size / l2e_size);
+    meta_size += nl2e * l2e_size;
 
     /* total size of L1 tables */
-    nl1e = nl2e * sizeof(uint64_t) / cluster_size;
+    nl1e = nl2e * l2e_size / cluster_size;
     nl1e = ROUND_UP(nl1e, cluster_size / sizeof(uint64_t));
     meta_size += nl1e * sizeof(uint64_t);
 
@@ -4704,6 +4707,7 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
     bool has_backing_file;
     bool has_luks;
     bool extended_l2;
+    size_t l2e_size;
 
     /* Parse image creation options */
     extended_l2 = qemu_opt_get_bool_del(opts, BLOCK_OPT_EXTL2, false);
@@ -4754,8 +4758,9 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
     virtual_size = ROUND_UP(virtual_size, cluster_size);
 
     /* Check that virtual disk size is valid */
+    l2e_size = extended_l2 ? L2E_SIZE_EXTENDED : L2E_SIZE_NORMAL;
     l2_tables = DIV_ROUND_UP(virtual_size / cluster_size,
-                             cluster_size / sizeof(uint64_t));
+                             cluster_size / l2e_size);
     if (l2_tables * sizeof(uint64_t) > QCOW_MAX_L1_SIZE) {
         error_setg(&local_err, "The image size is too large "
                                "(try using a larger cluster size)");
@@ -4818,9 +4823,9 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
     }
 
     info = g_new(BlockMeasureInfo, 1);
-    info->fully_allocated =
+    info->fully_allocated = luks_payload_size +
         qcow2_calc_prealloc_size(virtual_size, cluster_size,
-                                 ctz32(refcount_bits)) + luks_payload_size;
+                                 ctz32(refcount_bits), extended_l2);
 
     /* Remove data clusters that are not required.  This overestimates the
      * required size because metadata needed for the fully allocated file is
-- 
2.20.1


