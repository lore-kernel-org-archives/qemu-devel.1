Received: from eggs.gnu.org ([2001:4830:134:3::10]:52147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpvLe-0004ff-Rk
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:56:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpvLc-0001H3-5X
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:56:25 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 15 Aug 2018 14:55:28 +0200
Message-Id: <20180815125537.10651-13-kwolf@redhat.com>
In-Reply-To: <20180815125537.10651-1-kwolf@redhat.com>
References: <20180815125537.10651-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 12/21] mirror: Fail gracefully for source ==
 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

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
Reviewed-by: Eric Blake <eblake@redhat.com>
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
