Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6DACA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 21:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E48E320B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 21:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="pkKGqddW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48E320B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iN1NM-0002IE-Nn
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 17:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>) id 1iN1G9-0004Vs-QU
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 17:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <svens@stackframe.org>) id 1iN1G4-0002OV-Ve
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 17:00:05 -0400
Received: from [2001:470:70c5:1111::170] (port=50756 helo=smtp.duncanthrax.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <svens@stackframe.org>)
 id 1iN1G4-0002NE-C5
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 17:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=JH20qBQJmNGB6M1p6KsME4MOobA/2ww0jckNB/G2OyY=; b=pkKGqddWkeBurwCOkz/aXsypRB
 xDoySSX/YYTpRMOP70kSSm2+yxoLUDsc8ZD5Ptby1kJyEGJbpHaZ7jcIo9xuEbcLi7DqZdhImHy34
 IYP2170DLfT32nY552+FIrPFnIUZbmmrOkoP4/cH/XGrdJz2i0LiVmJcVJe0Rk8/N/xo=;
Received: from hsi-kbw-046-005-233-221.hsi8.kabel-badenwuerttemberg.de
 ([46.5.233.221] helo=x280.stackframe.org)
 by smtp.eurescom.eu with esmtpa (Exim 4.86_2)
 (envelope-from <svens@stackframe.org>)
 id 1iN1Fz-0004eI-E2; Tue, 22 Oct 2019 22:59:55 +0200
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <rth@twiddle.net>
Subject: [PATCH v3 2/6] hppa: Add support for LASI chip with i82596 NIC
Date: Tue, 22 Oct 2019 22:59:37 +0200
Message-Id: <20191022205941.23152-3-svens@stackframe.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022205941.23152-1-svens@stackframe.org>
References: <20191022205941.23152-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:470:70c5:1111::170
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
Cc: Jason Wang <jasowang@redhat.com>, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Helge Deller <deller@gmx.de>

LASI is a built-in multi-I/O chip which supports serial, parallel,
network (Intel i82596 Apricot), sound and other functionalities.
LASI has been used in many HP PARISC machines.
This patch adds the necessary parts to allow Linux and HP-UX to detect
LASI and the network card.

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 MAINTAINERS                 |   2 +
 hw/hppa/Kconfig             |   1 +
 hw/hppa/Makefile.objs       |   2 +-
 hw/hppa/hppa_sys.h          |   2 +
 hw/hppa/lasi.c              | 360 ++++++++++++++++++
 hw/hppa/machine.c           |   8 +-
 hw/hppa/trace-events        |   5 +
 hw/net/Kconfig              |   7 +
 hw/net/Makefile.objs        |   2 +
 hw/net/i82596.c             | 734 ++++++++++++++++++++++++++++++++++++
 hw/net/i82596.h             |  55 +++
 hw/net/lasi_i82596.c        | 188 +++++++++
 hw/net/trace-events         |  13 +
 include/hw/net/lasi_82596.h |  29 ++
 14 files changed, 1406 insertions(+), 2 deletions(-)
 create mode 100644 hw/hppa/lasi.c
 create mode 100644 hw/net/i82596.c
 create mode 100644 hw/net/i82596.h
 create mode 100644 hw/net/lasi_i82596.c
 create mode 100644 include/hw/net/lasi_82596.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f9541c3305..91e9e8ceac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -178,6 +178,8 @@ S: Maintained
 F: target/hppa/
 F: hw/hppa/
 F: disas/hppa.c
