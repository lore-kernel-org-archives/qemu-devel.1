Received: from eggs.gnu.org ([2001:4830:134:3::10]:54827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1faMuS-0006qd-Mh
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:08:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1faMuR-0002rD-EJ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:08:04 -0400
Date: Tue, 3 Jul 2018 17:07:58 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180703150758.GB28229@localhost.localdomain>
References: <20180703145915.32607-1-kwolf@redhat.com>
	<20180703145915.32607-6-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703145915.32607-6-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PULL 5/5] block: Add blklogwrites
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

Am 03.07.2018 um 16:59 hat Kevin Wolf geschrieben:
> From: Aapo Vienamo <aapo@tuxera.com>
> 
> Implements a block device write logging system, similar to Linux kernel
> device mapper dm-log-writes. The write operations that are performed
> on a block device are logged to a file or another block device. The
> write log format is identical to the dm-log-writes format. Currently,
> log markers are not supported.
> 
> This functionality can be used for crash consistency and fs consistency
> testing. By implementing it in qemu, tests utilizing write logs can be
> be used to test non-Linux drivers and older kernels.
> 
> The driver accepts an optional parameter to set the sector size used
> for logging. This makes the driver require all requests to be aligned
> to this sector size and also makes offsets and sizes of writes in the
> log metadata to be expressed in terms of this value (the log format has
> a granularity of one sector for offsets and sizes). This allows
> accurate logging of writes to guest block devices that have unusual
> sector sizes.
> 
> The implementation is based on the blkverify and blkdebug block
> drivers.
> 
> Signed-off-by: Aapo Vienamo <aapo@tuxera.com>
> Signed-off-by: Ari Sundholm <ari@tuxera.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Note that I saw Ari's v7 right after sending the pull request. It
contains only a few simple bugfixes compared to the version I had
queued, so I quickly squashed the following in and updated the tag.

Kevin


diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 0748b56d72..47093fadd6 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -53,6 +53,19 @@ typedef struct {
     uint64_t nr_entries;
 } BDRVBlkLogWritesState;
 
+static QemuOptsList runtime_opts = {
+    .name = "blklogwrites",
+    .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
+    .desc = {
+        {
+            .name = "log-sector-size",
+            .type = QEMU_OPT_SIZE,
+            .help = "Log sector size",
+        },
+        { /* end of list */ }
+    },
+};
+
 static inline uint32_t blk_log_writes_log2(uint32_t value)
 {
     assert(value > 0);
@@ -63,9 +76,18 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
                                Error **errp)
 {
     BDRVBlkLogWritesState *s = bs->opaque;
+    QemuOpts *opts;
     Error *local_err = NULL;
     int ret;
-    int64_t log_sector_size = BDRV_SECTOR_SIZE;
+    int64_t log_sector_size;
+
+    opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
+    qemu_opts_absorb_qdict(opts, options, &local_err);
+    if (local_err) {
+        ret = -EINVAL;
+        error_propagate(errp, local_err);
+        goto fail;
+    }
 
     /* Open the file */
     bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, false,
@@ -76,12 +98,10 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
-    if (qdict_haskey(options, "log-sector-size")) {
-        log_sector_size = qdict_get_int(options, "log-sector-size");
-        qdict_del(options, "log-sector-size");
-    }
+    log_sector_size = qemu_opt_get_size(opts, "log-sector-size",
+                                        BDRV_SECTOR_SIZE);
 
-    if (log_sector_size < 0 || log_sector_size >= (1ull << 32) ||
+    if (log_sector_size < 0 || log_sector_size > (1ull << 23) ||
         !is_power_of_2(log_sector_size))
     {
         ret = -EINVAL;
@@ -109,6 +129,7 @@ fail:
         bdrv_unref_child(bs, bs->file);
         bs->file = NULL;
     }
+    qemu_opts_del(opts);
     return ret;
 }
 
@@ -144,6 +165,7 @@ static void blk_log_writes_refresh_filename(BlockDriverState *bs,
         qobject_ref(s->log_file->bs->full_open_options);
         qdict_put_obj(opts, "log",
                       QOBJECT(s->log_file->bs->full_open_options));
+        qdict_put_int(opts, "log-sector-size", s->sectorsize);
 
         bs->full_open_options = opts;
     }
