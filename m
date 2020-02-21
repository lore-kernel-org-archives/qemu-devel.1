Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F8CC35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01208222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ls7HslZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01208222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58Ku-0003oL-7X
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:27:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582T-0007PF-CX
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582R-00034S-Tg
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:17 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53955)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582R-00033o-Ma
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:15 -0500
Received: by mail-wm1-x341.google.com with SMTP id s10so1731366wmh.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=5RqW1VFvoNTFM/LOz4YrIKBR0ShqAPTrRui+k6Sqcms=;
 b=ls7HslZR2GfKu7fI7DUeZXJDeEd1RD7151UUdOMoFQF/UdqPO/TEqOKmnjdJPmUwqw
 UxO6UC32OUHl6izG7It7OC5ycILll3iX8fNpr9KHWcrjYZGZSq2Uh2/76EmEoWoq20yG
 W1veY/oyRrJ1Yo6ZtfDhN6SWTA77vdZTOtg87qjwF5N36r6ViItVizkH+6Zd5m2NhyAF
 20E1pCjT9To+hVIosTTPFKpX1LOE6b47yHVEZGaKRw8so1E1VnHQinKPEeRfF7iC7RlC
 R8f2dHRTeOByGhUSy2adSkjX5EdjNHR1Ta4gKHojR6uHBvDtT9FEc1n3cxgxAGrah1/g
 h37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5RqW1VFvoNTFM/LOz4YrIKBR0ShqAPTrRui+k6Sqcms=;
 b=C0BlUIKlKwyK+YrOzQeGbFR2/7SJSPCitth776KrjW8a2rGD7atWMXP4ncoMuCb6wB
 n4vHSxukzYUCWSk7d4GsqBGVCLIkE1Zi1v+FdcHofpBDvL2Cnb3UA3yC3T5fYbZR/ofQ
 IGxQ2m1n40DYP5kiF8iBQxeZcpnAMUl0G5WcGSZa8T7u47AEE/WZIwhW8KMmJ7k7u1Ef
 ClrBPprQfLUvkxxtm+M0/3ETq1mygzglD2pG/BQZxd1VfoL9//i/+cKiQj9muoFQaGxS
 4YApxLQzJkZoRiEEIDdlJkPrFOYIGXygFgLjp8nrDJkrSmW6n3DX59F0HWOjSqewyPTH
 Q7aA==
X-Gm-Message-State: APjAAAUXBymfh4b4h1oJqTt7aNXH2SxiB8XpOh8Z0tVBpkBybq6maPB7
 pnAU+g+BnpNNiSndWCUj26evTnRC7+iNKg==
X-Google-Smtp-Source: APXvYqwsz52aYKlJoJv+2Ub+TEKPif2djidD/0rVLsW3YNEU6WjwS3u9lP/pOwGqF1TzK+9di3RNmQ==
X-Received: by 2002:a7b:c152:: with SMTP id z18mr3789392wmi.70.1582290493256; 
 Fri, 21 Feb 2020 05:08:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/52] target/arm: Read debug-related ID registers from KVM
Date: Fri, 21 Feb 2020 13:07:13 +0000
Message-Id: <20200221130740.7583-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

Now we have isar_feature test functions that look at fields in the
ID_AA64DFR0_EL1 and ID_DFR0 ID registers, add the code that reads
these register values from KVM so that the checks behave correctly
when we're using KVM.

No isar_feature function tests ID_AA64DFR1_EL1 or DBGDIDR yet, but we
add it to maintain the invariant that every field in the
ARMISARegisters struct is populated for a KVM CPU and can be relied
on.  This requirement isn't actually written down yet, so add a note
to the relevant comment.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200214175116.9164-13-peter.maydell@linaro.org
---
 target/arm/cpu.h   |  5 +++++
 target/arm/kvm32.c |  8 ++++++++
 target/arm/kvm64.c | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3c996db3e45..e043932fcb1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -853,6 +853,11 @@ struct ARMCPU {
      * prefix means a constant register.
      * Some of these registers are split out into a substructure that
      * is shared with the translators to control the ISA.
+     *
+     * Note that if you add an ID register to the ARMISARegisters struct
+     * you need to also update the 32-bit and 64-bit versions of the
+     * kvm_arm_get_host_cpu_features() function to correctly populate the
+     * field by reading the value from the KVM vCPU.
      */
     struct ARMISARegisters {
         uint32_t id_isar0;
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 3a8b437eef0..bca02553b25 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -97,6 +97,9 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         ahcf->isar.id_isar6 = 0;
     }
 
+    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_dfr0,
+                          ARM_CP15_REG32(0, 0, 1, 2));
+
     err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr0,
                           KVM_REG_ARM | KVM_REG_SIZE_U32 |
                           KVM_REG_ARM_VFP | KVM_REG_ARM_VFP_MVFR0);
