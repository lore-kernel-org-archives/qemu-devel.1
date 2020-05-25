Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006B9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 18:17:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB2F2071C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 18:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QY6LIkS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB2F2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdHek-0007wV-VY
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 14:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jdHXs-0003xb-O3; Mon, 25 May 2020 14:09:52 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:50992)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jdHXq-0007pf-2W; Mon, 25 May 2020 14:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=Oe86ilax3C8jctFM722sy6VnDUpDOutRe3DDBEhiVz4=; 
 b=QY6LIkS+kqitLscv5WV1Z8J+dlpTv9FbMlUS2a5Vt+NpBVLmMooAZVyghjmzrN0lhjmw8wJRTneBWPBO34RaG3qihoy97Z6lCp/hhHl/Uu5kW+AUFkZrvoOCtP6UcfWRsqqLTIcbdwDVgZ1AVh5BiwrvsSHBckKkW6K9EuAcIQK4PLDKXxU2mrNAEtvw8niAkH2g41uhy/SzOF4qBpeUcZig/yQomTvHHytLKaxDMkUHR03XjUAjAdtVBhShXTVndkKlglG+vKOncw6uxr++NlPNN7Tby4D+CyG6qkcgCPpC8pmLlD3pYr/XzhEhzbwTDJG1gQFnJVeLD07GfIIvzg==;
Received: from [81.0.38.199] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jdHXP-00088l-FL; Mon, 25 May 2020 20:09:23 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jdHXA-0002Nq-Fo; Mon, 25 May 2020 20:09:08 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 31/32] qcow2: Assert that expand_zero_clusters_in_l1() does
 not support subclusters
Date: Mon, 25 May 2020 20:08:56 +0200
Message-Id: <46c7f6775d80ad10d791c94cf49e402858466b58.1590429902.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1590429901.git.berto@igalia.com>
References: <cover.1590429901.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 14:09:23
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

This function is only used by qcow2_expand_zero_clusters() to
downgrade a qcow2 image to a previous version. It is however not
possible to downgrade an image with extended L2 entries because older
versions of qcow2 do not have this feature.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2-cluster.c      | 8 +++++++-
 tests/qemu-iotests/061     | 6 ++++++
 tests/qemu-iotests/061.out | 5 +++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 1641976028..2ceeb22f29 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -2157,6 +2157,9 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
     int ret;
     int i, j;
 
+    /* qcow2_downgrade() is not allowed in images with subclusters */
+    assert(!has_subclusters(s));
+
     slice_size2 = s->l2_slice_size * l2_entry_size(s);
     n_slices = s->cluster_size / slice_size2;
 
@@ -2225,7 +2228,8 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
                 if (cluster_type == QCOW2_CLUSTER_ZERO_PLAIN) {
                     if (!bs->backing) {
                         /* not backed; therefore we can simply deallocate the
-                         * cluster */
+                         * cluster. No need to call set_l2_bitmap(), this
+                         * function doesn't support images with subclusters. */
                         set_l2_entry(s, l2_slice, j, 0);
                         l2_dirty = true;
                         continue;
@@ -2296,6 +2300,8 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
                 } else {
                     set_l2_entry(s, l2_slice, j, offset);
                 }
+                /* No need to call set_l2_bitmap() after set_l2_entry() because
+                 * this function doesn't support images with subclusters. */
                 l2_dirty = true;
             }
 
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index 10eb243164..23add2dfe3 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -303,6 +303,12 @@ $QEMU_IMG amend -o "compat=0.10" "$TEST_IMG"
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
index 39812d8cf8..c1acdbd751 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -528,6 +528,11 @@ Format specific information:
     extended l2: false
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


