Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FDFC38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46CBB20753
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VE/Gb0uM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CBB20753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWYqh-0000QE-9S
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 01:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWYhy-0007g0-CN; Thu, 07 May 2020 01:04:30 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:56607)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWYhw-0007du-QH; Thu, 07 May 2020 01:04:30 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49HhFn6kNnz9sSx; Thu,  7 May 2020 15:04:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1588827853;
 bh=+QbVUd1UgLdlY1lqI5xNAI7XHDlOWMlYunUoNKLLV3s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VE/Gb0uM2mlbyjxEk0AZ/Xo1st4ZBqFl8gm71qUmbZ9HGcNelCeQmQ2F886JmgHpb
 ANE4GegUyXYQw175M6GxLZDv7ByLLyEs3vVKr3/wVFJd/vr7Xvom2qUp6ukWF8cS7m
 xP8zP/i5scZPOHIO+cuEJQqt/z1tiqkxiNq31hUY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 07/18] spapr: Drop CAS reboot flag
Date: Thu,  7 May 2020 15:02:17 +1000
Message-Id: <20200507050228.802395-8-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200507050228.802395-1-david@gibson.dropbear.id.au>
References: <20200507050228.802395-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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

From: Greg Kurz <groug@kaod.org>

The CAS reboot flag is false by default and all the locations that
could set it to true have been dropped. This means that all code
blocks depending on the flag being set is dead code and the other
code blocks should be executed always.

Just do that and drop the now uneeded CAS reboot flag. Fix a
comment on the way to make checkpatch happy.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <158514994893.478799.11772512888322840990.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         | 18 ++++--------------
 hw/ppc/spapr_hcall.c   | 33 ++++++++++++++-------------------
 include/hw/ppc/spapr.h |  1 -
 3 files changed, 18 insertions(+), 34 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f52488d397..841b5ec59b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1579,9 +1579,7 @@ void spapr_setup_hpt(SpaprMachineState *spapr)
 {
     int hpt_shift;
 
-    if ((spapr->resize_hpt == SPAPR_RESIZE_HPT_DISABLED)
-        || (spapr->cas_reboot
-            && !spapr_ovec_test(spapr->ov5_cas, OV5_HPT_RESIZE))) {
+    if (spapr->resize_hpt == SPAPR_RESIZE_HPT_DISABLED) {
         hpt_shift = spapr_hpt_shift_for_ramsize(MACHINE(spapr)->maxram_size);
     } else {
         uint64_t current_ram_size;
@@ -1645,16 +1643,10 @@ static void spapr_machine_reset(MachineState *machine)
 
     qemu_devices_reset();
 
-    /*
-     * If this reset wasn't generated by CAS, we should reset our
-     * negotiated options and start from scratch
-     */
-    if (!spapr->cas_reboot) {
-        spapr_ovec_cleanup(spapr->ov5_cas);
-        spapr->ov5_cas = spapr_ovec_new();
+    spapr_ovec_cleanup(spapr->ov5_cas);
+    spapr->ov5_cas = spapr_ovec_new();
 
-        ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
-    }
+    ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
 
     /*
      * This is fixing some of the default configuration of the XIVE
@@ -1707,8 +1699,6 @@ static void spapr_machine_reset(MachineState *machine)
     spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, 0, fdt_addr, 0);
     first_ppc_cpu->env.gpr[5] = 0;
 
-    spapr->cas_reboot = false;
-
     spapr->fwnmi_system_reset_addr = -1;
     spapr->fwnmi_machine_check_addr = -1;
     spapr->fwnmi_machine_check_interlock = -1;
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 48a8745514..0f54988f2e 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1678,6 +1678,7 @@ target_ulong do_client_architecture_support(PowerPCCPU *cpu,
     bool raw_mode_supported = false;
     bool guest_xive;
     CPUState *cs;
+    void *fdt;
 
     /* CAS is supposed to be called early when only the boot vCPU is active. */
     CPU_FOREACH(cs) {
@@ -1818,27 +1819,21 @@ target_ulong do_client_architecture_support(PowerPCCPU *cpu,
 
     spapr_handle_transient_dev_before_cas(spapr);
 
-    if (!spapr->cas_reboot) {
-        void *fdt;
-
-        /* If spapr_machine_reset() did not set up a HPT but one is necessary
-         * (because the guest isn't going to use radix) then set it up here. */
-        if ((spapr->patb_entry & PATE1_GR) && !guest_radix) {
-            /* legacy hash or new hash: */
-            spapr_setup_hpt(spapr);
-        }
-
-        fdt = spapr_build_fdt(spapr, false, fdt_bufsize);
-
-        g_free(spapr->fdt_blob);
-        spapr->fdt_size = fdt_totalsize(fdt);
-        spapr->fdt_initial_size = spapr->fdt_size;
-        spapr->fdt_blob = fdt;
+    /*
+     * If spapr_machine_reset() did not set up a HPT but one is necessary
+     * (because the guest isn't going to use radix) then set it up here.
+     */
+    if ((spapr->patb_entry & PATE1_GR) && !guest_radix) {
+        /* legacy hash or new hash: */
+        spapr_setup_hpt(spapr);
     }
 
-    if (spapr->cas_reboot) {
-        qemu_system_reset_request(SHUTDOWN_CAUSE_SUBSYSTEM_RESET);
-    }
+    fdt = spapr_build_fdt(spapr, false, fdt_bufsize);
+
+    g_free(spapr->fdt_blob);
+    spapr->fdt_size = fdt_totalsize(fdt);
+    spapr->fdt_initial_size = spapr->fdt_size;
+    spapr->fdt_blob = fdt;
 
     return H_SUCCESS;
 }
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index b7e13e5aaf..e579eaf28c 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -178,7 +178,6 @@ struct SpaprMachineState {
     SpaprEventSource *event_sources;
 
     /* ibm,client-architecture-support option negotiation */
-    bool cas_reboot;
     bool cas_pre_isa3_guest;
     SpaprOptionVector *ov5;         /* QEMU-supported option vectors */
     SpaprOptionVector *ov5_cas;     /* negotiated (via CAS) option vectors */
-- 
2.26.2


