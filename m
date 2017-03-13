Received: from eggs.gnu.org ([2001:4830:134:3::10]:43199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4t-0000yy-Az
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4r-0002eJ-9m
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnW4r-0002dx-18
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:21 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 230FD65383
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 19:56:21 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 13 Mar 2017 14:55:44 -0500
Message-Id: <20170313195547.21466-28-eblake@redhat.com>
In-Reply-To: <20170313195547.21466-1-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 27/30] trace: Fix parameter types in hw/usb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

An upcoming patch will let the compiler warn us when we are silently
losing precision in traces; update the trace definitions to pass
through the full value at the callsite, as well as updating a couple
of callers to use consistent typing to common trace calls.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 hw/usb/hcd-ehci.c   |  9 +++---
 hw/usb/hcd-xhci.c   |  4 +--
 hw/usb/trace-events | 84 ++++++++++++++++++++++++++---------------------------
 3 files changed, 49 insertions(+), 48 deletions(-)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 50ef817..43ba980 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -924,10 +924,11 @@ static uint64_t ehci_port_read(void *ptr, hwaddr addr,
                                unsigned size)
 {
     EHCIState *s = ptr;
+    int port = addr >> 2;
     uint32_t val;

-    val = s->portsc[addr >> 2];
-    trace_usb_ehci_portsc_read(addr + s->portscbase, addr >> 2, val);
+    val = s->portsc[port];
+    trace_usb_ehci_portsc_read(addr + s->portscbase, port, val);
     return val;
 }

@@ -968,7 +969,7 @@ static void ehci_port_write(void *ptr, hwaddr addr,
     uint32_t old = *portsc;
     USBDevice *dev = s->ports[port].dev;

-    trace_usb_ehci_portsc_write(addr + s->portscbase, addr >> 2, val);
+    trace_usb_ehci_portsc_write(addr + s->portscbase, port, val);

     /* Clear rwc bits */
     *portsc &= ~(val & PORTSC_RWC_MASK);
@@ -1009,7 +1010,7 @@ static void ehci_port_write(void *ptr, hwaddr addr,

     *portsc &= ~PORTSC_RO_MASK;
     *portsc |= val;
-    trace_usb_ehci_portsc_change(addr + s->portscbase, addr >> 2, *portsc, old);
+    trace_usb_ehci_portsc_change(addr + s->portscbase, port, *portsc, old);
 }

 static void ehci_opreg_write(void *ptr, hwaddr addr,
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index f0af852..c74095d 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -2016,7 +2016,7 @@ static int xhci_submit(XHCIState *xhci, XHCITransfer *xfer, XHCIEPContext *epctx
         }
         break;
     default:
-        trace_usb_xhci_unimplemented("endpoint type", epctx->type);
+        trace_usb_xhci_unimplemented("endpoint type", (hwaddr) epctx->type);
         return -1;
     }

@@ -2742,7 +2742,7 @@ static void xhci_process_commands(XHCIState *xhci)
             }
             break;
         default:
-            trace_usb_xhci_unimplemented("command", type);
+            trace_usb_xhci_unimplemented("command", (hwaddr) type);
             event.ccode = CC_TRB_ERROR;
             break;
         }
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index 0c323d4..ea0d1da 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -55,10 +55,10 @@ usb_ohci_ed_read_error(uint32_t addr) "ED read error at %x"
 usb_ohci_ed_pkt(uint32_t cur, int h, int c, uint32_t head, uint32_t tail, uint32_t next) "ED @ 0x%.8x h=%u c=%u\n  head=0x%.8x tailp=0x%.8x next=0x%.8x"
 usb_ohci_ed_pkt_flags(uint32_t fa, uint32_t en, uint32_t d, int s, int k, int f, uint32_t mps) "fa=%u en=%u d=%u s=%u k=%u f=%u mps=%u"
 usb_ohci_hcca_read_error(uint32_t addr) "HCCA read error at %x"
