Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4BEC38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:05:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27EFF20753
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HpF4vHZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27EFF20753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWYjG-000135-7z
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 01:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWYhx-0007dc-Jc; Thu, 07 May 2020 01:04:29 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49789 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWYhv-0007Yq-TV; Thu, 07 May 2020 01:04:29 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49HhFn60kDz9sSs; Thu,  7 May 2020 15:04:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1588827853;
 bh=tHs+GfOOXl50YkrqHGHK5Hke1db7bRi2ie5q1tvX20Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HpF4vHZl351iaZSG1FI+VW43wAnOlp6QoRi6jtrKhakW7q6f5wkMp6zBhnfwyPd0C
 SRadgUj1LzKPaa6NGbwRXRbQ5D7JqQGQ8E9bZzt0jXV056DNmq4C8QKiohFKLoav+F
 2avZY70yn22lBfbt/Okq4ie+egL+Pg3eYb2vRfJs=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 06/18] spapr/cas: Separate CAS handling from rebuilding the FDT
Date: Thu,  7 May 2020 15:02:16 +1000
Message-Id: <20200507050228.802395-7-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200507050228.802395-1-david@gibson.dropbear.id.au>
References: <20200507050228.802395-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 01:04:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, npiggin@gmail.com, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

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
Message-Id: <20200310050733.29805-3-aik@ozlabs.ru>
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <158514994229.478799.2178881312094922324.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         |  1 -
 hw/ppc/spapr_hcall.c   | 67 ++++++++++++++++++++++++++----------------
 include/hw/ppc/spapr.h |  7 +++++
 3 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 167b1216ba..f52488d397 100644
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
index fb4fdd4a0c..48a8745514 100644
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
     SpaprOptionVector *ov1_guest, *ov5_guest;
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
@@ -1824,7 +1820,6 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
 
     if (!spapr->cas_reboot) {
         void *fdt;
-        SpaprDeviceTreeUpdateHeader hdr = { .version_id = 1 };
 
         /* If spapr_machine_reset() did not set up a HPT but one is necessary
          * (because the guest isn't going to use radix) then set it up here. */
@@ -1833,21 +1828,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
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
@@ -1862,6 +1843,40 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
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
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 42d64a0368..b7e13e5aaf 100644
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
@@ -566,6 +568,11 @@ void spapr_register_hypercall(target_ulong opcode, spapr_hcall_fn fn);
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
-- 
2.26.2


