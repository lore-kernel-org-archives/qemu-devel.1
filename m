Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BE4C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 17:53:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E20B20746
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 17:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kWhO/fU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E20B20746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW1kl-0002Ee-KT
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 13:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jW1Xf-0006wo-RG; Tue, 05 May 2020 13:39:39 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:39028)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jW1Xd-0008Qj-Jv; Tue, 05 May 2020 13:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=gDhxCR7OHusS/Zl+2ck2F/ypSmlrdbE/+hA/eOXp1yE=; 
 b=kWhO/fU3BHWBnWs9FNh6KJqE+rqFzLNHRdSPzP/xjxlaVlHATxzb/VNUz7ToQnwjOH95I1R5ucUiclhWIG3H8d2HahMRa4QNq9JDopNuZwJmzkH3UXFRU2pgq97/a8sl6aQOiDlK9qDmrJfKt6h4xgIzVBjqkQ4Nc6BP2H89ZAvayFQlSox3zT+r11vgL/9FLKwxDfyPq9SiczIcPt/+K364NkesqZtPBz9GGKjg/lcPJ1F7a027G67+yHNOyDcQVvX/Uvzt3EfFeCe1W4k4+GIWFllQHBe/ynwRMZgQX82KtVpnaIKMjZhqqOewG892FVr+9E5DCj64Af9HDn82XQ==;
Received: from static.160.43.0.81.ibercom.com ([81.0.43.160]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jW1Ws-00025A-Co; Tue, 05 May 2020 19:38:50 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jW1Wc-00043z-SP; Tue, 05 May 2020 19:38:34 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 14/31] qcow2: Add QCow2SubclusterType and
 qcow2_get_subcluster_type()
Date: Tue,  5 May 2020 19:38:14 +0200
Message-Id: <5b744e9c0f3d348ea675c7a52aabaeeab6fe7b64.1588699789.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1588699789.git.berto@igalia.com>
References: <cover.1588699789.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 13:38:50
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
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds QCow2SubclusterType, which is the subcluster-level
version of QCow2ClusterType. All QCOW2_SUBCLUSTER_* values have the
the same meaning as their QCOW2_CLUSTER_* equivalents (when they
exist). See below for details and caveats.

In images without extended L2 entries clusters are treated as having
exactly one subcluster so it is possible to replace one data type with
the other while keeping the exact same semantics.

With extended L2 entries there are new possible values, and every
subcluster in the same cluster can obviously have a different
QCow2SubclusterType so functions need to be adapted to work on the
subcluster level.

There are several things that have to be taken into account:

  a) QCOW2_SUBCLUSTER_COMPRESSED means that the whole cluster is
     compressed. We do not support compression at the subcluster
     level.

  b) There are two different values for unallocated subclusters:
     QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN which means that the whole
     cluster is unallocated, and QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC
     which means that the cluster is allocated but the subcluster is
     not. The latter can only happen in images with extended L2
     entries.

  c) QCOW2_SUBCLUSTER_INVALID is used to detect the cases where an L2
     entry has a value that violates the specification. The caller is
     responsible for handling these situations.

     To prevent compatibility problems with images that have invalid
     values but are currently being read by QEMU without causing side
     effects, QCOW2_SUBCLUSTER_INVALID is only returned for images
     with extended L2 entries.

qcow2_cluster_to_subcluster_type() is added as a separate function
from qcow2_get_subcluster_type(), but this is only temporary and both
will be merged in a subsequent patch.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.h | 127 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 126 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 4ad93772b9..be7816a3b8 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -80,6 +80,21 @@
 
 #define QCOW_EXTL2_SUBCLUSTERS_PER_CLUSTER 32
 