-usb_ohci_mem_read_unaligned(uint32_t addr) "at %x"
-usb_ohci_mem_read_bad_offset(uint32_t addr) "%x"
-usb_ohci_mem_write_unaligned(uint32_t addr) "at %x"
-usb_ohci_mem_write_bad_offset(uint32_t addr) "%x"
+usb_ohci_mem_read_unaligned(hwaddr addr) "at %" HWADDR_PRIx
+usb_ohci_mem_read_bad_offset(hwaddr addr) "%" HWADDR_PRIx
+usb_ohci_mem_write_unaligned(hwaddr addr) "at %" HWADDR_PRIx
+usb_ohci_mem_write_bad_offset(hwaddr addr) "%" HWADDR_PRIx
 usb_ohci_process_lists(uint32_t head, uint32_t cur) "head %x, cur %x"
 usb_ohci_set_frame_interval(const char *name, uint16_t fi_x, uint16_t fi_u) "%s: FrameInterval = 0x%x (%u)"
 usb_ohci_hub_power_up(void) "powered up all ports"
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
+usb_ehci_opreg_read(hwaddr addr, const char *str, uint32_t val) "rd mmio %04" HWADDR_PRIx " [%s] = %x"
+usb_ehci_opreg_write(hwaddr addr, const char *str, uint64_t val) "wr mmio %04" HWADDR_PRIx " [%s] = %" PRIx64
+usb_ehci_opreg_change(hwaddr addr, const char *str, uint32_t new, uint32_t old) "ch mmio %04" HWADDR_PRIx " [%s] = %x (old: %x)"
+usb_ehci_portsc_read(hwaddr addr, int port, uint32_t val) "rd mmio %04" HWADDR_PRIx " [port %d] = %x"
+usb_ehci_portsc_write(hwaddr addr, int port, uint64_t val) "wr mmio %04" HWADDR_PRIx " [port %d] = %" PRIx64
+usb_ehci_portsc_change(hwaddr addr, uint32_t port, uint32_t new, uint32_t old) "ch mmio %04" HWADDR_PRIx " [port %d] = %x (old: %x)"
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
+usb_ehci_qh_ptrs(void *q, hwaddr addr, uint32_t nxt, uint32_t c_qtd, uint32_t n_qtd, uint32_t a_qtd) "q %p - QH @ %08" HWADDR_PRIx ": next %08x qtds %08x,%08x,%08x"
+usb_ehci_qh_fields(hwaddr addr, int rl, int mplen, int eps, int ep, int devaddr) "QH @ %08" HWADDR_PRIx " - rl %d, mplen %d, eps %d, ep %d, dev %d"
+usb_ehci_qh_bits(hwaddr addr, int c, int h, int dtc, int i) "QH @ %08" HWADDR_PRIx " - c %d, h %d, dtc %d, i %d"
+usb_ehci_qtd_ptrs(void *q, hwaddr addr, uint32_t nxt, uint32_t altnext) "q %p - QTD @ %08" HWADDR_PRIx ": next %08x altnext %08x"
+usb_ehci_qtd_fields(hwaddr addr, int tbytes, int cpage, int cerr, int pid) "QTD @ %08" HWADDR_PRIx " - tbytes %d, cpage %d, cerr %d, pid %d"
+usb_ehci_qtd_bits(hwaddr addr, int ioc, int active, int halt, int babble, int xacterr) "QTD @ %08" HWADDR_PRIx " - ioc %d, active %d, halt %d, babble %d, xacterr %d"
+usb_ehci_itd(hwaddr addr, uint32_t nxt, uint32_t mplen, uint32_t mult, uint32_t ep, uint32_t devaddr) "ITD @ %08" HWADDR_PRIx ": next %08x - mplen %d, mult %d, ep %d, dev %d"
+usb_ehci_sitd(hwaddr addr, uint32_t nxt, uint32_t active) "ITD @ %08" HWADDR_PRIx ": next %08x - active %d"
 usb_ehci_port_attach(uint32_t port, const char *owner, const char *device) "attach port #%d, owner %s, device %s"
 usb_ehci_port_detach(uint32_t port, const char *owner) "detach port #%d, owner %s"
 usb_ehci_port_reset(uint32_t port, int enable) "reset port #%d - %d"
