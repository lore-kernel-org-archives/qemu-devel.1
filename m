Received: from eggs.gnu.org ([2001:4830:134:3::10]:46710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clRkY-0005qq-La
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 21:54:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clRkX-0005yI-Cf
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 21:54:50 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue,  7 Mar 2017 20:54:27 -0600
Message-Id: <20170308025428.1037-10-eblake@redhat.com>
In-Reply-To: <20170308025428.1037-1-eblake@redhat.com>
References: <20170308025428.1037-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 09/10] blkdebug: Add ability to override
 unmap geometries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, Markus Armbruster <armbru@redhat.com>

Make it easier to simulate various unusual hardware setups (for
example, recent commits 3482b9b and b8d0a98 affect the Dell
Equallogic iSCSI with its 15M preferred and maximum unmap and
write zero sizing, or b2f95fe deals with the Linux loopback
block device having a max_transfer of 64k), by allowing blkdebug
to wrap any other device with further restrictions on various
alignments.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v6: more tweaks in docs and error messages
v5: tweak docs regarding max-transfer minimum
v4: relax 512 byte minimum now that blkdebug is byte-based, fix doc typo
v3: improve legibility of bounds checking, improve docs
v2: new patch
---
 qapi/block-core.json | 31 +++++++++++++++--
 block/blkdebug.c     | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 124 insertions(+), 3 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 9bb7f4a..e8aeb8e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2476,7 +2476,32 @@
 # @config:          #optional filename of the configuration file
 #
 # @align:           #optional required alignment for requests in bytes,
-#                   must be power of 2, or 0 for default
+#                   must be positive power of 2, or 0 for default
+#
+# @max-transfer:    #optional maximum size for I/O transfers in bytes,
+#                   must be positive multiple of @align and of the
+#                   underlying file's request alignment (but need not be
+#                   a power of 2), or 0 for default (since 2.10)
+#
+# @opt-write-zero:  #optional preferred alignment for write zero requests
+#                   in bytes, must be positive multiple of @align and of
+#                   the underlying file's request alignment (but need not
+#                   be a power of 2), or 0 for default (since 2.10)
+#
+# @max-write-zero:  #optional maximum size for write zero requests in bytes,
+#                   must be positive multiple of @align, of @opt-write-zero,
+#                   and of the underlying file's request alignment (but
+#                   need not be a power of 2), or 0 for default (since 2.10)
+#
+# @opt-discard:     #optional preferred alignment for discard requests
+#                   in bytes, must be positive multiple of @align and of
+#                   the underlying file's request alignment (but need not
+#                   be a power of 2), or 0 for default (since 2.10)
+#
+# @max-discard:     #optional maximum size for discard requests in bytes,
+#                   must be positive multiple of @align, of @opt-discard,
+#                   and of the underlying file's request alignment (but
+#                   need not be a power of 2), or 0 for default (since 2.10)
 #
 # @inject-error:    #optional array of error injection descriptions
 #
@@ -2487,7 +2512,9 @@
 { 'struct': 'BlockdevOptionsBlkdebug',
   'data': { 'image': 'BlockdevRef',
             '*config': 'str',
-            '*align': 'int',
+            '*align': 'int', '*max-transfer': 'int32',
+            '*opt-write-zero': 'int32', '*max-write-zero': 'int32',
+            '*opt-discard': 'int32', '*max-discard': 'int32',
             '*inject-error': ['BlkdebugInjectErrorOptions'],
             '*set-state': ['BlkdebugSetStateOptions'] } }

diff --git a/block/blkdebug.c b/block/blkdebug.c
index dd5d85d..4e2c392 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -39,6 +39,11 @@ typedef struct BDRVBlkdebugState {
     int state;
     int new_state;
     uint64_t align;
+    uint64_t max_transfer;
+    uint64_t opt_write_zero;
+    uint64_t max_write_zero;
+    uint64_t opt_discard;
+    uint64_t max_discard;

     /* For blkdebug_refresh_filename() */
     char *config_file;
@@ -343,6 +348,31 @@ static QemuOptsList runtime_opts = {
             .type = QEMU_OPT_SIZE,
             .help = "Required alignment in bytes",
         },
+        {
+            .name = "max-transfer",
+            .type = QEMU_OPT_SIZE,
+            .help = "Maximum transfer size in bytes",
+        },
+        {
+            .name = "opt-write-zero",
+            .type = QEMU_OPT_SIZE,
+            .help = "Optimum write zero alignment in bytes",
+        },
+        {
+            .name = "max-write-zero",
+            .type = QEMU_OPT_SIZE,
+            .help = "Maximum write zero size in bytes",
+        },
+        {
+            .name = "opt-discard",
+            .type = QEMU_OPT_SIZE,
+            .help = "Optimum discard alignment in bytes",
+        },
+        {
+            .name = "max-discard",
+            .type = QEMU_OPT_SIZE,
+            .help = "Maximum discard size in bytes",
+        },
         { /* end of list */ }
     },
 };
