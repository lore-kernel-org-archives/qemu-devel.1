Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EEDC7618F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:30:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 475C420873
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475C420873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoeCc-0004O5-GA
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 21:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44029)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aik@ozlabs.ru>) id 1hoeBv-0001WL-1Z
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:29:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1hoeBt-0003ay-Nv
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:29:38 -0400
Received: from ozlabs.ru ([107.173.13.209]:59146)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>)
 id 1hoeBt-0003ar-FS; Fri, 19 Jul 2019 21:29:37 -0400
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 0A804AE807F4;
 Fri, 19 Jul 2019 21:28:59 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: qemu-devel@nongnu.org
Date: Sat, 20 Jul 2019 11:28:50 +1000
Message-Id: <20190720012850.14369-5-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190720012850.14369-1-aik@ozlabs.ru>
References: <20190720012850.14369-1-aik@ozlabs.ru>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 107.173.13.209
Subject: [Qemu-devel] [PATCH qemu RFC 4/4] spapr: Implement SLOF-less
 client_architecture_support
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

QEMU already implements H_CAS called by SLOF. The existing handler
prepares a diff FDT and SLOF applies it on top of its current tree.
In SLOF-less setup when the user explicitly selected "bios=no",
this updates the FDT from the OS, updates it and writes back to the OS.
The new behavior is advertised to the OS via "/chosen/qemu,h_cas".

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/hw/ppc/spapr.h |  5 +++++
 hw/ppc/spapr.c         | 24 ++++++++++++++++-----
 hw/ppc/spapr_hcall.c   | 49 +++++++++++++++++++++++++++++++++++++++---
 3 files changed, 70 insertions(+), 8 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 7f5d7a70d27e..73cd9cf25b83 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -766,9 +766,14 @@ struct SpaprEventLogEntry {
 
 void spapr_events_init(SpaprMachineState *sm);
 void spapr_dt_events(SpaprMachineState *sm, void *fdt);
+int spapr_h_cas_do_compose_response(SpaprMachineState *spapr, void *fdt,
+                                    SpaprOptionVector *ov5_updates);
 int spapr_h_cas_compose_response(SpaprMachineState *sm,
                                  target_ulong addr, target_ulong size,
                                  SpaprOptionVector *ov5_updates);
+#define FDT_MAX_SIZE 0x100000
+void *spapr_build_fdt(SpaprMachineState *spapr);
+
 void close_htab_fd(SpaprMachineState *spapr);
 void spapr_setup_hpt_and_vrma(SpaprMachineState *spapr);
 void spapr_free_hpt(SpaprMachineState *spapr);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b097a99951f1..f84895f4a8b4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -978,6 +978,19 @@ static bool spapr_hotplugged_dev_before_cas(void)
     return false;
 }
 
+int spapr_h_cas_do_compose_response(SpaprMachineState *spapr, void *fdt,
+                                    SpaprOptionVector *ov5_updates)
+{
+    /* Fixup cpu nodes */
+    _FDT((spapr_fixup_cpu_dt(fdt, spapr)));
+
+    if (spapr_dt_cas_updates(spapr, fdt, ov5_updates)) {
+        return -1;
+    }
+
+    return 0;
+}
+
 int spapr_h_cas_compose_response(SpaprMachineState *spapr,
                                  target_ulong addr, target_ulong size,
                                  SpaprOptionVector *ov5_updates)
@@ -1009,10 +1022,7 @@ int spapr_h_cas_compose_response(SpaprMachineState *spapr,
     _FDT((fdt_open_into(fdt_skel, fdt, size)));
     g_free(fdt_skel);
 
-    /* Fixup cpu nodes */
-    _FDT((spapr_fixup_cpu_dt(fdt, spapr)));
-
-    if (spapr_dt_cas_updates(spapr, fdt, ov5_updates)) {
+    if (spapr_h_cas_do_compose_response(spapr, fdt, ov5_updates)) {
         return -1;
     }
 
@@ -1232,6 +1242,10 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt)
 
     /* We always implemented RTAS as hcall, tell guests to call it directly */
     _FDT(fdt_setprop_cell(fdt, chosen, "qemu,h_rtas", 1));
+    /* Tell the guest that H_CAS will return the entire FDT now, not the diff */
+    if (!spapr->bios_enabled) {
+        _FDT(fdt_setprop_cell(fdt, chosen, "qemu,h_cas", 1));
+    }
 
     spapr_dt_ov5_platform_support(spapr, fdt, chosen);
 
@@ -1262,7 +1276,7 @@ static void spapr_dt_hypervisor(SpaprMachineState *spapr, void *fdt)
     }
 }
 
-static void *spapr_build_fdt(SpaprMachineState *spapr)
+void *spapr_build_fdt(SpaprMachineState *spapr)
 {
     MachineState *machine = MACHINE(spapr);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index b964d94f330b..c5cb06c9d507 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -17,6 +17,7 @@
 #include "hw/ppc/spapr_ovec.h"
 #include "mmu-book3s-v3.h"
 #include "hw/mem/memory-device.h"
+#include "sysemu/device_tree.h"
 
 static bool has_spr(PowerPCCPU *cpu, int spr)
 {
@@ -1774,9 +1775,51 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
             /* legacy hash or new hash: */
             spapr_setup_hpt_and_vrma(spapr);
         }
-        spapr->cas_reboot =
-            (spapr_h_cas_compose_response(spapr, args[1], args[2],
-                                          ov5_updates) != 0);
+
+        if (spapr->bios_enabled) {
+            spapr->cas_reboot =
+                (spapr_h_cas_compose_response(spapr, args[1], args[2],
+                                              ov5_updates) != 0);
+        } else {
+            int size;
+            void *fdt, *fdt_skel;
+            struct fdt_header hdr = { 0 };
+
+            cpu_physical_memory_read(args[1], &hdr, sizeof(hdr));
+            size = fdt32_to_cpu(hdr.totalsize);
+            if (size > FDT_MAX_SIZE) {
+                return H_NOT_AVAILABLE;
+            }
+
+            fdt_skel = g_malloc0(size);
+            cpu_physical_memory_read(args[1], fdt_skel, size);
+
+            fdt = g_malloc0(FDT_MAX_SIZE);
+            fdt_open_into(fdt_skel, fdt, FDT_MAX_SIZE);
+            g_free(fdt_skel);
+
+            if (spapr_h_cas_do_compose_response(spapr, fdt, ov5_updates)) {
+                g_free(fdt);
+                return H_NOT_AVAILABLE;
+            }
+            fdt_pack(fdt);
+            if (fdt_totalsize(fdt) > FDT_MAX_SIZE) {
+                error_report("FDT too big ! 0x%x bytes (max is 0x%x)",
+                             fdt_totalsize(fdt), FDT_MAX_SIZE);
+                g_free(fdt);
+                return H_NOT_AVAILABLE;
+            }
+
+            /* Load the fdt */
+            cpu_physical_memory_write(args[1], fdt, fdt_totalsize(fdt));
+
+            g_free(spapr->fdt_blob);
+            spapr->fdt_size = fdt_totalsize(fdt);
+            spapr->fdt_initial_size = spapr->fdt_size;
+            spapr->fdt_blob = fdt;
+
+            qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
+        }
     }
 
     /*
-- 
2.17.1


