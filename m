Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69383C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:35:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3401A20640
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lRc97Tzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3401A20640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKOr5-0005DU-Rf
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 11:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iKOhI-0003G6-A8
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iKOhG-0003ps-PX
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:25:16 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:47093)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iKOhG-0003Z4-Ga; Tue, 15 Oct 2019 11:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=kALB3wZJBo7sh2ZPgeIIj7Aso3rnUuxVKnq2S4x/FbY=; 
 b=lRc97TzctbWpFuLiImYu7mZ4x4Mn9Hl8SZGtrkaHvKGPiWxdw629mHKGFKsCmuBBqkRJCR9wCQbz7q+oQ6YkE7INxLo3lFKIgJK3nRAFbptehdTQIMPM6ZzmONeg4h+dbe9dPKDG9brBHj4Pvqpvc/+w0J4/nPAEG+NqlzTBI3XLYv0+EyOJKVmj9IhWOF1+hZBpr5mJo0IoLx2Ev00GyKEpYJbbRPkBo2WrTbjK3k5D0OnPuWFtQ1756kyyzfGKe4BafBg7EigvxF7NmKu5qpg75/g+YQ3HBNBypPuS/dGAMpkRPtbfKPs7WqTOx8ELUDxIUOnV9VlyEwWsquNg4A==;
Received: from 82-181-115-92.bb.dnainternet.fi ([82.181.115.92]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iKOge-0003aY-0j; Tue, 15 Oct 2019 17:24:36 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iKOfm-00061V-Re; Tue, 15 Oct 2019 18:23:42 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 11/23] qcow2: Add qcow2_get_subcluster_type()
Date: Tue, 15 Oct 2019 18:23:22 +0300
Message-Id: <574a36d3e22089745ea3d05503163ab5c93addf0.1571152571.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1571152571.git.berto@igalia.com>
References: <cover.1571152571.git.berto@igalia.com>
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
 Max Reitz <mreitz@redhat.com>, "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function returns the type of an individual subcluster. If an
image does not have subclusters then this returns the exact same value
as qcow2_get_cluster_type().

The information in standard and extended L2 entries is encoded in a
slightly different way, but all existing QCow2ClusterType values are
also valid for subclusters and have the same meanings (although they
typically only apply to the requested subcluster).

There are two important exceptions to this:

  a) QCOW2_CLUSTER_COMPRESSED means that the whole cluster is
     compressed. We do not support compression at the subcluster
     level.

  b) QCOW2_CLUSTER_UNALLOCATED means that the cluster is unallocated,
     that is, the offset field of the L2 entry does not point to a
     host cluster. All subclusters are obviously unallocated too but
     any of them could be of type QCOW2_CLUSTER_ZERO_PLAIN.

In addition to that, extended L2 entries allow one new scenario where
the cluster is normally allocated but an individual subcluster is not.
This is very different from (b) and because of that this patch adds a
new value called QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER.

As a last thing, this patch adds QCOW2_CLUSTER_INVALID to detect the
cases where an L2 entry has a value that violates the spec. The caller
is responsible for handling these situations.

To prevent compatibility problems with images that have invalid values
but are currently being read by QEMU without causing side effects,
QCOW2_CLUSTER_INVALID is only returned for images with extended L2
entries.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.h | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/block/qcow2.h b/block/qcow2.h
index d9fe883fe0..60e4bf963e 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -74,6 +74,15 @@
 
 #define QCOW_MAX_SUBCLUSTERS_PER_CLUSTER 32
 
+/* The subcluster X [0..31] reads as zeroes */
+#define QCOW_OFLAG_SUB_ZERO(X)    ((1ULL << 63) >> (X))
+/* The subcluster X [0..31] is allocated */
+#define QCOW_OFLAG_SUB_ALLOC(X)   ((1ULL << 31) >> (X))
+/* L2 entry bitmap with all "read as zeroes" bits set */
+#define QCOW_L2_BITMAP_ALL_ZEROES 0xFFFFFFFF00000000ULL
+/* L2 entry bitmap with all allocation bits set */
+#define QCOW_L2_BITMAP_ALL_ALLOC  0x00000000FFFFFFFFULL
+
 #define MIN_CLUSTER_BITS 9
 #define MAX_CLUSTER_BITS 21
 
@@ -435,10 +444,12 @@ typedef struct QCowL2Meta
 
 typedef enum QCow2ClusterType {
     QCOW2_CLUSTER_UNALLOCATED,
+    QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER,
     QCOW2_CLUSTER_ZERO_PLAIN,
     QCOW2_CLUSTER_ZERO_ALLOC,
     QCOW2_CLUSTER_NORMAL,
     QCOW2_CLUSTER_COMPRESSED,
+    QCOW2_CLUSTER_INVALID,
 } QCow2ClusterType;
 
 typedef enum QCow2MetadataOverlap {
@@ -618,6 +629,57 @@ static inline QCow2ClusterType qcow2_get_cluster_type(BlockDriverState *bs,
     }
 }
 
+/* In an image without subsclusters this returns the same value as
+ * qcow2_get_cluster_type() */
+static inline int qcow2_get_subcluster_type(BlockDriverState *bs,
+                                            uint64_t l2_entry,
+                                            uint64_t l2_bitmap,
+                                            unsigned sc_index)
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
+            if (l2_bitmap != 0) {
+                return QCOW2_CLUSTER_INVALID;
+            }
+            break;
+        case QCOW2_CLUSTER_ZERO_PLAIN:
+        case QCOW2_CLUSTER_ZERO_ALLOC:
+            return QCOW2_CLUSTER_INVALID;
+        case QCOW2_CLUSTER_NORMAL:
+            if (!sc_zero && !sc_alloc) {
+                return QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER;
+            } else if (!sc_zero && sc_alloc) {
+                return QCOW2_CLUSTER_NORMAL;
+            } else if (sc_zero && !sc_alloc) {
+                return QCOW2_CLUSTER_ZERO_ALLOC;
+            } else { /* sc_zero && sc_alloc */
+                return QCOW2_CLUSTER_INVALID;
+            }
+        case QCOW2_CLUSTER_UNALLOCATED:
+            if (!sc_zero && !sc_alloc) {
+                return QCOW2_CLUSTER_UNALLOCATED;
+            } else if (!sc_zero && sc_alloc) {
+                return QCOW2_CLUSTER_INVALID;
+            } else if (sc_zero && !sc_alloc) {
+                return QCOW2_CLUSTER_ZERO_PLAIN;
+            } else { /* sc_zero && sc_alloc */
+                return QCOW2_CLUSTER_INVALID;
+            }
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    return type;
+}
+
 /* Check whether refcounts are eager or lazy */
 static inline bool qcow2_need_accurate_refcounts(BDRVQcow2State *s)
 {
-- 
2.20.1


