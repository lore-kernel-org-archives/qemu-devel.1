Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88ADBC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:45:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A03220775
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uHjrQk2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A03220775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7Hv-0000F5-EX
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 10:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jH7FB-0004Ah-QZ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:42:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jH7FA-0005hk-FU
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:42:57 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35540)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jH7F7-0005fJ-S5; Wed, 25 Mar 2020 10:42:53 -0400
Received: by mail-pg1-x543.google.com with SMTP id 7so1245680pgr.2;
 Wed, 25 Mar 2020 07:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m/ATHVgK+NJbwaXqtEE7x40Es4AHu63qi4TjELVQJaI=;
 b=uHjrQk2hO1TNR3Dkzn8Z0JDljurmfo1+CFnRagNIMdqQLssp/oDzaiw0T1NloqsAbJ
 6rFC90qoHPCpVwPL741NxKoTWkEdRklvu3XRmfiKYRxb0zCp0Off+/e7jTA4ZaHNEn90
 HJHJQ9lcs+PRQCP9kImjGjXPhlqTg9VRoqr4Gw0B7Xa5ynpzRp7e0vht++vEmtfU/qAI
 exSVNROHa87XEb9vB2yF3ottvYRnORGpALQbQm+ZpuyJSbuzxX1LR5dJqsIZ7YLdaZ4d
 Dst4UibEAL6n0+W3xEkMfqN6MMnUL211pzz3J9lQCtaGL6/nGqIknulA7DJqIJRtIxOg
 gFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m/ATHVgK+NJbwaXqtEE7x40Es4AHu63qi4TjELVQJaI=;
 b=KqFZslsKaz/M1dlQrv6ntW/DejWzD5AdFGKLb0XP1eqxDSkqzHDOKhb69PMKYDSszQ
 Y69ao+pWsxTg1dwaVkoeymbaiR18W4Swo6DqHfO9QgrUHBNTS5azoqC6qXUeu43ZmE3D
 EOQSjor9sgFMMA+GkCkXL5uyclfxrmUlR19BmS2bDhMN9HJ8lJrmnTcVDzWOQEHx3TT6
 gy4OopxijuUsAATZykP9CLhl0haIKk4xDETMqnSjFV3c4FVgENP9YD9oJvspDuJmT0W0
 KXSYWcg3b0VInl8aILl+hGR/xI0+GcIrtjVPhUD3gGWSls6UCWxxGgs3iw8DMZyZUM13
 YNnQ==
X-Gm-Message-State: ANhLgQ0lWn2Lbjua5k/0y1mkZS+kkbXEFw4g9dfrG1632h0xnZza7/0k
 0Cqu1xmhowbpfnF9xUwNL72M64T+
X-Google-Smtp-Source: ADFU+vvvjh50dC2dY4U4dhMcs8B6iIY3TTrezCVgrCX1jWJ1UXPbn+eg6C24WVVmu5fSRp14TlWHvg==
X-Received: by 2002:a62:194c:: with SMTP id 73mr3774067pfz.159.1585147372620; 
 Wed, 25 Mar 2020 07:42:52 -0700 (PDT)
Received: from bobo.ibm.com (14-202-190-183.tpgi.com.au. [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id 93sm4609599pjo.43.2020.03.25.07.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 07:42:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH 4/5] ppc/spapr: Implement mce injection
Date: Thu, 26 Mar 2020 00:41:46 +1000
Message-Id: <20200325144147.221875-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200325144147.221875-1-npiggin@gmail.com>
References: <20200325144147.221875-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This implements mce injection for spapr.

  (qemu) mce 0 0x200000 0x80 0xdeadbeef 1

    Disabling lock debugging due to kernel taint
    MCE: CPU0: machine check (Severe) Host SLB Multihit DAR: 00000000deadbeef [Recovered]
    MCE: CPU0: machine check (Severe) Host SLB Multihit [Recovered]
    MCE: CPU0: PID: 495 Comm: a NIP: [0000000130ee07c8]
    MCE: CPU0: Initiator CPU
    MCE: CPU0: Unknown
[   71.567193] MCE: CPU0: NIP: [c0000000000d7f6c] plpar_hcall_norets+0x1c/0x28
[   71.567249] MCE: CPU0: Initiator CPU
[   71.567308] MCE: CPU0: Unknown

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c         | 54 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  3 +++
 2 files changed, 57 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 785c41d205..6dbd1858f4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -83,6 +83,7 @@
 #include "hw/ppc/spapr_nvdimm.h"
 
 #include "monitor/monitor.h"
+#include "qapi/qmp/qdict.h"
 
 #include <libfdt.h>
 
@@ -3420,6 +3421,56 @@ static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
     }
 }
 
