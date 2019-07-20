Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429A9C7618F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:30:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B3B220873
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3B220873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoeCO-0003Qw-AW
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 21:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43973)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aik@ozlabs.ru>) id 1hoeBo-00010o-6r
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:29:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1hoeBn-0003Xu-43
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:29:32 -0400
Received: from ozlabs.ru ([107.173.13.209]:59116)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>)
 id 1hoeBm-0003XN-TR; Fri, 19 Jul 2019 21:29:31 -0400
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 7CF3AAE807E6;
 Fri, 19 Jul 2019 21:28:53 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: qemu-devel@nongnu.org
Date: Sat, 20 Jul 2019 11:28:47 +1000
Message-Id: <20190720012850.14369-2-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190720012850.14369-1-aik@ozlabs.ru>
References: <20190720012850.14369-1-aik@ozlabs.ru>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 107.173.13.209
Subject: [Qemu-devel] [PATCH qemu RFC 1/4] spapr: Allow changing kernel
 loading address
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
Cc: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 qemu-ppc@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Useful for the debugging purposes.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/hw/ppc/spapr.h |  1 +
 hw/ppc/spapr.c         | 33 +++++++++++++++++++++++++++------
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 74e427b588fc..ff82bb8554e1 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -159,6 +159,7 @@ struct SpaprMachineState {
     void *fdt_blob;
     long kernel_size;
     bool kernel_le;
+    uint64_t kernel_addr;
     uint32_t initrd_base;
     long initrd_size;
     uint64_t rtc_offset; /* Now used only during incoming migration */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 7fad42350538..6d13d65d8996 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1179,7 +1179,7 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt)
                           spapr->initrd_base + spapr->initrd_size));
 
     if (spapr->kernel_size) {
-        uint64_t kprop[2] = { cpu_to_be64(KERNEL_LOAD_ADDR),
+        uint64_t kprop[2] = { cpu_to_be64(spapr->kernel_addr),
                               cpu_to_be64(spapr->kernel_size) };
 
         _FDT(fdt_setprop(fdt, chosen, "qemu,boot-kernel",
@@ -1365,7 +1365,7 @@ static void *spapr_build_fdt(SpaprMachineState *spapr)
 
     /* Build memory reserve map */
     if (spapr->kernel_size) {
-        _FDT((fdt_add_mem_rsv(fdt, KERNEL_LOAD_ADDR, spapr->kernel_size)));
+        _FDT((fdt_add_mem_rsv(fdt, spapr->kernel_addr, spapr->kernel_size)));
     }
     if (spapr->initrd_size) {
         _FDT((fdt_add_mem_rsv(fdt, spapr->initrd_base, spapr->initrd_size)));
@@ -1391,7 +1391,8 @@ static void *spapr_build_fdt(SpaprMachineState *spapr)
 
 static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
 {
-    return (addr & 0x0fffffff) + KERNEL_LOAD_ADDR;
+    SpaprMachineState *spapr = opaque;
+    return (addr & 0x0fffffff) + spapr->kernel_addr;
 }
 
 static void emulate_spapr_hypercall(PPCVirtualHypervisor *vhyp,
@@ -2995,12 +2996,12 @@ static void spapr_machine_init(MachineState *machine)
         uint64_t lowaddr = 0;
 
         spapr->kernel_size = load_elf(kernel_filename, NULL,
-                                      translate_kernel_address, NULL,
+                                      translate_kernel_address, spapr,
                                       NULL, &lowaddr, NULL, 1,
                                       PPC_ELF_MACHINE, 0, 0);
         if (spapr->kernel_size == ELF_LOAD_WRONG_ENDIAN) {
             spapr->kernel_size = load_elf(kernel_filename, NULL,
-                                          translate_kernel_address, NULL, NULL,
+                                          translate_kernel_address, spapr, NULL,
                                           &lowaddr, NULL, 0, PPC_ELF_MACHINE,
                                           0, 0);
             spapr->kernel_le = spapr->kernel_size > 0;
@@ -3016,7 +3017,7 @@ static void spapr_machine_init(MachineState *machine)
             /* Try to locate the initrd in the gap between the kernel
              * and the firmware. Add a bit of space just in case
              */
-            spapr->initrd_base = (KERNEL_LOAD_ADDR + spapr->kernel_size
+            spapr->initrd_base = (spapr->kernel_addr + spapr->kernel_size
                                   + 0x1ffff) & ~0xffff;
             spapr->initrd_size = load_image_targphys(initrd_filename,
                                                      spapr->initrd_base,
@@ -3253,6 +3254,18 @@ static void spapr_set_vsmt(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, (uint32_t *)opaque, errp);
 }
 
+static void spapr_get_kernel_addr(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    visit_type_uint64(v, name, (uint64_t *)opaque, errp);
+}
+
+static void spapr_set_kernel_addr(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    visit_type_uint64(v, name, (uint64_t *)opaque, errp);
+}
+
 static char *spapr_get_ic_mode(Object *obj, Error **errp)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(obj);
@@ -3358,6 +3371,14 @@ static void spapr_instance_init(Object *obj)
     object_property_add_bool(obj, "vfio-no-msix-emulation",
                              spapr_get_msix_emulation, NULL, NULL);
 
+    object_property_add(obj, "kernel-addr", "uint64", spapr_get_kernel_addr,
+                        spapr_set_kernel_addr, NULL, &spapr->kernel_addr,
+                        &error_abort);
+    object_property_set_description(obj, "kernel-addr",
+                                    stringify(KERNEL_LOAD_ADDR)
+                                    " for -kernel is the default",
+                                    NULL);
+    spapr->kernel_addr = KERNEL_LOAD_ADDR;
     /* The machine class defines the default interrupt controller mode */
     spapr->irq = smc->irq;
     object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,
-- 
2.17.1


