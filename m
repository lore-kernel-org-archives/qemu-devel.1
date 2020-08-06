Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CCCC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 14:17:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE2123121
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 14:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2vCQDi9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE2123121
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3ghw-0008CI-8Y
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 10:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3geR-0003n9-BG
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 10:13:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58326
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3geO-0007QZ-2a
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 10:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596723223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z+JBq6ww2EPlwcfRXBoVS6vP6dVIQVpl9jXVrBlYsIQ=;
 b=F2vCQDi9EoRteEf/rQyS5Imx4znK3WkprI7ZuiVIKk7zTqrY7Bojp2Tclv6X8k5MnN+DdC
 GpgtUxnEACokZsJ1w1zEm9mcckEY05OlENdpryH3KOB2LvFKDvbOwYwRCUwUvf6AwCzBvm
 LfdQNBBVY0S1czUGVan8o1Oy/CLmZ48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-CgOLXFIrMkSTdVlkplcNeg-1; Thu, 06 Aug 2020 10:13:39 -0400
X-MC-Unique: CgOLXFIrMkSTdVlkplcNeg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2500D800469
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 14:13:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A177360BF1;
 Thu,  6 Aug 2020 14:13:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2C75410FDD9F; Thu,  6 Aug 2020 16:13:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] trace-events: Fix attribution of trace points to source
Date: Thu,  6 Aug 2020 16:13:34 +0200
Message-Id: <20200806141334.3646302-5-armbru@redhat.com>
In-Reply-To: <20200806141334.3646302-1-armbru@redhat.com>
References: <20200806141334.3646302-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: philmd@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some trace points are attributed to the wrong source file.  Happens
when we neglect to update trace-events for code motion, or add events
in the wrong place, or misspell the file name.

Clean up with help of scripts/cleanup-trace-events.pl.  Funnies
requiring manual post-processing:

* accel/tcg/cputlb.c trace points are in trace-events.

* block.c and blockdev.c trace points are in block/trace-events.

* hw/block/nvme.c uses the preprocessor to hide its trace point use
  from cleanup-trace-events.pl.

* hw/tpm/tpm_spapr.c uses pseudo trace point tpm_spapr_show_buffer to
  guard debug code.

* include/hw/xen/xen_common.h trace points are in hw/xen/trace-events.

* linux-user/trace-events abbreviates a tedious list of filenames to
  */signal.c.

* net/colo-compare and net/filter-rewriter.c use pseudo trace points
  colo_compare_miscompare and colo_filter_rewriter_debug to guard
  debug code.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/trace-events        |  5 ++---
 hw/block/trace-events     |  2 +-
 hw/char/trace-events      |  2 +-
 hw/display/trace-events   |  4 +++-
 hw/hyperv/trace-events    |  2 +-
 hw/mips/trace-events      |  2 +-
 hw/misc/trace-events      |  8 +++++---
 hw/ppc/trace-events       |  6 ++----
 hw/riscv/trace-events     |  2 +-
 hw/rtc/trace-events       |  2 +-
 hw/tpm/trace-events       |  2 +-
 hw/usb/trace-events       |  4 +++-
 hw/vfio/trace-events      | 10 ++++++----
 hw/virtio/trace-events    |  2 +-
 migration/trace-events    | 36 +++++++++++++++++++-----------------
 target/riscv/trace-events |  2 +-
 trace-events              |  5 +++--
 ui/trace-events           |  6 +++---
 util/trace-events         |  4 +++-
 19 files changed, 58 insertions(+), 48 deletions(-)

diff --git a/block/trace-events b/block/trace-events
index 778140d304..916c442277 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -58,12 +58,10 @@ qmp_block_job_finalize(void *job) "job %p"
 qmp_block_job_dismiss(void *job) "job %p"
 qmp_block_stream(void *bs) "bs %p"
 
-# file-posix.c
 # file-win32.c
 file_paio_submit(void *acb, void *opaque, int64_t offset, int count, int type) "acb %p opaque %p offset %"PRId64" count %d type %d"
