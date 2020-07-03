Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBBBC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:10:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0816D217BA
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XReo+abT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0816D217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrOGz-0007en-8B
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jrO5m-0003QE-Bo; Fri, 03 Jul 2020 11:59:10 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:41753)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jrO5k-0007S0-Bj; Fri, 03 Jul 2020 11:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=fFliMiIZg8gQ9uYP+jhwHbbYWydz6rMSlmOIpLu6pk0=; 
 b=XReo+abTqSdx4mMBNZcVTmkZRUxGv6nIef5MxwZRxbTHgJromDE5j+LVVrwSOwBSPPJ/a9lahMLg/F4UwsfPOEj38E/RXu15UaKWT056DMFnY9+UiH5hs9IOPbG9WqdBrMLycARUj476sY5dtXquqHtCReFoz6fPvTYwVIuOzj6chRym6UGAozlJa1SvbH7sLTJVGLYWCXUKrBSVhlN3so1ndXZBWttPYmtFdhTrrEPqMF3oosPWXr1G7NHlYpeM0+2XrvqOMYhRFUA5dCJusG18CV1/V5YkZtop7LvYl98JxTbaT6/v07UBDi/9xcZxzUumQT3Pk4CIDGrW78KQVQ==;
Received: from [81.0.49.0] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jrO5L-0001Qg-JV; Fri, 03 Jul 2020 17:58:43 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jrO52-0007QH-9O; Fri, 03 Jul 2020 17:58:24 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 24/34] qcow2: Add subcluster support to
 check_refcounts_l2()
Date: Fri,  3 Jul 2020 17:58:10 +0200
Message-Id: <54394425a624bd2180f3b01bf4a9526f8ad6ed6e.1593791819.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1593791819.git.berto@igalia.com>
References: <cover.1593791819.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 11:21:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

The offset field of an uncompressed cluster's L2 entry must be aligned
to the cluster size, otherwise it is invalid. If the cluster has no
data then it means that the offset points to a preallocation, so we
can clear the offset field without affecting the guest-visible data.
This is what 'qemu-img check' does when run in repair mode.

On traditional qcow2 images this can only happen when QCOW_OFLAG_ZERO
is set, and repairing such entries turns the clusters from ZERO_ALLOC
into ZERO_PLAIN.

Extended L2 entries have no ZERO_ALLOC clusters and no QCOW_OFLAG_ZERO
but the idea is the same: if none of the subclusters are allocated
then we can clear the offset field and leave the bitmap untouched.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-refcount.c     | 16 +++++++++++-----
 tests/qemu-iotests/060.out |  2 +-
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 770c5dbc83..aae52607eb 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1669,12 +1669,18 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
 
             /* Correct offsets are cluster aligned */
             if (offset_into_cluster(s, offset)) {
+                bool contains_data;
                 res->corruptions++;
 
-                if (qcow2_get_cluster_type(bs, l2_entry) ==
-                    QCOW2_CLUSTER_ZERO_ALLOC)
-                {
-                    fprintf(stderr, "%s offset=%" PRIx64 ": Preallocated zero "
+                if (has_subclusters(s)) {
+                    uint64_t l2_bitmap = get_l2_bitmap(s, l2_table, i);
+                    contains_data = (l2_bitmap & QCOW_L2_BITMAP_ALL_ALLOC);
+                } else {
+                    contains_data = !(l2_entry & QCOW_OFLAG_ZERO);
+                }
+
+                if (!contains_data) {
+                    fprintf(stderr, "%s offset=%" PRIx64 ": Preallocated "
                             "cluster is not properly aligned; L2 entry "
                             "corrupted.\n",
                             fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR",
@@ -1686,7 +1692,7 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
                         int ign = active ? QCOW2_OL_ACTIVE_L2 :
                                            QCOW2_OL_INACTIVE_L2;
 
-                        l2_entry = QCOW_OFLAG_ZERO;
+                        l2_entry = has_subclusters(s) ? 0 : QCOW_OFLAG_ZERO;
                         set_l2_entry(s, l2_table, i, l2_entry);
                         ret = qcow2_pre_write_overlap_check(bs, ign,
                                 l2e_offset, l2_entry_size(s), false);
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index be5f8707a3..fa3d68f0df 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -320,7 +320,7 @@ discard 65536/65536 bytes at offset 0
 qcow2: Marking image as corrupt: Preallocated zero cluster offset 0x2a00 unaligned (guest offset: 0); further corruption events will be suppressed
 write failed: Input/output error
 --- Repairing ---
-Repairing offset=2a00: Preallocated zero cluster is not properly aligned; L2 entry corrupted.
+Repairing offset=2a00: Preallocated cluster is not properly aligned; L2 entry corrupted.
 The following inconsistencies were found and repaired:
 
     0 leaked clusters
-- 
2.20.1