+/* The subcluster X [0..31] is allocated */
+#define QCOW_OFLAG_SUB_ALLOC(X)   (1ULL << (X))
+/* The subcluster X [0..31] reads as zeroes */
+#define QCOW_OFLAG_SUB_ZERO(X)    (QCOW_OFLAG_SUB_ALLOC(X) << 32)
+/* Subclusters X to Y (both included) are allocated */
+#define QCOW_OFLAG_SUB_ALLOC_RANGE(X, Y) \
+    (QCOW_OFLAG_SUB_ALLOC((Y) + 1) - QCOW_OFLAG_SUB_ALLOC(X))
+/* Subclusters X to Y (both included) read as zeroes */
+#define QCOW_OFLAG_SUB_ZERO_RANGE(X, Y) \
+    (QCOW_OFLAG_SUB_ALLOC_RANGE(X, Y) << 32)
+/* L2 entry bitmap with all allocation bits set */
+#define QCOW_L2_BITMAP_ALL_ALLOC  (QCOW_OFLAG_SUB_ALLOC_RANGE(0, 31))
+/* L2 entry bitmap with all "read as zeroes" bits set */
+#define QCOW_L2_BITMAP_ALL_ZEROES (QCOW_OFLAG_SUB_ZERO_RANGE(0, 31))
+
 /* Size of normal and extended L2 entries */
 #define L2E_SIZE_NORMAL   (sizeof(uint64_t))
 #define L2E_SIZE_EXTENDED (sizeof(uint64_t) * 2)
@@ -444,6 +459,33 @@ typedef struct QCowL2Meta
     QLIST_ENTRY(QCowL2Meta) next_in_flight;
 } QCowL2Meta;
 
