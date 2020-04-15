Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B373C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 19:03:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E69ED20768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 19:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="iXnGv/q0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69ED20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOnKI-000698-2c
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 15:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55580)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jOnJ9-0005cZ-AY
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 15:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jOnJ7-0003Yb-Ue
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 15:02:47 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:49459)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jOnJ7-0003Ps-BS; Wed, 15 Apr 2020 15:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=KfYvThIihR3Lk8FkZLDUEk5qUchvsn1nH/dYX8v+CTg=; 
 b=iXnGv/q0ocm1qMoppKBHlj9ypBu8KHvDa8AZCf4RIxm5G8YUZbMrLRHSor8O9i2hz3rhdrF9IXU0dw+spjeC36XiwRdlhScUV7dDlTubBJ08skIWVbWs7MunPHz4NZHc6fNQYBpVufS9YabqRAIcUfCV9Nv2jQVS9l3iRUbPRXKVQsULWc39yK53t1JQVcs7RusoRxBvM0hCI/tKWYVtt5yfPyx8GjkFjDb4ALHwi6AVWVyFksH/RbvOm7Rdh7HVHjmrNV8vQ7AEQHGX2ERS7Pa6gFLYkTHMKyubCRMrt4eSfCgG7SWjbygdVlr5y9At1gtu1zKhoaTDxcbKKe1yyQ==;
Received: from [81.0.35.113] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jOnIn-0005dC-E9; Wed, 15 Apr 2020 21:02:25 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jOnIZ-0005VO-HR; Wed, 15 Apr 2020 21:02:11 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1] qcow2: Don't open images with a backing file and the
 data-file-raw bit
Date: Wed, 15 Apr 2020 21:02:07 +0200
Message-Id: <20200415190207.21118-1-berto@igalia.com>
X-Mailer: git-send-email 2.20.1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Although we cannot create these images with qemu-img it is still
possible to do it using an external tool. QEMU should refuse to open
them until the data-file-raw bit is cleared with 'qemu-img check'.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c              | 39 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/244     | 13 +++++++++++++
 tests/qemu-iotests/244.out | 14 ++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index b524b0c53f..fcc3810391 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -588,16 +588,49 @@ static void qcow2_add_check_result(BdrvCheckResult *out,
     }
 }
 
+static int qcow2_check_header(BlockDriverState *bs, BdrvCheckResult *result,
+                              BdrvCheckMode fix)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int ret;
+
+    if (bs->backing && data_file_is_raw(bs)) {
+        fprintf(stderr, "%s header: data-file-raw cannot be set "
+                "when there is a backing file.\n",
+                fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR in");
+        if (fix & BDRV_FIX_ERRORS) {
+            s->autoclear_features &= ~QCOW2_AUTOCLEAR_DATA_FILE_RAW;
+            ret = qcow2_update_header(bs);
+            if (ret < 0) {
+                result->check_errors++;
+                return ret;
+            }
+            result->corruptions_fixed++;
+        } else {
+            result->corruptions++;
+        }
+    }
+
+    return 0;
+}
+
 static int coroutine_fn qcow2_co_check_locked(BlockDriverState *bs,
                                               BdrvCheckResult *result,
                                               BdrvCheckMode fix)
 {
+    BdrvCheckResult header_res = {};
     BdrvCheckResult snapshot_res = {};
     BdrvCheckResult refcount_res = {};
     int ret;
 
     memset(result, 0, sizeof(*result));
 
+    ret = qcow2_check_header(bs, &header_res, fix);
+    qcow2_add_check_result(result, &header_res, false);
+    if (ret < 0) {
+        return ret;
+    }
+
     ret = qcow2_check_read_snapshot_table(bs, &snapshot_res, fix);
     if (ret < 0) {
         qcow2_add_check_result(result, &snapshot_res, false);
@@ -1604,6 +1637,12 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
 
     /* read the backing file name */
     if (header.backing_file_offset != 0) {
+        if (data_file_is_raw(bs) && (!(flags & BDRV_O_CHECK))) {
+            error_setg(errp, "data-file-raw cannot be set when "
+                       "there is a backing file");
+            ret = -EINVAL;
+            goto fail;
+        }
         len = header.backing_file_size;
         if (len > MIN(1023, s->cluster_size - header.backing_file_offset) ||
             len >= sizeof(bs->backing_file)) {
diff --git a/tests/qemu-iotests/244 b/tests/qemu-iotests/244
index 2ec1815e6f..159941acd4 100755
--- a/tests/qemu-iotests/244
+++ b/tests/qemu-iotests/244
@@ -211,6 +211,19 @@ $QEMU_IMG amend -f $IMGFMT -o "data_file=blkdebug::$TEST_IMG.data" "$TEST_IMG"
 $QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n -C "$TEST_IMG.src" "$TEST_IMG"
 $QEMU_IMG compare -f $IMGFMT -F $IMGFMT "$TEST_IMG.src" "$TEST_IMG"
 
+echo
+echo "=== Using and repairing an image with backing file and the data_file_raw bit ==="
+echo
+
+# Create an image with a backing file and an external data file
+TEST_IMG_FILE="$TEST_IMG.base" _make_test_img 1M
+_make_test_img -o "data_file=$TEST_IMG.data" -b "$TEST_IMG.base"
+# Set 'data_file_raw' directly on the header (qemu-img amend won't let us)
+poke_file "$TEST_IMG" 95 "\x02"
+# Trying to open the image should produce an error
+$QEMU_IMG info "$TEST_IMG" 2>&1 | _filter_testdir
+_check_test_img -r all
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/244.out b/tests/qemu-iotests/244.out
index 56329deb4b..cab367dfb5 100644
--- a/tests/qemu-iotests/244.out
+++ b/tests/qemu-iotests/244.out
@@ -128,4 +128,18 @@ Offset          Length          Mapped to       File
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data
 Images are identical.
 Images are identical.
+
+=== Using and repairing an image with backing file and the data_file_raw bit ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=1048576
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base data_file=TEST_DIR/t.IMGFMT.data
+qemu-img: Could not open 'TEST_DIR/t.qcow2': data-file-raw cannot be set when there is a backing file
+Repairing header: data-file-raw cannot be set when there is a backing file.
+The following inconsistencies were found and repaired:
+
+    0 leaked clusters
+    1 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
 *** done
-- 
2.20.1