@@ -109,8 +109,8 @@ usb_uhci_frame_start(uint32_t num) "nr %d"
 usb_uhci_frame_stop_bandwidth(void) ""
 usb_uhci_frame_loop_stop_idle(void) ""
 usb_uhci_frame_loop_continue(void) ""
-usb_uhci_mmio_readw(uint32_t addr, uint32_t val) "addr 0x%04x, ret 0x%04x"
-usb_uhci_mmio_writew(uint32_t addr, uint32_t val) "addr 0x%04x, val 0x%04x"
+usb_uhci_mmio_readw(hwaddr addr, uint32_t val) "addr 0x%04" HWADDR_PRIx ", ret 0x%04x"
+usb_uhci_mmio_writew(hwaddr addr, uint64_t val) "addr 0x%04" HWADDR_PRIx ", val 0x%04" PRIx64
 usb_uhci_queue_add(uint32_t token) "token 0x%x"
 usb_uhci_queue_del(uint32_t token, const char *reason) "token 0x%x: %s"
 usb_uhci_packet_add(uint32_t token, uint32_t addr) "token 0x%x, td 0x%x"
@@ -135,15 +135,15 @@ usb_xhci_reset(void) "=== RESET ==="
 usb_xhci_exit(void) "=== EXIT ==="
 usb_xhci_run(void) ""
 usb_xhci_stop(void) ""
-usb_xhci_cap_read(uint32_t off, uint32_t val) "off 0x%04x, ret 0x%08x"
-usb_xhci_oper_read(uint32_t off, uint32_t val) "off 0x%04x, ret 0x%08x"
-usb_xhci_port_read(uint32_t port, uint32_t off, uint32_t val) "port %d, off 0x%04x, ret 0x%08x"
-usb_xhci_runtime_read(uint32_t off, uint32_t val) "off 0x%04x, ret 0x%08x"
-usb_xhci_doorbell_read(uint32_t off, uint32_t val) "off 0x%04x, ret 0x%08x"
-usb_xhci_oper_write(uint32_t off, uint32_t val) "off 0x%04x, val 0x%08x"
-usb_xhci_port_write(uint32_t port, uint32_t off, uint32_t val) "port %d, off 0x%04x, val 0x%08x"
-usb_xhci_runtime_write(uint32_t off, uint32_t val) "off 0x%04x, val 0x%08x"
-usb_xhci_doorbell_write(uint32_t off, uint32_t val) "off 0x%04x, val 0x%08x"
+usb_xhci_cap_read(hwaddr off, uint32_t val) "off 0x%04" HWADDR_PRIx ", ret 0x%08x"
+usb_xhci_oper_read(hwaddr off, uint32_t val) "off 0x%04" HWADDR_PRIx ", ret 0x%08x"
+usb_xhci_port_read(uint32_t port, hwaddr off, uint32_t val) "port %d, off 0x%04" HWADDR_PRIx ", ret 0x%08x"
+usb_xhci_runtime_read(hwaddr off, uint32_t val) "off 0x%04" HWADDR_PRIx ", ret 0x%08x"
+usb_xhci_doorbell_read(hwaddr off, uint32_t val) "off 0x%04" HWADDR_PRIx ", ret 0x%08x"
+usb_xhci_oper_write(hwaddr off, uint64_t val) "off 0x%04" HWADDR_PRIx ", val 0x%08" PRIx64
+usb_xhci_port_write(uint32_t port, hwaddr off, uint64_t val) "port %d, off 0x%04" HWADDR_PRIx ", val 0x%08" PRIx64
+usb_xhci_runtime_write(hwaddr off, uint64_t val) "off 0x%04" HWADDR_PRIx ", val 0x%08" PRIx64
+usb_xhci_doorbell_write(hwaddr off, uint64_t val) "off 0x%04" HWADDR_PRIx ", val 0x%08" PRIx64
 usb_xhci_irq_intx(uint32_t level) "level %d"
 usb_xhci_irq_msi(uint32_t nr) "nr %d"
 usb_xhci_irq_msix(uint32_t nr) "nr %d"
