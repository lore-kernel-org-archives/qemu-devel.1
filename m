Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C58C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:49:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AE142087D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="glkg0HcR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE142087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS04i-0001DX-F3
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqM-00072T-Kx
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:37 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqJ-0007Jm-E5
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:34 -0400
Received: by mail-wm1-x341.google.com with SMTP id q5so17954716wmq.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m+57w4waUDsMvpjTdXukUzVLKUiAH7ggRqO2IkZWWK8=;
 b=glkg0HcRhX7qs2EfhByu9sLqzsZG+NVIzN3ASb+5El6+xbkwltqLZBQ9y7QDt9Q3+t
 IKSW0n/+zZDYpK8TYI1usseAQtJ8+Lg4kk5VA5aW944p/mOzdJeudrY+vVYMxRDrQTR0
 EZqJIeHtDPkeOZ+z/I2g/c3LppkiHOarGOCaeULvlHeQl3xjY7Hzl/JLxX3HEFWs5A0Q
 71cDTJNSef42GXUBp33nfpDGxweSrvKsDM61EJVmgc+X6FouxzUwy7FfMAcHXp5XE3+L
 dxjjmhTe64fo2F0VcAd4lZ3seZAUWld1go6uyPeiFvPc2KBTDcGRSU42VrKCUp2pNQF4
 +SwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m+57w4waUDsMvpjTdXukUzVLKUiAH7ggRqO2IkZWWK8=;
 b=WYXckgnkxi3EuvI2vrC0qOjByaUeR9y9qGAzkjnu9ni9a1KprYBox4RZdNKU9zvMG1
 omI/2u716f5QZPuggHzKpvRIiqT+p64uqr6EF8YEKymVeehqDNnRuuxSdVP8YJpD/sV0
 nUqSawcpEkQX0fsJScfSelKGy7JbTGF/HHhsGU789NtNzKJtOUr+FFKHHXOD4xR8Hq58
 ZY0FUszvD6uX76tfH3DnD5wXI+zx8Sxj+IashNfYbZbBX9bCg9NCAqIDmbX0lH93fZlw
 tCYB4xUqOu5U1ybkCpld8wcAmF1OBcJpbwkZ0KPNxt7npmTCBKwM7vP//Ebz8lxl/7Nj
 t13Q==
X-Gm-Message-State: AOAM530mAPZMcrfSnKWll2Q8euZqZ3IRB2auK9fosWQUHUBd9CO9+eTY
 snrPG58JFLrxwjlm/htKI/fccg==
X-Google-Smtp-Source: ABdhPJy0s/tMr7a7W6VpAEx1VMxi0ETX8ZpI/O5OuEUPxNi5OepY7TXj7Y4dhULZEvAW6rRj4kdY4A==
X-Received: by 2002:a7b:cb82:: with SMTP id m2mr12017658wmi.56.1602516870030; 
 Mon, 12 Oct 2020 08:34:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm19675284wrq.73.2020.10.12.08.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:34:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/intc/arm_gicv3_cpuif: Make GIC maintenance interrupts work
Date: Mon, 12 Oct 2020 16:33:40 +0100
Message-Id: <20201012153408.9747-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153408.9747-1-peter.maydell@linaro.org>
References: <20201012153408.9747-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In gicv3_init_cpuif() we copy the ARMCPU gicv3_maintenance_interrupt
into the GICv3CPUState struct's maintenance_irq field.  This will
only work if the board happens to have already wired up the CPU
maintenance IRQ before the GIC was realized.  Unfortunately this is
not the case for the 'virt' board, and so the value that gets copied
is NULL (since a qemu_irq is really a pointer to an IRQState struct
under the hood).  The effect is that the CPU interface code never
actually raises the maintenance interrupt line.

Instead, since the GICv3CPUState has a pointer to the CPUState, make
the dereference at the point where we want to raise the interrupt, to
avoid an implicit requirement on board code to wire things up in a
particular order.

Reported-by: Jose Martins <josemartins90@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---

QEMU's implementation here is a bit odd because we've put all the
logic into the "GIC" device where in real hardware it's split between
a GIC device and the CPU interface part in the CPU.  If we had
arranged it in that way then we wouldn't have this odd bit of code
where the GIC device needs to raise an IRQ line that belongs to the
CPU.

Not sure why we've never noticed this bug previously with KVM as a
guest, you'd think we'd have spotted "maintenance interrupts just
don't work"...
---
 include/hw/intc/arm_gicv3_common.h | 1 -
 hw/intc/arm_gicv3_cpuif.c          | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index 0331b0ffdb8..91491a2f664 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -153,7 +153,6 @@ struct GICv3CPUState {
     qemu_irq parent_fiq;
     qemu_irq parent_virq;
     qemu_irq parent_vfiq;
-    qemu_irq maintenance_irq;
 
     /* Redistributor */
     uint32_t level;                  /* Current IRQ level */
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 08e000e33c6..43ef1d7a840 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -399,6 +399,7 @@ static void gicv3_cpuif_virt_update(GICv3CPUState *cs)
     int irqlevel = 0;
     int fiqlevel = 0;
     int maintlevel = 0;
+    ARMCPU *cpu = ARM_CPU(cs->cpu);
 
     idx = hppvi_index(cs);
     trace_gicv3_cpuif_virt_update(gicv3_redist_affid(cs), idx);
@@ -424,7 +425,7 @@ static void gicv3_cpuif_virt_update(GICv3CPUState *cs)
 
     qemu_set_irq(cs->parent_vfiq, fiqlevel);
     qemu_set_irq(cs->parent_virq, irqlevel);
-    qemu_set_irq(cs->maintenance_irq, maintlevel);
+    qemu_set_irq(cpu->gicv3_maintenance_interrupt, maintlevel);
 }
 
 static uint64_t icv_ap_read(CPUARMState *env, const ARMCPRegInfo *ri)
@@ -2624,8 +2625,6 @@ void gicv3_init_cpuif(GICv3State *s)
             && cpu->gic_num_lrs) {
             int j;
 
-            cs->maintenance_irq = cpu->gicv3_maintenance_interrupt;
-
             cs->num_list_regs = cpu->gic_num_lrs;
             cs->vpribits = cpu->gic_vpribits;
             cs->vprebits = cpu->gic_vprebits;
-- 
2.20.1


