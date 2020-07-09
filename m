Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF85C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF672074B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fQEif+7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF672074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtUKR-0001Cb-AH
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 07:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jtUJn-0000cn-H3
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:02:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25836
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jtUJl-0004Ym-8V
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594292536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Os62HM816HWFtB8DH8AfDZzFOxdciiOj3PSe7qaj0C4=;
 b=fQEif+7KD64bEfYST49eOs4H4Xjc5UGJDwlB7sGt4nCMfRQjn58MZ695aXfE4+/FIQNf1W
 pOfWD/+VsTnGszVW9Rj2pSapbe2ION7/HavB70sHYy3E3AEeLDdLFkGCyvh4Re1uSCyH7G
 yqELX47QKaMXxfoh0oQYaHBViHRpG0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-e-e-f9AAMbmDlTLtRGW2Ng-1; Thu, 09 Jul 2020 07:02:14 -0400
X-MC-Unique: e-e-f9AAMbmDlTLtRGW2Ng-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE63E1932480;
 Thu,  9 Jul 2020 11:02:13 +0000 (UTC)
Received: from localhost (ovpn-113-127.ams2.redhat.com [10.36.113.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E67F76FEDA;
 Thu,  9 Jul 2020 11:02:06 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH] iotests: Simplify _filter_img_create() a bit
Date: Thu,  9 Jul 2020 13:02:05 +0200
Message-Id: <20200709110205.310942-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:20:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Not only is it a bit stupid to try to filter multi-line "Formatting"
output (because we only need it for a single test, which can easily be
amended to no longer need it), it is also problematic when there can be
output after a "Formatting" line that we do not want to filter as if it
were part of it.

So rename _filter_img_create to _do_filter_img_create, let it filter
only a single line, and let _filter_img_create loop over all input
lines, calling _do_filter_img_create only on those that match
/^Formatting/ (basically, what _filter_img_create_in_qmp did already).
(And fix 020 to work with that.)

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
Kevin noted that the changes to _filter_img_create broke Eric's patch to
flush the Formatting line out before a potential error message.  This
patch should fix it (and the diff stat is negative, so that's nice).
---
 tests/qemu-iotests/020           | 29 ++++++++-------
 tests/qemu-iotests/020.out       | 13 +------
 tests/qemu-iotests/141           |  2 +-
 tests/qemu-iotests/common.filter | 62 ++++++++++++++------------------
 4 files changed, 45 insertions(+), 61 deletions(-)

diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index 20f8f185d0..b488000cb9 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -115,18 +115,23 @@ TEST_IMG="$TEST_IMG.base" _make_test_img 1M
 # Create an image with a null backing file to which committing will fail (with
 # ENOSPC so we can distinguish the result from some generic EIO which may be
 # generated anywhere in the block layer)
-_make_test_img -b "json:{'driver': '$IMGFMT',
-                         'file': {
-                             'driver': 'blkdebug',
-                             'inject-error': [{
-                                 'event': 'write_aio',
-                                 'errno': 28,
-                                 'once': true
-                             }],
-                             'image': {
-                                 'driver': 'file',
-                                 'filename': '$TEST_IMG.base'
-                             }}}"
+backing="json:{'driver': '$IMGFMT',
+               'file': {
+                   'driver': 'blkdebug',
+                   'inject-error': [{
+                       'event': 'write_aio',
+                       'errno': 28,
+                       'once': true
+                   }],
+                   'image': {
+                       'driver': 'file',
+                       'filename': '$TEST_IMG.base'
+                   }}}"
+
+# Filter out newlines and collapse spaces
+backing=$(echo "$backing" | tr -d '\n' | tr -s ' ')
+
+_make_test_img -b "$backing"
 
 # Just write anything so committing will not be a no-op
 $QEMU_IO -c 'writev 0 64k' "$TEST_IMG" | _filter_qemu_io
diff --git a/tests/qemu-iotests/020.out b/tests/qemu-iotests/020.out
index 4b722b2dd0..4668ac59df 100644
--- a/tests/qemu-iotests/020.out
+++ b/tests/qemu-iotests/020.out
@@ -1079,18 +1079,7 @@ No errors were found on the image.
 Testing failing commit
 
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=1048576
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=json:{'driver': 'IMGFMT',,
-                         'file': {
-                             'driver': 'blkdebug',,
-                             'inject-error': [{
-                                 'event': 'write_aio',,
-                                 'errno': 28,,
-                                 'once': true
-                             }],,
-                             'image': {
-                                 'driver': 'file',,
-                                 'filename': 'TEST_DIR/t.IMGFMT.base'
-                             }}}
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=json:{'driver': 'IMGFMT',, 'file': { 'driver': 'blkdebug',, 'inject-error': [{ 'event': 'write_aio',, 'errno': 28,, 'once': true }],, 'image': { 'driver': 'file',, 'filename': 'TEST_DIR/t.IMGFMT.base' }}}
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-img: Block job failed: No space left on device
diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
index 6d1b7b0d4c..5192d256e3 100755
--- a/tests/qemu-iotests/141
+++ b/tests/qemu-iotests/141
@@ -68,7 +68,7 @@ test_blockjob()
     _send_qemu_cmd $QEMU_HANDLE \
         "$1" \
         "$2" \
