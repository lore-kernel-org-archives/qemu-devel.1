Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFFBC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7833E21D56
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jN5u4Qzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7833E21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8vu2-0004HE-LB
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 19:59:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkx-0002ia-T1
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkt-0004Va-Ra
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:54 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:45732)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j8vks-0004Un-VY
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:51 -0500
Received: by mail-pf1-x432.google.com with SMTP id 2so543429pfg.12
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=L0gAOeYyh4ssRiGbBIUEmt9mPfUm7yjv/MJPi98va64=;
 b=jN5u4Qzmk0XSF1b+OLinbGW6CpUAVvC5i4IvUJo3+uoEAFLMPctWAqBOJs3dSMIInB
 hnO5mNvS+y9IM3mdLZu0KunFnT14wO8MyYAsIkso4AFnYspk/BIIOQWfqRfyIUhn322Q
 9swRQt2DWrQJYyiTuoona+eKMrqbZNN2kqCpQ10XIuT+QtlIimxC9/YU0prmdwHG4D5y
 J0ynL1Efl2bKM5zo4CkLntPbAfL1JvJLMiOpga3CJxehzpWkCcGuaQT2Fiuh6IVneYhh
 ww2UPf3VwNP222NcQ8GyUOnTnKIB+Du30FrczN0hGewGUBBm33u3/YkJGsPasSQRE2+i
 HfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=L0gAOeYyh4ssRiGbBIUEmt9mPfUm7yjv/MJPi98va64=;
 b=Nqr1h58nGY+xQf572B57F3QoSwO21keZcbx+pxud8qRT7tkRFH/oJycITe8IDgKiq9
 grenfr8qiokV2qr4DGVteydAuvjFbEOkKWbO4IXgKU8PCtap2Hi4r5BLpCw2yhiNg/eH
 O+xblA87dtzFpDEpu5kfF1veqRdoemeygpX7kWXpX1DdafQEEgqDfq6T2EzbvwZpFE38
 95rmlY1tm56XOaKSGmHYyie1b9S29TKb4fVPtGMzQDlJpSCJZtWOXAVrtyAUHEyzoSe2
 dD0XBG+C8rMNL9CFO6rhnsRccMsD+bniARUm0mcZQLRyldFSRRbIEKlP06pJbXsiE4Ns
 YUtw==
X-Gm-Message-State: ANhLgQ1UgVgsXOmAbjNIegacS2JIKOYtrqsl4lsWa7v9ANnjaj0MHrny
 RS6ZBHHPnbOAgzj0gEsN3z4PEw==
X-Google-Smtp-Source: ADFU+vu9D1s4m7d4MgW4humzghf+TfcxJoYeJct7ISzsKy43CI9sHKVgrApuSTJFaUIrsVcP2zqLgw==
X-Received: by 2002:a63:5916:: with SMTP id n22mr1574426pgb.190.1583196589503; 
 Mon, 02 Mar 2020 16:49:49 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id z10sm21620999pgf.35.2020.03.02.16.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 16:49:48 -0800 (PST)
Subject: [PULL 29/38] target/riscv: Allow specifying MMU stage
Date: Mon,  2 Mar 2020 16:48:39 -0800
Message-Id: <20200303004848.136788-30-palmerdabbelt@google.com>
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
X-Received-From: 2607:f8b0:4864:20::432
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
 target/riscv/cpu_helper.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index d9a29d702a..8ae1038bcd 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -277,10 +277,19 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
  *
  * Adapted from Spike's mmu_t::translate and mmu_t::walk
  *
+ * @env: CPURISCVState
+ * @physical: This will be set to the calculated physical address
+ * @prot: The returned protection attributes
+ * @addr: The virtual address to be translated
+ * @access_type: The type of MMU access
+ * @mmu_idx: Indicates current privilege level
+ * @first_stage: Are we in first stage translation?
+ *               Second stage is used for hypervisor guest translation
  */
 static int get_physical_address(CPURISCVState *env, hwaddr *physical,
                                 int *prot, target_ulong addr,
-                                int access_type, int mmu_idx)
+                                int access_type, int mmu_idx,
+                                bool first_stage)
 {
     /* NOTE: the env->pc value visible here will not be
      * correct, but the value visible to the exception handler
@@ -485,13 +494,21 @@ restart:
 }
 
 static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
-                                MMUAccessType access_type, bool pmp_violation)
+                                MMUAccessType access_type, bool pmp_violation,
+                                bool first_stage)
 {
     CPUState *cs = env_cpu(env);
-    int page_fault_exceptions =
-        (env->priv_ver >= PRIV_VERSION_1_10_0) &&
-        get_field(env->satp, SATP_MODE) != VM_1_10_MBARE &&
-        !pmp_violation;
+    int page_fault_exceptions;
+    if (first_stage) {
+        page_fault_exceptions =
+            (env->priv_ver >= PRIV_VERSION_1_10_0) &&
+            get_field(env->satp, SATP_MODE) != VM_1_10_MBARE &&
+            !pmp_violation;
+    } else {
+        page_fault_exceptions =
+            get_field(env->hgatp, HGATP_MODE) != VM_1_10_MBARE &&
+            !pmp_violation;
+    }
     switch (access_type) {
     case MMU_INST_FETCH:
         cs->exception_index = page_fault_exceptions ?
@@ -518,7 +535,8 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     int prot;
     int mmu_idx = cpu_mmu_index(&cpu->env, false);
 
-    if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0, mmu_idx)) {
+    if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0, mmu_idx,
+                             true)) {
         return -1;
     }
     return phys_addr;
@@ -583,7 +601,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
                   __func__, address, access_type, mmu_idx);
 
-    ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx);
+    ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx,
+                               true);
 
     if (mode == PRV_M && access_type != MMU_INST_FETCH) {
         if (get_field(env->mstatus, MSTATUS_MPRV)) {
@@ -610,7 +629,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     } else if (probe) {
         return false;
     } else {
-        raise_mmu_exception(env, address, access_type, pmp_violation);
+        raise_mmu_exception(env, address, access_type, pmp_violation, true);
         riscv_raise_exception(env, cs->exception_index, retaddr);
     }
 #else
-- 
2.25.0.265.gbab2e86ba0-goog


