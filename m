Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396ABC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0987720714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Us9bL0NB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0987720714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEH5H-0006KE-6A
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jEGmy-0003W8-Bi
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:18:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jEGmv-00009s-A2
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:18:04 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:58013)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jEGmu-0005yB-43; Tue, 17 Mar 2020 14:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=C0eALyg6t8kHhqoCkYLe5gXMSMiybsgvLwFsI8EfjjI=; 
 b=Us9bL0NBDkov6frBccZz/YTvQdgQ+ViKkF6Xc4JKeHbpjnsUxnJWm5X4pVzvCE6pq49NR1OoCq4WrITqGV4Y0p+emAT7jdH3U52XtKiS8XSLkk1Q4ViXC3z4py1NrM6RqG3W3qdeAZNFXgToE+nFZDbeqtGkFKgLt2JzZykB5gSrGzW71LSbzrZ7CYvK/VMoevRYoDlNqTwlPPqafjeXgowx4ApIZX/B0lBL2PICn3PSPZbwJfDmXW9upDEj7p3498Yu9XkaJR6fYXbY7ACQzaHFiSw9v5wu32HerYE9ELSCU2HkrVjH63fY5j7+A3YrT4L1V2aleiqKzOalq1zKoQ==;
Received: from [81.0.35.138] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jEGmD-00015A-4V; Tue, 17 Mar 2020 19:17:17 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jEGlw-0006Ov-Uz; Tue, 17 Mar 2020 19:17:00 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 27/30] qcow2: Assert that expand_zero_clusters_in_l1() does
 not support subclusters
Date: Tue, 17 Mar 2020 19:16:24 +0100
Message-Id: <5cc70489bfeb7d2f8f6c8a113dc530cab504db9e.1584468723.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1584468723.git.berto@igalia.com>
References: <cover.1584468723.git.berto@igalia.com>
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

This function is only used by qcow2_expand_zero_clusters() to
downgrade a qcow2 image to a previous version. It is however not
possible to downgrade an image with extended L2 entries because older
versions of qcow2 do not have this feature.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c      | 8 +++++++-
 tests/qemu-iotests/061     | 6 ++++++
 tests/qemu-iotests/061.out | 5 +++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 1f471db98c..125d2852f6 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -2039,6 +2039,9 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
     int ret;
     int i, j;
 
+    /* qcow2_downgrade() is not allowed in images with subclusters */
+    assert(!has_subclusters(s));
+
     slice_size2 = s->l2_slice_size * l2_entry_size(s);
     n_slices = s->cluster_size / slice_size2;
 
@@ -2107,7 +2110,8 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
                 if (cluster_type == QCOW2_CLUSTER_ZERO_PLAIN) {
                     if (!bs->backing) {
                         /* not backed; therefore we can simply deallocate the
-                         * cluster */
+                         * cluster. No need to call set_l2_bitmap(), this
+                         * function doesn't support images with subclusters. */
                         set_l2_entry(s, l2_slice, j, 0);
                         l2_dirty = true;
                         continue;
@@ -2178,6 +2182,8 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
                 } else {
                     set_l2_entry(s, l2_slice, j, offset);
                 }
+                /* No need to call set_l2_bitmap() after set_l2_entry() because
+                 * this function doesn't support images with subclusters. */
                 l2_dirty = true;
             }
 
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index 36b040491f..66bfd23179 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -266,6 +266,12 @@ $QEMU_IMG amend -o "compat=0.10" "$TEST_IMG"
 _img_info --format-specific
 _check_test_img
 
+echo
+echo "=== Testing version downgrade with extended L2 entries ==="
+echo
+_make_test_img -o "compat=1.1,extended_l2=on" 64M
+$QEMU_IMG amend -o "compat=0.10" "$TEST_IMG"
+
 echo
 echo "=== Try changing the external data file ==="
 echo
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 8b3091a412..5d009867a2 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -498,6 +498,11 @@ Format specific information:
     corrupt: false
 No errors were found on the image.
 
+=== Testing version downgrade with extended L2 entries ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+qemu-img: Cannot downgrade an image with incompatible features 0x10 set
+
 === Try changing the external data file ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-- 
2.20.1


