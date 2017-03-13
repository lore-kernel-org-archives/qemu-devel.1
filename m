Received: from eggs.gnu.org ([2001:4830:134:3::10]:43247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4v-00012B-O3
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4t-0002fx-Hg
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:25 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 13 Mar 2017 14:55:42 -0500
Message-Id: <20170313195547.21466-26-eblake@redhat.com>
In-Reply-To: <20170313195547.21466-1-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 25/30] trace: Fix parameter types in hw/scsi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Hannes Reinecke <hare@suse.de>, "open list:megasas" <qemu-block@nongnu.org>

An upcoming patch will let the compiler warn us when we are silently
losing precision in traces; update the trace definitions to pass
through the full value at the callsite.  Also update some callers
to avoid variable-sized dma_addr_t (which cannot be easily used in
trace headers) and needless casts for values used in tracing.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 hw/scsi/esp-pci.c    |   2 +-
 hw/scsi/megasas.c    |   8 ++--
 hw/scsi/trace-events | 114 +++++++++++++++++++++++++--------------------------
 3 files changed, 63 insertions(+), 61 deletions(-)

diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index e295d88..b0f4231 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -206,7 +206,7 @@ static void esp_pci_io_write(void *opaque, hwaddr addr,
         trace_esp_pci_sbac_write(pci->sbac, val);
         pci->sbac = val;
     } else {
-        trace_esp_pci_error_invalid_write((int)addr);
+        trace_esp_pci_error_invalid_write(addr);
     }
 }

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 84b8caf..c060a79 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -271,7 +271,8 @@ static int megasas_map_sgl(MegasasState *s, MegasasCmd *cmd, union mfi_sgl *sgl)
     }
     pci_dma_sglist_init(&cmd->qsg, PCI_DEVICE(s), iov_count);
     for (i = 0; i < iov_count; i++) {
-        dma_addr_t iov_pa, iov_size_p;
+        dma_addr_t iov_pa;
+        uint32_t iov_size_p;

         if (!sgl) {
             trace_megasas_iovec_sgl_underflow(cmd->index, i);
@@ -658,7 +659,7 @@ static int megasas_init_firmware(MegasasState *s, MegasasCmd *cmd)
     if (flags & MFI_QUEUE_FLAG_CONTEXT64) {
         s->flags |= MEGASAS_MASK_USE_QUEUE64;
     }
-    trace_megasas_init_queue((unsigned long)s->reply_queue_pa,
+    trace_megasas_init_queue(s->reply_queue_pa,
                              s->reply_queue_len, s->reply_queue_head,
                              s->reply_queue_tail, flags);
     megasas_reset_frames(s);
@@ -945,7 +946,8 @@ static int megasas_dcmd_pd_get_list(MegasasState *s, MegasasCmd *cmd)
     struct mfi_pd_list info;
     size_t dcmd_size = sizeof(info);
     BusChild *kid;
-    uint32_t offset, dcmd_limit, num_pd_disks = 0, max_pd_disks;
+    size_t dcmd_limit;
+    uint32_t offset, num_pd_disks = 0, max_pd_disks;

     memset(&info, 0, dcmd_size);
     offset = 8;
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index 4a2e5d6..11842a1 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -8,7 +8,7 @@ scsi_req_data_canceled(int target, int lun, int tag, int len) "target %d lun %d
 scsi_req_dequeue(int target, int lun, int tag) "target %d lun %d tag %d"
 scsi_req_continue(int target, int lun, int tag) "target %d lun %d tag %d"
 scsi_req_continue_canceled(int target, int lun, int tag) "target %d lun %d tag %d"
-scsi_req_parsed(int target, int lun, int tag, int cmd, int mode, int xfer) "target %d lun %d tag %d command %d dir %d length %d"
+scsi_req_parsed(int target, int lun, int tag, int cmd, int mode, size_t xfer) "target %d lun %d tag %d command %d dir %d length %zd"
 scsi_req_parsed_lba(int target, int lun, int tag, int cmd, uint64_t lba) "target %d lun %d tag %d command %d lba %"PRIu64
 scsi_req_parse_bad(int target, int lun, int tag, int cmd) "target %d lun %d tag %d command %d"
 scsi_req_build_sense(int target, int lun, int tag, int key, int asc, int ascq) "target %d lun %d tag %d key %#02x asc %#02x ascq %#02x"
@@ -19,20 +19,20 @@ scsi_test_unit_ready(int target, int lun, int tag) "target %d lun %d tag %d"
 scsi_request_sense(int target, int lun, int tag) "target %d lun %d tag %d"

 # hw/scsi/mptsas.c
-mptsas_command_complete(void *dev, uint32_t ctx, uint32_t status, uint32_t resid) "dev %p context 0x%08x status %x resid %d"
-mptsas_diag_read(void *dev, uint32_t addr, uint32_t val) "dev %p addr 0x%08x value 0x%08x"
-mptsas_diag_write(void *dev, uint32_t addr, uint32_t val) "dev %p addr 0x%08x value 0x%08x"
+mptsas_command_complete(void *dev, uint32_t ctx, uint32_t status, size_t resid) "dev %p context 0x%08x status %x resid %zd"
+mptsas_diag_read(void *dev, hwaddr addr, uint32_t val) "dev %p addr 0x%08" HWADDR_PRIx " value 0x%08x"
+mptsas_diag_write(void *dev, hwaddr addr, uint64_t val) "dev %p addr 0x%08" HWADDR_PRIx " value 0x%08" PRIx64
 mptsas_irq_intx(void *dev, int level) "dev %p level %d"
 mptsas_irq_msi(void *dev) "dev %p "
-mptsas_mmio_read(void *dev, uint32_t addr, uint32_t val) "dev %p addr 0x%08x value 0x%x"
-mptsas_mmio_unhandled_read(void *dev, uint32_t addr) "dev %p addr 0x%08x"
-mptsas_mmio_unhandled_write(void *dev, uint32_t addr, uint32_t val) "dev %p addr 0x%08x value 0x%x"
-mptsas_mmio_write(void *dev, uint32_t addr, uint32_t val) "dev %p addr 0x%08x value 0x%x"
+mptsas_mmio_read(void *dev, hwaddr addr, uint32_t val) "dev %p addr 0x%08" HWADDR_PRIx " value 0x%x"
+mptsas_mmio_unhandled_read(void *dev, hwaddr addr) "dev %p addr 0x%08" HWADDR_PRIx
+mptsas_mmio_unhandled_write(void *dev, hwaddr addr, uint64_t val) "dev %p addr 0x%08" HWADDR_PRIx " value 0x%" PRIx64
+mptsas_mmio_write(void *dev, hwaddr addr, uint64_t val) "dev %p addr 0x%08" HWADDR_PRIx " value 0x%" PRIx64
 mptsas_process_message(void *dev, int msg, uint32_t ctx) "dev %p cmd %d context 0x%08x\n"
-mptsas_process_scsi_io_request(void *dev, int bus, int target, int lun, uint64_t len) "dev %p dev %d:%d:%d length %"PRIu64""
+mptsas_process_scsi_io_request(void *dev, int bus, int target, int lun, uint32_t len) "dev %p dev %d:%d:%d length %"PRIu32""
 mptsas_reset(void *dev) "dev %p "
-mptsas_scsi_overflow(void *dev, uint32_t ctx, uint64_t req, uint64_t found) "dev %p context 0x%08x: %"PRIu64"/%"PRIu64""
-mptsas_sgl_overflow(void *dev, uint32_t ctx, uint64_t req, uint64_t found) "dev %p context 0x%08x: %"PRIu64"/%"PRIu64""
+mptsas_scsi_overflow(void *dev, uint32_t ctx, uint64_t req, uint32_t found) "dev %p context 0x%08x: %"PRIu64"/%"PRIu32""
+mptsas_sgl_overflow(void *dev, uint32_t ctx, uint32_t req, uint64_t found) "dev %p context 0x%08x: %"PRIu32"/%"PRIu64""
 mptsas_unhandled_cmd(void *dev, uint32_t ctx, uint8_t msg_cmd) "dev %p context 0x%08x: Unhandled cmd %x"
 mptsas_unhandled_doorbell_cmd(void *dev, int cmd) "dev %p value 0x%08x"

@@ -42,56 +42,56 @@ mptsas_config_sas_phy(void *dev, int address, int port, int phy_handle, int dev_

 # hw/scsi/megasas.c
 megasas_init_firmware(uint64_t pa) "pa %" PRIx64 " "
-megasas_init_queue(uint64_t queue_pa, int queue_len, uint64_t head, uint64_t tail, uint32_t flags) "queue at %" PRIx64 " len %d head %" PRIx64 " tail %" PRIx64 " flags %x"
+megasas_init_queue(uint64_t queue_pa, int queue_len, int head, int tail, uint32_t flags) "queue at %" PRIx64 " len %d head %d tail %d flags %x"
 megasas_initq_map_failed(int frame) "scmd %d: failed to map queue"
 megasas_initq_mapped(uint64_t pa) "queue already mapped at %" PRIx64
 megasas_initq_mismatch(int queue_len, int fw_cmds) "queue size %d max fw cmds %d"
-megasas_qf_mapped(unsigned int index) "skip mapped frame %x"
-megasas_qf_new(unsigned int index, uint64_t frame) "frame %x addr %" PRIx64
-megasas_qf_busy(unsigned long pa) "all frames busy for frame %lx"
-megasas_qf_enqueue(unsigned int index, unsigned int count, uint64_t context, unsigned int head, unsigned int tail, int busy) "frame %x count %d context %" PRIx64 " head %x tail %x busy %d"
+megasas_qf_mapped(unsigned long index) "skip mapped frame %lx"
+megasas_qf_new(unsigned long index, uint64_t frame) "frame %lx addr %" PRIx64
+megasas_qf_busy(hwaddr pa) "all frames busy for frame %" HWADDR_PRIx
+megasas_qf_enqueue(uint32_t index, unsigned int count, uint64_t context, unsigned int head, unsigned int tail, int busy) "frame %" PRIx32 " count %d context %" PRIx64 " head %x tail %x busy %d"
 megasas_qf_update(unsigned int head, unsigned int tail, unsigned int busy) "head %x tail %x busy %d"
 megasas_qf_map_failed(int cmd, unsigned long frame) "scmd %d: frame %lu"
 megasas_qf_complete_noirq(uint64_t context) "context %" PRIx64 " "
 megasas_qf_complete(uint64_t context, unsigned int head, unsigned int tail, int busy) "context %" PRIx64 " head %x tail %x busy %d"
 megasas_frame_busy(uint64_t addr) "frame %" PRIx64 " busy"
 megasas_unhandled_frame_cmd(int cmd, uint8_t frame_cmd) "scmd %d: MFI cmd %x"
-megasas_handle_scsi(const char *frame, int bus, int dev, int lun, void *sdev, unsigned long size) "%s dev %x/%x/%x sdev %p xfer %lu"
+megasas_handle_scsi(const char *frame, int bus, int dev, int lun, void *sdev, size_t size) "%s dev %x/%x/%x sdev %p xfer %zu"
 megasas_scsi_target_not_present(const char *frame, int bus, int dev, int lun) "%s dev %x/%x/%x"
 megasas_scsi_invalid_cdb_len(const char *frame, int bus, int dev, int lun, int len) "%s dev %x/%x/%x invalid cdb len %d"
-megasas_iov_read_overflow(int cmd, int bytes, int len) "scmd %d: %d/%d bytes"
-megasas_iov_write_overflow(int cmd, int bytes, int len) "scmd %d: %d/%d bytes"
-megasas_iov_read_underflow(int cmd, int bytes, int len) "scmd %d: %d/%d bytes"
-megasas_iov_write_underflow(int cmd, int bytes, int len) "scmd %d: %d/%d bytes"
+megasas_iov_read_overflow(int cmd, int bytes, size_t len) "scmd %d: %d/%zd bytes"
+megasas_iov_write_overflow(int cmd, int bytes, size_t len) "scmd %d: %d/%zd bytes"
+megasas_iov_read_underflow(int cmd, int bytes, size_t len) "scmd %d: %d/%zd bytes"
+megasas_iov_write_underflow(int cmd, int bytes, size_t len) "scmd %d: %d/%zd bytes"
 megasas_scsi_req_alloc_failed(const char *frame, int dev, int lun) "%s dev %x/%x"
-megasas_scsi_read_start(int cmd, int len) "scmd %d: transfer %d bytes of data"
-megasas_scsi_write_start(int cmd, int len) "scmd %d: transfer %d bytes of data"
+megasas_scsi_read_start(int cmd, size_t len) "scmd %d: transfer %zd bytes of data"
+megasas_scsi_write_start(int cmd, size_t len) "scmd %d: transfer %zd bytes of data"
 megasas_scsi_nodata(int cmd) "scmd %d: no data to be transferred"
-megasas_scsi_complete(int cmd, uint32_t status, int len, int xfer) "scmd %d: status %x, len %u/%u"
-megasas_command_complete(int cmd, uint32_t status, uint32_t resid) "scmd %d: status %x, residual %d"
+megasas_scsi_complete(int cmd, uint32_t status, size_t len, size_t xfer) "scmd %d: status %x, len %zu/%zu"
+megasas_command_complete(int cmd, uint32_t status, size_t resid) "scmd %d: status %x, residual %zd"
 megasas_handle_io(int cmd, const char *frame, int dev, int lun, unsigned long lba, unsigned long count) "scmd %d: %s dev %x/%x lba %lx count %lu"
 megasas_io_target_not_present(int cmd, const char *frame, int dev, int lun) "scmd %d: %s dev 1/%x/%x LUN not present"
-megasas_io_read_start(int cmd, unsigned long lba, unsigned long count, unsigned long len) "scmd %d: start LBA %lx %lu blocks (%lu bytes)"
-megasas_io_write_start(int cmd, unsigned long lba, unsigned long count, unsigned long len) "scmd %d: start LBA %lx %lu blocks (%lu bytes)"
+megasas_io_read_start(int cmd, uint64_t lba, uint32_t count, int len) "scmd %d: start LBA %" PRIx64 " %" PRIu32 " blocks (%u bytes)"
+megasas_io_write_start(int cmd, uint64_t lba, uint32_t count, int len) "scmd %d: start LBA %" PRIx64 " %" PRIu32 " blocks (%u bytes)"
 megasas_io_complete(int cmd, uint32_t len) "scmd %d: %d bytes"
 megasas_iovec_sgl_overflow(int cmd, int index, int limit) "scmd %d: iovec count %d limit %d"
 megasas_iovec_sgl_underflow(int cmd, int index) "scmd %d: iovec count %d"
 megasas_iovec_sgl_invalid(int cmd, int index, uint64_t pa, uint32_t len) "scmd %d: element %d pa %" PRIx64 " len %u"
-megasas_iovec_overflow(int cmd, int len, int limit) "scmd %d: len %d limit %d"
-megasas_iovec_underflow(int cmd, int len, int limit) "scmd %d: len %d limit %d"
+megasas_iovec_overflow(int cmd, size_t len, size_t limit) "scmd %d: len %zd limit %zd"
+megasas_iovec_underflow(int cmd, size_t len, size_t limit) "scmd %d: len %zd limit %zd"
 megasas_handle_dcmd(int cmd, int opcode) "scmd %d: MFI DCMD opcode %x"
 megasas_finish_dcmd(int cmd, int size) "scmd %d: MFI DCMD wrote %d bytes"
 megasas_dcmd_req_alloc_failed(int cmd, const char *desc) "scmd %d: %s"
 megasas_dcmd_internal_submit(int cmd, const char *desc, int dev) "scmd %d: %s to dev %d"
 megasas_dcmd_internal_finish(int cmd, int opcode, int lun) "scmd %d: cmd %x lun %d"
 megasas_dcmd_internal_invalid(int cmd, int opcode) "scmd %d: DCMD %x"
-megasas_dcmd_unhandled(int cmd, int opcode, int len) "scmd %d: opcode %x, len %d"
+megasas_dcmd_unhandled(int cmd, int opcode, size_t len) "scmd %d: opcode %x, len %zd"
 megasas_dcmd_zero_sge(int cmd) "scmd %d: zero DCMD sge count"
 megasas_dcmd_invalid_sge(int cmd, int count) "scmd %d: DCMD sge count %d"
-megasas_dcmd_invalid_xfer_len(int cmd, unsigned long size, unsigned long max) "scmd %d: xfer len %ld, max %ld"
-megasas_dcmd_enter(int cmd, const char *dcmd, int len) "scmd %d: DCMD %s len %d"
-megasas_dcmd_dummy(int cmd, unsigned long size) "scmd %d: xfer len %ld"
-megasas_dcmd_set_fw_time(int cmd, unsigned long time) "scmd %d: Set FW time %lx"
+megasas_dcmd_invalid_xfer_len(int cmd, size_t size, size_t max) "scmd %d: xfer len %zd, max %zd"
+megasas_dcmd_enter(int cmd, const char *dcmd, size_t len) "scmd %d: DCMD %s len %zd"
+megasas_dcmd_dummy(int cmd, size_t size) "scmd %d: xfer len %zd"
+megasas_dcmd_set_fw_time(int cmd, uint64_t time) "scmd %d: Set FW time %" PRIx64
 megasas_dcmd_pd_get_list(int cmd, int num, int max, int offset) "scmd %d: DCMD PD get list: %d / %d PDs, size %d"
 megasas_dcmd_ld_get_list(int cmd, int num, int max) "scmd %d: DCMD LD get list: found %d / %d LDs"
 megasas_dcmd_ld_get_info(int cmd, int ld_id) "scmd %d: dev %d"
@@ -99,7 +99,7 @@ megasas_dcmd_ld_list_query(int cmd, int flags) "scmd %d: query flags %x"
 megasas_dcmd_pd_get_info(int cmd, int pd_id) "scmd %d: dev %d"
 megasas_dcmd_pd_list_query(int cmd, int flags) "scmd %d: query flags %x"
 megasas_dcmd_reset_ld(int cmd, int target_id) "scmd %d: dev %d"
-megasas_dcmd_unsupported(int cmd, unsigned long size) "scmd %d: set properties len %ld"
+megasas_dcmd_unsupported(int cmd, size_t size) "scmd %d: set properties len %zd"
 megasas_abort_frame(int cmd, int abort_cmd) "scmd %d: frame %x"
 megasas_abort_no_cmd(int cmd, uint64_t context) "scmd %d: no active command for frame context %" PRIx64
 megasas_abort_invalid_context(int cmd, uint64_t context, int abort_cmd) "scmd %d: invalid frame context %" PRIx64 " for abort frame %x"
@@ -114,9 +114,9 @@ megasas_intr_disabled(void) "Interrupts disabled"
 megasas_msix_enabled(int vector) "vector %d"
 megasas_msi_enabled(int vector) "vector %d"
 megasas_mmio_readl(const char *reg, uint32_t val) "reg %s: 0x%x"
-megasas_mmio_invalid_readl(unsigned long addr) "addr 0x%lx"
-megasas_mmio_writel(const char *reg, uint32_t val) "reg %s: 0x%x"
-megasas_mmio_invalid_writel(uint32_t addr, uint32_t val) "addr 0x%x: 0x%x"
+megasas_mmio_invalid_readl(hwaddr addr) "addr 0x%" HWADDR_PRIx
+megasas_mmio_writel(const char *reg, uint64_t val) "reg %s: 0x%" PRIx64
+megasas_mmio_invalid_writel(hwaddr addr, uint64_t val) "addr 0x%" HWADDR_PRIx ": 0x%" PRIx64

 # hw/scsi/vmw_pvscsi.c
 pvscsi_ring_init_data(uint32_t txr_len_log2, uint32_t rxr_len_log2) "TX/RX rings logarithms set to %d/%d"
@@ -155,8 +155,8 @@ pvscsi_tx_rings_num_pages(const char* label, uint32_t num) "Number of %s pages:

 # hw/scsi/esp.c
 esp_error_fifo_overrun(void) "FIFO overrun"
-esp_error_unhandled_command(uint32_t val) "unhandled command (%2.2x)"
-esp_error_invalid_write(uint32_t val, uint32_t addr) "invalid write of 0x%02x at [0x%x]"
+esp_error_unhandled_command(uint64_t val) "unhandled command (%2.2" PRIx64 ")"
+esp_error_invalid_write(uint64_t val, uint32_t addr) "invalid write of 0x%02" PRIx64 " at [0x%x]"
 esp_raise_irq(void) "Raise IRQ"
 esp_lower_irq(void) "Lower IRQ"
 esp_dma_enable(void) "Raise enable"
@@ -173,26 +173,26 @@ esp_transfer_data(uint32_t dma_left, int32_t ti_size) "transfer %d/%d"
 esp_handle_ti(uint32_t minlen) "Transfer Information len %d"
 esp_handle_ti_cmd(uint32_t cmdlen) "command len %d"
 esp_mem_readb(uint32_t saddr, uint8_t reg) "reg[%d]: 0x%2.2x"
-esp_mem_writeb(uint32_t saddr, uint8_t reg, uint32_t val) "reg[%d]: 0x%2.2x -> 0x%2.2x"
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
+esp_mem_writeb(uint32_t saddr, uint8_t reg, uint64_t val) "reg[%d]: 0x%2.2x -> 0x%2.2" PRIx64
+esp_mem_writeb_cmd_nop(uint64_t val) "NOP (%2.2" PRIx64 ")"
+esp_mem_writeb_cmd_flush(uint64_t val) "Flush FIFO (%2.2" PRIx64 ")"
+esp_mem_writeb_cmd_reset(uint64_t val) "Chip reset (%2.2" PRIx64 ")"
+esp_mem_writeb_cmd_bus_reset(uint64_t val) "Bus reset (%2.2" PRIx64 ")"
+esp_mem_writeb_cmd_iccs(uint64_t val) "Initiator Command Complete Sequence (%2.2" PRIx64 ")"
+esp_mem_writeb_cmd_msgacc(uint64_t val) "Message Accepted (%2.2" PRIx64 ")"
+esp_mem_writeb_cmd_pad(uint64_t val) "Transfer padding (%2.2" PRIx64 ")"
+esp_mem_writeb_cmd_satn(uint64_t val) "Set ATN (%2.2" PRIx64 ")"
+esp_mem_writeb_cmd_rstatn(uint64_t val) "Reset ATN (%2.2" PRIx64 ")"
+esp_mem_writeb_cmd_sel(uint64_t val) "Select without ATN (%2.2" PRIx64 ")"
+esp_mem_writeb_cmd_selatn(uint64_t val) "Select with ATN (%2.2" PRIx64 ")"
+esp_mem_writeb_cmd_selatns(uint64_t val) "Select with ATN & stop (%2.2" PRIx64 ")"
+esp_mem_writeb_cmd_ensel(uint64_t val) "Enable selection (%2.2" PRIx64 ")"
+esp_mem_writeb_cmd_dissel(uint64_t val) "Disable selection (%2.2" PRIx64 ")"

 # hw/scsi/esp-pci.c
 esp_pci_error_invalid_dma_direction(void) "invalid DMA transfer direction"
 esp_pci_error_invalid_read(uint32_t reg) "read access outside bounds (reg 0x%x)"
-esp_pci_error_invalid_write(uint32_t reg) "write access outside bounds (reg 0x%x)"
+esp_pci_error_invalid_write(hwaddr reg) "write access outside bounds (reg 0x%" HWADDR_PRIx ")"
 esp_pci_error_invalid_write_dma(uint32_t val, uint32_t addr) "invalid write of 0x%02x at [0x%x]"
 esp_pci_dma_read(uint32_t saddr, uint32_t reg) "reg[%d]: 0x%8.8x"
 esp_pci_dma_write(uint32_t saddr, uint32_t reg, uint32_t val) "reg[%d]: 0x%8.8x -> 0x%8.8x"
@@ -201,7 +201,7 @@ esp_pci_dma_blast(uint32_t val) "BLAST (%.8x)"
 esp_pci_dma_abort(uint32_t val) "ABORT (%.8x)"
 esp_pci_dma_start(uint32_t val) "START (%.8x)"
 esp_pci_sbac_read(uint32_t reg) "sbac: 0x%8.8x"
-esp_pci_sbac_write(uint32_t reg, uint32_t val) "sbac: 0x%8.8x -> 0x%8.8x"
+esp_pci_sbac_write(uint32_t reg, uint64_t val) "sbac: 0x%8.8x -> 0x%8.8" PRIx64

 # hw/scsi/spapr_vscsi.c
 spapr_vscsi_send_rsp(uint8_t status, int32_t res_in, int32_t res_out) "status: 0x%x, res_in: %"PRId32", res_out: %"PRId32
-- 
2.9.3
