Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9A7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A8252071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ph8k67si"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A8252071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAURp-00018d-Ix
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUOv-00040d-BM
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:33:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59570
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUOs-0000cc-CJ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598344429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3nFpmCI2uYDGUKxfLFqrxJ3b3ZYo5STX0h4aHGsGM48=;
 b=Ph8k67sibyOtdEEk1AXzDFgGBrJemXc878QVYGgaW6rDvHSyckNUYOyODNn0SPN+baBngO
 PYwKhFrihO8dhhkk1lepxonICiFcQul3Kf1CBhRGkVhA31DxacK2B9uWNM6GcYhQ7tNTUF
 UWu2Zbh7hPuH1wh7SJorzyxnnzjD4P0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-QgwquM4iOGK2EZ1OUma7Sw-1; Tue, 25 Aug 2020 04:33:47 -0400
X-MC-Unique: QgwquM4iOGK2EZ1OUma7Sw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29A10E75F;
 Tue, 25 Aug 2020 08:33:46 +0000 (UTC)
Received: from localhost (ovpn-113-72.ams2.redhat.com [10.36.113.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98F2A50B3F;
 Tue, 25 Aug 2020 08:33:45 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 14/34] qcow2: Add QCow2SubclusterType and
 qcow2_get_subcluster_type()
Date: Tue, 25 Aug 2020 10:32:51 +0200
Message-Id: <20200825083311.1098442-15-mreitz@redhat.com>
In-Reply-To: <20200825083311.1098442-1-mreitz@redhat.com>
References: <20200825083311.1098442-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:05:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

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
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <26ef38e270f25851c98b51278852b4c4a7f97e69.1594396418.git.berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h | 126 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 82b86f6cec..3aec6f452a 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -80,6 +80,21 @@
 
 #define QCOW_EXTL2_SUBCLUSTERS_PER_CLUSTER 32
 
+/* The subcluster X [0..31] is allocated */
+#define QCOW_OFLAG_SUB_ALLOC(X)   (1ULL << (X))
+/* The subcluster X [0..31] reads as zeroes */
+#define QCOW_OFLAG_SUB_ZERO(X)    (QCOW_OFLAG_SUB_ALLOC(X) << 32)
+/* Subclusters [X, Y) (0 <= X <= Y <= 32) are allocated */
+#define QCOW_OFLAG_SUB_ALLOC_RANGE(X, Y) \
+    (QCOW_OFLAG_SUB_ALLOC(Y) - QCOW_OFLAG_SUB_ALLOC(X))
+/* Subclusters [X, Y) (0 <= X <= Y <= 32) read as zeroes */
+#define QCOW_OFLAG_SUB_ZERO_RANGE(X, Y) \
+    (QCOW_OFLAG_SUB_ALLOC_RANGE(X, Y) << 32)
+/* L2 entry bitmap with all allocation bits set */
+#define QCOW_L2_BITMAP_ALL_ALLOC  (QCOW_OFLAG_SUB_ALLOC_RANGE(0, 32))
+/* L2 entry bitmap with all "read as zeroes" bits set */
+#define QCOW_L2_BITMAP_ALL_ZEROES (QCOW_OFLAG_SUB_ZERO_RANGE(0, 32))
+
 /* Size of normal and extended L2 entries */
 #define L2E_SIZE_NORMAL   (sizeof(uint64_t))
 #define L2E_SIZE_EXTENDED (sizeof(uint64_t) * 2)
@@ -462,6 +477,33 @@ typedef struct QCowL2Meta
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
@@ -470,6 +512,16 @@ typedef enum QCow2ClusterType {
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
@@ -634,9 +686,11 @@ static inline int64_t qcow2_vm_state_offset(BDRVQcow2State *s)
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
@@ -656,6 +710,76 @@ static inline QCow2ClusterType qcow2_get_cluster_type(BlockDriverState *bs,
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
+ * Return QCOW2_SUBCLUSTER_INVALID if an invalid l2 entry is detected
+ * (this checks the whole entry and bitmap, not only the bits related
+ * to subcluster @sc_index).
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
+        switch (type) {
+        case QCOW2_CLUSTER_COMPRESSED:
+            return QCOW2_SUBCLUSTER_COMPRESSED;
+        case QCOW2_CLUSTER_NORMAL:
+            if ((l2_bitmap >> 32) & l2_bitmap) {
+                return QCOW2_SUBCLUSTER_INVALID;
+            } else if (l2_bitmap & QCOW_OFLAG_SUB_ZERO(sc_index)) {
+                return QCOW2_SUBCLUSTER_ZERO_ALLOC;
+            } else if (l2_bitmap & QCOW_OFLAG_SUB_ALLOC(sc_index)) {
+                return QCOW2_SUBCLUSTER_NORMAL;
+            } else {
+                return QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC;
+            }
+        case QCOW2_CLUSTER_UNALLOCATED:
+            if (l2_bitmap & QCOW_L2_BITMAP_ALL_ALLOC) {
+                return QCOW2_SUBCLUSTER_INVALID;
+            } else if (l2_bitmap & QCOW_OFLAG_SUB_ZERO(sc_index)) {
+                return QCOW2_SUBCLUSTER_ZERO_PLAIN;
+            } else {
+                return QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN;
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
2.26.2