+typedef struct MCEInjectionParams {
+    uint64_t srr1_mask;
+    uint32_t dsisr;
+    uint64_t dar;
+    bool recovered;
+} MCEInjectionParams;
+
+static void spapr_do_mce_on_cpu(CPUState *cs, run_on_cpu_data data)
+{
+    MCEInjectionParams *params = data.host_ptr;
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+    uint64_t srr1_mce_bits = PPC_BITMASK(42, 45) | PPC_BIT(36);
+
+    cpu_synchronize_state(cs);
+
+    env->spr[SPR_SRR0] = env->nip;
+    env->spr[SPR_SRR1] = (env->msr & ~srr1_mce_bits) |
+                         (params->srr1_mask & srr1_mce_bits);
+    if (params->dsisr) {
+        env->spr[SPR_DSISR] = params->dsisr;
+        env->spr[SPR_DAR] = params->dar;
+    }
+
+    spapr_mce_req_event(cpu, params->recovered);
+}
+
+static void spapr_mce(MCEState *m, const QDict *qdict, Error **errp)
+{
+    int cpu_index = qdict_get_int(qdict, "cpu_index");
+    uint64_t srr1_mask = qdict_get_int(qdict, "srr1_mask");
+    uint32_t dsisr = qdict_get_int(qdict, "dsisr");
+    uint64_t dar = qdict_get_int(qdict, "dar");
+    bool recovered = qdict_get_int(qdict, "recovered");
+    CPUState *cs;
+
+    cs = qemu_get_cpu(cpu_index);
+
+    if (cs != NULL) {
+        MCEInjectionParams params = {
+            .srr1_mask = srr1_mask,
+            .dsisr = dsisr,
+            .dar = dar,
+            .recovered = recovered,
+        };
+
+        run_on_cpu(cs, spapr_do_mce_on_cpu, RUN_ON_CPU_HOST_PTR(&params));
+    }
+}
+
 int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                           void *fdt, int *fdt_start_offset, Error **errp)
 {
@@ -4467,6 +4518,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(oc);
     FWPathProviderClass *fwc = FW_PATH_PROVIDER_CLASS(oc);
     NMIClass *nc = NMI_CLASS(oc);
+    MCEClass *mcec = MCE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
     PPCVirtualHypervisorClass *vhc = PPC_VIRTUAL_HYPERVISOR_CLASS(oc);
     XICSFabricClass *xic = XICS_FABRIC_CLASS(oc);
@@ -4511,6 +4563,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
     fwc->get_dev_path = spapr_get_fw_dev_path;
     nc->nmi_monitor_handler = spapr_nmi;
+    mcec->mce_monitor_handler = spapr_mce;
     smc->phb_placement = spapr_phb_placement;
     vhc->hypercall = emulate_spapr_hypercall;
     vhc->hpt_mask = spapr_hpt_mask;
@@ -4566,6 +4619,7 @@ static const TypeInfo spapr_machine_info = {
     .interfaces = (InterfaceInfo[]) {
         { TYPE_FW_PATH_PROVIDER },
         { TYPE_NMI },
+        { TYPE_MCE },
         { TYPE_HOTPLUG_HANDLER },
         { TYPE_PPC_VIRTUAL_HYPERVISOR },
         { TYPE_XICS_FABRIC },
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 42d64a0368..72f86a2ee8 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -929,4 +929,7 @@ void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
 
 void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
 hwaddr spapr_get_rtas_addr(void);
+
+void spapr_mce_inject(CPUState *cs, uint64_t srr1_mask, uint32_t dsisr,
+                      uint64_t dar, bool recovered);
 #endif /* HW_SPAPR_H */
-- 
2.23.0


