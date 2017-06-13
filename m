Received: from eggs.gnu.org ([2001:4830:134:3::10]:51040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKp4v-0004lp-GS
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKp4e-0000WW-PU
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:54:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dKp4d-0000VU-UO
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:48 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 13 Jun 2017 13:53:12 -0300
Message-Id: <20170613165313.20954-15-ehabkost@redhat.com>
In-Reply-To: <20170613165313.20954-1-ehabkost@redhat.com>
References: <20170613165313.20954-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 14/15] [coccinelle] Eliminate unnecessary
 local_err/error_propagate() usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Now we can check for errors on errp using the ERR_IS_SET() macro, even
if errors are being ignored.

Replace common local_err/error_propagate() usage using the following
Coccinelle script:

  @ simple_propagate @
  typedef Error;
  type T;
  identifier FN;
  expression some_func;
  identifier errp;
  identifier local_err;
  @@
   T FN(..., Error **errp)
   {
       ...
  -    Error *local_err = NULL;
       <... when != local_err
  (
       some_func(...,
  -        &local_err
  +        errp
          );
       ... when != local_err
  (
       error_propagate(errp, local_err);
  |
       if (local_err) {
           ... when != local_err
           error_propagate(errp, local_err);
           ... when != local_err
       }
  )
  |
       if (
  -        local_err
  +        ERR_IS_SET(errp)
          ) {
           ... when != local_err
  -        error_propagate(errp, local_err);
           ... when != local_err
       }
  |
  -    error_propagate(errp, local_err);
  )
       ...>
   }

>From the 792 error_propagate() calls in the tree, 346 were automatically
converted by the script.  Probably we can write a more complex script
that catches many of the remaining cases later, or convert them
manually.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qapi/qapi-visit-core.c              |   6 +-
 backends/hostmem.c                  |   6 +-
 backends/rng.c                      |   6 +-
 backends/tpm.c                      |   6 +-
 block.c                             |  41 ++++------
 block/blkdebug.c                    |  16 ++--
 block/block-backend.c               |   6 +-
 block/commit.c                      |  16 ++--
 block/crypto.c                      |   6 +-
 block/curl.c                        |   6 +-
 block/file-posix.c                  |   6 +-
 block/gluster.c                     |   6 +-
 block/io.c                          |  11 +--
 block/iscsi.c                       |  27 +++----
 block/mirror.c                      |  12 +--
 block/nbd.c                         |  18 ++---
 block/nfs.c                         |  12 +--
 block/qapi.c                        |   6 +-
 block/qcow2.c                       |  11 +--
 block/raw-format.c                  |   6 +-
 block/rbd.c                         |   6 +-
 block/replication.c                 |  10 +--
 block/sheepdog.c                    |  28 +++----
 block/ssh.c                         |  12 +--
 blockdev.c                          |  45 ++++-------
 blockjob.c                          |  13 +--
 bootdevice.c                        |  13 +--
 chardev/char.c                      |   6 +-
 dump.c                              | 153 +++++++++++-------------------------
 exec.c                              |  18 ++---
 hw/arm/allwinner-a10.c              |  26 +++---
 hw/arm/armv7m.c                     |  26 +++---
 hw/arm/digic.c                      |  21 ++---
 hw/arm/fsl-imx25.c                  |  61 ++++++--------
 hw/arm/fsl-imx31.c                  |  56 ++++++-------
 hw/arm/fsl-imx6.c                   |  76 +++++++-----------
 hw/arm/xlnx-zynqmp.c                |   6 +-
 hw/block/fdc.c                      |  23 ++----
 hw/block/pflash_cfi01.c             |   6 +-
 hw/block/pflash_cfi02.c             |   6 +-
 hw/block/virtio-blk.c               |  16 ++--
 hw/char/debugcon.c                  |   6 +-
 hw/char/serial-pci.c                |  12 +--
 hw/char/virtio-serial-bus.c         |   6 +-
 hw/core/machine.c                   |  12 +--
 hw/core/qdev-properties-system.c    |  24 ++----
 hw/core/qdev-properties.c           |  47 ++++-------
 hw/core/qdev.c                      |   6 +-
 hw/cpu/a15mpcore.c                  |   6 +-
 hw/cpu/a9mpcore.c                   |  26 +++---
 hw/cpu/arm11mpcore.c                |  21 ++---
 hw/cpu/core.c                       |  12 +--
 hw/cpu/realview_mpcore.c            |  11 +--
 hw/display/qxl.c                    |   6 +-
 hw/display/virtio-gpu.c             |   6 +-
 hw/display/virtio-vga.c             |   6 +-
 hw/i386/kvm/pci-assign.c            |   6 +-
 hw/i386/pc.c                        |   6 +-
 hw/input/virtio-input.c             |  12 +--
 hw/intc/apic_common.c               |   6 +-
 hw/intc/arm_gic.c                   |   6 +-
 hw/intc/arm_gic_kvm.c               |  11 +--
 hw/intc/arm_gicv3.c                 |   6 +-
 hw/intc/arm_gicv3_its_kvm.c         |   6 +-
 hw/intc/arm_gicv3_kvm.c             |  11 +--
 hw/intc/armv7m_nvic.c               |   6 +-
 hw/intc/realview_gic.c              |   6 +-
 hw/ipack/ipack.c                    |   4 +-
 hw/misc/ivshmem.c                   |  18 ++---
 hw/misc/macio/macio.c               |  33 +++-----
 hw/misc/tmp105.c                    |   6 +-
 hw/net/dp8393x.c                    |   6 +-
 hw/nvram/fw_cfg.c                   |  12 +--
 hw/pci-bridge/pci_expander_bridge.c |   6 +-
 hw/pci/pci.c                        |  17 ++--
 hw/pci/shpc.c                       |  12 +--
 hw/ppc/e500.c                       |   6 +-
 hw/ppc/pnv.c                        |  32 +++-----
 hw/ppc/pnv_core.c                   |  16 ++--
 hw/ppc/spapr.c                      |  12 +--
 hw/ppc/spapr_drc.c                  |  26 +++---
 hw/ppc/spapr_pci.c                  |  12 +--
 hw/s390x/css-bridge.c               |   6 +-
 hw/s390x/css.c                      |   6 +-
 hw/s390x/virtio-ccw.c               |  16 ++--
 hw/scsi/esp-pci.c                   |   6 +-
 hw/scsi/scsi-bus.c                  |  17 ++--
 hw/scsi/scsi-disk.c                 |  11 +--
 hw/scsi/vhost-scsi.c                |  11 +--
 hw/scsi/virtio-scsi.c               |   6 +-
 hw/usb/bus.c                        |  32 +++-----
 hw/usb/dev-serial.c                 |   6 +-
 hw/usb/hcd-ohci.c                   |  12 +--
 hw/usb/hcd-uhci.c                   |   6 +-
 hw/vfio/pci.c                       |  11 +--
 hw/virtio/virtio-balloon.c          |   6 +-
 hw/virtio/virtio-pci.c              |   6 +-
 hw/virtio/virtio-rng.c              |   6 +-
 hw/virtio/virtio.c                  |  17 ++--
 migration/colo.c                    |  12 +--
 migration/migration.c               |   6 +-
 net/filter.c                        |   6 +-
 net/tap.c                           |   6 +-
 qapi/string-input-visitor.c         |   6 +-
 qdev-monitor.c                      |   6 +-
 qga/commands-posix.c                |  80 ++++++-------------
 qga/commands-win32.c                |  18 ++---
 qmp.c                               |  11 +--
 qom/object.c                        |  84 +++++++-------------
 replication.c                       |  24 ++----
 target/alpha/cpu.c                  |   6 +-
 target/arm/cpu.c                    |   6 +-
 target/cris/cpu.c                   |   6 +-
 target/hppa/cpu.c                   |   6 +-
 target/i386/cpu.c                   |  42 ++++------
 target/lm32/cpu.c                   |   6 +-
 target/m68k/cpu.c                   |   6 +-
 target/microblaze/cpu.c             |   6 +-
 target/mips/cpu.c                   |   6 +-
 target/moxie/cpu.c                  |   6 +-
 target/nios2/cpu.c                  |   6 +-
 target/openrisc/cpu.c               |   6 +-
 target/ppc/translate_init.c         |  23 ++----
 target/s390x/cpu.c                  |   6 +-
 target/sh4/cpu.c                    |   6 +-
 target/sparc/cpu.c                  |   6 +-
 target/tilegx/cpu.c                 |   6 +-
 target/tricore/cpu.c                |   6 +-
 target/unicore32/cpu.c              |   6 +-
 target/xtensa/cpu.c                 |   6 +-
 util/qemu-config.c                  |   6 +-
 util/qemu-option.c                  |  18 ++---
 132 files changed, 691 insertions(+), 1310 deletions(-)

diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index 43a09d147d..e4700d3ff9 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -351,13 +351,11 @@ static void output_type_enum(Visitor *v, const char *name, int *obj,
 static void input_type_enum(Visitor *v, const char *name, int *obj,
                             const char *const strings[], Error **errp)
 {
-    Error *local_err = NULL;
     int64_t value = 0;
     char *enum_str;
 
-    visit_type_str(v, name, &enum_str, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_str(v, name, &enum_str, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 4606b73849..8fcc5d68c9 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -197,7 +197,6 @@ static bool host_memory_backend_get_prealloc(Object *obj, Error **errp)
 static void host_memory_backend_set_prealloc(Object *obj, bool value,
                                              Error **errp)
 {
-    Error *local_err = NULL;
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
 
     if (backend->force_prealloc) {
@@ -218,9 +217,8 @@ static void host_memory_backend_set_prealloc(Object *obj, bool value,
         void *ptr = memory_region_get_ram_ptr(&backend->mr);
         uint64_t sz = memory_region_size(&backend->mr);
 
-        os_mem_prealloc(fd, ptr, sz, smp_cpus, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        os_mem_prealloc(fd, ptr, sz, smp_cpus, errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
         backend->prealloc = true;
diff --git a/backends/rng.c b/backends/rng.c
index 59b7503efb..c5f4f01642 100644
--- a/backends/rng.c
+++ b/backends/rng.c
@@ -54,7 +54,6 @@ static void rng_backend_prop_set_opened(Object *obj, bool value, Error **errp)
 {
     RngBackend *s = RNG_BACKEND(obj);
     RngBackendClass *k = RNG_BACKEND_GET_CLASS(s);
-    Error *local_err = NULL;
 
     if (value == s->opened) {
         return;
@@ -66,9 +65,8 @@ static void rng_backend_prop_set_opened(Object *obj, bool value, Error **errp)
     }
 
     if (k->opened) {
-        k->opened(s, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        k->opened(s, errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     }
diff --git a/backends/tpm.c b/backends/tpm.c
index ef3e20a3cb..5b9788faf4 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -128,7 +128,6 @@ static void tpm_backend_prop_set_opened(Object *obj, bool value, Error **errp)
 {
     TPMBackend *s = TPM_BACKEND(obj);
     TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
-    Error *local_err = NULL;
 
     if (value == s->opened) {
         return;
@@ -140,9 +139,8 @@ static void tpm_backend_prop_set_opened(Object *obj, bool value, Error **errp)
     }
 
     if (k->opened) {
-        k->opened(s, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        k->opened(s, errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     }
diff --git a/block.c b/block.c
index b08d95a62a..1a6776447a 100644
--- a/block.c
+++ b/block.c
@@ -1440,7 +1440,6 @@ static int bdrv_fill_options(QDict **options, const char *filename,
     bool protocol = *flags & BDRV_O_PROTOCOL;
     bool parse_filename = false;
     BlockDriver *drv = NULL;
-    Error *local_err = NULL;
 
     /*
      * Caution: while qdict_get_try_str() is fine, getting non-string
@@ -1505,9 +1504,8 @@ static int bdrv_fill_options(QDict **options, const char *filename,
 
     /* Driver-specific filename parsing */
     if (drv && drv->bdrv_parse_filename && parse_filename) {
-        drv->bdrv_parse_filename(filename, *options, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        drv->bdrv_parse_filename(filename, *options, errp);
+        if (ERR_IS_SET(errp)) {
             return -EINVAL;
         }
 
@@ -2119,7 +2117,6 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
     BlockDriverState *backing_hd;
     QDict *options;
     QDict *tmp_parent_options = NULL;
-    Error *local_err = NULL;
 
     if (bs->backing != NULL) {
         goto free_exit;
@@ -2152,10 +2149,9 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
         goto free_exit;
     } else {
         bdrv_get_full_backing_filename(bs, backing_filename, PATH_MAX,
-                                       &local_err);
-        if (local_err) {
+                                       errp);
+        if (ERR_IS_SET(errp)) {
             ret = -EINVAL;
-            error_propagate(errp, local_err);
             QDECREF(options);
             goto free_exit;
         }
@@ -2184,10 +2180,9 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
 
     /* Hook up the backing file link; drop our reference, bs owns the
      * backing_hd reference now */
-    bdrv_set_backing_hd(bs, backing_hd, &local_err);
+    bdrv_set_backing_hd(bs, backing_hd, errp);
     bdrv_unref(backing_hd);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (ERR_IS_SET(errp)) {
         ret = -EINVAL;
         goto free_exit;
     }
@@ -2292,7 +2287,6 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
     int64_t total_size;
     QemuOpts *opts = NULL;
     BlockDriverState *bs_snapshot = NULL;
-    Error *local_err = NULL;
     int ret;
 
     /* if snapshot, we create a temporary backing file and open it
@@ -2339,9 +2333,8 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
      * order to be able to return one, we have to increase
      * bs_snapshot's refcount here */
     bdrv_ref(bs_snapshot);
-    bdrv_append(bs_snapshot, bs, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    bdrv_append(bs_snapshot, bs, errp);
+    if (ERR_IS_SET(errp)) {
         bs_snapshot = NULL;
         goto out;
     }
@@ -3196,17 +3189,13 @@ out:
 void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
                  Error **errp)
 {
-    Error *local_err = NULL;
-
-    bdrv_set_backing_hd(bs_new, bs_top, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    bdrv_set_backing_hd(bs_new, bs_top, errp);
+    if (ERR_IS_SET(errp)) {
         goto out;
     }
 
-    bdrv_replace_node(bs_top, bs_new, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    bdrv_replace_node(bs_top, bs_new, errp);
+    if (ERR_IS_SET(errp)) {
         bdrv_set_backing_hd(bs_new, NULL, &error_abort);
         goto out;
     }
@@ -4074,17 +4063,15 @@ void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
 void bdrv_invalidate_cache_all(Error **errp)
 {
     BlockDriverState *bs;
-    Error *local_err = NULL;
     BdrvNextIterator it;
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         AioContext *aio_context = bdrv_get_aio_context(bs);
 
         aio_context_acquire(aio_context);
-        bdrv_invalidate_cache(bs, &local_err);
+        bdrv_invalidate_cache(bs, errp);
         aio_context_release(aio_context);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     }
diff --git a/block/blkdebug.c b/block/blkdebug.c
index a5196e889d..57cd23d94a 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -246,7 +246,6 @@ static int read_config(BDRVBlkdebugState *s, const char *filename,
     FILE *f = NULL;
     int ret;
     struct add_rule_data d;
-    Error *local_err = NULL;
 
     if (filename) {
         f = fopen(filename, "r");
@@ -263,26 +262,23 @@ static int read_config(BDRVBlkdebugState *s, const char *filename,
         }
     }
 
-    qemu_config_parse_qdict(options, config_groups, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    qemu_config_parse_qdict(options, config_groups, errp);
+    if (ERR_IS_SET(errp)) {
         ret = -EINVAL;
         goto fail;
     }
 
     d.s = s;
     d.action = ACTION_INJECT_ERROR;
-    qemu_opts_foreach(&inject_error_opts, add_rule, &d, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    qemu_opts_foreach(&inject_error_opts, add_rule, &d, errp);
+    if (ERR_IS_SET(errp)) {
         ret = -EINVAL;
         goto fail;
     }
 
     d.action = ACTION_SET_STATE;
-    qemu_opts_foreach(&set_state_opts, add_rule, &d, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    qemu_opts_foreach(&set_state_opts, add_rule, &d, errp);
+    if (ERR_IS_SET(errp)) {
         ret = -EINVAL;
         goto fail;
     }
diff --git a/block/block-backend.c b/block/block-backend.c
index 9b9ca2eb35..0725cd84a4 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -141,7 +141,6 @@ static const char *blk_root_get_name(BdrvChild *child)
 static void blk_root_activate(BdrvChild *child, Error **errp)
 {
     BlockBackend *blk = child->opaque;
-    Error *local_err = NULL;
 
     if (!blk->disable_perm) {
         return;
@@ -149,9 +148,8 @@ static void blk_root_activate(BdrvChild *child, Error **errp)
 
     blk->disable_perm = false;
 
-    blk_set_perm(blk, blk->perm, blk->shared_perm, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    blk_set_perm(blk, blk->perm, blk->shared_perm, errp);
+    if (ERR_IS_SET(errp)) {
         blk->disable_perm = true;
         return;
     }
diff --git a/block/commit.c b/block/commit.c
index 264495177e..08ab3ce7de 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -293,7 +293,6 @@ void commit_start(const char *job_id, BlockDriverState *bs,
     BlockDriverState *iter;
     BlockDriverState *overlay_bs;
     BlockDriverState *commit_top_bs = NULL;
-    Error *local_err = NULL;
     int ret;
 
     assert(top != bs);
@@ -328,9 +327,8 @@ void commit_start(const char *job_id, BlockDriverState *bs,
                                          orig_overlay_flags | BDRV_O_RDWR);
     }
     if (reopen_queue) {
-        bdrv_reopen_multiple(bdrv_get_aio_context(bs), reopen_queue, &local_err);
-        if (local_err != NULL) {
-            error_propagate(errp, local_err);
+        bdrv_reopen_multiple(bdrv_get_aio_context(bs), reopen_queue, errp);
+        if (ERR_IS_SET(errp)) {
             goto fail;
         }
     }
@@ -345,18 +343,16 @@ void commit_start(const char *job_id, BlockDriverState *bs,
     commit_top_bs->total_sectors = top->total_sectors;
     bdrv_set_aio_context(commit_top_bs, bdrv_get_aio_context(top));
 
-    bdrv_set_backing_hd(commit_top_bs, top, &local_err);
-    if (local_err) {
+    bdrv_set_backing_hd(commit_top_bs, top, errp);
+    if (ERR_IS_SET(errp)) {
         bdrv_unref(commit_top_bs);
         commit_top_bs = NULL;
-        error_propagate(errp, local_err);
         goto fail;
     }
-    bdrv_set_backing_hd(overlay_bs, commit_top_bs, &local_err);
-    if (local_err) {
+    bdrv_set_backing_hd(overlay_bs, commit_top_bs, errp);
+    if (ERR_IS_SET(errp)) {
         bdrv_unref(commit_top_bs);
         commit_top_bs = NULL;
-        error_propagate(errp, local_err);
         goto fail;
     }
 
diff --git a/block/crypto.c b/block/crypto.c
index 5c2687d271..d98ae60c48 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -295,7 +295,6 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
 {
     BlockCrypto *crypto = bs->opaque;
     QemuOpts *opts = NULL;
-    Error *local_err = NULL;
     int ret = -EINVAL;
     QCryptoBlockOpenOptions *open_opts = NULL;
     unsigned int cflags = 0;
@@ -307,9 +306,8 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
     }
 
     opts = qemu_opts_create(opts_spec, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    qemu_opts_absorb_qdict(opts, options, errp);
+    if (ERR_IS_SET(errp)) {
         goto cleanup;
     }
 
diff --git a/block/curl.c b/block/curl.c
index 2a244e2439..05ed2e82c6 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -679,7 +679,6 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
     BDRVCURLState *s = bs->opaque;
     CURLState *state = NULL;
     QemuOpts *opts;
-    Error *local_err = NULL;
     const char *file;
     const char *cookie;
     const char *cookie_secret;
@@ -696,9 +695,8 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
 
     qemu_mutex_init(&s->mutex);
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    qemu_opts_absorb_qdict(opts, options, errp);
+    if (ERR_IS_SET(errp)) {
         goto out_noclean;
     }
 
diff --git a/block/file-posix.c b/block/file-posix.c
index 5e30164be3..ba49f0b528 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -756,7 +756,6 @@ static int raw_reopen_prepare(BDRVReopenState *state,
     BDRVRawState *s;
     BDRVRawReopenState *rs;
     int ret = 0;
-    Error *local_err = NULL;
 
     assert(state != NULL);
     assert(state->bs != NULL);
@@ -819,11 +818,10 @@ static int raw_reopen_prepare(BDRVReopenState *state,
     /* Fail already reopen_prepare() if we can't get a working O_DIRECT
      * alignment with the new fd. */
     if (rs->fd != -1) {
-        raw_probe_alignment(state->bs, rs->fd, &local_err);
-        if (local_err) {
+        raw_probe_alignment(state->bs, rs->fd, errp);
+        if (ERR_IS_SET(errp)) {
             qemu_close(rs->fd);
             rs->fd = -1;
-            error_propagate(errp, local_err);
             ret = -EINVAL;
         }
     }
diff --git a/block/gluster.c b/block/gluster.c
index 6179195620..30ac978a89 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -765,13 +765,11 @@ static int qemu_gluster_open(BlockDriverState *bs,  QDict *options,
     int ret = 0;
     BlockdevOptionsGluster *gconf = NULL;
     QemuOpts *opts;
-    Error *local_err = NULL;
     const char *filename, *logfile;
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    qemu_opts_absorb_qdict(opts, options, errp);
+    if (ERR_IS_SET(errp)) {
         ret = -EINVAL;
         goto out;
     }
diff --git a/block/io.c b/block/io.c
index ed31810c0a..cc3fd997a7 100644
--- a/block/io.c
+++ b/block/io.c
@@ -81,7 +81,6 @@ static void bdrv_merge_limits(BlockLimits *dst, const BlockLimits *src)
 void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     BlockDriver *drv = bs->drv;
-    Error *local_err = NULL;
 
     memset(&bs->bl, 0, sizeof(bs->bl));
 
@@ -94,9 +93,8 @@ void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
 
     /* Take some limits from the children as a default */
     if (bs->file) {
-        bdrv_refresh_limits(bs->file->bs, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        bdrv_refresh_limits(bs->file->bs, errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
         bdrv_merge_limits(&bs->bl, &bs->file->bs->bl);
@@ -109,9 +107,8 @@ void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
     }
 
     if (bs->backing) {
-        bdrv_refresh_limits(bs->backing->bs, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        bdrv_refresh_limits(bs->backing->bs, errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
         bdrv_merge_limits(&bs->bl, &bs->backing->bs->bl);
diff --git a/block/iscsi.c b/block/iscsi.c
index 0116fe97ce..6b3939585c 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1747,7 +1747,6 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     struct scsi_inquiry_supported_pages *inq_vpd;
     char *initiator_name = NULL;
     QemuOpts *opts;
-    Error *local_err = NULL;
     const char *transport_name, *portal, *target;
 #if LIBISCSI_API_VERSION >= (20160603)
     enum iscsi_transport_type transport;
@@ -1755,9 +1754,8 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     int i, ret = 0, timeout = 0, lun;
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    qemu_opts_absorb_qdict(opts, options, errp);
+    if (ERR_IS_SET(errp)) {
         ret = -EINVAL;
         goto out;
     }
@@ -1811,9 +1809,8 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     /* check if we got CHAP username/password via the options */
-    apply_chap(iscsi, opts, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    apply_chap(iscsi, opts, errp);
+    if (ERR_IS_SET(errp)) {
         ret = -EINVAL;
         goto out;
     }
@@ -1825,9 +1822,8 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     /* check if we got HEADER_DIGEST via the options */
-    apply_header_digest(iscsi, opts, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    apply_header_digest(iscsi, opts, errp);
+    if (ERR_IS_SET(errp)) {
         ret = -EINVAL;
         goto out;
     }
@@ -1878,9 +1874,8 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
         goto out;
     }
 
-    iscsi_readcapacity_sync(iscsilun, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    iscsi_readcapacity_sync(iscsilun, errp);
+    if (ERR_IS_SET(errp)) {
         ret = -EINVAL;
         goto out;
     }
@@ -2063,16 +2058,14 @@ static void iscsi_reopen_commit(BDRVReopenState *reopen_state)
 static int iscsi_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
 {
     IscsiLun *iscsilun = bs->opaque;
-    Error *local_err = NULL;
 
     if (iscsilun->type != TYPE_DISK) {
         error_setg(errp, "Cannot resize non-disk iSCSI devices");
         return -ENOTSUP;
     }
 
-    iscsi_readcapacity_sync(iscsilun, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    iscsi_readcapacity_sync(iscsilun, errp);
+    if (ERR_IS_SET(errp)) {
         return -EIO;
     }
 
diff --git a/block/mirror.c b/block/mirror.c
index 2d5d7dbbc2..addafec0ee 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1127,7 +1127,6 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     BlockDriverState *mirror_top_bs;
     bool target_graph_mod;
     bool target_is_backing;
-    Error *local_err = NULL;
     int ret;
 
     if (granularity == 0) {
@@ -1160,12 +1159,11 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
      * it alive until block_job_create() succeeds even if bs has no parent. */
     bdrv_ref(mirror_top_bs);
     bdrv_drained_begin(bs);
-    bdrv_append(mirror_top_bs, bs, &local_err);
+    bdrv_append(mirror_top_bs, bs, errp);
     bdrv_drained_end(bs);
 
-    if (local_err) {
+    if (ERR_IS_SET(errp)) {
         bdrv_unref(mirror_top_bs);
-        error_propagate(errp, local_err);
         return;
     }
 
@@ -1299,7 +1297,6 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
                          bool auto_complete, Error **errp)
 {
     int orig_base_flags;
-    Error *local_err = NULL;
 
     orig_base_flags = bdrv_get_flags(base);
 
@@ -1311,9 +1308,8 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
                      MIRROR_LEAVE_BACKING_CHAIN,
                      on_error, on_error, true, cb, opaque,
                      &commit_active_job_driver, false, base, auto_complete,
-                     filter_node_name, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+                     filter_node_name, errp);
+    if (ERR_IS_SET(errp)) {
         goto error_restore_flags;
     }
 
diff --git a/block/nbd.c b/block/nbd.c
index 975faab2c5..6644c0e75f 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -265,7 +265,6 @@ static SocketAddress *nbd_config(BDRVNBDState *s, QDict *options,
     QDict *addr = NULL;
     QObject *crumpled_addr = NULL;
     Visitor *iv = NULL;
-    Error *local_err = NULL;
 
     qdict_extract_subqdict(options, &addr, "server.");
     if (!qdict_size(addr)) {
@@ -287,9 +286,8 @@ static SocketAddress *nbd_config(BDRVNBDState *s, QDict *options,
      * visitor expects the former.
      */
     iv = qobject_input_visitor_new(crumpled_addr);
-    visit_type_SocketAddress(iv, NULL, &saddr, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_SocketAddress(iv, NULL, &saddr, errp);
+    if (ERR_IS_SET(errp)) {
         goto done;
     }
 
@@ -310,17 +308,15 @@ static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
                                                   Error **errp)
 {
     QIOChannelSocket *sioc;
-    Error *local_err = NULL;
 
     sioc = qio_channel_socket_new();
     qio_channel_set_name(QIO_CHANNEL(sioc), "nbd-client");
 
     qio_channel_socket_connect_sync(sioc,
                                     saddr,
-                                    &local_err);
-    if (local_err) {
+                                    errp);
+    if (ERR_IS_SET(errp)) {
         object_unref(OBJECT(sioc));
-        error_propagate(errp, local_err);
         return NULL;
     }
 
@@ -397,16 +393,14 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
 {
     BDRVNBDState *s = bs->opaque;
     QemuOpts *opts = NULL;
-    Error *local_err = NULL;
     QIOChannelSocket *sioc = NULL;
     QCryptoTLSCreds *tlscreds = NULL;
     const char *hostname = NULL;
     int ret = -EINVAL;
 
     opts = qemu_opts_create(&nbd_runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    qemu_opts_absorb_qdict(opts, options, errp);
+    if (ERR_IS_SET(errp)) {
         goto error;
     }
 
diff --git a/block/nfs.c b/block/nfs.c
index 848b2c0bb0..7792b3ad01 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -455,7 +455,6 @@ static NFSServer *nfs_config(QDict *options, Error **errp)
     QDict *addr = NULL;
     QObject *crumpled_addr = NULL;
     Visitor *iv = NULL;
-    Error *local_error = NULL;
 
     qdict_extract_subqdict(options, &addr, "server.");
     if (!qdict_size(addr)) {
@@ -476,9 +475,8 @@ static NFSServer *nfs_config(QDict *options, Error **errp)
      * they come from -drive, they're all QString.
      */
     iv = qobject_input_visitor_new(crumpled_addr);
-    visit_type_NFSServer(iv, NULL, &server, &local_error);
-    if (local_error) {
-        error_propagate(errp, local_error);
+    visit_type_NFSServer(iv, NULL, &server, errp);
+    if (ERR_IS_SET(errp)) {
         goto out;
     }
 
@@ -495,14 +493,12 @@ static int64_t nfs_client_open(NFSClient *client, QDict *options,
 {
     int ret = -EINVAL;
     QemuOpts *opts = NULL;
-    Error *local_err = NULL;
     struct stat st;
     char *file = NULL, *strp = NULL;
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    qemu_opts_absorb_qdict(opts, options, errp);
+    if (ERR_IS_SET(errp)) {
         ret = -EINVAL;
         goto fail;
     }
diff --git a/block/qapi.c b/block/qapi.c
index a40922ea26..423934f0bf 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -460,13 +460,11 @@ BlockInfoList *qmp_query_block(Error **errp)
 {
     BlockInfoList *head = NULL, **p_next = &head;
     BlockBackend *blk;
-    Error *local_err = NULL;
 
     for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
         BlockInfoList *info = g_malloc0(sizeof(*info));
-        bdrv_query_info(blk, &info->value, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        bdrv_query_info(blk, &info->value, errp);
+        if (ERR_IS_SET(errp)) {
             g_free(info);
             qapi_free_BlockInfoList(head);
             return NULL;
diff --git a/block/qcow2.c b/block/qcow2.c
index 53920a83b5..5e7e5bf292 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -598,22 +598,19 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
     int overlap_check_template = 0;
     uint64_t l2_cache_size, refcount_cache_size;
     int i;
-    Error *local_err = NULL;
     int ret;
 
     opts = qemu_opts_create(&qcow2_runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    qemu_opts_absorb_qdict(opts, options, errp);
+    if (ERR_IS_SET(errp)) {
         ret = -EINVAL;
         goto fail;
     }
 
     /* get L2 table/refcount block cache size from command line options */
     read_cache_sizes(bs, opts, &l2_cache_size, &refcount_cache_size,
-                     &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+                     errp);
+    if (ERR_IS_SET(errp)) {
         ret = -EINVAL;
         goto fail;
     }
diff --git a/block/raw-format.c b/block/raw-format.c
index 36e65036f0..5134373fbf 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -71,7 +71,6 @@ static QemuOptsList raw_create_opts = {
 static int raw_read_options(QDict *options, BlockDriverState *bs,
     BDRVRawState *s, Error **errp)
 {
-    Error *local_err = NULL;
     QemuOpts *opts = NULL;
     int64_t real_size = 0;
     int ret;
@@ -83,9 +82,8 @@ static int raw_read_options(QDict *options, BlockDriverState *bs,
     }
 
     opts = qemu_opts_create(&raw_runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    qemu_opts_absorb_qdict(opts, options, errp);
+    if (ERR_IS_SET(errp)) {
         ret = -EINVAL;
         goto end;
     }
diff --git a/block/rbd.c b/block/rbd.c
index e551639e47..25149e776b 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -346,7 +346,6 @@ static QemuOptsList runtime_opts = {
 
 static int qemu_rbd_create(const char *filename, QemuOpts *opts, Error **errp)
 {
-    Error *local_err = NULL;
     int64_t bytes = 0;
     int64_t objsize;
     int obj_order = 0;
@@ -378,10 +377,9 @@ static int qemu_rbd_create(const char *filename, QemuOpts *opts, Error **errp)
     }
 
     options = qdict_new();
-    qemu_rbd_parse_filename(filename, options, &local_err);
-    if (local_err) {
+    qemu_rbd_parse_filename(filename, options, errp);
+    if (ERR_IS_SET(errp)) {
         ret = -EINVAL;
-        error_propagate(errp, local_err);
         goto exit;
     }
 
diff --git a/block/replication.c b/block/replication.c
index c4ac17201a..c7ea016af9 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -313,7 +313,6 @@ static bool replication_recurse_is_first_non_filter(BlockDriverState *bs,
 
 static void secondary_do_checkpoint(BDRVReplicationState *s, Error **errp)
 {
-    Error *local_err = NULL;
     int ret;
 
     if (!s->secondary_disk->bs->job) {
@@ -321,9 +320,8 @@ static void secondary_do_checkpoint(BDRVReplicationState *s, Error **errp)
         return;
     }
 
-    backup_do_checkpoint(s->secondary_disk->bs->job, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    backup_do_checkpoint(s->secondary_disk->bs->job, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -347,7 +345,6 @@ static void reopen_backing_file(BlockDriverState *bs, bool writable,
     BlockReopenQueue *reopen_queue = NULL;
     int orig_hidden_flags, orig_secondary_flags;
     int new_hidden_flags, new_secondary_flags;
-    Error *local_err = NULL;
 
     if (writable) {
         orig_hidden_flags = s->orig_hidden_flags =
@@ -379,8 +376,7 @@ static void reopen_backing_file(BlockDriverState *bs, bool writable,
 
     if (reopen_queue) {
         bdrv_reopen_multiple(bdrv_get_aio_context(bs),
-                             reopen_queue, &local_err);
-        error_propagate(errp, local_err);
+                             reopen_queue, errp);
     }
 }
 
diff --git a/block/sheepdog.c b/block/sheepdog.c
index dd75571435..6160fa6717 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -553,7 +553,6 @@ static SocketAddress *sd_server_config(QDict *options, Error **errp)
     QObject *crumpled_server = NULL;
     Visitor *iv = NULL;
     SocketAddress *saddr = NULL;
-    Error *local_err = NULL;
 
     qdict_extract_subqdict(options, &server, "server.");
 
@@ -571,9 +570,8 @@ static SocketAddress *sd_server_config(QDict *options, Error **errp)
      * visitor expects the former.
      */
     iv = qobject_input_visitor_new(crumpled_server);
-    visit_type_SocketAddress(iv, NULL, &saddr, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_SocketAddress(iv, NULL, &saddr, errp);
+    if (ERR_IS_SET(errp)) {
         goto done;
     }
 
@@ -1197,17 +1195,15 @@ static void parse_vdiname(SheepdogConfig *cfg, const char *filename,
 static void sd_parse_filename(const char *filename, QDict *options,
                               Error **errp)
 {
-    Error *err = NULL;
     SheepdogConfig cfg;
     char buf[32];
 
     if (strstr(filename, "://")) {
-        sd_parse_uri(&cfg, filename, &err);
+        sd_parse_uri(&cfg, filename, errp);
     } else {
-        parse_vdiname(&cfg, filename, &err);
+        parse_vdiname(&cfg, filename, errp);
     }
-    if (err) {
-        error_propagate(errp, err);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -1572,15 +1568,13 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
     uint64_t snap_id;
     char *buf = NULL;
     QemuOpts *opts;
-    Error *local_err = NULL;
 
     s->bs = bs;
     s->aio_context = bdrv_get_aio_context(bs);
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    qemu_opts_absorb_qdict(opts, options, errp);
+    if (ERR_IS_SET(errp)) {
         ret = -EINVAL;
         goto err_no_fd;
     }
@@ -1955,7 +1949,6 @@ static int parse_block_size_shift(BDRVSheepdogState *s, QemuOpts *opt)
 static int sd_create(const char *filename, QemuOpts *opts,
                      Error **errp)
 {
-    Error *err = NULL;
     int ret = 0;
     uint32_t vid = 0;
     char *backing_file = NULL;
@@ -1968,12 +1961,11 @@ static int sd_create(const char *filename, QemuOpts *opts,
     s = g_new0(BDRVSheepdogState, 1);
 
     if (strstr(filename, "://")) {
-        sd_parse_uri(&cfg, filename, &err);
+        sd_parse_uri(&cfg, filename, errp);
     } else {
-        parse_vdiname(&cfg, filename, &err);
+        parse_vdiname(&cfg, filename, errp);
     }
-    if (err) {
-        error_propagate(errp, err);
+    if (ERR_IS_SET(errp)) {
         goto out;
     }
 
diff --git a/block/ssh.c b/block/ssh.c
index 11203fc5a2..008e256ad1 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -586,7 +586,6 @@ static InetSocketAddress *ssh_config(QDict *options, Error **errp)
     QDict *addr = NULL;
     QObject *crumpled_addr = NULL;
     Visitor *iv = NULL;
-    Error *local_error = NULL;
 
     qdict_extract_subqdict(options, &addr, "server.");
     if (!qdict_size(addr)) {
@@ -608,9 +607,8 @@ static InetSocketAddress *ssh_config(QDict *options, Error **errp)
      * visitor expects the former.
      */
     iv = qobject_input_visitor_new(crumpled_addr);
-    visit_type_InetSocketAddress(iv, NULL, &inet, &local_error);
-    if (local_error) {
-        error_propagate(errp, local_error);
+    visit_type_InetSocketAddress(iv, NULL, &inet, errp);
+    if (ERR_IS_SET(errp)) {
         goto out;
     }
 
@@ -626,15 +624,13 @@ static int connect_to_ssh(BDRVSSHState *s, QDict *options,
 {
     int r, ret;
     QemuOpts *opts = NULL;
-    Error *local_err = NULL;
     const char *user, *path, *host_key_check;
     long port = 0;
 
     opts = qemu_opts_create(&ssh_runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
+    qemu_opts_absorb_qdict(opts, options, errp);
+    if (ERR_IS_SET(errp)) {
         ret = -EINVAL;
-        error_propagate(errp, local_err);
         goto err;
     }
 
diff --git a/blockdev.c b/blockdev.c
index fdbf33aa3d..3ce592d4af 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1620,7 +1620,6 @@ static void external_snapshot_prepare(BlkActionState *common,
 {
     int flags = 0;
     QDict *options = NULL;
-    Error *local_err = NULL;
     /* Device and node name of the image to generate the snapshot from */
     const char *device;
     const char *node_name;
@@ -1726,9 +1725,8 @@ static void external_snapshot_prepare(BlkActionState *common,
             bdrv_img_create(new_image_file, format,
                             state->old_bs->filename,
                             state->old_bs->drv->format_name,
-                            NULL, size, flags, false, &local_err);
-            if (local_err) {
-                error_propagate(errp, local_err);
+                            NULL, size, flags, false, errp);
+            if (ERR_IS_SET(errp)) {
                 return;
             }
         }
@@ -1775,9 +1773,8 @@ static void external_snapshot_prepare(BlkActionState *common,
      * can fail, so we need to do it in .prepare; undoing it for abort is
      * always possible. */
     bdrv_ref(state->new_bs);
-    bdrv_append(state->new_bs, state->old_bs, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    bdrv_append(state->new_bs, state->old_bs, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     state->overlay_appended = true;
@@ -2166,7 +2163,6 @@ void qmp_transaction(TransactionActionList *dev_list,
     TransactionActionList *dev_entry = dev_list;
     BlockJobTxn *block_job_txn = NULL;
     BlkActionState *state, *next;
-    Error *local_err = NULL;
 
     QSIMPLEQ_HEAD(snap_bdrv_states, BlkActionState) snap_bdrv_states;
     QSIMPLEQ_INIT(&snap_bdrv_states);
@@ -2202,9 +2198,8 @@ void qmp_transaction(TransactionActionList *dev_list,
         state->txn_props = props;
         QSIMPLEQ_INSERT_TAIL(&snap_bdrv_states, state, entry);
 
-        state->ops->prepare(state, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        state->ops->prepare(state, errp);
+        if (ERR_IS_SET(errp)) {
             goto delete_and_fail;
         }
     }
@@ -2366,7 +2361,6 @@ void qmp_blockdev_close_tray(bool has_device, const char *device,
                              Error **errp)
 {
     BlockBackend *blk;
-    Error *local_err = NULL;
 
     device = has_device ? device : NULL;
     id = has_id ? id : NULL;
@@ -2390,9 +2384,8 @@ void qmp_blockdev_close_tray(bool has_device, const char *device,
         return;
     }
 
-    blk_dev_change_media_cb(blk, true, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    blk_dev_change_media_cb(blk, true, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 }
@@ -2457,7 +2450,6 @@ out:
 static void qmp_blockdev_insert_anon_medium(BlockBackend *blk,
                                             BlockDriverState *bs, Error **errp)
 {
-    Error *local_err = NULL;
     bool has_device;
     int ret;
 
@@ -2490,9 +2482,8 @@ static void qmp_blockdev_insert_anon_medium(BlockBackend *blk,
          * slot here.
          * Do it after blk_insert_bs() so blk_is_inserted(blk) returns the @load
          * value passed here (i.e. true). */
-        blk_dev_change_media_cb(blk, true, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        blk_dev_change_media_cb(blk, true, errp);
+        if (ERR_IS_SET(errp)) {
             blk_remove_bs(blk);
             return;
         }
@@ -2947,7 +2938,6 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
     BlockDriverState *bs, *iter;
     BlockDriverState *base_bs = NULL;
     AioContext *aio_context;
-    Error *local_err = NULL;
     const char *base_name = NULL;
 
     if (!has_on_error) {
@@ -3011,9 +3001,8 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
     base_name = has_backing_file ? backing_file : base_name;
 
     stream_start(has_job_id ? job_id : NULL, bs, base_bs, base_name,
-                 has_speed ? speed : 0, on_error, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+                 has_speed ? speed : 0, on_error, errp);
+    if (ERR_IS_SET(errp)) {
         goto out;
     }
 
@@ -3600,7 +3589,6 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
     BlockDriverState *target_bs;
     AioContext *aio_context;
     BlockMirrorBackingMode backing_mode = MIRROR_LEAVE_BACKING_CHAIN;
-    Error *local_err = NULL;
 
     bs = qmp_get_root_bs(device, errp);
     if (!bs) {
@@ -3626,8 +3614,7 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
                            has_on_target_error, on_target_error,
                            true, true,
                            has_filter_node_name, filter_node_name,
-                           &local_err);
-    error_propagate(errp, local_err);
+                           errp);
 
     aio_context_release(aio_context);
 }
@@ -3856,11 +3843,9 @@ void qmp_blockdev_add(BlockdevOptions *options, Error **errp)
     QObject *obj;
     Visitor *v = qobject_output_visitor_new(&obj);
     QDict *qdict;
-    Error *local_err = NULL;
 
-    visit_type_BlockdevOptions(v, NULL, &options, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_BlockdevOptions(v, NULL, &options, errp);
+    if (ERR_IS_SET(errp)) {
         goto fail;
     }
 
diff --git a/blockjob.c b/blockjob.c
index 69ad28dd65..c0b528f1e9 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -356,7 +356,6 @@ static int block_job_finish_sync(BlockJob *job,
                                  void (*finish)(BlockJob *, Error **errp),
                                  Error **errp)
 {
-    Error *local_err = NULL;
     int ret;
 
     assert(blk_bs(job->blk)->job == job);
@@ -364,10 +363,9 @@ static int block_job_finish_sync(BlockJob *job,
     block_job_ref(job);
 
     if (finish) {
-        finish(job, &local_err);
+        finish(job, errp);
     }
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (ERR_IS_SET(errp)) {
         block_job_unref(job);
         return -EBUSY;
     }
@@ -454,15 +452,12 @@ static void block_job_completed_txn_success(BlockJob *job)
 
 void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
 {
-    Error *local_err = NULL;
-
     if (!job->driver->set_speed) {
         error_setg(errp, QERR_UNSUPPORTED);
         return;
     }
-    job->driver->set_speed(job, speed, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    job->driver->set_speed(job, speed, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/bootdevice.c b/bootdevice.c
index 29ebbb1c48..92f607d321 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -52,17 +52,14 @@ void qemu_register_boot_set(QEMUBootSetHandler *func, void *opaque)
 
 void qemu_boot_set(const char *boot_order, Error **errp)
 {
-    Error *local_err = NULL;
-
     if (!boot_set_handler) {
         error_setg(errp, "no function defined to set boot device list for"
                          " this architecture");
         return;
     }
 
-    validate_bootdevices(boot_order, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    validate_bootdevices(boot_order, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -319,7 +316,6 @@ void device_add_bootindex_property(Object *obj, int32_t *bootindex,
                                    const char *name, const char *suffix,
                                    DeviceState *dev, Error **errp)
 {
-    Error *local_err = NULL;
     BootIndexProperty *prop = g_malloc0(sizeof(*prop));
 
     prop->bootindex = bootindex;
@@ -330,10 +326,9 @@ void device_add_bootindex_property(Object *obj, int32_t *bootindex,
                         device_get_bootindex,
                         device_set_bootindex,
                         property_release_bootindex,
-                        prop, &local_err);
+                        prop, errp);
 
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (ERR_IS_SET(errp)) {
         g_free(prop);
         return;
     }
diff --git a/chardev/char.c b/chardev/char.c
index 7aa0210765..ac3cd2b436 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -559,7 +559,6 @@ help_string_append(const char *name, void *opaque)
 Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
                                 Error **errp)
 {
-    Error *local_err = NULL;
     const ChardevClass *cc;
     Chardev *chr;
     int i;
@@ -610,9 +609,8 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
 
     chr = NULL;
     if (cc->parse) {
-        cc->parse(opts, backend, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        cc->parse(opts, backend, errp);
+        if (ERR_IS_SET(errp)) {
             goto out;
         }
     } else {
diff --git a/dump.c b/dump.c
index dc78c98b23..3fa8ba3571 100644
--- a/dump.c
+++ b/dump.c
@@ -348,22 +348,19 @@ static void write_memory(DumpState *s, GuestPhysBlock *block, ram_addr_t start,
                          int64_t size, Error **errp)
 {
     int64_t i;
-    Error *local_err = NULL;
 
     for (i = 0; i < size / s->dump_info.page_size; i++) {
         write_data(s, block->host_addr + start + i * s->dump_info.page_size,
-                   s->dump_info.page_size, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+                   s->dump_info.page_size, errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     }
 
     if ((size % s->dump_info.page_size) != 0) {
         write_data(s, block->host_addr + start + i * s->dump_info.page_size,
-                   size % s->dump_info.page_size, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+                   size % s->dump_info.page_size, errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     }
@@ -437,7 +434,6 @@ static void write_elf_loads(DumpState *s, Error **errp)
     MemoryMapping *memory_mapping;
     uint32_t phdr_index = 1;
     uint32_t max_index;
-    Error *local_err = NULL;
 
     if (s->have_section) {
         max_index = s->sh_info;
@@ -451,14 +447,13 @@ static void write_elf_loads(DumpState *s, Error **errp)
                          s, &offset, &filesz);
         if (s->dump_info.d_class == ELFCLASS64) {
             write_elf64_load(s, memory_mapping, phdr_index++, offset,
-                             filesz, &local_err);
+                             filesz, errp);
         } else {
             write_elf32_load(s, memory_mapping, phdr_index++, offset,
-                             filesz, &local_err);
+                             filesz, errp);
         }
 
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (ERR_IS_SET(errp)) {
             return;
         }
 
@@ -471,101 +466,65 @@ static void write_elf_loads(DumpState *s, Error **errp)
 /* write elf header, PT_NOTE and elf note to vmcore. */
 static void dump_begin(DumpState *s, Error **errp)
 {
-    Error *local_err = NULL;
-
-    /*
-     * the vmcore's format is:
-     *   --------------
-     *   |  elf header |
-     *   --------------
-     *   |  PT_NOTE    |
-     *   --------------
-     *   |  PT_LOAD    |
-     *   --------------
-     *   |  ......     |
-     *   --------------
-     *   |  PT_LOAD    |
-     *   --------------
-     *   |  sec_hdr    |
-     *   --------------
-     *   |  elf note   |
-     *   --------------
-     *   |  memory     |
-     *   --------------
-     *
-     * we only know where the memory is saved after we write elf note into
-     * vmcore.
-     */
-
-    /* write elf header to vmcore */
     if (s->dump_info.d_class == ELFCLASS64) {
-        write_elf64_header(s, &local_err);
+        write_elf64_header(s, errp);
     } else {
-        write_elf32_header(s, &local_err);
+        write_elf32_header(s, errp);
     }
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
     if (s->dump_info.d_class == ELFCLASS64) {
         /* write PT_NOTE to vmcore */
-        write_elf64_note(s, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        write_elf64_note(s, errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
 
         /* write all PT_LOAD to vmcore */
-        write_elf_loads(s, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        write_elf_loads(s, errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
 
         /* write section to vmcore */
         if (s->have_section) {
-            write_elf_section(s, 1, &local_err);
-            if (local_err) {
-                error_propagate(errp, local_err);
+            write_elf_section(s, 1, errp);
+            if (ERR_IS_SET(errp)) {
                 return;
             }
         }
 
         /* write notes to vmcore */
-        write_elf64_notes(fd_write_vmcore, s, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        write_elf64_notes(fd_write_vmcore, s, errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     } else {
         /* write PT_NOTE to vmcore */
-        write_elf32_note(s, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        write_elf32_note(s, errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
 
         /* write all PT_LOAD to vmcore */
-        write_elf_loads(s, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        write_elf_loads(s, errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
 
         /* write section to vmcore */
         if (s->have_section) {
-            write_elf_section(s, 0, &local_err);
-            if (local_err) {
-                error_propagate(errp, local_err);
+            write_elf_section(s, 0, errp);
+            if (ERR_IS_SET(errp)) {
                 return;
             }
         }
 
         /* write notes to vmcore */
-        write_elf32_notes(fd_write_vmcore, s, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        write_elf32_notes(fd_write_vmcore, s, errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     }
@@ -603,7 +562,6 @@ static void dump_iterate(DumpState *s, Error **errp)
 {
     GuestPhysBlock *block;
     int64_t size;
-    Error *local_err = NULL;
 
     do {
         block = s->next_block;
@@ -615,9 +573,8 @@ static void dump_iterate(DumpState *s, Error **errp)
                 size -= block->target_end - (s->begin + s->length);
             }
         }
-        write_memory(s, block, s->start, size, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        write_memory(s, block, s->start, size, errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
 
@@ -626,11 +583,8 @@ static void dump_iterate(DumpState *s, Error **errp)
 
 static void create_vmcore(DumpState *s, Error **errp)
 {
-    Error *local_err = NULL;
-
-    dump_begin(s, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    dump_begin(s, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -725,7 +679,6 @@ static void create_header32(DumpState *s, Error **errp)
     uint32_t bitmap_blocks;
     uint32_t status = 0;
     uint64_t offset_note;
-    Error *local_err = NULL;
 
     /* write common header, the version of kdump-compressed format is 6th */
     size = sizeof(DiskDumpHeader32);
@@ -789,9 +742,8 @@ static void create_header32(DumpState *s, Error **errp)
     s->note_buf_offset = 0;
 
     /* use s->note_buf to store notes temporarily */
-    write_elf32_notes(buf_write_note, s, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    write_elf32_notes(buf_write_note, s, errp);
+    if (ERR_IS_SET(errp)) {
         goto out;
     }
     if (write_buffer(s->fd, offset_note, s->note_buf,
@@ -825,7 +777,6 @@ static void create_header64(DumpState *s, Error **errp)
     uint32_t bitmap_blocks;
     uint32_t status = 0;
     uint64_t offset_note;
-    Error *local_err = NULL;
 
     /* write common header, the version of kdump-compressed format is 6th */
     size = sizeof(DiskDumpHeader64);
@@ -889,9 +840,8 @@ static void create_header64(DumpState *s, Error **errp)
     s->note_buf_offset = 0;
 
     /* use s->note_buf to store notes temporarily */
-    write_elf64_notes(buf_write_note, s, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    write_elf64_notes(buf_write_note, s, errp);
+    if (ERR_IS_SET(errp)) {
         goto out;
     }
 
@@ -917,14 +867,11 @@ out:
 
 static void write_dump_header(DumpState *s, Error **errp)
 {
-     Error *local_err = NULL;
-
     if (s->dump_info.d_class == ELFCLASS32) {
-        create_header32(s, &local_err);
+        create_header32(s, errp);
     } else {
-        create_header64(s, &local_err);
+        create_header64(s, errp);
     }
-    error_propagate(errp, local_err);
 }
 
 static size_t dump_bitmap_get_bufsize(DumpState *s)
@@ -1359,7 +1306,6 @@ out:
 static void create_kdump_vmcore(DumpState *s, Error **errp)
 {
     int ret;
-    Error *local_err = NULL;
 
     /*
      * the kdump-compressed format is:
@@ -1389,21 +1335,18 @@ static void create_kdump_vmcore(DumpState *s, Error **errp)
         return;
     }
 
-    write_dump_header(s, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    write_dump_header(s, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
-    write_dump_bitmap(s, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    write_dump_bitmap(s, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
-    write_dump_pages(s, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    write_dump_pages(s, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -1494,7 +1437,6 @@ static void dump_init(DumpState *s, int fd, bool has_format,
 {
     CPUState *cpu;
     int nr_cpus;
-    Error *err = NULL;
     int ret;
 
     s->has_format = has_format;
@@ -1565,9 +1507,8 @@ static void dump_init(DumpState *s, int fd, bool has_format,
 
     /* get memory mapping */
     if (paging) {
-        qemu_get_guest_memory_mapping(&s->list, &s->guest_phys_blocks, &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        qemu_get_guest_memory_mapping(&s->list, &s->guest_phys_blocks, errp);
+        if (ERR_IS_SET(errp)) {
             goto cleanup;
         }
     } else {
@@ -1723,7 +1664,6 @@ void qmp_dump_guest_memory(bool paging, const char *file,
     const char *p;
     int fd = -1;
     DumpState *s;
-    Error *local_err = NULL;
     bool detach_p = false;
 
     if (runstate_check(RUN_STATE_INMIGRATE)) {
@@ -1801,9 +1741,8 @@ void qmp_dump_guest_memory(bool paging, const char *file,
     dump_state_prepare(s);
 
     dump_init(s, fd, has_format, format, paging, has_begin,
-              begin, length, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+              begin, length, errp);
+    if (ERR_IS_SET(errp)) {
         atomic_set(&s->status, DUMP_STATUS_FAILED);
         return;
     }
diff --git a/exec.c b/exec.c
index 9d73a63f1c..35d9588350 100644
--- a/exec.c
+++ b/exec.c
@@ -1860,7 +1860,6 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
     RAMBlock *block;
     RAMBlock *last_block = NULL;
     ram_addr_t old_ram_size, new_ram_size;
-    Error *err = NULL;
 
     old_ram_size = last_ram_page();
 
@@ -1870,9 +1869,8 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
     if (!new_block->host) {
         if (xen_enabled()) {
             xen_ram_alloc(new_block->offset, new_block->max_length,
-                          new_block->mr, &err);
-            if (err) {
-                error_propagate(errp, err);
+                          new_block->mr, errp);
+            if (ERR_IS_SET(errp)) {
                 qemu_mutex_unlock_ramlist();
                 return;
             }
@@ -1938,7 +1936,6 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
                                    Error **errp)
 {
     RAMBlock *new_block;
-    Error *local_err = NULL;
 
     if (xen_enabled()) {
         error_setg(errp, "-mem-path not supported with Xen");
@@ -1969,10 +1966,9 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
-    ram_block_add(new_block, &local_err);
-    if (local_err) {
+    ram_block_add(new_block, errp);
+    if (ERR_IS_SET(errp)) {
         g_free(new_block);
-        error_propagate(errp, local_err);
         return NULL;
     }
     return new_block;
@@ -1988,7 +1984,6 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
                                   MemoryRegion *mr, Error **errp)
 {
     RAMBlock *new_block;
-    Error *local_err = NULL;
 
     size = HOST_PAGE_ALIGN(size);
     max_size = HOST_PAGE_ALIGN(max_size);
@@ -2007,10 +2002,9 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     if (resizeable) {
         new_block->flags |= RAM_RESIZEABLE;
     }
-    ram_block_add(new_block, &local_err);
-    if (local_err) {
+    ram_block_add(new_block, errp);
+    if (ERR_IS_SET(errp)) {
         g_free(new_block);
-        error_propagate(errp, local_err);
         return NULL;
     }
     return new_block;
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 651409094c..7d9c8691bb 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -54,19 +54,16 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sysbusdev;
     uint8_t i;
     qemu_irq fiq, irq;
-    Error *err = NULL;
 
-    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->cpu), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     irq = qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_IRQ);
     fiq = qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ);
 
-    object_property_set_bool(OBJECT(&s->intc), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->intc), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     sysbusdev = SYS_BUS_DEVICE(&s->intc);
@@ -77,9 +74,8 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
         s->irq[i] = qdev_get_gpio_in(DEVICE(&s->intc), i);
     }
 
-    object_property_set_bool(OBJECT(&s->timer), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->timer), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     sysbusdev = SYS_BUS_DEVICE(&s->timer);
@@ -91,18 +87,16 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(sysbusdev, 4, s->irq[67]);
     sysbus_connect_irq(sysbusdev, 5, s->irq[68]);
 
-    object_property_set_bool(OBJECT(&s->emac), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->emac), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     sysbusdev = SYS_BUS_DEVICE(&s->emac);
     sysbus_mmio_map(sysbusdev, 0, AW_A10_EMAC_BASE);
     sysbus_connect_irq(sysbusdev, 0, s->irq[55]);
 
-    object_property_set_bool(OBJECT(&s->sata), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->sata), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sata), 0, AW_A10_SATA_BASE);
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index c8a11f2b53..2fa8bbb249 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -161,7 +161,6 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
 {
     ARMv7MState *s = ARMV7M(dev);
     SysBusDevice *sbd;
-    Error *err = NULL;
     int i;
     char **cpustr;
     ObjectClass *oc;
@@ -186,10 +185,9 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
 
     cc = CPU_CLASS(oc);
     typename = object_class_get_name(oc);
-    cc->parse_features(typename, cpustr[1], &err);
+    cc->parse_features(typename, cpustr[1], errp);
     g_strfreev(cpustr);
-    if (err) {
-        error_propagate(errp, err);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -201,16 +199,14 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
 
     object_property_set_link(OBJECT(s->cpu), OBJECT(&s->container), "memory",
                              &error_abort);
-    object_property_set_bool(OBJECT(s->cpu), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(s->cpu), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
     /* Note that we must realize the NVIC after the CPU */
-    object_property_set_bool(OBJECT(&s->nvic), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->nvic), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -234,16 +230,14 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
         Object *obj = OBJECT(&s->bitband[i]);
         SysBusDevice *sbd = SYS_BUS_DEVICE(&s->bitband[i]);
 
-        object_property_set_int(obj, bitband_input_addr[i], "base", &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        object_property_set_int(obj, bitband_input_addr[i], "base", errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
         object_property_set_link(obj, OBJECT(s->board_memory),
                                  "source-memory", &error_abort);
-        object_property_set_bool(obj, true, "realized", &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        object_property_set_bool(obj, true, "realized", errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
 
diff --git a/hw/arm/digic.c b/hw/arm/digic.c
index f22fae73c3..eeaa8729ff 100644
--- a/hw/arm/digic.c
+++ b/hw/arm/digic.c
@@ -59,26 +59,22 @@ static void digic_init(Object *obj)
 static void digic_realize(DeviceState *dev, Error **errp)
 {
     DigicState *s = DIGIC(dev);
-    Error *err = NULL;
     SysBusDevice *sbd;
     int i;
 
-    object_property_set_bool(OBJECT(&s->cpu), true, "reset-hivecs", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->cpu), true, "reset-hivecs", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
-    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->cpu), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
     for (i = 0; i < DIGIC4_NB_TIMERS; i++) {
-        object_property_set_bool(OBJECT(&s->timer[i]), true, "realized", &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->timer[i]), true, "realized", errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
 
@@ -87,9 +83,8 @@ static void digic_realize(DeviceState *dev, Error **errp)
     }
 
     qdev_prop_set_chr(DEVICE(&s->uart), "chardev", serial_hds[0]);
-    object_property_set_bool(OBJECT(&s->uart), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->uart), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 40666b68a3..c10f96d83c 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -78,17 +78,14 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 {
     FslIMX25State *s = FSL_IMX25(dev);
     uint8_t i;
-    Error *err = NULL;
 
-    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->cpu), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
-    object_property_set_bool(OBJECT(&s->avic), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->avic), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->avic), 0, FSL_IMX25_AVIC_ADDR);
@@ -97,9 +94,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->avic), 1,
                        qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
 
-    object_property_set_bool(OBJECT(&s->ccm), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->ccm), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccm), 0, FSL_IMX25_CCM_ADDR);
@@ -131,9 +127,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
             qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", chr);
         }
 
-        object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, serial_table[i].addr);
@@ -156,9 +151,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
         s->gpt[i].ccm = IMX_CCM(&s->ccm);
 
-        object_property_set_bool(OBJECT(&s->gpt[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->gpt[i]), true, "realized", errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpt[i]), 0, gpt_table[i].addr);
@@ -179,9 +173,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
         s->epit[i].ccm = IMX_CCM(&s->ccm);
 
-        object_property_set_bool(OBJECT(&s->epit[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->epit[i]), true, "realized", errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->epit[i]), 0, epit_table[i].addr);
@@ -192,9 +185,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
     qdev_set_nic_properties(DEVICE(&s->fec), &nd_table[0]);
 
-    object_property_set_bool(OBJECT(&s->fec), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->fec), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->fec), 0, FSL_IMX25_FEC_ADDR);
@@ -213,9 +205,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
             { FSL_IMX25_I2C3_ADDR, FSL_IMX25_I2C3_IRQ }
         };
 
-        object_property_set_bool(OBJECT(&s->i2c[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->i2c[i]), true, "realized", errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c[i]), 0, i2c_table[i].addr);
@@ -236,9 +227,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
             { FSL_IMX25_GPIO4_ADDR, FSL_IMX25_GPIO4_IRQ }
         };
 
-        object_property_set_bool(OBJECT(&s->gpio[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->gpio[i]), true, "realized", errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0, gpio_table[i].addr);
@@ -250,17 +240,15 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
     /* initialize 2 x 16 KB ROM */
     memory_region_init_rom(&s->rom[0], NULL,
-                           "imx25.rom0", FSL_IMX25_ROM0_SIZE, &err);
-    if (err) {
-        error_propagate(errp, err);
+                           "imx25.rom0", FSL_IMX25_ROM0_SIZE, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX25_ROM0_ADDR,
                                 &s->rom[0]);
     memory_region_init_rom(&s->rom[1], NULL,
-                           "imx25.rom1", FSL_IMX25_ROM1_SIZE, &err);
-    if (err) {
-        error_propagate(errp, err);
+                           "imx25.rom1", FSL_IMX25_ROM1_SIZE, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX25_ROM1_ADDR,
@@ -268,9 +256,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
     /* initialize internal RAM (128 KB) */
     memory_region_init_ram(&s->iram, NULL, "imx25.iram", FSL_IMX25_IRAM_SIZE,
-                           &err);
-    if (err) {
-        error_propagate(errp, err);
+                           errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX25_IRAM_ADDR,
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index c30130667e..0cc80f3aee 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -70,17 +70,14 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 {
     FslIMX31State *s = FSL_IMX31(dev);
     uint16_t i;
-    Error *err = NULL;
 
-    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->cpu), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
-    object_property_set_bool(OBJECT(&s->avic), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->avic), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->avic), 0, FSL_IMX31_AVIC_ADDR);
@@ -89,9 +86,8 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->avic), 1,
                        qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
 
-    object_property_set_bool(OBJECT(&s->ccm), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->ccm), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccm), 0, FSL_IMX31_CCM_ADDR);
@@ -120,9 +116,8 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
             qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", chr);
         }
 
-        object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
 
@@ -134,9 +129,8 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
     s->gpt.ccm = IMX_CCM(&s->ccm);
 
-    object_property_set_bool(OBJECT(&s->gpt), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->gpt), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -156,9 +150,8 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
         s->epit[i].ccm = IMX_CCM(&s->ccm);
 
-        object_property_set_bool(OBJECT(&s->epit[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->epit[i]), true, "realized", errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
 
@@ -180,9 +173,8 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
         };
 
         /* Initialize the I2C */
-        object_property_set_bool(OBJECT(&s->i2c[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->i2c[i]), true, "realized", errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
         /* Map I2C memory */
@@ -206,9 +198,8 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
         object_property_set_bool(OBJECT(&s->gpio[i]), false, "has-edge-sel",
                                  &error_abort);
-        object_property_set_bool(OBJECT(&s->gpio[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->gpio[i]), true, "realized", errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0, gpio_table[i].addr);
@@ -220,9 +211,8 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
     /* On a real system, the first 16k is a `secure boot rom' */
     memory_region_init_rom(&s->secure_rom, NULL, "imx31.secure_rom",
-                           FSL_IMX31_SECURE_ROM_SIZE, &err);
-    if (err) {
-        error_propagate(errp, err);
+                           FSL_IMX31_SECURE_ROM_SIZE, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX31_SECURE_ROM_ADDR,
@@ -230,9 +220,8 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
     /* There is also a 16k ROM */
     memory_region_init_rom(&s->rom, NULL, "imx31.rom",
-                           FSL_IMX31_ROM_SIZE, &err);
-    if (err) {
-        error_propagate(errp, err);
+                           FSL_IMX31_ROM_SIZE, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX31_ROM_ADDR,
@@ -240,9 +229,8 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
     /* initialize internal RAM (16 KB) */
     memory_region_init_ram(&s->iram, NULL, "imx31.iram", FSL_IMX31_IRAM_SIZE,
-                           &err);
-    if (err) {
-        error_propagate(errp, err);
+                           errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX31_IRAM_ADDR,
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 73610d48a5..1bdf9dbd70 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -123,7 +123,6 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 {
     FslIMX6State *s = FSL_IMX6(dev);
     uint16_t i;
-    Error *err = NULL;
 
     for (i = 0; i < smp_cpus; i++) {
 
@@ -139,9 +138,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                      "start-powered-off", &error_abort);
         }
 
-        object_property_set_bool(OBJECT(&s->cpu[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->cpu[i]), true, "realized", errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     }
@@ -153,9 +151,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                             FSL_IMX6_MAX_IRQ + GIC_INTERNAL, "num-irq",
                             &error_abort);
 
-    object_property_set_bool(OBJECT(&s->a9mpcore), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->a9mpcore), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->a9mpcore), 0, FSL_IMX6_A9MPCORE_ADDR);
@@ -167,16 +164,14 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(DEVICE(&s->cpu[i]), ARM_CPU_FIQ));
     }
 
-    object_property_set_bool(OBJECT(&s->ccm), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->ccm), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccm), 0, FSL_IMX6_CCM_ADDR);
 
-    object_property_set_bool(OBJECT(&s->src), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->src), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->src), 0, FSL_IMX6_SRC_ADDR);
@@ -209,9 +204,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
             qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", chr);
         }
 
-        object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->uart[i]), true, "realized", errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
 
@@ -223,9 +217,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
     s->gpt.ccm = IMX_CCM(&s->ccm);
 
-    object_property_set_bool(OBJECT(&s->gpt), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->gpt), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -246,9 +239,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
         s->epit[i].ccm = IMX_CCM(&s->ccm);
 
-        object_property_set_bool(OBJECT(&s->epit[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->epit[i]), true, "realized", errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
 
@@ -269,9 +261,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
             { FSL_IMX6_I2C3_ADDR, FSL_IMX6_I2C3_IRQ }
         };
 
-        object_property_set_bool(OBJECT(&s->i2c[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->i2c[i]), true, "realized", errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
 
@@ -329,9 +320,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                  &error_abort);
         object_property_set_bool(OBJECT(&s->gpio[i]), true, "has-upper-pin-irq",
                                  &error_abort);
-        object_property_set_bool(OBJECT(&s->gpio[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->gpio[i]), true, "realized", errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
 
@@ -356,9 +346,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
             { FSL_IMX6_uSDHC4_ADDR, FSL_IMX6_uSDHC4_IRQ },
         };
 
-        object_property_set_bool(OBJECT(&s->esdhc[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->esdhc[i]), true, "realized", errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->esdhc[i]), 0, esdhc_table[i].addr);
@@ -381,9 +370,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         };
 
         /* Initialize the SPI */
-        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized", errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
 
@@ -393,9 +381,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                             spi_table[i].irq));
     }
 
-    object_property_set_bool(OBJECT(&s->eth), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->eth), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->eth), 0, FSL_IMX6_ENET_ADDR);
@@ -408,9 +395,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
     /* ROM memory */
     memory_region_init_rom(&s->rom, NULL, "imx6.rom",
-                           FSL_IMX6_ROM_SIZE, &err);
-    if (err) {
-        error_propagate(errp, err);
+                           FSL_IMX6_ROM_SIZE, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX6_ROM_ADDR,
@@ -418,9 +404,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
     /* CAAM memory */
     memory_region_init_rom(&s->caam, NULL, "imx6.caam",
-                           FSL_IMX6_CAAM_MEM_SIZE, &err);
-    if (err) {
-        error_propagate(errp, err);
+                           FSL_IMX6_CAAM_MEM_SIZE, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX6_CAAM_MEM_ADDR,
@@ -428,9 +413,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
     /* OCRAM memory */
     memory_region_init_ram(&s->ocram, NULL, "imx6.ocram", FSL_IMX6_OCRAM_SIZE,
-                           &err);
-    if (err) {
-        error_propagate(errp, err);
+                           errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX6_OCRAM_ADDR,
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 38f9577284..ee6c64b409 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -96,7 +96,6 @@ static inline int arm_gic_ppi_index(int cpu_nr, int ppi_index)
 static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
                                    Error **errp)
 {
-    Error *err = NULL;
     int i;
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_RPU_CPUS; i++) {
@@ -120,9 +119,8 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
         object_property_set_bool(OBJECT(&s->rpu_cpu[i]), true, "reset-hivecs",
                                  &error_abort);
         object_property_set_bool(OBJECT(&s->rpu_cpu[i]), true, "realized",
-                                 &err);
-        if (err) {
-            error_propagate(errp, err);
+                                 errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     }
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 5fed23c774..597ea719a7 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -473,16 +473,14 @@ static void fd_revalidate(FDrive *drv)
 static void fd_change_cb(void *opaque, bool load, Error **errp)
 {
     FDrive *drive = opaque;
-    Error *local_err = NULL;
 
     if (!load) {
         blk_set_perm(drive->blk, 0, BLK_PERM_ALL, &error_abort);
     } else {
         blkconf_apply_backend_options(drive->conf,
                                       blk_is_read_only(drive->blk), false,
-                                      &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+                                      errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     }
@@ -2528,7 +2526,6 @@ static void fdctrl_connect_drives(FDCtrl *fdctrl, DeviceState *fdc_dev,
     FDrive *drive;
     DeviceState *dev;
     BlockBackend *blk;
-    Error *local_err = NULL;
 
     for (i = 0; i < MAX_FD; i++) {
         drive = &fdctrl->drives[i];
@@ -2550,17 +2547,15 @@ static void fdctrl_connect_drives(FDCtrl *fdctrl, DeviceState *fdc_dev,
         blk_ref(blk);
         blk_detach_dev(blk, fdc_dev);
         fdctrl->qdev_for_drives[i].blk = NULL;
-        qdev_prop_set_drive(dev, "drive", blk, &local_err);
+        qdev_prop_set_drive(dev, "drive", blk, errp);
         blk_unref(blk);
 
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (ERR_IS_SET(errp)) {
             return;
         }
 
-        object_property_set_bool(OBJECT(dev), true, "realized", &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        object_property_set_bool(OBJECT(dev), true, "realized", errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     }
@@ -2689,7 +2684,6 @@ static void isabus_fdc_realize(DeviceState *dev, Error **errp)
     ISADevice *isadev = ISA_DEVICE(dev);
     FDCtrlISABus *isa = ISA_FDC(dev);
     FDCtrl *fdctrl = &isa->state;
-    Error *err = NULL;
 
     isa_register_portio_list(isadev, &fdctrl->portio_list,
                              isa->iobase, fdc_portio_list, fdctrl,
@@ -2703,9 +2697,8 @@ static void isabus_fdc_realize(DeviceState *dev, Error **errp)
     }
 
     qdev_set_legacy_instance_id(dev, isa->iobase, 2);
-    fdctrl_realize_common(dev, fdctrl, &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    fdctrl_realize_common(dev, fdctrl, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 }
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 594d4cf6fe..e634b128ce 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -706,7 +706,6 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
     int ret;
     uint64_t blocks_per_device, sector_len_per_device, device_len;
     int num_devices;
-    Error *local_err = NULL;
 
     if (pfl->sector_len == 0) {
         error_setg(errp, "attribute \"sector-length\" not specified or zero.");
@@ -747,9 +746,8 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
         &pfl->mem, OBJECT(dev),
         &pflash_cfi01_ops,
         pfl,
-        pfl->name, total_len, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+        pfl->name, total_len, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index e6c5c6c25d..2ef8c76b94 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -598,7 +598,6 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
     pflash_t *pfl = CFI_PFLASH02(dev);
     uint32_t chip_len;
     int ret;
-    Error *local_err = NULL;
 
     if (pfl->sector_len == 0) {
         error_setg(errp, "attribute \"sector-length\" not specified or zero.");
@@ -623,9 +622,8 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
 
     memory_region_init_rom_device(&pfl->orig_mem, OBJECT(pfl), pfl->be ?
                                   &pflash_cfi02_ops_be : &pflash_cfi02_ops_le,
-                                  pfl, pfl->name, chip_len, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+                                  pfl, pfl->name, chip_len, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index ce9cf63c3e..11455faebc 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -909,7 +909,6 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOBlock *s = VIRTIO_BLK(dev);
     VirtIOBlkConf *conf = &s->conf;
-    Error *err = NULL;
     unsigned i;
 
     if (!conf->conf.blk) {
@@ -928,15 +927,13 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     blkconf_serial(&conf->conf, &conf->serial);
     blkconf_apply_backend_options(&conf->conf,
                                   blk_is_read_only(conf->conf.blk), true,
-                                  &err);
-    if (err) {
-        error_propagate(errp, err);
+                                  errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     s->original_wce = blk_enable_write_cache(conf->conf.blk);
-    blkconf_geometry(&conf->conf, NULL, 65535, 255, 255, &err);
-    if (err) {
-        error_propagate(errp, err);
+    blkconf_geometry(&conf->conf, NULL, 65535, 255, 255, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     blkconf_blocksizes(&conf->conf);
@@ -951,9 +948,8 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < conf->num_queues; i++) {
         virtio_add_queue(vdev, 128, virtio_blk_handle_output);
     }
-    virtio_blk_data_plane_create(vdev, conf, &s->dataplane, &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    virtio_blk_data_plane_create(vdev, conf, &s->dataplane, errp);
+    if (ERR_IS_SET(errp)) {
         virtio_cleanup(vdev);
         return;
     }
diff --git a/hw/char/debugcon.c b/hw/char/debugcon.c
index 762e3d8ada..90e437edfb 100644
--- a/hw/char/debugcon.c
+++ b/hw/char/debugcon.c
@@ -100,11 +100,9 @@ static void debugcon_isa_realizefn(DeviceState *dev, Error **errp)
     ISADevice *d = ISA_DEVICE(dev);
     ISADebugconState *isa = ISA_DEBUGCON_DEVICE(dev);
     DebugconState *s = &isa->state;
-    Error *err = NULL;
 
-    debugcon_realize_core(s, &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    debugcon_realize_core(s, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     memory_region_init_io(&s->io, OBJECT(dev), &debugcon_ops, s,
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index 303104dd19..60074eb114 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -55,12 +55,10 @@ static void serial_pci_realize(PCIDevice *dev, Error **errp)
 {
     PCISerialState *pci = DO_UPCAST(PCISerialState, dev, dev);
     SerialState *s = &pci->state;
-    Error *err = NULL;
 
     s->baudbase = 115200;
-    serial_realize_core(s, &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    serial_realize_core(s, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -91,7 +89,6 @@ static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
     PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
     PCIMultiSerialState *pci = DO_UPCAST(PCIMultiSerialState, dev, dev);
     SerialState *s;
-    Error *err = NULL;
     int i, nr_ports = 0;
 
     switch (pc->device_id) {
@@ -115,9 +112,8 @@ static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
     for (i = 0; i < nr_ports; i++) {
         s = pci->state + i;
         s->baudbase = 115200;
-        serial_realize_core(s, &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        serial_realize_core(s, errp);
+        if (ERR_IS_SET(errp)) {
             multi_serial_pci_exit(dev);
             return;
         }
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index f5bc173844..8f0d130d49 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -926,7 +926,6 @@ static void virtser_port_device_realize(DeviceState *dev, Error **errp)
     VirtIOSerialBus *bus = VIRTIO_SERIAL_BUS(qdev_get_parent_bus(dev));
     int max_nr_ports;
     bool plugging_port0;
-    Error *err = NULL;
 
     port->vser = bus->vser;
     port->bh = qemu_bh_new(flush_queued_data_bh, port);
@@ -972,9 +971,8 @@ static void virtser_port_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    vsc->realize(dev, &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    vsc->realize(dev, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 2e7e9778cd..61e921c9ef 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -91,12 +91,10 @@ static void machine_set_kvm_shadow_mem(Object *obj, Visitor *v,
                                        Error **errp)
 {
     MachineState *ms = MACHINE(obj);
-    Error *error = NULL;
     int64_t value;
 
-    visit_type_int(v, name, &value, &error);
-    if (error) {
-        error_propagate(errp, error);
+    visit_type_int(v, name, &value, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -193,12 +191,10 @@ static void machine_set_phandle_start(Object *obj, Visitor *v,
                                       Error **errp)
 {
     MachineState *ms = MACHINE(obj);
-    Error *error = NULL;
     int64_t value;
 
-    visit_type_int(v, name, &value, &error);
-    if (error) {
-        error_propagate(errp, error);
+    visit_type_int(v, name, &value, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 73640ee3c6..68c97c08dc 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -43,7 +43,6 @@ static void set_pointer(Object *obj, Visitor *v, Property *prop,
                         const char *name, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
-    Error *local_err = NULL;
     void **ptr = qdev_get_prop_ptr(dev, prop);
     char *str;
 
@@ -52,9 +51,8 @@ static void set_pointer(Object *obj, Visitor *v, Property *prop,
         return;
     }
 
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_str(v, name, &str, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     if (!*str) {
@@ -185,7 +183,6 @@ static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
                     Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
-    Error *local_err = NULL;
     Property *prop = opaque;
     CharBackend *be = qdev_get_prop_ptr(dev, prop);
     Chardev *s;
@@ -196,9 +193,8 @@ static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
         return;
     }
 
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_str(v, name, &str, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -257,7 +253,6 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
     NICPeers *peers_ptr = qdev_get_prop_ptr(dev, prop);
     NetClientState **ncs = peers_ptr->ncs;
     NetClientState *peers[MAX_QUEUE_NUM];
-    Error *local_err = NULL;
     int queues, err = 0, i = 0;
     char *str;
 
@@ -266,9 +261,8 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_str(v, name, &str, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -361,7 +355,6 @@ static void set_vlan(Object *obj, Visitor *v, const char *name, void *opaque,
     Property *prop = opaque;
     NICPeers *peers_ptr = qdev_get_prop_ptr(dev, prop);
     NetClientState **ptr = &peers_ptr->ncs[0];
-    Error *local_err = NULL;
     int32_t id;
     NetClientState *hubport;
 
@@ -370,9 +363,8 @@ static void set_vlan(Object *obj, Visitor *v, const char *name, void *opaque,
         return;
     }
 
-    visit_type_int32(v, name, &id, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_int32(v, name, &id, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     if (id == -1) {
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 65ba36f4fb..f289841484 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -104,7 +104,6 @@ static void prop_set_bit(Object *obj, Visitor *v, const char *name,
 {
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
-    Error *local_err = NULL;
     bool value;
 
     if (dev->realized) {
@@ -112,9 +111,8 @@ static void prop_set_bit(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    visit_type_bool(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_bool(v, name, &value, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     bit_prop_set(dev, prop, value);
@@ -162,7 +160,6 @@ static void prop_set_bit64(Object *obj, Visitor *v, const char *name,
 {
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
-    Error *local_err = NULL;
     bool value;
 
     if (dev->realized) {
@@ -170,9 +167,8 @@ static void prop_set_bit64(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    visit_type_bool(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_bool(v, name, &value, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     bit64_prop_set(dev, prop, value);
@@ -410,7 +406,6 @@ static void set_string(Object *obj, Visitor *v, const char *name,
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
     char **ptr = qdev_get_prop_ptr(dev, prop);
-    Error *local_err = NULL;
     char *str;
 
     if (dev->realized) {
@@ -418,9 +413,8 @@ static void set_string(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_str(v, name, &str, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     g_free(*ptr);
@@ -470,7 +464,6 @@ static void set_mac(Object *obj, Visitor *v, const char *name, void *opaque,
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
     MACAddr *mac = qdev_get_prop_ptr(dev, prop);
-    Error *local_err = NULL;
     int i, pos;
     char *str, *p;
 
@@ -479,9 +472,8 @@ static void set_mac(Object *obj, Visitor *v, const char *name, void *opaque,
         return;
     }
 
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_str(v, name, &str, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -658,7 +650,6 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
     uint16_t value, *ptr = qdev_get_prop_ptr(dev, prop);
-    Error *local_err = NULL;
     const int64_t min = 512;
     const int64_t max = 32768;
 
@@ -667,9 +658,8 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    visit_type_uint16(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_uint16(v, name, &value, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     /* value of 0 means "unset" */
@@ -732,7 +722,6 @@ static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
     PCIHostDeviceAddress *addr = qdev_get_prop_ptr(dev, prop);
-    Error *local_err = NULL;
     char *str, *p;
     char *e;
     unsigned long val;
@@ -744,9 +733,8 @@ static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_str(v, name, &str, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -852,7 +840,6 @@ static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
     Property *prop = opaque;
     uint32_t *alenptr = qdev_get_prop_ptr(dev, prop);
     void **arrayptr = (void *)dev + prop->arrayoffset;
-    Error *local_err = NULL;
     void *eltptr;
     const char *arrayname;
     int i;
@@ -866,9 +853,8 @@ static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
                    name);
         return;
     }
-    visit_type_uint32(v, name, alenptr, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_uint32(v, name, alenptr, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     if (!*alenptr) {
@@ -905,9 +891,8 @@ static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
                             arrayprop->prop.info->get,
                             arrayprop->prop.info->set,
                             array_element_release,
-                            arrayprop, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+                            arrayprop, errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     }
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 163e827e01..cd95d8ce63 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -768,7 +768,6 @@ static void qdev_property_add_legacy(DeviceState *dev, Property *prop,
 void qdev_property_add_static(DeviceState *dev, Property *prop,
                               Error **errp)
 {
-    Error *local_err = NULL;
     Object *obj = OBJECT(dev);
 
     /*
@@ -783,10 +782,9 @@ void qdev_property_add_static(DeviceState *dev, Property *prop,
     object_property_add(obj, prop->name, prop->info->name,
                         prop->info->get, prop->info->set,
                         prop->info->release,
-                        prop, &local_err);
+                        prop, errp);
 
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 6d376b978d..e9f5caee7d 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -53,7 +53,6 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
     DeviceState *gicdev;
     SysBusDevice *busdev;
     int i;
-    Error *err = NULL;
     bool has_el3;
     Object *cpuobj;
 
@@ -71,9 +70,8 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
         qdev_prop_set_bit(gicdev, "has-security-extensions", has_el3);
     }
 
-    object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->gic), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     busdev = SYS_BUS_DEVICE(&s->gic);
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 23f2c252bd..b32fbb7a44 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -50,16 +50,14 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
     DeviceState *scudev, *gicdev, *gtimerdev, *mptimerdev, *wdtdev;
     SysBusDevice *scubusdev, *gicbusdev, *gtimerbusdev, *mptimerbusdev,
                  *wdtbusdev;
-    Error *err = NULL;
     int i;
     bool has_el3;
     Object *cpuobj;
 
     scudev = DEVICE(&s->scu);
     qdev_prop_set_uint32(scudev, "num-cpu", s->num_cpu);
-    object_property_set_bool(OBJECT(&s->scu), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->scu), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     scubusdev = SYS_BUS_DEVICE(&s->scu);
@@ -76,9 +74,8 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
         object_property_get_bool(cpuobj, "has_el3", &error_abort);
     qdev_prop_set_bit(gicdev, "has-security-extensions", has_el3);
 
-    object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->gic), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     gicbusdev = SYS_BUS_DEVICE(&s->gic);
@@ -91,27 +88,24 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
 
     gtimerdev = DEVICE(&s->gtimer);
     qdev_prop_set_uint32(gtimerdev, "num-cpu", s->num_cpu);
-    object_property_set_bool(OBJECT(&s->gtimer), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->gtimer), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     gtimerbusdev = SYS_BUS_DEVICE(&s->gtimer);
 
     mptimerdev = DEVICE(&s->mptimer);
     qdev_prop_set_uint32(mptimerdev, "num-cpu", s->num_cpu);
-    object_property_set_bool(OBJECT(&s->mptimer), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->mptimer), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     mptimerbusdev = SYS_BUS_DEVICE(&s->mptimer);
 
     wdtdev = DEVICE(&s->wdt);
     qdev_prop_set_uint32(wdtdev, "num-cpu", s->num_cpu);
-    object_property_set_bool(OBJECT(&s->wdt), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->wdt), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     wdtbusdev = SYS_BUS_DEVICE(&s->wdt);
diff --git a/hw/cpu/arm11mpcore.c b/hw/cpu/arm11mpcore.c
index eb244658b9..60336b1c0a 100644
--- a/hw/cpu/arm11mpcore.c
+++ b/hw/cpu/arm11mpcore.c
@@ -72,20 +72,17 @@ static void mpcore_priv_realize(DeviceState *dev, Error **errp)
     DeviceState *gicdev = DEVICE(&s->gic);
     DeviceState *mptimerdev = DEVICE(&s->mptimer);
     DeviceState *wdtimerdev = DEVICE(&s->wdtimer);
-    Error *err = NULL;
 
     qdev_prop_set_uint32(scudev, "num-cpu", s->num_cpu);
-    object_property_set_bool(OBJECT(&s->scu), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->scu), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
     qdev_prop_set_uint32(gicdev, "num-cpu", s->num_cpu);
     qdev_prop_set_uint32(gicdev, "num-irq", s->num_irq);
-    object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->gic), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -96,16 +93,14 @@ static void mpcore_priv_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_in(dev, mpcore_priv_set_irq, s->num_irq - 32);
 
     qdev_prop_set_uint32(mptimerdev, "num-cpu", s->num_cpu);
-    object_property_set_bool(OBJECT(&s->mptimer), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->mptimer), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
     qdev_prop_set_uint32(wdtimerdev, "num-cpu", s->num_cpu);
-    object_property_set_bool(OBJECT(&s->wdtimer), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->wdtimer), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/hw/cpu/core.c b/hw/cpu/core.c
index b38d882432..a10e655d32 100644
--- a/hw/cpu/core.c
+++ b/hw/cpu/core.c
@@ -24,12 +24,10 @@ static void core_prop_set_core_id(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
     CPUCore *core = CPU_CORE(obj);
-    Error *local_err = NULL;
     int64_t value;
 
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_int(v, name, &value, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -49,12 +47,10 @@ static void core_prop_set_nr_threads(Object *obj, Visitor *v, const char *name,
                                      void *opaque, Error **errp)
 {
     CPUCore *core = CPU_CORE(obj);
-    Error *local_err = NULL;
     int64_t value;
 
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_int(v, name, &value, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/hw/cpu/realview_mpcore.c b/hw/cpu/realview_mpcore.c
index 39d4ebeb1d..be5fad6d74 100644
--- a/hw/cpu/realview_mpcore.c
+++ b/hw/cpu/realview_mpcore.c
@@ -62,14 +62,12 @@ static void realview_mpcore_realize(DeviceState *dev, Error **errp)
     DeviceState *priv = DEVICE(&s->priv);
     DeviceState *gic;
     SysBusDevice *gicbusdev;
-    Error *err = NULL;
     int n;
     int i;
 
     qdev_prop_set_uint32(priv, "num-cpu", s->num_cpu);
-    object_property_set_bool(OBJECT(&s->priv), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->priv), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     sysbus_pass_irq(sbd, SYS_BUS_DEVICE(&s->priv));
@@ -78,9 +76,8 @@ static void realview_mpcore_realize(DeviceState *dev, Error **errp)
     }
     /* ??? IRQ routing is hardcoded to "normal" mode.  */
     for (n = 0; n < 4; n++) {
-        object_property_set_bool(OBJECT(&s->gic[n]), true, "realized", &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->gic[n]), true, "realized", errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
         gic = DEVICE(&s->gic[n]);
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index ad09bb98f9..0013b29ca5 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2163,7 +2163,6 @@ static void qxl_realize_primary(PCIDevice *dev, Error **errp)
 {
     PCIQXLDevice *qxl = PCI_QXL(dev);
     VGACommonState *vga = &qxl->vga;
-    Error *local_err = NULL;
 
     qxl->id = 0;
     qxl_init_ramsize(qxl);
@@ -2180,9 +2179,8 @@ static void qxl_realize_primary(PCIDevice *dev, Error **errp)
     vga->con = graphic_console_init(DEVICE(dev), 0, &qxl_ops, qxl);
     qemu_spice_display_init_common(&qxl->ssd);
 
-    qxl_realize_common(qxl, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    qxl_realize_common(qxl, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 58dc0b2737..9c8ecd2d87 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1104,7 +1104,6 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(qdev);
     VirtIOGPU *g = VIRTIO_GPU(qdev);
     bool have_virgl;
-    Error *local_err = NULL;
     int i;
 
     if (g->conf.max_outputs > VIRTIO_GPU_MAX_SCANOUTS) {
@@ -1124,9 +1123,8 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
 
     if (virtio_gpu_virgl_enabled(g->conf)) {
         error_setg(&g->migration_blocker, "virgl is not yet migratable");
-        migrate_add_blocker(g->migration_blocker, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        migrate_add_blocker(g->migration_blocker, errp);
+        if (ERR_IS_SET(errp)) {
             error_free(g->migration_blocker);
             return;
         }
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index f9b017d86b..f18484e333 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -101,7 +101,6 @@ static void virtio_vga_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     VirtIOVGA *vvga = VIRTIO_VGA(vpci_dev);
     VirtIOGPU *g = &vvga->vdev;
     VGACommonState *vga = &vvga->vga;
-    Error *err = NULL;
     uint32_t offset;
     int i;
 
@@ -146,9 +145,8 @@ static void virtio_vga_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     /* init virtio bits */
     qdev_set_parent_bus(DEVICE(g), BUS(&vpci_dev->bus));
     virtio_pci_force_virtio_1(vpci_dev);
-    object_property_set_bool(OBJECT(g), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(g), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/hw/i386/kvm/pci-assign.c b/hw/i386/kvm/pci-assign.c
index bc8795f7f3..194ebb70f3 100644
--- a/hw/i386/kvm/pci-assign.c
+++ b/hw/i386/kvm/pci-assign.c
@@ -838,7 +838,6 @@ static int assign_intx(AssignedDevice *dev, Error **errp)
     PCIINTxRoute intx_route;
     bool intx_host_msi;
     int r;
-    Error *local_err = NULL;
 
     /* Interrupt PIN 0 means don't use INTx */
     if (assigned_dev_pci_read_byte(&dev->dev, PCI_INTERRUPT_PIN) == 0) {
@@ -846,9 +845,8 @@ static int assign_intx(AssignedDevice *dev, Error **errp)
         return 0;
     }
 
-    verify_irqchip_in_kernel(&local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    verify_irqchip_in_kernel(errp);
+    if (ERR_IS_SET(errp)) {
         return -ENOTSUP;
     }
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index efa6c35157..7ce0ed96de 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1111,7 +1111,6 @@ void pc_hot_add_cpu(const int64_t id, Error **errp)
     ObjectClass *oc;
     MachineState *ms = MACHINE(qdev_get_machine());
     int64_t apic_id = x86_cpu_apic_id_from_index(id);
-    Error *local_err = NULL;
 
     if (id < 0) {
         error_setg(errp, "Invalid CPU id: %" PRIi64, id);
@@ -1127,9 +1126,8 @@ void pc_hot_add_cpu(const int64_t id, Error **errp)
 
     assert(ms->possible_cpus->cpus[0].cpu); /* BSP is always present */
     oc = OBJECT_CLASS(CPU_GET_CLASS(ms->possible_cpus->cpus[0].cpu));
-    pc_new_cpu(object_class_get_name(oc), apic_id, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    pc_new_cpu(object_class_get_name(oc), apic_id, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 }
diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index 0e42f0d02c..beb38528bd 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -235,12 +235,10 @@ static void virtio_input_device_realize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOInput *vinput = VIRTIO_INPUT(dev);
     VirtIOInputConfig *cfg;
-    Error *local_err = NULL;
 
     if (vic->realize) {
-        vic->realize(dev, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        vic->realize(dev, errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     }
@@ -278,12 +276,10 @@ static void virtio_input_device_unrealize(DeviceState *dev, Error **errp)
 {
     VirtIOInputClass *vic = VIRTIO_INPUT_GET_CLASS(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    Error *local_err = NULL;
 
     if (vic->unrealize) {
-        vic->unrealize(dev, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        vic->unrealize(dev, errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     }
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 09b75a3048..536cbad4d0 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -461,7 +461,6 @@ static void apic_common_set_id(Object *obj, Visitor *v, const char *name,
 {
     APICCommonState *s = APIC_COMMON(obj);
     DeviceState *dev = DEVICE(obj);
-    Error *local_err = NULL;
     int64_t value;
 
     if (dev->realized) {
@@ -469,9 +468,8 @@ static void apic_common_set_id(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_int(v, name, &value, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index b305d9032a..aa01bac522 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -1404,11 +1404,9 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
     GICState *s = ARM_GIC(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     ARMGICClass *agc = ARM_GIC_GET_CLASS(s);
-    Error *local_err = NULL;
 
-    agc->parent_realize(dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    agc->parent_realize(dev, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
index af5cd367e9..00f1b704be 100644
--- a/hw/intc/arm_gic_kvm.c
+++ b/hw/intc/arm_gic_kvm.c
@@ -495,12 +495,10 @@ static void kvm_arm_gic_realize(DeviceState *dev, Error **errp)
     int i;
     GICState *s = KVM_ARM_GIC(dev);
     KVMARMGICClass *kgc = KVM_ARM_GIC_GET_CLASS(s);
-    Error *local_err = NULL;
     int ret;
 
-    kgc->parent_realize(dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    kgc->parent_realize(dev, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -513,9 +511,8 @@ static void kvm_arm_gic_realize(DeviceState *dev, Error **errp)
     if (!kvm_arm_gic_can_save_restore(s)) {
         error_setg(&s->migration_blocker, "This operating system kernel does "
                                           "not support vGICv2 migration");
-        migrate_add_blocker(s->migration_blocker, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        migrate_add_blocker(s->migration_blocker, errp);
+        if (ERR_IS_SET(errp)) {
             error_free(s->migration_blocker);
             return;
         }
diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
index f0c967b304..1dd941fef3 100644
--- a/hw/intc/arm_gicv3.c
+++ b/hw/intc/arm_gicv3.c
@@ -365,11 +365,9 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
     /* Device instance realize function for the GIC sysbus device */
     GICv3State *s = ARM_GICV3(dev);
     ARMGICv3Class *agc = ARM_GICV3_GET_CLASS(s);
-    Error *local_err = NULL;
 
-    agc->parent_realize(dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    agc->parent_realize(dev, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index a0441d6bd1..edeb4334d1 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -56,16 +56,14 @@ static int kvm_its_send_msi(GICv3ITSState *s, uint32_t value, uint16_t devid)
 static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
 {
     GICv3ITSState *s = ARM_GICV3_ITS_COMMON(dev);
-    Error *local_err = NULL;
 
     /*
      * Block migration of a KVM GICv3 ITS device: the API for saving and
      * restoring the state in the kernel is not yet available
      */
     error_setg(&s->migration_blocker, "vITS migration is not implemented");
-    migrate_add_blocker(s->migration_blocker, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    migrate_add_blocker(s->migration_blocker, errp);
+    if (ERR_IS_SET(errp)) {
         error_free(s->migration_blocker);
         return;
     }
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 4ee2baa691..21e86edb17 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -684,14 +684,12 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
 {
     GICv3State *s = KVM_ARM_GICV3(dev);
     KVMARMGICv3Class *kgc = KVM_ARM_GICV3_GET_CLASS(s);
-    Error *local_err = NULL;
     int i;
 
     DPRINTF("kvm_arm_gicv3_realize\n");
 
-    kgc->parent_realize(dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    kgc->parent_realize(dev, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -744,9 +742,8 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
                                GICD_CTLR)) {
         error_setg(&s->migration_blocker, "This operating system kernel does "
                                           "not support vGICv3 migration");
-        migrate_add_blocker(s->migration_blocker, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        migrate_add_blocker(s->migration_blocker, errp);
+        if (ERR_IS_SET(errp)) {
             error_free(s->migration_blocker);
             return;
         }
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 26a4b2dcb5..7795c0623f 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1003,7 +1003,6 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
 {
     NVICState *s = NVIC(dev);
     SysBusDevice *systick_sbd;
-    Error *err = NULL;
 
     s->cpu = ARM_CPU(qemu_get_cpu(0));
     assert(s->cpu);
@@ -1018,9 +1017,8 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
     /* include space for internal exception vectors */
     s->num_irq += NVIC_FIRST_IRQ;
 
-    object_property_set_bool(OBJECT(&s->systick), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->systick), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     systick_sbd = SYS_BUS_DEVICE(&s->systick);
diff --git a/hw/intc/realview_gic.c b/hw/intc/realview_gic.c
index 50bbab66ee..1b114e7065 100644
--- a/hw/intc/realview_gic.c
+++ b/hw/intc/realview_gic.c
@@ -23,7 +23,6 @@ static void realview_gic_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     RealViewGICState *s = REALVIEW_GIC(dev);
     SysBusDevice *busdev;
-    Error *err = NULL;
     /* The GICs on the RealView boards have a fixed nonconfigurable
      * number of interrupt lines, so we don't need to expose this as
      * a qdev property.
@@ -31,9 +30,8 @@ static void realview_gic_realize(DeviceState *dev, Error **errp)
     int numirq = 96;
 
     qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", numirq);
-    object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->gic), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     busdev = SYS_BUS_DEVICE(&s->gic);
diff --git a/hw/ipack/ipack.c b/hw/ipack/ipack.c
index 6021e6d135..e380f4f369 100644
--- a/hw/ipack/ipack.c
+++ b/hw/ipack/ipack.c
@@ -60,11 +60,9 @@ static void ipack_device_unrealize(DeviceState *dev, Error **errp)
 {
     IPackDevice *idev = IPACK_DEVICE(dev);
     IPackDeviceClass *k = IPACK_DEVICE_GET_CLASS(dev);
-    Error *err = NULL;
 
     if (k->unrealize) {
-        k->unrealize(dev, &err);
-        error_propagate(errp, err);
+        k->unrealize(dev, errp);
         return;
     }
 
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 6367d041f0..a68342bd0e 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -463,7 +463,6 @@ static void setup_interrupt(IVShmemState *s, int vector, Error **errp)
     bool with_irqfd = kvm_msi_via_irqfd_enabled() &&
         ivshmem_has_feature(s, IVSHMEM_MSI);
     PCIDevice *pdev = PCI_DEVICE(s);
-    Error *err = NULL;
 
     IVSHMEM_DPRINTF("setting up interrupt for vector: %d\n", vector);
 
@@ -472,9 +471,8 @@ static void setup_interrupt(IVShmemState *s, int vector, Error **errp)
         watch_vector_notifier(s, n, vector);
     } else if (msix_enabled(pdev)) {
         IVSHMEM_DPRINTF("with irqfd\n");
-        ivshmem_add_kvm_msi_virq(s, vector, &err);
-        if (err) {
-            error_propagate(errp, err);
+        ivshmem_add_kvm_msi_virq(s, vector, errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
 
@@ -836,11 +834,9 @@ static void ivshmem_write_config(PCIDevice *pdev, uint32_t address,
 static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
 {
     IVShmemState *s = IVSHMEM_COMMON(dev);
-    Error *err = NULL;
     uint8_t *pci_conf;
     uint8_t attr = PCI_BASE_ADDRESS_SPACE_MEMORY |
         PCI_BASE_ADDRESS_MEM_PREFETCH;
-    Error *local_err = NULL;
 
     /* IRQFD requires MSI */
     if (ivshmem_has_feature(s, IVSHMEM_IOEVENTFD) &&
@@ -883,9 +879,8 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
          * Older versions did it asynchronously, but that creates a
          * number of entertaining race conditions.
          */
-        ivshmem_recv_setup(s, &err);
-        if (err) {
-            error_propagate(errp, err);
+        ivshmem_recv_setup(s, errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
 
@@ -911,9 +906,8 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
     if (!ivshmem_is_master(s)) {
         error_setg(&s->migration_blocker,
                    "Migration is disabled when using feature 'peer mode' in device 'ivshmem'");
-        migrate_add_blocker(s->migration_blocker, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        migrate_add_blocker(s->migration_blocker, errp);
+        if (ERR_IS_SET(errp)) {
             error_free(s->migration_blocker);
             return;
         }
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index fed0c6b269..c5945b81f7 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -126,15 +126,13 @@ static void macio_common_realize(PCIDevice *d, Error **errp)
 {
     MacIOState *s = MACIO(d);
     SysBusDevice *sysbus_dev;
-    Error *err = NULL;
     MemoryRegion *dbdma_mem;
 
     s->dbdma = DBDMA_init(&dbdma_mem);
     memory_region_add_subregion(&s->bar, 0x08000, dbdma_mem);
 
-    object_property_set_bool(OBJECT(&s->cuda), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->cuda), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     sysbus_dev = SYS_BUS_DEVICE(&s->cuda);
@@ -162,23 +160,20 @@ static void macio_oldworld_realize(PCIDevice *d, Error **errp)
 {
     MacIOState *s = MACIO(d);
     OldWorldMacIOState *os = OLDWORLD_MACIO(d);
-    Error *err = NULL;
     SysBusDevice *sysbus_dev;
     int i;
     int cur_irq = 0;
 
-    macio_common_realize(d, &err);
-    if (err) {
-        error_propagate(errp, err);
+    macio_common_realize(d, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
     sysbus_dev = SYS_BUS_DEVICE(&s->cuda);
     sysbus_connect_irq(sysbus_dev, 0, os->irqs[cur_irq++]);
 
-    object_property_set_bool(OBJECT(&os->nvram), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&os->nvram), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     sysbus_dev = SYS_BUS_DEVICE(&os->nvram);
@@ -196,9 +191,8 @@ static void macio_oldworld_realize(PCIDevice *d, Error **errp)
         qemu_irq irq0 = os->irqs[cur_irq++];
         qemu_irq irq1 = os->irqs[cur_irq++];
 
-        macio_realize_ide(s, &os->ide[i], irq0, irq1, 0x16 + (i * 4), &err);
-        if (err) {
-            error_propagate(errp, err);
+        macio_realize_ide(s, &os->ide[i], irq0, irq1, 0x16 + (i * 4), errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     }
@@ -273,15 +267,13 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
 {
     MacIOState *s = MACIO(d);
     NewWorldMacIOState *ns = NEWWORLD_MACIO(d);
-    Error *err = NULL;
     SysBusDevice *sysbus_dev;
     MemoryRegion *timer_memory = NULL;
     int i;
     int cur_irq = 0;
 
-    macio_common_realize(d, &err);
-    if (err) {
-        error_propagate(errp, err);
+    macio_common_realize(d, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -298,9 +290,8 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
         qemu_irq irq0 = ns->irqs[cur_irq++];
         qemu_irq irq1 = ns->irqs[cur_irq++];
 
-        macio_realize_ide(s, &ns->ide[i], irq0, irq1, 0x16 + (i * 4), &err);
-        if (err) {
-            error_propagate(errp, err);
+        macio_realize_ide(s, &ns->ide[i], irq0, irq1, 0x16 + (i * 4), errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     }
diff --git a/hw/misc/tmp105.c b/hw/misc/tmp105.c
index 82a25b91f4..1b0584d14b 100644
--- a/hw/misc/tmp105.c
+++ b/hw/misc/tmp105.c
@@ -70,12 +70,10 @@ static void tmp105_set_temperature(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
     TMP105State *s = TMP105(obj);
-    Error *local_err = NULL;
     int64_t temp;
 
-    visit_type_int(v, name, &temp, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_int(v, name, &temp, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     if (temp >= 128000 || temp < -128000) {
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index b53fcaa8bc..5142003d07 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -874,7 +874,6 @@ static void dp8393x_realize(DeviceState *dev, Error **errp)
     dp8393xState *s = DP8393X(dev);
     int i, checksum;
     uint8_t *prom;
-    Error *local_err = NULL;
 
     address_space_init(&s->as, s->dma_mr, "dp8393x");
     memory_region_init_io(&s->mmio, OBJECT(dev), &dp8393x_ops, s,
@@ -888,9 +887,8 @@ static void dp8393x_realize(DeviceState *dev, Error **errp)
     s->regs[SONIC_SR] = 0x0004; /* only revision recognized by Linux */
 
     memory_region_init_ram(&s->prom, OBJECT(dev),
-                           "dp8393x-prom", SONIC_PROM_SIZE, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+                           "dp8393x-prom", SONIC_PROM_SIZE, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     memory_region_set_readonly(&s->prom, true);
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 44da2caf51..43118044f1 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1073,11 +1073,9 @@ static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
 {
     FWCfgIoState *s = FW_CFG_IO(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    Error *local_err = NULL;
 
-    fw_cfg_file_slots_allocate(FW_CFG(s), &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    fw_cfg_file_slots_allocate(FW_CFG(s), errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -1126,11 +1124,9 @@ static void fw_cfg_mem_realize(DeviceState *dev, Error **errp)
     FWCfgMemState *s = FW_CFG_MEM(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     const MemoryRegionOps *data_ops = &fw_cfg_data_mem_ops;
-    Error *local_err = NULL;
 
-    fw_cfg_file_slots_allocate(FW_CFG(s), &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    fw_cfg_file_slots_allocate(FW_CFG(s), errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index ff59abf208..54132c52ad 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -216,7 +216,6 @@ static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error **errp)
     DeviceState *ds, *bds = NULL;
     PCIBus *bus;
     const char *dev_name = NULL;
-    Error *local_err = NULL;
 
     if (pxb->numa_node != NUMA_NODE_UNASSIGNED &&
         pxb->numa_node >= nb_numa_nodes) {
@@ -246,9 +245,8 @@ static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error **errp)
 
     PCI_HOST_BRIDGE(ds)->bus = bus;
 
-    pxb_register_bus(dev, bus, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    pxb_register_bus(dev, bus, errp);
+    if (ERR_IS_SET(errp)) {
         goto err_register_bus;
     }
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index a848d1508b..4e25eee0ad 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -960,7 +960,6 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
     PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(pci_dev);
     PCIConfigReadFunc *config_read = pc->config_read;
     PCIConfigWriteFunc *config_write = pc->config_write;
-    Error *local_err = NULL;
     DeviceState *dev = DEVICE(pci_dev);
 
     pci_dev->bus = bus;
@@ -1039,9 +1038,8 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
     if (pc->is_bridge) {
         pci_init_mask_bridge(pci_dev);
     }
-    pci_init_multifunction(bus, pci_dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    pci_init_multifunction(bus, pci_dev, errp);
+    if (ERR_IS_SET(errp)) {
         do_pci_unregister_device(pci_dev);
         return NULL;
     }
@@ -1983,7 +1981,6 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
 {
     PCIDevice *pci_dev = (PCIDevice *)qdev;
     PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(pci_dev);
-    Error *local_err = NULL;
     PCIBus *bus;
     bool is_default_rom;
 
@@ -2000,9 +1997,8 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         return;
 
     if (pc->realize) {
-        pc->realize(pci_dev, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        pc->realize(pci_dev, errp);
+        if (ERR_IS_SET(errp)) {
             do_pci_unregister_device(pci_dev);
             return;
         }
@@ -2015,9 +2011,8 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         is_default_rom = true;
     }
 
-    pci_add_option_rom(pci_dev, is_default_rom, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    pci_add_option_rom(pci_dev, is_default_rom, errp);
+    if (ERR_IS_SET(errp)) {
         pci_qdev_unrealize(DEVICE(pci_dev), IGNORE_ERRORS);
         return;
     }
diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index 844bc97737..f3ea297a4d 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -508,14 +508,12 @@ static void shpc_device_hotplug_common(PCIDevice *affected_dev, int *slot,
 void shpc_device_hotplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                             Error **errp)
 {
-    Error *local_err = NULL;
     PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
     SHPCDevice *shpc = pci_hotplug_dev->shpc;
     int slot;
 
-    shpc_device_hotplug_common(PCI_DEVICE(dev), &slot, shpc, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    shpc_device_hotplug_common(PCI_DEVICE(dev), &slot, shpc, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -551,16 +549,14 @@ void shpc_device_hotplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
 void shpc_device_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
                                        DeviceState *dev, Error **errp)
 {
-    Error *local_err = NULL;
     PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
     SHPCDevice *shpc = pci_hotplug_dev->shpc;
     uint8_t state;
     uint8_t led;
     int slot;
 
-    shpc_device_hotplug_common(PCI_DEVICE(dev), &slot, shpc, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    shpc_device_hotplug_common(PCI_DEVICE(dev), &slot, shpc, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 04621d5534..1b9abbb094 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -708,16 +708,14 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE500Params *params,
 static DeviceState *ppce500_init_mpic_kvm(PPCE500Params *params,
                                           qemu_irq **irqs, Error **errp)
 {
-    Error *err = NULL;
     DeviceState *dev;
     CPUState *cs;
 
     dev = qdev_create(NULL, TYPE_KVM_OPENPIC);
     qdev_prop_set_uint32(dev, "model", params->mpic_version);
 
-    object_property_set_bool(OBJECT(dev), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(dev), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         object_unparent(OBJECT(dev));
         return NULL;
     }
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 655f1da14c..0e5236e577 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -885,7 +885,6 @@ static void pnv_chip_icp_realize(PnvChip *chip, Error **errp)
 static void pnv_chip_realize(DeviceState *dev, Error **errp)
 {
     PnvChip *chip = PNV_CHIP(dev);
-    Error *error = NULL;
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
     char *typename = pnv_core_typename(pcc->cpu_model);
     size_t typesize = object_type_get_instance_size(typename);
@@ -897,17 +896,15 @@ static void pnv_chip_realize(DeviceState *dev, Error **errp)
     }
 
     /* XSCOM bridge */
-    pnv_xscom_realize(chip, &error);
-    if (error) {
-        error_propagate(errp, error);
+    pnv_xscom_realize(chip, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(chip), 0, PNV_XSCOM_BASE(chip));
 
     /* Cores */
-    pnv_chip_core_sanitize(chip, &error);
-    if (error) {
-        error_propagate(errp, error);
+    pnv_chip_core_sanitize(chip, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -955,26 +952,23 @@ static void pnv_chip_realize(DeviceState *dev, Error **errp)
 
     /* Interrupt Management Area. This is the memory region holding
      * all the Interrupt Control Presenter (ICP) registers */
-    pnv_chip_icp_realize(chip, &error);
-    if (error) {
-        error_propagate(errp, error);
+    pnv_chip_icp_realize(chip, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
     /* Processor Service Interface (PSI) Host Bridge */
     object_property_set_int(OBJECT(&chip->psi), PNV_PSIHB_BASE(chip),
                             "bar", &error_fatal);
-    object_property_set_bool(OBJECT(&chip->psi), true, "realized", &error);
-    if (error) {
-        error_propagate(errp, error);
+    object_property_set_bool(OBJECT(&chip->psi), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     pnv_xscom_add_subregion(chip, PNV_XSCOM_PSIHB_BASE, &chip->psi.xscom_regs);
 
     /* Create the simplified OCC model */
-    object_property_set_bool(OBJECT(&chip->occ), true, "realized", &error);
-    if (error) {
-        error_propagate(errp, error);
+    object_property_set_bool(OBJECT(&chip->occ), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     pnv_xscom_add_subregion(chip, PNV_XSCOM_OCC_BASE, &chip->occ.xscom_regs);
@@ -1083,11 +1077,9 @@ static void pnv_set_num_chips(Object *obj, Visitor *v, const char *name,
 {
     PnvMachineState *pnv = POWERNV_MACHINE(obj);
     uint32_t num_chips;
-    Error *local_err = NULL;
 
-    visit_type_uint32(v, name, &num_chips, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_uint32(v, name, &num_chips, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 161f7dbc62..24d132cc3e 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -113,7 +113,6 @@ static const MemoryRegionOps pnv_core_xscom_ops = {
 
 static void pnv_core_realize_child(Object *child, XICSFabric *xi, Error **errp)
 {
-    Error *local_err = NULL;
     CPUState *cs = CPU(child);
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     Object *obj;
@@ -121,23 +120,20 @@ static void pnv_core_realize_child(Object *child, XICSFabric *xi, Error **errp)
     obj = object_new(TYPE_PNV_ICP);
     object_property_add_child(OBJECT(cpu), "icp", obj, IGNORE_ERRORS);
     object_property_add_const_link(obj, "xics", OBJECT(xi), &error_abort);
-    object_property_set_bool(obj, true, "realized", &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    object_property_set_bool(obj, true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
-    object_property_set_bool(child, true, "realized", &local_err);
-    if (local_err) {
+    object_property_set_bool(child, true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         object_unparent(obj);
-        error_propagate(errp, local_err);
         return;
     }
 
-    powernv_cpu_init(cpu, &local_err);
-    if (local_err) {
+    powernv_cpu_init(cpu, errp);
+    if (ERR_IS_SET(errp)) {
         object_unparent(obj);
-        error_propagate(errp, local_err);
         return;
     }
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index af33297e0f..f39fd1e06f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2823,7 +2823,6 @@ void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState *dev,
     int index;
     sPAPRDRConnector *drc;
     sPAPRDRConnectorClass *drck;
-    Error *local_err = NULL;
     CPUCore *cc = CPU_CORE(dev);
     int smt = kvmppc_smt_threads();
 
@@ -2841,9 +2840,8 @@ void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState *dev,
     g_assert(drc);
 
     drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-    drck->detach(drc, dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    drck->detach(drc, dev, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -2859,7 +2857,6 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     CPUCore *cc = CPU_CORE(dev);
     CPUState *cs = CPU(core->threads);
     sPAPRDRConnector *drc;
-    Error *local_err = NULL;
     void *fdt = NULL;
     int fdt_offset = 0;
     int smt = kvmppc_smt_threads();
@@ -2886,10 +2883,9 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
     if (drc) {
         sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
-        drck->attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, &local_err);
-        if (local_err) {
+        drck->attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, errp);
+        if (ERR_IS_SET(errp)) {
             g_free(fdt);
-            error_propagate(errp, local_err);
             return;
         }
     }
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 1b0a7546fb..867fe9cd84 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -239,7 +239,6 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(obj);
-    Error *err = NULL;
     int fdt_offset_next, fdt_offset, fdt_depth;
     void *fdt;
 
@@ -263,19 +262,17 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
         case FDT_BEGIN_NODE:
             fdt_depth++;
             name = fdt_get_name(fdt, fdt_offset, &name_len);
-            visit_start_struct(v, name, NULL, 0, &err);
-            if (err) {
-                error_propagate(errp, err);
+            visit_start_struct(v, name, NULL, 0, errp);
+            if (ERR_IS_SET(errp)) {
                 return;
             }
             break;
         case FDT_END_NODE:
             /* shouldn't ever see an FDT_END_NODE before FDT_BEGIN_NODE */
             g_assert(fdt_depth > 0);
-            visit_check_struct(v, &err);
+            visit_check_struct(v, errp);
             visit_end_struct(v, NULL);
-            if (err) {
-                error_propagate(errp, err);
+            if (ERR_IS_SET(errp)) {
                 return;
             }
             fdt_depth--;
@@ -284,22 +281,19 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
             int i;
             prop = fdt_get_property_by_offset(fdt, fdt_offset, &prop_len);
             name = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
-            visit_start_list(v, name, NULL, 0, &err);
-            if (err) {
-                error_propagate(errp, err);
+            visit_start_list(v, name, NULL, 0, errp);
+            if (ERR_IS_SET(errp)) {
                 return;
             }
             for (i = 0; i < prop_len; i++) {
-                visit_type_uint8(v, NULL, (uint8_t *)&prop->data[i], &err);
-                if (err) {
-                    error_propagate(errp, err);
+                visit_type_uint8(v, NULL, (uint8_t *)&prop->data[i], errp);
+                if (ERR_IS_SET(errp)) {
                     return;
                 }
             }
-            visit_check_list(v, &err);
+            visit_check_list(v, errp);
             visit_end_list(v, NULL);
-            if (err) {
-                error_propagate(errp, err);
+            if (ERR_IS_SET(errp)) {
                 return;
             }
             break;
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 5b3660b674..03eff2f67c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1429,7 +1429,6 @@ static void spapr_phb_hot_plug_child(HotplugHandler *plug_handler,
     sPAPRPHBState *phb = SPAPR_PCI_HOST_BRIDGE(DEVICE(plug_handler));
     PCIDevice *pdev = PCI_DEVICE(plugged_dev);
     sPAPRDRConnector *drc = spapr_phb_get_pci_drc(phb, pdev);
-    Error *local_err = NULL;
     PCIBus *bus = PCI_BUS(qdev_get_parent_bus(DEVICE(pdev)));
     uint32_t slotnr = PCI_SLOT(pdev->devfn);
 
@@ -1461,9 +1460,8 @@ static void spapr_phb_hot_plug_child(HotplugHandler *plug_handler,
         return;
     }
 
-    spapr_phb_add_pci_device(drc, phb, pdev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    spapr_phb_add_pci_device(drc, phb, pdev, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -1497,7 +1495,6 @@ static void spapr_phb_hot_unplug_child(HotplugHandler *plug_handler,
     PCIDevice *pdev = PCI_DEVICE(plugged_dev);
     sPAPRDRConnectorClass *drck;
     sPAPRDRConnector *drc = spapr_phb_get_pci_drc(phb, pdev);
-    Error *local_err = NULL;
 
     if (!phb->dr_enabled) {
         error_setg(errp, QERR_BUS_NO_HOTPLUG,
@@ -1534,9 +1531,8 @@ static void spapr_phb_hot_unplug_child(HotplugHandler *plug_handler,
             }
         }
 
-        spapr_phb_remove_pci_device(drc, phb, pdev, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        spapr_phb_remove_pci_device(drc, phb, pdev, errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
 
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index 823747fcd7..49e20a5786 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -30,12 +30,10 @@ static void ccw_device_unplug(HotplugHandler *hotplug_dev,
     CcwDevice *ccw_dev = CCW_DEVICE(dev);
     CCWDeviceClass *k = CCW_DEVICE_GET_CLASS(ccw_dev);
     SubchDev *sch = ccw_dev->sch;
-    Error *err = NULL;
 
     if (k->unplug) {
-        k->unplug(hotplug_dev, dev, &err);
-        if (err) {
-            error_propagate(errp, err);
+        k->unplug(hotplug_dev, dev, errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     }
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index c39e65f206..cf3a3fa70a 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1974,7 +1974,6 @@ static void set_css_devid(Object *obj, Visitor *v, const char *name,
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
     CssDevId *dev_id = qdev_get_prop_ptr(dev, prop);
-    Error *local_err = NULL;
     char *str;
     int num, n1, n2;
     unsigned int cssid, ssid, devid;
@@ -1984,9 +1983,8 @@ static void set_css_devid(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    visit_type_str(v, name, &str, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_str(v, name, &str, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 9c56e17196..5cace901e0 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -901,12 +901,10 @@ static void virtio_ccw_rng_realize(VirtioCcwDevice *ccw_dev, Error **errp)
 {
     VirtIORNGCcw *dev = VIRTIO_RNG_CCW(ccw_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);
-    Error *err = NULL;
 
     qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -919,12 +917,10 @@ static void virtio_ccw_crypto_realize(VirtioCcwDevice *ccw_dev, Error **errp)
 {
     VirtIOCryptoCcw *dev = VIRTIO_CRYPTO_CCW(ccw_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);
-    Error *err = NULL;
 
     qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -1762,11 +1758,9 @@ static void vhost_vsock_ccw_realize(VirtioCcwDevice *ccw_dev, Error **errp)
 {
     VHostVSockCCWState *dev = VHOST_VSOCK_CCW(ccw_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);
-    Error *err = NULL;
 
     qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", &err);
-    error_propagate(errp, err);
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
 }
 
 static void vhost_vsock_ccw_class_init(ObjectClass *klass, void *data)
diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index e295d88939..30f866d5a0 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -462,15 +462,13 @@ static void dc390_write_config(PCIDevice *dev,
 static void dc390_scsi_realize(PCIDevice *dev, Error **errp)
 {
     DC390State *pci = DC390(dev);
-    Error *err = NULL;
     uint8_t *contents;
     uint16_t chksum = 0;
     int i;
 
     /* init base class */
-    esp_pci_scsi_realize(dev, &err);
-    if (err) {
-        error_propagate(errp, err);
+    esp_pci_scsi_realize(dev, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 796ae562bf..bb9f5628db 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -152,7 +152,6 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
     SCSIDevice *dev = SCSI_DEVICE(qdev);
     SCSIBus *bus = DO_UPCAST(SCSIBus, qbus, dev->qdev.parent_bus);
     SCSIDevice *d;
-    Error *local_err = NULL;
 
     if (dev->channel > bus->info->max_channel) {
         error_setg(errp, "bad scsi channel id: %d", dev->channel);
@@ -200,9 +199,8 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
     }
 
     QTAILQ_INIT(&dev->requests);
-    scsi_device_realize(dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    scsi_device_realize(dev, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     dev->vmsentry = qemu_add_vm_change_state_handler(scsi_dma_restart_cb,
@@ -229,7 +227,6 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
     const char *driver;
     char *name;
     DeviceState *dev;
-    Error *err = NULL;
 
     driver = blk_is_sg(blk) ? "scsi-generic" : "scsi-disk";
     dev = qdev_create(&bus->qbus, driver);
@@ -248,15 +245,13 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
     if (serial && object_property_find(OBJECT(dev), "serial", IGNORE_ERRORS)) {
         qdev_prop_set_string(dev, "serial", serial);
     }
-    qdev_prop_set_drive(dev, "drive", blk, &err);
-    if (err) {
-        error_propagate(errp, err);
+    qdev_prop_set_drive(dev, "drive", blk, errp);
+    if (ERR_IS_SET(errp)) {
         object_unparent(OBJECT(dev));
         return NULL;
     }
-    object_property_set_bool(OBJECT(dev), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(dev), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         object_unparent(OBJECT(dev));
         return NULL;
     }
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index a53f058621..d5c984504b 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2306,7 +2306,6 @@ static void scsi_disk_unit_attention_reported(SCSIDevice *dev)
 static void scsi_realize(SCSIDevice *dev, Error **errp)
 {
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
-    Error *err = NULL;
 
     if (!s->qdev.conf.blk) {
         error_setg(errp, "drive property not set");
@@ -2322,17 +2321,15 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
     blkconf_serial(&s->qdev.conf, &s->serial);
     blkconf_blocksizes(&s->qdev.conf);
     if (dev->type == TYPE_DISK) {
-        blkconf_geometry(&dev->conf, NULL, 65535, 255, 255, &err);
-        if (err) {
-            error_propagate(errp, err);
+        blkconf_geometry(&dev->conf, NULL, 65535, 255, 255, errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     }
     blkconf_apply_backend_options(&dev->conf,
                                   blk_is_read_only(s->qdev.conf.blk),
-                                  dev->type == TYPE_DISK, &err);
-    if (err) {
-        error_propagate(errp, err);
+                                  dev->type == TYPE_DISK, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index c44d1045b6..dea479b7ba 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -139,7 +139,6 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
 {
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(dev);
-    Error *err = NULL;
     int vhostfd = -1;
     int ret;
 
@@ -167,17 +166,15 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
                                vhost_dummy_handle_output,
                                vhost_dummy_handle_output,
                                vhost_dummy_handle_output,
-                               &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+                               errp);
+    if (ERR_IS_SET(errp)) {
         goto close_fd;
     }
 
     error_setg(&vsc->migration_blocker,
                "vhost-scsi does not support migration");
-    migrate_add_blocker(vsc->migration_blocker, &err);
-    if (err) {
-        error_propagate(errp, err);
+    migrate_add_blocker(vsc->migration_blocker, errp);
+    if (ERR_IS_SET(errp)) {
         error_free(vsc->migration_blocker);
         goto close_fd;
     }
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index f46f06d055..a253b5df59 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -877,15 +877,13 @@ static void virtio_scsi_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOSCSI *s = VIRTIO_SCSI(dev);
-    Error *err = NULL;
 
     virtio_scsi_common_realize(dev,
                                virtio_scsi_handle_ctrl,
                                virtio_scsi_handle_event,
                                virtio_scsi_handle_cmd,
-                               &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+                               errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index c25247e3cb..9c747821d2 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -246,7 +246,6 @@ void usb_device_free_streams(USBDevice *dev, USBEndpoint **eps, int nr_eps)
 static void usb_qdev_realize(DeviceState *qdev, Error **errp)
 {
     USBDevice *dev = USB_DEVICE(qdev);
-    Error *local_err = NULL;
 
     pstrcpy(dev->product_desc, sizeof(dev->product_desc),
             usb_device_get_product_desc(dev));
@@ -254,24 +253,21 @@ static void usb_qdev_realize(DeviceState *qdev, Error **errp)
     QLIST_INIT(&dev->strings);
     usb_ep_init(dev);
 
-    usb_claim_port(dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    usb_claim_port(dev, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
-    usb_device_realize(dev, &local_err);
-    if (local_err) {
+    usb_device_realize(dev, errp);
+    if (ERR_IS_SET(errp)) {
         usb_release_port(dev);
-        error_propagate(errp, local_err);
         return;
     }
 
     if (dev->auto_attach) {
-        usb_device_attach(dev, &local_err);
-        if (local_err) {
+        usb_device_attach(dev, errp);
+        if (ERR_IS_SET(errp)) {
             usb_qdev_unrealize(qdev, IGNORE_ERRORS);
-            error_propagate(errp, local_err);
             return;
         }
     }
@@ -330,7 +326,6 @@ USBDevice *usb_create(USBBus *bus, const char *name)
 static USBDevice *usb_try_create_simple(USBBus *bus, const char *name,
                                         Error **errp)
 {
-    Error *err = NULL;
     USBDevice *dev;
 
     dev = USB_DEVICE(qdev_try_create(&bus->qbus, name));
@@ -338,9 +333,8 @@ static USBDevice *usb_try_create_simple(USBBus *bus, const char *name,
         error_setg(errp, "Failed to create USB device '%s'", name);
         return NULL;
     }
-    object_property_set_bool(OBJECT(dev), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(dev), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         error_prepend(errp, "Failed to initialize USB device '%s': ",
                       name);
         object_unparent(OBJECT(dev));
@@ -533,11 +527,9 @@ void usb_check_attach(USBDevice *dev, Error **errp)
 void usb_device_attach(USBDevice *dev, Error **errp)
 {
     USBPort *port = dev->port;
-    Error *local_err = NULL;
 
-    usb_check_attach(dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    usb_check_attach(dev, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -754,15 +746,13 @@ static bool usb_get_attached(Object *obj, Error **errp)
 static void usb_set_attached(Object *obj, bool value, Error **errp)
 {
     USBDevice *dev = USB_DEVICE(obj);
-    Error *err = NULL;
 
     if (dev->attached == value) {
         return;
     }
 
     if (value) {
-        usb_device_attach(dev, &err);
-        error_propagate(errp, err);
+        usb_device_attach(dev, errp);
     } else {
         usb_device_detach(dev);
     }
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index bfbf7cdce7..cc9dd8b533 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -483,7 +483,6 @@ static void usb_serial_event(void *opaque, int event)
 static void usb_serial_realize(USBDevice *dev, Error **errp)
 {
     USBSerialState *s = USB_SERIAL_DEV(dev);
-    Error *local_err = NULL;
     Chardev *chr = qemu_chr_fe_get_driver(&s->cs);
 
     usb_desc_create_serial(dev);
@@ -495,9 +494,8 @@ static void usb_serial_realize(USBDevice *dev, Error **errp)
         return;
     }
 
-    usb_check_attach(dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    usb_check_attach(dev, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 3ada35e954..2c221d23be 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -1850,7 +1850,6 @@ static void usb_ohci_init(OHCIState *ohci, DeviceState *dev,
                           char *masterbus, uint32_t firstport,
                           AddressSpace *as, Error **errp)
 {
-    Error *err = NULL;
     int i;
 
     ohci->as = as;
@@ -1885,9 +1884,8 @@ static void usb_ohci_init(OHCIState *ohci, DeviceState *dev,
         usb_register_companion(masterbus, ports, num_ports,
                                firstport, ohci, &ohci_port_ops,
                                USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL,
-                               &err);
-        if (err) {
-            error_propagate(errp, err);
+                               errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     } else {
@@ -1944,7 +1942,6 @@ static void ohci_die(OHCIState *ohci)
 
 static void usb_ohci_realize_pci(PCIDevice *dev, Error **errp)
 {
-    Error *err = NULL;
     OHCIPCIState *ohci = PCI_OHCI(dev);
 
     dev->config[PCI_CLASS_PROG] = 0x10; /* OHCI */
@@ -1952,9 +1949,8 @@ static void usb_ohci_realize_pci(PCIDevice *dev, Error **errp)
 
     usb_ohci_init(&ohci->state, DEVICE(dev), ohci->num_ports, 0,
                   ohci->masterbus, ohci->firstport,
-                  pci_get_address_space(dev), &err);
-    if (err) {
-        error_propagate(errp, err);
+                  pci_get_address_space(dev), errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index ca72a80f27..b99a4d6429 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -1208,7 +1208,6 @@ static USBBusOps uhci_bus_ops = {
 
 static void usb_uhci_common_realize(PCIDevice *dev, Error **errp)
 {
-    Error *err = NULL;
     PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
     UHCIPCIDeviceClass *u = container_of(pc, UHCIPCIDeviceClass, parent_class);
     UHCIState *s = UHCI(dev);
@@ -1229,9 +1228,8 @@ static void usb_uhci_common_realize(PCIDevice *dev, Error **errp)
         usb_register_companion(s->masterbus, ports, NB_PORTS,
                                s->firstport, s, &uhci_port_ops,
                                USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL,
-                               &err);
-        if (err) {
-            error_propagate(errp, err);
+                               errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     } else {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 2d3bad68fc..ae34f35a55 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2615,7 +2615,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     VFIODevice *vbasedev_iter;
     VFIOGroup *group;
     char *tmp, group_path[PATH_MAX], *group_name;
-    Error *err = NULL;
     ssize_t len;
     struct stat st;
     int groupid;
@@ -2684,9 +2683,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
-    vfio_populate_device(vdev, &err);
-    if (err) {
-        error_propagate(errp, err);
+    vfio_populate_device(vdev, errp);
+    if (ERR_IS_SET(errp)) {
         goto error;
     }
 
@@ -2775,9 +2773,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     vfio_pci_size_rom(vdev);
 
-    vfio_msix_early_setup(vdev, &err);
-    if (err) {
-        error_propagate(errp, err);
+    vfio_msix_early_setup(vdev, errp);
+    if (ERR_IS_SET(errp)) {
         goto error;
     }
 
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index c2ba3f991b..09ac3b7d12 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -162,12 +162,10 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
                                             Error **errp)
 {
     VirtIOBalloon *s = opaque;
-    Error *local_err = NULL;
     int64_t value;
 
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_int(v, name, &value, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 20b2fef683..d6a8b6be5f 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2373,12 +2373,10 @@ static void virtio_rng_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
     VirtIORngPCI *vrng = VIRTIO_RNG_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&vrng->vdev);
-    Error *err = NULL;
 
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index e564e3b291..964c775e41 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -160,7 +160,6 @@ static void virtio_rng_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIORNG *vrng = VIRTIO_RNG(dev);
-    Error *local_err = NULL;
 
     if (vrng->conf.period_ms <= 0) {
         error_setg(errp, "'period' parameter expects a positive integer");
@@ -179,9 +178,8 @@ static void virtio_rng_device_realize(DeviceState *dev, Error **errp)
         vrng->conf.default_backend = RNG_RANDOM(object_new(TYPE_RNG_RANDOM));
 
         user_creatable_complete(OBJECT(vrng->conf.default_backend),
-                                &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+                                errp);
+        if (ERR_IS_SET(errp)) {
             object_unref(OBJECT(vrng->conf.default_backend));
             return;
         }
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index fd16ff7d9d..530b5e568e 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2477,22 +2477,19 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(dev);
-    Error *err = NULL;
 
     /* Devices should either use vmsd or the load/save methods */
     assert(!vdc->vmsd || !vdc->load);
 
     if (vdc->realize != NULL) {
-        vdc->realize(dev, &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        vdc->realize(dev, errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     }
 
-    virtio_bus_device_plugged(vdev, &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    virtio_bus_device_plugged(vdev, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -2504,14 +2501,12 @@ static void virtio_device_unrealize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(dev);
-    Error *err = NULL;
 
     virtio_bus_device_unplugged(vdev);
 
     if (vdc->unrealize != NULL) {
-        vdc->unrealize(dev, &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        vdc->unrealize(dev, errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     }
diff --git a/migration/colo.c b/migration/colo.c
index a68e6e9cdf..039b8afa03 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -235,12 +235,10 @@ static void colo_send_message(QEMUFile *f, COLOMessage msg,
 static void colo_send_message_value(QEMUFile *f, COLOMessage msg,
                                     uint64_t value, Error **errp)
 {
-    Error *local_err = NULL;
     int ret;
 
-    colo_send_message(f, msg, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    colo_send_message(f, msg, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     qemu_put_be64(f, value);
@@ -292,13 +290,11 @@ static void colo_receive_check_message(QEMUFile *f, COLOMessage expect_msg,
 static uint64_t colo_receive_message_value(QEMUFile *f, uint32_t expect_msg,
                                            Error **errp)
 {
-    Error *local_err = NULL;
     uint64_t value;
     int ret;
 
-    colo_receive_check_message(f, expect_msg, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    colo_receive_check_message(f, expect_msg, errp);
+    if (ERR_IS_SET(errp)) {
         return 0;
     }
 
diff --git a/migration/migration.c b/migration/migration.c
index ac49c4cac8..16bdd0a8d6 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1151,7 +1151,6 @@ void migrate_del_blocker(Error *reason)
 
 void qmp_migrate_incoming(const char *uri, Error **errp)
 {
-    Error *local_err = NULL;
     static bool once = true;
 
     if (!deferred_incoming) {
@@ -1162,10 +1161,9 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
         error_setg(errp, "The incoming migration has already been started");
     }
 
-    qemu_start_incoming_migration(uri, &local_err);
+    qemu_start_incoming_migration(uri, errp);
 
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/net/filter.c b/net/filter.c
index ee7ab8e443..43af9f3733 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -193,7 +193,6 @@ static void netfilter_complete(UserCreatable *uc, Error **errp)
     NetClientState *ncs[MAX_QUEUE_NUM];
     NetFilterClass *nfc = NETFILTER_GET_CLASS(uc);
     int queues;
-    Error *local_err = NULL;
 
     if (!nf->netdev_id) {
         error_setg(errp, "Parameter 'netdev' is required");
@@ -220,9 +219,8 @@ static void netfilter_complete(UserCreatable *uc, Error **errp)
     nf->netdev = ncs[0];
 
     if (nfc->setup) {
-        nfc->setup(nf, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        nfc->setup(nf, errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     }
diff --git a/net/tap.c b/net/tap.c
index 979e622e60..70e5dda82a 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -605,7 +605,6 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
                         const char *setup_script, char *ifname,
                         size_t ifname_sz, int mq_required, Error **errp)
 {
-    Error *err = NULL;
     int fd, vnet_hdr_required;
 
     if (tap->has_vnet_hdr) {
@@ -625,9 +624,8 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
     if (setup_script &&
         setup_script[0] != '\0' &&
         strcmp(setup_script, "no") != 0) {
-        launch_script(setup_script, ifname, fd, &err);
-        if (err) {
-            error_propagate(errp, err);
+        launch_script(setup_script, ifname, fd, errp);
+        if (ERR_IS_SET(errp)) {
             close(fd);
             return -1;
         }
diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index c089491c24..bb4a21ce0d 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -266,12 +266,10 @@ static void parse_type_size(Visitor *v, const char *name, uint64_t *obj,
                             Error **errp)
 {
     StringInputVisitor *siv = to_siv(v);
-    Error *err = NULL;
     uint64_t val;
 
-    parse_option_size(name, siv->string, &val, &err);
-    if (err) {
-        error_propagate(errp, err);
+    parse_option_size(name, siv->string, &val, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 37302305c5..7a802c6b37 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -175,16 +175,14 @@ static int set_property(void *opaque, const char *name, const char *value,
                         Error **errp)
 {
     Object *obj = opaque;
-    Error *err = NULL;
 
     if (strcmp(name, "driver") == 0)
         return 0;
     if (strcmp(name, "bus") == 0)
         return 0;
 
-    object_property_parse(obj, value, name, &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_parse(obj, value, name, errp);
+    if (ERR_IS_SET(errp)) {
         return -1;
     }
     return 0;
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 623a32a7d8..6d3476477f 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -72,7 +72,6 @@ static void ga_wait_child(pid_t pid, int *status, Error **errp)
 void qmp_guest_shutdown(bool has_mode, const char *mode, Error **errp)
 {
     const char *shutdown_flag;
-    Error *local_err = NULL;
     pid_t pid;
     int status;
 
@@ -105,9 +104,8 @@ void qmp_guest_shutdown(bool has_mode, const char *mode, Error **errp)
         return;
     }
 
-    ga_wait_child(pid, &status, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    ga_wait_child(pid, &status, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -143,7 +141,6 @@ void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)
     int ret;
     int status;
     pid_t pid;
-    Error *local_err = NULL;
     struct timeval tv;
 
     /* If user has passed a time, validate and set it. */
@@ -192,9 +189,8 @@ void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)
         return;
     }
 
-    ga_wait_child(pid, &status, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    ga_wait_child(pid, &status, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -1201,21 +1197,18 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
     strList *list;
     FsMountList mounts;
     struct FsMount *mount;
-    Error *local_err = NULL;
     int fd;
 
     slog("guest-fsfreeze called");
 
-    execute_fsfreeze_hook(FSFREEZE_HOOK_FREEZE, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    execute_fsfreeze_hook(FSFREEZE_HOOK_FREEZE, errp);
+    if (ERR_IS_SET(errp)) {
         return -1;
     }
 
     QTAILQ_INIT(&mounts);
-    build_fs_mount_list(&mounts, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    build_fs_mount_list(&mounts, errp);
+    if (ERR_IS_SET(errp)) {
         return -1;
     }
 
@@ -1286,12 +1279,10 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
     FsMountList mounts;
     FsMount *mount;
     int fd, i = 0, logged;
-    Error *local_err = NULL;
 
     QTAILQ_INIT(&mounts);
-    build_fs_mount_list(&mounts, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    build_fs_mount_list(&mounts, errp);
+    if (ERR_IS_SET(errp)) {
         return 0;
     }
 
@@ -1364,15 +1355,13 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
     FsMountList mounts;
     struct FsMount *mount;
     int fd;
-    Error *local_err = NULL;
     struct fstrim_range r;
 
     slog("guest-fstrim called");
 
     QTAILQ_INIT(&mounts);
-    build_fs_mount_list(&mounts, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    build_fs_mount_list(&mounts, errp);
+    if (ERR_IS_SET(errp)) {
         return NULL;
     }
 
@@ -1437,7 +1426,6 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
 static void bios_supports_mode(const char *pmutils_bin, const char *pmutils_arg,
                                const char *sysfile_str, Error **errp)
 {
-    Error *local_err = NULL;
     char *pmutils_path;
     pid_t pid;
     int status;
@@ -1489,9 +1477,8 @@ static void bios_supports_mode(const char *pmutils_bin, const char *pmutils_arg,
         goto out;
     }
 
-    ga_wait_child(pid, &status, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    ga_wait_child(pid, &status, errp);
+    if (ERR_IS_SET(errp)) {
         goto out;
     }
 
@@ -1521,7 +1508,6 @@ out:
 static void guest_suspend(const char *pmutils_bin, const char *sysfile_str,
                           Error **errp)
 {
-    Error *local_err = NULL;
     char *pmutils_path;
     pid_t pid;
     int status;
@@ -1566,9 +1552,8 @@ static void guest_suspend(const char *pmutils_bin, const char *sysfile_str,
         goto out;
     }
 
-    ga_wait_child(pid, &status, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    ga_wait_child(pid, &status, errp);
+    if (ERR_IS_SET(errp)) {
         goto out;
     }
 
@@ -1588,11 +1573,8 @@ out:
 
 void qmp_guest_suspend_disk(Error **errp)
 {
-    Error *local_err = NULL;
-
-    bios_supports_mode("pm-is-supported", "--hibernate", "disk", &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    bios_supports_mode("pm-is-supported", "--hibernate", "disk", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -1601,11 +1583,8 @@ void qmp_guest_suspend_disk(Error **errp)
 
 void qmp_guest_suspend_ram(Error **errp)
 {
-    Error *local_err = NULL;
-
-    bios_supports_mode("pm-is-supported", "--suspend", "mem", &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    bios_supports_mode("pm-is-supported", "--suspend", "mem", errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -1614,12 +1593,9 @@ void qmp_guest_suspend_ram(Error **errp)
 
 void qmp_guest_suspend_hybrid(Error **errp)
 {
-    Error *local_err = NULL;
-
     bios_supports_mode("pm-is-supported", "--suspend-hybrid", NULL,
-                       &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+                       errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -1947,7 +1923,6 @@ void qmp_guest_set_user_password(const char *username,
                                  bool crypted,
                                  Error **errp)
 {
-    Error *local_err = NULL;
     char *passwd_path = NULL;
     pid_t pid;
     int status;
@@ -2019,9 +1994,8 @@ void qmp_guest_set_user_password(const char *username,
     close(datafd[1]);
     datafd[1] = -1;
 
-    ga_wait_child(pid, &status, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    ga_wait_child(pid, &status, errp);
+    if (ERR_IS_SET(errp)) {
         goto out;
     }
 
@@ -2327,7 +2301,6 @@ err:
 
 GuestMemoryBlockInfo *qmp_guest_get_memory_block_info(Error **errp)
 {
-    Error *local_err = NULL;
     char *dirpath;
     int dirfd;
     char *buf;
@@ -2343,11 +2316,10 @@ GuestMemoryBlockInfo *qmp_guest_get_memory_block_info(Error **errp)
     g_free(dirpath);
 
     buf = g_malloc0(20);
-    ga_read_sysfs_file(dirfd, "block_size_bytes", buf, 20, &local_err);
+    ga_read_sysfs_file(dirfd, "block_size_bytes", buf, 20, errp);
     close(dirfd);
-    if (local_err) {
+    if (ERR_IS_SET(errp)) {
         g_free(buf);
-        error_propagate(errp, local_err);
         return NULL;
     }
 
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 439d229225..9f7936eeeb 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -269,7 +269,6 @@ static void execute_async(DWORD WINAPI (*func)(LPVOID), LPVOID opaque,
 
 void qmp_guest_shutdown(bool has_mode, const char *mode, Error **errp)
 {
-    Error *local_err = NULL;
     UINT shutdown_flag = EWX_FORCE;
 
     slog("guest-shutdown called, mode: %s", mode);
@@ -288,9 +287,8 @@ void qmp_guest_shutdown(bool has_mode, const char *mode, Error **errp)
 
     /* Request a shutdown privilege, but try to shut down the system
        anyway. */
-    acquire_privilege(SE_SHUTDOWN_NAME, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    acquire_privilege(SE_SHUTDOWN_NAME, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -760,7 +758,6 @@ GuestFsfreezeStatus qmp_guest_fsfreeze_status(Error **errp)
 int64_t qmp_guest_fsfreeze_freeze(Error **errp)
 {
     int i;
-    Error *local_err = NULL;
 
     if (!vss_initialized()) {
         error_setg(errp, QERR_UNSUPPORTED);
@@ -772,9 +769,8 @@ int64_t qmp_guest_fsfreeze_freeze(Error **errp)
     /* cannot risk guest agent blocking itself on a write in this state */
     ga_set_frozen(ga_state);
 
-    qga_vss_fsfreeze(&i, true, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    qga_vss_fsfreeze(&i, true, errp);
+    if (ERR_IS_SET(errp)) {
         goto error;
     }
 
@@ -1264,7 +1260,6 @@ int64_t qmp_guest_get_time(Error **errp)
 
 void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)
 {
-    Error *local_err = NULL;
     SYSTEMTIME ts;
     FILETIME tf;
     LONGLONG time;
@@ -1296,9 +1291,8 @@ void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)
         return;
     }
 
-    acquire_privilege(SE_SYSTEMTIME_NAME, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    acquire_privilege(SE_SYSTEMTIME_NAME, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/qmp.c b/qmp.c
index 7ee9bcfdcf..9821343ad4 100644
--- a/qmp.c
+++ b/qmp.c
@@ -164,7 +164,6 @@ SpiceInfo *qmp_query_spice(Error **errp)
 
 void qmp_cont(Error **errp)
 {
-    Error *local_err = NULL;
     BlockBackend *blk;
     BlockDriverState *bs;
     BdrvNextIterator it;
@@ -188,9 +187,8 @@ void qmp_cont(Error **errp)
     }
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
-        bdrv_add_key(bs, NULL, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        bdrv_add_key(bs, NULL, errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     }
@@ -201,9 +199,8 @@ void qmp_cont(Error **errp)
      * If there are no inactive block nodes (e.g. because the VM was just
      * paused rather than completing a migration), bdrv_inactivate_all() simply
      * doesn't do anything. */
-    bdrv_invalidate_cache_all(&local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    bdrv_invalidate_cache_all(errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/qom/object.c b/qom/object.c
index 8b2f2ef8ac..2a0084ea96 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1227,7 +1227,6 @@ typedef struct EnumProperty {
 int object_property_get_enum(Object *obj, const char *name,
                              const char *typename, Error **errp)
 {
-    Error *err = NULL;
     Visitor *v;
     char *str;
     int ret;
@@ -1248,9 +1247,8 @@ int object_property_get_enum(Object *obj, const char *name,
     enumprop = prop->opaque;
 
     v = string_output_visitor_new(false, &str);
-    object_property_get(obj, v, name, &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_get(obj, v, name, errp);
+    if (ERR_IS_SET(errp)) {
         visit_free(v);
         return 0;
     }
@@ -1268,14 +1266,12 @@ int object_property_get_enum(Object *obj, const char *name,
 void object_property_get_uint16List(Object *obj, const char *name,
                                     uint16List **list, Error **errp)
 {
-    Error *err = NULL;
     Visitor *v;
     char *str;
 
     v = string_output_visitor_new(false, &str);
-    object_property_get(obj, v, name, &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_get(obj, v, name, errp);
+    if (ERR_IS_SET(errp)) {
         goto out;
     }
     visit_complete(v, &str);
@@ -1301,12 +1297,10 @@ char *object_property_print(Object *obj, const char *name, bool human,
 {
     Visitor *v;
     char *string = NULL;
-    Error *local_err = NULL;
 
     v = string_output_visitor_new(human, &string);
-    object_property_get(obj, v, name, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    object_property_get(obj, v, name, errp);
+    if (ERR_IS_SET(errp)) {
         goto out;
     }
 
@@ -1758,11 +1752,9 @@ static void property_set_str(Object *obj, Visitor *v, const char *name,
 {
     StringProperty *prop = opaque;
     char *value;
-    Error *local_err = NULL;
 
-    visit_type_str(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_str(v, name, &value, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -1782,7 +1774,6 @@ void object_property_add_str(Object *obj, const char *name,
                            void (*set)(Object *, const char *, Error **),
                            Error **errp)
 {
-    Error *local_err = NULL;
     StringProperty *prop = g_malloc0(sizeof(*prop));
 
     prop->get = get;
@@ -1792,9 +1783,8 @@ void object_property_add_str(Object *obj, const char *name,
                         get ? property_get_str : NULL,
                         set ? property_set_str : NULL,
                         property_release_str,
-                        prop, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+                        prop, errp);
+    if (ERR_IS_SET(errp)) {
         g_free(prop);
     }
 }
@@ -1805,7 +1795,6 @@ void object_class_property_add_str(ObjectClass *klass, const char *name,
                                                Error **),
                                    Error **errp)
 {
-    Error *local_err = NULL;
     StringProperty *prop = g_malloc0(sizeof(*prop));
 
     prop->get = get;
@@ -1815,9 +1804,8 @@ void object_class_property_add_str(ObjectClass *klass, const char *name,
                               get ? property_get_str : NULL,
                               set ? property_set_str : NULL,
                               property_release_str,
-                              prop, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+                              prop, errp);
+    if (ERR_IS_SET(errp)) {
         g_free(prop);
     }
 }
@@ -1849,11 +1837,9 @@ static void property_set_bool(Object *obj, Visitor *v, const char *name,
 {
     BoolProperty *prop = opaque;
     bool value;
-    Error *local_err = NULL;
 
-    visit_type_bool(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_bool(v, name, &value, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -1872,7 +1858,6 @@ void object_property_add_bool(Object *obj, const char *name,
                               void (*set)(Object *, bool, Error **),
                               Error **errp)
 {
-    Error *local_err = NULL;
     BoolProperty *prop = g_malloc0(sizeof(*prop));
 
     prop->get = get;
@@ -1882,9 +1867,8 @@ void object_property_add_bool(Object *obj, const char *name,
                         get ? property_get_bool : NULL,
                         set ? property_set_bool : NULL,
                         property_release_bool,
-                        prop, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+                        prop, errp);
+    if (ERR_IS_SET(errp)) {
         g_free(prop);
     }
 }
@@ -1894,7 +1878,6 @@ void object_class_property_add_bool(ObjectClass *klass, const char *name,
                                     void (*set)(Object *, bool, Error **),
                                     Error **errp)
 {
-    Error *local_err = NULL;
     BoolProperty *prop = g_malloc0(sizeof(*prop));
 
     prop->get = get;
@@ -1904,9 +1887,8 @@ void object_class_property_add_bool(ObjectClass *klass, const char *name,
                               get ? property_get_bool : NULL,
                               set ? property_set_bool : NULL,
                               property_release_bool,
-                              prop, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+                              prop, errp);
+    if (ERR_IS_SET(errp)) {
         g_free(prop);
     }
 }
@@ -1932,11 +1914,9 @@ static void property_set_enum(Object *obj, Visitor *v, const char *name,
 {
     EnumProperty *prop = opaque;
     int value;
-    Error *err = NULL;
 
-    visit_type_enum(v, name, &value, prop->strings, &err);
-    if (err) {
-        error_propagate(errp, err);
+    visit_type_enum(v, name, &value, prop->strings, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     prop->set(obj, value, errp);
@@ -1956,7 +1936,6 @@ void object_property_add_enum(Object *obj, const char *name,
                               void (*set)(Object *, int, Error **),
                               Error **errp)
 {
-    Error *local_err = NULL;
     EnumProperty *prop = g_malloc(sizeof(*prop));
 
     prop->strings = strings;
@@ -1967,9 +1946,8 @@ void object_property_add_enum(Object *obj, const char *name,
                         get ? property_get_enum : NULL,
                         set ? property_set_enum : NULL,
                         property_release_enum,
-                        prop, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+                        prop, errp);
+    if (ERR_IS_SET(errp)) {
         g_free(prop);
     }
 }
@@ -1981,7 +1959,6 @@ void object_class_property_add_enum(ObjectClass *klass, const char *name,
                                     void (*set)(Object *, int, Error **),
                                     Error **errp)
 {
-    Error *local_err = NULL;
     EnumProperty *prop = g_malloc(sizeof(*prop));
 
     prop->strings = strings;
@@ -1992,9 +1969,8 @@ void object_class_property_add_enum(ObjectClass *klass, const char *name,
                               get ? property_get_enum : NULL,
                               set ? property_set_enum : NULL,
                               property_release_enum,
-                              prop, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+                              prop, errp);
+    if (ERR_IS_SET(errp)) {
         g_free(prop);
     }
 }
@@ -2062,7 +2038,6 @@ void object_property_add_tm(Object *obj, const char *name,
                             void (*get)(Object *, struct tm *, Error **),
                             Error **errp)
 {
-    Error *local_err = NULL;
     TMProperty *prop = g_malloc0(sizeof(*prop));
 
     prop->get = get;
@@ -2070,9 +2045,8 @@ void object_property_add_tm(Object *obj, const char *name,
     object_property_add(obj, name, "struct tm",
                         get ? property_get_tm : NULL, NULL,
                         property_release_tm,
-                        prop, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+                        prop, errp);
+    if (ERR_IS_SET(errp)) {
         g_free(prop);
     }
 }
@@ -2081,7 +2055,6 @@ void object_class_property_add_tm(ObjectClass *klass, const char *name,
                                   void (*get)(Object *, struct tm *, Error **),
                                   Error **errp)
 {
-    Error *local_err = NULL;
     TMProperty *prop = g_malloc0(sizeof(*prop));
 
     prop->get = get;
@@ -2089,9 +2062,8 @@ void object_class_property_add_tm(ObjectClass *klass, const char *name,
     object_class_property_add(klass, name, "struct tm",
                               get ? property_get_tm : NULL, NULL,
                               property_release_tm,
-                              prop, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+                              prop, errp);
+    if (ERR_IS_SET(errp)) {
         g_free(prop);
     }
 }
diff --git a/replication.c b/replication.c
index be3a42f9c9..d8f00e75b2 100644
--- a/replication.c
+++ b/replication.c
@@ -45,14 +45,12 @@ void replication_remove(ReplicationState *rs)
 void replication_start_all(ReplicationMode mode, Error **errp)
 {
     ReplicationState *rs, *next;
-    Error *local_err = NULL;
 
     QLIST_FOREACH_SAFE(rs, &replication_states, node, next) {
         if (rs->ops && rs->ops->start) {
-            rs->ops->start(rs, mode, &local_err);
+            rs->ops->start(rs, mode, errp);
         }
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     }
@@ -61,14 +59,12 @@ void replication_start_all(ReplicationMode mode, Error **errp)
 void replication_do_checkpoint_all(Error **errp)
 {
     ReplicationState *rs, *next;
-    Error *local_err = NULL;
 
     QLIST_FOREACH_SAFE(rs, &replication_states, node, next) {
         if (rs->ops && rs->ops->checkpoint) {
-            rs->ops->checkpoint(rs, &local_err);
+            rs->ops->checkpoint(rs, errp);
         }
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     }
@@ -77,14 +73,12 @@ void replication_do_checkpoint_all(Error **errp)
 void replication_get_error_all(Error **errp)
 {
     ReplicationState *rs, *next;
-    Error *local_err = NULL;
 
     QLIST_FOREACH_SAFE(rs, &replication_states, node, next) {
         if (rs->ops && rs->ops->get_error) {
-            rs->ops->get_error(rs, &local_err);
+            rs->ops->get_error(rs, errp);
         }
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     }
@@ -93,14 +87,12 @@ void replication_get_error_all(Error **errp)
 void replication_stop_all(bool failover, Error **errp)
 {
     ReplicationState *rs, *next;
-    Error *local_err = NULL;
 
     QLIST_FOREACH_SAFE(rs, &replication_states, node, next) {
         if (rs->ops && rs->ops->stop) {
-            rs->ops->stop(rs, failover, &local_err);
+            rs->ops->stop(rs, failover, errp);
         }
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     }
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index a863a1bf4d..b0a391f54b 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -58,11 +58,9 @@ static void alpha_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
     AlphaCPUClass *acc = ALPHA_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 28a9141298..00b17ca6af 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -628,11 +628,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     ARMCPUClass *acc = ARM_CPU_GET_CLASS(dev);
     CPUARMState *env = &cpu->env;
     int pagebits;
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 5f766f09d6..32815e3fa3 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -141,11 +141,9 @@ static void cris_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
     CRISCPUClass *ccc = CRIS_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 6a05445e0e..500414752e 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -52,11 +52,9 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
     HPPACPUClass *acc = HPPA_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ae7abdade5..e0a5862568 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1699,12 +1699,10 @@ static void x86_cpuid_version_set_family(Object *obj, Visitor *v,
     CPUX86State *env = &cpu->env;
     const int64_t min = 0;
     const int64_t max = 0xff + 0xf;
-    Error *local_err = NULL;
     int64_t value;
 
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_int(v, name, &value, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     if (value < min || value > max) {
@@ -1742,12 +1740,10 @@ static void x86_cpuid_version_set_model(Object *obj, Visitor *v,
     CPUX86State *env = &cpu->env;
     const int64_t min = 0;
     const int64_t max = 0xff;
-    Error *local_err = NULL;
     int64_t value;
 
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_int(v, name, &value, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     if (value < min || value > max) {
@@ -1780,12 +1776,10 @@ static void x86_cpuid_version_set_stepping(Object *obj, Visitor *v,
     CPUX86State *env = &cpu->env;
     const int64_t min = 0;
     const int64_t max = 0xf;
-    Error *local_err = NULL;
     int64_t value;
 
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_int(v, name, &value, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     if (value < min || value > max) {
@@ -1885,12 +1879,10 @@ static void x86_cpuid_set_tsc_freq(Object *obj, Visitor *v, const char *name,
     X86CPU *cpu = X86_CPU(obj);
     const int64_t min = 0;
     const int64_t max = INT64_MAX;
-    Error *local_err = NULL;
     int64_t value;
 
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_int(v, name, &value, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     if (value < min || value > max) {
@@ -1946,12 +1938,10 @@ static void x86_set_hv_spinlocks(Object *obj, Visitor *v, const char *name,
     const int64_t min = 0xFFF;
     const int64_t max = UINT_MAX;
     X86CPU *cpu = X86_CPU(obj);
-    Error *err = NULL;
     int64_t value;
 
-    visit_type_int(v, name, &value, &err);
-    if (err) {
-        error_propagate(errp, err);
+    visit_type_int(v, name, &value, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -3684,7 +3674,6 @@ static void x86_cpu_unrealizefn(DeviceState *dev, Error **errp)
 {
     X86CPU *cpu = X86_CPU(dev);
     X86CPUClass *xcc = X86_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
 #ifndef CONFIG_USER_ONLY
     cpu_remove_sync(CPU(dev));
@@ -3696,9 +3685,8 @@ static void x86_cpu_unrealizefn(DeviceState *dev, Error **errp)
         cpu->apic_state = NULL;
     }
 
-    xcc->parent_unrealize(dev, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    xcc->parent_unrealize(dev, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 }
@@ -3724,7 +3712,6 @@ static void x86_cpu_set_bit_prop(Object *obj, Visitor *v, const char *name,
     DeviceState *dev = DEVICE(obj);
     X86CPU *cpu = X86_CPU(obj);
     BitProperty *fp = opaque;
-    Error *local_err = NULL;
     bool value;
 
     if (dev->realized) {
@@ -3732,9 +3719,8 @@ static void x86_cpu_set_bit_prop(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    visit_type_bool(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_bool(v, name, &value, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
index 2b8c36b6d0..8bd90c09dc 100644
--- a/target/lm32/cpu.c
+++ b/target/lm32/cpu.c
@@ -143,11 +143,9 @@ static void lm32_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
     LM32CPUClass *lcc = LM32_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index f06892271f..ae7fa0e1b0 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -221,11 +221,9 @@ static void m68k_cpu_realizefn(DeviceState *dev, Error **errp)
     CPUState *cs = CPU(dev);
     M68kCPU *cpu = M68K_CPU(dev);
     M68kCPUClass *mcc = M68K_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 3d58869716..026b5b3e3f 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -137,11 +137,9 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
     CPUMBState *env = &cpu->env;
     uint8_t version_code = 0;
     int i = 0;
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 1bb66b7a5a..07c82ebb9d 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -123,11 +123,9 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
     MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
index 927b1a1e44..ad7435ecbd 100644
--- a/target/moxie/cpu.c
+++ b/target/moxie/cpu.c
@@ -59,11 +59,9 @@ static void moxie_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
     MoxieCPUClass *mcc = MOXIE_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index 7015cdefe6..227c5352a7 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -96,11 +96,9 @@ static void nios2_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
     Nios2CPUClass *ncc = NIOS2_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 1d6330cbcc..8cd0a46bf1 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -69,11 +69,9 @@ static void openrisc_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
     OpenRISCCPUClass *occ = OPENRISC_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 56a0ab22cf..0597df737e 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8444,14 +8444,12 @@ static void powerpc_get_compat(Object *obj, Visitor *v, const char *name,
 static void powerpc_set_compat(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
-    Error *error = NULL;
     char *value = NULL;
     Property *prop = opaque;
     uint32_t *max_compat = qdev_get_prop_ptr(DEVICE(obj), prop);
 
-    visit_type_str(v, name, &value, &error);
-    if (error) {
-        error_propagate(errp, error);
+    visit_type_str(v, name, &value, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -9825,7 +9823,6 @@ static void ppc_cpu_realizefn(DeviceState *dev, Error **errp)
     CPUState *cs = CPU(dev);
     PowerPCCPU *cpu = POWERPC_CPU(dev);
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
-    Error *local_err = NULL;
 #if !defined(CONFIG_USER_ONLY)
     int max_smt = kvmppc_smt_threads();
 #endif
@@ -9844,9 +9841,8 @@ static void ppc_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 #endif
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
@@ -9879,9 +9875,8 @@ static void ppc_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 #endif
 
-    create_ppc_opcodes(cpu, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    create_ppc_opcodes(cpu, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     init_ppc_proc(cpu);
@@ -10074,13 +10069,11 @@ static void ppc_cpu_unrealizefn(DeviceState *dev, Error **errp)
     PowerPCCPU *cpu = POWERPC_CPU(dev);
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     CPUPPCState *env = &cpu->env;
-    Error *local_err = NULL;
     opc_handler_t **table, **table_2;
     int i, j, k;
 
-    pcc->parent_unrealize(dev, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    pcc->parent_unrealize(dev, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 75e5966749..7d9e104151 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -250,7 +250,6 @@ static void s390x_cpu_set_id(Object *obj, Visitor *v, const char *name,
     DeviceState *dev = DEVICE(obj);
     const int64_t min = 0;
     const int64_t max = UINT32_MAX;
-    Error *err = NULL;
     int64_t value;
 
     if (dev->realized) {
@@ -259,9 +258,8 @@ static void s390x_cpu_set_id(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    visit_type_int(v, name, &value, &err);
-    if (err) {
-        error_propagate(errp, err);
+    visit_type_int(v, name, &value, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
     if (value < min || value > max) {
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 9da7e1ed38..dc2cbce478 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -243,11 +243,9 @@ static void superh_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
     SuperHCPUClass *scc = SUPERH_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 4d6f0c4f66..51a6f129a1 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -800,7 +800,6 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
     SPARCCPUClass *scc = SPARC_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 #if defined(CONFIG_USER_ONLY)
     SPARCCPU *cpu = SPARC_CPU(dev);
     CPUSPARCState *env = &cpu->env;
@@ -810,9 +809,8 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 #endif
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
index f8c479e1d7..f8448c4c9e 100644
--- a/target/tilegx/cpu.c
+++ b/target/tilegx/cpu.c
@@ -90,11 +90,9 @@ static void tilegx_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
     TileGXCPUClass *tcc = TILEGX_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 08f50e2ba7..efeb6553d0 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -67,11 +67,9 @@ static void tricore_cpu_realizefn(DeviceState *dev, Error **errp)
     TriCoreCPU *cpu = TRICORE_CPU(dev);
     TriCoreCPUClass *tcc = TRICORE_CPU_GET_CLASS(dev);
     CPUTriCoreState *env = &cpu->env;
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index c9b78ce68e..3b14cfa37d 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -103,11 +103,9 @@ static void uc32_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
     UniCore32CPUClass *ucc = UNICORE32_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index cd7f95823f..69bf002489 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -101,11 +101,9 @@ static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
     XtensaCPUClass *xcc = XTENSA_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (ERR_IS_SET(errp)) {
         return;
     }
 
diff --git a/util/qemu-config.c b/util/qemu-config.c
index be9ffb5872..48e5691f8d 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -568,12 +568,10 @@ void qemu_config_parse_qdict(QDict *options, QemuOptsList **lists,
                              Error **errp)
 {
     int i;
-    Error *local_err = NULL;
 
     for (i = 0; lists[i]; i++) {
-        config_parse_qdict_section(options, lists[i], &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        config_parse_qdict_section(options, lists[i], errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     }
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 5f1c7af1c6..4a4b145d42 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -526,7 +526,6 @@ static void opt_set(QemuOpts *opts, const char *name, const char *value,
 {
     QemuOpt *opt;
     const QemuOptDesc *desc;
-    Error *local_err = NULL;
 
     desc = find_desc_by_name(opts->list->desc, name);
     if (!desc && !opts_accepts_any(opts)) {
@@ -545,9 +544,8 @@ static void opt_set(QemuOpts *opts, const char *name, const char *value,
     opt->desc = desc;
     opt->str = g_strdup(value);
     assert(opt->str);
-    qemu_opt_parse(opt, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    qemu_opt_parse(opt, errp);
+    if (ERR_IS_SET(errp)) {
         qemu_opt_del(opt);
     }
 }
@@ -790,7 +788,6 @@ static void opts_do_parse(QemuOpts *opts, const char *params,
 {
     char option[128], value[1024];
     const char *p,*pe,*pc;
-    Error *local_err = NULL;
 
     for (p = params; *p != '\0'; p++) {
         pe = strchr(p, '=');
@@ -822,9 +819,8 @@ static void opts_do_parse(QemuOpts *opts, const char *params,
         }
         if (strcmp(option, "id") != 0) {
             /* store and parse */
-            opt_set(opts, option, value, prepend, &local_err);
-            if (local_err) {
-                error_propagate(errp, local_err);
+            opt_set(opts, option, value, prepend, errp);
+            if (ERR_IS_SET(errp)) {
                 return;
             }
         }
@@ -1073,7 +1069,6 @@ QDict *qemu_opts_to_qdict(QemuOpts *opts, QDict *qdict)
 void qemu_opts_validate(QemuOpts *opts, const QemuOptDesc *desc, Error **errp)
 {
     QemuOpt *opt;
-    Error *local_err = NULL;
 
     assert(opts_accepts_any(opts));
 
@@ -1084,9 +1079,8 @@ void qemu_opts_validate(QemuOpts *opts, const QemuOptDesc *desc, Error **errp)
             return;
         }
 
-        qemu_opt_parse(opt, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        qemu_opt_parse(opt, errp);
+        if (ERR_IS_SET(errp)) {
             return;
         }
     }
-- 
2.11.0.259.g40922b1
