Received: from eggs.gnu.org ([2001:4830:134:3::10]:58835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKLV-0002i8-MV
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:23:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKLS-0005lG-CV
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:23:25 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Feb 2017 18:22:23 +0100
Message-Id: <1487006583-24350-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 01/41] block: Attach bs->file only during
 .bdrv_open()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

The way that attaching bs->file worked was a bit unusual in that it was
the only child that would be attached to a node which is not opened yet.
Because of this, the block layer couldn't know yet which permissions the
driver would eventually need.

This patch moves the point where bs->file is attached to the beginning
of the individual .bdrv_open() implementations, so drivers already know
what they are going to do with the child. This is also more consistent
with how driver-specific children work.

bdrv_open() still needs its own BdrvChild to perform image probing, but
instead of directly assigning this BdrvChild to the BDS, it becomes a
temporary one and the node name is passed as an option to the drivers,
so that they can simply use bdrv_open_child() to create another
reference for their own use.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c                       | 34 +++++++++++++++++++++++-----------
 block/bochs.c                 |  6 ++++++
 block/cloop.c                 |  6 ++++++
 block/crypto.c                |  6 ++++++
 block/dmg.c                   |  6 ++++++
 block/parallels.c             |  6 ++++++
 block/qcow.c                  |  6 ++++++
 block/qcow2.c                 | 18 +++++++++++++++---
 block/qed.c                   | 18 +++++++++++++++---
 block/raw-format.c            |  6 ++++++
 block/replication.c           |  6 ++++++
 block/vdi.c                   |  6 ++++++
 block/vhdx.c                  |  6 ++++++
 block/vmdk.c                  |  6 ++++++
 block/vpc.c                   |  6 ++++++
 tests/qemu-iotests/051.out    |  4 ++--
 tests/qemu-iotests/051.pc.out |  4 ++--
 17 files changed, 129 insertions(+), 21 deletions(-)

diff --git a/block.c b/block.c
index 743c349..0618f4b 100644
--- a/block.c
+++ b/block.c
@@ -1103,13 +1103,6 @@ static int bdrv_open_common(BlockDriverState *bs, BdrvChild *file,
         assert(!drv->bdrv_needs_filename || filename != NULL);
         ret = drv->bdrv_file_open(bs, options, open_flags, &local_err);
     } else {
-        if (file == NULL) {
-            error_setg(errp, "Can't use '%s' as a block driver for the "
-                       "protocol level", drv->format_name);
-            ret = -EINVAL;
-            goto free_and_fail;
-        }
-        bs->file = file;
         ret = drv->bdrv_open(bs, options, open_flags, &local_err);
     }
 
@@ -1145,7 +1138,6 @@ static int bdrv_open_common(BlockDriverState *bs, BdrvChild *file,
     return 0;
 
 free_and_fail:
-    bs->file = NULL;
     g_free(bs->opaque);
     bs->opaque = NULL;
     bs->drv = NULL;
@@ -1368,7 +1360,18 @@ void bdrv_unref_child(BlockDriverState *parent, BdrvChild *child)
     }
 
     if (child->bs->inherits_from == parent) {
-        child->bs->inherits_from = NULL;
+        BdrvChild *c;
+
+        /* Remove inherits_from only when the last reference between parent and
+         * child->bs goes away. */
+        QLIST_FOREACH(c, &parent->children, next) {
+            if (c != child && c->bs == child->bs) {
+                break;
+            }
+        }
+        if (c == NULL) {
+            child->bs->inherits_from = NULL;
+        }
     }
 
     bdrv_root_unref_child(child);
@@ -1789,13 +1792,19 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
         qdict_del(options, "backing");
     }
 
-    /* Open image file without format layer */
+    /* Open image file without format layer. This BdrvChild is only used for
+     * probing, the block drivers will do their own bdrv_open_child() for the
+     * same BDS, which is why we put the node name back into options. */
     if ((flags & BDRV_O_PROTOCOL) == 0) {
         file = bdrv_open_child(filename, options, "file", bs,
                                &child_file, true, &local_err);
         if (local_err) {
             goto fail;
         }
+        if (file != NULL) {
+            qdict_put(options, "file",
+                      qstring_from_str(bdrv_get_node_name(file->bs)));
+        }
     }
 
     /* Image format probing */
@@ -1835,7 +1844,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
         goto fail;
     }
 
