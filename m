Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC44CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 04:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07F532075C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 04:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F532075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNUWJ-0006im-5E
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 00:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1iNUVN-0005o9-JH
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 00:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1iNUVL-0007MR-LR
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 00:13:44 -0400
Received: from ozlabs.ru ([107.173.13.209]:48252)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>)
 id 1iNUVL-0007J2-E7; Thu, 24 Oct 2019 00:13:43 -0400
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 92391AE80026;
 Thu, 24 Oct 2019 00:12:24 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH qemu] spapr: Add /choses to FDT only at reset time to preserve
 kernel and initramdisk
Date: Thu, 24 Oct 2019 15:13:08 +1100
Message-Id: <20191024041308.5673-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 107.173.13.209
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since "spapr: Render full FDT on ibm,client-architecture-support" we build
the entire flatten device tree (FDT) twice - at the reset time and
when "ibm,client-architecture-support" (CAS) is called. The full FDT from
CAS is then applied on top of the SLOF internal device tree.

This is mostly ok, however there is a case when the QEMU is started with
-initrd and for some reason the guest decided to move/unpack the init RAM
disk image - the guest correctly notifies SLOF about the change but
at CAS it is overridden with the QEMU initial location addresses and
the guest may fail to boot if the original initrd memory was changed.

This fixes the problem by only adding the /chosen node at the reset time
to prevent the original QEMU's linux,initrd-start/linux,initrd-end to
override the updated addresses.

This only treats /chosen differently as we know there is a special case
already and it is unlikely anything else will need to change /chosen at CAS
we are better off not touching /chosen after we handed it over to SLOF.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/ppc/spapr.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d4c07a9b1bab..0580789a1509 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -925,7 +925,7 @@ static bool spapr_hotplugged_dev_before_cas(void)
     return false;
 }
 
-static void *spapr_build_fdt(SpaprMachineState *spapr);
+static void *spapr_build_fdt(SpaprMachineState *spapr, bool reset);
 
 int spapr_h_cas_compose_response(SpaprMachineState *spapr,
                                  target_ulong addr, target_ulong size,
@@ -947,7 +947,7 @@ int spapr_h_cas_compose_response(SpaprMachineState *spapr,
 
     size -= sizeof(hdr);
 
-    fdt = spapr_build_fdt(spapr);
+    fdt = spapr_build_fdt(spapr, false);
     _FDT((fdt_pack(fdt)));
 
     if (fdt_totalsize(fdt) + sizeof(hdr) > size) {
@@ -1205,7 +1205,7 @@ static void spapr_dt_hypervisor(SpaprMachineState *spapr, void *fdt)
     }
 }
 
-static void *spapr_build_fdt(SpaprMachineState *spapr)
+static void *spapr_build_fdt(SpaprMachineState *spapr, bool reset)
 {
     MachineState *machine = MACHINE(spapr);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
@@ -1305,7 +1305,9 @@ static void *spapr_build_fdt(SpaprMachineState *spapr)
     spapr_dt_rtas(spapr, fdt);
 
     /* /chosen */
-    spapr_dt_chosen(spapr, fdt);
+    if (reset) {
+        spapr_dt_chosen(spapr, fdt);
+    }
 
     /* /hypervisor */
     if (kvm_enabled()) {
@@ -1313,11 +1315,14 @@ static void *spapr_build_fdt(SpaprMachineState *spapr)
     }
 
     /* Build memory reserve map */
-    if (spapr->kernel_size) {
-        _FDT((fdt_add_mem_rsv(fdt, KERNEL_LOAD_ADDR, spapr->kernel_size)));
-    }
-    if (spapr->initrd_size) {
-        _FDT((fdt_add_mem_rsv(fdt, spapr->initrd_base, spapr->initrd_size)));
+    if (reset) {
+        if (spapr->kernel_size) {
+            _FDT((fdt_add_mem_rsv(fdt, KERNEL_LOAD_ADDR, spapr->kernel_size)));
+        }
+        if (spapr->initrd_size) {
+            _FDT((fdt_add_mem_rsv(fdt, spapr->initrd_base,
+                                  spapr->initrd_size)));
+        }
     }
 
     /* ibm,client-architecture-support updates */
@@ -1726,7 +1731,7 @@ static void spapr_machine_reset(MachineState *machine)
      */
     fdt_addr = MIN(spapr->rma_size, RTAS_MAX_ADDR) - FDT_MAX_SIZE;
 
-    fdt = spapr_build_fdt(spapr);
+    fdt = spapr_build_fdt(spapr, true);
 
     rc = fdt_pack(fdt);
 
-- 
2.17.1


