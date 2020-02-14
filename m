Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CA2C3B1AF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:58:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9602520848
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wMB5gPIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9602520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fEG-00030N-QA
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 12:58:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7t-0005zY-IV
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7s-0000tJ-5p
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:41 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51700)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2f7r-0000qT-BZ
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:39 -0500
Received: by mail-wm1-x344.google.com with SMTP id t23so10844421wmi.1
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 09:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xVgyB/ZnMXDEzGcspXK1d/y3x9zIzwGPMhddTki8nJw=;
 b=wMB5gPIeIBSbzlWph6ShtV/PNXzq8bXUx0A7jxEzpExrFvZHZ75yikbukDUu2FgTeB
 Yte4fS0s+KULHfzRy+GZeD0kmUdCvUn/HSqgevlg28BrSUaIaTj64IoAUxuN38aMvJfT
 wluZ9eeBOXLw0HdjzhFVtlmurvUjfFUUH+u7x0SH0Ve5oH91tJsPY6423qebavtL85p7
 eEiO4OjEwKXxwLCbLuxlmoibYf4yhQJSVIJ+NSD+h0P2u+gAAnw8pLI9VPi/XOmKNOwp
 0psbaZ7mxhR/3THr39f6NQjF39kvnMq9/MYo68ERpOGmj1SO53cHr7r8gHuGsv5wAJ9g
 6EDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xVgyB/ZnMXDEzGcspXK1d/y3x9zIzwGPMhddTki8nJw=;
 b=fUnmuG9oprKGrRfqsjia2vimw6WmMg4iC3FC3mBYw8uf6T/CJW96slS3cU0I5ZEhKV
 ORfkwVpGnvt85DnIRh7FNRqfZj1sDUBRD+u2yxRSlknrF0PgJ0Q7QqLdnTzO85Ki85WZ
 fhPPZjXYj2vGCeeCAfbBaEw8EU8thSoDbF/qux0b2PwG7UFBteZDbaV8P0pyJbEhHBXI
 Vj5qjNzGOXkrR5U8NwbWABQulM6L/fHDgsRiJHgBT5Rdxu9KJfKNu9nJXemj6fje31Xg
 XY6lHDgjrg+pKozFu1ijP7K07rLu+EbABjVRFoKDfzhgHKEk18EE3PEvrXvgDZNSikx3
 I8bA==
X-Gm-Message-State: APjAAAX1QVnXeQNGC0BT/AsKskmWete4q/DI2BdNNp9BStTexrGJyQmy
 EXrJduroZGeDRKTIWqvQFw0UJogCMj0=
X-Google-Smtp-Source: APXvYqwYZSAfold6XYOIh8pypchVbtZxxRL45ahfE4Td1GUeAUl8GNQgwh0exVMHyXiDnV7AMEmG5w==
X-Received: by 2002:a1c:6645:: with SMTP id a66mr6124713wmc.121.1581702696443; 
 Fri, 14 Feb 2020 09:51:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v8sm8001857wrw.2.2020.02.14.09.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 09:51:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 12/21] target/arm: Read debug-related ID registers from KVM
Date: Fri, 14 Feb 2020 17:51:07 +0000
Message-Id: <20200214175116.9164-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214175116.9164-1-peter.maydell@linaro.org>
References: <20200214175116.9164-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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
index 3bae9e4a663..527532f2b37 100644
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
+            dbgdidr |= (1 << 16); /* RES1 bit */
+            ahcf->isar.dbgdidr = dbgdidr;
+        }
     }
 
     sve_supported = ioctl(fdarray[0], KVM_CHECK_EXTENSION, KVM_CAP_ARM_SVE) > 0;
-- 
2.20.1


