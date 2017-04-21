Received: from eggs.gnu.org ([2001:4830:134:3::10]:51605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d1Ytk-0004uu-Ow
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d1Ytj-0002Qo-Ij
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:46:56 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Fri, 21 Apr 2017 09:46:37 -0400
Message-Id: <20170421134644.10239-6-jcody@redhat.com>
In-Reply-To: <20170421134644.10239-1-jcody@redhat.com>
References: <20170421134644.10239-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 05/12] block: do not set BDS read_only if
 copy_on_read enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org

A few block drivers will set the BDS read_only flag from their
.bdrv_open() function.  This means the bs->read_only flag could
be set after we enable copy_on_read, as the BDRV_O_COPY_ON_READ
flag check occurs prior to the call to bdrv->bdrv_open().

This adds an error return to bdrv_set_read_only(), and an error will be
return if we try to set the BDS to read_only while copy_on_read is
enabled.

This patch also changes the behavior of vvfat.  Before, vvfat could
override the drive 'readonly' flag with its own, internal 'rw' flag.

For instance, this -drive parameter would result in a writable image:

"-drive format=vvfat,dir=/tmp/vvfat,rw,if=virtio,readonly=on"

This is not correct.  Now, attempting to use the above -drive parameter
will result in an error (i.e., 'rw' is incompatible with 'readonly=on').

Signed-off-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 0c5b4c1cc2c651471b131f21376dfd5ea24d2196.1491597120.git.jcody@redhat.com
---
 block.c               | 10 +++++++++-
 block/bochs.c         |  5 ++++-
 block/cloop.c         |  5 ++++-
 block/dmg.c           |  6 +++++-
 block/rbd.c           | 11 ++++++++++-
 block/vvfat.c         | 19 +++++++++++++++----
 include/block/block.h |  2 +-
 7 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index 25a4cfd..4766b8a 100644
--- a/block.c
+++ b/block.c
@@ -192,9 +192,17 @@ void path_combine(char *dest, int dest_size,
     }
 }
 
-void bdrv_set_read_only(BlockDriverState *bs, bool read_only)
+int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp)
 {
+    /* Do not set read_only if copy_on_read is enabled */
+    if (bs->copy_on_read && read_only) {
+        error_setg(errp, "Can't set node '%s' to r/o with copy-on-read enabled",
+                   bdrv_get_device_or_node_name(bs));
+        return -EINVAL;
+    }
+
     bs->read_only = read_only;
+    return 0;
 }
 
 void bdrv_get_full_backing_filename_from_filename(const char *backed,
diff --git a/block/bochs.c b/block/bochs.c
index bdc2831..a759b6e 100644
--- a/block/bochs.c
+++ b/block/bochs.c
@@ -110,7 +110,10 @@ static int bochs_open(BlockDriverState *bs, QDict *options, int flags,
         return -EINVAL;
     }
 
-    bdrv_set_read_only(bs, true); /* no write support yet */
+    ret = bdrv_set_read_only(bs, true, errp); /* no write support yet */
+    if (ret < 0) {
+        return ret;
+    }
 
     ret = bdrv_pread(bs->file, 0, &bochs, sizeof(bochs));
     if (ret < 0) {
diff --git a/block/cloop.c b/block/cloop.c
index 11f17c8..d6597fc 100644
--- a/block/cloop.c
+++ b/block/cloop.c
@@ -72,7 +72,10 @@ static int cloop_open(BlockDriverState *bs, QDict *options, int flags,
         return -EINVAL;
     }
 
-    bdrv_set_read_only(bs, true);
+    ret = bdrv_set_read_only(bs, true, errp);
+    if (ret < 0) {
+        return ret;
+    }
 
     /* read header */
     ret = bdrv_pread(bs->file, 128, &s->block_size, 4);
diff --git a/block/dmg.c b/block/dmg.c
index 27ce4a6..900ae5a 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -419,8 +419,12 @@ static int dmg_open(BlockDriverState *bs, QDict *options, int flags,
         return -EINVAL;
     }
 
+    ret = bdrv_set_read_only(bs, true, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
     block_module_load_one("dmg-bz2");
-    bdrv_set_read_only(bs, true);
 
     s->n_chunks = 0;
     s->offsets = s->lengths = s->sectors = s->sectorcounts = NULL;
diff --git a/block/rbd.c b/block/rbd.c
index 6ad2904..1c43171 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -635,13 +635,22 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         goto failed_shutdown;
     }
 
+    /* rbd_open is always r/w */
     r = rbd_open(s->io_ctx, s->name, &s->image, s->snap);
     if (r < 0) {
         error_setg_errno(errp, -r, "error reading header from %s", s->name);
         goto failed_open;
     }
 
-    bdrv_set_read_only(bs, (s->snap != NULL));
+    /* If we are using an rbd snapshot, we must be r/o, otherwise
+     * leave as-is */
+    if (s->snap != NULL) {
+        r = bdrv_set_read_only(bs, true, &local_err);
+        if (r < 0) {
+            error_propagate(errp, local_err);
+            goto failed_open;
+        }
+    }
 
     qemu_opts_del(opts);
     return 0;
diff --git a/block/vvfat.c b/block/vvfat.c
index d4ce6d7..b509d55 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1156,8 +1156,6 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
 
     s->current_cluster=0xffffffff;
 
-    /* read only is the default for safety */
-    bdrv_set_read_only(bs, true);
     s->qcow = NULL;
     s->qcow_filename = NULL;
     s->fat2 = NULL;
@@ -1169,11 +1167,24 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
     s->sector_count = cyls * heads * secs - (s->first_sectors_number - 1);
 
     if (qemu_opt_get_bool(opts, "rw", false)) {
-        ret = enable_write_target(bs, errp);
+        if (!bdrv_is_read_only(bs)) {
+            ret = enable_write_target(bs, errp);
+            if (ret < 0) {
+                goto fail;
+            }
+        } else {
+            ret = -EPERM;
+            error_setg(errp,
+                       "Unable to set VVFAT to 'rw' when drive is read-only");
+            goto fail;
+        }
+    } else  {
+        /* read only is the default for safety */
+        ret = bdrv_set_read_only(bs, true, &local_err);
         if (ret < 0) {
+            error_propagate(errp, local_err);
             goto fail;
         }
-        bdrv_set_read_only(bs, false);
     }
 
     bs->total_sectors = cyls * heads * secs;
diff --git a/include/block/block.h b/include/block/block.h
index 16eb909..3525590 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -434,7 +434,7 @@ int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
                             int64_t sector_num, int nb_sectors, int *pnum);
 
 bool bdrv_is_read_only(BlockDriverState *bs);
-void bdrv_set_read_only(BlockDriverState *bs, bool read_only);
+int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp);
 bool bdrv_is_sg(BlockDriverState *bs);
 bool bdrv_is_inserted(BlockDriverState *bs);
 int bdrv_media_changed(BlockDriverState *bs);
-- 
2.9.3
