Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59743C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2840C21D56
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JFj/yASJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2840C21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8vu3-0004JB-A7
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 19:59:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vke-000209-Q8
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkc-0004NT-FF
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:36 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39575)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j8vkc-0004N7-7v
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:34 -0500
Received: by mail-pg1-x544.google.com with SMTP id s2so666050pgv.6
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=1qGfwsKWyBYxIvKWzkbg1ul+1GiM3tK10LjXLhO5Vwg=;
 b=JFj/yASJ1VDIlAMmpy/kOFdr40MDGYXlOyobybFSTCZJe2UqNIk6TX3K6EnBphdmA8
 Bz1lNThdQYivnqNnGM0yu/jrNEc+8y686NjsqkRpfuldnFwr3R6/OCwEbYbEMaDK5JHS
 elHZ/S2Fc0flVcBn1Dq5pZEwmPIlO6SEOc+cWO6P0yBL4NR8Y4ISiIu6RtC0VS/Xo8Kw
 ONT879II7Jni5a5upbKRy62hDoQrQcDZV2WemGcxXpPn+z2IH4mu0R0r5Xq2yIbsMouH
 kyl7sPG1CERcf9vrZczTDVpbIDJNKAge4TwN/yvAMwPxvxH41QBCd9axl+C62bc6EYqf
 zdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=1qGfwsKWyBYxIvKWzkbg1ul+1GiM3tK10LjXLhO5Vwg=;
 b=oJ2wI2cuQpCNUi51wGhsGoPy0Pk3RicHYdf5qK5XE7cjfbUm0iJ4IVs69Op+utC/0y
 x6BSa9sYZPGGMu1Ag5EcunjIo3GWwfTGTs+tYbnM5tCjdJ8mYlS7qsR45PDkWbYmJJlu
 9Q1Km77t8DTelAvSzOv7MPaSTWIobh4EMmoOkdkOUX+B6A31RgIAfKvNIq+2NGDDFfWV
 ZACUCIOvljWUtasHjeSI98XIZnF8uJc2lAgqTUuzeiBgs5huxr58cP88EvFwtSCPqRaS
 pbxhsaVzDP5Yz5zg8RJ+uPFWEdjm99sII5eiUGnomQZWizr8Q908iUrU2Zt0dCFMbbPY
 jW/Q==
X-Gm-Message-State: ANhLgQ38/NvETnc0Vv454K2CB110WaAJiBhwdUr/NEksb5XGBdT8tDco
 p1pd1xMpSSTMK/Kh9Z5tZ72SQw==
X-Google-Smtp-Source: ADFU+vvViAr4xVkLM+WJfISm63A6yEXmJhDy2w5lddqp+NbQCUlRpqtppsnkNffqIUal2QSixYy2og==
X-Received: by 2002:a63:1e06:: with SMTP id e6mr1607568pge.134.1583196572975; 
 Mon, 02 Mar 2020 16:49:32 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id u6sm301786pjy.3.2020.03.02.16.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 16:49:32 -0800 (PST)
Subject: [PULL 21/38] target/riscv: Add hypvervisor trap support
Date: Mon,  2 Mar 2020 16:48:31 -0800
Message-Id: <20200303004848.136788-22-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200303004848.136788-1-palmerdabbelt@google.com>
References: <20200303004848.136788-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/cpu_helper.c | 69 +++++++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index a8b114ae16..895b6ca25d 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -641,6 +641,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
+    bool force_hs_execp = riscv_cpu_force_hs_excep_enabled(env);
+    target_ulong s;
 
     /* cs->exception is 32-bits wide unlike mcause which is XLEN-bits wide
      * so we mask off the MSB and separate into trap type and cause.
@@ -650,19 +652,14 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     target_ulong deleg = async ? env->mideleg : env->medeleg;
     target_ulong tval = 0;
 
-    static const int ecall_cause_map[] = {
-        [PRV_U] = RISCV_EXCP_U_ECALL,
-        [PRV_S] = RISCV_EXCP_S_ECALL,
-        [PRV_H] = RISCV_EXCP_VS_ECALL,
-        [PRV_M] = RISCV_EXCP_M_ECALL
-    };
-
     if (!async) {
         /* set tval to badaddr for traps with address information */
         switch (cause) {
         case RISCV_EXCP_INST_GUEST_PAGE_FAULT:
         case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
         case RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT:
+            force_hs_execp = true;
+            /* fallthrough */
         case RISCV_EXCP_INST_ADDR_MIS:
         case RISCV_EXCP_INST_ACCESS_FAULT:
         case RISCV_EXCP_LOAD_ADDR_MIS:
@@ -680,7 +677,16 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         /* ecall is dispatched as one cause so translate based on mode */
         if (cause == RISCV_EXCP_U_ECALL) {
             assert(env->priv <= 3);
-            cause = ecall_cause_map[env->priv];
+
+            if (env->priv == PRV_M) {
+                cause = RISCV_EXCP_M_ECALL;
+            } else if (env->priv == PRV_S && riscv_cpu_virt_enabled(env)) {
+                cause = RISCV_EXCP_VS_ECALL;
+            } else if (env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) {
+                cause = RISCV_EXCP_S_ECALL;
+            } else if (env->priv == PRV_U) {
+                cause = RISCV_EXCP_U_ECALL;
+            }
         }
     }
 
