Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C728C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 01:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 799BB2071A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 01:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C68+zgEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799BB2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKWkp-00019n-9v
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 21:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kKWij-00008o-TW
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 21:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kKWii-0003nQ-0e
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 21:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600736626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OCXmMtbTF3ll79L9Xg/4c0+B6MEqQlhUBjOo1NIMscE=;
 b=C68+zgEsds9Xju9tdkLKKU22Lo3b7tR4dmmoUorAJfU8MebpB9W2+K6aeQA3gaFCMjNYVf
 CzbqPMXGditxlgmm/pwoFcgcoVMnnuG9nGUpT3NGRjbcOm06xoiZHs90ttncPjI4HmSyHQ
 5W/8B5vDXc54omvDWDfkX3foH2Tx9U4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-MIW_xllxNh-JZkOy-6XWHw-1; Mon, 21 Sep 2020 21:03:41 -0400
X-MC-Unique: MIW_xllxNh-JZkOy-6XWHw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F113107464B;
 Tue, 22 Sep 2020 01:03:40 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-127.phx2.redhat.com [10.3.113.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 945CF5DA30;
 Tue, 22 Sep 2020 01:03:39 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] qemu-img: Support bitmap --merge into backing image
Date: Mon, 21 Sep 2020 20:03:35 -0500
Message-Id: <20200922010335.1578850-2-eblake@redhat.com>
In-Reply-To: <20200922010335.1578850-1-eblake@redhat.com>
References: <20200922010335.1578850-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eyal Shenitzky <eshenitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If you have the chain 'base.qcow2 <- top.qcow2' and want to merge a
bitmap from top into base, qemu-img was failing with:

qemu-img: Could not open 'top.qcow2': Could not open backing file: Failed to get shared "write" lock
Is another process using the image [base.qcow2]?

The easiest fix is to not open the entire backing chain of either
image (source or destination); after all, the point of 'qemu-img
bitmap' is solely to manipulate bitmaps directly within a single qcow2
image, and this is made more precise if we don't pay attention to
other images in the chain that may happen to have a bitmap by the same
name.

However, note that on a case-by-case analysis, there _are_ times where
we treat it as a feature that we can access a bitmap from a backing
layer in association with an overlay BDS.  A demonstration of this is
using NBD to expose both an overlay BDS (for constant contents) and a
bitmap (for learning which blocks are interesting) during an
incremental backup:

Base <- Active <- Temporary
          \--block job ->/

where Temporary is being fed by a backup 'sync=none' job.  When
exposing Temporary over NBD, referring to a bitmap that lives only in
Active is less effort than having to copy a bitmap into Temporary [1].
So the testsuite additions in this patch check both where bitmaps get
allocated (the qemu-img info output), and that qemu-nbd is indeed able
to access a bitmap inherited from the backing chain since it is a
different use case than 'qemu-img bitmap'.

[1] Full disclosure: prior to the recent commit 374eedd1c4 and
friends, we were NOT able to see bitmaps through filters, which meant
that we actually did not have nice clean semantics for uniformly being
able to pick up bitmaps from anywhere in the backing chain (seen as a
change in behavior between qemu 4.1 and 4.2 at commit 00e30f05de, when
block-copy swapped from a one-off to a filter).  Which means libvirt
was already coded to copy bitmaps around for the sake of older qemu,
even though modern qemu no longer needs it.  Oh well.

Fixes: http://bugzilla.redhat.com/1877209
Reported-by: Eyal Shenitzky <eshenitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200914191009.644842-1-eblake@redhat.com>
[eblake: more commit message tweaks, per Max Reitz review]
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qemu-img.c                 | 11 ++++++--
 tests/qemu-iotests/291     | 12 ++++++++
 tests/qemu-iotests/291.out | 56 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 1d8c5cd778c0..d79c6ffa2e49 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4779,14 +4779,19 @@ static int img_bitmap(int argc, char **argv)
     filename = argv[optind];
     bitmap = argv[optind + 1];

