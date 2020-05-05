Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED00C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 17:49:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 897DF206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 17:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gBGMU0Kw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897DF206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW1gl-0003xZ-3J
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 13:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jW1Xg-0006yz-Uv; Tue, 05 May 2020 13:39:42 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:39077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jW1Xd-0008R4-Qb; Tue, 05 May 2020 13:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=mXRRKtlDJDaiCh/vFhiNMUPmvJqfhZk4CUudHo/ocsQ=; 
 b=gBGMU0KwvWzSqvdSSr+jnXS9SjY286RRTBkITqokZj8AKBAXKjsx2NvdiRIry3AT4gOWPYg7/bDspvd5utk7Dlv3pxFGSTXDWlZ/Z23rHhr7FltSlG10Nib70rkIisUP0tp43SOrr12VHLeJM2za7V8OJS3FuDTXP+2LoydNnTzNQCbrwdQ194m4oqdeh0+hTVfKJaB1ridHL81GHKITLDO3mJJ4AWDULq5gi7TP6V+m53YfBngiKDn7N4Gbfb3XShT0NMEMXFPEYYTQMYxbnuFmZlgKk2x077kTxEqa1cqfd5+jnqd5eY84e9IfudwWH4QhMmyu5vWVGbWMxcrqEA==;
Received: from static.160.43.0.81.ibercom.com ([81.0.43.160]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jW1Ws-00025c-Hj; Tue, 05 May 2020 19:38:50 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jW1Wd-00044s-DG; Tue, 05 May 2020 19:38:35 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 29/31] qcow2: Assert that expand_zero_clusters_in_l1() does
 not support subclusters
Date: Tue,  5 May 2020 19:38:29 +0200
Message-Id: <7254228f69935c1802b2a16b2e77121fa6a46d5a.1588699789.git.berto@igalia.com>
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
index d0cf9d52e6..50da38800e 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -2113,6 +2113,9 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
     int ret;
     int i, j;
 
+    /* qcow2_downgrade() is not allowed in images with subclusters */
+    assert(!has_subclusters(s));
+
     slice_size2 = s->l2_slice_size * l2_entry_size(s);
     n_slices = s->cluster_size / slice_size2;
 
@@ -2181,7 +2184,8 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
                 if (cluster_type == QCOW2_CLUSTER_ZERO_PLAIN) {
                     if (!bs->backing) {
                         /* not backed; therefore we can simply deallocate the
-                         * cluster */
+                         * cluster. No need to call set_l2_bitmap(), this
+                         * function doesn't support images with subclusters. */
                         set_l2_entry(s, l2_slice, j, 0);
                         l2_dirty = true;
                         continue;
@@ -2252,6 +2256,8 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
                 } else {
                     set_l2_entry(s, l2_slice, j, offset);
                 }
+                /* No need to call set_l2_bitmap() after set_l2_entry() because
+                 * this function doesn't support images with subclusters. */
                 l2_dirty = true;
             }
 
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index ce285d3084..f746d7ece3 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -268,6 +268,12 @@ $QEMU_IMG amend -o "compat=0.10" "$TEST_IMG"
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
index b7b2533e0a..4c87bb1a3f 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -499,6 +499,11 @@ Format specific information:
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


