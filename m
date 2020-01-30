Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6781C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:19:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80E822082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G2ZBCJG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E822082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCXi-0003HM-KP
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:19:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCU9-0005nZ-Dx
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCU8-0003Bf-0S
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:05 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:34167)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixCU7-000393-6p
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:03 -0500
Received: by mail-wr1-x436.google.com with SMTP id t2so4820711wrr.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ERHeiWskVVmxjb2Ajc2jvjv2vBrDDeE9YX+KaKuyjf4=;
 b=G2ZBCJG/iYrMNladcfXdCekpZM8jYd1JHHFsWOilQ73Zefd2vOrGz4D9oVVfgezEoT
 QdH9rb9sLwRJdef78rgD+8b87AhR2qn7Fl5hnLuq2xcqsKE4tu0fdkfY2NKZnDwqxVf7
 0bwQBMmB4A7QtinzWmeYJpoF+aBkN9OXwYWMP6kRQg/rPrVOvk5crkwgxmCLi+MQLo+K
 hFtSChMurGr47H+J7HnEhDpV/0T8l3lRFSEpWWV+D/BdDmlinBPFY+sXFOeQiAf8yjur
 NhONlTvhbylsGOav9fSKo9I9fnkNgOHoIkNed6cW4NVI/uzTb0iFT6D5meFzAc4xptJb
 h9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ERHeiWskVVmxjb2Ajc2jvjv2vBrDDeE9YX+KaKuyjf4=;
 b=TDWAY3Rv2hxOd/ql2hVDa+TBdYLC8BoqXfRNcUCZMQFM2ErDQv8oS+vJ3hAfm/1kYB
 Cn2VOuTGw2kcwUzidjacm1wbdT1LMYIBvsgPkIyMA11PyNvXwtfC9xaRvQEtps2sAu1/
 rVdoWdHlseTyNhIlBYujqt1/kIaP81Sk3JJdJUNoNSuZJNZ1+MGtLsQ1J55asJOkn+sS
 7ervGYK/eJLrKxfYFnr/QBOyXFEHYCoEN6fXTvSuyxZzBww67L4JUS/9tBQ9YyLhfvQg
 LgZaGGndyJCH0sxIMA7qV+pqZGf9mxquscwc5efNtGsvPc8l1LdZXBYWE4BajB0Ntr9w
 k3vg==
X-Gm-Message-State: APjAAAXw8a0Z3X/AfNExtxU8hiV4DEfdSKQkmHwaaLv+8fpB2PEiz7JV
 M65E4ibczZUwB6Trst9Kbpnd1X4iCMscFg==
X-Google-Smtp-Source: APXvYqw6nhgPa2OpCgzJK0y/GBDhjbzAQ+QY1I6gtECFgi9WFYA6PPkRVOtrepqHOfavu2n9Tt+TLQ==
X-Received: by 2002:a05:6000:1201:: with SMTP id
 e1mr512122wrx.386.1580400961981; 
 Thu, 30 Jan 2020 08:16:01 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a22sm6994442wmd.20.2020.01.30.08.16.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:16:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/26] target/arm/kvm: trivial: Clean up header documentation
Date: Thu, 30 Jan 2020 16:15:28 +0000
Message-Id: <20200130161533.8180-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130161533.8180-1-peter.maydell@linaro.org>
References: <20200130161533.8180-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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

From: Andrew Jones <drjones@redhat.com>

Signed-off-by: Andrew Jones <drjones@redhat.com>
Message-id: 20200120101023.16030-2-drjones@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h | 46 ++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 8e14d400e8a..b48a9c95573 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -28,9 +28,9 @@
 int kvm_arm_vcpu_init(CPUState *cs);
 
 /**
- * kvm_arm_vcpu_finalize
+ * kvm_arm_vcpu_finalize:
  * @cs: CPUState
- * @feature: int
+ * @feature: feature to finalize
  *
  * Finalizes the configuration of the specified VCPU feature by
  * invoking the KVM_ARM_VCPU_FINALIZE ioctl. Features requiring
@@ -75,8 +75,8 @@ void kvm_arm_register_device(MemoryRegion *mr, uint64_t devid, uint64_t group,
 int kvm_arm_init_cpreg_list(ARMCPU *cpu);
 
 /**
- * kvm_arm_reg_syncs_via_cpreg_list
- * regidx: KVM register index
+ * kvm_arm_reg_syncs_via_cpreg_list:
+ * @regidx: KVM register index
  *
  * Return true if this KVM register should be synchronized via the
  * cpreg list of arbitrary system registers, false if it is synchronized
@@ -85,8 +85,8 @@ int kvm_arm_init_cpreg_list(ARMCPU *cpu);
 bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx);
 
 /**
- * kvm_arm_cpreg_level
- * regidx: KVM register index
+ * kvm_arm_cpreg_level:
+ * @regidx: KVM register index
  *
  * Return the level of this coprocessor/system register.  Return value is
  * either KVM_PUT_RUNTIME_STATE, KVM_PUT_RESET_STATE, or KVM_PUT_FULL_STATE.
@@ -148,6 +148,8 @@ void kvm_arm_init_serror_injection(CPUState *cs);
  * @cpu: ARMCPU
  *
  * Get VCPU related state from kvm.
+ *
+ * Returns: 0 if success else < 0 error code
  */
 int kvm_get_vcpu_events(ARMCPU *cpu);
 
