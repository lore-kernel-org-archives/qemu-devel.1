Received: from eggs.gnu.org ([2001:4830:134:3::10]:42951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBud-0000Lo-OL
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBuc-0007wk-AC
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:31 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:58:15 +0100
Message-Id: <1487689130-30373-20-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 19/54] block: Request child permissions in
 format drivers
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

This makes use of the .bdrv_child_perm() implementation for formats that
we just added. All format drivers expose the permissions they actually
need nows, so that they can be set accordingly and updated when parents
are attached or detached.

The only format not included here is raw, which was already converted
with the other filter drivers.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/bochs.c     | 1 +
 block/cloop.c     | 1 +
 block/crypto.c    | 1 +
 block/dmg.c       | 1 +
 block/parallels.c | 1 +
 block/qcow.c      | 1 +
 block/qcow2.c     | 1 +
 block/qed.c       | 1 +
 block/vdi.c       | 1 +
 block/vhdx.c      | 1 +
 block/vmdk.c      | 1 +
 block/vpc.c       | 1 +
 12 files changed, 12 insertions(+)

diff --git a/block/bochs.c b/block/bochs.c
index 7dd2ac4..516da56 100644
--- a/block/bochs.c
+++ b/block/bochs.c
@@ -293,6 +293,7 @@ static BlockDriver bdrv_bochs = {
     .instance_size	= sizeof(BDRVBochsState),
     .bdrv_probe		= bochs_probe,
     .bdrv_open		= bochs_open,
+    .bdrv_child_perm     = bdrv_format_default_perms,
     .bdrv_refresh_limits = bochs_refresh_limits,
     .bdrv_co_preadv = bochs_co_preadv,
     .bdrv_close		= bochs_close,
diff --git a/block/cloop.c b/block/cloop.c
index 877c9b0..a6c7b9d 100644
--- a/block/cloop.c
+++ b/block/cloop.c
@@ -290,6 +290,7 @@ static BlockDriver bdrv_cloop = {
     .instance_size  = sizeof(BDRVCloopState),
     .bdrv_probe     = cloop_probe,
     .bdrv_open      = cloop_open,
+    .bdrv_child_perm     = bdrv_format_default_perms,
     .bdrv_refresh_limits = cloop_refresh_limits,
     .bdrv_co_preadv = cloop_co_preadv,
     .bdrv_close     = cloop_close,
diff --git a/block/crypto.c b/block/crypto.c
index 7cb2ff2..4a20388 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -628,6 +628,7 @@ BlockDriver bdrv_crypto_luks = {
     .bdrv_probe         = block_crypto_probe_luks,
     .bdrv_open          = block_crypto_open_luks,
     .bdrv_close         = block_crypto_close,
+    .bdrv_child_perm    = bdrv_format_default_perms,
     .bdrv_create        = block_crypto_create_luks,
     .bdrv_truncate      = block_crypto_truncate,
     .create_opts        = &block_crypto_create_opts_luks,
diff --git a/block/dmg.c b/block/dmg.c
index 8e387cd..a7d25fc 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -697,6 +697,7 @@ static BlockDriver bdrv_dmg = {
     .bdrv_probe     = dmg_probe,
     .bdrv_open      = dmg_open,
     .bdrv_refresh_limits = dmg_refresh_limits,
+    .bdrv_child_perm     = bdrv_format_default_perms,
     .bdrv_co_preadv = dmg_co_preadv,
     .bdrv_close     = dmg_close,
 };
diff --git a/block/parallels.c b/block/parallels.c
index b2ec09f..6b0c0a9 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -762,6 +762,7 @@ static BlockDriver bdrv_parallels = {
     .bdrv_probe		= parallels_probe,
     .bdrv_open		= parallels_open,
     .bdrv_close		= parallels_close,
+    .bdrv_child_perm          = bdrv_format_default_perms,
     .bdrv_co_get_block_status = parallels_co_get_block_status,
     .bdrv_has_zero_init       = bdrv_has_zero_init_1,
     .bdrv_co_flush_to_os      = parallels_co_flush_to_os,
diff --git a/block/qcow.c b/block/qcow.c
index 038b05a..eb5d54c 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -1052,6 +1052,7 @@ static BlockDriver bdrv_qcow = {
     .bdrv_probe		= qcow_probe,
     .bdrv_open		= qcow_open,
     .bdrv_close		= qcow_close,
+    .bdrv_child_perm        = bdrv_format_default_perms,
     .bdrv_reopen_prepare    = qcow_reopen_prepare,
     .bdrv_create            = qcow_create,
     .bdrv_has_zero_init     = bdrv_has_zero_init_1,
diff --git a/block/qcow2.c b/block/qcow2.c
index 21e6142..ef028f6 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3403,6 +3403,7 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_reopen_commit   = qcow2_reopen_commit,
     .bdrv_reopen_abort    = qcow2_reopen_abort,
     .bdrv_join_options    = qcow2_join_options,
+    .bdrv_child_perm      = bdrv_format_default_perms,
     .bdrv_create        = qcow2_create,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
     .bdrv_co_get_block_status = qcow2_co_get_block_status,
diff --git a/block/qed.c b/block/qed.c
index 62a0a09..d8f947a 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1704,6 +1704,7 @@ static BlockDriver bdrv_qed = {
     .bdrv_open                = bdrv_qed_open,
     .bdrv_close               = bdrv_qed_close,
     .bdrv_reopen_prepare      = bdrv_qed_reopen_prepare,
+    .bdrv_child_perm          = bdrv_format_default_perms,
     .bdrv_create              = bdrv_qed_create,
     .bdrv_has_zero_init       = bdrv_has_zero_init_1,
     .bdrv_co_get_block_status = bdrv_qed_co_get_block_status,
diff --git a/block/vdi.c b/block/vdi.c
index 18b4773..fd6e26d 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -891,6 +891,7 @@ static BlockDriver bdrv_vdi = {
     .bdrv_open = vdi_open,
     .bdrv_close = vdi_close,
     .bdrv_reopen_prepare = vdi_reopen_prepare,
+    .bdrv_child_perm          = bdrv_format_default_perms,
     .bdrv_create = vdi_create,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
     .bdrv_co_get_block_status = vdi_co_get_block_status,
diff --git a/block/vhdx.c b/block/vhdx.c
index 9918ee9..ab747f6 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1983,6 +1983,7 @@ static BlockDriver bdrv_vhdx = {
     .bdrv_open              = vhdx_open,
     .bdrv_close             = vhdx_close,
     .bdrv_reopen_prepare    = vhdx_reopen_prepare,
+    .bdrv_child_perm        = bdrv_format_default_perms,
     .bdrv_co_readv          = vhdx_co_readv,
     .bdrv_co_writev         = vhdx_co_writev,
     .bdrv_create            = vhdx_create,
diff --git a/block/vmdk.c b/block/vmdk.c
index 9d68ec5..f5e2fb5 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2359,6 +2359,7 @@ static BlockDriver bdrv_vmdk = {
     .bdrv_open                    = vmdk_open,
     .bdrv_check                   = vmdk_check,
     .bdrv_reopen_prepare          = vmdk_reopen_prepare,
+    .bdrv_child_perm              = bdrv_format_default_perms,
     .bdrv_co_preadv               = vmdk_co_preadv,
     .bdrv_co_pwritev              = vmdk_co_pwritev,
     .bdrv_co_pwritev_compressed   = vmdk_co_pwritev_compressed,
diff --git a/block/vpc.c b/block/vpc.c
index d0df2a1..b9c9832 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -1067,6 +1067,7 @@ static BlockDriver bdrv_vpc = {
     .bdrv_open              = vpc_open,
     .bdrv_close             = vpc_close,
     .bdrv_reopen_prepare    = vpc_reopen_prepare,
+    .bdrv_child_perm        = bdrv_format_default_perms,
     .bdrv_create            = vpc_create,
 
     .bdrv_co_preadv             = vpc_co_preadv,
-- 
1.8.3.1
