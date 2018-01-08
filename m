Received: from eggs.gnu.org ([2001:4830:134:3::10]:37411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eYSLa-0007kd-W7
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 02:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eYSLa-0004wo-2F
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 02:59:55 -0500
From: Fam Zheng <famz@redhat.com>
Date: Mon,  8 Jan 2018 15:59:35 +0800
Message-Id: <20180108075935.23690-3-famz@redhat.com>
In-Reply-To: <20180108075935.23690-1-famz@redhat.com>
References: <20180108075935.23690-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] qemu-img: info: try -U automatically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

The error message we had didn't have a hint about "-U" when locking the
image failed, which is not friendly. Also it is imaginable that the
reaction to that error by the user would be a retry with '-U'.

So the reason we require "-U" for "qemu-img info" if the image is used
is to raise the awareness about what could be wrong. A warning would do
just fine, especially since it is a little more informative.

The test case reference output is updated accordingly.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qemu-img.c                 | 14 ++++++++++++++
 tests/qemu-iotests/153.out |  3 +--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 828e3b3b88..ec71959632 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2605,6 +2605,20 @@ static int img_info(int argc, char **argv)
 
     list = collect_image_info_list(image_opts, filename, fmt, chain,
                                    force_share, &local_err);
+    if (!list && !force_share) {
+        Error *local_err2 = NULL;
+        list = collect_image_info_list(image_opts, filename, fmt, chain,
+                                       true, &local_err2);
+        if (list) {
+            warn_report("--force-share (-U) is not used but it "
+                         "seems the image is attached to a running guest; "
+                         "the information may be inaccurate if it is being "
+                         "updated");
+            error_free(local_err);
+        } else {
+            error_free(local_err2);
+        }
+    }
     if (!list) {
         error_reportf_err(local_err, "Could not open '%s': ", filename);
         return 1;
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
index 5b917b177c..cbfdf242a8 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -41,8 +41,7 @@ Is another process using the image?
 no file open, try 'help open'
 
 _qemu_img_wrapper info TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock
-Is another process using the image?
+qemu-img: warning: --force-share (-U) is not used but it seems the image is attached to a running guest; the information may be inaccurate if it is being updated
 
 _qemu_img_wrapper check TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" lock
-- 
2.14.3