-    if (file && (bs->file != file)) {
+    if (file) {
         bdrv_unref_child(bs, file);
         file = NULL;
     }
@@ -1901,6 +1910,9 @@ fail:
     if (file != NULL) {
         bdrv_unref_child(bs, file);
     }
+    if (bs->file != NULL) {
+        bdrv_unref_child(bs, bs->file);
+    }
     QDECREF(snapshot_options);
     QDECREF(bs->explicit_options);
     QDECREF(bs->options);
diff --git a/block/bochs.c b/block/bochs.c
index 8c9652e..7dd2ac4 100644
--- a/block/bochs.c
+++ b/block/bochs.c
@@ -104,6 +104,12 @@ static int bochs_open(BlockDriverState *bs, QDict *options, int flags,
     struct bochs_header bochs;
     int ret;
 
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+                               false, errp);
+    if (!bs->file) {
+        return -EINVAL;
+    }
+
     bs->read_only = true; /* no write support yet */
 
     ret = bdrv_pread(bs->file, 0, &bochs, sizeof(bochs));
diff --git a/block/cloop.c b/block/cloop.c
index 7b75f7e..877c9b0 100644
--- a/block/cloop.c
+++ b/block/cloop.c
@@ -66,6 +66,12 @@ static int cloop_open(BlockDriverState *bs, QDict *options, int flags,
     uint32_t offsets_size, max_compressed_block_size = 1, i;
     int ret;
 
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+                               false, errp);
+    if (!bs->file) {
+        return -EINVAL;
+    }
+
     bs->read_only = true;
 
     /* read header */
diff --git a/block/crypto.c b/block/crypto.c
index 7aa7eb5..200fd0b 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -300,6 +300,12 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
     QCryptoBlockOpenOptions *open_opts = NULL;
     unsigned int cflags = 0;
 
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+                               false, errp);
+    if (!bs->file) {
+        return -EINVAL;
+    }
+
     opts = qemu_opts_create(opts_spec, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &local_err);
     if (local_err) {
diff --git a/block/dmg.c b/block/dmg.c
index 58a3ae8..8e387cd 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -413,6 +413,12 @@ static int dmg_open(BlockDriverState *bs, QDict *options, int flags,
     int64_t offset;
     int ret;
 
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+                               false, errp);
+    if (!bs->file) {
+        return -EINVAL;
+    }
+
     block_module_load_one("dmg-bz2");
     bs->read_only = true;
 
diff --git a/block/parallels.c b/block/parallels.c
index 2ccefa7..d3970e1 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -581,6 +581,12 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     Error *local_err = NULL;
     char *buf;
 
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+                               false, errp);
+    if (!bs->file) {
+        return -EINVAL;
+    }
+
     ret = bdrv_pread(bs->file, 0, &ph, sizeof(ph));
     if (ret < 0) {
         goto fail;
diff --git a/block/qcow.c b/block/qcow.c
index fb738fc..a6dfe1a 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -106,6 +106,12 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
     QCowHeader header;
     Error *local_err = NULL;
 
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+                               false, errp);
+    if (!bs->file) {
+        return -EINVAL;
+    }
+
     ret = bdrv_pread(bs->file, 0, &header, sizeof(header));
     if (ret < 0) {
         goto fail;
diff --git a/block/qcow2.c b/block/qcow2.c
index 3e274bd..4684554 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -814,8 +814,8 @@ static int qcow2_update_options(BlockDriverState *bs, QDict *options,
     return ret;
 }
 
-static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
-                      Error **errp)
+static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
+                         Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     unsigned int len, i;
@@ -1205,6 +1205,18 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
     return ret;
 }
 
+static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
+                      Error **errp)
+{
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+                               false, errp);
+    if (!bs->file) {
+        return -EINVAL;
+    }
+
+    return qcow2_do_open(bs, options, flags, errp);
+}
+
 static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
@@ -1785,7 +1797,7 @@ static void qcow2_invalidate_cache(BlockDriverState *bs, Error **errp)
     options = qdict_clone_shallow(bs->options);
 
     flags &= ~BDRV_O_INACTIVE;
-    ret = qcow2_open(bs, options, flags, &local_err);
+    ret = qcow2_do_open(bs, options, flags, &local_err);
     QDECREF(options);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/block/qed.c b/block/qed.c
index 1a7ef0a..1ea5114 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -391,8 +391,8 @@ static void bdrv_qed_drain(BlockDriverState *bs)
     }
 }
 
-static int bdrv_qed_open(BlockDriverState *bs, QDict *options, int flags,
-                         Error **errp)
+static int bdrv_qed_do_open(BlockDriverState *bs, QDict *options, int flags,
+                            Error **errp)
 {
     BDRVQEDState *s = bs->opaque;
     QEDHeader le_header;
@@ -526,6 +526,18 @@ out:
     return ret;
 }
 
+static int bdrv_qed_open(BlockDriverState *bs, QDict *options, int flags,
+                         Error **errp)
+{
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+                               false, errp);
+    if (!bs->file) {
+        return -EINVAL;
+    }
+
+    return bdrv_qed_do_open(bs, options, flags, errp);
+}
+
 static void bdrv_qed_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     BDRVQEDState *s = bs->opaque;
@@ -1603,7 +1615,7 @@ static void bdrv_qed_invalidate_cache(BlockDriverState *bs, Error **errp)
     bdrv_qed_close(bs);
 
     memset(s, 0, sizeof(BDRVQEDState));
