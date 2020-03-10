Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53D7C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 05:09:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9F8724655
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 05:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F8724655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBX8l-0005Sx-QZ
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 01:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1jBX7o-00047v-FW
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 01:08:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1jBX7n-0001gN-1J
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 01:08:16 -0400
Received: from [107.174.27.60] (port=46294 helo=ozlabs.ru)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>)
 id 1jBX7m-0001fS-Ow; Tue, 10 Mar 2020 01:08:14 -0400
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 7F881AE800ED;
 Tue, 10 Mar 2020 01:06:02 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH qemu v8 2/3] spapr/cas: Separate CAS handling from rebuilding
 the FDT
Date: Tue, 10 Mar 2020 16:07:32 +1100
Message-Id: <20200310050733.29805-3-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310050733.29805-1-aik@ozlabs.ru>
References: <20200310050733.29805-1-aik@ozlabs.ru>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 107.174.27.60
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At the moment "ibm,client-architecture-support" ("CAS") is implemented
in SLOF and QEMU assists via the custom H_CAS hypercall which copies
an updated flatten device tree (FDT) blob to the SLOF memory which
it then uses to update its internal tree.

When we enable the OpenFirmware client interface in QEMU, we won't need
to copy the FDT to the guest as the client is expected to fetch
the device tree using the client interface.

This moves FDT rebuild out to a separate helper which is going to be
called from the "ibm,client-architecture-support" handler and leaves
writing FDT to the guest in the H_CAS handler.

This should not cause any behavioral change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/hw/ppc/spapr.h |  7 +++++
 hw/ppc/spapr.c         |  1 -
 hw/ppc/spapr_hcall.c   | 67 ++++++++++++++++++++++++++----------------
 3 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 2015e37ac5c8..692e2d7c003b 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -102,6 +102,8 @@ typedef enum {
 #define SPAPR_CAP_FIXED_CCD             0x03
 #define SPAPR_CAP_FIXED_NA              0x10 /* Lets leave a bit of a gap... */
 
+#define FDT_MAX_SIZE                    0x100000
+
 typedef struct SpaprCapabilities SpaprCapabilities;
 struct SpaprCapabilities {
     uint8_t caps[SPAPR_CAP_NUM];
@@ -558,6 +560,11 @@ void spapr_register_hypercall(target_ulong opcode, spapr_hcall_fn fn);
 target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
                              target_ulong *args);
 
+target_ulong do_client_architecture_support(PowerPCCPU *cpu,
+                                            SpaprMachineState *spapr,
+                                            target_ulong addr,
+                                            target_ulong fdt_bufsize);
+
 /* Virtual Processor Area structure constants */
 #define VPA_MIN_SIZE           640
 #define VPA_SIZE_OFFSET        0x4
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 64bc8b83e91e..8c245a812bd3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -96,7 +96,6 @@
  *
  * We load our kernel at 4M, leaving space for SLOF initial image
  */
-#define FDT_MAX_SIZE            0x100000
 #define RTAS_MAX_ADDR           0x80000000 /* RTAS must stay below that */
 #define FW_MAX_SIZE             0x400000
 #define FW_FILE_NAME            "slof.bin"
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 40c86e91eb89..ae3b6c3f4cbd 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1665,16 +1665,12 @@ static void spapr_handle_transient_dev_before_cas(SpaprMachineState *spapr)
     spapr_clear_pending_hotplug_events(spapr);
 }
 
-static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
-                                                  SpaprMachineState *spapr,
-                                                  target_ulong opcode,
-                                                  target_ulong *args)
+target_ulong do_client_architecture_support(PowerPCCPU *cpu,
+                                            SpaprMachineState *spapr,
+                                            target_ulong vec,
+                                            target_ulong fdt_bufsize)
 {
-    /* Working address in data buffer */
-    target_ulong addr = ppc64_phys_to_real(args[0]);
-    target_ulong fdt_buf = args[1];
-    target_ulong fdt_bufsize = args[2];
-    target_ulong ov_table;
+    target_ulong ov_table; /* Working address in data buffer */
     uint32_t cas_pvr;
     SpaprOptionVector *ov1_guest, *ov5_guest, *ov5_cas_old;
     bool guest_radix;
@@ -1694,7 +1690,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
         }
     }
 
