Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431A0C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEAD02224A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJN7kQJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAD02224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXS97-0000Ty-Nr
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 12:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXS5F-0004pF-1L
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:44:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59263)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXS5C-0003SH-Vg
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603817066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y1VG61HOmNOKvBLwRPPe0Ze4yTQmPSubna6iSdyW97I=;
 b=aJN7kQJGI5OohwNdTwy7G4s6ChGKbsIegFPY0biLt8hs+a+KyC90hoEYb6oeK1oFCUKqqV
 vmTbT0Q7A6PWdsl3lJh4MDERFdbbsm8G6pFJopEUy/1x436RtkbfpJySfXw0gNdS17ti+E
 Zl5Gwj/w8VF1BVBUX03/nqzxpLmXu9E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-Vl4A6PuxO3qqXTOBXTrRuw-1; Tue, 27 Oct 2020 12:44:23 -0400
X-MC-Unique: Vl4A6PuxO3qqXTOBXTrRuw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40886809DEB;
 Tue, 27 Oct 2020 16:44:22 +0000 (UTC)
Received: from localhost (unknown [10.40.193.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C8F195B4A4;
 Tue, 27 Oct 2020 16:44:21 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/2] iotests/291: Filter irrelevant parts of img-info
Date: Tue, 27 Oct 2020 17:44:15 +0100
Message-Id: <20201027164416.144115-2-mreitz@redhat.com>
In-Reply-To: <20201027164416.144115-1-mreitz@redhat.com>
References: <20201027164416.144115-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need to let _img_info emit the format-specific information so we get
the list of bitmaps we want, but we do not need anything but the
bitmaps.  So filter out everything that is irrelevant to us.  (Ideally,
this would be a generalized function in common.filters that takes a list
of things to keep, but that would require implementing an anti-bitmap
filter, which would be hard, and which we do not need here.  So that is
why this function is just a local hack.)

This lets 291 pass with qcow2 options like refcount_bits or data_file
again.

Fixes: 14f16bf9474c860ecc127a66a86961942319f7af
       ("qemu-img: Support bitmap --merge into backing image")
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/291     | 14 +++++++++++---
 tests/qemu-iotests/291.out | 20 --------------------
 2 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/tests/qemu-iotests/291 b/tests/qemu-iotests/291
index 4f837b2056..77fa38f93d 100755
--- a/tests/qemu-iotests/291
+++ b/tests/qemu-iotests/291
@@ -42,6 +42,14 @@ _require_command QEMU_NBD
 # compat=0.10 does not support bitmaps
 _unsupported_imgopts 'compat=0.10'
 
+# Filter irrelevant format-specific information from the qemu-img info
+# output (we only want the bitmaps, basically)
+_filter_irrelevant_img_info()
+{
+    grep -v -e 'compat' -e 'compression type' -e 'data file' -e 'extended l2' \
+            -e 'lazy refcounts' -e 'refcount bits'
+}
+
 echo
 echo "=== Initial image setup ==="
 echo
@@ -79,7 +87,7 @@ echo
 
 # Only bitmaps from the active layer are copied
 $QEMU_IMG convert --bitmaps -O qcow2 "$TEST_IMG.orig" "$TEST_IMG"
-_img_info --format-specific
+_img_info --format-specific | _filter_irrelevant_img_info
 # But we can also merge in bitmaps from other layers.  This test is a bit
 # contrived to cover more code paths, in reality, you could merge directly
 # into b0 without going through tmp
@@ -89,7 +97,7 @@ $QEMU_IMG bitmap --add --merge b0 -b "$TEST_IMG.base" -F $IMGFMT \
 $QEMU_IMG bitmap --merge tmp -f $IMGFMT "$TEST_IMG" b0
 $QEMU_IMG bitmap --remove --image-opts \
     driver=$IMGFMT,file.driver=file,file.filename="$TEST_IMG" tmp
-_img_info --format-specific
+_img_info --format-specific | _filter_irrelevant_img_info
 
 echo
 echo "=== Merge from top layer into backing image ==="
@@ -98,7 +106,7 @@ echo
 $QEMU_IMG rebase -u -F qcow2 -b "$TEST_IMG.base" "$TEST_IMG"
 $QEMU_IMG bitmap --add --merge b2 -b "$TEST_IMG" -F $IMGFMT \
      -f $IMGFMT "$TEST_IMG.base" b3
-_img_info --format-specific --backing-chain
+_img_info --format-specific --backing-chain | _filter_irrelevant_img_info
 
 echo
 echo "=== Check bitmap contents ==="
diff --git a/tests/qemu-iotests/291.out b/tests/qemu-iotests/291.out
index 3990f7aacc..23411c0ff4 100644
--- a/tests/qemu-iotests/291.out
+++ b/tests/qemu-iotests/291.out
@@ -26,9 +26,6 @@ file format: IMGFMT
 virtual size: 10 MiB (10485760 bytes)
 cluster_size: 65536
 Format specific information:
-    compat: 1.1
-    compression type: zlib
-    lazy refcounts: false
     bitmaps:
         [0]:
             flags:
@@ -39,17 +36,12 @@ Format specific information:
                 [0]: auto
             name: b2
             granularity: 65536
-    refcount bits: 16
     corrupt: false
-    extended l2: false
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 10 MiB (10485760 bytes)
 cluster_size: 65536
 Format specific information:
-    compat: 1.1
-    compression type: zlib
-    lazy refcounts: false
     bitmaps:
         [0]:
             flags:
@@ -64,9 +56,7 @@ Format specific information:
             flags:
             name: b0
             granularity: 65536
-    refcount bits: 16
     corrupt: false
-    extended l2: false
 
 === Merge from top layer into backing image ===
 
@@ -77,9 +67,6 @@ cluster_size: 65536
 backing file: TEST_DIR/t.IMGFMT.base
 backing file format: IMGFMT
 Format specific information:
-    compat: 1.1
-    compression type: zlib
-    lazy refcounts: false
     bitmaps:
         [0]:
             flags:
@@ -94,18 +81,13 @@ Format specific information:
             flags:
             name: b0
             granularity: 65536
-    refcount bits: 16
     corrupt: false
-    extended l2: false
 
 image: TEST_DIR/t.IMGFMT.base
 file format: IMGFMT
 virtual size: 10 MiB (10485760 bytes)
 cluster_size: 65536
 Format specific information:
-    compat: 1.1
-    compression type: zlib
-    lazy refcounts: false
     bitmaps:
         [0]:
             flags:
@@ -117,9 +99,7 @@ Format specific information:
                 [0]: auto
             name: b3
             granularity: 65536
-    refcount bits: 16
     corrupt: false
-    extended l2: false
 
 === Check bitmap contents ===
 
-- 
2.26.2


