Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E9EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:26:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD7A207BB
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EYC5wxOC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD7A207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7tCh-0002rn-Hf
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 00:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t67-0007If-7v; Tue, 18 Aug 2020 00:19:43 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:53501 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t65-0006L4-3J; Tue, 18 Aug 2020 00:19:42 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BVyNZ35WZz9sTy; Tue, 18 Aug 2020 14:19:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597724366;
 bh=GzchIm7DStOF8X8JiH3RRIrOXxvgBdXuhASFMZERPbs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EYC5wxOCvd5zyWU6ByKFmesYLWF/+KBipCnRrwJ8aQxkN3tQ0hWvjAIZ8RLcyXZvn
 7pUazdKxRzVrWKRzf4vlNbierKP8AdzmcTvyTL1nl1X0Ny2eVBUPAJ6D7lRoGsvPg4
 TJieQT2KkHt6AMP9SNgVlF77LVC7T8dbRtQWIbJE=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org,
	groug@kaod.org
Subject: [PULL 08/40] spapr: Use error_append_hint() in spapr_caps.c
Date: Tue, 18 Aug 2020 14:18:50 +1000
Message-Id: <20200818041922.251708-9-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818041922.251708-1-david@gibson.dropbear.id.au>
References: <20200818041922.251708-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

We have a dedicated error API for hints. Use it instead of embedding
the hint in the error message, as recommanded in the "qapi/error.h"
header file.

While here, have cap_fwnmi_apply(), which already uses
error_append_hint(), to call ERRP_GUARD() as well.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <159594297421.8262.14314530897345809924.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_caps.c | 89 +++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 39 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 3225fc5a2e..275f5bd034 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -180,24 +180,24 @@ static void spapr_cap_set_pagesize(Object *obj, Visitor *v, const char *name,
 
 static void cap_htm_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
 {
+    ERRP_GUARD();
     if (!val) {
         /* TODO: We don't support disabling htm yet */
         return;
     }
     if (tcg_enabled()) {
-        error_setg(errp,
-                   "No Transactional Memory support in TCG,"
-                   " try appending -machine cap-htm=off");
+        error_setg(errp, "No Transactional Memory support in TCG");
+        error_append_hint(errp, "Try appending -machine cap-htm=off\n");
     } else if (kvm_enabled() && !kvmppc_has_cap_htm()) {
         error_setg(errp,
-"KVM implementation does not support Transactional Memory,"
-                   " try appending -machine cap-htm=off"
-            );
+                   "KVM implementation does not support Transactional Memory");
+        error_append_hint(errp, "Try appending -machine cap-htm=off\n");
     }
 }
 
 static void cap_vsx_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
 {
+    ERRP_GUARD();
     PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
     CPUPPCState *env = &cpu->env;
 
@@ -209,13 +209,14 @@ static void cap_vsx_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
      * rid of anything that doesn't do VMX */
     g_assert(env->insns_flags & PPC_ALTIVEC);
     if (!(env->insns_flags2 & PPC2_VSX)) {
-        error_setg(errp, "VSX support not available,"
-                   " try appending -machine cap-vsx=off");
+        error_setg(errp, "VSX support not available");
+        error_append_hint(errp, "Try appending -machine cap-vsx=off\n");
     }
 }
 
 static void cap_dfp_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
 {
+    ERRP_GUARD();
     PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
     CPUPPCState *env = &cpu->env;
 
@@ -224,8 +225,8 @@ static void cap_dfp_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
         return;
     }
     if (!(env->insns_flags2 & PPC2_DFP)) {
-        error_setg(errp, "DFP support not available,"
-                   " try appending -machine cap-dfp=off");
+        error_setg(errp, "DFP support not available");
+        error_append_hint(errp, "Try appending -machine cap-dfp=off\n");
     }
 }
 
@@ -239,6 +240,7 @@ SpaprCapPossible cap_cfpc_possible = {
 static void cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t val,
                                  Error **errp)
 {
+    ERRP_GUARD();
     uint8_t kvm_val =  kvmppc_get_cap_safe_cache();
 
     if (tcg_enabled() && val) {
@@ -247,9 +249,9 @@ static void cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t val,
                     cap_cfpc_possible.vals[val]);
     } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
-                   "Requested safe cache capability level not supported by kvm,"
-                   " try appending -machine cap-cfpc=%s",
-                   cap_cfpc_possible.vals[kvm_val]);
+                   "Requested safe cache capability level not supported by KVM");
+        error_append_hint(errp, "Try appending -machine cap-cfpc=%s\n",
+                          cap_cfpc_possible.vals[kvm_val]);
     }
 }
 
@@ -263,6 +265,7 @@ SpaprCapPossible cap_sbbc_possible = {
 static void cap_safe_bounds_check_apply(SpaprMachineState *spapr, uint8_t val,
                                         Error **errp)
 {
+    ERRP_GUARD();
     uint8_t kvm_val =  kvmppc_get_cap_safe_bounds_check();
 
     if (tcg_enabled() && val) {
@@ -271,9 +274,9 @@ static void cap_safe_bounds_check_apply(SpaprMachineState *spapr, uint8_t val,
                     cap_sbbc_possible.vals[val]);
     } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
-"Requested safe bounds check capability level not supported by kvm,"
-                   " try appending -machine cap-sbbc=%s",
-                   cap_sbbc_possible.vals[kvm_val]);
+"Requested safe bounds check capability level not supported by KVM");
+        error_append_hint(errp, "Try appending -machine cap-sbbc=%s\n",
+                          cap_sbbc_possible.vals[kvm_val]);
     }
 }
 