@@ -108,6 +111,11 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      * Fortunately there is not yet anything in there that affects migration.
      */
 
+    /*
+     * There is no way to read DBGDIDR, because currently 32-bit KVM
+     * doesn't implement debug at all. Leave it at zero.
+     */
+
     kvm_arm_destroy_scratch_host_vcpu(fdarray);
 
     if (err < 0) {
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 3bae9e4a663..e8d7cea74cb 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -541,6 +541,10 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     } else {
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64pfr1,
                               ARM64_SYS_REG(3, 0, 0, 4, 1));
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64dfr0,
+                              ARM64_SYS_REG(3, 0, 0, 5, 0));
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64dfr1,
+                              ARM64_SYS_REG(3, 0, 0, 5, 1));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64isar0,
                               ARM64_SYS_REG(3, 0, 0, 6, 0));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64isar1,
@@ -559,6 +563,8 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
          * than skipping the reads and leaving 0, as we must avoid
          * considering the values in every case.
          */
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_dfr0,
+                              ARM64_SYS_REG(3, 0, 0, 1, 2));
         err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar0,
                               ARM64_SYS_REG(3, 0, 0, 2, 0));
         err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar1,
@@ -580,6 +586,36 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                               ARM64_SYS_REG(3, 0, 0, 3, 1));
         err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr2,
                               ARM64_SYS_REG(3, 0, 0, 3, 2));
+
+        /*
+         * DBGDIDR is a bit complicated because the kernel doesn't
+         * provide an accessor for it in 64-bit mode, which is what this
+         * scratch VM is in, and there's no architected "64-bit sysreg
+         * which reads the same as the 32-bit register" the way there is
+         * for other ID registers. Instead we synthesize a value from the
+         * AArch64 ID_AA64DFR0, the same way the kernel code in
+         * arch/arm64/kvm/sys_regs.c:trap_dbgidr() does.
+         * We only do this if the CPU supports AArch32 at EL1.
+         */
+        if (FIELD_EX32(ahcf->isar.id_aa64pfr0, ID_AA64PFR0, EL1) >= 2) {
+            int wrps = FIELD_EX64(ahcf->isar.id_aa64dfr0, ID_AA64DFR0, WRPS);
+            int brps = FIELD_EX64(ahcf->isar.id_aa64dfr0, ID_AA64DFR0, BRPS);
+            int ctx_cmps =
+                FIELD_EX64(ahcf->isar.id_aa64dfr0, ID_AA64DFR0, CTX_CMPS);
+            int version = 6; /* ARMv8 debug architecture */
+            bool has_el3 =
+                !!FIELD_EX32(ahcf->isar.id_aa64pfr0, ID_AA64PFR0, EL3);
+            uint32_t dbgdidr = 0;
+
+            dbgdidr = FIELD_DP32(dbgdidr, DBGDIDR, WRPS, wrps);
+            dbgdidr = FIELD_DP32(dbgdidr, DBGDIDR, BRPS, brps);
+            dbgdidr = FIELD_DP32(dbgdidr, DBGDIDR, CTX_CMPS, ctx_cmps);
+            dbgdidr = FIELD_DP32(dbgdidr, DBGDIDR, VERSION, version);
+            dbgdidr = FIELD_DP32(dbgdidr, DBGDIDR, NSUHD_IMP, has_el3);
+            dbgdidr = FIELD_DP32(dbgdidr, DBGDIDR, SE_IMP, has_el3);
+            dbgdidr |= (1 << 15); /* RES1 bit */
+            ahcf->isar.dbgdidr = dbgdidr;
+        }
     }
 
     sve_supported = ioctl(fdarray[0], KVM_CHECK_EXTENSION, KVM_CAP_ARM_SVE) > 0;
-- 
2.20.1


