Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2B3C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 11:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC512086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 11:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC512086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyaNs-0002X1-Cw
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 07:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1hyaLF-0008KI-Ap
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 07:24:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hyaLE-0008Ha-1Z
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 07:24:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59568)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hyaLD-0008H5-Q9
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 07:24:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1709AC0272DE;
 Fri, 16 Aug 2019 11:24:19 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B9B943FEA;
 Fri, 16 Aug 2019 11:24:16 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 07:24:07 -0400
Message-Id: <20190816112407.28180-3-imammedo@redhat.com>
In-Reply-To: <20190816112407.28180-1-imammedo@redhat.com>
References: <20190816112407.28180-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 16 Aug 2019 11:24:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [POC Seabios PATCH] seabios: use isolated SMM address
 space for relocation
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
Cc: "Chen, Yingwen" <yingwen.chen@intel.com>,
 edk2-devel-groups-io <devel@edk2.groups.io>,
 Phillip Goerl <phillip.goerl@oracle.com>, "Yao, Jiewen" <jiewen.yao@intel.com>,
 "Nakajima, Jun" <jun.nakajima@intel.com>, pbonzini@redhat.com,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 edk2-rfc-groups-io <rfc@edk2.groups.io>, Laszlo Ersek <lersek@redhat.com>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

for purpose of demo SMRAM (at 0x30000) is aliased at a0000 in system address space
for easy initialization of SMI entry point.
Here is resulting debug output showing that RAM at 0x30000 is not affected
by SMM and only RAM in SMM adderss space is modified:

init smm
smm_relocate: before relocaten
smm_relocate: RAM codeentry 0
smm_relocate: RAM  cpu.i64.smm_base  0
smm_relocate: SMRAM  codeentry f000c831eac88c
smm_relocate: SMRAM  cpu.i64.smm_base  0
handle_smi cmd=0 smbase=0x00030000
smm_relocate: after relocaten
smm_relocate: RAM codeentry 0
smm_relocate: RAM  cpu.i64.smm_base  0
smm_relocate: SMRAM  codeentry f000c831eac88c
smm_relocate: SMRAM  cpu.i64.smm_base  a0000

Patch depends on QEMU POC patch that adds SMRAM at 0x30000 in SMM address space

PS:
configure bios with level 9 debugging and debug port

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 src/fw/smm.c | 43 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/src/fw/smm.c b/src/fw/smm.c
index d90e43a9..27f9747e 100644
--- a/src/fw/smm.c
+++ b/src/fw/smm.c
@@ -140,21 +140,22 @@ extern void entry_smi(void);
                   | ((u64)((u32)entry_smi - BUILD_BIOS_ADDR) << 24))
 
 static void
-smm_save_and_copy(void)
+smm_relocate(void)
 {
-    // save original memory content
     struct smm_layout *initsmm = (void*)BUILD_SMM_INIT_ADDR;
     struct smm_layout *smm = (void*)BUILD_SMM_ADDR;
-    memcpy(&smm->cpu, &initsmm->cpu, sizeof(smm->cpu));
-    memcpy(&smm->codeentry, &initsmm->codeentry, sizeof(smm->codeentry));
 
-    // Setup code entry point.
-    initsmm->codeentry = SMI_INSN;
-}
+    dprintf(3, "smm_relocate: before relocaten\n");
+    dprintf(3, "smm_relocate: RAM codeentry %llx\n", initsmm->codeentry);
+    dprintf(3, "smm_relocate: RAM  cpu.i64.smm_base  %lx\n", initsmm->cpu.i64.smm_base);
+
+
+    /* BUILD_SMM_ADDR aliased to BUILD_SMM_INIT_ADDR in SMM AS
+     * so we could set SMI entry point there */
+    smm->codeentry = SMI_INSN;
+    dprintf(3, "smm_relocate: SMRAM  codeentry %llx\n", smm->codeentry);
+    dprintf(3, "smm_relocate: SMRAM  cpu.i64.smm_base  %lx\n", smm->cpu.i64.smm_base);
 
-static void
-smm_relocate_and_restore(void)
-{
     /* init APM status port */
     outb(0x01, PORT_SMI_STATUS);
 
@@ -165,15 +166,13 @@ smm_relocate_and_restore(void)
     while (inb(PORT_SMI_STATUS) != 0x00)
         ;
 
-    /* restore original memory content */
-    struct smm_layout *initsmm = (void*)BUILD_SMM_INIT_ADDR;
-    struct smm_layout *smm = (void*)BUILD_SMM_ADDR;
-    memcpy(&initsmm->cpu, &smm->cpu, sizeof(initsmm->cpu));
-    memcpy(&initsmm->codeentry, &smm->codeentry, sizeof(initsmm->codeentry));
-
-    // Setup code entry point.
-    smm->codeentry = SMI_INSN;
     wbinvd();
+
+    dprintf(3, "smm_relocate: after relocaten\n");
+    dprintf(3, "smm_relocate: RAM codeentry %llx\n", initsmm->codeentry);
+    dprintf(3, "smm_relocate: RAM  cpu.i64.smm_base  %lx\n", initsmm->cpu.i64.smm_base);
+    dprintf(3, "smm_relocate: SMRAM  codeentry %llx\n", smm->codeentry);
+    dprintf(3, "smm_relocate: SMRAM  cpu.i64.smm_base  %lx\n", smm->cpu.i64.smm_base);
 }
 
 // This code is hardcoded for PIIX4 Power Management device.
@@ -187,8 +186,6 @@ static void piix4_apmc_smm_setup(int isabdf, int i440_bdf)
     /* enable the SMM memory window */
     pci_config_writeb(i440_bdf, I440FX_SMRAM, 0x02 | 0x48);
 
-    smm_save_and_copy();
-
     /* enable SMI generation when writing to the APMC register */
     pci_config_writel(isabdf, PIIX_DEVACTB, value | PIIX_DEVACTB_APMC_EN);
 
@@ -196,7 +193,7 @@ static void piix4_apmc_smm_setup(int isabdf, int i440_bdf)
     value = inl(acpi_pm_base + PIIX_PMIO_GLBCTL);
     outl(value | PIIX_PMIO_GLBCTL_SMI_EN, acpi_pm_base + PIIX_PMIO_GLBCTL);
 
-    smm_relocate_and_restore();
+    smm_relocate();
 
     /* close the SMM memory window and enable normal SMM */
     pci_config_writeb(i440_bdf, I440FX_SMRAM, 0x02 | 0x08);
@@ -213,8 +210,6 @@ void ich9_lpc_apmc_smm_setup(int isabdf, int mch_bdf)
     /* enable the SMM memory window */
     pci_config_writeb(mch_bdf, Q35_HOST_BRIDGE_SMRAM, 0x02 | 0x48);
 
-    smm_save_and_copy();
-
     /* enable SMI generation when writing to the APMC register */
     outl(value | ICH9_PMIO_SMI_EN_APMC_EN | ICH9_PMIO_SMI_EN_GLB_SMI_EN,
          acpi_pm_base + ICH9_PMIO_SMI_EN);
@@ -224,7 +219,7 @@ void ich9_lpc_apmc_smm_setup(int isabdf, int mch_bdf)
     pci_config_writel(isabdf, ICH9_LPC_GEN_PMCON_1,
                       value | ICH9_LPC_GEN_PMCON_1_SMI_LOCK);
 
-    smm_relocate_and_restore();
+    smm_relocate();
 
     /* close the SMM memory window and enable normal SMM */
     pci_config_writeb(mch_bdf, Q35_HOST_BRIDGE_SMRAM, 0x02 | 0x08);
-- 
2.18.1