@@ -290,6 +293,7 @@ SpaprCapPossible cap_ibs_possible = {
 static void cap_safe_indirect_branch_apply(SpaprMachineState *spapr,
                                            uint8_t val, Error **errp)
 {
+    ERRP_GUARD();
     uint8_t kvm_val = kvmppc_get_cap_safe_indirect_branch();
 
     if (tcg_enabled() && val) {
@@ -298,9 +302,9 @@ static void cap_safe_indirect_branch_apply(SpaprMachineState *spapr,
                     cap_ibs_possible.vals[val]);
     } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
-"Requested safe indirect branch capability level not supported by kvm,"
-                   " try appending -machine cap-ibs=%s",
-                   cap_ibs_possible.vals[kvm_val]);
+"Requested safe indirect branch capability level not supported by KVM");
+        error_append_hint(errp, "Try appending -machine cap-ibs=%s\n",
+                          cap_ibs_possible.vals[kvm_val]);
     }
 }
 
@@ -377,23 +381,25 @@ static void cap_hpt_maxpagesize_cpu_apply(SpaprMachineState *spapr,
 static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
                                     uint8_t val, Error **errp)
 {
+    ERRP_GUARD();
     if (!val) {
         /* capability disabled by default */
         return;
     }
 
     if (tcg_enabled()) {
-        error_setg(errp,
-                   "No Nested KVM-HV support in tcg,"
-                   " try appending -machine cap-nested-hv=off");
+        error_setg(errp, "No Nested KVM-HV support in TCG");
+        error_append_hint(errp, "Try appending -machine cap-nested-hv=off\n");
     } else if (kvm_enabled()) {
         if (!kvmppc_has_cap_nested_kvm_hv()) {
             error_setg(errp,
-"KVM implementation does not support Nested KVM-HV,"
-                       " try appending -machine cap-nested-hv=off");
+                       "KVM implementation does not support Nested KVM-HV");
+            error_append_hint(errp,
+                              "Try appending -machine cap-nested-hv=off\n");
         } else if (kvmppc_set_cap_nested_kvm_hv(val) < 0) {
-                error_setg(errp,
-"Error enabling cap-nested-hv with KVM, try cap-nested-hv=off");
+                error_setg(errp, "Error enabling cap-nested-hv with KVM");
+                error_append_hint(errp,
+                                  "Try appending -machine cap-nested-hv=off\n");
         }
     }
 }
@@ -401,6 +407,7 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
 static void cap_large_decr_apply(SpaprMachineState *spapr,
                                  uint8_t val, Error **errp)
 {
+    ERRP_GUARD();
     PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
 
@@ -411,22 +418,23 @@ static void cap_large_decr_apply(SpaprMachineState *spapr,
     if (tcg_enabled()) {
         if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
                               spapr->max_compat_pvr)) {
-            error_setg(errp,
-                "Large decrementer only supported on POWER9, try -cpu POWER9");
+            error_setg(errp, "Large decrementer only supported on POWER9");
+            error_append_hint(errp, "Try -cpu POWER9\n");
             return;
         }
     } else if (kvm_enabled()) {
         int kvm_nr_bits = kvmppc_get_cap_large_decr();
 
         if (!kvm_nr_bits) {
-            error_setg(errp,
-                       "No large decrementer support,"
-                        " try appending -machine cap-large-decr=off");
+            error_setg(errp, "No large decrementer support");
+            error_append_hint(errp,
+                              "Try appending -machine cap-large-decr=off\n");
         } else if (pcc->lrg_decr_bits != kvm_nr_bits) {
             error_setg(errp,
-"KVM large decrementer size (%d) differs to model (%d),"
-                " try appending -machine cap-large-decr=off",
-                kvm_nr_bits, pcc->lrg_decr_bits);
+                       "KVM large decrementer size (%d) differs to model (%d)",
+                       kvm_nr_bits, pcc->lrg_decr_bits);
+            error_append_hint(errp,
+                              "Try appending -machine cap-large-decr=off\n");
         }
     }
 }
@@ -435,14 +443,15 @@ static void cap_large_decr_cpu_apply(SpaprMachineState *spapr,
                                      PowerPCCPU *cpu,
                                      uint8_t val, Error **errp)
 {
+    ERRP_GUARD();
     CPUPPCState *env = &cpu->env;
     target_ulong lpcr = env->spr[SPR_LPCR];
 
     if (kvm_enabled()) {
         if (kvmppc_enable_cap_large_decr(cpu, val)) {
-            error_setg(errp,
-                       "No large decrementer support,"
-                       " try appending -machine cap-large-decr=off");
+            error_setg(errp, "No large decrementer support");
+            error_append_hint(errp,
+                              "Try appending -machine cap-large-decr=off\n");
         }
     }
 
@@ -457,6 +466,7 @@ static void cap_large_decr_cpu_apply(SpaprMachineState *spapr,
 static void cap_ccf_assist_apply(SpaprMachineState *spapr, uint8_t val,
                                  Error **errp)
 {
+    ERRP_GUARD();
     uint8_t kvm_val = kvmppc_get_cap_count_cache_flush_assist();
 
     if (tcg_enabled() && val) {
@@ -479,14 +489,15 @@ static void cap_ccf_assist_apply(SpaprMachineState *spapr, uint8_t val,
             return;
         }
         error_setg(errp,
-"Requested count cache flush assist capability level not supported by kvm,"
-                   " try appending -machine cap-ccf-assist=off");
+                   "Requested count cache flush assist capability level not supported by KVM");
+        error_append_hint(errp, "Try appending -machine cap-ccf-assist=off\n");
     }
 }
 
 static void cap_fwnmi_apply(SpaprMachineState *spapr, uint8_t val,
                                 Error **errp)
 {
+    ERRP_GUARD();
     if (!val) {
         return; /* Disabled by default */
     }
-- 
2.26.2