-        | _filter_img_create_in_qmp | _filter_qmp_empty_return
+        | _filter_img_create | _filter_qmp_empty_return
 
     # We want this to return an error because the block job is still running
     _send_qemu_cmd $QEMU_HANDLE \
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index d967adc59a..3833206327 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -119,8 +119,21 @@ _filter_actual_image_size()
     $SED -s 's/\("actual-size":\s*\)[0-9]\+/\1SIZE/g'
 }
 
+# Filename filters for qemu-img create
+_filter_img_create_filenames()
+{
+    $SED \
+        -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
+        -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
+        -e "s#$TEST_DIR#TEST_DIR#g" \
+        -e "s#$SOCK_DIR#SOCK_DIR#g" \
+        -e "s#$IMGFMT#IMGFMT#g" \
+        -e 's#nbd:127.0.0.1:[0-9]\\+#TEST_DIR/t.IMGFMT#g' \
+        -e 's#nbd+unix:///\??socket=SOCK_DIR/nbd#TEST_DIR/t.IMGFMT#g'
+}
+
 # replace driver-specific options in the "Formatting..." line
-_filter_img_create()
+_do_filter_img_create()
 {
     # Split the line into the pre-options part ($filename_part, which
     # precedes ", fmt=") and the options part ($options, which starts
@@ -128,23 +141,10 @@ _filter_img_create()
     # (And just echo everything before the first "^Formatting")
     readarray formatting_line < <($SED -e 's/, fmt=/\n/')
 
-    filename_part=''
-    options=''
-    lines=${#formatting_line[@]}
-    for ((i = 0; i < $lines; i++)); do
-        line=${formatting_line[i]}
-        unset formatting_line[i]
-
-        filename_part="$filename_part$line"
+    filename_part=${formatting_line[0]}
+    unset formatting_line[0]
 
-        if echo "$line" | grep -q '^Formatting'; then
-            next_i=$((i + 1))
-            if [ -n "${formatting_line[next_i]}" ]; then
-                options="fmt=${formatting_line[@]}"
-            fi
-            break
-        fi
-    done
+    options="fmt=${formatting_line[@]}"
 
     # Set grep_data_file to '\|data_file' to keep it; make it empty
     # to drop it.
@@ -156,17 +156,7 @@ _filter_img_create()
         grep_data_file=()
     fi
 
-    filename_filters=(
-        -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
-        -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
-        -e "s#$TEST_DIR#TEST_DIR#g" \
-        -e "s#$SOCK_DIR#SOCK_DIR#g" \
-        -e "s#$IMGFMT#IMGFMT#g" \
-        -e 's#nbd:127.0.0.1:[0-9]\\+#TEST_DIR/t.IMGFMT#g' \
-        -e 's#nbd+unix:///\??socket=SOCK_DIR/nbd#TEST_DIR/t.IMGFMT#g'
-    )
-
-    filename_part=$(echo "$filename_part" | $SED "${filename_filters[@]}")
+    filename_part=$(echo "$filename_part" | _filter_img_create_filenames)
 
     # Break the option line before each option (preserving pre-existing
     # line breaks by replacing them by \0 and restoring them at the end),
@@ -179,7 +169,8 @@ _filter_img_create()
         | $SED -e 's/ \([a-z0-9_.-]*\)=/\n\1=/g' \
         | grep -a -e '^fmt' -e '^size' -e '^backing' -e '^preallocation' \
                   -e '^encryption' "${grep_data_file[@]}" \
-        | $SED "${filename_filters[@]}" \
+        | _filter_img_create_filenames \
+        | $SED \
             -e 's/^\(fmt\)/0-\1/' \
             -e 's/^\(size\)/1-\1/' \
             -e 's/^\(backing\)/2-\1/' \
@@ -199,17 +190,16 @@ _filter_img_create()
     fi
 }
 
-# Filter the "Formatting..." line in QMP output (leaving the QMP output
-# untouched)
-# (In contrast to _filter_img_create(), this function does not support
-# multi-line Formatting output)
-_filter_img_create_in_qmp()
+# Filter qemu-img create output:
+# Pipe all ^Formatting lines through _do_filter_img_create, and all
+# other lines through _filter_img_create_filenames
+_filter_img_create()
 {
     while read -r line; do
         if echo "$line" | grep -q '^Formatting'; then
-            echo "$line" | _filter_img_create
+            echo "$line" | _do_filter_img_create
         else
-            echo "$line"
+            echo "$line" | _filter_img_create_filenames
         fi
     done
 }
-- 
2.26.2


