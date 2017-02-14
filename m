Received: from eggs.gnu.org ([2001:4830:134:3::10]:39493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdijP-00014P-DZ
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 14:25:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdijN-0005Mh-Mp
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 14:25:43 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue, 14 Feb 2017 13:25:24 -0600
Message-Id: <20170214192525.18624-7-eblake@redhat.com>
In-Reply-To: <20170214192525.18624-1-eblake@redhat.com>
References: <20170214192525.18624-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 6/7] blkdebug: Add ability to override unmap
 geometries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, Markus Armbruster <armbru@redhat.com>

Make it easier to simulate various unusual hardware setups (for
example, recent commits 3482b9b and b8d0a98 affect the Dell
Equallogic iSCSI with its 15M preferred and maximum unmap and
write zero sizing, or b2f95fe deals with the Linux loopback
block device having a max_transfer of 64k), by allowing blkdebug
to wrap any other device with further restrictions on various
alignments.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v5: tweak docs regarding max-transfer minimum
v4: relax 512 byte minimum now that blkdebug is byte-based, fix doc typo
v3: improve legibility of bounds checking, improve docs
v2: new patch
---
 qapi/block-core.json | 25 ++++++++++++++-
 block/blkdebug.c     | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 114 insertions(+), 2 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 932f5bb..8556c2b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2463,6 +2463,27 @@
 # @align:           #optional required alignment for requests in bytes,
 #                   must be power of 2, or 0 for default
 #
+# @max-transfer:    #optional maximum size for I/O transfers in bytes,
+#                   must be multiple of @align and of the underlying file's
+#                   request alignment (but need not be a power of 2), or
+#                   0 for default (since 2.9)
+#
+# @opt-write-zero:  #optional preferred alignment for write zero requests
+#                   in bytes, must be multiple of @align (but need not be
+#                   a power of 2), or 0 for default (since 2.9)
+#
+# @max-write-zero:  #optional maximum size for write zero requests in bytes,
+#                   must be multiple of @align (but need not be a power of
+#                   2), or 0 for default (since 2.9)
+#
+# @opt-discard:     #optional preferred alignment for discard requests
+#                   in bytes, must be multiple of @align (but need not be
+#                   a power of 2), or 0 for default (since 2.9)
+#
+# @max-discard:     #optional maximum size for discard requests in bytes,
+#                   must be multiple of @align (but need not be a power of
+#                   2), or 0 for default (since 2.9)
+#
 # @inject-error:    #optional array of error injection descriptions
 #
 # @set-state:       #optional array of state-change descriptions
@@ -2472,7 +2493,9 @@
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
index 2996152..c2e4604 100644
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
@@ -387,12 +418,55 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
     bs->supported_zero_flags = (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
         bs->file->bs->supported_zero_flags;

-    /* Set request alignment */
+    /* Set alignment overrides */
     s->align = qemu_opt_get_size(opts, "align", 0);
     if (s->align && (s->align >= INT_MAX || !is_power_of_2(s->align))) {
         error_setg(errp, "Invalid alignment, align must be integer power of 2");
         goto fail_unref;
     }
+    align = MAX(s->align, bs->file->bs->bl.request_alignment);
+
+    s->max_transfer = qemu_opt_get_size(opts, "max-transfer", 0);
+    if (s->max_transfer &&
+        (s->max_transfer >= INT_MAX ||
+         !QEMU_IS_ALIGNED(s->max_transfer, align))) {
+        error_setg(errp, "Invalid max-transfer, must be multiple of align");
+        goto fail_unref;
+    }
+
+    s->opt_write_zero = qemu_opt_get_size(opts, "opt-write-zero", 0);
+    if (s->opt_write_zero &&
+        (s->opt_write_zero >= INT_MAX ||
+         !QEMU_IS_ALIGNED(s->opt_write_zero, align))) {
+        error_setg(errp, "Invalid opt-write-zero, not consistent with align");
+        goto fail_unref;
+    }
+
+    s->max_write_zero = qemu_opt_get_size(opts, "max-write-zero", 0);
+    if (s->max_write_zero &&
+        (s->max_write_zero >= INT_MAX ||
+         !QEMU_IS_ALIGNED(s->max_write_zero,
+                          MAX(s->opt_write_zero, align)))) {
+        error_setg(errp, "Invalid max-write-zero, not consistent with align");
+        goto fail_unref;
+    }
+
+    s->opt_discard = qemu_opt_get_size(opts, "opt-discard", 0);
+    if (s->opt_discard &&
+        (s->opt_discard >= INT_MAX ||
+         !QEMU_IS_ALIGNED(s->opt_discard, align))) {
+        error_setg(errp, "Invalid opt-discard, not consistent with align");
+        goto fail_unref;
+    }
+
+    s->max_discard = qemu_opt_get_size(opts, "max-discard", 0);
+    if (s->max_discard &&
+        (s->max_discard >= INT_MAX ||
+         !QEMU_IS_ALIGNED(s->max_discard,
+                          MAX(s->opt_discard, align)))) {
+        error_setg(errp, "Invalid max-discard, not consistent with align");
+        goto fail_unref;
+    }

     ret = 0;
     goto out;
@@ -819,6 +893,21 @@ static void blkdebug_refresh_limits(BlockDriverState *bs, Error **errp)
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
