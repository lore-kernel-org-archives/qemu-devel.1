Received: from eggs.gnu.org ([2001:4830:134:3::10]:54916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDFxj-0001L3-7j
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:31:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDFxh-0004FD-Em
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:31:39 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 10 Nov 2017 21:31:09 +0100
Message-Id: <20171110203111.7666-4-mreitz@redhat.com>
In-Reply-To: <20171110203111.7666-1-mreitz@redhat.com>
References: <20171110203111.7666-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 3/5] block: Guard against NULL bs->drv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>

We currently do not guard everywhere against a NULL bs->drv where we
should be doing so.  Most of the places fixed here just do not care
about that case at all.

Some care implicitly, e.g. through a prior function call to
bdrv_getlength() which would always fail for an ejected BDS.  Add an
assert there to make it more obvious.

Other places seem to care, but do so insufficiently: Freeing clusters in
a qcow2 image is an error-free operation, but it may leave the image in
an unusable state anyway.  Giving qcow2_free_clusters() an error code is
not really viable, it is much easier to note that bs->drv may be NULL
even after a successful driver call.  This concerns bdrv_co_flush(), and
the way the check is added to bdrv_co_pdiscard() (in every iteration
instead of only once).

Finally, some places employ at least an assert(bs->drv); somewhere, that
may be reasonable (such as in the reopen code), but in
bdrv_has_zero_init(), it is definitely not.  Returning 0 there in case
of an ejected BDS saves us much headache instead.

Reported-by: R. Nageswara Sastry <nasastry@in.ibm.com>
Buglink: https://bugs.launchpad.net/qemu/+bug/1728660
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                    | 19 ++++++++++++++++++-
 block/io.c                 | 36 ++++++++++++++++++++++++++++++++++++
 block/qapi.c               |  8 +++++++-
 block/replication.c        | 15 +++++++++++++++
 block/vvfat.c              |  2 +-
 tests/qemu-iotests/060     | 22 ++++++++++++++++++++++
 tests/qemu-iotests/060.out | 31 +++++++++++++++++++++++++++++++
 7 files changed, 130 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index cec4e9a8d6..dce20ed5e7 100644
