Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD66AC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:25:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA6922527
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiCZnfSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA6922527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifT9c-0004EO-2C
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:25:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifSHE-0005K0-4X
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:29:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifSHB-00041k-VM
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:29:23 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42487)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifSHB-00040F-N6
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:29:21 -0500
Received: by mail-wr1-x441.google.com with SMTP id q6so3602862wro.9
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 09:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PDm0yyqvXq+OhmvJ72i1vFG6mZGav2pTUkONp23jxeo=;
 b=AiCZnfSH1LK8xZxZyopqgaQL0/uU4ETuq7E3i/f5c6Jsx9E7QOdWEJ0Y1fUt2kWimm
 tBsJsvI/lL+gwkKJ8OLw2KtSDdtBnAzi9DMr7K9YThugMOgFsiuy0sfuviWE63AJfAuv
 nQPmXhJ6Z5nXsipRZZeG0R+NY/C1jY6aO4pmQu0dhN2BJyJVXM4pudNjB9wR1ihC3zZt
 RupxY/t4dOWH9ygY9xqeYS5gHoOCWERnhd04FnnP2cxv3dHL65W6+RRyS5caumZQEzB9
 2D8Jjsv2AjnNLlDrYamnCFLxGbiiMERPJITfwz4/kcCuyCJQieZ4S3uVK5Xuf4hYPJoY
 HvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=PDm0yyqvXq+OhmvJ72i1vFG6mZGav2pTUkONp23jxeo=;
 b=f/0dV6B+Ak4vvi5RpSFmFQMETlrxV6yNnidQj3iOzWW27MGWJ9RQxsznjuvxPUPA+k
 27LFCGw7wCD5arGIHlYWik2aSOQhfLFefof+mjyIS9m1KoONLXBBFiPnLA6Cahft6Zrp
 7wuUC/Bk8D4ncHONvsggnHf9V6QF5ZrcKh0aOvRAYlW3BSlBqpWokUE4rgrpzwf96BS/
 sbX7xp1K5oyIFTqqfHPATbz7LTkNC3bkyFnuQ2tPKcUj9YFFEzqmUKPltf7KYBr3jZN6
 0PHCfe/+Ca+W7Acx7F8+YQVAHVieP6JFupQ21GoE0JzgggdPLP1qrGGpFJQbr3sqdGF2
 bUsg==
X-Gm-Message-State: APjAAAU8efoKWPzG7ycvP0ksbOmfvLYBFh+1gDxt7DsZg7BJF+/EJMPV
 lYoXXE0GKAVr9GJNK9UkJrdF6i/o
X-Google-Smtp-Source: APXvYqwm/clmaDCJwlpZHEiemnIZ1sBBN3HiD/7G+Rp0MB5Zhgr1OBg9w9XeeToJ57FDEiFDj22KmA==
X-Received: by 2002:adf:9b83:: with SMTP id d3mr7605358wrc.54.1576171760145;
 Thu, 12 Dec 2019 09:29:20 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id 2sm6810130wrq.31.2019.12.12.09.29.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 09:29:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/8] hw: replace hw/i386/pc.h with a header just for the
 i8259
Date: Thu, 12 Dec 2019 18:29:09 +0100
Message-Id: <1576171754-45138-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576171754-45138-1-git-send-email-pbonzini@redhat.com>
References: <1576171754-45138-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: philmd@redhat.com, slp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove the need to include i386/pc.h to get to the i8259 functions.
This is enough to remove the inclusion of hw/i386/pc.h from all non-x86
files.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/alpha/alpha_sys.h            |  3 ++-
 hw/alpha/dp264.c                |  1 +
 hw/hppa/hppa_sys.h              |  3 ++-
 hw/hppa/machine.c               |  1 +
 hw/i386/kvm/i8259.c             |  1 +
 hw/i386/microvm.c               |  1 +
 hw/i386/pc.c                    |  1 +
 hw/i386/x86.c                   |  1 +
 hw/input/pckbd.c                |  1 -
 hw/intc/Kconfig                 |  2 ++
 hw/intc/apic.c                  |  2 +-
 hw/intc/i8259.c                 |  2 +-
 hw/intc/i8259_common.c          |  2 +-
 hw/intc/ioapic.c                |  3 ++-
 hw/isa/i82378.c                 |  2 +-
 hw/isa/lpc_ich9.c               |  1 -
 hw/isa/piix4.c                  |  2 +-
 hw/mips/gt64xxx_pci.c           |  2 +-
 hw/mips/mips_fulong2e.c         |  2 +-
 hw/mips/mips_jazz.c             |  2 +-
 hw/mips/mips_r4k.c              |  2 +-
 hw/pci-host/bonito.c            |  1 -
 hw/pci-host/prep.c              |  2 +-
 include/hw/i386/pc.h            |  8 --------
 include/hw/intc/i8259.h         | 12 ++++++++++++
 include/hw/isa/i8259_internal.h |  2 +-
 target/i386/monitor.c           |  1 -
 27 files changed, 37 insertions(+), 26 deletions(-)
 create mode 100644 include/hw/intc/i8259.h

diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
index 4e127a6..95033d7 100644
--- a/hw/alpha/alpha_sys.h
+++ b/hw/alpha/alpha_sys.h
@@ -7,7 +7,8 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "hw/ide.h"
-#include "hw/i386/pc.h"
+#include "hw/boards.h"
+#include "hw/intc/i8259.h"
 
 
 PCIBus *typhoon_init(ram_addr_t, ISABus **, qemu_irq *, AlphaCPU *[4],
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 4320497..5ed9a5a 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -20,6 +20,7 @@
 #include "hw/timer/i8254.h"
 #include "hw/isa/superio.h"
 #include "hw/dma/i8257.h"
+#include "net/net.h"
 #include "qemu/cutils.h"
 
 #define MAX_IDE_BUS 2
diff --git a/hw/hppa/hppa_sys.h b/hw/hppa/hppa_sys.h
index 43d25d2..4e50196 100644
--- a/hw/hppa/hppa_sys.h
+++ b/hw/hppa/hppa_sys.h
@@ -6,7 +6,8 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "hw/ide.h"
-#include "hw/i386/pc.h"
+#include "hw/boards.h"
+#include "hw/intc/i8259.h"
 
 #include "hppa_hardware.h"
 
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index b30aba6..5d0de26 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -19,6 +19,7 @@
 #include "hppa_sys.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "net/net.h"
 #include "qemu/log.h"
 
 #define MAX_IDE_BUS 2
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index d0c1b1d..e404fdc 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/isa/i8259_internal.h"
+#include "hw/intc/i8259.h"
 #include "qemu/module.h"
 #include "hw/i386/apic_internal.h"
 #include "hw/irq.h"
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index def37e6..2068319 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -34,6 +34,7 @@
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
 #include "target/i386/cpu.h"
+#include "hw/intc/i8259.h"
 #include "hw/timer/i8254.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/char/serial.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3d2c5d8..fdbd2bf 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -44,6 +44,7 @@
 #include "migration/vmstate.h"
 #include "multiboot.h"
 #include "hw/rtc/mc146818rtc.h"
+#include "hw/intc/i8259.h"
 #include "hw/dma/i8257.h"
 #include "hw/timer/i8254.h"
 #include "hw/input/i8042.h"
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 394edc2..3e4aee5 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -39,6 +39,7 @@
 #include "target/i386/cpu.h"
 #include "hw/i386/topology.h"
 #include "hw/i386/fw_cfg.h"
+#include "hw/intc/i8259.h"
 
 #include "hw/acpi/cpu_hotplug.h"
 #include "hw/nmi.h"
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index f0acfd8..2f09f78 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -26,7 +26,6 @@
 #include "qemu/log.h"
 #include "hw/isa/isa.h"
 #include "migration/vmstate.h"
-#include "hw/i386/pc.h"
 #include "hw/input/ps2.h"
 #include "hw/irq.h"
 #include "hw/input/i8042.h"
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 5347f84..10a680b 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -9,6 +9,7 @@ config PL190
 
 config IOAPIC
     bool
+    select I8259
 
 config ARM_GIC
     bool
@@ -21,6 +22,7 @@ config OPENPIC
 config APIC
     bool
     select MSI_NONBROKEN
+    select I8259
 
 config ARM_GIC_KVM
     bool
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 2a74f7b..bd40467 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -22,10 +22,10 @@
 #include "hw/i386/apic_internal.h"
 #include "hw/i386/apic.h"
 #include "hw/i386/ioapic.h"
+#include "hw/intc/i8259.h"
 #include "hw/pci/msi.h"
 #include "qemu/host-utils.h"
 #include "trace.h"
-#include "hw/i386/pc.h"
 #include "hw/i386/apic-msidef.h"
 #include "qapi/error.h"
 
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 211a989..51b27f6 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/i386/pc.h"
+#include "hw/intc/i8259.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
 #include "qemu/timer.h"
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index bd37bb5..e7b1a10 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -24,7 +24,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/i386/pc.h"
+#include "hw/intc/i8259.h"
 #include "hw/isa/i8259_internal.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index ead14e1..4f55776 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -23,10 +23,11 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "monitor/monitor.h"
-#include "hw/i386/pc.h"
 #include "hw/i386/apic.h"
 #include "hw/i386/ioapic.h"
 #include "hw/i386/ioapic_internal.h"
+#include "hw/i386/x86.h"
+#include "hw/intc/i8259.h"
 #include "hw/pci/msi.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/kvm.h"
diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index de276cd..dcb6b47 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -19,8 +19,8 @@
 
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
-#include "hw/i386/pc.h"
 #include "hw/irq.h"
+#include "hw/intc/i8259.h"
 #include "hw/timer/i8254.h"
 #include "migration/vmstate.h"
 #include "hw/audio/pcspk.h"
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 17c292e..170792a 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -35,7 +35,6 @@
 #include "hw/isa/isa.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "hw/i386/pc.h"
 #include "hw/irq.h"
 #include "hw/isa/apm.h"
 #include "hw/i386/ioapic.h"
diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 86678e6..7edec5e 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -26,11 +26,11 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/irq.h"
-#include "hw/i386/pc.h"
 #include "hw/southbridge/piix.h"
 #include "hw/pci/pci.h"
 #include "hw/isa/isa.h"
 #include "hw/sysbus.h"
+#include "hw/intc/i8259.h"
 #include "hw/dma/i8257.h"
 #include "hw/timer/i8254.h"
 #include "hw/rtc/mc146818rtc.h"
diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index f1af840..b2ea13f 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -30,7 +30,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/southbridge/piix.h"
 #include "migration/vmstate.h"
-#include "hw/i386/pc.h"
+#include "hw/intc/i8259.h"
 #include "hw/irq.h"
 #include "exec/address-spaces.h"
 #include "trace.h"
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 55c143e..6199c54 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -23,7 +23,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "hw/i386/pc.h"
+#include "hw/intc/i8259.h"
 #include "hw/dma/i8257.h"
 #include "hw/isa/superio.h"
 #include "net/net.h"
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index d978bb6..c40b23f 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -26,7 +26,7 @@
 #include "qemu-common.h"
 #include "hw/mips/mips.h"
 #include "hw/mips/cpudevs.h"
-#include "hw/i386/pc.h"
+#include "hw/intc/i8259.h"
 #include "hw/dma/i8257.h"
 #include "hw/char/serial.h"
 #include "hw/char/parallel.h"
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 7002423..fbbd59e 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -15,7 +15,7 @@
 #include "cpu.h"
 #include "hw/mips/mips.h"
 #include "hw/mips/cpudevs.h"
-#include "hw/i386/pc.h"
+#include "hw/intc/i8259.h"
 #include "hw/char/serial.h"
 #include "hw/isa/isa.h"
 #include "net/net.h"
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index ceee463..c924007 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -40,7 +40,6 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "hw/pci/pci.h"
-#include "hw/i386/pc.h"
 #include "hw/irq.h"
 #include "hw/mips/mips.h"
 #include "hw/pci/pci_host.h"
diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 85d7ba9..afa136d 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -32,7 +32,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
-#include "hw/i386/pc.h"
+#include "hw/intc/i8259.h"
 #include "hw/irq.h"
 #include "hw/loader.h"
 #include "hw/or-irq.h"
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 1f86eba..82447f8 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -134,14 +134,6 @@ typedef struct PCMachineClass {
 #define PC_MACHINE_CLASS(klass) \
     OBJECT_CLASS_CHECK(PCMachineClass, (klass), TYPE_PC_MACHINE)
 
-/* i8259.c */
-
-extern DeviceState *isa_pic;
-qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq);
-qemu_irq *kvm_i8259_init(ISABus *bus);
-int pic_read_irq(DeviceState *d);
-int pic_get_output(DeviceState *d);
-
 /* ioapic.c */
 
 /* Global System Interrupts */
diff --git a/include/hw/intc/i8259.h b/include/hw/intc/i8259.h
new file mode 100644
index 0000000..e2b1e8c
--- /dev/null
+++ b/include/hw/intc/i8259.h
@@ -0,0 +1,12 @@
+#ifndef HW_I8259_H
+#define HW_I8259_H
+
+/* i8259.c */
+
+extern DeviceState *isa_pic;
+qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq);
+qemu_irq *kvm_i8259_init(ISABus *bus);
+int pic_get_output(DeviceState *d);
+int pic_read_irq(DeviceState *d);
+
+#endif
diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index ee189e4..861d70d 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -25,9 +25,9 @@
 #ifndef QEMU_I8259_INTERNAL_H
 #define QEMU_I8259_INTERNAL_H
 
-#include "hw/i386/pc.h"
 #include "hw/isa/isa.h"
 #include "hw/intc/intc.h"
+#include "hw/intc/i8259.h"
 
 typedef struct PICCommonState PICCommonState;
 
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 9fb4d64..27ebfa3 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -28,7 +28,6 @@
 #include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 #include "qapi/qmp/qdict.h"
-#include "hw/i386/pc.h"
 #include "sysemu/kvm.h"
 #include "sysemu/sev.h"
 #include "qapi/error.h"
-- 
1.8.3.1