-    blk = img_open(image_opts, filename, fmt, BDRV_O_RDWR, false, false,
-                   false);
+    /*
+     * No need to open backing chains; we will be manipulating bitmaps
+     * directly in this image without reference to image contents.
+     */
+    blk = img_open(image_opts, filename, fmt, BDRV_O_RDWR | BDRV_O_NO_BACKING,
+                   false, false, false);
     if (!blk) {
         goto out;
     }
     bs = blk_bs(blk);
     if (src_filename) {
-        src = img_open(false, src_filename, src_fmt, 0, false, false, false);
+        src = img_open(false, src_filename, src_fmt, BDRV_O_NO_BACKING,
+                       false, false, false);
         if (!src) {
             goto out;
         }
diff --git a/tests/qemu-iotests/291 b/tests/qemu-iotests/291
index 1e0bb76959bb..4f837b205655 100755
--- a/tests/qemu-iotests/291
+++ b/tests/qemu-iotests/291
@@ -91,6 +91,15 @@ $QEMU_IMG bitmap --remove --image-opts \
     driver=$IMGFMT,file.driver=file,file.filename="$TEST_IMG" tmp
 _img_info --format-specific

+echo
+echo "=== Merge from top layer into backing image ==="
+echo
+
+$QEMU_IMG rebase -u -F qcow2 -b "$TEST_IMG.base" "$TEST_IMG"
+$QEMU_IMG bitmap --add --merge b2 -b "$TEST_IMG" -F $IMGFMT \
+     -f $IMGFMT "$TEST_IMG.base" b3
+_img_info --format-specific --backing-chain
+
 echo
 echo "=== Check bitmap contents ==="
 echo
@@ -107,6 +116,9 @@ $QEMU_IMG map --output=json --image-opts \
 nbd_server_start_unix_socket -r -f qcow2 -B b2 "$TEST_IMG"
 $QEMU_IMG map --output=json --image-opts \
     "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b2" | _filter_qemu_img_map
+nbd_server_start_unix_socket -r -f qcow2 -B b3 "$TEST_IMG"
+$QEMU_IMG map --output=json --image-opts \
+    "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b3" | _filter_qemu_img_map

 # success, all done
 echo '*** done'
diff --git a/tests/qemu-iotests/291.out b/tests/qemu-iotests/291.out
index ee89a728855f..3990f7aacc7b 100644
--- a/tests/qemu-iotests/291.out
+++ b/tests/qemu-iotests/291.out
@@ -68,6 +68,59 @@ Format specific information:
     corrupt: false
     extended l2: false

+=== Merge from top layer into backing image ===
+
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 10 MiB (10485760 bytes)
+cluster_size: 65536
+backing file: TEST_DIR/t.IMGFMT.base
+backing file format: IMGFMT
+Format specific information:
+    compat: 1.1
+    compression type: zlib
+    lazy refcounts: false
+    bitmaps:
+        [0]:
+            flags:
+            name: b1
+            granularity: 524288
+        [1]:
+            flags:
+                [0]: auto
+            name: b2
+            granularity: 65536
+        [2]:
+            flags:
+            name: b0
+            granularity: 65536
+    refcount bits: 16
+    corrupt: false
+    extended l2: false
+
+image: TEST_DIR/t.IMGFMT.base
+file format: IMGFMT
+virtual size: 10 MiB (10485760 bytes)
+cluster_size: 65536
+Format specific information:
+    compat: 1.1
+    compression type: zlib
+    lazy refcounts: false
+    bitmaps:
+        [0]:
+            flags:
+                [0]: auto
+            name: b0
+            granularity: 65536
+        [1]:
+            flags:
+                [0]: auto
+            name: b3
+            granularity: 65536
+    refcount bits: 16
+    corrupt: false
+    extended l2: false
+
 === Check bitmap contents ===

 [{ "start": 0, "length": 3145728, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
@@ -79,4 +132,7 @@ Format specific information:
 [{ "start": 0, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
 { "start": 2097152, "length": 1048576, "depth": 0, "zero": false, "data": false},
 { "start": 3145728, "length": 7340032, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
+[{ "start": 0, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 2097152, "length": 1048576, "depth": 0, "zero": false, "data": false},
+{ "start": 3145728, "length": 7340032, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
 *** done
-- 
2.28.0


