Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB01C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 14:53:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C4322075F
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 14:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="N97aVSvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4322075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcs0Q-0003mK-C1
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 10:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jcrzY-0001fO-Ri; Sun, 24 May 2020 10:52:44 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:37778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jcrzX-0002kL-Am; Sun, 24 May 2020 10:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=XBnN61YNWOhG+6+Gd0bCaslv74HTZpq5RBwS8AyYww8=; 
 b=N97aVSvALkiDVkpq4JwCUXfBk2Mz3dBFdNRTB9pL7+54jmU11iEnIx5YdetyYrjCZEosXlE0Jfqg9/KmG9CTD8PL328MbGkZTOI92F4DmOhKZ36s7kensx8kGGPvwzdOetPFOXobhB3XVoxNG+p/Lz7g/Q+f33Nitp3t8Lx3TS4v5/Oh4gGrsl0RVXO4tT2PsNuxEgZZYdblEGlUEQ6Pbbh+zT9iu+pYecZjiAlVi9GkocAqvuXYeg0kJlhpB9lQrmEu4/5YfdwGL6s0yod3oXAikBDrX9coDn2IWwK05BRimu9EtaK9vy5CdmfFyqjGHVre4vobtjrvhXBxEseg4A==;
Received: from [81.0.38.199] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jcrz9-0007GJ-8t; Sun, 24 May 2020 16:52:19 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jcryv-0005Ku-IO; Sun, 24 May 2020 16:52:05 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 29/32] qcow2: Add subcluster support to qcow2_measure()
Date: Sun, 24 May 2020 16:51:49 +0200
Message-Id: <a8e0bf5b36ac4e2d2531a7ab722ab5f6e4de0903.1590331741.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1590331741.git.berto@igalia.com>
References: <cover.1590331741.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 10:52:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Derek Su <dereksu@qnap.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extended L2 entries are bigger than normal L2 entries so this has an
impact on the amount of metadata needed for a qcow2 file.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 40988fff55..bc7a4a1729 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3233,28 +3233,31 @@ int64_t qcow2_refcount_metadata_size(int64_t clusters, size_t cluster_size,
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
 
@@ -4834,6 +4837,8 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
     PreallocMode prealloc;
     bool has_backing_file;
     bool has_luks;
+    bool extended_l2 = false; /* Set to false until the option is added */
+    size_t l2e_size;
 
     /* Parse image creation options */
     cluster_size = qcow2_opt_get_cluster_size_del(opts, &local_err);
@@ -4899,8 +4904,9 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
     virtual_size = ROUND_UP(virtual_size, cluster_size);
 
     /* Check that virtual disk size is valid */
+    l2e_size = extended_l2 ? L2E_SIZE_EXTENDED : L2E_SIZE_NORMAL;
     l2_tables = DIV_ROUND_UP(virtual_size / cluster_size,
-                             cluster_size / sizeof(uint64_t));
+                             cluster_size / l2e_size);
     if (l2_tables * sizeof(uint64_t) > QCOW_MAX_L1_SIZE) {
         error_setg(&local_err, "The image size is too large "
                                "(try using a larger cluster size)");
@@ -4963,9 +4969,9 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
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


