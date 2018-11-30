Received: from eggs.gnu.org ([2001:4830:134:3::10]:51510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gSkZa-0007S8-CR
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:19:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gSkZY-0006Wt-6H
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:19:18 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 30 Nov 2018 17:17:47 +0200
Message-Id: <0a6d861a7b942e495dc79946a3eb225eb959decf.1543590618.git.berto@igalia.com>
In-Reply-To: <cover.1543590618.git.berto@igalia.com>
References: <cover.1543590618.git.berto@igalia.com>
In-Reply-To: <cover.1543590618.git.berto@igalia.com>
References: <cover.1543590618.git.berto@igalia.com>
Subject: [Qemu-devel] [RFC PATCH v2 09/12] block: Add 'runtime_opts' and
 'mutable_opts' fields to BlockDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This patch adds two new fields to BlockDriver:

   - runtime_opts: list of runtime options for a particular block
     driver. We'll use this list later to detect what options are
     missing when we try to reopen a block device.

   - mutable_opts: names of the runtime options that can be reset to
     their default value after a block device has been added. This way
     an option can not be reset by omitting it during reopen unless we
     explicitly allow it.

This also sets runtime_opts (and mutable_opts where appropriate) in
all drivers that allow reopening. Most of those drivers don't actually
support changing any of their options. If the user specifies a new
value for an option that can't be changed then we already detect that
and forbid it (in bdrv_reopen_prepare()). But if the user omits an
option in order to try to reset it to its default value we need to
detect that, so we'll use these two new fields for that.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/blkdebug.c          |  1 +
 block/crypto.c            |  1 +
 block/file-posix.c        | 10 ++++++++++
 block/iscsi.c             |  2 ++
 block/null.c              |  2 ++
 block/nvme.c              |  1 +
 block/qcow.c              |  1 +
 block/rbd.c               |  1 +
 block/sheepdog.c          |  2 ++
 block/vpc.c               |  1 +
 include/block/block_int.h |  5 +++++
 11 files changed, 27 insertions(+)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 0759452925..bba7645e09 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -893,6 +893,7 @@ static BlockDriver bdrv_blkdebug = {
     .protocol_name          = "blkdebug",
     .instance_size          = sizeof(BDRVBlkdebugState),
     .is_filter              = true,
+    .runtime_opts           = &runtime_opts,
 
     .bdrv_parse_filename    = blkdebug_parse_filename,
     .bdrv_file_open         = blkdebug_open,
diff --git a/block/crypto.c b/block/crypto.c
index 33ee01bebd..266b737bde 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -634,6 +634,7 @@ BlockDriver bdrv_crypto_luks = {
     .bdrv_co_create_opts = block_crypto_co_create_opts_luks,
     .bdrv_co_truncate   = block_crypto_co_truncate,
     .create_opts        = &block_crypto_create_opts_luks,
+    .runtime_opts       = &block_crypto_runtime_opts_luks,
 
     .bdrv_reopen_prepare = block_crypto_reopen_prepare,
     .bdrv_refresh_limits = block_crypto_refresh_limits,
diff --git a/block/file-posix.c b/block/file-posix.c
index 07bbdab953..9bffdf4566 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -439,6 +439,8 @@ static QemuOptsList raw_runtime_opts = {
     },
 };
 
+static const char *const mutable_opts[] = { "x-check-cache-dropped", NULL };
+
 static int raw_open_common(BlockDriverState *bs, QDict *options,
                            int bdrv_flags, int open_flags,
                            bool device, Error **errp)
@@ -2722,6 +2724,8 @@ BlockDriver bdrv_file = {
     .format_name = "file",
     .protocol_name = "file",
     .instance_size = sizeof(BDRVRawState),
+    .runtime_opts = &raw_runtime_opts,
+    .mutable_opts = mutable_opts,
     .bdrv_needs_filename = true,
     .bdrv_probe = NULL, /* no probe for protocols */
     .bdrv_parse_filename = raw_parse_filename,
@@ -3204,6 +3208,8 @@ static BlockDriver bdrv_host_device = {
     .format_name        = "host_device",
     .protocol_name        = "host_device",
     .instance_size      = sizeof(BDRVRawState),
+    .runtime_opts = &raw_runtime_opts,
+    .mutable_opts = mutable_opts,
     .bdrv_needs_filename = true,
     .bdrv_probe_device  = hdev_probe_device,
     .bdrv_parse_filename = hdev_parse_filename,
@@ -3330,6 +3336,8 @@ static BlockDriver bdrv_host_cdrom = {
     .format_name        = "host_cdrom",
     .protocol_name      = "host_cdrom",
     .instance_size      = sizeof(BDRVRawState),
+    .runtime_opts = &raw_runtime_opts,
+    .mutable_opts = mutable_opts,
     .bdrv_needs_filename = true,
     .bdrv_probe_device	= cdrom_probe_device,
     .bdrv_parse_filename = cdrom_parse_filename,
@@ -3463,6 +3471,8 @@ static BlockDriver bdrv_host_cdrom = {
     .format_name        = "host_cdrom",
     .protocol_name      = "host_cdrom",
     .instance_size      = sizeof(BDRVRawState),
+    .runtime_opts = &raw_runtime_opts,
+    .mutable_opts = mutable_opts,
     .bdrv_needs_filename = true,
     .bdrv_probe_device	= cdrom_probe_device,
     .bdrv_parse_filename = cdrom_parse_filename,
diff --git a/block/iscsi.c b/block/iscsi.c
index 727dee50bf..adfa6da6b7 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2433,6 +2433,7 @@ static BlockDriver bdrv_iscsi = {
     .bdrv_close             = iscsi_close,
     .bdrv_co_create_opts    = iscsi_co_create_opts,
     .create_opts            = &iscsi_create_opts,
+    .runtime_opts           = &runtime_opts,
     .bdrv_reopen_prepare    = iscsi_reopen_prepare,
     .bdrv_reopen_commit     = iscsi_reopen_commit,
     .bdrv_co_invalidate_cache = iscsi_co_invalidate_cache,
@@ -2470,6 +2471,7 @@ static BlockDriver bdrv_iser = {
     .bdrv_close             = iscsi_close,
     .bdrv_co_create_opts    = iscsi_co_create_opts,
     .create_opts            = &iscsi_create_opts,
+    .runtime_opts           = &runtime_opts,
     .bdrv_reopen_prepare    = iscsi_reopen_prepare,
     .bdrv_reopen_commit     = iscsi_reopen_commit,
     .bdrv_co_invalidate_cache  = iscsi_co_invalidate_cache,
diff --git a/block/null.c b/block/null.c
index d442d3e901..5df4b46723 100644
--- a/block/null.c
+++ b/block/null.c
@@ -256,6 +256,7 @@ static BlockDriver bdrv_null_co = {
     .format_name            = "null-co",
     .protocol_name          = "null-co",
     .instance_size          = sizeof(BDRVNullState),
+    .runtime_opts           = &runtime_opts,
 
     .bdrv_file_open         = null_file_open,
     .bdrv_parse_filename    = null_co_parse_filename,
@@ -275,6 +276,7 @@ static BlockDriver bdrv_null_aio = {
     .format_name            = "null-aio",
     .protocol_name          = "null-aio",
     .instance_size          = sizeof(BDRVNullState),
+    .runtime_opts           = &runtime_opts,
 
     .bdrv_file_open         = null_file_open,
     .bdrv_parse_filename    = null_aio_parse_filename,
diff --git a/block/nvme.c b/block/nvme.c
index 29294038fc..655b18dc27 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1143,6 +1143,7 @@ static BlockDriver bdrv_nvme = {
     .format_name              = "nvme",
     .protocol_name            = "nvme",
     .instance_size            = sizeof(BDRVNVMeState),
+    .runtime_opts             = &runtime_opts,
 
     .bdrv_parse_filename      = nvme_parse_filename,
     .bdrv_file_open           = nvme_file_open,
diff --git a/block/qcow.c b/block/qcow.c
index 4518cb4c35..5cceba7c16 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -1186,6 +1186,7 @@ static QemuOptsList qcow_create_opts = {
 static BlockDriver bdrv_qcow = {
     .format_name	= "qcow",
     .instance_size	= sizeof(BDRVQcowState),
+    .runtime_opts       = &qcow_runtime_opts,
     .bdrv_probe		= qcow_probe,
     .bdrv_open		= qcow_open,
     .bdrv_close		= qcow_close,
diff --git a/block/rbd.c b/block/rbd.c
index 8a1a9f4b6e..6de6112ce8 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1231,6 +1231,7 @@ static QemuOptsList qemu_rbd_create_opts = {
 static BlockDriver bdrv_rbd = {
     .format_name            = "rbd",
     .instance_size          = sizeof(BDRVRBDState),
+    .runtime_opts           = &runtime_opts,
     .bdrv_parse_filename    = qemu_rbd_parse_filename,
     .bdrv_refresh_limits    = qemu_rbd_refresh_limits,
     .bdrv_file_open         = qemu_rbd_open,
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 0125df9d49..28d64af517 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -3288,6 +3288,7 @@ static BlockDriver bdrv_sheepdog_tcp = {
     .bdrv_attach_aio_context      = sd_attach_aio_context,
 
     .create_opts                  = &sd_create_opts,
+    .runtime_opts                 = &runtime_opts,
 };
 
 static BlockDriver bdrv_sheepdog_unix = {
@@ -3325,6 +3326,7 @@ static BlockDriver bdrv_sheepdog_unix = {
     .bdrv_attach_aio_context      = sd_attach_aio_context,
 
     .create_opts                  = &sd_create_opts,
+    .runtime_opts                 = &runtime_opts,
 };
 
 static void bdrv_sheepdog_init(void)
diff --git a/block/vpc.c b/block/vpc.c
index 80c5b2b197..159f5c9ec6 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -1235,6 +1235,7 @@ static BlockDriver bdrv_vpc = {
     .bdrv_get_info          = vpc_get_info,
 
     .create_opts            = &vpc_create_opts,
+    .runtime_opts           = &vpc_runtime_opts,
     .bdrv_has_zero_init     = vpc_has_zero_init,
 };
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 05d925227a..6c2dffd8b9 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -345,6 +345,11 @@ struct BlockDriver {
 
     /* List of options for creating images, terminated by name == NULL */
     QemuOptsList *create_opts;
+    /* Runtime options for a block device, terminated by name == NULL */
+    QemuOptsList *runtime_opts;
+    /* Names of the runtime options that can be reset by omitting
+     * their value on reopen, NULL-terminated. */
+    const char *const *mutable_opts;
 
     /*
      * Returns 0 for completed check, -errno for internal errors.
-- 
2.11.0
