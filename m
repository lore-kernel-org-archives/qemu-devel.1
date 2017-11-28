Received: from eggs.gnu.org ([2001:4830:134:3::10]:37167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1eJejG-000646-8z
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1eJejF-0005S8-6z
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:11:10 -0500
From: "Denis V. Lunev" <den@openvz.org>
Date: Tue, 28 Nov 2017 15:10:55 +0300
Message-Id: <20171128121055.6954-3-den@openvz.org>
In-Reply-To: <20171128121055.6954-1-den@openvz.org>
References: <20171128121055.6954-1-den@openvz.org>
Subject: [Qemu-devel] [PATCH 2/2] ide: fix crash in IDE cdrom read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

There is the following crash reported from the field in QEMU 2.9:
    bdrv_inc_in_flight (bs=bs@entry=0x0)
    blk_aio_prwv
    blk_aio_preadv
    ide_buffered_readv
    cd_read_sector
    ide_data_readw
    portio_read
    memory_region_read_accessor
    access_with_adjusted_size
    memory_region_dispatch_read1
    memory_region_dispatch_read
    address_space_read_continue
    address_space_read_full
    address_space_read
    address_space_rw
    kvm_handle_io
    kvm_cpu_exec
    qemu_kvm_cpu_thread_fn
    start_thread
    clone
Indeed, the CDROM device without media has blk->bs == NULL. We should
check that the media is really available for the device like has been done
in SCSI code.

May be the patch adds a bit more check than necessary, but this is not be
the problem. We should always stay on the safe side.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: John Snow <jsnow@redhat.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/ide/atapi.c | 32 ++++++++++++++++++++++++++++----
 hw/ide/core.c  |  4 ++--
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index c0509c8bf5..fa50c0ccf6 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -119,6 +119,11 @@ cd_read_sector_sync(IDEState *s)
 
     trace_cd_read_sector_sync(s->lba);
 
+    if (!blk_is_available(s->blk)) {
+        ret = -ENOMEDIUM;
+        goto fail;
+    }
+
     switch (s->cd_sector_size) {
     case 2048:
         ret = blk_pread(s->blk, (int64_t)s->lba << ATAPI_SECTOR_BITS,
@@ -132,8 +137,8 @@ cd_read_sector_sync(IDEState *s)
         }
         break;
     default:
-        block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_READ);
-        return -EIO;
+        ret = -EIO;
+        goto fail;
     }
 
     if (ret < 0) {
@@ -145,6 +150,10 @@ cd_read_sector_sync(IDEState *s)
     }
 
     return ret;
+
+fail:
+    block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_READ);
+    return ret;
 }
 
 static void cd_read_sector_cb(void *opaque, int ret)
@@ -174,9 +183,15 @@ static void cd_read_sector_cb(void *opaque, int ret)
 
 static int cd_read_sector(IDEState *s)
 {
+    int err;
+
     if (s->cd_sector_size != 2048 && s->cd_sector_size != 2352) {
-        block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_READ);
-        return -EINVAL;
+        err = -EINVAL;
+        goto fail;
+    }
+    if (!blk_is_available(s->blk)) {
+        err = -ENOMEDIUM;
+        goto fail;
     }
 
     s->iov.iov_base = (s->cd_sector_size == 2352) ?
@@ -195,6 +210,10 @@ static int cd_read_sector(IDEState *s)
 
     s->status |= BUSY_STAT;
     return 0;
+
+fail:
+    block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_READ);
+    return err;
 }
 
 void ide_atapi_cmd_ok(IDEState *s)
@@ -404,6 +423,11 @@ static void ide_atapi_cmd_read_dma_cb(void *opaque, int ret)
         goto eot;
     }
 
+    if (!blk_is_available(s->blk)) {
+        ide_atapi_cmd_read_dma_cb(s, -ENOMEDIUM);
+        return;
+    }
+
     s->io_buffer_index = 0;
     if (s->cd_sector_size == 2352) {
         n = 1;
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 471d0c928b..71780fc9d1 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -758,7 +758,7 @@ static void ide_sector_read(IDEState *s)
 
     trace_ide_sector_read(sector_num, n);
 
-    if (!ide_sect_range_ok(s, sector_num, n)) {
+    if (!ide_sect_range_ok(s, sector_num, n) || !blk_is_available(s->blk)) {
         ide_rw_error(s);
         block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_READ);
         return;
@@ -1023,7 +1023,7 @@ static void ide_sector_write(IDEState *s)
 
     trace_ide_sector_write(sector_num, n);
 
-    if (!ide_sect_range_ok(s, sector_num, n)) {
+    if (!ide_sect_range_ok(s, sector_num, n) || !blk_is_available(s->blk)) {
         ide_rw_error(s);
         block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_WRITE);
         return;
-- 
2.11.0