@@ -156,6 +158,8 @@ int kvm_get_vcpu_events(ARMCPU *cpu);
  * @cpu: ARMCPU
  *
  * Put VCPU related state to kvm.
+ *
+ * Returns: 0 if success else < 0 error code
  */
 int kvm_put_vcpu_events(ARMCPU *cpu);
 
@@ -205,10 +209,12 @@ typedef struct ARMHostCPUFeatures {
 
 /**
  * kvm_arm_get_host_cpu_features:
- * @ahcc: ARMHostCPUClass to fill in
+ * @ahcf: ARMHostCPUClass to fill in
  *
  * Probe the capabilities of the host kernel's preferred CPU and fill
  * in the ARMHostCPUClass struct accordingly.
+ *
+ * Returns true on success and false otherwise.
  */
 bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf);
 
@@ -242,7 +248,7 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
 bool kvm_arm_aarch32_supported(CPUState *cs);
 
 /**
- * bool kvm_arm_pmu_supported:
+ * kvm_arm_pmu_supported:
  * @cs: CPUState
  *
  * Returns: true if the KVM VCPU can enable its PMU
@@ -251,7 +257,7 @@ bool kvm_arm_aarch32_supported(CPUState *cs);
 bool kvm_arm_pmu_supported(CPUState *cs);
 
 /**
- * bool kvm_arm_sve_supported:
+ * kvm_arm_sve_supported:
  * @cs: CPUState
  *
  * Returns true if the KVM VCPU can enable SVE and false otherwise.
@@ -259,26 +265,30 @@ bool kvm_arm_pmu_supported(CPUState *cs);
 bool kvm_arm_sve_supported(CPUState *cs);
 
 /**
- * kvm_arm_get_max_vm_ipa_size - Returns the number of bits in the
- * IPA address space supported by KVM
- *
+ * kvm_arm_get_max_vm_ipa_size:
  * @ms: Machine state handle
+ *
+ * Returns the number of bits in the IPA address space supported by KVM
  */
 int kvm_arm_get_max_vm_ipa_size(MachineState *ms);
 
 /**
- * kvm_arm_sync_mpstate_to_kvm
+ * kvm_arm_sync_mpstate_to_kvm:
  * @cpu: ARMCPU
  *
  * If supported set the KVM MP_STATE based on QEMU's model.
+ *
+ * Returns 0 on success and -1 on failure.
  */
 int kvm_arm_sync_mpstate_to_kvm(ARMCPU *cpu);
 
 /**
- * kvm_arm_sync_mpstate_to_qemu
+ * kvm_arm_sync_mpstate_to_qemu:
  * @cpu: ARMCPU
  *
  * If supported get the MP_STATE from KVM and store in QEMU's model.
+ *
+ * Returns 0 on success and aborts on failure.
  */
 int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu);
 
@@ -292,7 +302,8 @@ int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
 
 static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
 {
-    /* This should never actually be called in the "not KVM" case,
+    /*
+     * This should never actually be called in the "not KVM" case,
      * but set up the fields to indicate an error anyway.
      */
     cpu->kvm_target = QEMU_KVM_ARM_TARGET_NONE;
@@ -377,23 +388,20 @@ bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit);
  *
  * Return: TRUE if any hardware breakpoints in use.
  */
-
 bool kvm_arm_hw_debug_active(CPUState *cs);
 
 /**
  * kvm_arm_copy_hw_debug_data:
- *
  * @ptr: kvm_guest_debug_arch structure
  *
  * Copy the architecture specific debug registers into the
  * kvm_guest_debug ioctl structure.
  */
 struct kvm_guest_debug_arch;
-
 void kvm_arm_copy_hw_debug_data(struct kvm_guest_debug_arch *ptr);
 
 /**
- * its_class_name
+ * its_class_name:
  *
  * Return the ITS class name to use depending on whether KVM acceleration
  * and KVM CAP_SIGNAL_MSI are supported
-- 
2.20.1