@@ -354,6 +384,7 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
     QemuOpts *opts;
     Error *local_err = NULL;
     int ret;
+    uint64_t align;

     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &local_err);
@@ -387,13 +418,61 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
     bs->supported_zero_flags = (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
         bs->file->bs->supported_zero_flags;

-    /* Set request alignment */
+    /* Set alignment overrides */
     s->align = qemu_opt_get_size(opts, "align", 0);
     if (s->align && (s->align >= INT_MAX || !is_power_of_2(s->align))) {
         error_setg(errp, "Cannot meet constraints with align %" PRIu64,
                    s->align);
         goto fail_unref;
     }
+    align = MAX(s->align, bs->file->bs->bl.request_alignment);
+
+    s->max_transfer = qemu_opt_get_size(opts, "max-transfer", 0);
+    if (s->max_transfer &&
+        (s->max_transfer >= INT_MAX ||
+         !QEMU_IS_ALIGNED(s->max_transfer, align))) {
+        error_setg(errp, "Cannot meet constraints with max-transfer %" PRIu64,
+                   s->max_transfer);
+        goto fail_unref;
+    }
+
+    s->opt_write_zero = qemu_opt_get_size(opts, "opt-write-zero", 0);
+    if (s->opt_write_zero &&
+        (s->opt_write_zero >= INT_MAX ||
+         !QEMU_IS_ALIGNED(s->opt_write_zero, align))) {
+        error_setg(errp, "Cannot meet constraints with opt-write-zero %" PRIu64,
+                   s->opt_write_zero);
+        goto fail_unref;
+    }
+
+    s->max_write_zero = qemu_opt_get_size(opts, "max-write-zero", 0);
+    if (s->max_write_zero &&
+        (s->max_write_zero >= INT_MAX ||
+         !QEMU_IS_ALIGNED(s->max_write_zero,
+                          MAX(s->opt_write_zero, align)))) {
+        error_setg(errp, "Cannot meet constraints with max-write-zero %" PRIu64,
+                   s->max_write_zero);
+        goto fail_unref;
+    }
+
+    s->opt_discard = qemu_opt_get_size(opts, "opt-discard", 0);
+    if (s->opt_discard &&
+        (s->opt_discard >= INT_MAX ||
+         !QEMU_IS_ALIGNED(s->opt_discard, align))) {
+        error_setg(errp, "Cannot meet constraints with opt-discard %" PRIu64,
+                   s->opt_discard);
+        goto fail_unref;
+    }
+
+    s->max_discard = qemu_opt_get_size(opts, "max-discard", 0);
+    if (s->max_discard &&
+        (s->max_discard >= INT_MAX ||
+         !QEMU_IS_ALIGNED(s->max_discard,
+                          MAX(s->opt_discard, align)))) {
+        error_setg(errp, "Cannot meet constraints with max-discard %" PRIu64,
+                   s->max_discard);
+        goto fail_unref;
+    }

     ret = 0;
     goto out;
@@ -793,6 +872,21 @@ static void blkdebug_refresh_limits(BlockDriverState *bs, Error **errp)
     if (s->align) {
         bs->bl.request_alignment = s->align;
     }
+    if (s->max_transfer) {
+        bs->bl.max_transfer = s->max_transfer;
+    }
+    if (s->opt_write_zero) {
+        bs->bl.pwrite_zeroes_alignment = s->opt_write_zero;
+    }
+    if (s->max_write_zero) {
+        bs->bl.max_pwrite_zeroes = s->max_write_zero;
+    }
+    if (s->opt_discard) {
+        bs->bl.pdiscard_alignment = s->opt_discard;
+    }
+    if (s->max_discard) {
+        bs->bl.max_pdiscard = s->max_discard;
+    }
 }

 static int blkdebug_reopen_prepare(BDRVReopenState *reopen_state,
-- 
2.9.3
