Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D691CC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:04:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D9B20674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKQMHxj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D9B20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE4P4-0008EF-Ej
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 01:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jE4Nq-0006hF-Ou
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jE4Np-0001CI-GY
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:03:18 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43315)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jE4Nm-0000d9-Sm; Tue, 17 Mar 2020 01:03:15 -0400
Received: by mail-pg1-x543.google.com with SMTP id u12so11022010pgb.10;
 Mon, 16 Mar 2020 22:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FpkqH7lKgv3hBCPD1KWrNB8YKsLdSFik7uBKlmMW2Hc=;
 b=rKQMHxj19vqhmOULQpa3tDb/GIUmhqwquUQWj9wFye3LxUR+0B6BPuWFj5y45hLWX8
 lwjV4V5Qx8D0UQ/Vjlhtoh3NRTh/VJ2ASR8XX6Gg3Qx495Y0LMrvyqYy6oPlkGG/WVxY
 u4/3MeIriXoAyeKRs/c0g5ML0EcNrjdLgxYWUtg/I3FxU0wLONu0pEZ+9umTQLyK33f+
 iagqE47+eCApIkdnWamD+EwvQg9ENjsOgD0I3I7uyd19KnlFuxizvIr/StJ/TorYd3rH
 yzl5VT+5NDRiCZEWR3TLBMadlTyeuiLKhc7T2iqjlWJBTktSxk+BzYrq2RUBtTKh1gxB
 U91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FpkqH7lKgv3hBCPD1KWrNB8YKsLdSFik7uBKlmMW2Hc=;
 b=rwRi2PCn5WhrN0po7rSuuD2eM8ipIEJtmnissWbVM1mbYKD9muZca9ccnVPe4Fpn/Z
 rPIAVFrK4kkhF64rOExoyIDvjMkJ3AVpvveWZgezUTzE2x2UaRf98vq9nH3GxnOvxKaJ
 0OE4vD/f1ydiNAxOAUtB55BLIQreM6u0QIYP3AH3iBnotDaFF6v9qdINLOUl/H+HLj2y
 lHbCY/qsSD+vi8hoHkLd2Rjb7Pq1QuxQEK4sf5R7USfosvCHc6sA120pKHMOAyrUEQ1I
 26kD46zUU/T37SwzU1jDJI/SaSqTXPv6bZDIiIC2mqm+108UPUHqygNBRqS9h5II8cbl
 1UAQ==
X-Gm-Message-State: ANhLgQ01OstglbFKRmehJX9/duudPAktFgMx6/XRYMlOY3O95ZqZ842j
 wfL7Ij8hPkd93AVrfG5bdDG8T7ERiTI=
X-Google-Smtp-Source: ADFU+vt9wEos5Ya4Xsc+pLppAGYONPDN2ZFLQUBljyHqor1TDqM90pO2muQVuh/NA+4DheBpe243LQ==
X-Received: by 2002:a63:ec50:: with SMTP id r16mr3449405pgj.274.1584421393504; 
 Mon, 16 Mar 2020 22:03:13 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (14-202-190-183.tpgi.com.au.
 [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id k67sm994803pga.91.2020.03.16.22.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 22:03:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH 1/5] ppc/spapr: KVM FWNMI should not be enabled until guest
 requests it
Date: Tue, 17 Mar 2020 15:02:11 +1000
Message-Id: <20200317050215.159334-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200317050215.159334-1-npiggin@gmail.com>
References: <20200317050215.159334-1-npiggin@gmail.com>
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The KVM FWNMI capability should be enabled with the "ibm,nmi-register"
rtas call. Although MCEs from KVM will be delivered as architected
interrupts to the guest before "ibm,nmi-register" is called, KVM has
different behaviour depending on whether the guest has enabled FWNMI
(it attempts to do more recovery on behalf of a non-FWNMI guest).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_caps.c  | 5 +++--
 hw/ppc/spapr_rtas.c  | 7 +++++++
 target/ppc/kvm.c     | 7 +++++++
 target/ppc/kvm_ppc.h | 6 ++++++
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 679ae7959f..eb5521d0c2 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -517,9 +517,10 @@ static void cap_fwnmi_apply(SpaprMachineState *spapr, uint8_t val,
     }
 
     if (kvm_enabled()) {
-        if (kvmppc_set_fwnmi() < 0) {
+        if (!kvmppc_get_fwnmi()) {
             error_setg(errp, "Firmware Assisted Non-Maskable Interrupts(FWNMI) "
-                             "not supported by KVM");
+                             "not supported by KVM, "
+                             "try appending -machine cap-fwnmi=off");
         }
     }
 }
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 9fb8c8632a..29abe66d01 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -437,6 +437,13 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
         return;
     }
 
+    if (kvm_enabled()) {
+        if (kvmppc_set_fwnmi() < 0) {
+            rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
+            return;
+        }
+    }
+
     spapr->fwnmi_system_reset_addr = sreset_addr;
     spapr->fwnmi_machine_check_addr = mce_addr;
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 597f72be1b..03d0667e8f 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -88,6 +88,7 @@ static int cap_ppc_safe_indirect_branch;
 static int cap_ppc_count_cache_flush_assist;
 static int cap_ppc_nested_kvm_hv;
 static int cap_large_decr;
+static int cap_fwnmi;
 
 static uint32_t debug_inst_opcode;
 
@@ -136,6 +137,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     kvmppc_get_cpu_characteristics(s);
     cap_ppc_nested_kvm_hv = kvm_vm_check_extension(s, KVM_CAP_PPC_NESTED_HV);
     cap_large_decr = kvmppc_get_dec_bits();
+    cap_fwnmi = kvm_vm_check_extension(s, KVM_CAP_PPC_FWNMI);
     /*
      * Note: setting it to false because there is not such capability
      * in KVM at this moment.
@@ -2064,6 +2066,11 @@ void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy)
     }
 }
 
+bool kvmppc_get_fwnmi(void)
+{
+    return cap_fwnmi;
+}
+
 int kvmppc_set_fwnmi(void)
 {
     PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 332fa0aa1c..fcaf745516 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -27,6 +27,7 @@ void kvmppc_enable_h_page_init(void);
 void kvmppc_set_papr(PowerPCCPU *cpu);
 int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
 void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
+bool kvmppc_get_fwnmi(void);
 int kvmppc_set_fwnmi(void);
 int kvmppc_smt_threads(void);
 void kvmppc_error_append_smt_possible_hint(Error *const *errp);
@@ -163,6 +164,11 @@ static inline void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy)
 {
 }
 
+static inline bool kvmppc_get_fwnmi(void)
+{
+    return false;
+}
+
 static inline int kvmppc_set_fwnmi(void)
 {
     return -1;
-- 
2.23.0


