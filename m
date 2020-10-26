Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EA1C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5CA822263
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHpE67mY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CA822263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX3is-0003At-VM
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX3WD-0004Bz-Bl
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:30:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21384)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX3WB-0007zy-4s
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603722638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G0aQcEKzxl9mU1pGa/tulErPIBkfTI0EJwleZBBrc3U=;
 b=YHpE67mYuDF+eT4RgRwBSgmG+lpCJm6pNlECH0cAtMIAXCpqpqZ2A/7lgHDL3my0InfDE6
 7XrE6YknOnZs2pQ6zK05OS9ZIdijZmzKJDGmKx/0x6J+3YL+qoo+4rNn7BwAZlA2kBVLvc
 jen8OzqhK+ob5+bN1b2qAwsr+tQ7Z20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-SuzlOrguNqyCLPsxB_c0ZQ-1; Mon, 26 Oct 2020 10:30:35 -0400
X-MC-Unique: SuzlOrguNqyCLPsxB_c0ZQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BD321016CE2;
 Mon, 26 Oct 2020 14:30:34 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF5895C1C5;
 Mon, 26 Oct 2020 14:30:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/15] ppc: remove bios_name
Date: Mon, 26 Oct 2020 10:30:23 -0400
Message-Id: <20201026143028.3034018-11-pbonzini@redhat.com>
In-Reply-To: <20201026143028.3034018-1-pbonzini@redhat.com>
References: <20201026143028.3034018-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ppc/e500.c          | 4 ++--
 hw/ppc/mac_newworld.c  | 4 +---
 hw/ppc/mac_oldworld.c  | 4 +---
 hw/ppc/pnv.c           | 5 +----
 hw/ppc/ppc405_boards.c | 6 ++----
 hw/ppc/prep.c          | 4 +---
 hw/ppc/spapr.c         | 4 +---
 7 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index ae39b9358e..153a74c98c 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1035,7 +1035,7 @@ void ppce500_init(MachineState *machine)
      * -kernel to users but allows them to run through u-boot as well.
      */
     kernel_as_payload = false;
-    if (bios_name == NULL) {
+    if (machine->firmware == NULL) {
         if (machine->kernel_filename) {
             payload_name = machine->kernel_filename;
             kernel_as_payload = true;
@@ -1043,7 +1043,7 @@ void ppce500_init(MachineState *machine)
             payload_name = "u-boot.e500";
         }
     } else {
-        payload_name = bios_name;
+        payload_name = machine->firmware;
     }
 
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, payload_name);
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index f9a1cc8944..61c63819df 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -109,6 +109,7 @@ static void ppc_core99_reset(void *opaque)
 static void ppc_core99_init(MachineState *machine)
 {
     ram_addr_t ram_size = machine->ram_size;
+    const char *bios_name = machine->firmware ?: PROM_FILENAME;
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
@@ -161,9 +162,6 @@ static void ppc_core99_init(MachineState *machine)
                            &error_fatal);
     memory_region_add_subregion(get_system_memory(), PROM_BASE, bios);
 
