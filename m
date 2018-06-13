Received: from eggs.gnu.org ([2001:4830:134:3::10]:41498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fT7zf-0002ba-16
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fT7zd-0000A3-Vd
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:47:31 -0400
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Wed, 13 Jun 2018 18:47:10 +0300
Message-Id: <20180613154711.12977-2-dplotnikov@virtuozzo.com>
In-Reply-To: <20180613154711.12977-1-dplotnikov@virtuozzo.com>
References: <20180613154711.12977-1-dplotnikov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v0 1/2] block: check for read-only on
 copy-on-read setting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com, eblake@redhat.com, famz@redhat.com, mreitz@redhat.com, stefanha@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, den@virtuozzo.com, rkagan@virtuozzo.com

We should always check whether block device is in the
read-only state before enabling copy-on-read.
The patch embeds the check in the copy-on-read setter.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 block.c               |  4 +---
 block/io.c            | 10 ++++++++--
 block/stream.c        |  5 +++--
 include/block/block.h |  2 +-
 4 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/block.c b/block.c
index 50887087f3..e73fccd397 100644
--- a/block.c
+++ b/block.c
@@ -1370,9 +1370,7 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
     assert(atomic_read(&bs->copy_on_read) == 0);
 
     if (bs->open_flags & BDRV_O_COPY_ON_READ) {
-        if (!bs->read_only) {
-            bdrv_enable_copy_on_read(bs);
-        } else {
+        if (!bdrv_enable_copy_on_read(bs)) {
             error_setg(errp, "Can't use copy-on-read on read-only device");
             ret = -EINVAL;
             goto fail_opts;
diff --git a/block/io.c b/block/io.c
index b7beaeeb9f..6ec008dbdc 100644
--- a/block/io.c
+++ b/block/io.c
@@ -131,9 +131,15 @@ void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
  * use the feature without worrying about clobbering its previous state.
  * Copy-on-read stays enabled until all users have called to disable it.
  */
-void bdrv_enable_copy_on_read(BlockDriverState *bs)
+bool bdrv_enable_copy_on_read(BlockDriverState *bs)
 {
-    atomic_inc(&bs->copy_on_read);
+    if (bs->read_only) {
+        return false;
+    } else {
+        atomic_inc(&bs->copy_on_read);
+    }
+
+    return true;
 }
 
 void bdrv_disable_copy_on_read(BlockDriverState *bs)
diff --git a/block/stream.c b/block/stream.c
index 9264b68a1e..033e24f22c 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -130,8 +130,9 @@ static void coroutine_fn stream_run(void *opaque)
      * backing chain since the copy-on-read operation does not take base into
      * account.
      */
-    if (!base) {
-        bdrv_enable_copy_on_read(bs);
+    if (!base && !bdrv_enable_copy_on_read(bs)) {
+        ret = -EPERM;
+        goto out;
     }
 
     for ( ; offset < len; offset += n) {
diff --git a/include/block/block.h b/include/block/block.h
index e677080c4e..dddfd032f9 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -490,7 +490,7 @@ void *qemu_try_blockalign(BlockDriverState *bs, size_t size);
 void *qemu_try_blockalign0(BlockDriverState *bs, size_t size);
 bool bdrv_qiov_is_aligned(BlockDriverState *bs, QEMUIOVector *qiov);
 
-void bdrv_enable_copy_on_read(BlockDriverState *bs);
+bool bdrv_enable_copy_on_read(BlockDriverState *bs);
 void bdrv_disable_copy_on_read(BlockDriverState *bs);
 
 void bdrv_ref(BlockDriverState *bs);
-- 
2.17.0
