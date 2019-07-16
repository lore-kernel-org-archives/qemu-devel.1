Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711EAC76191
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 02:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FD7F20880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 02:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="majXZKOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD7F20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnDWB-0005BN-6n
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 22:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44428)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hnDVd-00035F-BL
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 22:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hnDVb-0004df-Vm
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 22:48:05 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38770)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hnDVY-0004be-S1; Mon, 15 Jul 2019 22:48:01 -0400
Received: by mail-pf1-x442.google.com with SMTP id y15so8347672pfn.5;
 Mon, 15 Jul 2019 19:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e2dPud5PCxHxMG9QDmjQcp4vS6NKyFk8d+yIr1hiXRY=;
 b=majXZKOd789jiH8CvODQrazuiZotMNH4anIlPhsXdMnJSMFKeYBndaHINWFjhvveC5
 wGldN1idZc0fzjCTflgOajT9lyINsx0/UiGteY/kyqr9Y6X+0r5qdx0rgEPivz03phM9
 dVSwdqUhfdzvBMK3eWjurVStvrAuSUgLSsSaHOL7pmMHLLQ95Ot5+9GnSybFdIPsh6b9
 121dWZwnW9xQKSj7Xt6EyY9P0Vxrp7f7pDYd3BASXE8UJQaZ+b/mW1tF6V0YsUnapOWQ
 5FiM/L5D6mCN62+Mi8HG02lQbB2uZdHxhNWsAHRJPNnQbQ0QSx+K1UPtlNNZbgn7F/BP
 1E1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e2dPud5PCxHxMG9QDmjQcp4vS6NKyFk8d+yIr1hiXRY=;
 b=oDMD6Q46hZ/YtA2Vfkrg8+ylhXgba2abxRwDraDH0dbF33neCUHDWS42Y3pFtbheO9
 MDw6WhI/xmdfRO6wecW8un3Ene4OtsNeC4O6WKIuO7Mb5T/47U/wVwMy1rSFhnCM8SrH
 ZJ5e33i0IVWhPda75+MUB6IM6mg12iyn7kF7YhTl+tSIY5x5PA66lZBus7GvEoDAy7Br
 q4oiYmH1Cm0V+ryck+hYlMMyX5A8kj4xaIXzmQktCgi9ti9VBxUrganhggEUNM1kJUKO
 OysbrBorK2vnc9D+AwW9GNMswwfNBcsfbMaLYQMxVDimbv6QH5icQkqa0iUaL89HVtps
 FPLA==
X-Gm-Message-State: APjAAAU4fH2WE5Mn/BXctSkjQKSyNxYwIcyef2BqohaRd5k1zlgc3Tlv
 3ocTtTUcBoApaDMdNy81EKE=
X-Google-Smtp-Source: APXvYqxsepVTxOnFpMTLu8zaAj4mzscjX+tukDPBMiz9uecGaonsbAmyelq7glsgRf7VH9qAB+nCrA==
X-Received: by 2002:a63:4e60:: with SMTP id o32mr31065659pgl.68.1563245279762; 
 Mon, 15 Jul 2019 19:47:59 -0700 (PDT)
Received: from bobo.local0.net ([203.220.8.141])
 by smtp.gmail.com with ESMTPSA id x8sm16557837pfa.46.2019.07.15.19.47.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 15 Jul 2019 19:47:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 16 Jul 2019 12:47:26 +1000
Message-Id: <20190716024726.17864-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190716024726.17864-1-npiggin@gmail.com>
References: <20190716024726.17864-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v4 5/5] spapr: Implement ibm,suspend-me
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
Cc: Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This has been useful to modify and test the Linux pseries suspend
code but it requires modification to the guest to call it (due to
being gated by other unimplemented features). It is not otherwise
used by Linux yet, but work is slowly progressing there.

This allows a (lightly modified) guest kernel to suspend with
`echo mem > /sys/power/state` and be resumed with system_wakeup
monitor command.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c         | 26 ++++++++++++++++++++++++++
 hw/ppc/spapr_rtas.c    | 32 ++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  7 ++++++-
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5c54e1cb9a..b85d41bb1e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1710,6 +1710,11 @@ static void spapr_machine_reset(MachineState *machine)
     void *fdt;
     int rc;
 