-file_copy_file_range(void *bs, int src, int64_t src_off, int dst, int64_t dst_off, int64_t bytes, int flags, int64_t ret) "bs %p src_fd %d offset %"PRIu64" dst_fd %d offset %"PRIu64" bytes %"PRIu64" flags %d ret %"PRId64
 
-#io_uring.c
+# io_uring.c
 luring_init_state(void *s, size_t size) "s %p size %zu"
 luring_cleanup_state(void *s) "%p freed"
 luring_io_plug(void *s) "LuringState %p plug"
@@ -199,6 +197,7 @@ curl_setup_preadv(uint64_t bytes, uint64_t start, const char *range) "reading %"
 curl_close(void) "close"
 
 # file-posix.c
+file_copy_file_range(void *bs, int src, int64_t src_off, int dst, int64_t dst_off, int64_t bytes, int flags, int64_t ret) "bs %p src_fd %d offset %"PRIu64" dst_fd %d offset %"PRIu64" bytes %"PRIu64" flags %d ret %"PRId64
 file_FindEjectableOpticalMedia(const char *media) "Matching using %s"
 file_setup_cdrom(const char *partition) "Using %s as optical disc"
 file_hdev_is_sg(int type, int version) "SG device found: type=%d, version=%d"
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 958fcc5508..857ac5645e 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -4,8 +4,8 @@
 fdc_ioport_read(uint8_t reg, uint8_t value) "read reg 0x%02x val 0x%02x"
 fdc_ioport_write(uint8_t reg, uint8_t value) "write reg 0x%02x val 0x%02x"
 
-# pflash_cfi02.c
 # pflash_cfi01.c
+# pflash_cfi02.c
 pflash_reset(void) "reset"
 pflash_timer_expired(uint8_t cmd) "command 0x%02x done"
 pflash_io_read(uint64_t offset, unsigned size, uint32_t value, uint8_t cmd, uint8_t wcycle) "offset:0x%04"PRIx64" size:%u value:0x%04x cmd:0x%02x wcycle:%u"
diff --git a/hw/char/trace-events b/hw/char/trace-events
index d20eafd56f..2442a9f7d5 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -98,5 +98,5 @@ exynos_uart_rxsize(uint32_t channel, uint32_t size) "UART%d: Rx FIFO size: %d"
 exynos_uart_channel_error(uint32_t channel) "Wrong UART channel number: %d"
 exynos_uart_rx_timeout(uint32_t channel, uint32_t stat, uint32_t intsp) "UART%d: Rx timeout stat=0x%x intsp=0x%x"
 
-# hw/char/cadence_uart.c
+# cadence_uart.c
 cadence_uart_baudrate(unsigned baudrate) "baudrate %u"
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 970d6bac5d..957b8ba994 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -32,9 +32,11 @@ vmware_scratch_read(uint32_t index, uint32_t value) "index %d, value 0x%x"
 vmware_scratch_write(uint32_t index, uint32_t value) "index %d, value 0x%x"
 vmware_setmode(uint32_t w, uint32_t h, uint32_t bpp) "%dx%d @ %d bpp"
 
+# virtio-gpu-base.c
+virtio_gpu_features(bool virgl) "virgl %d"
+
 # virtio-gpu-3d.c
 # virtio-gpu.c
-virtio_gpu_features(bool virgl) "virgl %d"
 virtio_gpu_cmd_get_display_info(void) ""
 virtio_gpu_cmd_get_edid(uint32_t scanout) "scanout %d"
 virtio_gpu_cmd_set_scanout(uint32_t id, uint32_t res, uint32_t w, uint32_t h, uint32_t x, uint32_t y) "id %d, res 0x%x, w %d, h %d, x %d, y %d"
diff --git a/hw/hyperv/trace-events b/hw/hyperv/trace-events
index ba5bd62d61..b4c35ca8e3 100644
--- a/hw/hyperv/trace-events
+++ b/hw/hyperv/trace-events
@@ -1,4 +1,4 @@
-# vmbus
+# vmbus.c
 vmbus_recv_message(uint32_t type, uint32_t size) "type %d size %d"
 vmbus_signal_event(void) ""
 vmbus_channel_notify_guest(uint32_t chan_id) "channel #%d"
