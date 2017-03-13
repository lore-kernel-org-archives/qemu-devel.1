Received: from eggs.gnu.org ([2001:4830:134:3::10]:42980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4f-0000iv-39
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4e-0002Wl-3b
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnW4d-0002WD-RS
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:08 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C96E4C05B1D3
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 19:56:07 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 13 Mar 2017 14:55:31 -0500
Message-Id: <20170313195547.21466-15-eblake@redhat.com>
In-Reply-To: <20170313195547.21466-1-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 14/30] trace: Fix parameter types in
 hw/display
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com

An upcoming patch will let the compiler warn us when we are silently
losing precision in traces; update the trace definitions to pass
through the full value at the callsite.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 hw/display/trace-events | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/display/trace-events b/hw/display/trace-events
index 3e896d2..515767d 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -10,17 +10,17 @@ xenfb_input_connected(void *xendev, int abs_pointer_wanted) "%p abs %d"

 # hw/display/g364fb.c
 g364fb_read(uint64_t addr, uint32_t val) "read addr=0x%"PRIx64": 0x%x"
-g364fb_write(uint64_t addr, uint32_t new) "write addr=0x%"PRIx64": 0x%x"
+g364fb_write(uint64_t addr, uint64_t new) "write addr=0x%"PRIx64": 0x%" PRIx64

 # hw/display/milkymist-tmu2.c
-milkymist_tmu2_memory_read(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_tmu2_memory_write(uint32_t addr, uint32_t value) "addr %08x value %08x"
+milkymist_tmu2_memory_read(hwaddr addr, uint32_t value) "addr %08" HWADDR_PRIx " value %08x"
+milkymist_tmu2_memory_write(hwaddr addr, uint64_t value) "addr %08" HWADDR_PRIx " value %08" PRIx64
 milkymist_tmu2_start(void) "Start TMU"
 milkymist_tmu2_pulse_irq(void) "Pulse IRQ"

 # hw/display/milkymist-vgafb.c
-milkymist_vgafb_memory_read(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_vgafb_memory_write(uint32_t addr, uint32_t value) "addr %08x value %08x"
+milkymist_vgafb_memory_read(hwaddr addr, uint32_t value) "addr %08" HWADDR_PRIx " value %08x"
+milkymist_vgafb_memory_write(hwaddr addr, uint64_t value) "addr %08" HWADDR_PRIx " value %08" PRIx64

 # hw/display/vmware_vga.c
 vmware_value_read(uint32_t index, uint32_t value) "index %d, value 0x%x"
@@ -61,11 +61,11 @@ qxl_create_guest_primary_rest(int qid, int32_t stride, uint32_t type, uint32_t f
 qxl_destroy_primary(int qid) "%d"
 qxl_enter_vga_mode(int qid) "%d"
 qxl_exit_vga_mode(int qid) "%d"
-qxl_hard_reset(int qid, int64_t loadvm) "%d loadvm=%"PRId64
+qxl_hard_reset(int qid, int loadvm) "%d loadvm=%d"
 qxl_interface_async_complete_io(int qid, uint32_t current_async, void *cookie) "%d current=%d cookie=%p"
 qxl_interface_attach_worker(int qid) "%d"
 qxl_interface_get_init_info(int qid) "%d"
-qxl_interface_set_compression_level(int qid, int64_t level) "%d %"PRId64
+qxl_interface_set_compression_level(int qid, int level) "%d %d"
 qxl_interface_update_area_complete(int qid, uint32_t surface_id, uint32_t dirty_left, uint32_t dirty_right, uint32_t dirty_top, uint32_t dirty_bottom) "%d surface=%d [%d,%d,%d,%d]"
 qxl_interface_update_area_complete_rest(int qid, uint32_t num_updated_rects) "%d #=%d"
 qxl_interface_update_area_complete_overflow(int qid, int max) "%d max=%d"
@@ -112,7 +112,7 @@ qxl_interrupt_client_monitors_config(int qid, int num_heads, void *heads) "%d %d
 qxl_client_monitors_config_unsupported_by_guest(int qid, uint32_t int_mask, void *client_monitors_config) "%d %X %p"
 qxl_client_monitors_config_unsupported_by_device(int qid, int revision) "%d revision=%d"
 qxl_client_monitors_config_capped(int qid, int requested, int limit) "%d %d %d"
-qxl_client_monitors_config_crc(int qid, unsigned size, uint32_t crc32) "%d %u %u"
+qxl_client_monitors_config_crc(int qid, size_t size, uint32_t crc32) "%d %zu %u"
 qxl_set_client_capabilities_unsupported_by_revision(int qid, int revision) "%d revision=%d"

 # hw/display/qxl-render.c
@@ -127,7 +127,7 @@ vga_vbe_read(uint32_t index, uint32_t val) "index 0x%x, val 0x%x"
 vga_vbe_write(uint32_t index, uint32_t val) "index 0x%x, val 0x%x"

 # hw/display/cirrus_vga.c
-vga_cirrus_read_io(uint32_t addr, uint32_t val) "addr 0x%x, val 0x%x"
-vga_cirrus_write_io(uint32_t addr, uint32_t val) "addr 0x%x, val 0x%x"
+vga_cirrus_read_io(hwaddr addr, int val) "addr 0x%" HWADDR_PRIx ", val 0x%x"
+vga_cirrus_write_io(hwaddr addr, uint64_t val) "addr 0x%" HWADDR_PRIx ", val 0x%" PRIx64
 vga_cirrus_read_blt(uint32_t offset, uint32_t val) "offset 0x%x, val 0x%x"
 vga_cirrus_write_blt(uint32_t offset, uint32_t val) "offset 0x%x, val 0x%x"
-- 
2.9.3
