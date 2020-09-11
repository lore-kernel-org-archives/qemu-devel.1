Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E42C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:11:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B622226B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="AsPPcU4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B622226B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGjlZ-0005Zq-Gu
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 10:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kGjka-0004OH-1V; Fri, 11 Sep 2020 10:10:04 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:50976)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kGjkW-0000h9-Kw; Fri, 11 Sep 2020 10:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=Uj8oGFGFid1keo97GpxzEqjju8VM0l2+7NhMncE/GrM=; 
 b=AsPPcU4mGQMmt3hBprEZemf94oHY08xaCIuTf/b5CNxRyjiR5sX3OfYG4Pyo6swmfLxy6LaqUKv/OWrYzsd39fW9k/W64L70DoNOX92KBAJ7ZFCp1yS3k2tVKdldtf/LBxuNK4ZKidYpfEQJxnp3TMUuu0muiO0PuDubpn33yB7+qXYjXBBZuiGOLBYSYcs5YRMj71lOf/TIIzAJbqcPjpTM135rMoWZJdDXi7LL8zubvdAGGwwXkD9n7fg7karsvDnL4IcdFsF1TKehblvApe7tdXK//BgrNGxMauIONqU9Xt67uldPXCMmK2HpW3QDGHdCs1ODFGa8YES2Y8K3Hw==;
Received: from [81.0.39.67] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1kGjkR-0004ol-Su; Fri, 11 Sep 2020 16:09:55 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1kGjkF-0000zu-2E; Fri, 11 Sep 2020 16:09:43 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] qcow2: Make preallocate_co() resize the image to the
 correct size
Date: Fri, 11 Sep 2020 16:09:41 +0200
Message-Id: <adeb8b059917b141d5f5b3bd2a016262d3052c79.1599833007.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1599833007.git.berto@igalia.com>
References: <cover.1599833007.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 10:09:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function preallocates metadata structures and then extends the
image to its new size, but that new size calculation is wrong because
it doesn't take into account that the host_offset variable is always
cluster-aligned.

This problem can be reproduced with preallocation=metadata when the
original size is not cluster-aligned but the new size is. In this case
the final image size will be shorter than expected.

   qemu-img create -f qcow2 img.qcow2 31k
   qemu-img resize --preallocation=metadata img.qcow2 128k

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c              |  1 +
 tests/qemu-iotests/125     | 40 +++++++++++++++++++++-----------------
 tests/qemu-iotests/125.out | 28 ++++++++++++++++++++++++--
 3 files changed, 49 insertions(+), 20 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 77c43ce178..1cb5daf39a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3135,6 +3135,7 @@ static int coroutine_fn preallocate_co(BlockDriverState *bs, uint64_t offset,
             error_setg_errno(errp, -ret, "Allocating clusters failed");
             goto out;
         }
+        host_offset += offset_into_cluster(s, offset);
 
         for (m = meta; m != NULL; m = m->next) {
             m->prealloc = true;
diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
index 7cb1c19730..1f35598b2b 100755
--- a/tests/qemu-iotests/125
+++ b/tests/qemu-iotests/125
@@ -168,24 +168,28 @@ done
 $QEMU_IMG create -f raw "$TEST_IMG.base" 128k | _filter_img_create
 $QEMU_IO -c 'write -q -P 1 0 128k' -f raw "$TEST_IMG.base"
 for orig_size in 31k 33k; do
-    echo "--- Resizing image from $orig_size to 96k ---"
-    _make_test_img -F raw -b "$TEST_IMG.base" -o cluster_size=64k "$orig_size"
-    $QEMU_IMG resize -f "$IMGFMT" --preallocation=full "$TEST_IMG" 96k
-    # The first part of the image should contain data from the backing file
-    $QEMU_IO -c "read -q -P 1 0 ${orig_size}" "$TEST_IMG"
-    # The resized part of the image should contain zeroes
-    $QEMU_IO -c "read -q -P 0 ${orig_size} 63k" "$TEST_IMG"
-    # If the image does not have an external data file we can also verify its
-    # actual size. The resized image should have 7 clusters:
-    # header, L1 table, L2 table, refcount table, refcount block, 2 data clusters
-    if ! _get_data_file "$TEST_IMG" > /dev/null; then
-        expected_file_length=$((65536 * 7))
-        file_length=$(stat -c '%s' "$TEST_IMG_FILE")
-        if [ "$file_length" != "$expected_file_length" ]; then
-            echo "ERROR: file length $file_length (expected $expected_file_length)"
-        fi
-    fi
-    echo
+    for dst_size in 96k 128k; do
+        for prealloc in metadata full; do
+            echo "--- Resizing image from $orig_size to $dst_size (preallocation=$prealloc) ---"
+            _make_test_img -F raw -b "$TEST_IMG.base" -o cluster_size=64k "$orig_size"
+            $QEMU_IMG resize -f "$IMGFMT" --preallocation="$prealloc" "$TEST_IMG" "$dst_size"
+            # The first part of the image should contain data from the backing file
+            $QEMU_IO -c "read -q -P 1 0 ${orig_size}" "$TEST_IMG"
+            # The resized part of the image should contain zeroes
+            $QEMU_IO -c "read -q -P 0 ${orig_size} 63k" "$TEST_IMG"
+            # If the image does not have an external data file we can also verify its
+            # actual size. The resized image should have 7 clusters:
+            # header, L1 table, L2 table, refcount table, refcount block, 2 data clusters
+            if ! _get_data_file "$TEST_IMG" > /dev/null; then
+                expected_file_length=$((65536 * 7))
+                file_length=$(stat -c '%s' "$TEST_IMG_FILE")
+                if [ "$file_length" != "$expected_file_length" ]; then
+                    echo "ERROR: file length $file_length (expected $expected_file_length)"
+                fi
+            fi
+            echo
+        done
+    done
 done
 
 # success, all done
diff --git a/tests/qemu-iotests/125.out b/tests/qemu-iotests/125.out
index 7f76f7af20..63a6e9e8a9 100644
--- a/tests/qemu-iotests/125.out
+++ b/tests/qemu-iotests/125.out
@@ -768,11 +768,35 @@ wrote 81920/81920 bytes at offset 2048000
 80 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=raw size=131072
---- Resizing image from 31k to 96k ---
+--- Resizing image from 31k to 96k (preallocation=metadata) ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=31744 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=raw
 Image resized.
 
---- Resizing image from 33k to 96k ---
+--- Resizing image from 31k to 96k (preallocation=full) ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=31744 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=raw
+Image resized.
+
+--- Resizing image from 31k to 128k (preallocation=metadata) ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=31744 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=raw
+Image resized.
+
+--- Resizing image from 31k to 128k (preallocation=full) ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=31744 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=raw
+Image resized.
+
+--- Resizing image from 33k to 96k (preallocation=metadata) ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33792 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=raw
+Image resized.
+
+--- Resizing image from 33k to 96k (preallocation=full) ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33792 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=raw
+Image resized.
+
+--- Resizing image from 33k to 128k (preallocation=metadata) ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33792 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=raw
+Image resized.
+
+--- Resizing image from 33k to 128k (preallocation=full) ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33792 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=raw
 Image resized.
 
-- 
2.20.1


