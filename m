Received: from eggs.gnu.org ([2001:4830:134:3::10]:46710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cvg3Q-0003Aa-2q
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:12:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cvg3M-0006vU-TL
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:12:36 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cvg3M-0006ug-Mt
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:12:32 -0400
Received: by mail-wm0-x243.google.com with SMTP id o81so1297250wmb.0
	for <qemu-devel@nongnu.org>; Wed, 05 Apr 2017 01:12:32 -0700 (PDT)
Received: from donizetti.lan (94-39-149-222.adsl-ull.clienti.tiscali.it.
	[94.39.149.222]) by smtp.gmail.com with ESMTPSA id
	u189sm11483864wmg.18.2017.04.05.01.12.29 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Apr 2017 01:12:29 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Apr 2017 10:12:09 +0200
Message-Id: <20170405081209.26814-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9] tco: do not generate an NMI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This behavior is not indicated in the datasheet and can confuse the OS.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/acpi/tco.c          | 2 --
 hw/isa/lpc_ich9.c      | 5 -----
 include/hw/i386/ich9.h | 1 -
 3 files changed, 8 deletions(-)

diff --git a/hw/acpi/tco.c b/hw/acpi/tco.c
index b4adac8..05b9d7b 100644
--- a/hw/acpi/tco.c
+++ b/hw/acpi/tco.c
@@ -75,8 +75,6 @@ static void tco_timer_expired(void *opaque)
 
     if (pm->smi_en & ICH9_PMIO_SMI_EN_TCO_EN) {
         ich9_generate_smi();
-    } else {
-        ich9_generate_nmi();
     }
     tr->tco.rld = tr->tco.tmr;
     tco_timer_reload(tr);
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 59930dd..a0866c3 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -312,11 +312,6 @@ void ich9_generate_smi(void)
     cpu_interrupt(first_cpu, CPU_INTERRUPT_SMI);
 }
 
-void ich9_generate_nmi(void)
-{
-    cpu_interrupt(first_cpu, CPU_INTERRUPT_NMI);
-}
-
 static int ich9_lpc_sci_irq(ICH9LPCState *lpc)
 {
     switch (lpc->d.config[ICH9_LPC_ACPI_CTRL] &
diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
index 18dcca7..673d13d 100644
--- a/include/hw/i386/ich9.h
+++ b/include/hw/i386/ich9.h
@@ -21,7 +21,6 @@ void ich9_lpc_pm_init(PCIDevice *pci_lpc, bool smm_enabled);
 I2CBus *ich9_smb_init(PCIBus *bus, int devfn, uint32_t smb_io_base);
 
 void ich9_generate_smi(void);
-void ich9_generate_nmi(void);
 
 #define ICH9_CC_SIZE (16 * 1024) /* 16KB. Chipset configuration registers */
 
-- 
2.9.3