diff --git a/hw/mips/trace-events b/hw/mips/trace-events
index 321933283f..915139d981 100644
--- a/hw/mips/trace-events
+++ b/hw/mips/trace-events
@@ -1,4 +1,4 @@
-# gt64xxx.c
+# gt64xxx_pci.c
 gt64120_read(const char *regname, unsigned size, uint64_t value) "gt64120 read %s size:%u value:0x%08" PRIx64
 gt64120_write(const char *regname, unsigned size, uint64_t value) "gt64120 write %s size:%u value:0x%08" PRIx64
 gt64120_isd_remap(uint64_t from_length, uint64_t from_addr, uint64_t to_length, uint64_t to_addr) "ISD: 0x%08" PRIx64 "@0x%08" PRIx64 " -> 0x%08" PRIx64 "@0x%08" PRIx64
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index f9a0ba1a93..56a622d1e9 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -110,13 +110,13 @@ mos6522_set_sr_int(void) "set sr_int"
 mos6522_write(uint64_t addr, uint64_t val) "reg=0x%"PRIx64 " val=0x%"PRIx64
 mos6522_read(uint64_t addr, unsigned val) "reg=0x%"PRIx64 " val=0x%x"
 
-# stm32f4xx_syscfg
+# stm32f4xx_syscfg.c
 stm32f4xx_syscfg_set_irq(int gpio, int line, int level) "Interupt: GPIO: %d, Line: %d; Level: %d"
 stm32f4xx_pulse_exti(int irq) "Pulse EXTI: %d"
 stm32f4xx_syscfg_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
 stm32f4xx_syscfg_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
 
-# stm32f4xx_exti
+# stm32f4xx_exti.c
 stm32f4xx_exti_set_irq(int irq, int leve) "Set EXTI: %d to %d"
 stm32f4xx_exti_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
 stm32f4xx_exti_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
@@ -181,11 +181,13 @@ armsse_mhu_write(uint64_t offset, uint64_t data, unsigned size) "SSE-200 MHU wri
 # aspeed_xdma.c
 aspeed_xdma_write(uint64_t offset, uint64_t data) "XDMA write: offset 0x%" PRIx64 " data 0x%" PRIx64
 
+# bcm2835_property.c
+bcm2835_mbox_property(uint32_t tag, uint32_t bufsize, size_t resplen) "mbox property tag:0x%08x in_sz:%u out_sz:%zu"
+
 # bcm2835_mbox.c
 bcm2835_mbox_write(unsigned int size, uint64_t addr, uint64_t value) "mbox write sz:%u addr:0x%"PRIx64" data:0x%"PRIx64
 bcm2835_mbox_read(unsigned int size, uint64_t addr, uint64_t value) "mbox read sz:%u addr:0x%"PRIx64" data:0x%"PRIx64
 bcm2835_mbox_irq(unsigned level) "mbox irq:ARM level:%u"
-bcm2835_mbox_property(uint32_t tag, uint32_t bufsize, size_t resplen) "mbox property tag:0x%08x in_sz:%u out_sz:%zu"
 
 # mac_via.c
 via1_rtc_update_data_out(int count, int value) "count=%d value=0x%02x"
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index ca34244e2a..dcc06d49b5 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -9,10 +9,8 @@ spapr_pci_msi_write(uint64_t addr, uint64_t data, uint32_t dt_irq) "@0x%"PRIx64"
 spapr_pci_lsi_set(const char *busname, int pin, uint32_t irq) "%s PIN%d IRQ %u"
 spapr_pci_msi_retry(unsigned config_addr, unsigned req_num, unsigned max_irqs) "Guest device at 0x%x asked %u, have only %u"
 
-# spapr.c
-spapr_cas_continue(unsigned long n) "Copy changes to the guest: %ld bytes"
-
 # spapr_hcall.c
+spapr_cas_continue(unsigned long n) "Copy changes to the guest: %ld bytes"
 spapr_cas_pvr(uint32_t cur_pvr, bool explicit_match, uint32_t new_pvr) "current=0x%x, explicit_match=%u, new=0x%x"
 spapr_h_resize_hpt_prepare(uint64_t flags, uint64_t shift) "flags=0x%"PRIx64", shift=%"PRIu64
 spapr_h_resize_hpt_commit(uint64_t flags, uint64_t shift) "flags=0x%"PRIx64", shift=%"PRIu64
