Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EC7C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 15:08:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11E220826
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 15:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DaWfFOqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11E220826
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcsEK-0004vp-UY
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 11:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jcs01-00036V-VX; Sun, 24 May 2020 10:53:13 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:38069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jcrzy-0002lt-CF; Sun, 24 May 2020 10:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=VM/l5Zr2yE+YJDPCCI/z23hervw4AluXjgu6TqCtgN8=; 
 b=DaWfFOqSWF0MIKS9UrvOn4Dr3enzYg87iFkYt3OOh0ki2Be7hm2ajarXMb1byz2QLz5Ehg0g56TFgUxs0GtOqMggNaX3UfuAD08kXx0Zf1MhMr/0hbgYPibZ7d4EfgG+51TZ5AiMAygJH4o4jTsZiqDOCAjJp4/GQbRBXJumW7l8fM3bEn0pgBjetpBVzk2sY7R3MYDj2dNpxHJNb3zxzoE93WrfBufBoWZXl0651FLHPSsXvEePefDCcG+oPbDxjms7vBrZaBqtHEPVlAJX6hsUQPgpEJYdG8hm0oBxvGqOb2fu22mmYiUpkHYWXd05v7yuFdMqb8l+5l6xoVFSLg==;
Received: from [81.0.38.199] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jcrzF-0007Gg-Sm; Sun, 24 May 2020 16:52:26 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jcryv-0005KS-3L; Sun, 24 May 2020 16:52:05 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 15/32] qcow2: Add qcow2_get_subcluster_range_type()
Date: Sun, 24 May 2020 16:51:35 +0200
Message-Id: <1a2ca24ad22d0c14d1c6cb05f5ab4db7444a7161.1590331741.git.berto@igalia.com>
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

There are situations in which we want to know how many contiguous
subclusters of the same type there are in a given cluster. This can be
done by simply iterating over the subclusters and repeatedly calling
qcow2_get_subcluster_type() for each one of them.

However once we determined the type of a subcluster we can check the
rest efficiently by counting the number of adjacent ones (or zeroes)
in the bitmap. This is what this function does.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 51 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 8b2fc550b7..32dc6e75e3 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -375,6 +375,57 @@ fail:
     return ret;
 }
 
+/*
+ * For a given L2 entry, count the number of contiguous subclusters of
+ * the same type starting from @sc_from. Compressed clusters are
+ * treated as if they were divided into subclusters of size
+ * s->subcluster_size.
+ *
+ * Return the number of contiguous subclusters and set @type to the
+ * subcluster type.
+ *
+ * If the L2 entry is invalid return -errno and set @type to
+ * QCOW2_SUBCLUSTER_INVALID.
+ */
+G_GNUC_UNUSED
+static int qcow2_get_subcluster_range_type(BlockDriverState *bs,
+                                           uint64_t l2_entry,
+                                           uint64_t l2_bitmap,
+                                           unsigned sc_from,
+                                           QCow2SubclusterType *type)
+{
+    BDRVQcow2State *s = bs->opaque;
+    uint32_t val;
+
+    *type = qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, sc_from);
+
+    if (*type == QCOW2_SUBCLUSTER_INVALID) {
+        return -EINVAL;
+    } else if (!has_subclusters(s) || *type == QCOW2_SUBCLUSTER_COMPRESSED) {
+        return s->subclusters_per_cluster - sc_from;
+    }
+
+    switch (*type) {
+    case QCOW2_SUBCLUSTER_NORMAL:
+        val = l2_bitmap | QCOW_OFLAG_SUB_ALLOC_RANGE(0, sc_from);
+        return cto32(val) - sc_from;
+
+    case QCOW2_SUBCLUSTER_ZERO_PLAIN:
+    case QCOW2_SUBCLUSTER_ZERO_ALLOC:
+        val = (l2_bitmap | QCOW_OFLAG_SUB_ZERO_RANGE(0, sc_from)) >> 32;
+        return cto32(val) - sc_from;
+
+    case QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN:
+    case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC:
+        val = ((l2_bitmap >> 32) | l2_bitmap)
+            & ~QCOW_OFLAG_SUB_ALLOC_RANGE(0, sc_from);
+        return ctz32(val) - sc_from;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
 /*
  * Checks how many clusters in a given L2 slice are contiguous in the image
  * file. As soon as one of the flags in the bitmask stop_flags changes compared
-- 
2.20.1


