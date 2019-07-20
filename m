Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADD3C76195
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0182020873
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0182020873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoeCA-0002Ss-Va
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 21:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43998)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aik@ozlabs.ru>) id 1hoeBq-0001BQ-HW
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:29:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1hoeBp-0003Yk-A6
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:29:34 -0400
Received: from ozlabs.ru ([107.173.13.209]:59138)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>)
 id 1hoeBp-0003Yb-2b; Fri, 19 Jul 2019 21:29:33 -0400
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id A4BBEAE807F2;
 Fri, 19 Jul 2019 21:28:55 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: qemu-devel@nongnu.org
Date: Sat, 20 Jul 2019 11:28:48 +1000
Message-Id: <20190720012850.14369-3-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190720012850.14369-1-aik@ozlabs.ru>
References: <20190720012850.14369-1-aik@ozlabs.ru>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 107.173.13.209
Subject: [Qemu-devel] [PATCH qemu RFC 2/4] spapr: Allow bios-less
 configuration
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

The pseries kernel can do either usual prom-init boot or kexec style boot.
We always did the prom-init which relies on the completeness of
the device tree (for example, PCI BARs have to be assigned beforehand) and
the client interface; the system firmware (SLOF) implements this.

However we can use the kexec style boot as well. To do that, we can skip
loading SLOF and jump straight to the kernel. GPR5==0 (the client
interface entry point, SLOF passes a valid pointer there) tells Linux to
do the kexec boot rather than prom_init so it can proceed to the initramfs.
With few PCI fixes in the guest kernel, it can boot from PCI (via
petitboot, for example).

This adds a "bios" machine option which controls whether QEMU loads SLOF
or jumps directly to the kernel. When bios==off, this does not copy SLOF
and RTAS into the guest RAM and sets RTAS properties to 0 to bypass
the kexec user space tool which checks for their presence (not for
the values though).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/hw/ppc/spapr.h |  1 +
 hw/ppc/spapr.c         | 58 ++++++++++++++++++++++++++++++++----------
 2 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index ff82bb8554e1..7f5d7a70d27e 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -160,6 +160,7 @@ struct SpaprMachineState {
     long kernel_size;
     bool kernel_le;
     uint64_t kernel_addr;
+    bool bios_enabled;
     uint32_t initrd_base;
     long initrd_size;
     uint64_t rtc_offset; /* Now used only during incoming migration */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6d13d65d8996..81ad6a6f28de 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1116,6 +1116,10 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
     _FDT(fdt_setprop(fdt, rtas, "ibm,lrdr-capacity",
                      lrdr_capacity, sizeof(lrdr_capacity)));
 
+    /* These are to make kexec-lite happy */
+    _FDT(fdt_setprop_cell(fdt, rtas, "linux,rtas-base", 0));
+    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-size", 0));
+
     spapr_dt_rtas_tokens(fdt, rtas);
 }
 
@@ -1814,7 +1818,11 @@ static void spapr_machine_reset(MachineState *machine)
     spapr->fdt_blob = fdt;
 
     /* Set up the entry state */
-    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr);
+    if (!spapr->bios_enabled) {
+        spapr_cpu_set_entry_state(first_ppc_cpu, spapr->kernel_addr, fdt_addr);
+    } else {
+        spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr);
+    }
     first_ppc_cpu->env.gpr[5] = 0;
 
     spapr->cas_reboot = false;
@@ -3031,20 +3039,22 @@ static void spapr_machine_init(MachineState *machine)
         }
     }
 
-    if (bios_name == NULL) {
-        bios_name = FW_FILE_NAME;
+    if (spapr->bios_enabled) {
+        if (bios_name == NULL) {
+            bios_name = FW_FILE_NAME;
+        }
+        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+        if (!filename) {
+            error_report("Could not find LPAR firmware '%s'", bios_name);
+            exit(1);
+        }
+        fw_size = load_image_targphys(filename, 0, FW_MAX_SIZE);
+        if (fw_size <= 0) {
+            error_report("Could not load LPAR firmware '%s'", filename);
+            exit(1);
+        }
+        g_free(filename);
     }
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
-    if (!filename) {
-        error_report("Could not find LPAR firmware '%s'", bios_name);
-        exit(1);
-    }
-    fw_size = load_image_targphys(filename, 0, FW_MAX_SIZE);
-    if (fw_size <= 0) {
-        error_report("Could not load LPAR firmware '%s'", filename);
-        exit(1);
-    }
-    g_free(filename);
 
     /* FIXME: Should register things through the MachineState's qdev
      * interface, this is a legacy from the sPAPREnvironment structure
@@ -3266,6 +3276,20 @@ static void spapr_set_kernel_addr(Object *obj, Visitor *v, const char *name,
     visit_type_uint64(v, name, (uint64_t *)opaque, errp);
 }
 
+static bool spapr_get_bios_enabled(Object *obj, Error **errp)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(obj);
+
+    return spapr->bios_enabled;
+}
+
+static void spapr_set_bios_enabled(Object *obj, bool value, Error **errp)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(obj);
+
+    spapr->bios_enabled = value;
+}
+
 static char *spapr_get_ic_mode(Object *obj, Error **errp)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(obj);
@@ -3379,6 +3403,12 @@ static void spapr_instance_init(Object *obj)
                                     " for -kernel is the default",
                                     NULL);
     spapr->kernel_addr = KERNEL_LOAD_ADDR;
+    object_property_add_bool(obj, "bios", spapr_get_bios_enabled,
+                            spapr_set_bios_enabled, NULL);
+    object_property_set_description(obj, "bios", "Conrols whether to load bios",
+                                    NULL);
+    spapr->bios_enabled = true;
+
     /* The machine class defines the default interrupt controller mode */
     spapr->irq = smc->irq;
     object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,
-- 
2.17.1


