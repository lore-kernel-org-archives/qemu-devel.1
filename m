Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24AFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 09:50:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF21206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 09:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="axKaANN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF21206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jixNP-0001vL-TJ
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 05:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jixJj-0006E6-U7; Wed, 10 Jun 2020 05:46:43 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:45515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jixJi-0002No-1M; Wed, 10 Jun 2020 05:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=P9vZ11NKkCaDVcMicVXwC8MMjREiPzHVeLAEkepras8=; 
 b=axKaANN3z+kuCKmUC7tbvnkL8B1pI0/1ks0XogrMvkg9dVTOQ8fEvxTuUSs6W/ZSBNE+Pw7H4uPyuDNPOb7lPcCkGJ+25Kb4fSYCfvXKG0IE5taJRkpCfPCyU8TpmtLZ74Y2iBcRNGhFkGSLZU+engpmewFeIJ9Scgl5fqbG5tStBOildqrWHiZVIx0d3MUaDC+QdF8eGPMRLO9Y3vs2JC1sLV54lbhJ5o0lGdRMumHALKodDqmIav98lfRugcy35zOdWBHvUQKr2SG7Cxw9U3rNvzyc7crZ2vcbpQR7CRTEixvIIxpDn7+BxmlwV0o8Y6obTORU8IuA2odSO4GK6Q==;
Received: from [81.0.38.199] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jixJL-000379-2w; Wed, 10 Jun 2020 11:46:19 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jixJ7-00013p-PK; Wed, 10 Jun 2020 11:46:05 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qcow2: Fix preallocation on images with unaligned sizes
Date: Wed, 10 Jun 2020 11:46:00 +0200
Message-Id: <20200610094600.4029-1-berto@igalia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 05:46:19
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When resizing an image with qcow2_co_truncate() using the falloc or
full preallocation modes the code assumes that both the old and new
sizes are cluster-aligned.

There are two problems with this:

  1) The calculation of how many clusters are involved does not always
     get the right result.

     Example: creating a 60KB image and resizing it (with
     preallocation=full) to 80KB won't allocate the second cluster.

  2) No copy-on-write is performed, so in the previous example if
     there is a backing file then the first 60KB of the first cluster
     won't be filled with data from the backing file.

This patch fixes both issues.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c              | 17 ++++++++++++++---
 tests/qemu-iotests/125     | 21 +++++++++++++++++++++
 tests/qemu-iotests/125.out |  9 +++++++++
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 0cd2e6757e..e20590c3b7 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4239,8 +4239,8 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
             old_file_size = ROUND_UP(old_file_size, s->cluster_size);
         }
 
-        nb_new_data_clusters = DIV_ROUND_UP(offset - old_length,
-                                            s->cluster_size);
+        nb_new_data_clusters = (ROUND_UP(offset, s->cluster_size) -
+            start_of_cluster(s, old_length)) >> s->cluster_bits;
 
         /* This is an overestimation; we will not actually allocate space for
          * these in the file but just make sure the new refcount structures are
@@ -4317,10 +4317,21 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
             int64_t nb_clusters = MIN(
                 nb_new_data_clusters,
                 s->l2_slice_size - offset_to_l2_slice_index(s, guest_offset));
-            QCowL2Meta allocation = {
+            unsigned cow_start_length = offset_into_cluster(s, guest_offset);
+            QCowL2Meta allocation;
+            guest_offset = start_of_cluster(s, guest_offset);
+            allocation = (QCowL2Meta) {
                 .offset       = guest_offset,
                 .alloc_offset = host_offset,
                 .nb_clusters  = nb_clusters,
+                .cow_start    = {
+                    .offset       = 0,
+                    .nb_bytes     = cow_start_length,
+                },
+                .cow_end      = {
+                    .offset       = nb_clusters << s->cluster_bits,
+                    .nb_bytes     = 0,
+                },
             };
             qemu_co_queue_init(&allocation.dependent_requests);
 
diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
index d510984045..5c249b4b23 100755
--- a/tests/qemu-iotests/125
+++ b/tests/qemu-iotests/125
@@ -164,6 +164,27 @@ for GROWTH_SIZE in 16 48 80; do
 done
 done
 
+# Test image resizing using preallocation and unaligned offsets
+$QEMU_IMG create -f raw "$TEST_IMG.base" 128k | _filter_img_create
+$QEMU_IO -c 'write -q -P 1 0 128k' -f raw "$TEST_IMG.base"
+for orig_size in 31k 33k; do
+    echo "--- Resizing image from $orig_size to 96k ---"
+    _make_test_img -F raw -b "$TEST_IMG.base" -o cluster_size=64k "$orig_size"
+    $QEMU_IMG resize -f "$IMGFMT" --preallocation=full "$TEST_IMG" 96k
+    # The first part of the image should contain data from the backing file
+    $QEMU_IO -c "read -q -P 1 0 ${orig_size}" "$TEST_IMG"
+    # The resized part of the image should contain zeroes
+    $QEMU_IO -c "read -q -P 0 ${orig_size} 63k" "$TEST_IMG"
+    # The resized image should have 7 clusters:
+    # header, L1 table, L2 table, refcount table, refcount block, 2 data clusters
+    expected_file_length=$((65536 * 7))
+    file_length=$(stat -c '%s' "$TEST_IMG_FILE")
+    if [ "$file_length" != "$expected_file_length" ]; then
+        echo "ERROR: file length $file_length (expected $expected_file_length)"
+    fi
+    echo
+done
+
 # success, all done
 echo '*** done'
 rm -f $seq.full
diff --git a/tests/qemu-iotests/125.out b/tests/qemu-iotests/125.out
index 596905f533..7f76f7af20 100644
--- a/tests/qemu-iotests/125.out
+++ b/tests/qemu-iotests/125.out
@@ -767,4 +767,13 @@ wrote 2048000/2048000 bytes at offset 0
 wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=raw size=131072
+--- Resizing image from 31k to 96k ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=31744 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=raw
+Image resized.
+
+--- Resizing image from 33k to 96k ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33792 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=raw
+Image resized.
+
 *** done
-- 
2.20.1


