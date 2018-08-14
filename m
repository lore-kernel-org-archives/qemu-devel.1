Received: from eggs.gnu.org ([2001:4830:134:3::10]:60412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpW6N-0007A6-1C
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 05:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpW6M-0005D0-7J
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 05:58:59 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 14 Aug 2018 11:58:47 +0200
Message-Id: <20180814095847.23778-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH] mirror: Fail gracefully for source == target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org

blockdev-mirror with the same node for source and target segfaults
today: A node is in its own backing chain, so mirror_start_job() decides
that this is an active commit. When adding the intermediate nodes with
block_job_add_bdrv(), it starts the iteration through the subchain with
the backing file of source, though, so it never reaches target and
instead runs into NULL at the base.

While we could fix that by starting with source itself, there is no
point in allowing mirroring a node into itself and I wouldn't be
surprised if this caused more problems later.

So just check for this scenario and error out.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c             | 5 +++++
 tests/qemu-iotests/041     | 6 ++++++
 tests/qemu-iotests/041.out | 4 ++--
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index b48c3f8cf5..dd5ca02b09 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1499,6 +1499,11 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
         buf_size = DEFAULT_MIRROR_BUF_SIZE;
     }
 
+    if (bs == target) {
+        error_setg(errp, "Can't mirror node into itself");
+        return;
+    }
+
     /* In the case of active commit, add dummy driver to provide consistent
      * reads on the top, while disabling it in the intermediate nodes, and make
      * the backing chain writable. */
diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index c20ac7da87..9336ab6ff5 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -234,6 +234,12 @@ class TestSingleBlockdev(TestSingleDrive):
         result = self.vm.qmp("blockdev-add", **args)
         self.assert_qmp(result, 'return', {})
 
+    def test_mirror_to_self(self):
+        result = self.vm.qmp(self.qmp_cmd, job_id='job0',
+                             device=self.qmp_target, sync='full',
+                             target=self.qmp_target)
+        self.assert_qmp(result, 'error/class', 'GenericError')
+
     test_large_cluster = None
     test_image_not_found = None
     test_small_buffer2 = None
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index c28b392b87..e071d0b261 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-.....................................................................................
+........................................................................................
 ----------------------------------------------------------------------
-Ran 85 tests
+Ran 88 tests
 
 OK
-- 
2.13.6
