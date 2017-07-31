Received: from eggs.gnu.org ([2001:4830:134:3::10]:33773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dcD8l-0004fO-JV
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dcD8a-0008EP-5z
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:01:55 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:47818 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dcD8Y-0008Cn-Nm
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:01:44 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 31 Jul 2017 19:01:35 +0300
Message-Id: <20170731160135.12101-5-vsementsov@virtuozzo.com>
In-Reply-To: <20170731160135.12101-1-vsementsov@virtuozzo.com>
References: <20170731160135.12101-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 4/4] trace-events: fix code style: print 0x
 before hex numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, stefanha@gmail.com, peter.maydell@linaro.org, berrange@redhat.com, cohuck@redhat.com

The only exception are groups of numers separated by symbols
'.', ' ', ':', '/', like 'ab.09.7d'.

This patch is made by the following:

> find . -name trace-events | xargs python script.py

where script.py is the following python script:
=========================
 #!/usr/bin/env python

import sys
import re
import fileinput

rhex = '%[-+ *.0-9]*(?:[hljztL]|ll|hh)?(?:x|X|"\s*PRI[xX][^"]*"?)'
rgroup = re.compile('((?:' + rhex + '[.:/ ])+' + rhex + ')')
rbad = re.compile('(?<!0x)' + rhex)

files = sys.argv[1:]

for fname in files:
    for line in fileinput.input(fname, inplace=True):
        arr = re.split(rgroup, line)
        for i in range(0, len(arr), 2):
            arr[i] = re.sub(rbad, '0x\g<0>', arr[i])

        sys.stdout.write(''.join(arr))
=========================

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
---
 accel/tcg/trace-events    |   2 +-
 block/trace-events        |  22 +++----
 hw/audio/trace-events     |   4 +-
 hw/char/trace-events      |  12 ++--
 hw/display/trace-events   |  12 ++--
 hw/dma/trace-events       |  20 +++---
 hw/i386/xen/trace-events  |   4 +-
 hw/input/trace-events     |   4 +-
 hw/intc/trace-events      | 156 +++++++++++++++++++++++-----------------------
 hw/isa/trace-events       |   4 +-
 hw/misc/trace-events      |  78 +++++++++++------------
 hw/net/trace-events       |  34 +++++-----
 hw/nvram/trace-events     |   2 +-
 hw/ppc/trace-events       |  64 +++++++++----------
 hw/s390x/trace-events     |  20 +++---
 hw/scsi/trace-events      | 112 ++++++++++++++++-----------------
 hw/sd/trace-events        |   4 +-
 hw/timer/trace-events     |  20 +++---
 hw/usb/trace-events       |  56 ++++++++---------
 hw/vfio/trace-events      |  44 ++++++-------
 hw/virtio/trace-events    |   6 +-
 linux-user/trace-events   |  10 +--
 migration/trace-events    |  36 +++++------
 nbd/trace-events          |  18 +++---
 net/trace-events          |   4 +-
 target/arm/trace-events   |  10 +--
 target/s390x/trace-events |   2 +-
 target/sparc/trace-events |  30 ++++-----
 28 files changed, 395 insertions(+), 395 deletions(-)

