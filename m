Received: from eggs.gnu.org ([2001:4830:134:3::10]:53124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fTUVM-0000j8-V4
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:49:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fTUVI-0003nj-8y
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:49:45 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 14 Jun 2018 18:49:04 +0300
Message-Id: <54751f9032d94639042f0d502b1731a7b89f9099.1528991017.git.berto@igalia.com>
In-Reply-To: <cover.1528991017.git.berto@igalia.com>
References: <cover.1528991017.git.berto@igalia.com>
In-Reply-To: <cover.1528991017.git.berto@igalia.com>
References: <cover.1528991017.git.berto@igalia.com>
Subject: [Qemu-devel] [RFC PATCH 07/10] block: Add 'runtime_opts' and
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
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>

This patch adds two new fields to BlockDriver:

   - runtime_opts: list of runtime options for a particular block
     driver. We'll use this list later to detect what options are
     missing when we try to reopen a block device.

   - mutable_opts: names of the runtime options that can be modified
     after a block device has been added. This way an option can not
     be changed unless we explicitly allow it.

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
 include/block/block_int.h |  4 ++++
 11 files changed, 26 insertions(+)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 526af2a808..9b52465642 100644
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
index bc322b50f5..5da97799b2 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -696,6 +696,7 @@ BlockDriver bdrv_crypto_luks = {
     .bdrv_co_create_opts = block_crypto_co_create_opts_luks,
     .bdrv_truncate      = block_crypto_truncate,
     .create_opts        = &block_crypto_create_opts_luks,
+    .runtime_opts       = &block_crypto_runtime_opts_luks,
 
     .bdrv_reopen_prepare = block_crypto_reopen_prepare,
     .bdrv_refresh_limits = block_crypto_refresh_limits,
diff --git a/block/file-posix.c b/block/file-posix.c
index 1511a4d69d..d6fe8d17cf 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -429,6 +429,8 @@ static QemuOptsList raw_runtime_opts = {
     },
 };
 
+static const char *const mutable_opts[] = { "x-check-cache-dropped", NULL };
+
 static int raw_open_common(BlockDriverState *bs, QDict *options,
                            int bdrv_flags, int open_flags, Error **errp)
 {
@@ -2582,6 +2584,8 @@ BlockDriver bdrv_file = {
     .format_name = "file",
     .protocol_name = "file",
     .instance_size = sizeof(BDRVRawState),
+    .runtime_opts = &raw_runtime_opts,
+    .mutable_opts = mutable_opts,
     .bdrv_needs_filename = true,
     .bdrv_probe = NULL, /* no probe for protocols */
     .bdrv_parse_filename = raw_parse_filename,
@@ -3064,6 +3068,8 @@ static BlockDriver bdrv_host_device = {
     .format_name        = "host_device",
     .protocol_name        = "host_device",
     .instance_size      = sizeof(BDRVRawState),
+    .runtime_opts = &raw_runtime_opts,
+    .mutable_opts = mutable_opts,
     .bdrv_needs_filename = true,
     .bdrv_probe_device  = hdev_probe_device,
     .bdrv_parse_filename = hdev_parse_filename,
@@ -3189,6 +3195,8 @@ static BlockDriver bdrv_host_cdrom = {
     .format_name        = "host_cdrom",
     .protocol_name      = "host_cdrom",
     .instance_size      = sizeof(BDRVRawState),
+    .runtime_opts = &raw_runtime_opts,
+    .mutable_opts = mutable_opts,
     .bdrv_needs_filename = true,
     .bdrv_probe_device	= cdrom_probe_device,
     .bdrv_parse_filename = cdrom_parse_filename,
@@ -3321,6 +3329,8 @@ static BlockDriver bdrv_host_cdrom = {
     .format_name        = "host_cdrom",
     .protocol_name      = "host_cdrom",
     .instance_size      = sizeof(BDRVRawState),
+    .runtime_opts = &raw_runtime_opts,
+    .mutable_opts = mutable_opts,
     .bdrv_needs_filename = true,
     .bdrv_probe_device	= cdrom_probe_device,
     .bdrv_parse_filename = cdrom_parse_filename,
diff --git a/block/iscsi.c b/block/iscsi.c
index c2fbd8a8aa..5f68d11176 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2443,6 +2443,7 @@ static BlockDriver bdrv_iscsi = {
     .bdrv_close             = iscsi_close,
     .bdrv_co_create_opts    = iscsi_co_create_opts,
     .create_opts            = &iscsi_create_opts,
+    .runtime_opts           = &runtime_opts,
     .bdrv_reopen_prepare    = iscsi_reopen_prepare,
     .bdrv_reopen_commit     = iscsi_reopen_commit,
     .bdrv_co_invalidate_cache = iscsi_co_invalidate_cache,
@@ -2480,6 +2481,7 @@ static BlockDriver bdrv_iser = {
     .bdrv_close             = iscsi_close,
     .bdrv_co_create_opts    = iscsi_co_create_opts,
     .create_opts            = &iscsi_create_opts,
+    .runtime_opts           = &runtime_opts,
     .bdrv_reopen_prepare    = iscsi_reopen_prepare,
     .bdrv_reopen_commit     = iscsi_reopen_commit,
     .bdrv_co_invalidate_cache  = iscsi_co_invalidate_cache,
diff --git a/block/null.c b/block/null.c
index 5d610fdfba..fff3b12099 100644
--- a/block/null.c
+++ b/block/null.c
@@ -260,6 +260,7 @@ static BlockDriver bdrv_null_co = {
     .format_name            = "null-co",
     .protocol_name          = "null-co",
     .instance_size          = sizeof(BDRVNullState),
+    .runtime_opts           = &runtime_opts,
 
     .bdrv_file_open         = null_file_open,
     .bdrv_parse_filename    = null_co_parse_filename,
@@ -280,6 +281,7 @@ static BlockDriver bdrv_null_aio = {
     .format_name            = "null-aio",
     .protocol_name          = "null-aio",
     .instance_size          = sizeof(BDRVNullState),
+    .runtime_opts           = &runtime_opts,
 
     .bdrv_file_open         = null_file_open,
     .bdrv_parse_filename    = null_aio_parse_filename,
diff --git a/block/nvme.c b/block/nvme.c
index 6f71122bf5..5c77f82adb 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1158,6 +1158,7 @@ static BlockDriver bdrv_nvme = {
     .format_name              = "nvme",
     .protocol_name            = "nvme",
     .instance_size            = sizeof(BDRVNVMeState),
+    .runtime_opts             = &runtime_opts,
 
     .bdrv_parse_filename      = nvme_parse_filename,
     .bdrv_file_open           = nvme_file_open,
diff --git a/block/qcow.c b/block/qcow.c
index 1f866af0d3..1176d5dbef 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -1188,6 +1188,7 @@ static QemuOptsList qcow_create_opts = {
 static BlockDriver bdrv_qcow = {
     .format_name	= "qcow",
     .instance_size	= sizeof(BDRVQcowState),
+    .runtime_opts       = &qcow_runtime_opts,
     .bdrv_probe		= qcow_probe,
     .bdrv_open		= qcow_open,
     .bdrv_close		= qcow_close,
diff --git a/block/rbd.c b/block/rbd.c
index a16431e267..173d7a50b0 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1160,6 +1160,7 @@ static QemuOptsList qemu_rbd_create_opts = {
 static BlockDriver bdrv_rbd = {
     .format_name            = "rbd",
     .instance_size          = sizeof(BDRVRBDState),
+    .runtime_opts           = &runtime_opts,
     .bdrv_parse_filename    = qemu_rbd_parse_filename,
     .bdrv_refresh_limits    = qemu_rbd_refresh_limits,
     .bdrv_file_open         = qemu_rbd_open,
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 7b98725af7..6b27df169a 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -3301,6 +3301,7 @@ static BlockDriver bdrv_sheepdog_tcp = {
     .bdrv_attach_aio_context      = sd_attach_aio_context,
 
     .create_opts                  = &sd_create_opts,
+    .runtime_opts                 = &runtime_opts,
 };
 
 static BlockDriver bdrv_sheepdog_unix = {
@@ -3338,6 +3339,7 @@ static BlockDriver bdrv_sheepdog_unix = {
     .bdrv_attach_aio_context      = sd_attach_aio_context,
 
     .create_opts                  = &sd_create_opts,
+    .runtime_opts                 = &runtime_opts,
 };
 
 static void bdrv_sheepdog_init(void)
diff --git a/block/vpc.c b/block/vpc.c
index 0ebfcd3cc8..460212c261 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -1234,6 +1234,7 @@ static BlockDriver bdrv_vpc = {
     .bdrv_get_info          = vpc_get_info,
 
     .create_opts            = &vpc_create_opts,
+    .runtime_opts           = &vpc_runtime_opts,
     .bdrv_has_zero_init     = vpc_has_zero_init,
 };
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 327e478a73..eef3a55220 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -342,6 +342,10 @@ struct BlockDriver {
 
     /* List of options for creating images, terminated by name == NULL */
     QemuOptsList *create_opts;
+    /* Runtime options for a block device, terminated by name == NULL */
+    QemuOptsList *runtime_opts;
+    /* Names of the runtime options that can be modified, NULL-terminated */
+    const char *const *mutable_opts;
 
     /*
      * Returns 0 for completed check, -errno for internal errors.
-- 
2.11.0