+/*
+ * In images with standard L2 entries all clusters are treated as if
+ * they had one subcluster so QCow2ClusterType and QCow2SubclusterType
+ * can be mapped to each other and have the exact same meaning
+ * (QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC cannot happen in these images).
+ *
+ * In images with extended L2 entries QCow2ClusterType refers to the
+ * complete cluster and QCow2SubclusterType to each of the individual
+ * subclusters, so there are several possible combinations:
+ *
+ *     |--------------+---------------------------|
+ *     | Cluster type | Possible subcluster types |
+ *     |--------------+---------------------------|
+ *     | UNALLOCATED  |         UNALLOCATED_PLAIN |
+ *     |              |                ZERO_PLAIN |
+ *     |--------------+---------------------------|
+ *     | NORMAL       |         UNALLOCATED_ALLOC |
+ *     |              |                ZERO_ALLOC |
+ *     |              |                    NORMAL |
+ *     |--------------+---------------------------|
+ *     | COMPRESSED   |                COMPRESSED |
+ *     |--------------+---------------------------|
+ *
+ * QCOW2_SUBCLUSTER_INVALID means that the L2 entry is incorrect and
+ * the image should be marked corrupt.
+ */
+
 typedef enum QCow2ClusterType {
     QCOW2_CLUSTER_UNALLOCATED,
     QCOW2_CLUSTER_ZERO_PLAIN,
@@ -452,6 +494,16 @@ typedef enum QCow2ClusterType {
     QCOW2_CLUSTER_COMPRESSED,
 } QCow2ClusterType;
 
+typedef enum QCow2SubclusterType {
+    QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN,
+    QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC,
+    QCOW2_SUBCLUSTER_ZERO_PLAIN,
+    QCOW2_SUBCLUSTER_ZERO_ALLOC,
+    QCOW2_SUBCLUSTER_NORMAL,
+    QCOW2_SUBCLUSTER_COMPRESSED,
+    QCOW2_SUBCLUSTER_INVALID,
+} QCow2SubclusterType;
+
 typedef enum QCow2MetadataOverlap {
     QCOW2_OL_MAIN_HEADER_BITNR      = 0,
     QCOW2_OL_ACTIVE_L1_BITNR        = 1,
@@ -616,9 +668,11 @@ static inline int64_t qcow2_vm_state_offset(BDRVQcow2State *s)
 static inline QCow2ClusterType qcow2_get_cluster_type(BlockDriverState *bs,
                                                       uint64_t l2_entry)
 {
+    BDRVQcow2State *s = bs->opaque;
+
     if (l2_entry & QCOW_OFLAG_COMPRESSED) {
         return QCOW2_CLUSTER_COMPRESSED;
-    } else if (l2_entry & QCOW_OFLAG_ZERO) {
+    } else if ((l2_entry & QCOW_OFLAG_ZERO) && !has_subclusters(s)) {
         if (l2_entry & L2E_OFFSET_MASK) {
             return QCOW2_CLUSTER_ZERO_ALLOC;
         }
@@ -638,6 +692,77 @@ static inline QCow2ClusterType qcow2_get_cluster_type(BlockDriverState *bs,
     }
 }
 
+/*
+ * For an image without extended L2 entries, return the
+ * QCow2SubclusterType equivalent of a given QCow2ClusterType.
+ */
+static inline
+QCow2SubclusterType qcow2_cluster_to_subcluster_type(QCow2ClusterType type)
+{
+    switch (type) {
+    case QCOW2_CLUSTER_COMPRESSED:
+        return QCOW2_SUBCLUSTER_COMPRESSED;
+    case QCOW2_CLUSTER_ZERO_PLAIN:
+        return QCOW2_SUBCLUSTER_ZERO_PLAIN;
+    case QCOW2_CLUSTER_ZERO_ALLOC:
+        return QCOW2_SUBCLUSTER_ZERO_ALLOC;
+    case QCOW2_CLUSTER_NORMAL:
+        return QCOW2_SUBCLUSTER_NORMAL;
+    case QCOW2_CLUSTER_UNALLOCATED:
+        return QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+/*
+ * In an image without subsclusters @l2_bitmap is ignored and
+ * @sc_index must be 0.
+ */
+static inline
+QCow2SubclusterType qcow2_get_subcluster_type(BlockDriverState *bs,
+                                              uint64_t l2_entry,
+                                              uint64_t l2_bitmap,
+                                              unsigned sc_index)
+{
+    BDRVQcow2State *s = bs->opaque;
+    QCow2ClusterType type = qcow2_get_cluster_type(bs, l2_entry);
+    assert(sc_index < s->subclusters_per_cluster);
+
+    if (has_subclusters(s)) {
+        bool sc_zero  = l2_bitmap & QCOW_OFLAG_SUB_ZERO(sc_index);
+        bool sc_alloc = l2_bitmap & QCOW_OFLAG_SUB_ALLOC(sc_index);
+        switch (type) {
+        case QCOW2_CLUSTER_COMPRESSED:
+            return QCOW2_SUBCLUSTER_COMPRESSED;
+        case QCOW2_CLUSTER_NORMAL:
+            if (!sc_zero && !sc_alloc) {
+                return QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC;
+            } else if (!sc_zero && sc_alloc) {
+                return QCOW2_SUBCLUSTER_NORMAL;
+            } else if (sc_zero && !sc_alloc) {
+                return QCOW2_SUBCLUSTER_ZERO_ALLOC;
+            } else { /* sc_zero && sc_alloc */
+                return QCOW2_SUBCLUSTER_INVALID;
+            }
+        case QCOW2_CLUSTER_UNALLOCATED:
+            if (!sc_zero && !sc_alloc) {
+                return QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN;
+            } else if (!sc_zero && sc_alloc) {
+                return QCOW2_SUBCLUSTER_INVALID;
+            } else if (sc_zero && !sc_alloc) {
+                return QCOW2_SUBCLUSTER_ZERO_PLAIN;
+            } else { /* sc_zero && sc_alloc */
+                return QCOW2_SUBCLUSTER_INVALID;
+            }
+        default:
+            g_assert_not_reached();
+        }
+    } else {
+        return qcow2_cluster_to_subcluster_type(type);
+    }
+}
+
 /* Check whether refcounts are eager or lazy */
 static inline bool qcow2_need_accurate_refcounts(BDRVQcow2State *s)
 {
-- 
2.20.1