@@ -173,16 +173,16 @@ usb_xhci_xfer_nak(void *xfer) "%p"
 usb_xhci_xfer_retry(void *xfer) "%p"
 usb_xhci_xfer_success(void *xfer, uint32_t bytes) "%p: len %d"
 usb_xhci_xfer_error(void *xfer, uint32_t ret) "%p: ret %d"
-usb_xhci_unimplemented(const char *item, int nr) "%s (0x%x)"
+usb_xhci_unimplemented(const char *item, hwaddr nr) "%s (0x%" HWADDR_PRIx ")"
 usb_xhci_enforced_limit(const char *item) "%s"

 # hw/usb/desc.c
-usb_desc_device(int addr, int len, int ret) "dev %d query device, len %d, ret %d"
-usb_desc_device_qualifier(int addr, int len, int ret) "dev %d query device qualifier, len %d, ret %d"
-usb_desc_config(int addr, int index, int len, int ret) "dev %d query config %d, len %d, ret %d"
-usb_desc_other_speed_config(int addr, int index, int len, int ret) "dev %d query config %d, len %d, ret %d"
-usb_desc_string(int addr, int index, int len, int ret) "dev %d query string %d, len %d, ret %d"
-usb_desc_bos(int addr, int len, int ret) "dev %d bos, len %d, ret %d"
+usb_desc_device(int addr, size_t len, int ret) "dev %d query device, len %zd, ret %d"
+usb_desc_device_qualifier(int addr, size_t len, int ret) "dev %d query device qualifier, len %zd, ret %d"
+usb_desc_config(int addr, int index, size_t len, int ret) "dev %d query config %d, len %zd, ret %d"
+usb_desc_other_speed_config(int addr, int index, size_t len, int ret) "dev %d query config %d, len %zd, ret %d"
+usb_desc_string(int addr, int index, size_t len, int ret) "dev %d query string %d, len %zd, ret %d"
+usb_desc_bos(int addr, size_t len, int ret) "dev %d bos, len %zd, ret %d"
 usb_desc_msos(int addr, int index, int len, int ret) "dev %d msos, index 0x%x, len %d, ret %d"
 usb_set_addr(int addr) "dev %d"
 usb_set_config(int addr, int config, int ret) "dev %d, config %d, ret %d"
@@ -202,14 +202,14 @@ usb_hub_status_report(int addr, int status) "dev %d, status 0x%x"

 # hw/usb/dev-uas.c
 usb_uas_reset(int addr) "dev %d"
-usb_uas_command(int addr, uint16_t tag, int lun, uint32_t lun64_1, uint32_t lun64_2) "dev %d, tag 0x%x, lun %d, lun64 %08x-%08x"
+usb_uas_command(int addr, uint16_t tag, int lun, uint64_t lun64_1, uint64_t lun64_2) "dev %d, tag 0x%x, lun %d, lun64 %08" PRIx64 "-%08" PRIx64
 usb_uas_response(int addr, uint16_t tag, uint8_t code) "dev %d, tag 0x%x, code 0x%x"
 usb_uas_sense(int addr, uint16_t tag, uint8_t status) "dev %d, tag 0x%x, status 0x%x"
 usb_uas_read_ready(int addr, uint16_t tag) "dev %d, tag 0x%x"
 usb_uas_write_ready(int addr, uint16_t tag) "dev %d, tag 0x%x"