-    cas_pvr = cas_check_pvr(spapr, cpu, &addr, &raw_mode_supported, &local_err);
+    cas_pvr = cas_check_pvr(spapr, cpu, &vec, &raw_mode_supported, &local_err);
     if (local_err) {
         error_report_err(local_err);
         return H_HARDWARE;
@@ -1717,7 +1713,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     }
 
     /* For the future use: here @ov_table points to the first option vector */
-    ov_table = addr;
+    ov_table = vec;
 
     ov1_guest = spapr_ovec_parse_vector(ov_table, 1);
     if (!ov1_guest) {
@@ -1839,7 +1835,6 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
 
     if (!spapr->cas_reboot) {
         void *fdt;
-        SpaprDeviceTreeUpdateHeader hdr = { .version_id = 1 };
 
         /* If spapr_machine_reset() did not set up a HPT but one is necessary
          * (because the guest isn't going to use radix) then set it up here. */
@@ -1848,21 +1843,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
             spapr_setup_hpt(spapr);
         }
 
-        if (fdt_bufsize < sizeof(hdr)) {
-            error_report("SLOF provided insufficient CAS buffer "
-                         TARGET_FMT_lu " (min: %zu)", fdt_bufsize, sizeof(hdr));
-            exit(EXIT_FAILURE);
-        }
-
-        fdt_bufsize -= sizeof(hdr);
-
         fdt = spapr_build_fdt(spapr, false, fdt_bufsize);
-        _FDT((fdt_pack(fdt)));
-
-        cpu_physical_memory_write(fdt_buf, &hdr, sizeof(hdr));
-        cpu_physical_memory_write(fdt_buf + sizeof(hdr), fdt,
-                                  fdt_totalsize(fdt));
-        trace_spapr_cas_continue(fdt_totalsize(fdt) + sizeof(hdr));
 
         g_free(spapr->fdt_blob);
         spapr->fdt_size = fdt_totalsize(fdt);
@@ -1877,6 +1858,40 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
 
+static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
+                                                  SpaprMachineState *spapr,
+                                                  target_ulong opcode,
+                                                  target_ulong *args)
+{
+    target_ulong vec = ppc64_phys_to_real(args[0]);
+    target_ulong fdt_buf = args[1];
+    target_ulong fdt_bufsize = args[2];
+    target_ulong ret;
+    SpaprDeviceTreeUpdateHeader hdr = { .version_id = 1 };
+
+    if (fdt_bufsize < sizeof(hdr)) {
+        error_report("SLOF provided insufficient CAS buffer "
+                     TARGET_FMT_lu " (min: %zu)", fdt_bufsize, sizeof(hdr));
+        exit(EXIT_FAILURE);
+    }
+
+    fdt_bufsize -= sizeof(hdr);
+
+    ret = do_client_architecture_support(cpu, spapr, vec, fdt_bufsize);
+    if (ret == H_SUCCESS) {
+        _FDT((fdt_pack(spapr->fdt_blob)));
+        spapr->fdt_size = fdt_totalsize(spapr->fdt_blob);
+        spapr->fdt_initial_size = spapr->fdt_size;
+
+        cpu_physical_memory_write(fdt_buf, &hdr, sizeof(hdr));
+        cpu_physical_memory_write(fdt_buf + sizeof(hdr), spapr->fdt_blob,
+                                  spapr->fdt_size);
+        trace_spapr_cas_continue(spapr->fdt_size + sizeof(hdr));
+    }
+
+    return ret;
+}
+
 static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
                                               SpaprMachineState *spapr,
                                               target_ulong opcode,
-- 
2.17.1


