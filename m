Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE6DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 15:17:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B76206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 15:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="iqsFaXeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B76206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj2Tg-0004gH-QN
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 11:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jj2Gy-0002mB-Rq; Wed, 10 Jun 2020 11:04:12 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:58253)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jj2Gs-0006wf-OT; Wed, 10 Jun 2020 11:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=jiMv9S+Pgj4nbYi0/zDdysZBoTSQanZXM6tOp5flWJA=; 
 b=iqsFaXeIV39lg3qH+p4JMDNKazZJh0LJwAfzFWaMYQclW13ccfMOFbT9bkI8yI98pSr/KbBvuNXOvOTSKWXNYVEdJmbo25pK8PiwwzHSINKWJSsjbKhe5gJ5OT0ZuUNd/6ORvbb+uzxewrhd6QmpwLmG2/LXBc0+M3Ydz1g9yWQj+RT3rhmnZ421UKZHVSvqwmHQALPjGj1Y8pmoop2b8x+GbTRHeWEgmwQ58IiwtXQei9Mct9DWg7HJ26U2on/YfvPv6Gp3160xXbl69fr6gudlRq6LWWPQSwx/fuZ5LSKAtG90c0Nwu9LTPfmxmxiS5u+AzRTLwc6QzPNKg2JEOQ==;
Received: from [81.0.38.199] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jj2GR-0007hG-SJ; Wed, 10 Jun 2020 17:03:40 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jj2GC-0007Nl-HZ; Wed, 10 Jun 2020 17:03:24 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 29/34] qcow2: Add subcluster support to qcow2_measure()
Date: Wed, 10 Jun 2020 17:03:07 +0200
Message-Id: <80fc75dd6dd7dba6d52ca7a0b57949ce5cabf943.1591801197.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1591801197.git.berto@igalia.com>
References: <cover.1591801197.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 11:03:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
index 4edc3c72b9..72bd25e774 100644
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
 
@@ -4845,6 +4848,8 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
     PreallocMode prealloc;
     bool has_backing_file;
     bool has_luks;
+    bool extended_l2 = false; /* Set to false until the option is added */
+    size_t l2e_size;
 
     /* Parse image creation options */
     cluster_size = qcow2_opt_get_cluster_size_del(opts, &local_err);
@@ -4910,8 +4915,9 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
     virtual_size = ROUND_UP(virtual_size, cluster_size);
 
     /* Check that virtual disk size is valid */
+    l2e_size = extended_l2 ? L2E_SIZE_EXTENDED : L2E_SIZE_NORMAL;
     l2_tables = DIV_ROUND_UP(virtual_size / cluster_size,
-                             cluster_size / sizeof(uint64_t));
+                             cluster_size / l2e_size);
     if (l2_tables * sizeof(uint64_t) > QCOW_MAX_L1_SIZE) {
         error_setg(&local_err, "The image size is too large "
                                "(try using a larger cluster size)");
@@ -4974,9 +4980,9 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
     }
 
     info = g_new0(BlockMeasureInfo, 1);
-    info->fully_allocated =
+    info->fully_allocated = luks_payload_size +
         qcow2_calc_prealloc_size(virtual_size, cluster_size,
-                                 ctz32(refcount_bits)) + luks_payload_size;
+                                 ctz32(refcount_bits), extended_l2);
 
     /*
      * Remove data clusters that are not required.  This overestimates the
-- 
2.20.1