@@ -20,7 +18,7 @@ spapr_update_dt(unsigned cb) "New blob %u bytes"
 spapr_update_dt_failed_size(unsigned cbold, unsigned cbnew, unsigned magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
 spapr_update_dt_failed_check(unsigned cbold, unsigned cbnew, unsigned magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
 
-# spapr_hcall_tpm.c
+# spapr_tpm_proxy.c
 spapr_h_tpm_comm(const char *device_path, uint64_t operation) "tpm_device_path=%s operation=0x%"PRIu64
 spapr_tpm_execute(uint64_t data_in, uint64_t data_in_sz, uint64_t data_out, uint64_t data_out_sz) "data_in=0x%"PRIx64", data_in_sz=%"PRIu64", data_out=0x%"PRIx64", data_out_sz=%"PRIu64
 
diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
index 6d59233e23..b819878963 100644
--- a/hw/riscv/trace-events
+++ b/hw/riscv/trace-events
@@ -1,6 +1,6 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
-# hw/gpio/sifive_gpio.c
+# sifive_gpio.c
 sifive_gpio_read(uint64_t offset, uint64_t r) "offset 0x%" PRIx64 " value 0x%" PRIx64
 sifive_gpio_write(uint64_t offset, uint64_t value) "offset 0x%" PRIx64 " value 0x%" PRIx64
 sifive_gpio_set(int64_t line, int64_t value) "line %" PRIi64 " value %" PRIi64
diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
index 1bc7147d0e..8bdcf74264 100644
--- a/hw/rtc/trace-events
+++ b/hw/rtc/trace-events
@@ -18,7 +18,7 @@ pl031_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
 pl031_alarm_raised(void) "alarm raised"
 pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
 
-# aspeed-rtc.c
+# aspeed_rtc.c
 aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
 aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
 
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index de9bf1e01b..266de17d38 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -4,7 +4,7 @@
 tpm_crb_mmio_read(uint64_t addr, unsigned size, uint32_t val) "CRB read 0x%016" PRIx64 " len:%u val: 0x%" PRIx32
 tpm_crb_mmio_write(uint64_t addr, unsigned size, uint32_t val) "CRB write 0x%016" PRIx64 " len:%u val: 0x%" PRIx32
 
-# tpm_tis.c
+# tpm_tis_common.c
 tpm_tis_raise_irq(uint32_t irqmask) "Raising IRQ for flag 0x%08x"
 tpm_tis_new_active_locality(uint8_t locty) "Active locality is now %d"
 tpm_tis_abort(uint8_t locty) "New active locality is %d"
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index e9cdeeed14..72e4298780 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -10,6 +10,9 @@ usb_port_attach(int bus, const char *port, const char *devspeed, const char *por
 usb_port_detach(int bus, const char *port) "bus %d, port %s"
 usb_port_release(int bus, const char *port) "bus %d, port %s"
 
+# hcd-ohci-pci.c
+usb_ohci_exit(const char *s) "%s"
+
 # hcd-ohci.c
 usb_ohci_iso_td_read_failed(uint32_t addr) "ISO_TD read error at 0x%x"
 usb_ohci_iso_td_head(uint32_t head, uint32_t tail, uint32_t flags, uint32_t bp, uint32_t next, uint32_t be, uint32_t framenum, uint32_t startframe, uint32_t framecount, int rel_frame_num) "ISO_TD ED head 0x%.8x tailp 0x%.8x\n0x%.8x 0x%.8x 0x%.8x 0x%.8x\nframe_number 0x%.8x starting_frame 0x%.8x\nframe_count  0x%.8x relative %d"
@@ -35,7 +38,6 @@ usb_ohci_reset(const char *s) "%s"
 usb_ohci_start(const char *s) "%s: USB Operational"
 usb_ohci_resume(const char *s) "%s: USB Resume"
 usb_ohci_stop(const char *s) "%s: USB Suspended"
-usb_ohci_exit(const char *s) "%s"
 usb_ohci_set_ctl(const char *s, uint32_t new_state) "%s: new state 0x%x"
 usb_ohci_td_underrun(void) ""
 usb_ohci_td_dev_error(void) ""
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index b1ef55a33f..93a0bc2522 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -80,16 +80,18 @@ vfio_quirk_ati_bonaire_reset(const char *name) "%s"
 vfio_ioeventfd_exit(const char *name, uint64_t addr, unsigned size, uint64_t data) "%s+0x%"PRIx64"[%d]:0x%"PRIx64
 vfio_ioeventfd_handler(const char *name, uint64_t addr, unsigned size, uint64_t data) "%s+0x%"PRIx64"[%d] -> 0x%"PRIx64
 vfio_ioeventfd_init(const char *name, uint64_t addr, unsigned size, uint64_t data, bool vfio) "%s+0x%"PRIx64"[%d]:0x%"PRIx64" vfio:%d"
-vfio_pci_igd_bar4_write(const char *name, uint32_t index, uint32_t data, uint32_t base) "%s [0x%03x] 0x%08x -> 0x%08x"
-vfio_pci_igd_bdsm_enabled(const char *name, int size) "%s %dMB"
 vfio_pci_igd_opregion_enabled(const char *name) "%s"
-vfio_pci_igd_host_bridge_enabled(const char *name) "%s"
-vfio_pci_igd_lpc_bridge_enabled(const char *name) "%s"
 
 vfio_pci_nvidia_gpu_setup_quirk(const char *name, uint64_t tgt, uint64_t size) "%s tgt=0x%"PRIx64" size=0x%"PRIx64
 vfio_pci_nvlink2_setup_quirk_ssatgt(const char *name, uint64_t tgt, uint64_t size) "%s tgt=0x%"PRIx64" size=0x%"PRIx64
 vfio_pci_nvlink2_setup_quirk_lnkspd(const char *name, uint32_t link_speed) "%s link_speed=0x%x"
 
+# igd.c
+vfio_pci_igd_bar4_write(const char *name, uint32_t index, uint32_t data, uint32_t base) "%s [0x%03x] 0x%08x -> 0x%08x"
+vfio_pci_igd_bdsm_enabled(const char *name, int size) "%s %dMB"
+vfio_pci_igd_host_bridge_enabled(const char *name) "%s"
+vfio_pci_igd_lpc_bridge_enabled(const char *name) "%s"
+
 # common.c
 vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
 vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t data) " (%s:region%d+0x%"PRIx64", %d) = 0x%"PRIx64
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 045e89cae6..845200bf10 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -55,7 +55,7 @@ virtio_mmio_guest_page(uint64_t size, int shift) "guest page size 0x%" PRIx64 "
 virtio_mmio_queue_write(uint64_t value, int max_size) "mmio_queue write 0x%" PRIx64 " max %d"
 virtio_mmio_setting_irq(int level) "virtio_mmio setting IRQ %d"
 
-# hw/virtio/virtio-iommu.c
+# virtio-iommu.c
 virtio_iommu_device_reset(void) "reset!"
 virtio_iommu_get_features(uint64_t features) "device supports features=0x%"PRIx64
 virtio_iommu_device_status(uint8_t status) "driver status = %d"
diff --git a/migration/trace-events b/migration/trace-events
index 6f94106bfa..7ba2fa6644 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -91,23 +91,6 @@ migration_bitmap_sync_start(void) ""
 migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu64
 migration_bitmap_clear_dirty(char *str, uint64_t start, uint64_t size, unsigned long page) "rb %s start 0x%"PRIx64" size 0x%"PRIx64" page 0x%lx"
 migration_throttle(void) ""
-multifd_new_send_channel_async(uint8_t id) "channel %d"
-multifd_recv(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t flags, uint32_t next_packet_size) "channel %d packet_num %" PRIu64 " pages %d flags 0x%x next packet size %d"
-multifd_recv_new_channel(uint8_t id) "channel %d"
-multifd_recv_sync_main(long packet_num) "packet num %ld"
-multifd_recv_sync_main_signal(uint8_t id) "channel %d"
-multifd_recv_sync_main_wait(uint8_t id) "channel %d"
-multifd_recv_terminate_threads(bool error) "error %d"
-multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "channel %d packets %" PRIu64 " pages %" PRIu64
-multifd_recv_thread_start(uint8_t id) "%d"
-multifd_send(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t flags, uint32_t next_packet_size) "channel %d packet_num %" PRIu64 " pages %d flags 0x%x next packet size %d"
-multifd_send_error(uint8_t id) "channel %d"
-multifd_send_sync_main(long packet_num) "packet num %ld"
-multifd_send_sync_main_signal(uint8_t id) "channel %d"
-multifd_send_sync_main_wait(uint8_t id) "channel %d"
-multifd_send_terminate_threads(bool error) "error %d"
-multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "channel %d packets %" PRIu64 " pages %"  PRIu64
-multifd_send_thread_start(uint8_t id) "%d"
 ram_discard_range(const char *rbname, uint64_t start, size_t len) "%s: start: %" PRIx64 " %zx"
 ram_load_loop(const char *rbname, uint64_t addr, int flags, void *host) "%s: addr: 0x%" PRIx64 " flags: 0x%x host: %p"
 ram_load_postcopy_loop(uint64_t addr, int flags) "@%" PRIx64 " %x"
@@ -128,6 +111,25 @@ save_xbzrle_page_overflow(void) ""
 ram_save_iterate_big_wait(uint64_t milliconds, int iterations) "big wait: %" PRIu64 " milliseconds, %d iterations"
 ram_load_complete(int ret, uint64_t seq_iter) "exit_code %d seq iteration %" PRIu64
 
+# multifd.c
+multifd_new_send_channel_async(uint8_t id) "channel %d"
+multifd_recv(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t flags, uint32_t next_packet_size) "channel %d packet_num %" PRIu64 " pages %d flags 0x%x next packet size %d"
+multifd_recv_new_channel(uint8_t id) "channel %d"
+multifd_recv_sync_main(long packet_num) "packet num %ld"
+multifd_recv_sync_main_signal(uint8_t id) "channel %d"
+multifd_recv_sync_main_wait(uint8_t id) "channel %d"
+multifd_recv_terminate_threads(bool error) "error %d"
+multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "channel %d packets %" PRIu64 " pages %" PRIu64
+multifd_recv_thread_start(uint8_t id) "%d"
+multifd_send(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t flags, uint32_t next_packet_size) "channel %d packet_num %" PRIu64 " pages %d flags 0x%x next packet size %d"
+multifd_send_error(uint8_t id) "channel %d"
+multifd_send_sync_main(long packet_num) "packet num %ld"
+multifd_send_sync_main_signal(uint8_t id) "channel %d"
+multifd_send_sync_main_wait(uint8_t id) "channel %d"
+multifd_send_terminate_threads(bool error) "error %d"
+multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "channel %d packets %" PRIu64 " pages %"  PRIu64
+multifd_send_thread_start(uint8_t id) "%d"
+
 # migration.c
 await_return_path_close_on_source_close(void) ""
 await_return_path_close_on_source_joining(void) ""
diff --git a/target/riscv/trace-events b/target/riscv/trace-events
index 4b6c652ae9..b7e371ee97 100644
--- a/target/riscv/trace-events
+++ b/target/riscv/trace-events
@@ -1,4 +1,4 @@
-# target/riscv/cpu_helper.c
+# cpu_helper.c
 riscv_trap(uint64_t hartid, bool async, uint64_t cause, uint64_t epc, uint64_t tval, const char *desc) "hart:%"PRId64", async:%d, cause:%"PRId64", epc:0x%"PRIx64", tval:0x%"PRIx64", desc=%s"
 
 # pmp.c
diff --git a/trace-events b/trace-events
index 5882c2d5fc..ac7cef9335 100644
--- a/trace-events
+++ b/trace-events
@@ -36,6 +36,8 @@ dma_map_wait(void *dbs) "dbs=%p"
 find_ram_offset(uint64_t size, uint64_t offset) "size: 0x%" PRIx64 " @ 0x%" PRIx64
 find_ram_offset_loop(uint64_t size, uint64_t candidate, uint64_t offset, uint64_t next, uint64_t mingap) "trying size: 0x%" PRIx64 " @ 0x%" PRIx64 ", offset: 0x%" PRIx64" next: 0x%" PRIx64 " mingap: 0x%" PRIx64
 ram_block_discard_range(const char *rbname, void *hva, size_t length, bool need_madvise, bool need_fallocate, int ret) "%s@%p + 0x%zx: madvise: %d fallocate: %d ret: %d"
+
+# accel/tcg/cputlb.c
 memory_notdirty_write_access(uint64_t vaddr, uint64_t ram_addr, unsigned size) "0x%" PRIx64 " ram_addr 0x%" PRIx64 " size %u"
 memory_notdirty_set_dirty(uint64_t vaddr) "0x%" PRIx64
 
@@ -134,8 +136,7 @@ vcpu guest_cpu_reset(void)
 # Targets: TCG(all)
 vcpu tcg guest_mem_before(TCGv vaddr, uint16_t info) "info=%d", "vaddr=0x%016"PRIx64" info=%d"
 
-# linux-user/syscall.c
-# bsd-user/syscall.c
+# include/user/syscall-trace.h
 
 # @num: System call number.
 # @arg*: System call argument value.
diff --git a/ui/trace-events b/ui/trace-events
index 5367fd3f16..b7d7270c02 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -17,9 +17,9 @@ displaychangelistener_register(void *dcl, const char *name) "%p [ %s ]"
 displaychangelistener_unregister(void *dcl, const char *name) "%p [ %s ]"
 ppm_save(int fd, void *display_surface) "fd=%d surface=%p"
 
-# gtk.c
-# gtk-gl-area.c
 # gtk-egl.c
+# gtk-gl-area.c
+# gtk.c
 gd_switch(const char *tab, int width, int height) "tab=%s, width=%d, height=%d"
 gd_update(const char *tab, int x, int y, int w, int h) "tab=%s, x=%d, y=%d, w=%d, h=%d"
 gd_key_event(const char *tab, int gdk_keycode, int qkeycode, const char *action) "tab=%s, translated GDK keycode %d to QKeyCode %d (%s)"
@@ -28,8 +28,8 @@ gd_ungrab(const char *tab, const char *device) "tab=%s, dev=%s"
 gd_keymap_windowing(const char *name) "backend=%s"
 
 # vnc-auth-sasl.c
-# vnc-ws.c
 # vnc-auth-vencrypt.c
+# vnc-ws.c
 # vnc.c
 vnc_key_guest_leds(bool caps, bool num, bool scroll) "caps %d, num %d, scroll %d"
 vnc_key_map_init(const char *layout) "%s"
diff --git a/util/trace-events b/util/trace-events
index 0ce42822eb..55c5d0b0cd 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -44,8 +44,8 @@ qemu_co_mutex_lock_return(void *mutex, void *self) "mutex %p self %p"
 qemu_co_mutex_unlock_entry(void *mutex, void *self) "mutex %p self %p"
 qemu_co_mutex_unlock_return(void *mutex, void *self) "mutex %p self %p"
 
-# oslib-win32.c
 # oslib-posix.c
+# oslib-win32.c
 qemu_memalign(size_t alignment, size_t size, void *ptr) "alignment %zu size %zu ptr %p"
 qemu_anon_ram_alloc(size_t size, void *ptr) "size %zu ptr %p"
 qemu_vfree(void *ptr) "ptr %p"
@@ -70,6 +70,8 @@ lockcnt_futex_wake(const void *lockcnt) "lockcnt %p waking up one waiter"
 socket_listen(int num) "backlog: %d"
 
 # qemu-thread-common.h
+# qemu-thread-posix.c
+# qemu-thread-win32.c
 qemu_mutex_lock(void *mutex, const char *file, const int line) "waiting on mutex %p (%s:%d)"
 qemu_mutex_locked(void *mutex, const char *file, const int line) "taken mutex %p (%s:%d)"
 qemu_mutex_unlock(void *mutex, const char *file, const int line) "released mutex %p (%s:%d)"
-- 
2.26.2