diff --git a/accel/tcg/trace-events b/accel/tcg/trace-events
index 2de8359670..c22ad60af7 100644
--- a/accel/tcg/trace-events
+++ b/accel/tcg/trace-events
@@ -4,7 +4,7 @@
 # cpu-exec.c
 disable exec_tb(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
 disable exec_tb_nocache(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
-disable exec_tb_exit(void *last_tb, unsigned int flags) "tb:%p flags=%x"
+disable exec_tb_exit(void *last_tb, unsigned int flags) "tb:%p flags=0x%x"
 
 # translate-all.c
 translate_block(void *tb, uintptr_t pc, uint8_t *tb_code) "tb:%p, pc:0x%"PRIxPTR", tb_code:%p"
diff --git a/block/trace-events b/block/trace-events
index 14351753af..071a8d77ba 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -5,8 +5,8 @@ bdrv_open_common(void *bs, const char *filename, int flags, const char *format_n
 bdrv_lock_medium(void *bs, bool locked) "bs %p locked %d"
 
 # block/block-backend.c
-blk_co_preadv(void *blk, void *bs, int64_t offset, unsigned int bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %u flags %x"
-blk_co_pwritev(void *blk, void *bs, int64_t offset, unsigned int bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %u flags %x"
+blk_co_preadv(void *blk, void *bs, int64_t offset, unsigned int bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %u flags 0x%x"
+blk_co_pwritev(void *blk, void *bs, int64_t offset, unsigned int bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %u flags 0x%x"
 
 # block/io.c
 bdrv_co_readv(void *bs, int64_t sector_num, int nb_sector) "bs %p sector_num %"PRId64" nb_sectors %d"
@@ -54,19 +54,19 @@ paio_submit_co(int64_t offset, int count, int type) "offset %"PRId64" count %d t
 paio_submit(void *acb, void *opaque, int64_t offset, int count, int type) "acb %p opaque %p offset %"PRId64" count %d type %d"
 
 # block/qcow2.c
-qcow2_writev_start_req(void *co, int64_t offset, int bytes) "co %p offset %" PRIx64 " bytes %d"
+qcow2_writev_start_req(void *co, int64_t offset, int bytes) "co %p offset 0x%" PRIx64 " bytes %d"
 qcow2_writev_done_req(void *co, int ret) "co %p ret %d"
 qcow2_writev_start_part(void *co) "co %p"
 qcow2_writev_done_part(void *co, int cur_bytes) "co %p cur_bytes %d"
-qcow2_writev_data(void *co, uint64_t offset) "co %p offset %" PRIx64
-qcow2_pwrite_zeroes_start_req(void *co, int64_t offset, int count) "co %p offset %" PRIx64 " count %d"
-qcow2_pwrite_zeroes(void *co, int64_t offset, int count) "co %p offset %" PRIx64 " count %d"
+qcow2_writev_data(void *co, uint64_t offset) "co %p offset 0x%" PRIx64
+qcow2_pwrite_zeroes_start_req(void *co, int64_t offset, int count) "co %p offset 0x%" PRIx64 " count %d"
+qcow2_pwrite_zeroes(void *co, int64_t offset, int count) "co %p offset 0x%" PRIx64 " count %d"
 
 # block/qcow2-cluster.c
-qcow2_alloc_clusters_offset(void *co, uint64_t offset, int bytes) "co %p offset %" PRIx64 " bytes %d"
-qcow2_handle_copied(void *co, uint64_t guest_offset, uint64_t host_offset, uint64_t bytes) "co %p guest_offset %" PRIx64 " host_offset %" PRIx64 " bytes %" PRIx64
-qcow2_handle_alloc(void *co, uint64_t guest_offset, uint64_t host_offset, uint64_t bytes) "co %p guest_offset %" PRIx64 " host_offset %" PRIx64 " bytes %" PRIx64
-qcow2_do_alloc_clusters_offset(void *co, uint64_t guest_offset, uint64_t host_offset, int nb_clusters) "co %p guest_offset %" PRIx64 " host_offset %" PRIx64 " nb_clusters %d"
+qcow2_alloc_clusters_offset(void *co, uint64_t offset, int bytes) "co %p offset 0x%" PRIx64 " bytes %d"
+qcow2_handle_copied(void *co, uint64_t guest_offset, uint64_t host_offset, uint64_t bytes) "co %p guest_offset 0x%" PRIx64 " host_offset 0x%" PRIx64 " bytes 0x%" PRIx64
+qcow2_handle_alloc(void *co, uint64_t guest_offset, uint64_t host_offset, uint64_t bytes) "co %p guest_offset 0x%" PRIx64 " host_offset 0x%" PRIx64 " bytes 0x%" PRIx64
+qcow2_do_alloc_clusters_offset(void *co, uint64_t guest_offset, uint64_t host_offset, int nb_clusters) "co %p guest_offset 0x%" PRIx64 " host_offset 0x%" PRIx64 " nb_clusters %d"
 qcow2_cluster_alloc_phys(void *co) "co %p"
 qcow2_cluster_link_l2(void *co, int nb_clusters) "co %p nb_clusters %d"
 
@@ -77,7 +77,7 @@ qcow2_l2_allocate_write_l1(void *bs, int l1_index) "bs %p l1_index %d"
 qcow2_l2_allocate_done(void *bs, int l1_index, int ret) "bs %p l1_index %d ret %d"
 
 # block/qcow2-cache.c
-qcow2_cache_get(void *co, int c, uint64_t offset, bool read_from_disk) "co %p is_l2_cache %d offset %" PRIx64 " read_from_disk %d"
+qcow2_cache_get(void *co, int c, uint64_t offset, bool read_from_disk) "co %p is_l2_cache %d offset 0x%" PRIx64 " read_from_disk %d"
 qcow2_cache_get_replace_entry(void *co, int c, int i) "co %p is_l2_cache %d index %d"
 qcow2_cache_get_read(void *co, int c, int i) "co %p is_l2_cache %d index %d"
 qcow2_cache_get_done(void *co, int c, int i) "co %p is_l2_cache %d index %d"
diff --git a/hw/audio/trace-events b/hw/audio/trace-events
index 47e2ed53d7..fa1646d169 100644
--- a/hw/audio/trace-events
+++ b/hw/audio/trace-events
@@ -7,8 +7,8 @@ cs4231_mem_writel_reg(uint32_t reg, uint32_t old, uint32_t val) "write reg %d: 0
 cs4231_mem_writel_dreg(uint32_t reg, uint32_t old, uint32_t val) "write dreg %d: 0x%02x -> 0x%02x"
 
 # hw/audio/milkymist-ac97.c
-milkymist_ac97_memory_read(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_ac97_memory_write(uint32_t addr, uint32_t value) "addr %08x value %08x"
+milkymist_ac97_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+milkymist_ac97_memory_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
 milkymist_ac97_pulse_irq_crrequest(void) "Pulse IRQ CR request"
 milkymist_ac97_pulse_irq_crreply(void) "Pulse IRQ CR reply"
 milkymist_ac97_pulse_irq_dmaw(void) "Pulse IRQ DMA write"
diff --git a/hw/char/trace-events b/hw/char/trace-events
index eeb1a0a527..ebd8a92450 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -28,8 +28,8 @@ lm32_uart_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
 lm32_uart_irq_state(int level) "irq state %d"
 
 # hw/char/milkymist-uart.c
-milkymist_uart_memory_read(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_uart_memory_write(uint32_t addr, uint32_t value) "addr %08x value %08x"
+milkymist_uart_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+milkymist_uart_memory_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
 milkymist_uart_raise_irq(void) "Raise IRQ"
 milkymist_uart_lower_irq(void) "Lower IRQ"
 
@@ -38,22 +38,22 @@ escc_put_queue(char channel, int b) "channel %c put: 0x%02x"
 escc_get_queue(char channel, int val) "channel %c get 0x%02x"
 escc_update_irq(int irq) "IRQ = %d"
 escc_update_parameters(char channel, int speed, int parity, int data_bits, int stop_bits) "channel %c: speed=%d parity=%c data=%d stop=%d"
-escc_mem_writeb_ctrl(char channel, uint32_t reg, uint32_t val) "Write channel %c, reg[%d] = %2.2x"
+escc_mem_writeb_ctrl(char channel, uint32_t reg, uint32_t val) "Write channel %c, reg[%d] = 0x%2.2x"
 escc_mem_writeb_data(char channel, uint32_t val) "Write channel %c, ch %d"
-escc_mem_readb_ctrl(char channel, uint32_t reg, uint8_t val) "Read channel %c, reg[%d] = %2.2x"
+escc_mem_readb_ctrl(char channel, uint32_t reg, uint8_t val) "Read channel %c, reg[%d] = 0x%2.2x"
 escc_mem_readb_data(char channel, uint32_t ret) "Read channel %c, ch %d"
 escc_serial_receive_byte(char channel, int ch) "channel %c put ch %d"
 escc_sunkbd_event_in(int ch, const char *name, int down) "QKeyCode 0x%2.2x [%s], down %d"
 escc_sunkbd_event_out(int ch) "Translated keycode 0x%2.2x"
 escc_kbd_command(int val) "Command %d"
-escc_sunmouse_event(int dx, int dy, int buttons_state) "dx=%d dy=%d buttons=%01x"
+escc_sunmouse_event(int dx, int dy, int buttons_state) "dx=%d dy=%d buttons=0x%01x"
 
 # hw/char/pl011.c
 pl011_irq_state(int level) "irq state %d"
 pl011_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
 pl011_read_fifo(int read_count) "FIFO read, read_count now %d"
 pl011_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
-pl011_can_receive(uint32_t lcr, int read_count, int r) "LCR %08x read_count %d returning %d"
+pl011_can_receive(uint32_t lcr, int read_count, int r) "LCR 0x%08x read_count %d returning %d"
 pl011_put_fifo(uint32_t c, int read_count) "new char 0x%x read_count now %d"
 pl011_put_fifo_full(void) "FIFO now full, RXFF set"
 
diff --git a/hw/display/trace-events b/hw/display/trace-events
index d9d408c2fd..ed8cca0755 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -13,14 +13,14 @@ g364fb_read(uint64_t addr, uint32_t val) "read addr=0x%"PRIx64": 0x%x"
 g364fb_write(uint64_t addr, uint32_t new) "write addr=0x%"PRIx64": 0x%x"
 
 # hw/display/milkymist-tmu2.c
-milkymist_tmu2_memory_read(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_tmu2_memory_write(uint32_t addr, uint32_t value) "addr %08x value %08x"
+milkymist_tmu2_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+milkymist_tmu2_memory_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
 milkymist_tmu2_start(void) "Start TMU"
 milkymist_tmu2_pulse_irq(void) "Pulse IRQ"
 
 # hw/display/milkymist-vgafb.c
-milkymist_vgafb_memory_read(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_vgafb_memory_write(uint32_t addr, uint32_t value) "addr %08x value %08x"
+milkymist_vgafb_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+milkymist_vgafb_memory_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
 
 # hw/display/vmware_vga.c
 vmware_value_read(uint32_t index, uint32_t value) "index %d, value 0x%x"
@@ -56,7 +56,7 @@ virtio_gpu_fence_resp(uint64_t fence) "fence 0x%" PRIx64
 # hw/display/qxl.c
 disable qxl_interface_set_mm_time(int qid, uint32_t mm_time) "%d %d"
 disable qxl_io_write_vga(int qid, const char *mode, uint32_t addr, uint32_t val) "%d %s addr=%u val=%u"
-qxl_create_guest_primary(int qid, uint32_t width, uint32_t height, uint64_t mem, uint32_t format, uint32_t position) "%d %ux%u mem=%" PRIx64 " %u,%u"
+qxl_create_guest_primary(int qid, uint32_t width, uint32_t height, uint64_t mem, uint32_t format, uint32_t position) "%d %ux%u mem=0x%" PRIx64 " %u,%u"
 qxl_create_guest_primary_rest(int qid, int32_t stride, uint32_t type, uint32_t flags) "%d %d,%d,%d"
 qxl_destroy_primary(int qid) "%d"
 qxl_enter_vga_mode(int qid) "%d"
@@ -109,7 +109,7 @@ qxl_send_events(int qid, uint32_t events) "%d %d"
 qxl_send_events_vm_stopped(int qid, uint32_t events) "%d %d"
 qxl_set_guest_bug(int qid) "%d"
 qxl_interrupt_client_monitors_config(int qid, int num_heads, void *heads) "%d %d %p"
-qxl_client_monitors_config_unsupported_by_guest(int qid, uint32_t int_mask, void *client_monitors_config) "%d %X %p"
+qxl_client_monitors_config_unsupported_by_guest(int qid, uint32_t int_mask, void *client_monitors_config) "%d 0x%X %p"
 qxl_client_monitors_config_unsupported_by_device(int qid, int revision) "%d revision=%d"
 qxl_client_monitors_config_capped(int qid, int requested, int limit) "%d %d %d"
 qxl_client_monitors_config_crc(int qid, unsigned size, uint32_t crc32) "%d %u %u"
diff --git a/hw/dma/trace-events b/hw/dma/trace-events
index 40e9688325..428469a140 100644
--- a/hw/dma/trace-events
+++ b/hw/dma/trace-events
@@ -13,20 +13,20 @@ sparc32_dma_set_irq_raise(void) "Raise IRQ"
 sparc32_dma_set_irq_lower(void) "Lower IRQ"
 espdma_memory_read(uint32_t addr) "DMA read addr 0x%08x"
 espdma_memory_write(uint32_t addr) "DMA write addr 0x%08x"
-sparc32_dma_mem_readl(uint64_t addr, uint32_t ret) "read dmareg %"PRIx64": 0x%08x"
-sparc32_dma_mem_writel(uint64_t addr, uint32_t old, uint32_t val) "write dmareg %"PRIx64": 0x%08x -> 0x%08x"
+sparc32_dma_mem_readl(uint64_t addr, uint32_t ret) "read dmareg 0x%"PRIx64": 0x%08x"
+sparc32_dma_mem_writel(uint64_t addr, uint32_t old, uint32_t val) "write dmareg 0x%"PRIx64": 0x%08x -> 0x%08x"
 sparc32_dma_enable_raise(void) "Raise DMA enable"
 sparc32_dma_enable_lower(void) "Lower DMA enable"
 
 # hw/dma/sun4m_iommu.c
-sun4m_iommu_mem_readl(uint64_t addr, uint32_t ret) "read reg[%"PRIx64"] = %x"
-sun4m_iommu_mem_writel(uint64_t addr, uint32_t val) "write reg[%"PRIx64"] = %x"
-sun4m_iommu_mem_writel_ctrl(uint64_t iostart) "iostart = %"PRIx64
-sun4m_iommu_mem_writel_tlbflush(uint32_t val) "tlb flush %x"
-sun4m_iommu_mem_writel_pgflush(uint32_t val) "page flush %x"
-sun4m_iommu_page_get_flags(uint64_t pa, uint64_t iopte, uint32_t ret) "get flags addr %"PRIx64" => pte %"PRIx64", *pte = %x"
-sun4m_iommu_translate_pa(uint64_t addr, uint64_t pa, uint32_t iopte) "xlate dva %"PRIx64" => pa %"PRIx64" iopte = %x"
-sun4m_iommu_bad_addr(uint64_t addr) "bad addr %"PRIx64
+sun4m_iommu_mem_readl(uint64_t addr, uint32_t ret) "read reg[0x%"PRIx64"] = 0x%x"
+sun4m_iommu_mem_writel(uint64_t addr, uint32_t val) "write reg[0x%"PRIx64"] = 0x%x"
+sun4m_iommu_mem_writel_ctrl(uint64_t iostart) "iostart = 0x%"PRIx64
+sun4m_iommu_mem_writel_tlbflush(uint32_t val) "tlb flush 0x%x"
+sun4m_iommu_mem_writel_pgflush(uint32_t val) "page flush 0x%x"
+sun4m_iommu_page_get_flags(uint64_t pa, uint64_t iopte, uint32_t ret) "get flags addr 0x%"PRIx64" => pte 0x%"PRIx64", *pte = 0x%x"
+sun4m_iommu_translate_pa(uint64_t addr, uint64_t pa, uint32_t iopte) "xlate dva 0x%"PRIx64" => pa 0x%"PRIx64" iopte = 0x%x"
+sun4m_iommu_bad_addr(uint64_t addr) "bad addr 0x%"PRIx64
 
 # hw/dma/i8257.c
 i8257_unregistered_dma(int nchan, int dma_pos, int dma_len) "unregistered DMA channel used nchan=%d dma_pos=%d dma_len=%d"
diff --git a/hw/i386/xen/trace-events b/hw/i386/xen/trace-events
index 28a8d7dd82..8dab7bcfe0 100644
--- a/hw/i386/xen/trace-events
+++ b/hw/i386/xen/trace-events
@@ -2,8 +2,8 @@
 xen_platform_log(char *s) "xen platform: %s"
 
 # hw/i386/xen/xen_pvdevice.c
-xen_pv_mmio_read(uint64_t addr) "WARNING: read from Xen PV Device MMIO space (address %"PRIx64")"
-xen_pv_mmio_write(uint64_t addr) "WARNING: write to Xen PV Device MMIO space (address %"PRIx64")"
+xen_pv_mmio_read(uint64_t addr) "WARNING: read from Xen PV Device MMIO space (address 0x%"PRIx64")"
+xen_pv_mmio_write(uint64_t addr) "WARNING: write to Xen PV Device MMIO space (address 0x%"PRIx64")"
 
 # xen-hvm.c
 xen_ram_alloc(unsigned long ram_addr, unsigned long size) "requested: 0x%lx, size 0x%lx"
diff --git a/hw/input/trace-events b/hw/input/trace-events
index 88b56f8282..6fcb3c063f 100644
--- a/hw/input/trace-events
+++ b/hw/input/trace-events
@@ -16,8 +16,8 @@ ps2_kbd_init(void *s) "%p"
 ps2_mouse_init(void *s) "%p"
 
 # hw/input/milkymist-softusb.c
-milkymist_softusb_memory_read(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_softusb_memory_write(uint32_t addr, uint32_t value) "addr %08x value %08x"
+milkymist_softusb_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+milkymist_softusb_memory_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
 milkymist_softusb_mevt(uint8_t m) "m %d"
 milkymist_softusb_kevt(uint8_t m) "m %d"
 milkymist_softusb_pulse_irq(void) "Pulse IRQ"
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index fad8b36e04..4762329482 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -1,8 +1,8 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
 # hw/intc/apic_common.c
-cpu_set_apic_base(uint64_t val) "%016"PRIx64
-cpu_get_apic_base(uint64_t val) "%016"PRIx64
+cpu_set_apic_base(uint64_t val) "0x%016"PRIx64
+cpu_get_apic_base(uint64_t val) "0x%016"PRIx64
 # coalescing
 apic_report_irq_delivered(int apic_irq_delivered) "coalescing %d"
 apic_reset_irq_delivered(int apic_irq_delivered) "old coalescing %d"
@@ -11,8 +11,8 @@ apic_get_irq_delivered(int apic_irq_delivered) "returning coalescing %d"
 # hw/intc/apic.c
 apic_local_deliver(int vector, uint32_t lvt) "vector %d delivery mode %d"
 apic_deliver_irq(uint8_t dest, uint8_t dest_mode, uint8_t delivery_mode, uint8_t vector_num, uint8_t trigger_mode) "dest %d dest_mode %d delivery_mode %d vector %d trigger_mode %d"
-apic_mem_readl(uint64_t addr, uint32_t val)  "%"PRIx64" = %08x"
-apic_mem_writel(uint64_t addr, uint32_t val) "%"PRIx64" = %08x"
+apic_mem_readl(uint64_t addr, uint32_t val)  "0x%"PRIx64" = 0x%08x"
+apic_mem_writel(uint64_t addr, uint32_t val) "0x%"PRIx64" = 0x%08x"
 
 # hw/intc/ioapic.c
 ioapic_set_remote_irr(int n) "set remote irr for pin %d"
@@ -22,16 +22,16 @@ ioapic_mem_read(uint8_t addr, uint8_t size, uint32_t val) "ioapic mem read addr
 ioapic_mem_write(uint8_t addr, uint8_t size, uint32_t val) "ioapic mem write addr 0x%"PRIx8" size 0x%"PRIx8" val 0x%"PRIx32
 
 # hw/intc/slavio_intctl.c
-slavio_intctl_mem_readl(uint32_t cpu, uint64_t addr, uint32_t ret) "read cpu %d reg 0x%"PRIx64" = %x"
-slavio_intctl_mem_writel(uint32_t cpu, uint64_t addr, uint32_t val) "write cpu %d reg 0x%"PRIx64" = %x"
-slavio_intctl_mem_writel_clear(uint32_t cpu, uint32_t val, uint32_t intreg_pending) "Cleared cpu %d irq mask %x, curmask %x"
-slavio_intctl_mem_writel_set(uint32_t cpu, uint32_t val, uint32_t intreg_pending) "Set cpu %d irq mask %x, curmask %x"
-slavio_intctlm_mem_readl(uint64_t addr, uint32_t ret) "read system reg 0x%"PRIx64" = %x"
-slavio_intctlm_mem_writel(uint64_t addr, uint32_t val) "write system reg 0x%"PRIx64" = %x"
-slavio_intctlm_mem_writel_enable(uint32_t val, uint32_t intregm_disabled) "Enabled master irq mask %x, curmask %x"
-slavio_intctlm_mem_writel_disable(uint32_t val, uint32_t intregm_disabled) "Disabled master irq mask %x, curmask %x"
+slavio_intctl_mem_readl(uint32_t cpu, uint64_t addr, uint32_t ret) "read cpu %d reg 0x%"PRIx64" = 0x%x"
+slavio_intctl_mem_writel(uint32_t cpu, uint64_t addr, uint32_t val) "write cpu %d reg 0x%"PRIx64" = 0x%x"
+slavio_intctl_mem_writel_clear(uint32_t cpu, uint32_t val, uint32_t intreg_pending) "Cleared cpu %d irq mask 0x%x, curmask 0x%x"
+slavio_intctl_mem_writel_set(uint32_t cpu, uint32_t val, uint32_t intreg_pending) "Set cpu %d irq mask 0x%x, curmask 0x%x"
+slavio_intctlm_mem_readl(uint64_t addr, uint32_t ret) "read system reg 0x%"PRIx64" = 0x%x"
+slavio_intctlm_mem_writel(uint64_t addr, uint32_t val) "write system reg 0x%"PRIx64" = 0x%x"
+slavio_intctlm_mem_writel_enable(uint32_t val, uint32_t intregm_disabled) "Enabled master irq mask 0x%x, curmask 0x%x"
+slavio_intctlm_mem_writel_disable(uint32_t val, uint32_t intregm_disabled) "Disabled master irq mask 0x%x, curmask 0x%x"
 slavio_intctlm_mem_writel_target(uint32_t cpu) "Set master irq cpu %d"
-slavio_check_interrupts(uint32_t pending, uint32_t intregm_disabled) "pending %x disabled %x"
+slavio_check_interrupts(uint32_t pending, uint32_t intregm_disabled) "pending 0x%x disabled 0x%x"
 slavio_set_irq(uint32_t target_cpu, int irq, uint32_t pil, int level) "Set cpu %d irq %d -> pil %d level %d"
 slavio_set_timer_irq_cpu(int cpu, int level) "Set cpu %d local timer level %d"
 
@@ -74,8 +74,8 @@ flic_no_device_api(int err) "flic: no Device Contral API support %d"
 flic_reset_failed(int err) "flic: reset failed %d"
 
 # hw/intc/s390_flic.c
-qemu_s390_airq_suppressed(uint8_t type, uint8_t isc) "flic: adapter I/O interrupt suppressed (type %x isc %x)"
-qemu_s390_suppress_airq(uint8_t isc, const char *from, const char *to) "flic: for isc %x, suppress airq by modifying ais mode from %s to %s"
+qemu_s390_airq_suppressed(uint8_t type, uint8_t isc) "flic: adapter I/O interrupt suppressed (type 0x%x isc 0x%x)"
+qemu_s390_suppress_airq(uint8_t isc, const char *from, const char *to) "flic: for isc 0x%x, suppress airq by modifying ais mode from %s to %s"
 
 # hw/intc/aspeed_vic.c
 aspeed_vic_set_irq(int irq, int level) "Enabling IRQ %d: %d"
@@ -93,63 +93,63 @@ gic_update_set_irq(int cpu, const char *name, int level) "cpu[%d]: %s = %d"
 gic_acknowledge_irq(int cpu, int irq) "cpu %d acknowledged irq %d"
 
 # hw/intc/arm_gicv3_cpuif.c
-gicv3_icc_pmr_read(uint32_t cpu, uint64_t val) "GICv3 ICC_PMR read cpu %x value 0x%" PRIx64
-gicv3_icc_pmr_write(uint32_t cpu, uint64_t val) "GICv3 ICC_PMR write cpu %x value 0x%" PRIx64
-gicv3_icc_bpr_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICC_BPR%d read cpu %x value 0x%" PRIx64
-gicv3_icc_bpr_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICC_BPR%d write cpu %x value 0x%" PRIx64
-gicv3_icc_ap_read(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICC_AP%dR%d read cpu %x value 0x%" PRIx64
-gicv3_icc_ap_write(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICC_AP%dR%d write cpu %x value 0x%" PRIx64
-gicv3_icc_igrpen_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICC_IGRPEN%d read cpu %x value 0x%" PRIx64
-gicv3_icc_igrpen_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICC_IGRPEN%d write cpu %x value 0x%" PRIx64
-gicv3_icc_igrpen1_el3_read(uint32_t cpu, uint64_t val) "GICv3 ICC_IGRPEN1_EL3 read cpu %x value 0x%" PRIx64
-gicv3_icc_igrpen1_el3_write(uint32_t cpu, uint64_t val) "GICv3 ICC_IGRPEN1_EL3 write cpu %x value 0x%" PRIx64
-gicv3_icc_ctlr_read(uint32_t cpu, uint64_t val) "GICv3 ICC_CTLR read cpu %x value 0x%" PRIx64
-gicv3_icc_ctlr_write(uint32_t cpu, uint64_t val) "GICv3 ICC_CTLR write cpu %x value 0x%" PRIx64
-gicv3_icc_ctlr_el3_read(uint32_t cpu, uint64_t val) "GICv3 ICC_CTLR_EL3 read cpu %x value 0x%" PRIx64
-gicv3_icc_ctlr_el3_write(uint32_t cpu, uint64_t val) "GICv3 ICC_CTLR_EL3 write cpu %x value 0x%" PRIx64
-gicv3_cpuif_update(uint32_t cpuid, int irq, int grp, int prio) "GICv3 CPU i/f %x HPPI update: irq %d group %d prio %d"
-gicv3_cpuif_set_irqs(uint32_t cpuid, int fiqlevel, int irqlevel) "GICv3 CPU i/f %x HPPI update: setting FIQ %d IRQ %d"
-gicv3_icc_generate_sgi(uint32_t cpuid, int irq, int irm, uint32_t aff, uint32_t targetlist) "GICv3 CPU i/f %x generating SGI %d IRM %d target affinity 0x%xxx targetlist 0x%x"
-gicv3_icc_iar0_read(uint32_t cpu, uint64_t val) "GICv3 ICC_IAR0 read cpu %x value 0x%" PRIx64
-gicv3_icc_iar1_read(uint32_t cpu, uint64_t val) "GICv3 ICC_IAR1 read cpu %x value 0x%" PRIx64
-gicv3_icc_eoir_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICC_EOIR%d write cpu %x value 0x%" PRIx64
-gicv3_icc_hppir0_read(uint32_t cpu, uint64_t val) "GICv3 ICC_HPPIR0 read cpu %x value 0x%" PRIx64
-gicv3_icc_hppir1_read(uint32_t cpu, uint64_t val) "GICv3 ICC_HPPIR1 read cpu %x value 0x%" PRIx64
-gicv3_icc_dir_write(uint32_t cpu, uint64_t val) "GICv3 ICC_DIR write cpu %x value 0x%" PRIx64
-gicv3_icc_rpr_read(uint32_t cpu, uint64_t val) "GICv3 ICC_RPR read cpu %x value 0x%" PRIx64
-gicv3_ich_ap_read(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_AP%dR%d read cpu %x value 0x%" PRIx64
-gicv3_ich_ap_write(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_AP%dR%d write cpu %x value 0x%" PRIx64
-gicv3_ich_hcr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_HCR_EL2 read cpu %x value 0x%" PRIx64
-gicv3_ich_hcr_write(uint32_t cpu, uint64_t val) "GICv3 ICH_HCR_EL2 write cpu %x value 0x%" PRIx64
-gicv3_ich_vmcr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_VMCR_EL2 read cpu %x value 0x%" PRIx64
-gicv3_ich_vmcr_write(uint32_t cpu, uint64_t val) "GICv3 ICH_VMCR_EL2 write cpu %x value 0x%" PRIx64
-gicv3_ich_lr_read(int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_LR%d_EL2 read cpu %x value 0x%" PRIx64
-gicv3_ich_lr32_read(int regno, uint32_t cpu, uint32_t val) "GICv3 ICH_LR%d read cpu %x value 0x%" PRIx32
-gicv3_ich_lrc_read(int regno, uint32_t cpu, uint32_t val) "GICv3 ICH_LRC%d read cpu %x value 0x%" PRIx32
-gicv3_ich_lr_write(int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_LR%d_EL2 write cpu %x value 0x%" PRIx64
-gicv3_ich_lr32_write(int regno, uint32_t cpu, uint32_t val) "GICv3 ICH_LR%d write cpu %x value 0x%" PRIx32
-gicv3_ich_lrc_write(int regno, uint32_t cpu, uint32_t val) "GICv3 ICH_LRC%d write cpu %x value 0x%" PRIx32
-gicv3_ich_vtr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_VTR read cpu %x value 0x%" PRIx64
-gicv3_ich_misr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_MISR read cpu %x value 0x%" PRIx64
-gicv3_ich_eisr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_EISR read cpu %x value 0x%" PRIx64
-gicv3_ich_elrsr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_ELRSR read cpu %x value 0x%" PRIx64
-gicv3_icv_ap_read(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICV_AP%dR%d read cpu %x value 0x%" PRIx64
-gicv3_icv_ap_write(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICV_AP%dR%d write cpu %x value 0x%" PRIx64
-gicv3_icv_bpr_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_BPR%d read cpu %x value 0x%" PRIx64
-gicv3_icv_bpr_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_BPR%d write cpu %x value 0x%" PRIx64
-gicv3_icv_pmr_read(uint32_t cpu, uint64_t val) "GICv3 ICV_PMR read cpu %x value 0x%" PRIx64
-gicv3_icv_pmr_write(uint32_t cpu, uint64_t val) "GICv3 ICV_PMR write cpu %x value 0x%" PRIx64
-gicv3_icv_igrpen_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_IGRPEN%d read cpu %x value 0x%" PRIx64
-gicv3_icv_igrpen_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_IGRPEN%d write cpu %x value 0x%" PRIx64
-gicv3_icv_ctlr_read(uint32_t cpu, uint64_t val) "GICv3 ICV_CTLR read cpu %x value 0x%" PRIx64
-gicv3_icv_ctlr_write(uint32_t cpu, uint64_t val) "GICv3 ICV_CTLR write cpu %x value 0x%" PRIx64
-gicv3_icv_rpr_read(uint32_t cpu, uint64_t val) "GICv3 ICV_RPR read cpu %x value 0x%" PRIx64
-gicv3_icv_hppir_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_HPPIR%d read cpu %x value 0x%" PRIx64
-gicv3_icv_dir_write(uint32_t cpu, uint64_t val) "GICv3 ICV_DIR write cpu %x value 0x%" PRIx64
-gicv3_icv_iar_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_IAR%d read cpu %x value 0x%" PRIx64
-gicv3_icv_eoir_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_EOIR%d write cpu %x value 0x%" PRIx64
-gicv3_cpuif_virt_update(uint32_t cpuid, int idx) "GICv3 CPU i/f %x virt HPPI update LR index %d"
-gicv3_cpuif_virt_set_irqs(uint32_t cpuid, int fiqlevel, int irqlevel, int maintlevel) "GICv3 CPU i/f %x virt HPPI update: setting FIQ %d IRQ %d maintenance-irq %d"
+gicv3_icc_pmr_read(uint32_t cpu, uint64_t val) "GICv3 ICC_PMR read cpu 0x%x value 0x%" PRIx64
+gicv3_icc_pmr_write(uint32_t cpu, uint64_t val) "GICv3 ICC_PMR write cpu 0x%x value 0x%" PRIx64
+gicv3_icc_bpr_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICC_BPR%d read cpu 0x%x value 0x%" PRIx64
+gicv3_icc_bpr_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICC_BPR%d write cpu 0x%x value 0x%" PRIx64
+gicv3_icc_ap_read(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICC_AP%dR%d read cpu 0x%x value 0x%" PRIx64
+gicv3_icc_ap_write(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICC_AP%dR%d write cpu 0x%x value 0x%" PRIx64
+gicv3_icc_igrpen_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICC_IGRPEN%d read cpu 0x%x value 0x%" PRIx64
+gicv3_icc_igrpen_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICC_IGRPEN%d write cpu 0x%x value 0x%" PRIx64
+gicv3_icc_igrpen1_el3_read(uint32_t cpu, uint64_t val) "GICv3 ICC_IGRPEN1_EL3 read cpu 0x%x value 0x%" PRIx64
+gicv3_icc_igrpen1_el3_write(uint32_t cpu, uint64_t val) "GICv3 ICC_IGRPEN1_EL3 write cpu 0x%x value 0x%" PRIx64
+gicv3_icc_ctlr_read(uint32_t cpu, uint64_t val) "GICv3 ICC_CTLR read cpu 0x%x value 0x%" PRIx64
+gicv3_icc_ctlr_write(uint32_t cpu, uint64_t val) "GICv3 ICC_CTLR write cpu 0x%x value 0x%" PRIx64
+gicv3_icc_ctlr_el3_read(uint32_t cpu, uint64_t val) "GICv3 ICC_CTLR_EL3 read cpu 0x%x value 0x%" PRIx64
+gicv3_icc_ctlr_el3_write(uint32_t cpu, uint64_t val) "GICv3 ICC_CTLR_EL3 write cpu 0x%x value 0x%" PRIx64
+gicv3_cpuif_update(uint32_t cpuid, int irq, int grp, int prio) "GICv3 CPU i/f 0x%x HPPI update: irq %d group %d prio %d"
+gicv3_cpuif_set_irqs(uint32_t cpuid, int fiqlevel, int irqlevel) "GICv3 CPU i/f 0x%x HPPI update: setting FIQ %d IRQ %d"
+gicv3_icc_generate_sgi(uint32_t cpuid, int irq, int irm, uint32_t aff, uint32_t targetlist) "GICv3 CPU i/f 0x%x generating SGI %d IRM %d target affinity 0x%xxx targetlist 0x%x"
+gicv3_icc_iar0_read(uint32_t cpu, uint64_t val) "GICv3 ICC_IAR0 read cpu 0x%x value 0x%" PRIx64
+gicv3_icc_iar1_read(uint32_t cpu, uint64_t val) "GICv3 ICC_IAR1 read cpu 0x%x value 0x%" PRIx64
+gicv3_icc_eoir_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICC_EOIR%d write cpu 0x%x value 0x%" PRIx64
+gicv3_icc_hppir0_read(uint32_t cpu, uint64_t val) "GICv3 ICC_HPPIR0 read cpu 0x%x value 0x%" PRIx64
+gicv3_icc_hppir1_read(uint32_t cpu, uint64_t val) "GICv3 ICC_HPPIR1 read cpu 0x%x value 0x%" PRIx64
+gicv3_icc_dir_write(uint32_t cpu, uint64_t val) "GICv3 ICC_DIR write cpu 0x%x value 0x%" PRIx64
+gicv3_icc_rpr_read(uint32_t cpu, uint64_t val) "GICv3 ICC_RPR read cpu 0x%x value 0x%" PRIx64
+gicv3_ich_ap_read(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_AP%dR%d read cpu 0x%x value 0x%" PRIx64
+gicv3_ich_ap_write(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_AP%dR%d write cpu 0x%x value 0x%" PRIx64
+gicv3_ich_hcr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_HCR_EL2 read cpu 0x%x value 0x%" PRIx64
+gicv3_ich_hcr_write(uint32_t cpu, uint64_t val) "GICv3 ICH_HCR_EL2 write cpu 0x%x value 0x%" PRIx64
+gicv3_ich_vmcr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_VMCR_EL2 read cpu 0x%x value 0x%" PRIx64
+gicv3_ich_vmcr_write(uint32_t cpu, uint64_t val) "GICv3 ICH_VMCR_EL2 write cpu 0x%x value 0x%" PRIx64
+gicv3_ich_lr_read(int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_LR%d_EL2 read cpu 0x%x value 0x%" PRIx64
+gicv3_ich_lr32_read(int regno, uint32_t cpu, uint32_t val) "GICv3 ICH_LR%d read cpu 0x%x value 0x%" PRIx32
+gicv3_ich_lrc_read(int regno, uint32_t cpu, uint32_t val) "GICv3 ICH_LRC%d read cpu 0x%x value 0x%" PRIx32
+gicv3_ich_lr_write(int regno, uint32_t cpu, uint64_t val) "GICv3 ICH_LR%d_EL2 write cpu 0x%x value 0x%" PRIx64
+gicv3_ich_lr32_write(int regno, uint32_t cpu, uint32_t val) "GICv3 ICH_LR%d write cpu 0x%x value 0x%" PRIx32
+gicv3_ich_lrc_write(int regno, uint32_t cpu, uint32_t val) "GICv3 ICH_LRC%d write cpu 0x%x value 0x%" PRIx32
+gicv3_ich_vtr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_VTR read cpu 0x%x value 0x%" PRIx64
+gicv3_ich_misr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_MISR read cpu 0x%x value 0x%" PRIx64
+gicv3_ich_eisr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_EISR read cpu 0x%x value 0x%" PRIx64
+gicv3_ich_elrsr_read(uint32_t cpu, uint64_t val) "GICv3 ICH_ELRSR read cpu 0x%x value 0x%" PRIx64
+gicv3_icv_ap_read(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICV_AP%dR%d read cpu 0x%x value 0x%" PRIx64
+gicv3_icv_ap_write(int grp, int regno, uint32_t cpu, uint64_t val) "GICv3 ICV_AP%dR%d write cpu 0x%x value 0x%" PRIx64
+gicv3_icv_bpr_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_BPR%d read cpu 0x%x value 0x%" PRIx64
+gicv3_icv_bpr_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_BPR%d write cpu 0x%x value 0x%" PRIx64
+gicv3_icv_pmr_read(uint32_t cpu, uint64_t val) "GICv3 ICV_PMR read cpu 0x%x value 0x%" PRIx64
+gicv3_icv_pmr_write(uint32_t cpu, uint64_t val) "GICv3 ICV_PMR write cpu 0x%x value 0x%" PRIx64
+gicv3_icv_igrpen_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_IGRPEN%d read cpu 0x%x value 0x%" PRIx64
+gicv3_icv_igrpen_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_IGRPEN%d write cpu 0x%x value 0x%" PRIx64
+gicv3_icv_ctlr_read(uint32_t cpu, uint64_t val) "GICv3 ICV_CTLR read cpu 0x%x value 0x%" PRIx64
+gicv3_icv_ctlr_write(uint32_t cpu, uint64_t val) "GICv3 ICV_CTLR write cpu 0x%x value 0x%" PRIx64
+gicv3_icv_rpr_read(uint32_t cpu, uint64_t val) "GICv3 ICV_RPR read cpu 0x%x value 0x%" PRIx64
+gicv3_icv_hppir_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_HPPIR%d read cpu 0x%x value 0x%" PRIx64
+gicv3_icv_dir_write(uint32_t cpu, uint64_t val) "GICv3 ICV_DIR write cpu 0x%x value 0x%" PRIx64
+gicv3_icv_iar_read(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_IAR%d read cpu 0x%x value 0x%" PRIx64
+gicv3_icv_eoir_write(int grp, uint32_t cpu, uint64_t val) "GICv3 ICV_EOIR%d write cpu 0x%x value 0x%" PRIx64
+gicv3_cpuif_virt_update(uint32_t cpuid, int idx) "GICv3 CPU i/f 0x%x virt HPPI update LR index %d"
+gicv3_cpuif_virt_set_irqs(uint32_t cpuid, int fiqlevel, int irqlevel, int maintlevel) "GICv3 CPU i/f 0x%x virt HPPI update: setting FIQ %d IRQ %d maintenance-irq %d"
 
 # hw/intc/arm_gicv3_dist.c
 gicv3_dist_read(uint64_t offset, uint64_t data, unsigned size, bool secure) "GICv3 distributor read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u secure %d"
@@ -159,12 +159,12 @@ gicv3_dist_badwrite(uint64_t offset, uint64_t data, unsigned size, bool secure)
 gicv3_dist_set_irq(int irq, int level) "GICv3 distributor interrupt %d level changed to %d"
 
 # hw/intc/arm_gicv3_redist.c
-gicv3_redist_read(uint32_t cpu, uint64_t offset, uint64_t data, unsigned size, bool secure) "GICv3 redistributor %x read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u secure %d"
-gicv3_redist_badread(uint32_t cpu, uint64_t offset, unsigned size, bool secure) "GICv3 redistributor %x read: offset 0x%" PRIx64 " size %u secure %d: error"
-gicv3_redist_write(uint32_t cpu, uint64_t offset, uint64_t data, unsigned size, bool secure) "GICv3 redistributor %x write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u secure %d"
-gicv3_redist_badwrite(uint32_t cpu, uint64_t offset, uint64_t data, unsigned size, bool secure) "GICv3 redistributor %x write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u secure %d: error"
-gicv3_redist_set_irq(uint32_t cpu, int irq, int level) "GICv3 redistributor %x interrupt %d level changed to %d"
-gicv3_redist_send_sgi(uint32_t cpu, int irq) "GICv3 redistributor %x pending SGI %d"
+gicv3_redist_read(uint32_t cpu, uint64_t offset, uint64_t data, unsigned size, bool secure) "GICv3 redistributor 0x%x read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u secure %d"
+gicv3_redist_badread(uint32_t cpu, uint64_t offset, unsigned size, bool secure) "GICv3 redistributor 0x%x read: offset 0x%" PRIx64 " size %u secure %d: error"
+gicv3_redist_write(uint32_t cpu, uint64_t offset, uint64_t data, unsigned size, bool secure) "GICv3 redistributor 0x%x write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u secure %d"
+gicv3_redist_badwrite(uint32_t cpu, uint64_t offset, uint64_t data, unsigned size, bool secure) "GICv3 redistributor 0x%x write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u secure %d: error"
+gicv3_redist_set_irq(uint32_t cpu, int irq, int level) "GICv3 redistributor 0x%x interrupt %d level changed to %d"
+gicv3_redist_send_sgi(uint32_t cpu, int irq) "GICv3 redistributor 0x%x pending SGI %d"
 
 # hw/intc/armv7m_nvic.c
 nvic_recompute_state(int vectpending, int exception_prio) "NVIC state recomputed: vectpending %d exception_prio %d"
diff --git a/hw/isa/trace-events b/hw/isa/trace-events
index 254500a3f6..a4ab4e3634 100644
--- a/hw/isa/trace-events
+++ b/hw/isa/trace-events
@@ -1,8 +1,8 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
 # hw/isa/pc87312.c
-pc87312_io_read(uint32_t addr, uint32_t val) "read addr=%x val=%x"
-pc87312_io_write(uint32_t addr, uint32_t val) "write addr=%x val=%x"
+pc87312_io_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
+pc87312_io_write(uint32_t addr, uint32_t val) "write addr=0x%x val=0x%x"
 pc87312_info_floppy(uint32_t base) "base 0x%x"
 pc87312_info_ide(uint32_t base) "base 0x%x"
 pc87312_info_parallel(uint32_t base, uint32_t irq) "base 0x%x, irq %u"
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 56ee4fb5f6..3313585b12 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -1,54 +1,54 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
 # hw/misc/eccmemctl.c
-ecc_mem_writel_mer(uint32_t val) "Write memory enable %08x"
-ecc_mem_writel_mdr(uint32_t val) "Write memory delay %08x"
-ecc_mem_writel_mfsr(uint32_t val) "Write memory fault status %08x"
-ecc_mem_writel_vcr(uint32_t val) "Write slot configuration %08x"
-ecc_mem_writel_dr(uint32_t val) "Write diagnostic %08x"
-ecc_mem_writel_ecr0(uint32_t val) "Write event count 1 %08x"
-ecc_mem_writel_ecr1(uint32_t val) "Write event count 2 %08x"
-ecc_mem_readl_mer(uint32_t ret) "Read memory enable %08x"
-ecc_mem_readl_mdr(uint32_t ret) "Read memory delay %08x"
-ecc_mem_readl_mfsr(uint32_t ret) "Read memory fault status %08x"
-ecc_mem_readl_vcr(uint32_t ret) "Read slot configuration %08x"
-ecc_mem_readl_mfar0(uint32_t ret) "Read memory fault address 0 %08x"
-ecc_mem_readl_mfar1(uint32_t ret) "Read memory fault address 1 %08x"
-ecc_mem_readl_dr(uint32_t ret) "Read diagnostic %08x"
-ecc_mem_readl_ecr0(uint32_t ret) "Read event count 1 %08x"
-ecc_mem_readl_ecr1(uint32_t ret) "Read event count 2 %08x"
-ecc_diag_mem_writeb(uint64_t addr, uint32_t val) "Write diagnostic %"PRId64" = %02x"
-ecc_diag_mem_readb(uint64_t addr, uint32_t ret) "Read diagnostic %"PRId64"= %02x"
+ecc_mem_writel_mer(uint32_t val) "Write memory enable 0x%08x"
+ecc_mem_writel_mdr(uint32_t val) "Write memory delay 0x%08x"
+ecc_mem_writel_mfsr(uint32_t val) "Write memory fault status 0x%08x"
+ecc_mem_writel_vcr(uint32_t val) "Write slot configuration 0x%08x"
+ecc_mem_writel_dr(uint32_t val) "Write diagnostic 0x%08x"
+ecc_mem_writel_ecr0(uint32_t val) "Write event count 1 0x%08x"
+ecc_mem_writel_ecr1(uint32_t val) "Write event count 2 0x%08x"
+ecc_mem_readl_mer(uint32_t ret) "Read memory enable 0x%08x"
+ecc_mem_readl_mdr(uint32_t ret) "Read memory delay 0x%08x"
+ecc_mem_readl_mfsr(uint32_t ret) "Read memory fault status 0x%08x"
+ecc_mem_readl_vcr(uint32_t ret) "Read slot configuration 0x%08x"
+ecc_mem_readl_mfar0(uint32_t ret) "Read memory fault address 0 0x%08x"
+ecc_mem_readl_mfar1(uint32_t ret) "Read memory fault address 1 0x%08x"
+ecc_mem_readl_dr(uint32_t ret) "Read diagnostic 0x%08x"
+ecc_mem_readl_ecr0(uint32_t ret) "Read event count 1 0x%08x"
+ecc_mem_readl_ecr1(uint32_t ret) "Read event count 2 0x%08x"
+ecc_diag_mem_writeb(uint64_t addr, uint32_t val) "Write diagnostic %"PRId64" = 0x%02x"
+ecc_diag_mem_readb(uint64_t addr, uint32_t ret) "Read diagnostic %"PRId64"= 0x%02x"
 
 # hw/misc/slavio_misc.c
 slavio_misc_update_irq_raise(void) "Raise IRQ"
 slavio_misc_update_irq_lower(void) "Lower IRQ"
 slavio_set_power_fail(int power_failing, uint8_t config) "Power fail: %d, config: %d"
-slavio_cfg_mem_writeb(uint32_t val) "Write config %02x"
-slavio_cfg_mem_readb(uint32_t ret) "Read config %02x"
-slavio_diag_mem_writeb(uint32_t val) "Write diag %02x"
-slavio_diag_mem_readb(uint32_t ret) "Read diag %02x"
-slavio_mdm_mem_writeb(uint32_t val) "Write modem control %02x"
-slavio_mdm_mem_readb(uint32_t ret) "Read modem control %02x"
-slavio_aux1_mem_writeb(uint32_t val) "Write aux1 %02x"
-slavio_aux1_mem_readb(uint32_t ret) "Read aux1 %02x"
-slavio_aux2_mem_writeb(uint32_t val) "Write aux2 %02x"
-slavio_aux2_mem_readb(uint32_t ret) "Read aux2 %02x"
-apc_mem_writeb(uint32_t val) "Write power management %02x"
-apc_mem_readb(uint32_t ret) "Read power management %02x"
-slavio_sysctrl_mem_writel(uint32_t val) "Write system control %08x"
-slavio_sysctrl_mem_readl(uint32_t ret) "Read system control %08x"
-slavio_led_mem_writew(uint32_t val) "Write diagnostic LED %04x"
-slavio_led_mem_readw(uint32_t ret) "Read diagnostic LED %04x"
+slavio_cfg_mem_writeb(uint32_t val) "Write config 0x%02x"
+slavio_cfg_mem_readb(uint32_t ret) "Read config 0x%02x"
+slavio_diag_mem_writeb(uint32_t val) "Write diag 0x%02x"
+slavio_diag_mem_readb(uint32_t ret) "Read diag 0x%02x"
+slavio_mdm_mem_writeb(uint32_t val) "Write modem control 0x%02x"
+slavio_mdm_mem_readb(uint32_t ret) "Read modem control 0x%02x"
+slavio_aux1_mem_writeb(uint32_t val) "Write aux1 0x%02x"
+slavio_aux1_mem_readb(uint32_t ret) "Read aux1 0x%02x"
+slavio_aux2_mem_writeb(uint32_t val) "Write aux2 0x%02x"
+slavio_aux2_mem_readb(uint32_t ret) "Read aux2 0x%02x"
+apc_mem_writeb(uint32_t val) "Write power management 0x%02x"
+apc_mem_readb(uint32_t ret) "Read power management 0x%02x"
+slavio_sysctrl_mem_writel(uint32_t val) "Write system control 0x%08x"
+slavio_sysctrl_mem_readl(uint32_t ret) "Read system control 0x%08x"
+slavio_led_mem_writew(uint32_t val) "Write diagnostic LED 0x%04x"
+slavio_led_mem_readw(uint32_t ret) "Read diagnostic LED 0x%04x"
 
 # hw/misc/milkymist-hpdmc.c
-milkymist_hpdmc_memory_read(uint32_t addr, uint32_t value) "addr=%08x value=%08x"
-milkymist_hpdmc_memory_write(uint32_t addr, uint32_t value) "addr=%08x value=%08x"
+milkymist_hpdmc_memory_read(uint32_t addr, uint32_t value) "addr=0x%08x value=0x%08x"
+milkymist_hpdmc_memory_write(uint32_t addr, uint32_t value) "addr=0x%08x value=0x%08x"
 
 # hw/misc/milkymist-pfpu.c
-milkymist_pfpu_memory_read(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_pfpu_memory_write(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_pfpu_vectout(uint32_t a, uint32_t b, uint32_t dma_ptr) "a %08x b %08x dma_ptr %08x"
+milkymist_pfpu_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+milkymist_pfpu_memory_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+milkymist_pfpu_vectout(uint32_t a, uint32_t b, uint32_t dma_ptr) "a 0x%08x b 0x%08x dma_ptr 0x%08x"
 milkymist_pfpu_pulse_irq(void) "Pulse IRQ"
 
 # hw/misc/aspeed_scu.c
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 5e46acd02d..27e5482765 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -1,14 +1,14 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
 # hw/net/lance.c
-lance_mem_readw(uint64_t addr, uint32_t ret) "addr=%"PRIx64"val=0x%04x"
-lance_mem_writew(uint64_t addr, uint32_t val) "addr=%"PRIx64"val=0x%04x"
+lance_mem_readw(uint64_t addr, uint32_t ret) "addr=0x%"PRIx64"val=0x%04x"
+lance_mem_writew(uint64_t addr, uint32_t val) "addr=0x%"PRIx64"val=0x%04x"
 
 # hw/net/milkymist-minimac2.c
-milkymist_minimac2_memory_read(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_minimac2_memory_write(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_minimac2_mdio_write(uint8_t phy_addr, uint8_t addr, uint16_t value) "phy_addr %02x addr %02x value %04x"
-milkymist_minimac2_mdio_read(uint8_t phy_addr, uint8_t addr, uint16_t value) "phy_addr %02x addr %02x value %04x"
+milkymist_minimac2_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+milkymist_minimac2_memory_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+milkymist_minimac2_mdio_write(uint8_t phy_addr, uint8_t addr, uint16_t value) "phy_addr 0x%02x addr 0x%02x value 0x%04x"
+milkymist_minimac2_mdio_read(uint8_t phy_addr, uint8_t addr, uint16_t value) "phy_addr 0x%02x addr 0x%02x value 0x%04x"
 milkymist_minimac2_tx_frame(uint32_t length) "length %u"
 milkymist_minimac2_rx_frame(const void *buf, uint32_t length) "buf %p length %u"
 milkymist_minimac2_rx_transfer(const void *buf, uint32_t length) "buf %p length %d"
@@ -21,21 +21,21 @@ mipsnet_send(uint32_t size) "sending len=%u"
 mipsnet_receive(uint32_t size) "receiving len=%u"
 mipsnet_read(uint64_t addr, uint32_t val) "read addr=0x%" PRIx64 " val=0x%x"
 mipsnet_write(uint64_t addr, uint64_t val) "write addr=0x%" PRIx64 " val=0x%" PRIx64
-mipsnet_irq(uint32_t isr, uint32_t intctl) "set irq to %d (%02x)"
+mipsnet_irq(uint32_t isr, uint32_t intctl) "set irq to %d (0x%02x)"
 
 # hw/net/opencores_eth.c
-open_eth_mii_write(unsigned idx, uint16_t v) "MII[%02x] <- %04x"
-open_eth_mii_read(unsigned idx, uint16_t v) "MII[%02x] -> %04x"
-open_eth_update_irq(uint32_t v) "IRQ <- %x"
+open_eth_mii_write(unsigned idx, uint16_t v) "MII[0x%02x] <- 0x%04x"
+open_eth_mii_read(unsigned idx, uint16_t v) "MII[0x%02x] -> 0x%04x"
+open_eth_update_irq(uint32_t v) "IRQ <- 0x%x"
 open_eth_receive(unsigned len) "RX: len: %u"
 open_eth_receive_mcast(unsigned idx, uint32_t h0, uint32_t h1) "MCAST: idx = %u, hash: %08x:%08x"
 open_eth_receive_reject(void) "RX: rejected"
-open_eth_receive_desc(uint32_t addr, uint32_t len_flags) "RX: %08x, len_flags: %08x"
-open_eth_start_xmit(uint32_t addr, unsigned len, unsigned tx_len) "TX: %08x, len: %u, tx_len: %u"
-open_eth_reg_read(uint32_t addr, uint32_t v) "MAC[%02x] -> %08x"
-open_eth_reg_write(uint32_t addr, uint32_t v) "MAC[%02x] <- %08x"
-open_eth_desc_read(uint32_t addr, uint32_t v) "DESC[%04x] -> %08x"
-open_eth_desc_write(uint32_t addr, uint32_t v) "DESC[%04x] <- %08x"
+open_eth_receive_desc(uint32_t addr, uint32_t len_flags) "RX: 0x%08x, len_flags: 0x%08x"
+open_eth_start_xmit(uint32_t addr, unsigned len, unsigned tx_len) "TX: 0x%08x, len: %u, tx_len: %u"
+open_eth_reg_read(uint32_t addr, uint32_t v) "MAC[0x%02x] -> 0x%08x"
+open_eth_reg_write(uint32_t addr, uint32_t v) "MAC[0x%02x] <- 0x%08x"
+open_eth_desc_read(uint32_t addr, uint32_t v) "DESC[0x%04x] -> 0x%08x"
+open_eth_desc_write(uint32_t addr, uint32_t v) "DESC[0x%04x] <- 0x%08x"
 
 # hw/net/pcnet.c
 pcnet_s_reset(void *s) "s=%p"
@@ -98,7 +98,7 @@ e1000x_rx_can_recv_disabled(bool link_up, bool rx_enabled, bool pci_master) "lin
 e1000x_vlan_is_vlan_pkt(bool is_vlan_pkt, uint16_t eth_proto, uint16_t vet) "Is VLAN packet: %d, ETH proto: 0x%X, VET: 0x%X"
 e1000x_rx_flt_ucast_match(uint32_t idx, uint8_t b0, uint8_t b1, uint8_t b2, uint8_t b3, uint8_t b4, uint8_t b5) "unicast match[%d]: %02x:%02x:%02x:%02x:%02x:%02x"
 e1000x_rx_flt_ucast_mismatch(uint8_t b0, uint8_t b1, uint8_t b2, uint8_t b3, uint8_t b4, uint8_t b5) "unicast mismatch: %02x:%02x:%02x:%02x:%02x:%02x"
-e1000x_rx_flt_inexact_mismatch(uint8_t b0, uint8_t b1, uint8_t b2, uint8_t b3, uint8_t b4, uint8_t b5, uint32_t mo, uint32_t mta, uint32_t mta_val) "inexact mismatch: %02x:%02x:%02x:%02x:%02x:%02x MO %d MTA[%d] %x"
+e1000x_rx_flt_inexact_mismatch(uint8_t b0, uint8_t b1, uint8_t b2, uint8_t b3, uint8_t b4, uint8_t b5, uint32_t mo, uint32_t mta, uint32_t mta_val) "inexact mismatch: %02x:%02x:%02x:%02x:%02x:%02x MO %d MTA[%d] 0x%x"
 e1000x_rx_link_down(uint32_t status_reg) "Received packet dropped because the link is down STATUS = %u"
 e1000x_rx_disabled(uint32_t rctl_reg) "Received packet dropped because receive is disabled RCTL = %u"
 e1000x_rx_oversized(size_t size) "Received packet dropped because it was oversized (%zu bytes)"
diff --git a/hw/nvram/trace-events b/hw/nvram/trace-events
index f9a778d152..6b55ba7a09 100644
--- a/hw/nvram/trace-events
+++ b/hw/nvram/trace-events
@@ -6,5 +6,5 @@ nvram_write(uint32_t addr, uint32_t old, uint32_t val) "write addr %d: 0x%02x ->
 
 # hw/nvram/fw_cfg.c
 fw_cfg_select(void *s, uint16_t key, int ret) "%p key %d = %d"
-fw_cfg_read(void *s, uint64_t ret) "%p = %"PRIx64
+fw_cfg_read(void *s, uint64_t ret) "%p = 0x%"PRIx64
 fw_cfg_add_file(void *s, int index, char *name, size_t len) "%p #%d: %s (%zd bytes)"
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 0501b88477..4a6a6490fa 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -1,44 +1,44 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
 # hw/ppc/spapr_pci.c
-spapr_pci_msi(const char *msg, uint32_t ca) "%s (cfg=%x)"
-spapr_pci_msi_setup(const char *name, unsigned vector, uint64_t addr) "dev\"%s\" vector %u, addr=%"PRIx64
-spapr_pci_rtas_ibm_change_msi(unsigned cfg, unsigned func, unsigned req, unsigned first) "cfgaddr %x func %u, requested %u, first irq %u"
+spapr_pci_msi(const char *msg, uint32_t ca) "%s (cfg=0x%x)"
+spapr_pci_msi_setup(const char *name, unsigned vector, uint64_t addr) "dev\"%s\" vector %u, addr=0x%"PRIx64
+spapr_pci_rtas_ibm_change_msi(unsigned cfg, unsigned func, unsigned req, unsigned first) "cfgaddr 0x%x func %u, requested %u, first irq %u"
 spapr_pci_rtas_ibm_query_interrupt_source_number(unsigned ioa, unsigned intr) "queries for #%u, IRQ%u"
-spapr_pci_msi_write(uint64_t addr, uint64_t data, uint32_t dt_irq) "@%"PRIx64"<=%"PRIx64" IRQ %u"
+spapr_pci_msi_write(uint64_t addr, uint64_t data, uint32_t dt_irq) "@0x%"PRIx64"<=0x%"PRIx64" IRQ %u"
 spapr_pci_lsi_set(const char *busname, int pin, uint32_t irq) "%s PIN%d IRQ %u"
-spapr_pci_msi_retry(unsigned config_addr, unsigned req_num, unsigned max_irqs) "Guest device at %x asked %u, have only %u"
+spapr_pci_msi_retry(unsigned config_addr, unsigned req_num, unsigned max_irqs) "Guest device at 0x%x asked %u, have only %u"
 
 # hw/ppc/spapr.c
 spapr_cas_failed(unsigned long n) "DT diff buffer is too small: %ld bytes"
 spapr_cas_continue(unsigned long n) "Copy changes to the guest: %ld bytes"
 
 # hw/ppc/spapr_hcall.c
-spapr_cas_pvr_try(uint32_t pvr) "%x"
-spapr_cas_pvr(uint32_t cur_pvr, bool explicit_match, uint32_t new_pvr) "current=%x, explicit_match=%u, new=%x"
+spapr_cas_pvr_try(uint32_t pvr) "0x%x"
+spapr_cas_pvr(uint32_t cur_pvr, bool explicit_match, uint32_t new_pvr) "current=0x%x, explicit_match=%u, new=0x%x"
 spapr_h_resize_hpt_prepare(uint64_t flags, uint64_t shift) "flags=0x%"PRIx64", shift=%"PRIu64
 spapr_h_resize_hpt_commit(uint64_t flags, uint64_t shift) "flags=0x%"PRIx64", shift=%"PRIu64
 
 # hw/ppc/spapr_iommu.c
-spapr_iommu_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t ret) "liobn=%"PRIx64" ioba=0x%"PRIx64" tce=0x%"PRIx64" ret=%"PRId64
-spapr_iommu_get(uint64_t liobn, uint64_t ioba, uint64_t ret, uint64_t tce) "liobn=%"PRIx64" ioba=0x%"PRIx64" ret=%"PRId64" tce=0x%"PRIx64
-spapr_iommu_indirect(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t iobaN, uint64_t tceN, uint64_t ret) "liobn=%"PRIx64" ioba=0x%"PRIx64" tcelist=0x%"PRIx64" iobaN=0x%"PRIx64" tceN=0x%"PRIx64" ret=%"PRId64
-spapr_iommu_stuff(uint64_t liobn, uint64_t ioba, uint64_t tce_value, uint64_t npages, uint64_t ret) "liobn=%"PRIx64" ioba=0x%"PRIx64" tcevalue=0x%"PRIx64" npages=%"PRId64" ret=%"PRId64
-spapr_iommu_pci_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t ret) "liobn=%"PRIx64" ioba=0x%"PRIx64" tce=0x%"PRIx64" ret=%"PRId64
-spapr_iommu_pci_get(uint64_t liobn, uint64_t ioba, uint64_t ret, uint64_t tce) "liobn=%"PRIx64" ioba=0x%"PRIx64" ret=%"PRId64" tce=0x%"PRIx64
-spapr_iommu_pci_indirect(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t iobaN, uint64_t tceN, uint64_t ret) "liobn=%"PRIx64" ioba=0x%"PRIx64" tcelist=0x%"PRIx64" iobaN=0x%"PRIx64" tceN=0x%"PRIx64" ret=%"PRId64
-spapr_iommu_pci_stuff(uint64_t liobn, uint64_t ioba, uint64_t tce_value, uint64_t npages, uint64_t ret) "liobn=%"PRIx64" ioba=0x%"PRIx64" tcevalue=0x%"PRIx64" npages=%"PRId64" ret=%"PRId64
-spapr_iommu_xlate(uint64_t liobn, uint64_t ioba, uint64_t tce, unsigned perm, unsigned pgsize) "liobn=%"PRIx64" 0x%"PRIx64" -> 0x%"PRIx64" perm=%u mask=%x"
-spapr_iommu_new_table(uint64_t liobn, void *table, int fd) "liobn=%"PRIx64" table=%p fd=%d"
-spapr_iommu_pre_save(uint64_t liobn, uint32_t nb, uint64_t offs, uint32_t ps) "liobn=%"PRIx64" %"PRIx32" bus_offset=%"PRIx64" ps=%"PRIu32
-spapr_iommu_post_load(uint64_t liobn, uint32_t pre_nb, uint32_t post_nb, uint64_t offs, uint32_t ps) "liobn=%"PRIx64" %"PRIx32" => %"PRIx32" bus_offset=%"PRIx64" ps=%"PRIu32
-spapr_iommu_ddw_query(uint64_t buid, uint32_t cfgaddr, unsigned wa, uint64_t win_size, uint32_t pgmask) "buid=%"PRIx64" addr=%"PRIx32", %u windows available, max window size=%"PRIx64", mask=%"PRIx32
-spapr_iommu_ddw_create(uint64_t buid, uint32_t cfgaddr, uint64_t pg_size, uint64_t req_size, uint64_t start, uint32_t liobn) "buid=%"PRIx64" addr=%"PRIx32", page size=0x%"PRIx64", requested=0x%"PRIx64", start addr=%"PRIx64", liobn=%"PRIx32
-spapr_iommu_ddw_remove(uint32_t liobn) "liobn=%"PRIx32
-spapr_iommu_ddw_reset(uint64_t buid, uint32_t cfgaddr) "buid=%"PRIx64" addr=%"PRIx32
+spapr_iommu_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t ret) "liobn=0x%"PRIx64" ioba=0x%"PRIx64" tce=0x%"PRIx64" ret=%"PRId64
+spapr_iommu_get(uint64_t liobn, uint64_t ioba, uint64_t ret, uint64_t tce) "liobn=0x%"PRIx64" ioba=0x%"PRIx64" ret=%"PRId64" tce=0x%"PRIx64
+spapr_iommu_indirect(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t iobaN, uint64_t tceN, uint64_t ret) "liobn=0x%"PRIx64" ioba=0x%"PRIx64" tcelist=0x%"PRIx64" iobaN=0x%"PRIx64" tceN=0x%"PRIx64" ret=%"PRId64
+spapr_iommu_stuff(uint64_t liobn, uint64_t ioba, uint64_t tce_value, uint64_t npages, uint64_t ret) "liobn=0x%"PRIx64" ioba=0x%"PRIx64" tcevalue=0x%"PRIx64" npages=%"PRId64" ret=%"PRId64
+spapr_iommu_pci_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t ret) "liobn=0x%"PRIx64" ioba=0x%"PRIx64" tce=0x%"PRIx64" ret=%"PRId64
+spapr_iommu_pci_get(uint64_t liobn, uint64_t ioba, uint64_t ret, uint64_t tce) "liobn=0x%"PRIx64" ioba=0x%"PRIx64" ret=%"PRId64" tce=0x%"PRIx64
+spapr_iommu_pci_indirect(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t iobaN, uint64_t tceN, uint64_t ret) "liobn=0x%"PRIx64" ioba=0x%"PRIx64" tcelist=0x%"PRIx64" iobaN=0x%"PRIx64" tceN=0x%"PRIx64" ret=%"PRId64
+spapr_iommu_pci_stuff(uint64_t liobn, uint64_t ioba, uint64_t tce_value, uint64_t npages, uint64_t ret) "liobn=0x%"PRIx64" ioba=0x%"PRIx64" tcevalue=0x%"PRIx64" npages=%"PRId64" ret=%"PRId64
+spapr_iommu_xlate(uint64_t liobn, uint64_t ioba, uint64_t tce, unsigned perm, unsigned pgsize) "liobn=0x%"PRIx64" 0x%"PRIx64" -> 0x%"PRIx64" perm=%u mask=0x%x"
+spapr_iommu_new_table(uint64_t liobn, void *table, int fd) "liobn=0x%"PRIx64" table=%p fd=%d"
+spapr_iommu_pre_save(uint64_t liobn, uint32_t nb, uint64_t offs, uint32_t ps) "liobn=%"PRIx64" %"PRIx32" bus_offset=0x%"PRIx64" ps=%"PRIu32
+spapr_iommu_post_load(uint64_t liobn, uint32_t pre_nb, uint32_t post_nb, uint64_t offs, uint32_t ps) "liobn=%"PRIx64" %"PRIx32" => 0x%"PRIx32" bus_offset=0x%"PRIx64" ps=%"PRIu32
+spapr_iommu_ddw_query(uint64_t buid, uint32_t cfgaddr, unsigned wa, uint64_t win_size, uint32_t pgmask) "buid=0x%"PRIx64" addr=0x%"PRIx32", %u windows available, max window size=0x%"PRIx64", mask=0x%"PRIx32
+spapr_iommu_ddw_create(uint64_t buid, uint32_t cfgaddr, uint64_t pg_size, uint64_t req_size, uint64_t start, uint32_t liobn) "buid=0x%"PRIx64" addr=0x%"PRIx32", page size=0x%"PRIx64", requested=0x%"PRIx64", start addr=0x%"PRIx64", liobn=0x%"PRIx32
+spapr_iommu_ddw_remove(uint32_t liobn) "liobn=0x%"PRIx32
+spapr_iommu_ddw_reset(uint64_t buid, uint32_t cfgaddr) "buid=0x%"PRIx64" addr=0x%"PRIx32
 
 # hw/ppc/spapr_drc.c
-spapr_drc_set_isolation_state(uint32_t index, int state) "drc: 0x%"PRIx32", state: %"PRIx32
+spapr_drc_set_isolation_state(uint32_t index, int state) "drc: 0x%"PRIx32", state: 0x%"PRIx32
 spapr_drc_set_isolation_state_finalizing(uint32_t index) "drc: 0x%"PRIx32
 spapr_drc_set_isolation_state_deferring(uint32_t index) "drc: 0x%"PRIx32
 spapr_drc_set_dr_indicator(uint32_t index, int state) "drc: 0x%"PRIx32", state: 0x%x"
@@ -78,20 +78,20 @@ prep_io_800_writeb(uint32_t addr, uint32_t val) "0x%08" PRIx32 " => 0x%02" PRIx3
 prep_io_800_readb(uint32_t addr, uint32_t retval) "0x%08" PRIx32 " <= 0x%02" PRIx32
 
 # hw/ppc/prep_systemio.c
-prep_systemio_read(uint32_t addr, uint32_t val) "read addr=%x val=%x"
-prep_systemio_write(uint32_t addr, uint32_t val) "write addr=%x val=%x"
+prep_systemio_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
+prep_systemio_write(uint32_t addr, uint32_t val) "write addr=0x%x val=0x%x"
 
 # hw/ppc/rs6000_mc.c
-rs6000mc_id_read(uint32_t addr, uint32_t val) "read addr=%x val=%x"
-rs6000mc_presence_read(uint32_t addr, uint32_t val) "read addr=%x val=%x"
-rs6000mc_size_read(uint32_t addr, uint32_t val) "read addr=%x val=%x"
-rs6000mc_size_write(uint32_t addr, uint32_t val) "write addr=%x val=%x"
-rs6000mc_parity_read(uint32_t addr, uint32_t val) "read addr=%x val=%x"
+rs6000mc_id_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
+rs6000mc_presence_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
+rs6000mc_size_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
+rs6000mc_size_write(uint32_t addr, uint32_t val) "write addr=0x%x val=0x%x"
+rs6000mc_parity_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
 
 # hw/ppc/mac_newworld.c
 mac99_uninorth_write(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
 mac99_uninorth_read(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
 
 # hw/ppc/ppc4xx_pci.c
-ppc4xx_pci_map_irq(int32_t devfn, int irq_num, int slot) "devfn %x irq %d -> %d"
+ppc4xx_pci_map_irq(int32_t devfn, int irq_num, int slot) "devfn 0x%x irq %d -> %d"
 ppc4xx_pci_set_irq(int irq_num) "PCI irq %d"
diff --git a/hw/s390x/trace-events b/hw/s390x/trace-events
index 5086cd9ad9..0d3622ec6f 100644
--- a/hw/s390x/trace-events
+++ b/hw/s390x/trace-events
@@ -2,15 +2,15 @@
 
 # hw/s390x/css.c
 css_enable_facility(const char *facility) "CSS: enable %s"
-css_crw(uint8_t rsc, uint8_t erc, uint16_t rsid, const char *chained) "CSS: queueing crw: rsc=%x, erc=%x, rsid=%x %s"
-css_chpid_add(uint8_t cssid, uint8_t chpid, uint8_t type) "CSS: add chpid %x.%02x (type %02x)"
-css_new_image(uint8_t cssid, const char *default_cssid) "CSS: add css image %02x %s"
-css_assign_subch(const char *do_assign, uint8_t cssid, uint8_t ssid, uint16_t schid, uint16_t devno) "CSS: %s %x.%x.%04x (devno %04x)"
-css_io_interrupt(int cssid, int ssid, int schid, uint32_t intparm, uint8_t isc, const char *conditional) "CSS: I/O interrupt on sch %x.%x.%04x (intparm %08x, isc %x) %s"
-css_adapter_interrupt(uint8_t isc) "CSS: adapter I/O interrupt (isc %x)"
-css_do_sic(uint16_t mode, uint8_t isc) "CSS: set interruption mode %x on isc %x"
+css_crw(uint8_t rsc, uint8_t erc, uint16_t rsid, const char *chained) "CSS: queueing crw: rsc=0x%x, erc=0x%x, rsid=0x%x %s"
+css_chpid_add(uint8_t cssid, uint8_t chpid, uint8_t type) "CSS: add chpid %x.%02x (type 0x%02x)"
+css_new_image(uint8_t cssid, const char *default_cssid) "CSS: add css image 0x%02x %s"
+css_assign_subch(const char *do_assign, uint8_t cssid, uint8_t ssid, uint16_t schid, uint16_t devno) "CSS: %s %x.%x.%04x (devno 0x%04x)"
+css_io_interrupt(int cssid, int ssid, int schid, uint32_t intparm, uint8_t isc, const char *conditional) "CSS: I/O interrupt on sch %x.%x.%04x (intparm 0x%08x, isc 0x%x) %s"
+css_adapter_interrupt(uint8_t isc) "CSS: adapter I/O interrupt (isc 0x%x)"
+css_do_sic(uint16_t mode, uint8_t isc) "CSS: set interruption mode 0x%x on isc 0x%x"
 
 # hw/s390x/virtio-ccw.c
-virtio_ccw_interpret_ccw(int cssid, int ssid, int schid, int cmd_code) "VIRTIO-CCW: %x.%x.%04x: interpret command %x"
-virtio_ccw_new_device(int cssid, int ssid, int schid, int devno, const char *devno_mode) "VIRTIO-CCW: add subchannel %x.%x.%04x, devno %04x (%s)"
-virtio_ccw_set_ind(uint64_t ind_loc, uint8_t ind_old, uint8_t ind_new) "VIRTIO-CCW: indicator at %" PRIu64 ": %x->%x"
+virtio_ccw_interpret_ccw(int cssid, int ssid, int schid, int cmd_code) "VIRTIO-CCW: %x.%x.%04x: interpret command 0x%x"
+virtio_ccw_new_device(int cssid, int ssid, int schid, int devno, const char *devno_mode) "VIRTIO-CCW: add subchannel %x.%x.%04x, devno 0x%04x (%s)"
+virtio_ccw_set_ind(uint64_t ind_loc, uint8_t ind_old, uint8_t ind_new) "VIRTIO-CCW: indicator at %" PRIu64 ": 0x%x->0x%x"
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index 7b444e437a..6e299d0338 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -19,7 +19,7 @@ scsi_test_unit_ready(int target, int lun, int tag) "target %d lun %d tag %d"
 scsi_request_sense(int target, int lun, int tag) "target %d lun %d tag %d"
 
 # hw/scsi/mptsas.c
-mptsas_command_complete(void *dev, uint32_t ctx, uint32_t status, uint32_t resid) "dev %p context 0x%08x status %x resid %d"
+mptsas_command_complete(void *dev, uint32_t ctx, uint32_t status, uint32_t resid) "dev %p context 0x%08x status 0x%x resid %d"
 mptsas_diag_read(void *dev, uint32_t addr, uint32_t val) "dev %p addr 0x%08x value 0x%08x"
 mptsas_diag_write(void *dev, uint32_t addr, uint32_t val) "dev %p addr 0x%08x value 0x%08x"
 mptsas_irq_intx(void *dev, int level) "dev %p level %d"
@@ -33,7 +33,7 @@ mptsas_process_scsi_io_request(void *dev, int bus, int target, int lun, uint64_t
 mptsas_reset(void *dev) "dev %p "
 mptsas_scsi_overflow(void *dev, uint32_t ctx, uint64_t req, uint64_t found) "dev %p context 0x%08x: %"PRIu64"/%"PRIu64""
 mptsas_sgl_overflow(void *dev, uint32_t ctx, uint64_t req, uint64_t found) "dev %p context 0x%08x: %"PRIu64"/%"PRIu64""
-mptsas_unhandled_cmd(void *dev, uint32_t ctx, uint8_t msg_cmd) "dev %p context 0x%08x: Unhandled cmd %x"
+mptsas_unhandled_cmd(void *dev, uint32_t ctx, uint8_t msg_cmd) "dev %p context 0x%08x: Unhandled cmd 0x%x"
 mptsas_unhandled_doorbell_cmd(void *dev, int cmd) "dev %p value 0x%08x"
 
 # hw/scsi/mptconfig.c
@@ -41,21 +41,21 @@ mptsas_config_sas_device(void *dev, int address, int port, int phy_handle, int d
 mptsas_config_sas_phy(void *dev, int address, int port, int phy_handle, int dev_handle, int page) "dev %p address %d (port %d, handles: phy %d dev %d) page %d"
 
 # hw/scsi/megasas.c
-megasas_init_firmware(uint64_t pa) "pa %" PRIx64 " "
-megasas_init_queue(uint64_t queue_pa, int queue_len, uint64_t head, uint64_t tail, uint32_t flags) "queue at %" PRIx64 " len %d head %" PRIx64 " tail %" PRIx64 " flags %x"
+megasas_init_firmware(uint64_t pa) "pa 0x%" PRIx64 " "
+megasas_init_queue(uint64_t queue_pa, int queue_len, uint64_t head, uint64_t tail, uint32_t flags) "queue at 0x%" PRIx64 " len %d head 0x%" PRIx64 " tail 0x%" PRIx64 " flags 0x%x"
 megasas_initq_map_failed(int frame) "scmd %d: failed to map queue"
-megasas_initq_mapped(uint64_t pa) "queue already mapped at %" PRIx64
+megasas_initq_mapped(uint64_t pa) "queue already mapped at 0x%" PRIx64
 megasas_initq_mismatch(int queue_len, int fw_cmds) "queue size %d max fw cmds %d"
-megasas_qf_mapped(unsigned int index) "skip mapped frame %x"
-megasas_qf_new(unsigned int index, uint64_t frame) "frame %x addr %" PRIx64
-megasas_qf_busy(unsigned long pa) "all frames busy for frame %lx"
-megasas_qf_enqueue(unsigned int index, unsigned int count, uint64_t context, unsigned int head, unsigned int tail, int busy) "frame %x count %d context %" PRIx64 " head %x tail %x busy %d"
-megasas_qf_update(unsigned int head, unsigned int tail, unsigned int busy) "head %x tail %x busy %d"
+megasas_qf_mapped(unsigned int index) "skip mapped frame 0x%x"
+megasas_qf_new(unsigned int index, uint64_t frame) "frame 0x%x addr 0x%" PRIx64
+megasas_qf_busy(unsigned long pa) "all frames busy for frame 0x%lx"
+megasas_qf_enqueue(unsigned int index, unsigned int count, uint64_t context, unsigned int head, unsigned int tail, int busy) "frame 0x%x count %d context 0x%" PRIx64 " head 0x%x tail 0x%x busy %d"
+megasas_qf_update(unsigned int head, unsigned int tail, unsigned int busy) "head 0x%x tail 0x%x busy %d"
 megasas_qf_map_failed(int cmd, unsigned long frame) "scmd %d: frame %lu"
-megasas_qf_complete_noirq(uint64_t context) "context %" PRIx64 " "
-megasas_qf_complete(uint64_t context, unsigned int head, unsigned int tail, int busy) "context %" PRIx64 " head %x tail %x busy %d"
-megasas_frame_busy(uint64_t addr) "frame %" PRIx64 " busy"
-megasas_unhandled_frame_cmd(int cmd, uint8_t frame_cmd) "scmd %d: MFI cmd %x"
+megasas_qf_complete_noirq(uint64_t context) "context 0x%" PRIx64 " "
+megasas_qf_complete(uint64_t context, unsigned int head, unsigned int tail, int busy) "context 0x%" PRIx64 " head 0x%x tail 0x%x busy %d"
+megasas_frame_busy(uint64_t addr) "frame 0x%" PRIx64 " busy"
+megasas_unhandled_frame_cmd(int cmd, uint8_t frame_cmd) "scmd %d: MFI cmd 0x%x"
 megasas_handle_scsi(const char *frame, int bus, int dev, int lun, void *sdev, unsigned long size) "%s dev %x/%x/%x sdev %p xfer %lu"
 megasas_scsi_target_not_present(const char *frame, int bus, int dev, int lun) "%s dev %x/%x/%x"
 megasas_scsi_invalid_cdb_len(const char *frame, int bus, int dev, int lun, int len) "%s dev %x/%x/%x invalid cdb len %d"
@@ -67,43 +67,43 @@ megasas_scsi_req_alloc_failed(const char *frame, int dev, int lun) "%s dev %x/%x
 megasas_scsi_read_start(int cmd, int len) "scmd %d: transfer %d bytes of data"
 megasas_scsi_write_start(int cmd, int len) "scmd %d: transfer %d bytes of data"
 megasas_scsi_nodata(int cmd) "scmd %d: no data to be transferred"
-megasas_scsi_complete(int cmd, uint32_t status, int len, int xfer) "scmd %d: status %x, len %u/%u"
-megasas_command_complete(int cmd, uint32_t status, uint32_t resid) "scmd %d: status %x, residual %d"
-megasas_handle_io(int cmd, const char *frame, int dev, int lun, unsigned long lba, unsigned long count) "scmd %d: %s dev %x/%x lba %lx count %lu"
+megasas_scsi_complete(int cmd, uint32_t status, int len, int xfer) "scmd %d: status 0x%x, len %u/%u"
+megasas_command_complete(int cmd, uint32_t status, uint32_t resid) "scmd %d: status 0x%x, residual %d"
+megasas_handle_io(int cmd, const char *frame, int dev, int lun, unsigned long lba, unsigned long count) "scmd %d: %s dev %x/%x lba 0x%lx count %lu"
 megasas_io_target_not_present(int cmd, const char *frame, int dev, int lun) "scmd %d: %s dev 1/%x/%x LUN not present"
-megasas_io_read_start(int cmd, unsigned long lba, unsigned long count, unsigned long len) "scmd %d: start LBA %lx %lu blocks (%lu bytes)"
-megasas_io_write_start(int cmd, unsigned long lba, unsigned long count, unsigned long len) "scmd %d: start LBA %lx %lu blocks (%lu bytes)"
+megasas_io_read_start(int cmd, unsigned long lba, unsigned long count, unsigned long len) "scmd %d: start LBA 0x%lx %lu blocks (%lu bytes)"
+megasas_io_write_start(int cmd, unsigned long lba, unsigned long count, unsigned long len) "scmd %d: start LBA 0x%lx %lu blocks (%lu bytes)"
 megasas_io_complete(int cmd, uint32_t len) "scmd %d: %d bytes"
 megasas_iovec_sgl_overflow(int cmd, int index, int limit) "scmd %d: iovec count %d limit %d"
 megasas_iovec_sgl_underflow(int cmd, int index) "scmd %d: iovec count %d"
-megasas_iovec_sgl_invalid(int cmd, int index, uint64_t pa, uint32_t len) "scmd %d: element %d pa %" PRIx64 " len %u"
+megasas_iovec_sgl_invalid(int cmd, int index, uint64_t pa, uint32_t len) "scmd %d: element %d pa 0x%" PRIx64 " len %u"
 megasas_iovec_overflow(int cmd, int len, int limit) "scmd %d: len %d limit %d"
 megasas_iovec_underflow(int cmd, int len, int limit) "scmd %d: len %d limit %d"
-megasas_handle_dcmd(int cmd, int opcode) "scmd %d: MFI DCMD opcode %x"
+megasas_handle_dcmd(int cmd, int opcode) "scmd %d: MFI DCMD opcode 0x%x"
 megasas_finish_dcmd(int cmd, int size) "scmd %d: MFI DCMD wrote %d bytes"
 megasas_dcmd_req_alloc_failed(int cmd, const char *desc) "scmd %d: %s"
 megasas_dcmd_internal_submit(int cmd, const char *desc, int dev) "scmd %d: %s to dev %d"
-megasas_dcmd_internal_finish(int cmd, int opcode, int lun) "scmd %d: cmd %x lun %d"
-megasas_dcmd_internal_invalid(int cmd, int opcode) "scmd %d: DCMD %x"
-megasas_dcmd_unhandled(int cmd, int opcode, int len) "scmd %d: opcode %x, len %d"
+megasas_dcmd_internal_finish(int cmd, int opcode, int lun) "scmd %d: cmd 0x%x lun %d"
+megasas_dcmd_internal_invalid(int cmd, int opcode) "scmd %d: DCMD 0x%x"
+megasas_dcmd_unhandled(int cmd, int opcode, int len) "scmd %d: opcode 0x%x, len %d"
 megasas_dcmd_zero_sge(int cmd) "scmd %d: zero DCMD sge count"
 megasas_dcmd_invalid_sge(int cmd, int count) "scmd %d: DCMD sge count %d"
 megasas_dcmd_invalid_xfer_len(int cmd, unsigned long size, unsigned long max) "scmd %d: xfer len %ld, max %ld"
 megasas_dcmd_enter(int cmd, const char *dcmd, int len) "scmd %d: DCMD %s len %d"
 megasas_dcmd_dummy(int cmd, unsigned long size) "scmd %d: xfer len %ld"
-megasas_dcmd_set_fw_time(int cmd, unsigned long time) "scmd %d: Set FW time %lx"
+megasas_dcmd_set_fw_time(int cmd, unsigned long time) "scmd %d: Set FW time 0x%lx"
 megasas_dcmd_pd_get_list(int cmd, int num, int max, int offset) "scmd %d: DCMD PD get list: %d / %d PDs, size %d"
 megasas_dcmd_ld_get_list(int cmd, int num, int max) "scmd %d: DCMD LD get list: found %d / %d LDs"
 megasas_dcmd_ld_get_info(int cmd, int ld_id) "scmd %d: dev %d"
-megasas_dcmd_ld_list_query(int cmd, int flags) "scmd %d: query flags %x"
+megasas_dcmd_ld_list_query(int cmd, int flags) "scmd %d: query flags 0x%x"
 megasas_dcmd_pd_get_info(int cmd, int pd_id) "scmd %d: dev %d"
-megasas_dcmd_pd_list_query(int cmd, int flags) "scmd %d: query flags %x"
+megasas_dcmd_pd_list_query(int cmd, int flags) "scmd %d: query flags 0x%x"
 megasas_dcmd_reset_ld(int cmd, int target_id) "scmd %d: dev %d"
 megasas_dcmd_unsupported(int cmd, unsigned long size) "scmd %d: set properties len %ld"
-megasas_abort_frame(int cmd, int abort_cmd) "scmd %d: frame %x"
-megasas_abort_no_cmd(int cmd, uint64_t context) "scmd %d: no active command for frame context %" PRIx64
-megasas_abort_invalid_context(int cmd, uint64_t context, int abort_cmd) "scmd %d: invalid frame context %" PRIx64 " for abort frame %x"
-megasas_reset(int fw_state) "firmware state %x"
+megasas_abort_frame(int cmd, int abort_cmd) "scmd %d: frame 0x%x"
+megasas_abort_no_cmd(int cmd, uint64_t context) "scmd %d: no active command for frame context 0x%" PRIx64
+megasas_abort_invalid_context(int cmd, uint64_t context, int abort_cmd) "scmd %d: invalid frame context 0x%" PRIx64 " for abort frame 0x%x"
+megasas_reset(int fw_state) "firmware state 0x%x"
 megasas_init(int sges, int cmds, const char *mode) "Using %d sges, %d cmds, %s mode"
 megasas_msix_raise(int vector) "vector %d"
 megasas_msi_raise(int vector) "vector %d"
@@ -142,20 +142,20 @@ pvscsi_on_cmd_noimpl(const char* cmd) "unimplemented command %s ignored"
 pvscsi_on_cmd_reset_dev(uint32_t tgt, int lun, void* dev) "PVSCSI_CMD_RESET_DEVICE[target %u lun %d (dev 0x%p)]"
 pvscsi_on_cmd_arrived(const char* cmd) "command %s arrived"
 pvscsi_on_cmd_abort(uint64_t ctx, uint32_t tgt) "command PVSCSI_CMD_ABORT_CMD for ctx 0x%"PRIx64", target %u"
-pvscsi_on_cmd_unknown(uint64_t cmd_id) "unknown command %"PRIx64
-pvscsi_on_cmd_unknown_data(uint32_t data) "data for unknown command 0x:%x"
-pvscsi_io_write(const char* cmd, uint64_t val) "%s write: %"PRIx64
+pvscsi_on_cmd_unknown(uint64_t cmd_id) "unknown command 0x%"PRIx64
+pvscsi_on_cmd_unknown_data(uint32_t data) "data for unknown command 0x:0x%x"
+pvscsi_io_write(const char* cmd, uint64_t val) "%s write: 0x%"PRIx64
 pvscsi_io_write_unknown(unsigned long addr, unsigned sz, uint64_t val) "unknown write address: 0x%lx size: %u bytes value: 0x%"PRIx64
 pvscsi_io_read(const char* cmd, uint64_t status) "%s read: 0x%"PRIx64
 pvscsi_io_read_unknown(unsigned long addr, unsigned sz) "unknown read address: 0x%lx size: %u bytes"
 pvscsi_init_msi_fail(int res) "failed to initialize MSI, error %d"
 pvscsi_state(const char* state) "starting %s ..."
-pvscsi_tx_rings_ppn(const char* label, uint64_t ppn) "%s page: %"PRIx64
+pvscsi_tx_rings_ppn(const char* label, uint64_t ppn) "%s page: 0x%"PRIx64
 pvscsi_tx_rings_num_pages(const char* label, uint32_t num) "Number of %s pages: %u"
 
 # hw/scsi/esp.c
 esp_error_fifo_overrun(void) "FIFO overrun"
-esp_error_unhandled_command(uint32_t val) "unhandled command (%2.2x)"
+esp_error_unhandled_command(uint32_t val) "unhandled command (0x%2.2x)"
 esp_error_invalid_write(uint32_t val, uint32_t addr) "invalid write of 0x%02x at [0x%x]"
 esp_raise_irq(void) "Raise IRQ"
 esp_lower_irq(void) "Lower IRQ"
@@ -174,20 +174,20 @@ esp_handle_ti(uint32_t minlen) "Transfer Information len %d"
 esp_handle_ti_cmd(uint32_t cmdlen) "command len %d"
 esp_mem_readb(uint32_t saddr, uint8_t reg) "reg[%d]: 0x%2.2x"
 esp_mem_writeb(uint32_t saddr, uint8_t reg, uint32_t val) "reg[%d]: 0x%2.2x -> 0x%2.2x"
-esp_mem_writeb_cmd_nop(uint32_t val) "NOP (%2.2x)"
-esp_mem_writeb_cmd_flush(uint32_t val) "Flush FIFO (%2.2x)"
-esp_mem_writeb_cmd_reset(uint32_t val) "Chip reset (%2.2x)"
-esp_mem_writeb_cmd_bus_reset(uint32_t val) "Bus reset (%2.2x)"
-esp_mem_writeb_cmd_iccs(uint32_t val) "Initiator Command Complete Sequence (%2.2x)"
-esp_mem_writeb_cmd_msgacc(uint32_t val) "Message Accepted (%2.2x)"
-esp_mem_writeb_cmd_pad(uint32_t val) "Transfer padding (%2.2x)"
-esp_mem_writeb_cmd_satn(uint32_t val) "Set ATN (%2.2x)"
-esp_mem_writeb_cmd_rstatn(uint32_t val) "Reset ATN (%2.2x)"
-esp_mem_writeb_cmd_sel(uint32_t val) "Select without ATN (%2.2x)"
-esp_mem_writeb_cmd_selatn(uint32_t val) "Select with ATN (%2.2x)"
-esp_mem_writeb_cmd_selatns(uint32_t val) "Select with ATN & stop (%2.2x)"
-esp_mem_writeb_cmd_ensel(uint32_t val) "Enable selection (%2.2x)"
-esp_mem_writeb_cmd_dissel(uint32_t val) "Disable selection (%2.2x)"
+esp_mem_writeb_cmd_nop(uint32_t val) "NOP (0x%2.2x)"
+esp_mem_writeb_cmd_flush(uint32_t val) "Flush FIFO (0x%2.2x)"
+esp_mem_writeb_cmd_reset(uint32_t val) "Chip reset (0x%2.2x)"
+esp_mem_writeb_cmd_bus_reset(uint32_t val) "Bus reset (0x%2.2x)"
+esp_mem_writeb_cmd_iccs(uint32_t val) "Initiator Command Complete Sequence (0x%2.2x)"
+esp_mem_writeb_cmd_msgacc(uint32_t val) "Message Accepted (0x%2.2x)"
+esp_mem_writeb_cmd_pad(uint32_t val) "Transfer padding (0x%2.2x)"
+esp_mem_writeb_cmd_satn(uint32_t val) "Set ATN (0x%2.2x)"
+esp_mem_writeb_cmd_rstatn(uint32_t val) "Reset ATN (0x%2.2x)"
+esp_mem_writeb_cmd_sel(uint32_t val) "Select without ATN (0x%2.2x)"
+esp_mem_writeb_cmd_selatn(uint32_t val) "Select with ATN (0x%2.2x)"
+esp_mem_writeb_cmd_selatns(uint32_t val) "Select with ATN & stop (0x%2.2x)"
+esp_mem_writeb_cmd_ensel(uint32_t val) "Enable selection (0x%2.2x)"
+esp_mem_writeb_cmd_dissel(uint32_t val) "Disable selection (0x%2.2x)"
 
 # hw/scsi/esp-pci.c
 esp_pci_error_invalid_dma_direction(void) "invalid DMA transfer direction"
@@ -196,10 +196,10 @@ esp_pci_error_invalid_write(uint32_t reg) "write access outside bounds (reg 0x%x
 esp_pci_error_invalid_write_dma(uint32_t val, uint32_t addr) "invalid write of 0x%02x at [0x%x]"
 esp_pci_dma_read(uint32_t saddr, uint32_t reg) "reg[%d]: 0x%8.8x"
 esp_pci_dma_write(uint32_t saddr, uint32_t reg, uint32_t val) "reg[%d]: 0x%8.8x -> 0x%8.8x"
-esp_pci_dma_idle(uint32_t val) "IDLE (%.8x)"
-esp_pci_dma_blast(uint32_t val) "BLAST (%.8x)"
-esp_pci_dma_abort(uint32_t val) "ABORT (%.8x)"
-esp_pci_dma_start(uint32_t val) "START (%.8x)"
+esp_pci_dma_idle(uint32_t val) "IDLE (0x%.8x)"
+esp_pci_dma_blast(uint32_t val) "BLAST (0x%.8x)"
+esp_pci_dma_abort(uint32_t val) "ABORT (0x%.8x)"
+esp_pci_dma_start(uint32_t val) "START (0x%.8x)"
 esp_pci_sbac_read(uint32_t reg) "sbac: 0x%8.8x"
 esp_pci_sbac_write(uint32_t reg, uint32_t val) "sbac: 0x%8.8x -> 0x%8.8x"
 
@@ -212,7 +212,7 @@ spapr_vscsi_fetch_desc_out_of_range(unsigned desc, unsigned desc_offset) "#%u is
 spapr_vscsi_fetch_desc_dma_read_error(int rc) "spapr_vio_dma_read -> %d reading ext_desc"
 spapr_vscsi_fetch_desc_indirect_seg_ext(uint32_t qtag, unsigned n, unsigned desc, uint64_t va, uint32_t len) "indirect segment ext. tag=0x%"PRIx32" desc#%u/%u { va=0x%"PRIx64" len=0x%"PRIx32" }"
 spapr_vscsi_fetch_desc_out_of_desc(void) "Out of descriptors !"
-spapr_vscsi_fetch_desc_out_of_desc_boundary(unsigned offset, unsigned desc, uint32_t len) "   offset=0x%x is out of a descriptor #%u boundary=%"PRIx32
+spapr_vscsi_fetch_desc_out_of_desc_boundary(unsigned offset, unsigned desc, uint32_t len) "   offset=0x%x is out of a descriptor #%u boundary=0x%"PRIx32
 spapr_vscsi_fetch_desc_done(unsigned desc_num, unsigned desc_offset, uint64_t va, uint32_t len) "   cur=%u offs=0x%x ret { va=0x%"PRIx64" len=0x%"PRIx32" }"
 spapr_vscsi_srp_indirect_data(uint32_t len) "indirect segment 0x%"PRIx32" bytes"
 spapr_vscsi_srp_indirect_data_rw(int writing, int rc) "spapr_vio_dma_r/w(%d) -> %d"
@@ -226,6 +226,6 @@ spapr_vscsi_command_complete_status(uint32_t status) "Command complete err=%"PRI
 spapr_vscsi_save_request(uint32_t qtag, unsigned desc, unsigned offset) "saving tag=%"PRIu32", current desc#%u, offset=0x%x"
 spapr_vscsi_load_request(uint32_t qtag, unsigned desc, unsigned offset) "restoring tag=%"PRIu32", current desc#%u, offset=0x%x"
 spapr_vscsi_process_login(void) "Got login, sending response !"
-spapr_vscsi_queue_cmd_no_drive(uint64_t lun) "Command for lun %08" PRIx64 " with no drive"
+spapr_vscsi_queue_cmd_no_drive(uint64_t lun) "Command for lun 0x%08" PRIx64 " with no drive"
 spapr_vscsi_queue_cmd(uint32_t qtag, unsigned cdb, const char *cmd, int lun, int ret) "Queued command tag 0x%"PRIx32" CMD 0x%x=%s LUN %d ret: %d"
 spapr_vscsi_do_crq(unsigned c0, unsigned c1) "crq: %02x %02x ..."
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 42ebc2d0d8..1fc0bcf44b 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -1,5 +1,5 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
 # hw/sd/milkymist-memcard.c
-milkymist_memcard_memory_read(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_memcard_memory_write(uint32_t addr, uint32_t value) "addr %08x value %08x"
+milkymist_memcard_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+milkymist_memcard_memory_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index 62c4e0dc75..640722b5d1 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -1,19 +1,19 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
 # hw/timer/slavio_timer.c
-slavio_timer_get_out(uint64_t limit, uint32_t counthigh, uint32_t count) "limit %"PRIx64" count %x%08x"
-slavio_timer_irq(uint32_t counthigh, uint32_t count) "callback: count %x%08x"
-slavio_timer_mem_readl_invalid(uint64_t addr) "invalid read address %"PRIx64
-slavio_timer_mem_readl(uint64_t addr, uint32_t ret) "read %"PRIx64" = %08x"
-slavio_timer_mem_writel(uint64_t addr, uint32_t val) "write %"PRIx64" = %08x"
-slavio_timer_mem_writel_limit(unsigned int timer_index, uint64_t count) "processor %d user timer set to %016"PRIx64
+slavio_timer_get_out(uint64_t limit, uint32_t counthigh, uint32_t count) "limit 0x%"PRIx64" count 0x%x0x%08x"
+slavio_timer_irq(uint32_t counthigh, uint32_t count) "callback: count 0x%x0x%08x"
+slavio_timer_mem_readl_invalid(uint64_t addr) "invalid read address 0x%"PRIx64
+slavio_timer_mem_readl(uint64_t addr, uint32_t ret) "read 0x%"PRIx64" = 0x%08x"
+slavio_timer_mem_writel(uint64_t addr, uint32_t val) "write 0x%"PRIx64" = 0x%08x"
+slavio_timer_mem_writel_limit(unsigned int timer_index, uint64_t count) "processor %d user timer set to 0x%016"PRIx64
 slavio_timer_mem_writel_counter_invalid(void) "not user timer"
 slavio_timer_mem_writel_status_start(unsigned int timer_index) "processor %d user timer started"
 slavio_timer_mem_writel_status_stop(unsigned int timer_index) "processor %d user timer stopped"
 slavio_timer_mem_writel_mode_user(unsigned int timer_index) "processor %d changed from counter to user timer"
 slavio_timer_mem_writel_mode_counter(unsigned int timer_index) "processor %d changed from user timer to counter"
 slavio_timer_mem_writel_mode_invalid(void) "not system timer"
-slavio_timer_mem_writel_invalid(uint64_t addr) "invalid write address %"PRIx64
+slavio_timer_mem_writel_invalid(uint64_t addr) "invalid write address 0x%"PRIx64
 
 # hw/timer/grlib_gptimer.c
 grlib_gptimer_enable(int id, uint32_t count) "timer:%d set count 0x%x and run"
@@ -31,9 +31,9 @@ lm32_timer_hit(void) "timer hit"
 lm32_timer_irq_state(int level) "irq state %d"
 
 # hw/timer/milkymist-sysctl.c
-milkymist_sysctl_memory_read(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_sysctl_memory_write(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_sysctl_icap_write(uint32_t value) "value %08x"
+milkymist_sysctl_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+milkymist_sysctl_memory_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+milkymist_sysctl_icap_write(uint32_t value) "value 0x%08x"
 milkymist_sysctl_start_timer0(void) "Start timer0"
 milkymist_sysctl_stop_timer0(void) "Stop timer0"
 milkymist_sysctl_start_timer1(void) "Start timer1"
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index f74cbd5bcd..2c18770ca5 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -11,7 +11,7 @@ usb_port_detach(int bus, const char *port) "bus %d, port %s"
 usb_port_release(int bus, const char *port) "bus %d, port %s"
 
 # hw/usb/hcd-ohci.c
-usb_ohci_iso_td_read_failed(uint32_t addr) "ISO_TD read error at %x"
+usb_ohci_iso_td_read_failed(uint32_t addr) "ISO_TD read error at 0x%x"
 usb_ohci_iso_td_head(uint32_t head, uint32_t tail, uint32_t flags, uint32_t bp, uint32_t next, uint32_t be, uint32_t framenum, uint32_t startframe, uint32_t framecount, int rel_frame_num) "ISO_TD ED head 0x%.8x tailp 0x%.8x\n0x%.8x 0x%.8x 0x%.8x 0x%.8x\nframe_number 0x%.8x starting_frame 0x%.8x\nframe_count  0x%.8x relative %d"
 usb_ohci_iso_td_head_offset(uint32_t o0, uint32_t o1, uint32_t o2, uint32_t o3, uint32_t o4, uint32_t o5, uint32_t o6, uint32_t o7) "0x%.8x 0x%.8x 0x%.8x 0x%.8x 0x%.8x 0x%.8x 0x%.8x 0x%.8x"
 usb_ohci_iso_td_relative_frame_number_neg(int rel) "ISO_TD R=%d < 0"
@@ -43,7 +43,7 @@ usb_ohci_td_nak(void) ""
 usb_ohci_td_stall(void) ""
 usb_ohci_td_babble(void) ""
 usb_ohci_td_bad_device_response(int rc) "%d"
-usb_ohci_td_read_error(uint32_t addr) "TD read error at %x"
+usb_ohci_td_read_error(uint32_t addr) "TD read error at 0x%x"
 usb_ohci_td_bad_direction(int dir) "Bad direction %d"
 usb_ohci_td_skip_async(void) ""
 usb_ohci_td_pkt_hdr(uint32_t addr, int64_t pktlen, int64_t len, const char *s, int flag_r, uint32_t cbp, uint32_t be) " TD @ 0x%.8x %" PRId64 " of %" PRId64 " bytes %s r=%d cbp=0x%.8x be=0x%.8x"
@@ -51,15 +51,15 @@ usb_ohci_td_pkt_short(const char *dir, const char *buf) "%s data: %s"
 usb_ohci_td_pkt_full(const char *dir, const char *buf) "%s data: %s"
 usb_ohci_td_too_many_pending(void) ""
 usb_ohci_td_packet_status(int status) "status=%d"
-usb_ohci_ed_read_error(uint32_t addr) "ED read error at %x"
+usb_ohci_ed_read_error(uint32_t addr) "ED read error at 0x%x"
 usb_ohci_ed_pkt(uint32_t cur, int h, int c, uint32_t head, uint32_t tail, uint32_t next) "ED @ 0x%.8x h=%u c=%u\n  head=0x%.8x tailp=0x%.8x next=0x%.8x"
 usb_ohci_ed_pkt_flags(uint32_t fa, uint32_t en, uint32_t d, int s, int k, int f, uint32_t mps) "fa=%u en=%u d=%u s=%u k=%u f=%u mps=%u"
-usb_ohci_hcca_read_error(uint32_t addr) "HCCA read error at %x"
-usb_ohci_mem_read_unaligned(uint32_t addr) "at %x"
-usb_ohci_mem_read_bad_offset(uint32_t addr) "%x"
-usb_ohci_mem_write_unaligned(uint32_t addr) "at %x"
-usb_ohci_mem_write_bad_offset(uint32_t addr) "%x"
-usb_ohci_process_lists(uint32_t head, uint32_t cur) "head %x, cur %x"
+usb_ohci_hcca_read_error(uint32_t addr) "HCCA read error at 0x%x"
+usb_ohci_mem_read_unaligned(uint32_t addr) "at 0x%x"
+usb_ohci_mem_read_bad_offset(uint32_t addr) "0x%x"
+usb_ohci_mem_write_unaligned(uint32_t addr) "at 0x%x"
+usb_ohci_mem_write_bad_offset(uint32_t addr) "0x%x"
+usb_ohci_process_lists(uint32_t head, uint32_t cur) "head 0x%x, cur 0x%x"
 usb_ohci_set_frame_interval(const char *name, uint16_t fi_x, uint16_t fi_u) "%s: FrameInterval = 0x%x (%u)"
 usb_ohci_hub_power_up(void) "powered up all ports"
 usb_ohci_hub_power_down(void) "powered down all ports"
@@ -70,22 +70,22 @@ usb_ohci_async_complete(void) ""
 # hw/usb/hcd-ehci.c
 usb_ehci_reset(void) "=== RESET ==="
 usb_ehci_unrealize(void) "=== UNREALIZE ==="
-usb_ehci_opreg_read(uint32_t addr, const char *str, uint32_t val) "rd mmio %04x [%s] = %x"
-usb_ehci_opreg_write(uint32_t addr, const char *str, uint32_t val) "wr mmio %04x [%s] = %x"
-usb_ehci_opreg_change(uint32_t addr, const char *str, uint32_t new, uint32_t old) "ch mmio %04x [%s] = %x (old: %x)"
-usb_ehci_portsc_read(uint32_t addr, uint32_t port, uint32_t val) "rd mmio %04x [port %d] = %x"
-usb_ehci_portsc_write(uint32_t addr, uint32_t port, uint32_t val) "wr mmio %04x [port %d] = %x"
-usb_ehci_portsc_change(uint32_t addr, uint32_t port, uint32_t new, uint32_t old) "ch mmio %04x [port %d] = %x (old: %x)"
+usb_ehci_opreg_read(uint32_t addr, const char *str, uint32_t val) "rd mmio 0x%04x [%s] = 0x%x"
+usb_ehci_opreg_write(uint32_t addr, const char *str, uint32_t val) "wr mmio 0x%04x [%s] = 0x%x"
+usb_ehci_opreg_change(uint32_t addr, const char *str, uint32_t new, uint32_t old) "ch mmio 0x%04x [%s] = 0x%x (old: 0x%x)"
+usb_ehci_portsc_read(uint32_t addr, uint32_t port, uint32_t val) "rd mmio 0x%04x [port %d] = 0x%x"
+usb_ehci_portsc_write(uint32_t addr, uint32_t port, uint32_t val) "wr mmio 0x%04x [port %d] = 0x%x"
+usb_ehci_portsc_change(uint32_t addr, uint32_t port, uint32_t new, uint32_t old) "ch mmio 0x%04x [port %d] = 0x%x (old: 0x%x)"
 usb_ehci_usbsts(const char *sts, int state) "usbsts %s %d"
 usb_ehci_state(const char *schedule, const char *state) "%s schedule %s"
-usb_ehci_qh_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t c_qtd, uint32_t n_qtd, uint32_t a_qtd) "q %p - QH @ %08x: next %08x qtds %08x,%08x,%08x"
-usb_ehci_qh_fields(uint32_t addr, int rl, int mplen, int eps, int ep, int devaddr) "QH @ %08x - rl %d, mplen %d, eps %d, ep %d, dev %d"
-usb_ehci_qh_bits(uint32_t addr, int c, int h, int dtc, int i) "QH @ %08x - c %d, h %d, dtc %d, i %d"
-usb_ehci_qtd_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t altnext) "q %p - QTD @ %08x: next %08x altnext %08x"
-usb_ehci_qtd_fields(uint32_t addr, int tbytes, int cpage, int cerr, int pid) "QTD @ %08x - tbytes %d, cpage %d, cerr %d, pid %d"
-usb_ehci_qtd_bits(uint32_t addr, int ioc, int active, int halt, int babble, int xacterr) "QTD @ %08x - ioc %d, active %d, halt %d, babble %d, xacterr %d"
-usb_ehci_itd(uint32_t addr, uint32_t nxt, uint32_t mplen, uint32_t mult, uint32_t ep, uint32_t devaddr) "ITD @ %08x: next %08x - mplen %d, mult %d, ep %d, dev %d"
-usb_ehci_sitd(uint32_t addr, uint32_t nxt, uint32_t active) "ITD @ %08x: next %08x - active %d"
+usb_ehci_qh_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t c_qtd, uint32_t n_qtd, uint32_t a_qtd) "q %p - QH @ 0x%08x: next 0x%08x qtds 0x%08x,0x%08x,0x%08x"
+usb_ehci_qh_fields(uint32_t addr, int rl, int mplen, int eps, int ep, int devaddr) "QH @ 0x%08x - rl %d, mplen %d, eps %d, ep %d, dev %d"
+usb_ehci_qh_bits(uint32_t addr, int c, int h, int dtc, int i) "QH @ 0x%08x - c %d, h %d, dtc %d, i %d"
+usb_ehci_qtd_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t altnext) "q %p - QTD @ 0x%08x: next 0x%08x altnext 0x%08x"
+usb_ehci_qtd_fields(uint32_t addr, int tbytes, int cpage, int cerr, int pid) "QTD @ 0x%08x - tbytes %d, cpage %d, cerr %d, pid %d"
+usb_ehci_qtd_bits(uint32_t addr, int ioc, int active, int halt, int babble, int xacterr) "QTD @ 0x%08x - ioc %d, active %d, halt %d, babble %d, xacterr %d"
+usb_ehci_itd(uint32_t addr, uint32_t nxt, uint32_t mplen, uint32_t mult, uint32_t ep, uint32_t devaddr) "ITD @ 0x%08x: next 0x%08x - mplen %d, mult %d, ep %d, dev %d"
+usb_ehci_sitd(uint32_t addr, uint32_t nxt, uint32_t active) "ITD @ 0x%08x: next 0x%08x - active %d"
 usb_ehci_port_attach(uint32_t port, const char *owner, const char *device) "attach port #%d, owner %s, device %s"
 usb_ehci_port_detach(uint32_t port, const char *owner) "detach port #%d, owner %s"
 usb_ehci_port_reset(uint32_t port, int enable) "reset port #%d - %d"
@@ -149,11 +149,11 @@ usb_xhci_irq_msi(uint32_t nr) "nr %d"
 usb_xhci_irq_msix(uint32_t nr) "nr %d"
 usb_xhci_irq_msix_use(uint32_t nr) "nr %d"
 usb_xhci_irq_msix_unuse(uint32_t nr) "nr %d"
-usb_xhci_queue_event(uint32_t vector, uint32_t idx, const char *trb, const char *evt, uint64_t param, uint32_t status, uint32_t control) "v %d, idx %d, %s, %s, p %016" PRIx64 ", s %08x, c 0x%08x"
-usb_xhci_fetch_trb(uint64_t addr, const char *name, uint64_t param, uint32_t status, uint32_t control) "addr %016" PRIx64 ", %s, p %016" PRIx64 ", s %08x, c 0x%08x"
+usb_xhci_queue_event(uint32_t vector, uint32_t idx, const char *trb, const char *evt, uint64_t param, uint32_t status, uint32_t control) "v %d, idx %d, %s, %s, p 0x%016" PRIx64 ", s 0x%08x, c 0x%08x"
+usb_xhci_fetch_trb(uint64_t addr, const char *name, uint64_t param, uint32_t status, uint32_t control) "addr 0x%016" PRIx64 ", %s, p 0x%016" PRIx64 ", s 0x%08x, c 0x%08x"
 usb_xhci_port_reset(uint32_t port, bool warm) "port %d, warm %d"
 usb_xhci_port_link(uint32_t port, uint32_t pls) "port %d, pls %d"
-usb_xhci_port_notify(uint32_t port, uint32_t pls) "port %d, bits %x"
+usb_xhci_port_notify(uint32_t port, uint32_t pls) "port %d, bits 0x%x"
 usb_xhci_slot_enable(uint32_t slotid) "slotid %d"
 usb_xhci_slot_disable(uint32_t slotid) "slotid %d"
 usb_xhci_slot_address(uint32_t slotid, const char *port) "slotid %d, port %s"
@@ -162,7 +162,7 @@ usb_xhci_slot_evaluate(uint32_t slotid) "slotid %d"
 usb_xhci_slot_reset(uint32_t slotid) "slotid %d"
 usb_xhci_ep_enable(uint32_t slotid, uint32_t epid) "slotid %d, epid %d"
 usb_xhci_ep_disable(uint32_t slotid, uint32_t epid) "slotid %d, epid %d"
-usb_xhci_ep_set_dequeue(uint32_t slotid, uint32_t epid, uint32_t streamid, uint64_t param) "slotid %d, epid %d, streamid %d, ptr %016" PRIx64
+usb_xhci_ep_set_dequeue(uint32_t slotid, uint32_t epid, uint32_t streamid, uint64_t param) "slotid %d, epid %d, streamid %d, ptr 0x%016" PRIx64
 usb_xhci_ep_kick(uint32_t slotid, uint32_t epid, uint32_t streamid) "slotid %d, epid %d, streamid %d"
 usb_xhci_ep_stop(uint32_t slotid, uint32_t epid) "slotid %d, epid %d"
 usb_xhci_ep_reset(uint32_t slotid, uint32_t epid) "slotid %d, epid %d"
@@ -202,7 +202,7 @@ usb_hub_status_report(int addr, int status) "dev %d, status 0x%x"
 
 # hw/usb/dev-uas.c
 usb_uas_reset(int addr) "dev %d"
-usb_uas_command(int addr, uint16_t tag, int lun, uint32_t lun64_1, uint32_t lun64_2) "dev %d, tag 0x%x, lun %d, lun64 %08x-%08x"
+usb_uas_command(int addr, uint16_t tag, int lun, uint32_t lun64_1, uint32_t lun64_2) "dev %d, tag 0x%x, lun %d, lun64 0x%08x-0x%08x"
 usb_uas_response(int addr, uint16_t tag, uint8_t code) "dev %d, tag 0x%x, code 0x%x"
 usb_uas_sense(int addr, uint16_t tag, uint8_t status) "dev %d, tag 0x%x, status 0x%x"
 usb_uas_read_ready(int addr, uint16_t tag) "dev %d, tag 0x%x"
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index f7f891439a..fae096c072 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -23,7 +23,7 @@ vfio_rom_read(const char *name, uint64_t addr, int size, uint64_t data) " (%s, 0
 vfio_pci_size_rom(const char *name, int size) "%s ROM size 0x%x"
 vfio_vga_write(uint64_t addr, uint64_t data, int size) " (0x%"PRIx64", 0x%"PRIx64", %d)"
 vfio_vga_read(uint64_t addr, int size, uint64_t data) " (0x%"PRIx64", %d) = 0x%"PRIx64
-vfio_pci_read_config(const char *name, int addr, int len, int val) " (%s, @0x%x, len=0x%x) %x"
+vfio_pci_read_config(const char *name, int addr, int len, int val) " (%s, @0x%x, len=0x%x) 0x%x"
 vfio_pci_write_config(const char *name, int addr, int val, int len) " (%s, @0x%x, 0x%x, len=0x%x)"
 vfio_msi_setup(const char *name, int pos) "%s PCI MSI CAP @0x%x"
 vfio_msix_early_setup(const char *name, int pos, int table_bar, int offset, int entries) "%s PCI MSI-X CAP @0x%x, BAR %d, offset 0x%x, entries %d"
@@ -37,14 +37,14 @@ vfio_pci_hot_reset_result(const char *name, const char *result) "%s hot reset: %
 vfio_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device %s config:\n  size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
 vfio_populate_device_get_irq_info_failure(void) "VFIO_DEVICE_GET_IRQ_INFO failure: %m"
 vfio_realize(const char *name, int group_id) " (%s) group %d"
-vfio_add_ext_cap_dropped(const char *name, uint16_t cap, uint16_t offset) "%s %x@%x"
+vfio_add_ext_cap_dropped(const char *name, uint16_t cap, uint16_t offset) "%s 0x%x@0x%x"
 vfio_pci_reset(const char *name) " (%s)"
 vfio_pci_reset_flr(const char *name) "%s FLR/VFIO_DEVICE_RESET"
 vfio_pci_reset_pm(const char *name) "%s PCI PM Reset"
-vfio_pci_emulated_vendor_id(const char *name, uint16_t val) "%s %04x"
-vfio_pci_emulated_device_id(const char *name, uint16_t val) "%s %04x"
-vfio_pci_emulated_sub_vendor_id(const char *name, uint16_t val) "%s %04x"
-vfio_pci_emulated_sub_device_id(const char *name, uint16_t val) "%s %04x"
+vfio_pci_emulated_vendor_id(const char *name, uint16_t val) "%s 0x%04x"
+vfio_pci_emulated_device_id(const char *name, uint16_t val) "%s 0x%04x"
+vfio_pci_emulated_sub_vendor_id(const char *name, uint16_t val) "%s 0x%04x"
+vfio_pci_emulated_sub_device_id(const char *name, uint16_t val) "%s 0x%04x"
 
 # hw/vfio/pci-quirks.c
 vfio_quirk_rom_blacklisted(const char *name, uint16_t vid, uint16_t did) "%s %04x:%04x"
@@ -58,7 +58,7 @@ vfio_quirk_ati_3c3_probe(const char *name) "%s"
 vfio_quirk_ati_bar4_probe(const char *name) "%s"
 vfio_quirk_ati_bar2_probe(const char *name) "%s"
 vfio_quirk_nvidia_3d0_state(const char *name, const char *state) "%s %s"
-vfio_quirk_nvidia_3d0_read(const char *name, uint8_t offset, unsigned size, uint64_t val) " (%s, @0x%x, len=0x%x) %"PRIx64
+vfio_quirk_nvidia_3d0_read(const char *name, uint8_t offset, unsigned size, uint64_t val) " (%s, @0x%x, len=0x%x) 0x%"PRIx64
 vfio_quirk_nvidia_3d0_write(const char *name, uint8_t offset, uint64_t data, unsigned size) "(%s, @0x%x, 0x%"PRIx64", len=0x%x)"
 vfio_quirk_nvidia_3d0_probe(const char *name) "%s"
 vfio_quirk_nvidia_bar5_state(const char *name, const char *state) "%s %s"
@@ -75,7 +75,7 @@ vfio_quirk_ati_bonaire_reset_no_smc(const char *name) "%s"
 vfio_quirk_ati_bonaire_reset_timeout(const char *name) "%s"
 vfio_quirk_ati_bonaire_reset_done(const char *name) "%s"
 vfio_quirk_ati_bonaire_reset(const char *name) "%s"
-vfio_pci_igd_bar4_write(const char *name, uint32_t index, uint32_t data, uint32_t base) "%s [%03x] %08x -> %08x"
+vfio_pci_igd_bar4_write(const char *name, uint32_t index, uint32_t data, uint32_t base) "%s [0x%03x] 0x%08x -> 0x%08x"
 vfio_pci_igd_bdsm_enabled(const char *name, int size) "%s %dMB"
 vfio_pci_igd_opregion_enabled(const char *name) "%s"
 vfio_pci_igd_host_bridge_enabled(const char *name) "%s"
@@ -84,19 +84,19 @@ vfio_pci_igd_lpc_bridge_enabled(const char *name) "%s"
 # hw/vfio/common.c
 vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
 vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t data) " (%s:region%d+0x%"PRIx64", %d) = 0x%"PRIx64
-vfio_iommu_map_notify(const char *op, uint64_t iova_start, uint64_t iova_end) "iommu %s @ %"PRIx64" - %"PRIx64
-vfio_listener_region_add_skip(uint64_t start, uint64_t end) "SKIPPING region_add %"PRIx64" - %"PRIx64
-vfio_listener_region_add_iommu(uint64_t start, uint64_t end) "region_add [iommu] %"PRIx64" - %"PRIx64
-vfio_listener_region_add_ram(uint64_t iova_start, uint64_t iova_end, void *vaddr) "region_add [ram] %"PRIx64" - %"PRIx64" [%p]"
-vfio_listener_region_del_skip(uint64_t start, uint64_t end) "SKIPPING region_del %"PRIx64" - %"PRIx64
-vfio_listener_region_del(uint64_t start, uint64_t end) "region_del %"PRIx64" - %"PRIx64
+vfio_iommu_map_notify(const char *op, uint64_t iova_start, uint64_t iova_end) "iommu %s @ 0x%"PRIx64" - 0x%"PRIx64
+vfio_listener_region_add_skip(uint64_t start, uint64_t end) "SKIPPING region_add 0x%"PRIx64" - 0x%"PRIx64
+vfio_listener_region_add_iommu(uint64_t start, uint64_t end) "region_add [iommu] 0x%"PRIx64" - 0x%"PRIx64
+vfio_listener_region_add_ram(uint64_t iova_start, uint64_t iova_end, void *vaddr) "region_add [ram] 0x%"PRIx64" - 0x%"PRIx64" [%p]"
+vfio_listener_region_del_skip(uint64_t start, uint64_t end) "SKIPPING region_del 0x%"PRIx64" - 0x%"PRIx64
+vfio_listener_region_del(uint64_t start, uint64_t end) "region_del 0x%"PRIx64" - 0x%"PRIx64
 vfio_disconnect_container(int fd) "close container->fd=%d"
 vfio_put_group(int fd) "close group->fd=%d"
 vfio_get_device(const char * name, unsigned int flags, unsigned int num_regions, unsigned int num_irqs) "Device %s flags: %u, regions: %u, irqs: %u"
 vfio_put_base_device(int fd) "close vdev->fd=%d"
-vfio_region_setup(const char *dev, int index, const char *name, unsigned long flags, unsigned long offset, unsigned long size) "Device %s, region %d \"%s\", flags: %lx, offset: %lx, size: %lx"
-vfio_region_mmap_fault(const char *name, int index, unsigned long offset, unsigned long size, int fault) "Region %s mmaps[%d], [%lx - %lx], fault: %d"
-vfio_region_mmap(const char *name, unsigned long offset, unsigned long end) "Region %s [%lx - %lx]"
+vfio_region_setup(const char *dev, int index, const char *name, unsigned long flags, unsigned long offset, unsigned long size) "Device %s, region %d \"%s\", flags: 0x%lx, offset: 0x%lx, size: 0x%lx"
+vfio_region_mmap_fault(const char *name, int index, unsigned long offset, unsigned long size, int fault) "Region %s mmaps[%d], [0x%lx - 0x%lx], fault: %d"
+vfio_region_mmap(const char *name, unsigned long offset, unsigned long end) "Region %s [0x%lx - 0x%lx]"
 vfio_region_exit(const char *name, int index) "Device %s, region %d"
 vfio_region_finalize(const char *name, int index) "Device %s, region %d"
 vfio_region_mmaps_set_enabled(const char *name, bool enabled) "Region %s mmaps enabled: %d"
@@ -117,9 +117,9 @@ vfio_platform_start_level_irqfd_injection(int index, int fd, int resamplefd) "IR
 vfio_platform_start_edge_irqfd_injection(int index, int fd) "IRQ index=%d, fd = %d"
 
 # hw/vfio/spapr.c
-vfio_prereg_listener_region_add_skip(uint64_t start, uint64_t end) "%"PRIx64" - %"PRIx64
-vfio_prereg_listener_region_del_skip(uint64_t start, uint64_t end) "%"PRIx64" - %"PRIx64
-vfio_prereg_register(uint64_t va, uint64_t size, int ret) "va=%"PRIx64" size=%"PRIx64" ret=%d"
-vfio_prereg_unregister(uint64_t va, uint64_t size, int ret) "va=%"PRIx64" size=%"PRIx64" ret=%d"
+vfio_prereg_listener_region_add_skip(uint64_t start, uint64_t end) "0x%"PRIx64" - 0x%"PRIx64
+vfio_prereg_listener_region_del_skip(uint64_t start, uint64_t end) "0x%"PRIx64" - 0x%"PRIx64
+vfio_prereg_register(uint64_t va, uint64_t size, int ret) "va=0x%"PRIx64" size=0x%"PRIx64" ret=%d"
+vfio_prereg_unregister(uint64_t va, uint64_t size, int ret) "va=0x%"PRIx64" size=0x%"PRIx64" ret=%d"
 vfio_spapr_create_window(int ps, uint64_t ws, uint64_t off) "pageshift=0x%x winsize=0x%"PRIx64" offset=0x%"PRIx64
-vfio_spapr_remove_window(uint64_t off) "offset=%"PRIx64
+vfio_spapr_remove_window(uint64_t off) "offset=0x%"PRIx64
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 012bbaa694..775461ae98 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -20,8 +20,8 @@ virtio_rng_vm_state_change(void *rng, int running, int state) "rng %p: state cha
 
 # hw/virtio/virtio-balloon.c
 #
-virtio_balloon_bad_addr(uint64_t gpa) "%"PRIx64
-virtio_balloon_handle_output(const char *name, uint64_t gpa) "section name: %s gpa: %"PRIx64
+virtio_balloon_bad_addr(uint64_t gpa) "0x%"PRIx64
+virtio_balloon_handle_output(const char *name, uint64_t gpa) "section name: %s gpa: 0x%"PRIx64
 virtio_balloon_get_config(uint32_t num_pages, uint32_t actual) "num_pages: %d actual: %d"
 virtio_balloon_set_config(uint32_t actual, uint32_t oldactual) "actual: %d oldactual: %d"
-virtio_balloon_to_target(uint64_t target, uint32_t num_pages) "balloon target: %"PRIx64" num_pages: %d"
+virtio_balloon_to_target(uint64_t target, uint32_t num_pages) "balloon target: 0x%"PRIx64" num_pages: %d"
diff --git a/linux-user/trace-events b/linux-user/trace-events
index 80ad957dfd..68f36ac8fd 100644
--- a/linux-user/trace-events
+++ b/linux-user/trace-events
@@ -1,12 +1,12 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
 # linux-user/signal.c
-user_setup_frame(void *env, uint64_t frame_addr) "env=%p frame_addr=%"PRIx64
-user_setup_rt_frame(void *env, uint64_t frame_addr) "env=%p frame_addr=%"PRIx64
-user_do_rt_sigreturn(void *env, uint64_t frame_addr) "env=%p frame_addr=%"PRIx64
-user_do_sigreturn(void *env, uint64_t frame_addr) "env=%p frame_addr=%"PRIx64
+user_setup_frame(void *env, uint64_t frame_addr) "env=%p frame_addr=0x%"PRIx64
+user_setup_rt_frame(void *env, uint64_t frame_addr) "env=%p frame_addr=0x%"PRIx64
+user_do_rt_sigreturn(void *env, uint64_t frame_addr) "env=%p frame_addr=0x%"PRIx64
+user_do_sigreturn(void *env, uint64_t frame_addr) "env=%p frame_addr=0x%"PRIx64
 user_force_sig(void *env, int target_sig, int host_sig) "env=%p signal %d (host %d)"
 user_handle_signal(void *env, int target_sig) "env=%p signal %d"
 user_host_signal(void *env, int host_sig, int target_sig) "env=%p signal %d (target %d("
 user_queue_signal(void *env, int target_sig) "env=%p signal %d"
-user_s390x_restore_sigregs(void *env, uint64_t sc_psw_addr, uint64_t env_psw_addr) "env=%p frame psw.addr %"PRIx64 " current psw.addr %"PRIx64
+user_s390x_restore_sigregs(void *env, uint64_t sc_psw_addr, uint64_t env_psw_addr) "env=%p frame psw.addr 0x%"PRIx64 " current psw.addr 0x%"PRIx64
diff --git a/migration/trace-events b/migration/trace-events
index a7d546b289..7a3b5144ff 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -21,7 +21,7 @@ loadvm_postcopy_ram_handle_discard(void) ""
 loadvm_postcopy_ram_handle_discard_end(void) ""
 loadvm_postcopy_ram_handle_discard_header(const char *ramid, uint16_t len) "%s: %ud"
 loadvm_process_command(uint16_t com, uint16_t len) "com=0x%x len=%d"
-loadvm_process_command_ping(uint32_t val) "%x"
+loadvm_process_command_ping(uint32_t val) "0x%x"
 postcopy_ram_listen_thread_exit(void) ""
 postcopy_ram_listen_thread_start(void) ""
 qemu_savevm_send_postcopy_advise(void) ""
@@ -31,7 +31,7 @@ savevm_section_start(const char *id, unsigned int section_id) "%s, section_id %u
 savevm_section_end(const char *id, unsigned int section_id, int ret) "%s, section_id %u -> %d"
 savevm_section_skip(const char *id, unsigned int section_id) "%s, section_id %u"
 savevm_send_open_return_path(void) ""
-savevm_send_ping(uint32_t val) "%x"
+savevm_send_ping(uint32_t val) "0x%x"
 savevm_send_postcopy_listen(void) ""
 savevm_send_postcopy_run(void) ""
 savevm_state_setup(void) ""
@@ -65,17 +65,17 @@ put_qtailq_end(const char *name, const char *reason) "%s %s"
 qemu_file_fclose(void) ""
 
 # migration/ram.c
-get_queued_page(const char *block_name, uint64_t tmp_offset, unsigned long page_abs) "%s/%" PRIx64 " page_abs=%lx"
-get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset, unsigned long page_abs, int sent) "%s/%" PRIx64 " page_abs=%lx (sent=%d)"
+get_queued_page(const char *block_name, uint64_t tmp_offset, unsigned long page_abs) "%s/0x%" PRIx64 " page_abs=0x%lx"
+get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset, unsigned long page_abs, int sent) "%s/0x%" PRIx64 " page_abs=0x%lx (sent=%d)"
 migration_bitmap_sync_start(void) ""
 migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu64
 migration_throttle(void) ""
 ram_discard_range(const char *rbname, uint64_t start, size_t len) "%s: start: %" PRIx64 " %zx"
-ram_load_loop(const char *rbname, uint64_t addr, int flags, void *host) "%s: addr: %" PRIx64 " flags: %x host: %p"
+ram_load_loop(const char *rbname, uint64_t addr, int flags, void *host) "%s: addr: 0x%" PRIx64 " flags: 0x%x host: %p"
 ram_load_postcopy_loop(uint64_t addr, int flags) "@%" PRIx64 " %x"
 ram_postcopy_send_discard_bitmap(void) ""
-ram_save_page(const char *rbname, uint64_t offset, void *host) "%s: offset: %" PRIx64 " host: %p"
-ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: %zx len: %zx"
+ram_save_page(const char *rbname, uint64_t offset, void *host) "%s: offset: 0x%" PRIx64 " host: %p"
+ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: 0x%zx len: 0x%zx"
 
 # migration/migration.c
 await_return_path_close_on_source_close(void) ""
@@ -84,7 +84,7 @@ migrate_set_state(int new_state) "new state %d"
 migrate_fd_cleanup(void) ""
 migrate_fd_error(const char *error_desc) "error=%s"
 migrate_fd_cancel(void) ""
-migrate_handle_rp_req_pages(const char *rbname, size_t start, size_t len) "in %s at %zx len %zx"
+migrate_handle_rp_req_pages(const char *rbname, size_t start, size_t len) "in %s at 0x%zx len 0x%zx"
 migrate_pending(uint64_t size, uint64_t max, uint64_t post, uint64_t nonpost) "pending size %" PRIu64 " max %" PRIu64 " (post=%" PRIu64 " nonpost=%" PRIu64 ")"
 migrate_send_rp_message(int msg_type, uint16_t len) "%d: len %d"
 migration_completion_file_err(void) ""
@@ -103,8 +103,8 @@ source_return_path_thread_bad_end(void) ""
 source_return_path_thread_end(void) ""
 source_return_path_thread_entry(void) ""
 source_return_path_thread_loop_top(void) ""
-source_return_path_thread_pong(uint32_t val) "%x"
-source_return_path_thread_shut(uint32_t val) "%x"
+source_return_path_thread_pong(uint32_t val) "0x%x"
+source_return_path_thread_shut(uint32_t val) "0x%x"
 migrate_global_state_post_load(const char *state) "loaded state: %s"
 migrate_global_state_pre_save(const char *state) "saved state: %s"
 migration_thread_low_pending(uint64_t pending) "%" PRIu64
@@ -143,10 +143,10 @@ qemu_rdma_register_and_get_keys(uint64_t len, void *start) "Registering %" PRIu6
 qemu_rdma_registration_handle_compress(int64_t length, int index, int64_t offset) "Zapping zero chunk: %" PRId64 " bytes, index %d, offset %" PRId64
 qemu_rdma_registration_handle_finished(void) ""
 qemu_rdma_registration_handle_ram_blocks(void) ""
-qemu_rdma_registration_handle_ram_blocks_loop(const char *name, uint64_t offset, uint64_t length, void *local_host_addr, unsigned int src_index) "%s: @%" PRIx64 "/%" PRIu64 " host:@%p src_index: %u"
+qemu_rdma_registration_handle_ram_blocks_loop(const char *name, uint64_t offset, uint64_t length, void *local_host_addr, unsigned int src_index) "%s: @0x%" PRIx64 "/%" PRIu64 " host:@%p src_index: %u"
 qemu_rdma_registration_handle_register(int requests) "%d requests"
 qemu_rdma_registration_handle_register_loop(int req, int index, uint64_t addr, uint64_t chunks) "Registration request (%d): index %d, current_addr %" PRIu64 " chunks: %" PRIu64
-qemu_rdma_registration_handle_register_rkey(int rkey) "%x"
+qemu_rdma_registration_handle_register_rkey(int rkey) "0x%x"
 qemu_rdma_registration_handle_unregister(int requests) "%d requests"
 qemu_rdma_registration_handle_unregister_loop(int count, int index, uint64_t chunk) "Unregistration request (%d): index %d, chunk %" PRIu64
 qemu_rdma_registration_handle_unregister_success(uint64_t chunk) "%" PRIu64
@@ -163,9 +163,9 @@ qemu_rdma_unregister_waiting_send(uint64_t chunk) "Sending unregister for chunk:
 qemu_rdma_unregister_waiting_complete(uint64_t chunk) "Unregister for chunk: %" PRIu64 " complete."
 qemu_rdma_write_flush(int sent) "sent total: %d"
 qemu_rdma_write_one_block(int count, int block, uint64_t chunk, uint64_t current, uint64_t len, int nb_sent, int nb_chunks) "(%d) Not clobbering: block: %d chunk %" PRIu64 " current %" PRIu64 " len %" PRIu64 " %d %d"
-qemu_rdma_write_one_post(uint64_t chunk, long addr, long remote, uint32_t len) "Posting chunk: %" PRIu64 ", addr: %lx remote: %lx, bytes %" PRIu32
+qemu_rdma_write_one_post(uint64_t chunk, long addr, long remote, uint32_t len) "Posting chunk: %" PRIu64 ", addr: 0x%lx remote: 0x%lx, bytes %" PRIu32
 qemu_rdma_write_one_queue_full(void) ""
-qemu_rdma_write_one_recvregres(int mykey, int theirkey, uint64_t chunk) "Received registration result: my key: %x their key %x, chunk %" PRIu64
+qemu_rdma_write_one_recvregres(int mykey, int theirkey, uint64_t chunk) "Received registration result: my key: 0x%x their key 0x%x, chunk %" PRIu64
 qemu_rdma_write_one_sendreg(uint64_t chunk, int len, int index, int64_t offset) "Sending registration request chunk %" PRIu64 " for %d bytes, index: %d, offset: %" PRId64
 qemu_rdma_write_one_top(uint64_t chunks, uint64_t size) "Writing %" PRIu64 " chunks, (%" PRIu64 " MB)"
 qemu_rdma_write_one_zero(uint64_t chunk, int len, int index, int64_t offset) "Entire chunk is zero, sending compress: %" PRIu64 " for %d bytes, index: %d, offset: %" PRId64
@@ -181,16 +181,16 @@ rdma_start_outgoing_migration_after_rdma_source_init(void) ""
 # migration/postcopy-ram.c
 postcopy_discard_send_finish(const char *ramblock, int nwords, int ncmds) "%s mask words sent=%d in %d commands"
 postcopy_discard_send_range(const char *ramblock, unsigned long start, unsigned long length) "%s:%lx/%lx"
-postcopy_cleanup_range(const char *ramblock, void *host_addr, size_t offset, size_t length) "%s: %p offset=%zx length=%zx"
-postcopy_init_range(const char *ramblock, void *host_addr, size_t offset, size_t length) "%s: %p offset=%zx length=%zx"
-postcopy_nhp_range(const char *ramblock, void *host_addr, size_t offset, size_t length) "%s: %p offset=%zx length=%zx"
+postcopy_cleanup_range(const char *ramblock, void *host_addr, size_t offset, size_t length) "%s: %p offset=0x%zx length=0x%zx"
+postcopy_init_range(const char *ramblock, void *host_addr, size_t offset, size_t length) "%s: %p offset=0x%zx length=0x%zx"
+postcopy_nhp_range(const char *ramblock, void *host_addr, size_t offset, size_t length) "%s: %p offset=0x%zx length=0x%zx"
 postcopy_place_page(void *host_addr) "host=%p"
 postcopy_place_page_zero(void *host_addr) "host=%p"
 postcopy_ram_enable_notify(void) ""
 postcopy_ram_fault_thread_entry(void) ""
 postcopy_ram_fault_thread_exit(void) ""
 postcopy_ram_fault_thread_quit(void) ""
-postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ramblock, size_t offset) "Request for HVA=%" PRIx64 " rb=%s offset=%zx"
+postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ramblock, size_t offset) "Request for HVA=0x%" PRIx64 " rb=%s offset=0x%zx"
 postcopy_ram_incoming_cleanup_closeuf(void) ""
 postcopy_ram_incoming_cleanup_entry(void) ""
 postcopy_ram_incoming_cleanup_exit(void) ""
diff --git a/nbd/trace-events b/nbd/trace-events
index d7c7746ea8..48a4f27682 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -1,8 +1,8 @@
 # nbd/client.c
 nbd_unknown_error(int err) "Squashing unexpected error %d to EINVAL"
 nbd_send_option_request(uint32_t opt, const char *name, uint32_t len) "Sending option request %" PRIu32" (%s), len %" PRIu32
-nbd_receive_option_reply(uint32_t option, const char *optname, uint32_t type, const char *typename, uint32_t length) "Received option reply %" PRIx32" (%s), type %" PRIx32" (%s), len %" PRIu32
-nbd_reply_err_unsup(uint32_t option, const char *name) "server doesn't understand request %" PRIx32 " (%s), attempting fallback"
+nbd_receive_option_reply(uint32_t option, const char *optname, uint32_t type, const char *typename, uint32_t length) "Received option reply 0x%" PRIx32" (%s), type 0x%" PRIx32" (%s), len %" PRIu32
+nbd_reply_err_unsup(uint32_t option, const char *name) "server doesn't understand request 0x%" PRIx32 " (%s), attempting fallback"
 nbd_opt_go_start(const char *name) "Attempting NBD_OPT_GO for export '%s'"
 nbd_opt_go_success(void) "Export is good to go"
 nbd_opt_go_info_unknown(int info, const char *name) "Ignoring unknown info %d (%s)"
@@ -15,9 +15,9 @@ nbd_receive_starttls_new_client(void) "TLS request approved, setting up TLS"
 nbd_receive_starttls_tls_handshake(void) "Starting TLS handshake"
 nbd_receive_negotiate(void *tlscreds, const char *hostname) "Receiving negotiation tlscreds=%p hostname=%s"
 nbd_receive_negotiate_magic(uint64_t magic) "Magic is 0x%" PRIx64
-nbd_receive_negotiate_server_flags(uint32_t globalflags) "Global flags are %" PRIx32
+nbd_receive_negotiate_server_flags(uint32_t globalflags) "Global flags are 0x%" PRIx32
 nbd_receive_negotiate_default_name(void) "Using default NBD export name \"\""
-nbd_receive_negotiate_size_flags(uint64_t size, uint16_t flags) "Size is %" PRIu64 ", export flags %" PRIx16
+nbd_receive_negotiate_size_flags(uint64_t size, uint16_t flags) "Size is %" PRIu64 ", export flags 0x%" PRIx16
 nbd_init_set_socket(void) "Setting NBD socket"
 nbd_init_set_block_size(unsigned long block_size) "Setting block size to %lu"
 nbd_init_set_size(unsigned long sectors) "Setting size to %lu block(s)"
@@ -28,11 +28,11 @@ nbd_client_loop(void) "Doing NBD loop"
 nbd_client_loop_ret(int ret, const char *error) "NBD loop returned %d: %s"
 nbd_client_clear_queue(void) "Clearing NBD queue"
 nbd_client_clear_socket(void) "Clearing NBD socket"
-nbd_send_request(uint64_t from, uint32_t len, uint64_t handle, uint16_t flags, uint16_t type, const char *name) "Sending request to server: { .from = %" PRIu64", .len = %" PRIu32 ", .handle = %" PRIu64 ", .flags = %" PRIx16 ", .type = %" PRIu16 " (%s) }"
+nbd_send_request(uint64_t from, uint32_t len, uint64_t handle, uint16_t flags, uint16_t type, const char *name) "Sending request to server: { .from = %" PRIu64", .len = %" PRIu32 ", .handle = %" PRIu64 ", .flags = 0x%" PRIx16 ", .type = %" PRIu16 " (%s) }"
 nbd_receive_reply(uint32_t magic, int32_t error, uint64_t handle) "Got reply: { magic = 0x%" PRIx32 ", .error = % " PRId32 ", handle = %" PRIu64" }"
 
 # nbd/server.c
-nbd_negotiate_send_rep_len(uint32_t opt, const char *optname, uint32_t type, const char *typename, uint32_t len) "Reply opt=%" PRIx32 " (%s), type=%" PRIx32 " (%s), len=%" PRIu32
+nbd_negotiate_send_rep_len(uint32_t opt, const char *optname, uint32_t type, const char *typename, uint32_t len) "Reply opt=0x%" PRIx32 " (%s), type=0x%" PRIx32 " (%s), len=%" PRIu32
 nbd_negotiate_send_rep_err(const char *msg) "sending error message \"%s\""
 nbd_negotiate_send_rep_list(const char *name, const char *desc) "Advertising export name '%s' description '%s'"
 nbd_negotiate_handle_export_name(void) "Checking length"
@@ -47,10 +47,10 @@ nbd_negotiate_options_flags(uint32_t flags) "Received client flags 0x%" PRIx32
 nbd_negotiate_options_check_magic(uint64_t magic) "Checking opts magic 0x%" PRIx64
 nbd_negotiate_options_check_option(uint32_t option, const char *name) "Checking option 0x%" PRIx32 " (%s)"
 nbd_negotiate_begin(void) "Beginning negotiation"
-nbd_negotiate_old_style(uint64_t size, unsigned flags) "advertising size %" PRIu64 " and flags %x"
-nbd_negotiate_new_style_size_flags(uint64_t size, unsigned flags) "advertising size %" PRIu64 " and flags %x"
+nbd_negotiate_old_style(uint64_t size, unsigned flags) "advertising size %" PRIu64 " and flags 0x%x"
+nbd_negotiate_new_style_size_flags(uint64_t size, unsigned flags) "advertising size %" PRIu64 " and flags 0x%x"
 nbd_negotiate_success(void) "Negotiation succeeded"
-nbd_receive_request(uint32_t magic, uint16_t flags, uint16_t type, uint64_t from, uint32_t len) "Got request: { magic = 0x%" PRIx32 ", .flags = %" PRIx16 ", .type = %" PRIx16 ", from = %" PRIu64 ", len = %" PRIu32 " }"
+nbd_receive_request(uint32_t magic, uint16_t flags, uint16_t type, uint64_t from, uint32_t len) "Got request: { magic = 0x%" PRIx32 ", .flags = 0x%" PRIx16 ", .type = 0x%" PRIx16 ", from = %" PRIu64 ", len = %" PRIu32 " }"
 nbd_send_reply(int32_t error, uint64_t handle) "Sending response to client: { .error = %" PRId32 ", handle = %" PRIu64 " }"
 nbd_blk_aio_attached(const char *name, void *ctx) "Export %s: Attaching clients to AIO context %p\n"
 nbd_blk_aio_detach(const char *name, void *ctx) "Export %s: Detaching clients from AIO context %p\n"
diff --git a/net/trace-events b/net/trace-events
index 201813941d..938263dd7a 100644
--- a/net/trace-events
+++ b/net/trace-events
@@ -13,9 +13,9 @@ colo_compare_icmp_miscompare(const char *sta, int size) ": %s = %d"
 colo_compare_ip_info(int psize, const char *sta, const char *stb, int ssize, const char *stc, const char *std) "ppkt size = %d, ip_src = %s, ip_dst = %s, spkt size = %d, ip_src = %s, ip_dst = %s"
 colo_old_packet_check_found(int64_t old_time) "%" PRId64
 colo_compare_miscompare(void) ""
-colo_compare_tcp_info(const char *pkt, uint32_t seq, uint32_t ack, int res, uint32_t flag, int size) "side: %s seq/ack= %u/%u res= %d flags= %x pkt_size: %d\n"
+colo_compare_tcp_info(const char *pkt, uint32_t seq, uint32_t ack, int res, uint32_t flag, int size) "side: %s seq/ack= %u/%u res= %d flags= 0x%x pkt_size: %d\n"
 
 # net/filter-rewriter.c
 colo_filter_rewriter_debug(void) ""
-colo_filter_rewriter_pkt_info(const char *func, const char *src, const char *dst, uint32_t seq, uint32_t ack, uint32_t flag) "%s: src/dst: %s/%s p: seq/ack=%u/%u  flags=%x\n"
+colo_filter_rewriter_pkt_info(const char *func, const char *src, const char *dst, uint32_t seq, uint32_t ack, uint32_t flag) "%s: src/dst: %s/%s p: seq/ack=%u/%u  flags=0x%x\n"
 colo_filter_rewriter_conn_offset(uint32_t offset) ": offset=%u\n"
diff --git a/target/arm/trace-events b/target/arm/trace-events
index c4fcda59b4..9e37131115 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -1,10 +1,10 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
 # target/arm/helper.c
-arm_gt_recalc(int timer, int irqstate, uint64_t nexttick) "gt recalc: timer %d irqstate %d next tick %" PRIx64
+arm_gt_recalc(int timer, int irqstate, uint64_t nexttick) "gt recalc: timer %d irqstate %d next tick 0x%" PRIx64
 arm_gt_recalc_disabled(int timer) "gt recalc: timer %d irqstate 0 timer disabled"
-arm_gt_cval_write(int timer, uint64_t value) "gt_cval_write: timer %d value %" PRIx64
-arm_gt_tval_write(int timer, uint64_t value) "gt_tval_write: timer %d value %" PRIx64
-arm_gt_ctl_write(int timer, uint64_t value) "gt_ctl_write: timer %d value %" PRIx64
+arm_gt_cval_write(int timer, uint64_t value) "gt_cval_write: timer %d value 0x%" PRIx64
+arm_gt_tval_write(int timer, uint64_t value) "gt_tval_write: timer %d value 0x%" PRIx64
+arm_gt_ctl_write(int timer, uint64_t value) "gt_ctl_write: timer %d value 0x%" PRIx64
 arm_gt_imask_toggle(int timer, int irqstate) "gt_ctl_write: timer %d IMASK toggle, new irqstate %d"
-arm_gt_cntvoff_write(uint64_t value) "gt_cntvoff_write: value %" PRIx64
+arm_gt_cntvoff_write(uint64_t value) "gt_cntvoff_write: value 0x%" PRIx64
diff --git a/target/s390x/trace-events b/target/s390x/trace-events
index 852a248d66..4d871f5087 100644
--- a/target/s390x/trace-events
+++ b/target/s390x/trace-events
@@ -8,7 +8,7 @@ set_skeys_nonzero(int rc) "SKEY: Call to set_skeys unexpectedly returned %d"
 ioinst(const char *insn) "IOINST: %s"
 ioinst_sch_id(const char *insn, int cssid, int ssid, int schid) "IOINST: %s (%x.%x.%04x)"
 ioinst_chp_id(const char *insn, int cssid, int chpid) "IOINST: %s (%x.%02x)"
-ioinst_chsc_cmd(uint16_t cmd, uint16_t len) "IOINST: chsc command %04x, len %04x"
+ioinst_chsc_cmd(uint16_t cmd, uint16_t len) "IOINST: chsc command 0x%04x, len 0x%04x"
 
 # target/s390x/kvm.c
 kvm_enable_cmma(int rc) "CMMA: enabling with result code %d"
diff --git a/target/sparc/trace-events b/target/sparc/trace-events
index 8d1ed1b913..764b1e5a02 100644
--- a/target/sparc/trace-events
+++ b/target/sparc/trace-events
@@ -1,28 +1,28 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
 # target/sparc/mmu_helper.c
-mmu_helper_dfault(uint64_t address, uint64_t context, int mmu_idx, uint32_t tl) "DFAULT at %"PRIx64" context %"PRIx64" mmu_idx=%d tl=%d"
-mmu_helper_dprot(uint64_t address, uint64_t context, int mmu_idx, uint32_t tl) "DPROT at %"PRIx64" context %"PRIx64" mmu_idx=%d tl=%d"
-mmu_helper_dmiss(uint64_t address, uint64_t context) "DMISS at %"PRIx64" context %"PRIx64
-mmu_helper_tfault(uint64_t address, uint64_t context) "TFAULT at %"PRIx64" context %"PRIx64
-mmu_helper_tmiss(uint64_t address, uint64_t context) "TMISS at %"PRIx64" context %"PRIx64
-mmu_helper_get_phys_addr_code(uint32_t tl, int mmu_idx, uint64_t prim_context, uint64_t sec_context, uint64_t address) "tl=%d mmu_idx=%d primary context=%"PRIx64" secondary context=%"PRIx64" address=%"PRIx64
-mmu_helper_get_phys_addr_data(uint32_t tl, int mmu_idx, uint64_t prim_context, uint64_t sec_context, uint64_t address) "tl=%d mmu_idx=%d primary context=%"PRIx64" secondary context=%"PRIx64" address=%"PRIx64
-mmu_helper_mmu_fault(uint64_t address, uint64_t paddr, int mmu_idx, uint32_t tl, uint64_t prim_context, uint64_t sec_context) "Translate at %"PRIx64" -> %"PRIx64", mmu_idx=%d tl=%d primary context=%"PRIx64" secondary context=%"PRIx64
+mmu_helper_dfault(uint64_t address, uint64_t context, int mmu_idx, uint32_t tl) "DFAULT at 0x%"PRIx64" context 0x%"PRIx64" mmu_idx=%d tl=%d"
+mmu_helper_dprot(uint64_t address, uint64_t context, int mmu_idx, uint32_t tl) "DPROT at 0x%"PRIx64" context 0x%"PRIx64" mmu_idx=%d tl=%d"
+mmu_helper_dmiss(uint64_t address, uint64_t context) "DMISS at 0x%"PRIx64" context 0x%"PRIx64
+mmu_helper_tfault(uint64_t address, uint64_t context) "TFAULT at 0x%"PRIx64" context 0x%"PRIx64
+mmu_helper_tmiss(uint64_t address, uint64_t context) "TMISS at 0x%"PRIx64" context 0x%"PRIx64
+mmu_helper_get_phys_addr_code(uint32_t tl, int mmu_idx, uint64_t prim_context, uint64_t sec_context, uint64_t address) "tl=%d mmu_idx=%d primary context=0x%"PRIx64" secondary context=0x%"PRIx64" address=0x%"PRIx64
+mmu_helper_get_phys_addr_data(uint32_t tl, int mmu_idx, uint64_t prim_context, uint64_t sec_context, uint64_t address) "tl=%d mmu_idx=%d primary context=0x%"PRIx64" secondary context=0x%"PRIx64" address=0x%"PRIx64
+mmu_helper_mmu_fault(uint64_t address, uint64_t paddr, int mmu_idx, uint32_t tl, uint64_t prim_context, uint64_t sec_context) "Translate at 0x%"PRIx64" -> 0x%"PRIx64", mmu_idx=%d tl=%d primary context=0x%"PRIx64" secondary context=0x%"PRIx64
 
 # target/sparc/int64_helper.c
-int_helper_set_softint(uint32_t softint) "new %08x"
-int_helper_clear_softint(uint32_t softint) "new %08x"
-int_helper_write_softint(uint32_t softint) "new %08x"
+int_helper_set_softint(uint32_t softint) "new 0x%08x"
+int_helper_clear_softint(uint32_t softint) "new 0x%08x"
+int_helper_write_softint(uint32_t softint) "new 0x%08x"
 
 # target/sparc/int32_helper.c
 int_helper_icache_freeze(void) "Instruction cache: freeze"
 int_helper_dcache_freeze(void) "Data cache: freeze"
 
 # target/sparc/win_helper.c
-win_helper_gregset_error(uint32_t pstate) "ERROR in get_gregset: active pstate bits=%x"
-win_helper_switch_pstate(uint32_t pstate_regs, uint32_t new_pstate_regs) "change_pstate: switching regs old=%x new=%x"
-win_helper_no_switch_pstate(uint32_t new_pstate_regs) "change_pstate: regs new=%x (unchanged)"
-win_helper_wrpil(uint32_t psrpil, uint32_t new_pil) "old=%x new=%x"
+win_helper_gregset_error(uint32_t pstate) "ERROR in get_gregset: active pstate bits=0x%x"
+win_helper_switch_pstate(uint32_t pstate_regs, uint32_t new_pstate_regs) "change_pstate: switching regs old=0x%x new=0x%x"
+win_helper_no_switch_pstate(uint32_t new_pstate_regs) "change_pstate: regs new=0x%x (unchanged)"
+win_helper_wrpil(uint32_t psrpil, uint32_t new_pil) "old=0x%x new=0x%x"
 win_helper_done(uint32_t tl) "tl=%d"
 win_helper_retry(uint32_t tl) "tl=%d"
-- 
2.11.1
