Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004AEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:14:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF1A1221E5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VMRerHch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1A1221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3xWK-0005gx-U8
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 04:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1k3xSg-00073r-Ut
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:10:46 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:46970)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1k3xSc-0001hN-Rx
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:10:46 -0400
Received: by mail-il1-x141.google.com with SMTP id c6so1053721ilo.13
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 01:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9aB5SJHC8FbDBha6sRb/HKsg3SmMO8+j3TVfCLWuY0I=;
 b=VMRerHchoWHr6rI5g1T1wBXEAV08CskMGvdTstVSKB1XxOvhzZ3/tIF/aOWYqm0zJi
 KOgIgp4cS890MoVcBHUhGd61D3p2blbo5YJ0VcGA1sr30zKXcR3SL9R65GjTDYWvkYuw
 QEaBck9wT8PcjJxo9A6b7VOYyeVBQ/pY6mFEuFgVj1i9/C0CHB2FHo8Uzu+fBA/wsw1+
 GrFcPBz8szdvlRgMJtN719v4Q4fCYKE5xx77k5IbJnMqmpu00RFFTr3V/rtnVi8+3iMP
 V2zSdFakfE/WlUnkpWK6b+xu67XLfZ3QO1rM+EQyHirsyJY8TELx4axKy3czRwEOLVEV
 RW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9aB5SJHC8FbDBha6sRb/HKsg3SmMO8+j3TVfCLWuY0I=;
 b=B5lhom2qE4IeV+dTqdYLm5uyKxsXmzBIr1sp5VzlCJmyLRHJsFOgrwGfjdNTetgW23
 5cj1ZoCl+K54ygJKALnyNqJpwZTjBQIr8ZI3K6xWaEs6iR/Kyy/FynEYYYXkl7FKKWum
 uz6bHofIbhxPTtdeZaSs+Vn+auPGcgMh17+Uso/omycpXgHrntmnR13ifgOp1Vlb1SDu
 GLTTKucB8C47/4H0zXW4IUoSoozIXqN6kzZltVWh5BF/Da2gzTS95ggZNTy0+6HPDM8U
 Dtw/QXfOfB4ZuCrPD8AigQWuwaLY0joPXuXIqwkveGH6aNW9YzzI3J3LeWR6fn468dCd
 g5VA==
X-Gm-Message-State: AOAM530AAlpOCqyziMe1IMuAnF361oo50nvARd0iYiqOWfH8JT08ryyN
 61qIQXix9jKvfNpxKEq0JD7C
X-Google-Smtp-Source: ABdhPJysPrQcDjSYpoMeRJAXtSsCanQ8RUHrdS2KtsJppKv03QaV+LmRwH7B8KY8/NZrKZsm2LVYNg==
X-Received: by 2002:a92:c74a:: with SMTP id y10mr3126240ilp.306.1596787841901; 
 Fri, 07 Aug 2020 01:10:41 -0700 (PDT)
Received: from localhost.localdomain ([147.75.106.138])
 by smtp.gmail.com with ESMTPSA id l144sm6233546ill.6.2020.08.07.01.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2020 01:10:41 -0700 (PDT)
From: Haibo Xu <haibo.xu@linaro.org>
To: peter.maydell@linaro.org
Subject: [PATCH 2/7] target/arm/kvm: spe: Add helper to detect SPE when using
 KVM
Date: Fri,  7 Aug 2020 08:10:32 +0000
Message-Id: <76aa68f9ec73ced85070b81ef5251771ca27d072.1596768588.git.haibo.xu@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1596768588.git.haibo.xu@linaro.org>
References: <cover.1596768588.git.haibo.xu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=haibo.xu@linaro.org; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: drjones@redhat.com, qemu-arm@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org, Haibo Xu <haibo.xu@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
---
 target/arm/kvm.c     |  5 +++++
 target/arm/kvm_arm.h | 13 +++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 8bb7318378..58f991e890 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -214,6 +214,11 @@ bool kvm_arm_pmu_supported(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3);
 }
 
+bool kvm_arm_spe_supported(void)
+{
+    return kvm_check_extension(kvm_state, KVM_CAP_ARM_SPE_V1);
+}
+
 int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
 {
     KVMState *s = KVM_STATE(ms->accelerator);
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index adb38514bf..f79655674e 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -283,6 +283,14 @@ bool kvm_arm_aarch32_supported(void);
  */
 bool kvm_arm_pmu_supported(void);

+/**
+ * kvm_arm_spe_supported:
+ *
+ * Returns: true if the KVM VCPU can enable its SPE
+ * and false otherwise.
+ */
+bool kvm_arm_spe_supported(void);
+
 /**
  * kvm_arm_sve_supported:
  *
@@ -366,6 +374,11 @@ static inline bool kvm_arm_pmu_supported(void)
     return false;
 }

+static inline bool kvm_arm_spe_supported(void)
+{
+    return false;
+}
+
 static inline bool kvm_arm_sve_supported(void)
 {
     return false;
-- 
2.17.1


