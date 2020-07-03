Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B54AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432EF208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kJut4Eo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432EF208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrP2j-0006vf-Cy
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxA-0004hH-OB
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:20 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOx8-0005fP-SN
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:20 -0400
Received: by mail-wr1-x444.google.com with SMTP id a6so33423178wrm.4
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=BP6j/3HoxCBLJuDgMNnWxb3Xu4bxKE76bxnjKGSc4hg=;
 b=kJut4Eo5SHspIxgjriUq994rVvP3dM7w9x9sDGSehnrSs6GJ57odYtCKBIjLcMntCR
 SoDGx66UGDCT3K0E6G6uNfep+t+d/osNBDg6JQv6DLYWKEdjawR1ralR4y2BT4d7hNfV
 aj+NATFOG6knQExuN/V2AL41cwJ0Wy4wHceqecdjvTiH+b9X7v8VpdkVjkeYqg7eaUza
 Vg2WEv6Y0oRlKnHNR8bVx4bDCzm9vM7Ifl+kMgWXZ+26WsAcHFdsVQ00OAaIpo1Bsimf
 PNwV6o+nTNg28PL8APVZky4n3UevdMDc6/nQRReuwvT6wH3pj9FCImzb6VuoXO2z6v7B
 N2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BP6j/3HoxCBLJuDgMNnWxb3Xu4bxKE76bxnjKGSc4hg=;
 b=QXESOhWpnbGKkgbu0kk3SHyQjOzsTi6uCLU2N/UjeU3eQvsfpndc0s+/LXIQiffP+5
 uDRx03LvpBAqoWPwKH+/uQzsj0lAUGIbosfyqgfdRlTez/Btg+i8Dzb82TF40jwhA+hc
 f8fzQxOFQBGyahESieeccikc8qqTWQGzOuq6UvnUAAVtMmCGWbspXPJ5YQSpZOnX6tNp
 yVrZDdECdz+VL8pm/Y/pIIuW1eBJ7BEhvBE8z5rwovZg2+ZKFfkyM+FjX9gca/qkX5BH
 gdTtaUmyRoKhNSqm9FwnBYYyIGy6soJmYec7dFXSeBg9PojhW4iXkREXWNXwMUtwmDmX
 c0BQ==
X-Gm-Message-State: AOAM530QmuTd7Bt8Fc1e/A9T4hpdw5+jEcQxUjqIpb8G0ezAVAynpFii
 Z/2zt1zlJKXp2zv2yJZs8a1dQoAUyN4HxQ==
X-Google-Smtp-Source: ABdhPJxxQ+V5TSWok5/j/fMEqewGaC4CiRnWl7fzafXTRv/SPBpUG+g5ZSzdn9rjqd88DLHtgdItRw==
X-Received: by 2002:a5d:4b0f:: with SMTP id v15mr2685265wrq.216.1593795257154; 
 Fri, 03 Jul 2020 09:54:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/34] target/arm: kvm: Handle DABT with no valid ISS
Date: Fri,  3 Jul 2020 17:53:40 +0100
Message-Id: <20200703165405.17672-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Beata Michalska <beata.michalska@linaro.org>

On ARMv7 & ARMv8 some load/store instructions might trigger a data abort
exception with no valid ISS info to be decoded. The lack of decode info
makes it at least tricky to emulate those instruction which is one of the
(many) reasons why KVM will not even try to do so.

Add support for handling those by requesting KVM to inject external
dabt into the quest.

Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Message-id: 20200629114110.30723-2-beata.michalska@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 7c672c78b88..3a46f54f1fd 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -39,6 +39,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
 
 static bool cap_has_mp_state;
 static bool cap_has_inject_serror_esr;
+static bool cap_has_inject_ext_dabt;
 
 static ARMHostCPUFeatures arm_host_cpu_features;
 
@@ -245,6 +246,16 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         ret = -EINVAL;
     }
 
+    if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
+        if (kvm_vm_enable_cap(s, KVM_CAP_ARM_NISV_TO_USER, 0)) {
+            error_report("Failed to enable KVM_CAP_ARM_NISV_TO_USER cap");
+        } else {
+            /* Set status for supporting the external dabt injection */
+            cap_has_inject_ext_dabt = kvm_check_extension(s,
+                                    KVM_CAP_ARM_INJECT_EXT_DABT);
+        }
+    }
+
     return ret;
 }
 
@@ -810,6 +821,42 @@ void kvm_arm_vm_state_change(void *opaque, int running, RunState state)
     }
 }
 
+/**
+ * kvm_arm_handle_dabt_nisv:
+ * @cs: CPUState
+ * @esr_iss: ISS encoding (limited) for the exception from Data Abort
+ *           ISV bit set to '0b0' -> no valid instruction syndrome
+ * @fault_ipa: faulting address for the synchronous data abort
+ *
+ * Returns: 0 if the exception has been handled, < 0 otherwise
+ */
+static int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
+                                    uint64_t fault_ipa)
+{
+    /*
+     * Request KVM to inject the external data abort into the guest
+     */
+    if (cap_has_inject_ext_dabt) {
+        struct kvm_vcpu_events events = { };
+        /*
+         * The external data abort event will be handled immediately by KVM
+         * using the address fault that triggered the exit on given VCPU.
+         * Requesting injection of the external data abort does not rely
+         * on any other VCPU state. Therefore, in this particular case, the VCPU
+         * synchronization can be exceptionally skipped.
+         */
+        events.exception.ext_dabt_pending = 1;
+        /* KVM_CAP_ARM_INJECT_EXT_DABT implies KVM_CAP_VCPU_EVENTS */
+        return kvm_vcpu_ioctl(cs, KVM_SET_VCPU_EVENTS, &events);
+    } else {
+        error_report("Data abort exception triggered by guest memory access "
+                     "at physical address: 0x"  TARGET_FMT_lx,
+                     (target_ulong)fault_ipa);
+        error_printf("KVM unable to emulate faulting instruction.\n");
+    }
+    return -1;
+}
+
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
     int ret = 0;
@@ -820,6 +867,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
             ret = EXCP_DEBUG;
         } /* otherwise return to guest */
         break;
+    case KVM_EXIT_ARM_NISV:
+        /* External DABT with no valid iss to decode */
+        ret = kvm_arm_handle_dabt_nisv(cs, run->arm_nisv.esr_iss,
+                                       run->arm_nisv.fault_ipa);
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
                       __func__, run->exit_reason);
-- 
2.20.1