@@ -690,7 +696,36 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     if (env->priv <= PRV_S &&
             cause < TARGET_LONG_BITS && ((deleg >> cause) & 1)) {
         /* handle the trap in S-mode */
-        target_ulong s = env->mstatus;
+        if (riscv_has_ext(env, RVH)) {
+            target_ulong hdeleg = async ? env->hideleg : env->hedeleg;
+
+            if (riscv_cpu_virt_enabled(env) && ((hdeleg >> cause) & 1) &&
+                !force_hs_execp) {
+                /* Trap to VS mode */
+            } else if (riscv_cpu_virt_enabled(env)) {
+                /* Trap into HS mode, from virt */
+                riscv_cpu_swap_hypervisor_regs(env);
+                env->hstatus = set_field(env->hstatus, HSTATUS_SP2V,
+                                         get_field(env->hstatus, HSTATUS_SPV));
+                env->hstatus = set_field(env->hstatus, HSTATUS_SP2P,
+                                         get_field(env->mstatus, SSTATUS_SPP));
+                env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
+                                         riscv_cpu_virt_enabled(env));
+
+                riscv_cpu_set_virt_enabled(env, 0);
+                riscv_cpu_set_force_hs_excep(env, 0);
+            } else {
+                /* Trap into HS mode */
+                env->hstatus = set_field(env->hstatus, HSTATUS_SP2V,
+                                         get_field(env->hstatus, HSTATUS_SPV));
+                env->hstatus = set_field(env->hstatus, HSTATUS_SP2P,
+                                         get_field(env->mstatus, SSTATUS_SPP));
+                env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
+                                         riscv_cpu_virt_enabled(env));
+            }
+        }
+
+        s = env->mstatus;
         s = set_field(s, MSTATUS_SPIE, env->priv_ver >= PRIV_VERSION_1_10_0 ?
             get_field(s, MSTATUS_SIE) : get_field(s, MSTATUS_UIE << env->priv));
         s = set_field(s, MSTATUS_SPP, env->priv);
@@ -704,7 +739,21 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         riscv_cpu_set_mode(env, PRV_S);
     } else {
         /* handle the trap in M-mode */
-        target_ulong s = env->mstatus;
+        if (riscv_has_ext(env, RVH)) {
+            if (riscv_cpu_virt_enabled(env)) {
+                riscv_cpu_swap_hypervisor_regs(env);
+            }
+            env->mstatus = set_field(env->mstatus, MSTATUS_MPV,
+                                      riscv_cpu_virt_enabled(env));
+            env->mstatus = set_field(env->mstatus, MSTATUS_MTL,
+                                      riscv_cpu_force_hs_excep_enabled(env));
+
+            /* Trapping to M mode, virt is disabled */
+            riscv_cpu_set_virt_enabled(env, 0);
+            riscv_cpu_set_force_hs_excep(env, 0);
+        }
+
+        s = env->mstatus;
         s = set_field(s, MSTATUS_MPIE, env->priv_ver >= PRIV_VERSION_1_10_0 ?
             get_field(s, MSTATUS_MIE) : get_field(s, MSTATUS_UIE << env->priv));
         s = set_field(s, MSTATUS_MPP, env->priv);
-- 
2.25.0.265.gbab2e86ba0-goog


