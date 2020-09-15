Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDF1C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 011EB21D1B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JV+29TZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011EB21D1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI8o2-0001wB-21
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 07:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8Ud-00013i-At
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:47:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54473
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8Ua-0004ey-Cg
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600166839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vZ/4iXDyh/GClurwSqIb6dMh22LSvdlpa0SHBWTovlY=;
 b=JV+29TZf2oMuWpXDyyXLTNhQ2e01ZVFlbD/7WVhxoRNc37JJdRK72x31OXKZ3thnHxnFuW
 o10kSSjrjmTUPisjhXwjZHcMYbCJabjFItt3m4W2GLXH09kxf9PIJJ5Tg1S/aycBRMaUUo
 3pZpziF2eiiXWdQ5CnuMRWqQ4uc9Iw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-srlLcSfRNpyb_PyYXah7-A-1; Tue, 15 Sep 2020 06:47:15 -0400
X-MC-Unique: srlLcSfRNpyb_PyYXah7-A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A8601084D69;
 Tue, 15 Sep 2020 10:47:14 +0000 (UTC)
Received: from localhost (ovpn-113-7.ams2.redhat.com [10.36.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC9B35DC1E;
 Tue, 15 Sep 2020 10:47:13 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 20/22] qcow2: Make preallocate_co() resize the image to the
 correct size
Date: Tue, 15 Sep 2020 12:46:25 +0200
Message-Id: <20200915104627.699552-21-mreitz@redhat.com>
In-Reply-To: <20200915104627.699552-1-mreitz@redhat.com>
References: <20200915104627.699552-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:11:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

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
Message-Id: <adeb8b059917b141d5f5b3bd2a016262d3052c79.1599833007.git.berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
[mreitz: Mark compat=0.10 unsupported for iotest 125]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c              |  1 +
 tests/qemu-iotests/125     | 44 ++++++++++++++++++++++----------------
 tests/qemu-iotests/125.out | 28 ++++++++++++++++++++++--
 3 files changed, 53 insertions(+), 20 deletions(-)

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
index 7cb1c19730..5720e86dce 100755
--- a/tests/qemu-iotests/125
+++ b/tests/qemu-iotests/125
@@ -43,6 +43,10 @@ get_image_size_on_host()
 
 _supported_fmt qcow2
 _supported_proto file
+# Growing a file with a backing file (without preallocation=full or
+# =falloc) requires zeroing the newly added area, which is impossible
+# to do quickly for v2 images, and hence is unsupported.
+_unsupported_imgopts 'compat=0.10'
 
 if [ -z "$TEST_IMG_FILE" ]; then
     TEST_IMG_FILE=$TEST_IMG
@@ -168,24 +172,28 @@ done
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
2.26.2


