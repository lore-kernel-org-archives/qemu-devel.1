Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3854CC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 14:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04A672075F
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 14:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TnvcSppr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A672075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcs4P-0004nU-8D
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 10:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jcrzx-0002ro-5q; Sun, 24 May 2020 10:53:09 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:37895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jcrzv-0002lK-9w; Sun, 24 May 2020 10:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=8zplI1UiwFKJ83AGO9lzNzyl1XqngZYwma9UQPZedjE=; 
 b=TnvcSpprxd2/dlXZfQRyRIfwdmXYUZNjh5NAd9Emyopd352G1U9ay2Gr2XlYQBPDPuUZpiZadeIG4JjkskAkYu1c/C4wk2cIDLSVBg8VrHZbmcWekFLAKetNmdxeVF+tl3rrfMAkXy7J7q6emPFbWM3d/aMbhu5dImxtu+cqlgQO6ol6sIetvF5ImBV7Hd886qjkOp7tv55BFa/WTmXZenLfbmkxJ8MLFeorEPtUASFE+cSxfROBZae35Cgt8GIh28szgAZL7MIvI3tILmy9iTpLKljygaOGPn7xqH1+CuKodT1eFGF3llRFAX7L7oXGG1Pt2cTzanmOsuOUBHSQVA==;
Received: from [81.0.38.199] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jcrzF-0007GP-5g; Sun, 24 May 2020 16:52:25 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jcryu-0005KG-T5; Sun, 24 May 2020 16:52:04 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 09/32] qcow2: Add subcluster-related fields to
 BDRVQcow2State
Date: Sun, 24 May 2020 16:51:29 +0200
Message-Id: <fbffb90925bb8000896e818efc0b8a3ef0f62519.1590331741.git.berto@igalia.com>
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

This patch adds the following new fields to BDRVQcow2State:

- subclusters_per_cluster: Number of subclusters in a cluster
- subcluster_size: The size of each subcluster, in bytes
- subcluster_bits: No. of bits so 1 << subcluster_bits = subcluster_size

Images without subclusters are treated as if they had exactly one
subcluster per cluster (i.e. subcluster_size = cluster_size).

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.h | 5 +++++
 block/qcow2.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/block/qcow2.h b/block/qcow2.h
index f41bfd743f..4e9c732831 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -78,6 +78,8 @@
 /* The cluster reads as all zeros */
 #define QCOW_OFLAG_ZERO (1ULL << 0)
 
+#define QCOW_EXTL2_SUBCLUSTERS_PER_CLUSTER 32
+
 #define MIN_CLUSTER_BITS 9
 #define MAX_CLUSTER_BITS 21
 
@@ -295,6 +297,9 @@ typedef struct BDRVQcow2State {
     int cluster_bits;
     int cluster_size;
     int l2_slice_size;
+    int subcluster_bits;
+    int subcluster_size;
+    int subclusters_per_cluster;
     int l2_bits;
     int l2_size;
     int l1_size;
diff --git a/block/qcow2.c b/block/qcow2.c
index 6562eb1590..916b6c3f92 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1433,6 +1433,11 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
         }
     }
 
+    s->subclusters_per_cluster =
+        has_subclusters(s) ? QCOW_EXTL2_SUBCLUSTERS_PER_CLUSTER : 1;
+    s->subcluster_size = s->cluster_size / s->subclusters_per_cluster;
+    s->subcluster_bits = ctz32(s->subcluster_size);
+
     /* Check support for various header values */
     if (header.refcount_order > 6) {
         error_setg(errp, "Reference count entry width too large; may not "
-- 
2.20.1


