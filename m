Received: from eggs.gnu.org ([2001:4830:134:3::10]:36156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvmpT-0001DM-Ll
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvmpR-0004sE-IQ
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:26:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cvmpR-0004ry-CU
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:26:37 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5633AC059754
	for <qemu-devel@nongnu.org>; Wed,  5 Apr 2017 15:26:36 +0000 (UTC)
Received: from donizetti.redhat.com (unknown [10.36.118.26])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B513A2D653
	for <qemu-devel@nongnu.org>; Wed,  5 Apr 2017 15:26:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Apr 2017 17:26:33 +0200
Message-Id: <20170405152633.6824-2-pbonzini@redhat.com>
In-Reply-To: <20170405152633.6824-1-pbonzini@redhat.com>
References: <20170405152633.6824-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] tco: do not generate an NMI
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
The TCO can trap NMIs from SERR# or IOCHK# and convert them to SMIs; but
any other TCO event is either delivered as an SMI or completely disabled.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
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
