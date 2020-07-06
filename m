Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2B6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:06:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E2E2074F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i3GutNzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E2E2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsO0h-0004k3-55
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 06:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jsNzS-0002eh-W7
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:04:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53409
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jsNzR-00040V-8M
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594029884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eVYR/K11nGkGqENmn7dDzzY0OhxOmePiTgzCFoaGOWE=;
 b=i3GutNzmoQCjMACXnO4YarVbixpGu9oTeMza3+Vz33AaXqjRfzknLYWDR/TRPYPmaI+ryS
 aKny38PwSUYrpR6l2J8Kfi8N3YdM84YyUyImF9IzwFJYWAbXipDQQzGmPS9VnzMrK94tVF
 KFMYfOaVMpOHf9DdhNDQ6FMB29GxC7A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-hGfP0s5KPYqPt2d3BKZ01A-1; Mon, 06 Jul 2020 06:04:40 -0400
X-MC-Unique: hGfP0s5KPYqPt2d3BKZ01A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6070518A8222;
 Mon,  6 Jul 2020 10:04:39 +0000 (UTC)
Received: from localhost (ovpn-112-176.ams2.redhat.com [10.36.112.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F1F0E7B41B;
 Mon,  6 Jul 2020 10:04:38 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 02/31] qcow2: Fix preallocation on images with unaligned sizes
Date: Mon,  6 Jul 2020 12:04:03 +0200
Message-Id: <20200706100432.2301919-3-mreitz@redhat.com>
In-Reply-To: <20200706100432.2301919-1-mreitz@redhat.com>
References: <20200706100432.2301919-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:39:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Message-Id: <20200617140036.20311-1-berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c              | 17 ++++++++++++++---
 tests/qemu-iotests/125     | 24 ++++++++++++++++++++++++
 tests/qemu-iotests/125.out |  9 +++++++++
 3 files changed, 47 insertions(+), 3 deletions(-)

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
index d510984045..7cb1c19730 100755
--- a/tests/qemu-iotests/125
+++ b/tests/qemu-iotests/125
@@ -164,6 +164,30 @@ for GROWTH_SIZE in 16 48 80; do
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
+    # If the image does not have an external data file we can also verify its
+    # actual size. The resized image should have 7 clusters:
+    # header, L1 table, L2 table, refcount table, refcount block, 2 data clusters
+    if ! _get_data_file "$TEST_IMG" > /dev/null; then
+        expected_file_length=$((65536 * 7))
+        file_length=$(stat -c '%s' "$TEST_IMG_FILE")
+        if [ "$file_length" != "$expected_file_length" ]; then
+            echo "ERROR: file length $file_length (expected $expected_file_length)"
+        fi
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
2.26.2