-usb_uas_xfer_data(int addr, uint16_t tag, uint32_t copy, uint32_t uoff, uint32_t usize, uint32_t soff, uint32_t ssize) "dev %d, tag 0x%x, copy %d, usb-pkt %d/%d, scsi-buf %d/%d"
+usb_uas_xfer_data(int addr, uint16_t tag, uint32_t copy, uint32_t uoff, size_t usize, uint32_t soff, uint32_t ssize) "dev %d, tag 0x%x, copy %d, usb-pkt %d/%zd, scsi-buf %d/%d"
 usb_uas_scsi_data(int addr, uint16_t tag, uint32_t bytes) "dev %d, tag 0x%x, bytes %d"
-usb_uas_scsi_complete(int addr, uint16_t tag, uint32_t status, uint32_t resid) "dev %d, tag 0x%x, status 0x%x, residue %d"
+usb_uas_scsi_complete(int addr, uint16_t tag, uint32_t status, size_t resid) "dev %d, tag 0x%x, status 0x%x, residue %zd"
 usb_uas_tmf_abort_task(int addr, uint16_t tag, uint16_t task_tag) "dev %d, tag 0x%x, task-tag 0x%x"
 usb_uas_tmf_logical_unit_reset(int addr, uint16_t tag, int lun) "dev %d, tag 0x%x, lun %d"
 usb_uas_tmf_unsupported(int addr, uint16_t tag, uint32_t function) "dev %d, tag 0x%x, function 0x%x"
@@ -219,8 +219,8 @@ usb_mtp_reset(int addr) "dev %d"
 usb_mtp_command(int dev, uint16_t code, uint32_t trans, uint32_t arg0, uint32_t arg1, uint32_t arg2, uint32_t arg3, uint32_t arg4) "dev %d, code 0x%x, trans 0x%x, args 0x%x, 0x%x, 0x%x, 0x%x, 0x%x"
 usb_mtp_success(int dev, uint32_t trans, uint32_t arg0, uint32_t arg1) "dev %d, trans 0x%x, args 0x%x, 0x%x"
 usb_mtp_error(int dev, uint16_t code, uint32_t trans, uint32_t arg0, uint32_t arg1) "dev %d, code 0x%x, trans 0x%x, args 0x%x, 0x%x"
-usb_mtp_data_in(int dev, uint32_t trans, uint32_t len) "dev %d, trans 0x%x, len %d"
-usb_mtp_xfer(int dev, uint32_t ep, uint32_t dlen, uint32_t plen) "dev %d, ep %d, %d/%d"
+usb_mtp_data_in(int dev, uint32_t trans, uint64_t len) "dev %d, trans 0x%x, len %" PRId64
+usb_mtp_xfer(int dev, uint32_t ep, uint32_t dlen, size_t plen) "dev %d, ep %d, %d/%zd"
 usb_mtp_nak(int dev, uint32_t ep) "dev %d, ep %d"
 usb_mtp_stall(int dev, const char *reason) "dev %d, reason: %s"
 usb_mtp_op_get_device_info(int dev) "dev %d"
@@ -252,7 +252,7 @@ usb_host_set_interface(int bus, int addr, int interface, int alt) "dev %d:%d, in
 usb_host_claim_interface(int bus, int addr, int config, int interface) "dev %d:%d, config %d, if %d"
 usb_host_release_interface(int bus, int addr, int interface) "dev %d:%d, if %d"
 usb_host_req_control(int bus, int addr, void *p, int req, int value, int index) "dev %d:%d, packet %p, req 0x%x, value %d, index %d"
-usb_host_req_data(int bus, int addr, void *p, int in, int ep, int size) "dev %d:%d, packet %p, in %d, ep %d, size %d"
+usb_host_req_data(int bus, int addr, void *p, int in, int ep, size_t size) "dev %d:%d, packet %p, in %d, ep %d, size %zd"
 usb_host_req_complete(int bus, int addr, void *p, int status, int length) "dev %d:%d, packet %p, status %d, length %d"
 usb_host_req_emulated(int bus, int addr, void *p, int status) "dev %d:%d, packet %p, status %d"
 usb_host_req_canceled(int bus, int addr, void *p) "dev %d:%d, packet %p"
-- 
2.9.3