+F: hw/net/*i82596*
+F: include/hw/net/lasi_82596.h
 
 LM32 TCG CPUs
 M: Michael Walle <michael@walle.cc>
diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
index 6e5d74a825..2a7b38d6d6 100644
--- a/hw/hppa/Kconfig
+++ b/hw/hppa/Kconfig
@@ -10,3 +10,4 @@ config DINO
     select IDE_CMD646
     select MC146818RTC
     select LSI_SCSI_PCI
+    select LASI_82596
diff --git a/hw/hppa/Makefile.objs b/hw/hppa/Makefile.objs
index 67838f50a3..eac3467d8a 100644
--- a/hw/hppa/Makefile.objs
+++ b/hw/hppa/Makefile.objs
@@ -1 +1 @@
-obj-$(CONFIG_DINO) += pci.o machine.o dino.o
+obj-$(CONFIG_DINO) += pci.o machine.o dino.o lasi.o
diff --git a/hw/hppa/hppa_sys.h b/hw/hppa/hppa_sys.h
index 43d25d21fc..d99b5dd87b 100644
--- a/hw/hppa/hppa_sys.h
+++ b/hw/hppa/hppa_sys.h
@@ -11,6 +11,8 @@
 #include "hppa_hardware.h"
 
 PCIBus *dino_init(MemoryRegion *, qemu_irq *, qemu_irq *);
+DeviceState *lasi_init(MemoryRegion *);
+#define enable_lasi_lan()       0
 
 #define TYPE_DINO_PCI_HOST_BRIDGE "dino-pcihost"
 
diff --git a/hw/hppa/lasi.c b/hw/hppa/lasi.c
new file mode 100644
index 0000000000..51752589f3
--- /dev/null
+++ b/hw/hppa/lasi.c
@@ -0,0 +1,360 @@
+/*
+ * HP-PARISC Lasi chipset emulation.
+ *
+ * (C) 2019 by Helge Deller <deller@gmx.de>
+ *
+ * This work is licensed under the GNU GPL license version 2 or later.
+ *
+ * Documentation available at:
+ * https://parisc.wiki.kernel.org/images-parisc/7/79/Lasi_ers.pdf
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "trace.h"
+#include "hw/hw.h"
+#include "hw/irq.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
+#include "hppa_sys.h"
+#include "hw/net/lasi_82596.h"
+#include "hw/char/parallel.h"
+#include "hw/char/serial.h"
+#include "exec/address-spaces.h"
+#include "migration/vmstate.h"
+
+#define TYPE_LASI_CHIP "lasi-chip"
+
+#define LASI_IRR        0x00    /* RO */
+#define LASI_IMR        0x04
+#define LASI_IPR        0x08
+#define LASI_ICR        0x0c
+#define LASI_IAR        0x10
+
+#define LASI_PCR        0x0C000 /* LASI Power Control register */
+#define LASI_ERRLOG     0x0C004 /* LASI Error Logging register */
+#define LASI_VER        0x0C008 /* LASI Version Control register */
+#define LASI_IORESET    0x0C00C /* LASI I/O Reset register */
+#define LASI_AMR        0x0C010 /* LASI Arbitration Mask register */
+#define LASI_IO_CONF    0x7FFFE /* LASI primary configuration register */
+#define LASI_IO_CONF2   0x7FFFF /* LASI secondary configuration register */
+
+#define LASI_BIT(x)     (1ul << (x))
+#define LASI_IRQ_BITS   (LASI_BIT(5) | LASI_BIT(7) | LASI_BIT(8) | LASI_BIT(9) \
+            | LASI_BIT(13) | LASI_BIT(14) | LASI_BIT(16) | LASI_BIT(17) \
+            | LASI_BIT(18) | LASI_BIT(19) | LASI_BIT(20) | LASI_BIT(21) \
+            | LASI_BIT(26))
+
+#define ICR_BUS_ERROR_BIT  LASI_BIT(8)  /* bit 8 in ICR */
+#define ICR_TOC_BIT        LASI_BIT(1)  /* bit 1 in ICR */
+
+#define LASI_CHIP(obj) \
+    OBJECT_CHECK(LasiState, (obj), TYPE_LASI_CHIP)
+
+#define LASI_RTC_HPA    (LASI_HPA + 0x9000)
+
+typedef struct LasiState {
+    PCIHostState parent_obj;
+
+    uint32_t irr;
+    uint32_t imr;
+    uint32_t ipr;
+    uint32_t icr;
+    uint32_t iar;
+
+    uint32_t errlog;
+    uint32_t amr;
+    uint32_t rtc;
+    time_t rtc_ref;
+
+    MemoryRegion this_mem;
+} LasiState;
+
+static bool lasi_chip_mem_valid(void *opaque, hwaddr addr,
+                                unsigned size, bool is_write,
+                                MemTxAttrs attrs)
+{
+    bool ret = false;
+
+    switch (addr) {
+    case LASI_IRR:
+    case LASI_IMR:
+    case LASI_IPR:
+    case LASI_ICR:
+    case LASI_IAR:
+
+    case (LASI_LAN_HPA - LASI_HPA):
+    case (LASI_LPT_HPA - LASI_HPA):
+    case (LASI_UART_HPA - LASI_HPA):
+    case (LASI_RTC_HPA - LASI_HPA):
+
+    case LASI_PCR ... LASI_AMR:
+        ret = true;
+    }
+
+    trace_lasi_chip_mem_valid(addr, ret);
+    return ret;
+}
+
+static MemTxResult lasi_chip_read_with_attrs(void *opaque, hwaddr addr,
+                                             uint64_t *data, unsigned size,
+                                             MemTxAttrs attrs)
+{
+    LasiState *s = opaque;
+    MemTxResult ret = MEMTX_OK;
+    uint32_t val;
+
+    switch (addr) {
+    case LASI_IRR:
+        val = s->irr;
+        break;
+    case LASI_IMR:
+        val = s->imr;
+        break;
+    case LASI_IPR:
+        val = s->ipr;
+        /* Any read to IPR clears the register.  */
+        s->ipr = 0;
+        break;
+    case LASI_ICR:
+        val = s->icr & ICR_BUS_ERROR_BIT; /* bus_error */
+        break;
+    case LASI_IAR:
+        val = s->iar;
+        break;
+
+    case (LASI_LAN_HPA - LASI_HPA):
+    case (LASI_LPT_HPA - LASI_HPA):
+    case (LASI_UART_HPA - LASI_HPA):
+        val = 0;
+        break;
+    case (LASI_RTC_HPA - LASI_HPA):
+        val = time(NULL);
+        val += s->rtc_ref;
+        break;
+
+    case LASI_PCR:
+    case LASI_VER:      /* only version 0 existed. */
+    case LASI_IORESET:
+        val = 0;
+        break;
+    case LASI_ERRLOG:
+        val = s->errlog;
+        break;
+    case LASI_AMR:
+        val = s->amr;
+        break;
+
+    default:
+        /* Controlled by lasi_chip_mem_valid above. */
+        g_assert_not_reached();
+    }
+
+    trace_lasi_chip_read(addr, val);
+
+    *data = val;
+    return ret;
+}
+
+static MemTxResult lasi_chip_write_with_attrs(void *opaque, hwaddr addr,
+                                              uint64_t val, unsigned size,
+                                              MemTxAttrs attrs)
+{
+    LasiState *s = opaque;
+
+    trace_lasi_chip_write(addr, val);
+
+    switch (addr) {
+    case LASI_IRR:
+        /* read-only.  */
+        break;
+    case LASI_IMR:
+        s->imr = val;  /* 0x20 ?? */
+        assert((val & LASI_IRQ_BITS) == val);
+        break;
+    case LASI_IPR:
+        /* Any write to IPR clears the register. */
+        s->ipr = 0;
+        break;
+    case LASI_ICR:
+        s->icr = val;
+        /* if (val & ICR_TOC_BIT) issue_toc(); */
+        break;
+    case LASI_IAR:
+        s->iar = val;
+        break;
+
+    case (LASI_LAN_HPA - LASI_HPA):
+        /* XXX: reset LAN card */
+        break;
+    case (LASI_LPT_HPA - LASI_HPA):
+        /* XXX: reset parallel port */
+        break;
+    case (LASI_UART_HPA - LASI_HPA):
+        /* XXX: reset serial port */
+        break;
+    case (LASI_RTC_HPA - LASI_HPA):
+        s->rtc_ref = val - time(NULL);
+        break;
+
+    case LASI_PCR:
+        if (val == 0x02) /* immediately power off */
+            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+        break;
+    case LASI_ERRLOG:
+        s->errlog = val;
+        break;
+    case LASI_VER:
+        /* read-only.  */
+        break;
+    case LASI_IORESET:
+        break;  /* XXX: TODO: Reset various devices. */
+    case LASI_AMR:
+        s->amr = val;
+        break;
+
+    default:
+        /* Controlled by lasi_chip_mem_valid above. */
+        g_assert_not_reached();
+    }
+    return MEMTX_OK;
+}
+
+static const MemoryRegionOps lasi_chip_ops = {
+    .read_with_attrs = lasi_chip_read_with_attrs,
+    .write_with_attrs = lasi_chip_write_with_attrs,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+        .accepts = lasi_chip_mem_valid,
+    },
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static const VMStateDescription vmstate_lasi = {
+    .name = "Lasi",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(irr, LasiState),
+        VMSTATE_UINT32(imr, LasiState),
+        VMSTATE_UINT32(ipr, LasiState),
+        VMSTATE_UINT32(icr, LasiState),
+        VMSTATE_UINT32(iar, LasiState),
+        VMSTATE_UINT32(errlog, LasiState),
+        VMSTATE_UINT32(amr, LasiState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+
+static void lasi_set_irq(void *opaque, int irq, int level)
+{
+    LasiState *s = opaque;
+    uint32_t bit = 1u << irq;
+
+    if (level) {
+        s->ipr |= bit;
+        if (bit & s->imr) {
+            uint32_t iar = s->iar;
+            s->irr |= bit;
+            if ((s->icr & ICR_BUS_ERROR_BIT) == 0) {
+                stl_be_phys(&address_space_memory, iar & -32, iar & 31);
+            }
+        }
+    }
+}
+
+static int lasi_get_irq(unsigned long hpa)
+{
+    switch (hpa) {
+    case LASI_HPA:
+        return 14;
+    case LASI_UART_HPA:
+        return 5;
+    case LASI_LPT_HPA:
+        return 7;
+    case LASI_LAN_HPA:
+        return 8;
+    case LASI_SCSI_HPA:
+        return 9;
+    case LASI_AUDIO_HPA:
+        return 13;
+    case LASI_PS2KBD_HPA:
+    case LASI_PS2MOU_HPA:
+        return 26;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+DeviceState *lasi_init(MemoryRegion *address_space)
+{
+    DeviceState *dev;
+    LasiState *s;
+
+    dev = qdev_create(NULL, TYPE_LASI_CHIP);
+    s = LASI_CHIP(dev);
+    s->iar = CPU_HPA + 3;
+
+    /* Lasi access from main memory.  */
+    memory_region_init_io(&s->this_mem, OBJECT(s), &lasi_chip_ops,
+                          s, "lasi", 0x100000);
+    memory_region_add_subregion(address_space, LASI_HPA, &s->this_mem);
+
+    qdev_init_nofail(dev);
+
+    /* LAN */
+    if (enable_lasi_lan()) {
+        qemu_irq lan_irq = qemu_allocate_irq(lasi_set_irq, s,
+                lasi_get_irq(LASI_LAN_HPA));
+        lasi_82596_init(address_space, LASI_LAN_HPA, lan_irq);
+    }
+
+    /* Parallel port */
+    qemu_irq lpt_irq = qemu_allocate_irq(lasi_set_irq, s,
+            lasi_get_irq(LASI_LPT_HPA));
+    parallel_mm_init(address_space, LASI_LPT_HPA + 0x800, 0,
+                     lpt_irq, parallel_hds[0]);
+
+    /* Real time clock (RTC), it's only one 32-bit counter @9000 */
+    s->rtc = time(NULL);
+    s->rtc_ref = 0;
+
+    if (serial_hd(1)) {
+        /* Serial port */
+        qemu_irq serial_irq = qemu_allocate_irq(lasi_set_irq, s,
+                lasi_get_irq(LASI_UART_HPA));
+        serial_mm_init(address_space, LASI_UART_HPA + 0x800, 0,
+                serial_irq, 8000000 / 16,
+                serial_hd(1), DEVICE_NATIVE_ENDIAN);
+    }
+    return dev;
+}
+
+static void lasi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_lasi;
+}
+
+static const TypeInfo lasi_pcihost_info = {
+    .name          = TYPE_LASI_CHIP,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(LasiState),
+    .class_init    = lasi_class_init,
+};
+
+static void lasi_register_types(void)
+{
+    type_register_static(&lasi_pcihost_info);
+}
+
+type_init(lasi_register_types)
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 7e23675429..65fc20ebed 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -16,6 +16,7 @@
 #include "hw/ide.h"
 #include "hw/timer/i8254.h"
 #include "hw/char/serial.h"
+#include "hw/net/lasi_82596.h"
 #include "hppa_sys.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
@@ -100,6 +101,9 @@ static void machine_hppa_init(MachineState *machine)
                                          "ram", ram_size);
     memory_region_add_subregion(addr_space, 0, ram_region);
 
+    /* Init Lasi chip */
+    lasi_init(addr_space);
+
     /* Init Dino (PCI host bus chip).  */
     pci_bus = dino_init(addr_space, &rtc_irq, &serial_irq);
     assert(pci_bus);
@@ -124,7 +128,9 @@ static void machine_hppa_init(MachineState *machine)
 
     /* Network setup.  e1000 is good enough, failing Tulip support.  */
     for (i = 0; i < nb_nics; i++) {
-        pci_nic_init_nofail(&nd_table[i], pci_bus, "e1000", NULL);
+        if (!enable_lasi_lan()) {
+            pci_nic_init_nofail(&nd_table[i], pci_bus, "e1000", NULL);
+        }
     }
 
     /* Load firmware.  Given that this is not "real" firmware,
diff --git a/hw/hppa/trace-events b/hw/hppa/trace-events
index f943b16c4e..3ff620319a 100644
--- a/hw/hppa/trace-events
+++ b/hw/hppa/trace-events
@@ -7,3 +7,8 @@ hppa_pci_iack_write(void) ""
 dino_chip_mem_valid(uint64_t addr, uint32_t val) "access to addr 0x%"PRIx64" is %d"
 dino_chip_read(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%08x"
 dino_chip_write(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%08x"
+
+# lasi.c
+lasi_chip_mem_valid(uint64_t addr, uint32_t val) "access to addr 0x%"PRIx64" is %d"
+lasi_chip_read(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%08x"
+lasi_chip_write(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%08x"
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index 4ef86dc3a5..a38f9adaeb 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -24,6 +24,9 @@ config PCNET_PCI
 config PCNET_COMMON
     bool
 
+config I82596_COMMON
+    bool
+
 config E1000_PCI
     bool
     default y if PCI_DEVICES
@@ -82,6 +85,10 @@ config LANCE
     bool
     select PCNET_COMMON
 
+config LASI_82596
+    bool
+    select I82596_COMMON
+
 config SUNHME
     bool
 
diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
index 9904273b06..f3ef9ffe9b 100644
--- a/hw/net/Makefile.objs
+++ b/hw/net/Makefile.objs
@@ -27,6 +27,8 @@ common-obj-$(CONFIG_IMX_FEC) += imx_fec.o
 common-obj-$(CONFIG_CADENCE) += cadence_gem.o
 common-obj-$(CONFIG_STELLARIS_ENET) += stellaris_enet.o
 common-obj-$(CONFIG_LANCE) += lance.o
+common-obj-$(CONFIG_LASI_82596) += lasi_i82596.o
+common-obj-$(CONFIG_I82596_COMMON) += i82596.o
 common-obj-$(CONFIG_SUNHME) += sunhme.o
 common-obj-$(CONFIG_FTGMAC100) += ftgmac100.o
 common-obj-$(CONFIG_SUNGEM) += sungem.o
diff --git a/hw/net/i82596.c b/hw/net/i82596.c
new file mode 100644
index 0000000000..ce1cc18b93
--- /dev/null
+++ b/hw/net/i82596.c
@@ -0,0 +1,734 @@
+/*
+ * QEMU Intel i82596 (Apricot) emulation
+ *
+ * Copyright (c) 2019 Helge Deller <deller@gmx.de>
+ * This work is licensed under the GNU GPL license version 2 or later.
+ *
+ * This software was written to be compatible with the specification:
+ * https://www.intel.com/assets/pdf/general/82596ca.pdf
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+#include "net/net.h"
+#include "net/eth.h"
+#include "sysemu/sysemu.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "qemu/module.h"
+#include "trace.h"
+#include "i82596.h"
+#include <zlib.h>       /* For crc32 */
+
+#if defined(ENABLE_DEBUG)
+#define DBG(x)          x
+#else
+#define DBG(x)          do { } while (0)
+#endif
+
+#define USE_TIMER       0
+
+#define BITS(n, m) (((0xffffffffU << (31 - n)) >> (31 - n + m)) << m)
+
+#define PKT_BUF_SZ      1536
+#define MAX_MC_CNT      64
+
+#define ISCP_BUSY       0x0001
+
+#define I596_NULL       ((uint32_t)0xffffffff)
+
+#define SCB_STATUS_CX   0x8000 /* CU finished command with I bit */
+#define SCB_STATUS_FR   0x4000 /* RU finished receiving a frame */
+#define SCB_STATUS_CNA  0x2000 /* CU left active state */
+#define SCB_STATUS_RNR  0x1000 /* RU left active state */
+
+#define CU_IDLE         0
+#define CU_SUSPENDED    1
+#define CU_ACTIVE       2
+
+#define RX_IDLE         0
+#define RX_SUSPENDED    1
+#define RX_READY        4
+
+#define CMD_EOL         0x8000  /* The last command of the list, stop. */
+#define CMD_SUSP        0x4000  /* Suspend after doing cmd. */
+#define CMD_INTR        0x2000  /* Interrupt after doing cmd. */
+
+#define CMD_FLEX        0x0008  /* Enable flexible memory model */
+
+enum commands {
+        CmdNOp = 0, CmdSASetup = 1, CmdConfigure = 2, CmdMulticastList = 3,
+        CmdTx = 4, CmdTDR = 5, CmdDump = 6, CmdDiagnose = 7
+};
+
+#define STAT_C          0x8000  /* Set to 0 after execution */
+#define STAT_B          0x4000  /* Command being executed */
+#define STAT_OK         0x2000  /* Command executed ok */
+#define STAT_A          0x1000  /* Command aborted */
+
+#define I596_EOF        0x8000
+#define SIZE_MASK       0x3fff
+
+#define ETHER_TYPE_LEN 2
+#define VLAN_TCI_LEN 2
+#define VLAN_HLEN (ETHER_TYPE_LEN + VLAN_TCI_LEN)
+
+/* various flags in the chip config registers */
+#define I596_PREFETCH   (s->config[0] & 0x80)
+#define I596_PROMISC    (s->config[8] & 0x01)
+#define I596_BC_DISABLE (s->config[8] & 0x02) /* broadcast disable */
+#define I596_NOCRC_INS  (s->config[8] & 0x08)
+#define I596_CRCINM     (s->config[11] & 0x04) /* CRC appended */
+#define I596_MC_ALL     (s->config[11] & 0x20)
+#define I596_MULTIIA    (s->config[13] & 0x40)
+
+
+static uint8_t get_byte(uint32_t addr)
+{
+    return ldub_phys(&address_space_memory, addr);
+}
+
+static void set_byte(uint32_t addr, uint8_t c)
+{
+    return stb_phys(&address_space_memory, addr, c);
+}
+
+static uint16_t get_uint16(uint32_t addr)
+{
+    return lduw_be_phys(&address_space_memory, addr);
+}
+
+static void set_uint16(uint32_t addr, uint16_t w)
+{
+    return stw_be_phys(&address_space_memory, addr, w);
+}
+
+static uint32_t get_uint32(uint32_t addr)
+{
+    uint32_t lo = lduw_be_phys(&address_space_memory, addr);
+    uint32_t hi = lduw_be_phys(&address_space_memory, addr + 2);
+    return (hi << 16) | lo;
+}
+
+static void set_uint32(uint32_t addr, uint32_t val)
+{
+    set_uint16(addr, (uint16_t) val);
+    set_uint16(addr + 2, val >> 16);
+}
+
+
+struct qemu_ether_header {
+    uint8_t ether_dhost[6];
+    uint8_t ether_shost[6];
+    uint16_t ether_type;
+};
+
+#define PRINT_PKTHDR(txt, BUF) do {                  \
+    struct qemu_ether_header *hdr = (void *)(BUF); \
+    printf(txt ": packet dhost=" MAC_FMT ", shost=" MAC_FMT ", type=0x%04x\n",\
+           MAC_ARG(hdr->ether_dhost), MAC_ARG(hdr->ether_shost),        \
+           be16_to_cpu(hdr->ether_type));       \
+} while (0)
+
+static void i82596_transmit(I82596State *s, uint32_t addr)
+{
+    uint32_t tdb_p; /* Transmit Buffer Descriptor */
+
+    /* TODO: Check flexible mode */
+    tdb_p = get_uint32(addr + 8);
+    while (tdb_p != I596_NULL) {
+        uint16_t size, len;
+        uint32_t tba;
+
+        size = get_uint16(tdb_p);
+        len = size & SIZE_MASK;
+        tba = get_uint32(tdb_p + 8);
+        trace_i82596_transmit(len, tba);
+
+        if (s->nic && len) {
+            assert(len <= sizeof(s->tx_buffer));
+            address_space_rw(&address_space_memory, tba,
+                MEMTXATTRS_UNSPECIFIED, s->tx_buffer, len, 0);
+            DBG(PRINT_PKTHDR("Send", &s->tx_buffer));
+            DBG(printf("Sending %d bytes\n", len));
+            qemu_send_packet(qemu_get_queue(s->nic), s->tx_buffer, len);
+        }
+
+        /* was this the last package? */
+        if (size & I596_EOF) {
+            break;
+        }
+
+        /* get next buffer pointer */
+        tdb_p = get_uint32(tdb_p + 4);
+    }
+}
+
+static void set_individual_address(I82596State *s, uint32_t addr)
+{
+    NetClientState *nc;
+    uint8_t *m;
+
+    nc = qemu_get_queue(s->nic);
+    m = s->conf.macaddr.a;
+    address_space_rw(&address_space_memory, addr + 8,
+        MEMTXATTRS_UNSPECIFIED, m, ETH_ALEN, 0);
+    qemu_format_nic_info_str(nc, m);
+    trace_i82596_new_mac(nc->info_str);
+}
+
+static void set_multicast_list(I82596State *s, uint32_t addr)
+{
+    uint16_t mc_count, i;
+
+    memset(&s->mult[0], 0, sizeof(s->mult));
+    mc_count = get_uint16(addr + 8) / ETH_ALEN;
+    addr += 10;
+    if (mc_count > MAX_MC_CNT) {
+        mc_count = MAX_MC_CNT;
+    }
+    for (i = 0; i < mc_count; i++) {
+        uint8_t multicast_addr[ETH_ALEN];
+        address_space_rw(&address_space_memory,
+            addr + i * ETH_ALEN, MEMTXATTRS_UNSPECIFIED,
+            multicast_addr, ETH_ALEN, 0);
+        DBG(printf("Add multicast entry " MAC_FMT "\n",
+                    MAC_ARG(multicast_addr)));
+        unsigned mcast_idx = (net_crc32(multicast_addr, ETH_ALEN) &
+                              BITS(7, 2)) >> 2;
+        assert(mcast_idx < 8 * sizeof(s->mult));
+        s->mult[mcast_idx >> 3] |= (1 << (mcast_idx & 7));
+    }
+    trace_i82596_set_multicast(mc_count);
+}
+
+void i82596_set_link_status(NetClientState *nc)
+{
+    I82596State *d = qemu_get_nic_opaque(nc);
+
+    d->lnkst = nc->link_down ? 0 : 0x8000;
+}
+
+static void update_scb_status(I82596State *s)
+{
+    s->scb_status = (s->scb_status & 0xf000)
+        | (s->cu_status << 8) | (s->rx_status << 4);
+    set_uint16(s->scb, s->scb_status);
+}
+
+
+static void i82596_s_reset(I82596State *s)
+{
+    trace_i82596_s_reset(s);
+    s->scp = 0;
+    s->scb_status = 0;
+    s->cu_status = CU_IDLE;
+    s->rx_status = RX_SUSPENDED;
+    s->cmd_p = I596_NULL;
+    s->lnkst = 0x8000; /* initial link state: up */
+    s->ca = s->ca_active = 0;
+    s->send_irq = 0;
+}
+
+
+static void command_loop(I82596State *s)
+{
+    uint16_t cmd;
+    uint16_t status;
+    uint8_t byte_cnt;
+
+    DBG(printf("STARTING COMMAND LOOP cmd_p=%08x\n", s->cmd_p));
+
+    while (s->cmd_p != I596_NULL) {
+        /* set status */
+        status = STAT_B;
+        set_uint16(s->cmd_p, status);
+        status = STAT_C | STAT_OK; /* update, but write later */
+
+        cmd = get_uint16(s->cmd_p + 2);
+        DBG(printf("Running command %04x at %08x\n", cmd, s->cmd_p));
+
+        switch (cmd & 0x07) {
+        case CmdNOp:
+            break;
+        case CmdSASetup:
+            set_individual_address(s, s->cmd_p);
+            break;
+        case CmdConfigure:
+            byte_cnt = get_byte(s->cmd_p + 8) & 0x0f;
+            byte_cnt = MAX(byte_cnt, 4);
+            byte_cnt = MIN(byte_cnt, sizeof(s->config));
+            /* copy byte_cnt max. */
+            address_space_rw(&address_space_memory, s->cmd_p + 8,
+                MEMTXATTRS_UNSPECIFIED, s->config, byte_cnt, 0);
+            /* config byte according to page 35ff */
+            s->config[2] &= 0x82; /* mask valid bits */
+            s->config[2] |= 0x40;
+            s->config[7]  &= 0xf7; /* clear zero bit */
+            assert(I596_NOCRC_INS == 0); /* do CRC insertion */
+            s->config[10] = MAX(s->config[10], 5); /* min frame length */
+            s->config[12] &= 0x40; /* only full duplex field valid */
+            s->config[13] |= 0x3f; /* set ones in byte 13 */
+            break;
+        case CmdTDR:
+            /* get signal LINK */
+            set_uint32(s->cmd_p + 8, s->lnkst);
+            break;
+        case CmdTx:
+            i82596_transmit(s, s->cmd_p);
+            break;
+        case CmdMulticastList:
+            set_multicast_list(s, s->cmd_p);
+            break;
+        case CmdDump:
+        case CmdDiagnose:
+            printf("FIXME Command %d !!\n", cmd & 7);
+            assert(0);
+        }
+
+        /* update status */
+        set_uint16(s->cmd_p, status);
+
+        s->cmd_p = get_uint32(s->cmd_p + 4); /* get link address */
+        DBG(printf("NEXT addr would be %08x\n", s->cmd_p));
+        if (s->cmd_p == 0) {
+            s->cmd_p = I596_NULL;
+        }
+
+        /* Stop when last command of the list. */
+        if (cmd & CMD_EOL) {
+            s->cmd_p = I596_NULL;
+        }
+        /* Suspend after doing cmd? */
+        if (cmd & CMD_SUSP) {
+            s->cu_status = CU_SUSPENDED;
+            printf("FIXME SUSPEND !!\n");
+        }
+        /* Interrupt after doing cmd? */
+        if (cmd & CMD_INTR) {
+            s->scb_status |= SCB_STATUS_CX;
+        } else {
+            s->scb_status &= ~SCB_STATUS_CX;
+        }
+        update_scb_status(s);
+
+        /* Interrupt after doing cmd? */
+        if (cmd & CMD_INTR) {
+            s->send_irq = 1;
+        }
+
+        if (s->cu_status != CU_ACTIVE) {
+            break;
+        }
+    }
+    DBG(printf("FINISHED COMMAND LOOP\n"));
+    qemu_flush_queued_packets(qemu_get_queue(s->nic));
+}
+
+static void i82596_flush_queue_timer(void *opaque)
+{
+    I82596State *s = opaque;
+    if (0) {
+        timer_del(s->flush_queue_timer);
+        qemu_flush_queued_packets(qemu_get_queue(s->nic));
+        timer_mod(s->flush_queue_timer,
+              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 1000);
+    }
+}
+
+static void examine_scb(I82596State *s)
+{
+    uint16_t command, cuc, ruc;
+
+    /* get the scb command word */
+    command = get_uint16(s->scb + 2);
+    cuc = (command >> 8) & 0x7;
+    ruc = (command >> 4) & 0x7;
+    DBG(printf("MAIN COMMAND %04x  cuc %02x ruc %02x\n", command, cuc, ruc));
+    /* and clear the scb command word */
+    set_uint16(s->scb + 2, 0);
+
+    if (command & BIT(31))      /* ACK-CX */
+        s->scb_status &= ~SCB_STATUS_CX;
+    if (command & BIT(30))      /*ACK-FR */
+        s->scb_status &= ~SCB_STATUS_FR;
+    if (command & BIT(29))      /*ACK-CNA */
+        s->scb_status &= ~SCB_STATUS_CNA;
+    if (command & BIT(28))      /*ACK-RNR */
+        s->scb_status &= ~SCB_STATUS_RNR;
+
+    switch (cuc) {
+    case 0:     /* no change */
+        break;
+    case 1:     /* CUC_START */
+        s->cu_status = CU_ACTIVE;
+        break;
+    case 4:     /* CUC_ABORT */
+        s->cu_status = CU_SUSPENDED;
+        s->scb_status |= SCB_STATUS_CNA; /* CU left active state */
+        break;
+    default:
+        printf("WARNING: Unknown CUC %d!\n", cuc);
+    }
+
+    switch (ruc) {
+    case 0:     /* no change */
+        break;
+    case 1:     /* RX_START */
+    case 2:     /* RX_RESUME */
+        s->rx_status = RX_IDLE;
+        if (USE_TIMER) {
+            timer_mod(s->flush_queue_timer, qemu_clock_get_ms(
+                                QEMU_CLOCK_VIRTUAL) + 1000);
+        }
+        break;
+    case 3:     /* RX_SUSPEND */
+    case 4:     /* RX_ABORT */
+        s->rx_status = RX_SUSPENDED;
+        s->scb_status |= SCB_STATUS_RNR; /* RU left active state */
+        break;
+    default:
+        printf("WARNING: Unknown RUC %d!\n", ruc);
+    }
+
+    if (command & 0x80) { /* reset bit set? */
+        i82596_s_reset(s);
+    }
+
+    /* execute commands from SCBL */
+    if (s->cu_status != CU_SUSPENDED) {
+        if (s->cmd_p == I596_NULL) {
+            s->cmd_p = get_uint32(s->scb + 4);
+        }
+    }
+
+    /* update scb status */
+    update_scb_status(s);
+
+    command_loop(s);
+}
+
+static void signal_ca(I82596State *s)
+{
+    uint32_t iscp = 0;
+
+    /* trace_i82596_channel_attention(s); */
+    if (s->scp) {
+        /* CA after reset -> do init with new scp. */
+        s->sysbus = get_byte(s->scp + 3); /* big endian */
+        DBG(printf("SYSBUS = %08x\n", s->sysbus));
+        if (((s->sysbus >> 1) & 0x03) != 2) {
+            printf("WARNING: NO LINEAR MODE !!\n");
+        }
+        if ((s->sysbus >> 7)) {
+            printf("WARNING: 32BIT LINMODE IN B-STEPPING NOT SUPPORTED !!\n");
+        }
+        iscp = get_uint32(s->scp + 8);
+        s->scb = get_uint32(iscp + 4);
+        set_byte(iscp + 1, 0); /* clear BUSY flag in iscp */
+        s->scp = 0;
+    }
+
+    s->ca++;    /* count ca() */
+    if (!s->ca_active) {
+        s->ca_active = 1;
+        while (s->ca)   {
+            examine_scb(s);
+            s->ca--;
+        }
+        s->ca_active = 0;
+    }
+
+    if (s->send_irq) {
+        s->send_irq = 0;
+        qemu_set_irq(s->irq, 1);
+    }
+}
+
+void i82596_ioport_writew(void *opaque, uint32_t addr, uint32_t val)
+{
+    I82596State *s = opaque;
+    /* printf("i82596_ioport_writew addr=0x%08x val=0x%04x\n", addr, val); */
+    switch (addr) {
+    case PORT_RESET: /* Reset */
+        i82596_s_reset(s);
+        break;
+    case PORT_ALTSCP:
+        s->scp = val;
+        break;
+    case PORT_CA:
+        signal_ca(s);
+        break;
+    }
+}
+
+uint32_t i82596_ioport_readw(void *opaque, uint32_t addr)
+{
+    return -1;
+}
+
+void i82596_h_reset(void *opaque)
+{
+    I82596State *s = opaque;
+
+    i82596_s_reset(s);
+}
+
+int i82596_can_receive(NetClientState *nc)
+{
+    I82596State *s = qemu_get_nic_opaque(nc);
+
+    if (s->rx_status == RX_SUSPENDED) {
+        return 0;
+    }
+
+    if (!s->lnkst) {
+        return 0;
+    }
+
+    if (USE_TIMER && !timer_pending(s->flush_queue_timer)) {
+        return 1;
+    }
+
+    return 1;
+}
+
+#define MIN_BUF_SIZE 60
+
+ssize_t i82596_receive(NetClientState *nc, const uint8_t *buf, size_t sz)
+{
+    I82596State *s = qemu_get_nic_opaque(nc);
+    uint32_t rfd_p;
+    uint32_t rbd;
+    uint16_t is_broadcast = 0;
+    size_t len = sz;
+    uint32_t crc;
+    uint8_t *crc_ptr;
+    uint8_t buf1[MIN_BUF_SIZE + VLAN_HLEN];
+    static const uint8_t broadcast_macaddr[6] = {
+                0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
+
+    DBG(printf("i82596_receive() start\n"));
+
+    if (USE_TIMER && timer_pending(s->flush_queue_timer)) {
+        return 0;
+    }
+
+    /* first check if receiver is enabled */
+    if (s->rx_status == RX_SUSPENDED) {
+        trace_i82596_receive_analysis(">>> Receiving suspended");
+        return -1;
+    }
+
+    if (!s->lnkst) {
+        trace_i82596_receive_analysis(">>> Link down");
+        return -1;
+    }
+
+    /* Received frame smaller than configured "min frame len"? */
+    if (sz < s->config[10]) {
+        printf("Received frame too small, %lu vs. %u bytes\n",
+            sz, s->config[10]);
+        return -1;
+    }
+
+    DBG(printf("Received %lu bytes\n", sz));
+
+    if (I596_PROMISC) {
+
+        /* promiscuous: receive all */
+        trace_i82596_receive_analysis(
+                ">>> packet received in promiscuous mode");
+
+    } else {
+
+        if (!memcmp(buf,  broadcast_macaddr, 6)) {
+            /* broadcast address */
+            if (I596_BC_DISABLE) {
+                trace_i82596_receive_analysis(">>> broadcast packet rejected");
+
+                return len;
+            }
+
+            trace_i82596_receive_analysis(">>> broadcast packet received");
+            is_broadcast = 1;
+
+        } else if (buf[0] & 0x01) {
+            /* multicast */
+            if (!I596_MC_ALL) {
+                trace_i82596_receive_analysis(">>> multicast packet rejected");
+
+                return len;
+            }
+
+            int mcast_idx = (net_crc32(buf, ETH_ALEN) & BITS(7, 2)) >> 2;
+            assert(mcast_idx < 8 * sizeof(s->mult));
+
+            if (!(s->mult[mcast_idx >> 3] & (1 << (mcast_idx & 7)))) {
+                trace_i82596_receive_analysis(">>> multicast address mismatch");
+
+                return len;
+            }
+
+            trace_i82596_receive_analysis(">>> multicast packet received");
+            is_broadcast = 1;
+
+        } else if (!memcmp(s->conf.macaddr.a, buf, 6)) {
+
+            /* match */
+            trace_i82596_receive_analysis(
+                    ">>> physical address matching packet received");
+
+        } else {
+
+            trace_i82596_receive_analysis(">>> unknown packet");
+
+            return len;
+        }
+    }
+
+    /* if too small buffer, then expand it */
+    if (len < MIN_BUF_SIZE + VLAN_HLEN) {
+        memcpy(buf1, buf, len);
+        memset(buf1 + len, 0, MIN_BUF_SIZE + VLAN_HLEN - len);
+        buf = buf1;
+        if (len < MIN_BUF_SIZE) {
+            len = MIN_BUF_SIZE;
+        }
+    }
+
+    /* Calculate the ethernet checksum (4 bytes) */
+    len += 4;
+    crc = cpu_to_be32(crc32(~0, buf, sz));
+    crc_ptr = (uint8_t *) &crc;
+
+    rfd_p = get_uint32(s->scb + 8); /* get Receive Frame Descriptor */
+    assert(rfd_p && rfd_p != I596_NULL);
+
+    /* get first Receive Buffer Descriptor Address */
+    rbd = get_uint32(rfd_p + 8);
+    assert(rbd && rbd != I596_NULL);
+
+    trace_i82596_receive_packet(len);
+    /* PRINT_PKTHDR("Receive", buf); */
+
+    while (len) {
+        uint16_t command, status;
+        uint32_t next_rfd;
+
+        command = get_uint16(rfd_p + 2);
+        assert(command & CMD_FLEX); /* assert Flex Mode */
+        /* get first Receive Buffer Descriptor Address */
+        rbd = get_uint32(rfd_p + 8);
+        assert(get_uint16(rfd_p + 14) == 0);
+
+        /* printf("Receive: rfd is %08x\n", rfd_p); */
+
+        while (len) {
+            uint16_t buffer_size, num;
+            uint32_t rba;
+
+            /* printf("Receive: rbd is %08x\n", rbd); */
+            buffer_size = get_uint16(rbd + 12);
+            /* printf("buffer_size is 0x%x\n", buffer_size); */
+            assert(buffer_size != 0);
+
+            num = buffer_size & SIZE_MASK;
+            if (num > len) {
+                num = len;
+            }
+            rba = get_uint32(rbd + 8);
+            /* printf("rba is 0x%x\n", rba); */
+            address_space_rw(&address_space_memory, rba,
+                MEMTXATTRS_UNSPECIFIED, (void *)buf, num, 1);
+            rba += num;
+            buf += num;
+            len -= num;
+            if (len == 0) { /* copy crc */
+                address_space_rw(&address_space_memory, rba - 4,
+                    MEMTXATTRS_UNSPECIFIED, crc_ptr, 4, 1);
+            }
+
+            num |= 0x4000; /* set F BIT */
+            if (len == 0) {
+                num |= I596_EOF; /* set EOF BIT */
+            }
+            set_uint16(rbd + 0, num); /* write actual count with flags */
+
+            /* get next rbd */
+            rbd = get_uint32(rbd + 4);
+            /* printf("Next Receive: rbd is %08x\n", rbd); */
+
+            if (buffer_size & I596_EOF) /* last entry */
+                break;
+        }
+
+        /* Housekeeping, see pg. 18 */
+        next_rfd = get_uint32(rfd_p + 4);
+        set_uint32(next_rfd + 8, rbd);
+
+        status = STAT_C | STAT_OK | is_broadcast;
+        set_uint16(rfd_p, status);
+
+        if (command & CMD_SUSP) {  /* suspend after command? */
+            s->rx_status = RX_SUSPENDED;
+            s->scb_status |= SCB_STATUS_RNR; /* RU left active state */
+            break;
+        }
+        if (command & CMD_EOL) /* was it last Frame Descriptor? */
+            break;
+
+        assert(len == 0);
+    }
+
+    assert(len == 0);
+
+    s->scb_status |= SCB_STATUS_FR; /* set "RU finished receiving frame" bit. */
+    update_scb_status(s);
+
+    /* send IRQ that we received data */
+    qemu_set_irq(s->irq, 1);
+    /* s->send_irq = 1; */
+
+    if (0) {
+        DBG(printf("Checking:\n"));
+        rfd_p = get_uint32(s->scb + 8); /* get Receive Frame Descriptor */
+        DBG(printf("Next Receive: rfd is %08x\n", rfd_p));
+        rfd_p = get_uint32(rfd_p + 4); /* get Next Receive Frame Descriptor */
+        DBG(printf("Next Receive: rfd is %08x\n", rfd_p));
+        /* get first Receive Buffer Descriptor Address */
+        rbd = get_uint32(rfd_p + 8);
+        DBG(printf("Next Receive: rbd is %08x\n", rbd));
+    }
+
+    return sz;
+}
+
+
+const VMStateDescription vmstate_i82596 = {
+    .name = "i82596",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT16(lnkst, I82596State),
+        VMSTATE_TIMER_PTR(flush_queue_timer, I82596State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+void i82596_common_init(DeviceState *dev, I82596State *s, NetClientInfo *info)
+{
+    if (s->conf.macaddr.a[0] == 0) {
+        qemu_macaddr_default_if_unset(&s->conf.macaddr);
+    }
+    s->nic = qemu_new_nic(info, &s->conf, object_get_typename(OBJECT(dev)),
+                dev->id, s);
+    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+
+    if (USE_TIMER) {
+        s->flush_queue_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                    i82596_flush_queue_timer, s);
+    }
+    s->lnkst = 0x8000; /* initial link state: up */
+}
diff --git a/hw/net/i82596.h b/hw/net/i82596.h
new file mode 100644
index 0000000000..1238ac11f8
--- /dev/null
+++ b/hw/net/i82596.h
@@ -0,0 +1,55 @@
+#ifndef HW_I82596_H
+#define HW_I82596_H
+
+#define I82596_IOPORT_SIZE       0x20
+
+#include "exec/memory.h"
+#include "exec/address-spaces.h"
+
+#define PORT_RESET              0x00    /* reset 82596 */
+#define PORT_SELFTEST           0x01    /* selftest */
+#define PORT_ALTSCP             0x02    /* alternate SCB address */
+#define PORT_ALTDUMP            0x03    /* Alternate DUMP address */
+#define PORT_CA                 0x10    /* QEMU-internal CA signal */
+
+typedef struct I82596State_st I82596State;
+
+struct I82596State_st {
+    MemoryRegion mmio;
+    MemoryRegion *as;
+    qemu_irq irq;
+    NICState *nic;
+    NICConf conf;
+    QEMUTimer *flush_queue_timer;
+
+    hwaddr scp;         /* pointer to SCP */
+    uint8_t sysbus;
+    uint32_t scb;       /* SCB */
+    uint16_t scb_status;
+    uint8_t cu_status, rx_status;
+    uint16_t lnkst;
+
+    uint32_t cmd_p;     /* addr of current command */
+    int ca;
+    int ca_active;
+    int send_irq;
+
+    /* Hash register (multicast mask array, multiple individual addresses). */
+    uint8_t mult[8];
+    uint8_t config[14]; /* config bytes from CONFIGURE command */
+
+    uint8_t tx_buffer[0x4000];
+};
+
+void i82596_h_reset(void *opaque);
+void i82596_ioport_writew(void *opaque, uint32_t addr, uint32_t val);
+uint32_t i82596_ioport_readw(void *opaque, uint32_t addr);
+void i82596_ioport_writel(void *opaque, uint32_t addr, uint32_t val);
+uint32_t i82596_ioport_readl(void *opaque, uint32_t addr);
+uint32_t i82596_bcr_readw(I82596State *s, uint32_t rap);
+ssize_t i82596_receive(NetClientState *nc, const uint8_t *buf, size_t size_);
+int i82596_can_receive(NetClientState *nc);
+void i82596_set_link_status(NetClientState *nc);
+void i82596_common_init(DeviceState *dev, I82596State *s, NetClientInfo *info);
+extern const VMStateDescription vmstate_i82596;
+#endif
diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
new file mode 100644
index 0000000000..9629ba189d
--- /dev/null
+++ b/hw/net/lasi_i82596.c
@@ -0,0 +1,188 @@
+/*
+ * QEMU LASI NIC i82596 emulation
+ *
+ * Copyright (c) 2019 Helge Deller <deller@gmx.de>
+ * This work is licensed under the GNU GPL license version 2 or later.
+ *
+ *
+ * On PA-RISC, this is the Network part of LASI chip.
+ * See:
+ * https://parisc.wiki.kernel.org/images-parisc/7/79/Lasi_ers.pdf
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+#include "hw/sysbus.h"
+#include "net/eth.h"
+#include "hw/net/lasi_82596.h"
+#include "hw/net/i82596.h"
+#include "trace.h"
+#include "sysemu/sysemu.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+
+#define PA_I82596_RESET         0       /* Offsets relative to LASI-LAN-Addr.*/
+#define PA_CPU_PORT_L_ACCESS    4
+#define PA_CHANNEL_ATTENTION    8
+#define PA_GET_MACADDR          12
+
+#define SWAP32(x)   (((uint32_t)(x) << 16) | ((((uint32_t)(x))) >> 16))
+
+static void lasi_82596_mem_write(void *opaque, hwaddr addr,
+                            uint64_t val, unsigned size)
+{
+    SysBusI82596State *d = opaque;
+
+    trace_lasi_82596_mem_writew(addr, val);
+    switch (addr) {
+    case PA_I82596_RESET:
+        i82596_h_reset(&d->state);
+        break;
+    case PA_CPU_PORT_L_ACCESS:
+        d->val_index++;
+        if (d->val_index == 0) {
+            uint32_t v = d->last_val | (val << 16);
+            v = v & ~0xff;
+            i82596_ioport_writew(&d->state, d->last_val & 0xff, v);
+        }
+        d->last_val = val;
+        break;
+    case PA_CHANNEL_ATTENTION:
+        i82596_ioport_writew(&d->state, PORT_CA, val);
+        break;
+    case PA_GET_MACADDR:
+        /*
+         * Provided for SeaBIOS only. Write MAC of Network card to addr @val.
+         * Needed for the PDC_LAN_STATION_ID_READ PDC call.
+         */
+        address_space_rw(&address_space_memory, val,
+            MEMTXATTRS_UNSPECIFIED, d->state.conf.macaddr.a, ETH_ALEN, 1);
+        break;
+    }
+}
+
+static uint64_t lasi_82596_mem_read(void *opaque, hwaddr addr,
+                               unsigned size)
+{
+    SysBusI82596State *d = opaque;
+    uint32_t val;
+
+    if (addr == PA_GET_MACADDR) {
+        val = 0xBEEFBABE;
+    } else {
+        val = i82596_ioport_readw(&d->state, addr);
+    }
+    trace_lasi_82596_mem_readw(addr, val);
+    return val;
+}
+
+static const MemoryRegionOps lasi_82596_mem_ops = {
+    .read = lasi_82596_mem_read,
+    .write = lasi_82596_mem_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static NetClientInfo net_lasi_82596_info = {
+    .type = NET_CLIENT_DRIVER_NIC,
+    .size = sizeof(NICState),
+    .can_receive = i82596_can_receive,
+    .receive = i82596_receive,
+    .link_status_changed = i82596_set_link_status,
+};
+
+static const VMStateDescription vmstate_lasi_82596 = {
+    .name = "i82596",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT(state, SysBusI82596State, 0, vmstate_i82596,
+                I82596State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void lasi_82596_realize(DeviceState *dev, Error **errp)
+{
+    SysBusI82596State *d = SYSBUS_I82596(dev);
+    I82596State *s = &d->state;
+
+    memory_region_init_io(&s->mmio, OBJECT(d), &lasi_82596_mem_ops, d,
+                "lasi_82596-mmio", PA_GET_MACADDR + 4);
+
+    i82596_common_init(dev, s, &net_lasi_82596_info);
+}
+
+SysBusI82596State *lasi_82596_init(MemoryRegion *addr_space,
+                  hwaddr hpa, qemu_irq lan_irq)
+{
+    DeviceState *dev;
+    SysBusI82596State *s;
+    static const MACAddr HP_MAC = {
+        .a = { 0x08, 0x00, 0x09, 0xef, 0x34, 0xf6 } };
+
+    qemu_check_nic_model(&nd_table[0], TYPE_LASI_82596);
+    dev = qdev_create(NULL, TYPE_LASI_82596);
+    s = SYSBUS_I82596(dev);
+    s->state.irq = lan_irq;
+    qdev_set_nic_properties(dev, &nd_table[0]);
+    qdev_init_nofail(dev);
+    s->state.conf.macaddr = HP_MAC; /* set HP MAC prefix */
+
+    /* LASI 82596 ports in main memory. */
+    memory_region_add_subregion(addr_space, hpa, &s->state.mmio);
+    return s;
+}
+
+static void lasi_82596_reset(DeviceState *dev)
+{
+    SysBusI82596State *d = SYSBUS_I82596(dev);
+
+    i82596_h_reset(&d->state);
+}
+
+static void lasi_82596_instance_init(Object *obj)
+{
+    SysBusI82596State *d = SYSBUS_I82596(obj);
+    I82596State *s = &d->state;
+
+    device_add_bootindex_property(obj, &s->conf.bootindex,
+                                  "bootindex", "/ethernet-phy@0",
+                                  DEVICE(obj), NULL);
+}
+
+static Property lasi_82596_properties[] = {
+    DEFINE_NIC_PROPERTIES(SysBusI82596State, state.conf),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void lasi_82596_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = lasi_82596_realize;
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+    dc->fw_name = "ethernet";
+    dc->reset = lasi_82596_reset;
+    dc->vmsd = &vmstate_lasi_82596;
+    dc->props = lasi_82596_properties;
+    dc->user_creatable = false;
+}
+
+static const TypeInfo lasi_82596_info = {
+    .name          = TYPE_LASI_82596,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(SysBusI82596State),
+    .class_init    = lasi_82596_class_init,
+    .instance_init = lasi_82596_instance_init,
+};
+
+static void lasi_82596_register_types(void)
+{
+    type_register_static(&lasi_82596_info);
+}
+
+type_init(lasi_82596_register_types)
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 58665655cc..abb71a6a9a 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -367,3 +367,16 @@ virtio_net_announce_notify(void) ""
 virtio_net_announce_timer(int round) "%d"
 virtio_net_handle_announce(int round) "%d"
 virtio_net_post_load_device(void)
+
+# lasi_i82596.c
+lasi_82596_mem_readw(uint64_t addr, uint32_t ret) "addr=0x%"PRIx64" val=0x%04x"
+lasi_82596_mem_writew(uint64_t addr, uint32_t val) "addr=0x%"PRIx64" val=0x%04x"
+
+# i82596.c
+i82596_s_reset(void *s) "%p Reset chip"
+i82596_transmit(uint32_t size, uint32_t addr) "size %u from addr 0x%04x"
+i82596_receive_analysis(const char *s) "%s"
+i82596_receive_packet(size_t sz) "len=%zu"
+i82596_new_mac(const char *id_with_mac) "New MAC for: %s"
+i82596_set_multicast(uint16_t count) "Added %d multicast entries"
+i82596_channel_attention(void *s) "%p: Received CHANNEL ATTENTION"
diff --git a/include/hw/net/lasi_82596.h b/include/hw/net/lasi_82596.h
new file mode 100644
index 0000000000..e76ef8308e
--- /dev/null
+++ b/include/hw/net/lasi_82596.h
@@ -0,0 +1,29 @@
+/*
+ * QEMU LASI i82596 device emulation
+ *
+ * Copyright (c) 201 Helge Deller <deller@gmx.de>
+ *
+ */
+
+#ifndef LASI_82596_H
+#define LASI_82596_H
+
+#include "net/net.h"
+#include "hw/net/i82596.h"
+
+#define TYPE_LASI_82596 "lasi_82596"
+#define SYSBUS_I82596(obj) \
+    OBJECT_CHECK(SysBusI82596State, (obj), TYPE_LASI_82596)
+
+typedef struct {
+    SysBusDevice parent_obj;
+
+    I82596State state;
+    uint16_t last_val;
+    int val_index:1;
+} SysBusI82596State;
+
+SysBusI82596State *lasi_82596_init(MemoryRegion *addr_space,
+                                    hwaddr hpa, qemu_irq irq);
+
+#endif
-- 
2.23.0