-    if (!bios_name) {
-        bios_name = PROM_FILENAME;
-    }
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
     if (filename) {
         /* Load OpenBIOS (ELF) */
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 6c59aa5601..11623e8e67 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -83,6 +83,7 @@ static void ppc_heathrow_reset(void *opaque)
 static void ppc_heathrow_init(MachineState *machine)
 {
     ram_addr_t ram_size = machine->ram_size;
+    const char *bios_name = machine->firmware ?: PROM_FILENAME;
     const char *boot_device = machine->boot_order;
     PowerPCCPU *cpu = NULL;
     CPUPPCState *env = NULL;
@@ -130,9 +131,6 @@ static void ppc_heathrow_init(MachineState *machine)
                            &error_fatal);
     memory_region_add_subregion(get_system_memory(), PROM_BASE, bios);
 
-    if (!bios_name) {
-        bios_name = PROM_FILENAME;
-    }
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
     if (filename) {
         /* Load OpenBIOS (ELF) */
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d9e52873ea..f2b1ee83d3 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -713,6 +713,7 @@ static void pnv_chip_power10_pic_print_info(PnvChip *chip, Monitor *mon)
 
 static void pnv_init(MachineState *machine)
 {
+    const char *bios_name = machine->firmware ?: FW_FILE_NAME;
     PnvMachineState *pnv = PNV_MACHINE(machine);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     char *fw_filename;
@@ -739,10 +740,6 @@ static void pnv_init(MachineState *machine)
     pnv->pnor = PNV_PNOR(dev);
 
     /* load skiboot firmware  */
-    if (bios_name == NULL) {
-        bios_name = FW_FILE_NAME;
-    }
-
     fw_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
     if (!fw_filename) {
         error_report("Could not find OPAL firmware '%s'", bios_name);
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 4687715b15..c867e46330 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -141,6 +141,7 @@ static void ref405ep_fpga_init(MemoryRegion *sysmem, uint32_t base)
 static void ref405ep_init(MachineState *machine)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const char *bios_name = machine->firmware ?: BIOS_FILENAME;
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
@@ -206,8 +207,6 @@ static void ref405ep_init(MachineState *machine)
         memory_region_init_rom(bios, NULL, "ef405ep.bios", BIOS_SIZE,
                                &error_fatal);
 
-        if (bios_name == NULL)
-            bios_name = BIOS_FILENAME;
         filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
         if (filename) {
             bios_size = load_image_size(filename,
@@ -425,6 +424,7 @@ static void taihu_cpld_init(MemoryRegion *sysmem, uint32_t base)
 static void taihu_405ep_init(MachineState *machine)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const char *bios_name = machine->firmware ?: BIOS_FILENAME;
     const char *kernel_filename = machine->kernel_filename;
     const char *initrd_filename = machine->initrd_filename;
     char *filename;
@@ -475,8 +475,6 @@ static void taihu_405ep_init(MachineState *machine)
     } else
 #endif
     {
-        if (bios_name == NULL)
-            bios_name = BIOS_FILENAME;
         bios = g_new(MemoryRegion, 1);
         memory_region_init_rom(bios, NULL, "taihu_405ep.bios", BIOS_SIZE,
                                &error_fatal);
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 4a0cb434a6..c6b9d1ddcb 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -237,6 +237,7 @@ static int prep_set_cmos_checksum(DeviceState *dev, void *opaque)
 
 static void ibm_40p_init(MachineState *machine)
 {
+    const char *bios_name = machine->firmware ?: "openbios-ppc";
     CPUPPCState *env = NULL;
     uint16_t cmos_checksum;
     PowerPCCPU *cpu;
@@ -271,9 +272,6 @@ static void ibm_40p_init(MachineState *machine)
 
     /* PCI host */
     dev = qdev_new("raven-pcihost");
-    if (!bios_name) {
-        bios_name = "openbios-ppc";
-    }
     qdev_prop_set_string(dev, "bios-name", bios_name);
     qdev_prop_set_uint32(dev, "elf-machine", PPC_ELF_MACHINE);
     pcihost = SYS_BUS_DEVICE(dev);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 63315f2d0f..667d59e5ad 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2647,6 +2647,7 @@ static void spapr_machine_init(MachineState *machine)
     SpaprMachineState *spapr = SPAPR_MACHINE(machine);
     SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const char *bios_name = machine->firmware ?: FW_FILE_NAME;
     const char *kernel_filename = machine->kernel_filename;
     const char *initrd_filename = machine->initrd_filename;
     PCIHostState *phb;
@@ -2970,9 +2971,6 @@ static void spapr_machine_init(MachineState *machine)
         }
     }
 
-    if (bios_name == NULL) {
-        bios_name = FW_FILE_NAME;
-    }
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
     if (!filename) {
         error_report("Could not find LPAR firmware '%s'", bios_name);
-- 
2.26.2