--- a/block.c
+++ b/block.c
@@ -720,6 +720,10 @@ static int refresh_total_sectors(BlockDriverState *bs, int64_t hint)
 {
     BlockDriver *drv = bs->drv;
 
+    if (!drv) {
+        return -ENOMEDIUM;
+    }
+
     /* Do not attempt drv->bdrv_getlength() on scsi-generic devices */
     if (bdrv_is_sg(bs))
         return 0;
@@ -3431,6 +3435,10 @@ int bdrv_change_backing_file(BlockDriverState *bs,
     BlockDriver *drv = bs->drv;
     int ret;
 
+    if (!drv) {
+        return -ENOMEDIUM;
+    }
+
     /* Backing file format doesn't make sense without a backing file */
     if (backing_fmt && !backing_file) {
         return -EINVAL;
@@ -3916,7 +3924,9 @@ int bdrv_has_zero_init_1(BlockDriverState *bs)
 
 int bdrv_has_zero_init(BlockDriverState *bs)
 {
-    assert(bs->drv);
+    if (!bs->drv) {
+        return 0;
+    }
 
     /* If BS is a copy on write image, it is initialized to
        the contents of the base image, which may not be zeroes.  */
@@ -4245,6 +4255,10 @@ static int bdrv_inactivate_recurse(BlockDriverState *bs,
     BdrvChild *child, *parent;
     int ret;
 
+    if (!bs->drv) {
+        return -ENOMEDIUM;
+    }
+
     if (!setting_flag && bs->drv->bdrv_inactivate) {
         ret = bs->drv->bdrv_inactivate(bs);
         if (ret < 0) {
@@ -4780,6 +4794,9 @@ void bdrv_remove_aio_context_notifier(BlockDriverState *bs,
 int bdrv_amend_options(BlockDriverState *bs, QemuOpts *opts,
                        BlockDriverAmendStatusCB *status_cb, void *cb_opaque)
 {
+    if (!bs->drv) {
+        return -ENOMEDIUM;
+    }
     if (!bs->drv->bdrv_amend_options) {
         return -ENOTSUP;
     }
diff --git a/block/io.c b/block/io.c
index 3d5ef2cabe..4fdf93a014 100644
--- a/block/io.c
+++ b/block/io.c
@@ -853,6 +853,10 @@ static int coroutine_fn bdrv_driver_preadv(BlockDriverState *bs,
 
     assert(!(flags & ~BDRV_REQ_MASK));
 
+    if (!drv) {
+        return -ENOMEDIUM;
+    }
+
     if (drv->bdrv_co_preadv) {
         return drv->bdrv_co_preadv(bs, offset, bytes, qiov, flags);
     }
@@ -894,6 +898,10 @@ static int coroutine_fn bdrv_driver_pwritev(BlockDriverState *bs,
 
     assert(!(flags & ~BDRV_REQ_MASK));
 
+    if (!drv) {
+        return -ENOMEDIUM;
+    }
+
     if (drv->bdrv_co_pwritev) {
         ret = drv->bdrv_co_pwritev(bs, offset, bytes, qiov,
                                    flags & bs->supported_write_flags);
@@ -945,6 +953,10 @@ bdrv_driver_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
 {
     BlockDriver *drv = bs->drv;
 
+    if (!drv) {
+        return -ENOMEDIUM;
+    }
+
     if (!drv->bdrv_co_pwritev_compressed) {
         return -ENOTSUP;
     }
@@ -975,6 +987,10 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
                                     BDRV_REQUEST_MAX_BYTES);
     unsigned int progress = 0;
 
+    if (!drv) {
+        return -ENOMEDIUM;
+    }
+
     /* FIXME We cannot require callers to have write permissions when all they
      * are doing is a read request. If we did things right, write permissions
      * would be obtained anyway, but internally by the copy-on-read code. As
@@ -1291,6 +1307,10 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
                         bs->bl.request_alignment);
     int max_transfer = MIN_NON_ZERO(bs->bl.max_transfer, MAX_BOUNCE_BUFFER);
 
+    if (!drv) {
+        return -ENOMEDIUM;
+    }
+
     assert(alignment % bs->bl.request_alignment == 0);
     head = offset % alignment;
     tail = (offset + bytes) % alignment;
@@ -1397,6 +1417,10 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     uint64_t bytes_remaining = bytes;
     int max_transfer;
 
+    if (!drv) {
+        return -ENOMEDIUM;
+    }
+
     if (bdrv_has_readonly_bitmaps(bs)) {
         return -EPERM;
     }
@@ -1863,6 +1887,8 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
         bytes = n;
     }
 
+    /* Must be non-NULL or bdrv_getlength() would have failed */
+    assert(bs->drv);
     if (!bs->drv->bdrv_co_get_block_status) {
         *pnum = bytes;
         ret = BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED;
@@ -2373,6 +2399,12 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
     }
 
     BLKDBG_EVENT(bs->file, BLKDBG_FLUSH_TO_DISK);
+    if (!bs->drv) {
+        /* bs->drv->bdrv_co_flush() might have ejected the BDS
+         * (even in case of apparent success) */
+        ret = -ENOMEDIUM;
+        goto out;
+    }
     if (bs->drv->bdrv_co_flush_to_disk) {
         ret = bs->drv->bdrv_co_flush_to_disk(bs);
     } else if (bs->drv->bdrv_aio_flush) {
@@ -2542,6 +2574,10 @@ int coroutine_fn bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
             num = max_pdiscard;
         }
 
+        if (!bs->drv) {
+            ret = -ENOMEDIUM;
+            goto out;
+        }
         if (bs->drv->bdrv_co_pdiscard) {
             ret = bs->drv->bdrv_co_pdiscard(bs, offset, num);
         } else {
diff --git a/block/qapi.c b/block/qapi.c
index 7fa2437923..fc10f0a565 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -39,8 +39,14 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
 {
     ImageInfo **p_image_info;
     BlockDriverState *bs0;
-    BlockDeviceInfo *info = g_malloc0(sizeof(*info));
+    BlockDeviceInfo *info;
 
+    if (!bs->drv) {
+        error_setg(errp, "Block device %s is ejected", bs->node_name);
+        return NULL;
+    }
+
+    info = g_malloc0(sizeof(*info));
     info->file                   = g_strdup(bs->filename);
     info->ro                     = bs->read_only;
     info->drv                    = g_strdup(bs->drv->format_name);
diff --git a/block/replication.c b/block/replication.c
index 1c95d673ff..e41e293d2b 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -342,12 +342,24 @@ static void secondary_do_checkpoint(BDRVReplicationState *s, Error **errp)
         return;
     }
 
+    if (!s->active_disk->bs->drv) {
+        error_setg(errp, "Active disk %s is ejected",
+                   s->active_disk->bs->node_name);
+        return;
+    }
+
     ret = s->active_disk->bs->drv->bdrv_make_empty(s->active_disk->bs);
     if (ret < 0) {
         error_setg(errp, "Cannot make active disk empty");
         return;
     }
 
+    if (!s->hidden_disk->bs->drv) {
+        error_setg(errp, "Hidden disk %s is ejected",
+                   s->hidden_disk->bs->node_name);
+        return;
+    }
+
     ret = s->hidden_disk->bs->drv->bdrv_make_empty(s->hidden_disk->bs);
     if (ret < 0) {
         error_setg(errp, "Cannot make hidden disk empty");
@@ -511,6 +523,9 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
             return;
         }
 
+        /* Must be true, or the bdrv_getlength() calls would have failed */
+        assert(s->active_disk->bs->drv && s->hidden_disk->bs->drv);
+
         if (!s->active_disk->bs->drv->bdrv_make_empty ||
             !s->hidden_disk->bs->drv->bdrv_make_empty) {
             error_setg(errp,
diff --git a/block/vvfat.c b/block/vvfat.c
index 0841cc42fc..a690595f2c 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -2947,7 +2947,7 @@ static int do_commit(BDRVVVFATState* s)
         return ret;
     }
 
-    if (s->qcow->bs->drv->bdrv_make_empty) {
+    if (s->qcow->bs->drv && s->qcow->bs->drv->bdrv_make_empty) {
         s->qcow->bs->drv->bdrv_make_empty(s->qcow->bs);
     }
 
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 49bc89df38..44141f6243 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -337,6 +337,28 @@ $QEMU_IO -c "write 0 64k" "$TEST_IMG" | _filter_qemu_io
 
 # Can't repair this yet (TODO: We can just deallocate the cluster)
 
+echo
+echo '=== Discarding with an unaligned refblock ==='
+echo
+
+_make_test_img 64M
+
+$QEMU_IO -c "write 0 128k" "$TEST_IMG" | _filter_qemu_io
+# Make our refblock unaligned
+poke_file "$TEST_IMG" "$(($rt_offset))" "\x00\x00\x00\x00\x00\x00\x2a\x00"
+# Now try to discard something that will be submitted as two requests
+# (main part + tail)
+$QEMU_IO -c "discard 0 65537" "$TEST_IMG"
+
+echo '--- Repairing ---'
+# Fails the first repair because the corruption prevents the check
+# function from double-checking
+# (Using -q for the first invocation, because otherwise the
+#  double-check error message appears above the summary for some
+#  reason -- so let's just hide the summary)
+_check_test_img -q -r all
+_check_test_img -r all
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index c583076808..07dfdcac99 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -317,4 +317,35 @@ discard 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Marking image as corrupt: Preallocated zero cluster offset 0x2a00 unaligned (guest offset: 0); further corruption events will be suppressed
 write failed: Input/output error
+
+=== Discarding with an unaligned refblock ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+wrote 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qcow2: Marking image as corrupt: Refblock offset 0x2a00 unaligned (reftable index: 0); further corruption events will be suppressed
+qcow2_free_clusters failed: Input/output error
+discard failed: No medium found
+--- Repairing ---
+ERROR refcount block 0 is not cluster aligned; refcount table entry corrupted
+qcow2: Marking image as corrupt: Refblock offset 0x2a00 unaligned (reftable index: 0); further corruption events will be suppressed
+Can't get refcount for cluster 0: Input/output error
+Can't get refcount for cluster 1: Input/output error
+Can't get refcount for cluster 2: Input/output error
+Can't get refcount for cluster 3: Input/output error
+Can't get refcount for cluster 4: Input/output error
+Can't get refcount for cluster 5: Input/output error
+Can't get refcount for cluster 6: Input/output error
+Rebuilding refcount structure
+Repairing cluster 1 refcount=1 reference=0
+qemu-img: Check failed: No medium found
+Leaked cluster 1 refcount=1 reference=0
+Repairing cluster 1 refcount=1 reference=0
+The following inconsistencies were found and repaired:
+
+    1 leaked clusters
+    0 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
 *** done
-- 
2.13.6
