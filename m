Received: from eggs.gnu.org ([2001:4830:134:3::10]:57854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71rC-0002Ve-Qz
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71rB-0007J8-IR
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:42 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  1 Oct 2018 19:18:58 +0200
Message-Id: <20181001171901.11004-21-kwolf@redhat.com>
In-Reply-To: <20181001171901.11004-1-kwolf@redhat.com>
References: <20181001171901.11004-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 20/23] block-backend: Set werror/rerror defaults
 in blk_new()
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

Currently, the default values for werror and rerror have to be set
explicitly with blk_set_on_error() by the callers of blk_new(). The only
caller actually doing this is blockdev_init(), which is called for
BlockBackends created using -drive.

In particular, anonymous BlockBackends created with
-device ...,drive=<node-name> didn't get the correct default set and
instead defaulted to the integer value 0 (= BLOCKDEV_ON_ERROR_REPORT).
This is the intended default for rerror anyway, but the default for
werror should be BLOCKDEV_ON_ERROR_ENOSPC.

Set the defaults in blk_new() instead so that they apply no matter what
way the BlockBackend was created.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 block/block-backend.c      | 3 +++
 tests/qemu-iotests/067.out | 1 +
 2 files changed, 4 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 7b1ec5071b..dc0cd57724 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -325,6 +325,9 @@ BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm)
     blk->shared_perm = shared_perm;
     blk_set_enable_write_cache(blk, true);
 
+    blk->on_read_error = BLOCKDEV_ON_ERROR_REPORT;
+    blk->on_write_error = BLOCKDEV_ON_ERROR_ENOSPC;
+
     block_acct_init(&blk->stats);
 
     notifier_list_init(&blk->remove_bs_notifiers);
diff --git a/tests/qemu-iotests/067.out b/tests/qemu-iotests/067.out
index 2e71cff3ce..b10c71db03 100644
--- a/tests/qemu-iotests/067.out
+++ b/tests/qemu-iotests/067.out
@@ -385,6 +385,7 @@ Testing: -device virtio-scsi -device scsi-cd,id=cd0
 {
     "return": [
         {
+            "io-status": "ok",
             "device": "",
             "locked": false,
             "removable": true,
-- 
2.13.6
