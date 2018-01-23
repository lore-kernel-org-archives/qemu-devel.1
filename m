Received: from eggs.gnu.org ([2001:4830:134:3::10]:57814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edz9r-0003Zb-Ci
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edz9q-0005w8-Br
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:39 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 23 Jan 2018 15:01:48 +0100
Message-Id: <20180123140201.31163-17-kwolf@redhat.com>
In-Reply-To: <20180123140201.31163-1-kwolf@redhat.com>
References: <20180123140201.31163-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 16/29] iotests: Drop format-specific in
 _filter_img_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

_filter_img_info should remove format-specific information, too.  We
already have such a filter in _img_info, and it is very useful for
query-block-named-block-nodes (etc.), too.

However, in 198 we need that information (but we still want the rest of
the filter), so make that filtering optional.  Note that "the rest of
the filter" includes filtering of the test directory, so we can drop the
_filter_testdir from 198 at the same time.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20171123020832.8165-7-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/198           |  6 ++++--
 tests/qemu-iotests/common.filter | 29 ++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
index 34ef666381..a84a058396 100755
--- a/tests/qemu-iotests/198
+++ b/tests/qemu-iotests/198
@@ -91,11 +91,13 @@ $QEMU_IO --object $SECRET0 --object $SECRET1 -c "read -P 0x9 0 $size" --image-op
 
 echo
 echo "== checking image base =="
-$QEMU_IMG info --image-opts $IMGSPECBASE | _filter_img_info | _filter_testdir | sed -e "/^disk size:/ D"
+$QEMU_IMG info --image-opts $IMGSPECBASE | _filter_img_info --format-specific \
+    | sed -e "/^disk size:/ D"
 
 echo
 echo "== checking image layer =="
-$QEMU_IMG info --image-opts $IMGSPECLAYER | _filter_img_info | _filter_testdir | sed -e "/^disk size:/ D"
+$QEMU_IMG info --image-opts $IMGSPECLAYER | _filter_img_info --format-specific \
+    | sed -e "/^disk size:/ D"
 
 
 # success, all done
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index f08248bfd9..cb2be23340 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -140,6 +140,15 @@ _filter_img_create()
 
 _filter_img_info()
 {
+    if [[ "$1" == "--format-specific" ]]; then
+        local format_specific=1
+        shift
+    else
+        local format_specific=0
+    fi
+
+    discard=0
+    regex_json_spec_start='^ *"format-specific": \{'
     sed -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
         -e "s#$TEST_DIR#TEST_DIR#g" \
         -e "s#$IMGFMT#IMGFMT#g" \
@@ -160,7 +169,25 @@ _filter_img_info()
         -e "/block_state_zero: \\(on\\|off\\)/d" \
         -e "/log_size: [0-9]\\+/d" \
         -e "s/iters: [0-9]\\+/iters: 1024/" \
-        -e "s/uuid: [-a-f0-9]\\+/uuid: 00000000-0000-0000-0000-000000000000/"
+        -e "s/uuid: [-a-f0-9]\\+/uuid: 00000000-0000-0000-0000-000000000000/" | \
+    while IFS='' read -r line; do
+        if [[ $format_specific == 1 ]]; then
+            discard=0
+        elif [[ $line == "Format specific information:" ]]; then
+            discard=1
+        elif [[ $line =~ $regex_json_spec_start ]]; then
+            discard=2
+            regex_json_spec_end="^${line%%[^ ]*}\\},? *$"
+        fi
+        if [[ $discard == 0 ]]; then
+            echo "$line"
+        elif [[ $discard == 1 && ! $line ]]; then
+            echo
+            discard=0
+        elif [[ $discard == 2 && $line =~ $regex_json_spec_end ]]; then
+            discard=0
+        fi
+    done
 }
 
 # filter out offsets and file names from qemu-img map; good for both
-- 
2.13.6