+    if (spapr->suspend_reset) {
+        spapr->suspend_reset = false;
+        return;
+    }
+
     spapr_caps_apply(spapr);
 
     first_ppc_cpu = POWERPC_CPU(first_cpu);
@@ -2721,6 +2726,23 @@ static PCIHostState *spapr_create_default_phb(void)
     return PCI_HOST_BRIDGE(dev);
 }
 
+static Notifier wakeup;
+static void spapr_notify_wakeup(Notifier *notifier, void *data)
+{
+    WakeupReason *reason = data;
+
+    switch (*reason) {
+    case QEMU_WAKEUP_REASON_RTC:
+        break;
+    case QEMU_WAKEUP_REASON_PMTIMER:
+        break;
+    case QEMU_WAKEUP_REASON_OTHER:
+        break;
+    default:
+        break;
+    }
+}
+
 /* pSeries LPAR / sPAPR hardware init */
 static void spapr_machine_init(MachineState *machine)
 {
@@ -3078,6 +3100,10 @@ static void spapr_machine_init(MachineState *machine)
 
     qemu_register_boot_set(spapr_boot_set, spapr);
 
+    wakeup.notify = spapr_notify_wakeup;
+    qemu_register_wakeup_notifier(&wakeup);
+    qemu_register_wakeup_support();
+
     if (kvm_enabled()) {
         /* to stop and start vmclock */
         qemu_add_vm_change_state_handler(cpu_ppc_clock_vm_state_change,
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index a618a2ac0f..60a007ec38 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -216,6 +216,36 @@ static void rtas_stop_self(PowerPCCPU *cpu, SpaprMachineState *spapr,
     qemu_cpu_kick(cs);
 }
 
+static void rtas_ibm_suspend_me(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           uint32_t token, uint32_t nargs,
+                           target_ulong args,
+                           uint32_t nret, target_ulong rets)
+{
+    CPUState *cs;
+
+    if (nargs != 0 || nret != 1) {
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        return;
+    }
+
+    CPU_FOREACH(cs) {
+        PowerPCCPU *c = POWERPC_CPU(cs);
+        CPUPPCState *e = &c->env;
+        if (c == cpu)
+            continue;
+
+	/* See h_join */
+        if (!cs->halted || (e->msr & (1ULL << MSR_EE))) {
+            rtas_st(rets, 0, H_MULTI_THREADS_ACTIVE);
+            return;
+        }
+    }
+
+    spapr->suspend_reset = true;
+    qemu_system_suspend_request();
+    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+}
+
 static inline int sysparm_st(target_ulong addr, target_ulong len,
                              const void *val, uint16_t vallen)
 {
@@ -483,6 +513,8 @@ static void core_rtas_register_types(void)
                         rtas_query_cpu_stopped_state);
     spapr_rtas_register(RTAS_START_CPU, "start-cpu", rtas_start_cpu);
     spapr_rtas_register(RTAS_STOP_SELF, "stop-self", rtas_stop_self);
+    spapr_rtas_register(RTAS_IBM_SUSPEND_ME, "ibm,suspend-me",
+                        rtas_ibm_suspend_me);
     spapr_rtas_register(RTAS_IBM_GET_SYSTEM_PARAMETER,
                         "ibm,get-system-parameter",
                         rtas_ibm_get_system_parameter);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 5d36eec9d0..df0b0c15da 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -171,6 +171,10 @@ struct SpaprMachineState {
     bool use_hotplug_event_source;
     SpaprEventSource *event_sources;
 
+    /* Machine has been suspended, so the next machine_reset should not
+     * reset state, but just return and allow execution to resume. */
+    bool suspend_reset;
+
     /* ibm,client-architecture-support option negotiation */
     bool cas_reboot;
     bool cas_legacy_guest_workaround;
@@ -631,8 +635,9 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
 #define RTAS_IBM_CREATE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x27)
 #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x28)
 #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x29)
+#define RTAS_IBM_SUSPEND_ME                     (RTAS_TOKEN_BASE + 0x2A)
 
-#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2A)
+#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2B)
 
 /* RTAS ibm,get-system-parameter token values */
 #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
-- 
2.20.1


