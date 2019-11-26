Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5A6C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:16:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85B8C2071A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DXbDcWYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B8C2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZbdS-0002EU-NP
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 09:16:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iZbaC-00079g-D9
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:12:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iZbaB-0005mH-Av
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:12:48 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iZbaB-0005lr-4d
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:12:47 -0500
Received: by mail-wm1-x341.google.com with SMTP id n188so3505912wme.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 06:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=aKXqfhFcjwTNQfz6gmtXLCCK1LadnZMXJ8QP8IawtYU=;
 b=DXbDcWYmL5p4FFOEabOQtqYztMUQU48iIGjBQAROPqWvor3wfVX4BCtPFtINxBudPJ
 tYGSmErbbmqubVeFEJiQvZJIQf7NBk/t64uH4NwDPpAYz2VB/+qlbu/1w2vy6T4CiKvt
 pXOY6Hm99zb5cK3YdM4vrmsGYJJA7pxzr8cALO36EwIQx+IUqg13tQkvCybn6cePEIQM
 pQc3mSFA5mSpNn9NPVLrmM9L9+DU6rNALJP7i7vYqzwiaZXQRNS/6PlOc8l79t3ekwr8
 pVVL3j+ip5s8evOfVQ1HSVpWcJca/yKnJI462SPAM21S3t9sXOqqMBvKACg1ORBpf50C
 dzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aKXqfhFcjwTNQfz6gmtXLCCK1LadnZMXJ8QP8IawtYU=;
 b=YE+nsmc1El25YgI0OjM0kc5ef+KKEzc2iXuBAuvJVK5MkxM6GTuFXy9fXD+oKo5V6v
 jGmAQjajnzT/dwmhT9mE9npQ9dd9M7hiQ3At8qoqtpXmhJJewe1LJVmRoAzmY5gBtIPP
 5jchzOg6cqMvAd7Fpu0Nia2yzcDOSP9DuFBq136rPIX9OBuauTHe5k/zPUfMCSfLpBXf
 b/mP47AibgR8OZIzm3SOE/NaxxCFT/q08/BBe5I/OdXMUYljB7++Y4uylNOQZEuhZDXj
 tXtFNXcfoK7Q8whNMLCobR8GQkDimJhZySUTDhHBcIMHg4vAXHT/RczHgodO5n3Ns+Ei
 5Viw==
X-Gm-Message-State: APjAAAXfmSM7mdqd24R+YvNbbIIxUhAvcacz9QxItp35Zw/4VQLXPZg3
 mkdo3SWvwOxFA0sFUa4nwyfpeXn59V0=
X-Google-Smtp-Source: APXvYqydkbHGSC8yF+ABBGHC1r5HXf50WiP5iU/QHn+9CB7WIWvagJIH893JH2DCy8gXbPP4ybg+xA==
X-Received: by 2002:a1c:99cb:: with SMTP id b194mr4725581wme.100.1574777565929; 
 Tue, 26 Nov 2019 06:12:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id i127sm3364581wma.35.2019.11.26.06.12.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 06:12:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/4] target/arm: Fix ISR_EL1 tracking when executing at EL2
Date: Tue, 26 Nov 2019 14:12:38 +0000
Message-Id: <20191126141239.8219-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191126141239.8219-1-peter.maydell@linaro.org>
References: <20191126141239.8219-1-peter.maydell@linaro.org>
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

From: Marc Zyngier <maz@kernel.org>

The ARMv8 ARM states when executing at EL2, EL3 or Secure EL1,
ISR_EL1 shows the pending status of the physical IRQ, FIQ, or
SError interrupts.

Unfortunately, QEMU's implementation only considers the HCR_EL2
bits, and ignores the current exception level. This means a hypervisor
trying to look at its own interrupt state actually sees the guest
state, which is unexpected and breaks KVM as of Linux 5.3.

Instead, check for the running EL and return the physical bits
if not running in a virtualized context.

Fixes: 636540e9c40b
Cc: qemu-stable@nongnu.org
Reported-by: Quentin Perret <qperret@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Message-id: 20191122135833.28953-1-maz@kernel.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a089fb5a690..027fffbff69 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1934,8 +1934,11 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     CPUState *cs = env_cpu(env);
     uint64_t hcr_el2 = arm_hcr_el2_eff(env);
     uint64_t ret = 0;
+    bool allow_virt = (arm_current_el(env) == 1 &&
+                       (!arm_is_secure_below_el3(env) ||
+                        (env->cp15.scr_el3 & SCR_EEL2)));
 
-    if (hcr_el2 & HCR_IMO) {
+    if (allow_virt && (hcr_el2 & HCR_IMO)) {
         if (cs->interrupt_request & CPU_INTERRUPT_VIRQ) {
             ret |= CPSR_I;
         }
@@ -1945,7 +1948,7 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
         }
     }
 
-    if (hcr_el2 & HCR_FMO) {
+    if (allow_virt && (hcr_el2 & HCR_FMO)) {
         if (cs->interrupt_request & CPU_INTERRUPT_VFIQ) {
             ret |= CPSR_F;
         }
-- 
2.20.1