-    ret = bdrv_qed_open(bs, NULL, bs->open_flags, &local_err);
+    ret = bdrv_qed_do_open(bs, NULL, bs->open_flags, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         error_prepend(errp, "Could not reopen qed layer: ");
diff --git a/block/raw-format.c b/block/raw-format.c
index 8404a82..30caaa5 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -384,6 +384,12 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
     BDRVRawState *s = bs->opaque;
     int ret;
 
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+                               false, errp);
+    if (!bs->file) {
+        return -EINVAL;
+    }
+
     bs->sg = bs->file->bs->sg;
     bs->supported_write_flags = BDRV_REQ_FUA &
         bs->file->bs->supported_write_flags;
diff --git a/block/replication.c b/block/replication.c
index 729dd12..eff85c7 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -86,6 +86,12 @@ static int replication_open(BlockDriverState *bs, QDict *options,
     const char *mode;
     const char *top_id;
 
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+                               false, errp);
+    if (!bs->file) {
+        return -EINVAL;
+    }
+
     ret = -EINVAL;
     opts = qemu_opts_create(&replication_runtime_opts, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &local_err);
diff --git a/block/vdi.c b/block/vdi.c
index 0aeb940..18b4773 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -363,6 +363,12 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
     int ret;
     Error *local_err = NULL;
 
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+                               false, errp);
+    if (!bs->file) {
+        return -EINVAL;
+    }
+
     logout("\n");
 
     ret = bdrv_read(bs->file, 0, (uint8_t *)&header, 1);
diff --git a/block/vhdx.c b/block/vhdx.c
index 68db9e0..4dc2743 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -898,6 +898,12 @@ static int vhdx_open(BlockDriverState *bs, QDict *options, int flags,
     uint64_t signature;
     Error *local_err = NULL;
 
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+                               false, errp);
+    if (!bs->file) {
+        return -EINVAL;
+    }
+
     s->bat = NULL;
     s->first_visible_write = true;
 
diff --git a/block/vmdk.c b/block/vmdk.c
index 393c84d..9d68ec5 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -943,6 +943,12 @@ static int vmdk_open(BlockDriverState *bs, QDict *options, int flags,
     uint32_t magic;
     Error *local_err = NULL;
 
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+                               false, errp);
+    if (!bs->file) {
+        return -EINVAL;
+    }
+
     buf = vmdk_read_desc(bs->file, 0, errp);
     if (!buf) {
         return -EINVAL;
diff --git a/block/vpc.c b/block/vpc.c
index ed6353d..d0df2a1 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -220,6 +220,12 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
     int disk_type = VHD_DYNAMIC;
     int ret;
 
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+                               false, errp);
+    if (!bs->file) {
+        return -EINVAL;
+    }
+
     opts = qemu_opts_create(&vpc_runtime_opts, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &local_err);
     if (local_err) {
diff --git a/tests/qemu-iotests/051.out b/tests/qemu-iotests/051.out
index 42bf416..7524c62 100644
--- a/tests/qemu-iotests/051.out
+++ b/tests/qemu-iotests/051.out
@@ -225,7 +225,7 @@ Testing: -drive driver=nbd
 QEMU_PROG: -drive driver=nbd: NBD server address missing
 
 Testing: -drive driver=raw
-QEMU_PROG: -drive driver=raw: Can't use 'raw' as a block driver for the protocol level
+QEMU_PROG: -drive driver=raw: A block device must be specified for "file"
 
 Testing: -drive file.driver=file
 QEMU_PROG: -drive file.driver=file: The 'file' block driver requires a file name
@@ -234,7 +234,7 @@ Testing: -drive file.driver=nbd
 QEMU_PROG: -drive file.driver=nbd: NBD server address missing
 
 Testing: -drive file.driver=raw
-QEMU_PROG: -drive file.driver=raw: Can't use 'raw' as a block driver for the protocol level
+QEMU_PROG: -drive file.driver=raw: A block device must be specified for "file"
 
 Testing: -drive foo=bar
 QEMU_PROG: -drive foo=bar: Must specify either driver or file
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index 603bb76..f1669c1 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -319,7 +319,7 @@ Testing: -drive driver=nbd
 QEMU_PROG: -drive driver=nbd: NBD server address missing
 
 Testing: -drive driver=raw
-QEMU_PROG: -drive driver=raw: Can't use 'raw' as a block driver for the protocol level
+QEMU_PROG: -drive driver=raw: A block device must be specified for "file"
 
 Testing: -drive file.driver=file
 QEMU_PROG: -drive file.driver=file: The 'file' block driver requires a file name
@@ -328,7 +328,7 @@ Testing: -drive file.driver=nbd
 QEMU_PROG: -drive file.driver=nbd: NBD server address missing
 
 Testing: -drive file.driver=raw
-QEMU_PROG: -drive file.driver=raw: Can't use 'raw' as a block driver for the protocol level
+QEMU_PROG: -drive file.driver=raw: A block device must be specified for "file"
 
 Testing: -drive foo=bar
 QEMU_PROG: -drive foo=bar: Must specify either driver or file
-- 
1.8.3.1
