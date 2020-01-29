Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96ACC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 20:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8747320702
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 20:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hmZ6qyaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8747320702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwtuw-0006lw-O1
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 15:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iwttn-0005LI-VE
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 15:25:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iwttm-0001J7-Ti
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 15:25:19 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37879)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iwttm-0001Hk-OA
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 15:25:18 -0500
Received: by mail-wr1-x444.google.com with SMTP id w15so1081971wru.4
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 12:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+tZ0YBqhVEsxFXOR05MPD9ATHbI+tc6ggHRmtxE2t3s=;
 b=hmZ6qyaI6/s1G9fnfQJcUMPDpFu9Z3QQVzkxagMyyHwmFeewG3Pom3ubikvAIRvOBU
 VJBypdw++F73MZW0g1YdJR0bfVSWuO4AVnfKlAgdVI34ILKKBKySNiMaLQI/qLUoDIbi
 DgYv3OLEP4Vl3hNRWoYwKTcSl7BDaIuxkZCiw2/4knZX2Bz3RUP6PauRghFz28offnot
 oeuqe1k6Feq8WxWs3IT2hh2kDDJsKce6HlMVZ5+18n43TalBEpQ8OKRrrUgJIEIY0xmj
 08MmPAG4ZH4tTTkxkIdhRy///qnucEDZuhyOzGPGR3c+SGxXMEGI3ZENZTHXDwZOuzFH
 36RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+tZ0YBqhVEsxFXOR05MPD9ATHbI+tc6ggHRmtxE2t3s=;
 b=d+beX0j+bIVcFvy22A2E8aG+KH11tDTZWkHtBjzohGzShDlVxOM7AYLKgpMWIFv5Y8
 N6rdvLk7ho/U4qU7Ue/Efk+cSkad2JRG7/Vhjx3Q07pphyGxQ4Drp1xZGQVCAAFjSU8d
 //u6ZmndPpS639aokPMoCQhIUPs+I84XaJx4WX0I+J4+UUW2/FhgysYG7ZN/r6ue8y72
 FUYDxks3pd+fUxsEIKXExTFmd/6hNxowSxW308L/XhHGyaLgC32vO9YG6Fx6OKSNz9OT
 otXh0YLPKvZqbRoAJ8pqBXzjbPghJjxO/7+ddr+NoxL89mAU55htyX5DYR2jcXSVP1iE
 XdJw==
X-Gm-Message-State: APjAAAVETZrYhgibFsSS6TkvQgK8Dqj+VV6qO+DKsWQ1qGYN/8DC3VJ/
 tpd52tEyr+yMcAhfjy45wdoEduo3TRA=
X-Google-Smtp-Source: APXvYqxeG+727dSd9hpflWUs37JO+uDRBt85YuaVw/2/qEYgkhJrgszDi4Osfq32YMA7sHZ23onsUw==
X-Received: by 2002:adf:f18b:: with SMTP id h11mr711078wro.56.1580329517572;
 Wed, 29 Jan 2020 12:25:17 -0800 (PST)
Received: from moi-limbo-9350.home
 (host86-131-78-194.range86-131.btcentralplus.com. [86.131.78.194])
 by smtp.gmail.com with ESMTPSA id h2sm4377518wrt.45.2020.01.29.12.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 12:25:17 -0800 (PST)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] target/arm: kvm: Inject events at the last stage of
 sync
Date: Wed, 29 Jan 2020 20:24:40 +0000
Message-Id: <20200129202441.12745-2-beata.michalska@linaro.org>
In-Reply-To: <20200129202441.12745-1-beata.michalska@linaro.org>
References: <20200129202441.12745-1-beata.michalska@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, kvmarm@lists.cs.columbia.edu,
 Christoffer.Dall@arm.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

KVM_SET_VCPU_EVENTS might actually lead to vcpu registers being modified.
As such this should be the last step of sync to avoid potential overwriting
of whatever changes KVM might have done.

Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
---
 target/arm/kvm32.c | 20 ++++++++++----------
 target/arm/kvm64.c | 20 ++++++++++----------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 32bf8d6..cf2b47f 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -386,17 +386,17 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         return ret;
     }
 
-    ret = kvm_put_vcpu_events(cpu);
-    if (ret) {
-        return ret;
-    }
-
     write_cpustate_to_list(cpu, true);
 
     if (!write_list_to_kvmstate(cpu, level)) {
         return EINVAL;
     }
 
+    ret = kvm_put_vcpu_events(cpu);
+    if (ret) {
+        return ret;
+    }
+
     kvm_arm_sync_mpstate_to_kvm(cpu);
 
     return ret;
@@ -462,11 +462,6 @@ int kvm_arch_get_registers(CPUState *cs)
     }
     vfp_set_fpscr(env, fpscr);
 
-    ret = kvm_get_vcpu_events(cpu);
-    if (ret) {
-        return ret;
-    }
-
     if (!write_kvmstate_to_list(cpu)) {
         return EINVAL;
     }
@@ -475,6 +470,11 @@ int kvm_arch_get_registers(CPUState *cs)
      */
     write_list_to_cpustate(cpu);
 
+    ret = kvm_get_vcpu_events(cpu);
+    if (ret) {
+        return ret;
+    }
+
     kvm_arm_sync_mpstate_to_qemu(cpu);
 
     return 0;
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 6344113..d06fd32 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -1043,17 +1043,17 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         return ret;
     }
 
-    ret = kvm_put_vcpu_events(cpu);
-    if (ret) {
-        return ret;
-    }
-
     write_cpustate_to_list(cpu, true);
 
     if (!write_list_to_kvmstate(cpu, level)) {
         return -EINVAL;
     }
 
+    ret = kvm_put_vcpu_events(cpu);
+    if (ret) {
+        return ret;
+    }
+
     kvm_arm_sync_mpstate_to_kvm(cpu);
 
     return ret;
@@ -1251,11 +1251,6 @@ int kvm_arch_get_registers(CPUState *cs)
     }
     vfp_set_fpcr(env, fpr);
 
-    ret = kvm_get_vcpu_events(cpu);
-    if (ret) {
-        return ret;
-    }
-
     if (!write_kvmstate_to_list(cpu)) {
         return -EINVAL;
     }
@@ -1264,6 +1259,11 @@ int kvm_arch_get_registers(CPUState *cs)
      */
     write_list_to_cpustate(cpu);
 
+    ret = kvm_get_vcpu_events(cpu);
+    if (ret) {
+        return ret;
+    }
+
     kvm_arm_sync_mpstate_to_qemu(cpu);
 
     /* TODO: other registers */
-- 
2.7.4


