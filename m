Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA040C4742C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:18:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 393652222B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="KFWc1GOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 393652222B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZaf7-0008Lv-3R
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 09:18:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kZaeH-0007iJ-0B; Mon, 02 Nov 2020 09:17:29 -0500
Received: from pharaoh.lmichel.fr ([149.202.28.74]:59700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kZaeE-00049R-7A; Mon, 02 Nov 2020 09:17:28 -0500
Received: from localhost (sekoia-pc.home.lmichel.fr [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPSA id DBD91C60011;
 Mon,  2 Nov 2020 14:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1604326642;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qp0haXp9skMBrDWMipkfGnc7ZWhDc+b1zvHHdD+csw8=;
 b=KFWc1GObrJSp9skTMAmV4nZRO88+hgm6JtDJy3haaCR/ChlOT/lT8Qb/3aad7W1edJnfw2
 jtL8++jmqRBecpWfYqEG5aMPG3DlzhFo4F9r1fDVwaC20ECb/tdS3GU8CSiTQnJKaR8hTa
 WdjhHoL69dA66MsyzofvH/Fp9ZDLBj2RWGZoR8rwC0QQmG/PGa5sstRcb5/nQwmZpq4phN
 9ff41TlQdrCG3FocUCvkfJ0DA8O91BAgzZRlZ6bF6igytcpKEHE0afJcdZBYw6fxcQUHyc
 coUt/IdwlURl2mPS0vkrYIRZalCaJe9wJwXakEli1vv/Fojx8uUkMwQJZ5k3KA==
Date: Mon, 2 Nov 2020 15:18:36 +0100
From: Luc Michel <luc@lmichel.fr>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] hw/intc/arm_gicv3_cpuif: Make GIC maintenance interrupts
 work
Message-ID: <20201102141836.6qla5tcp5afqb63e@sekoia-pc.home.lmichel.fr>
References: <20201009153904.28529-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009153904.28529-1-peter.maydell@linaro.org>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1604326643;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qp0haXp9skMBrDWMipkfGnc7ZWhDc+b1zvHHdD+csw8=;
 b=bJnVuMT30izud7rIqG3qoY+C16RkPq0VhdzafPIFw0oajghMxQVAeSvG7RzeR2BhHHfLQV
 JGZf1QnCjcE6j3vBYZJLJrsbF//7C+bRzLznK9eHjtGuMWGmjmiU4ffEzyP3ooHFWXWT7b
 gtlz5QgBja+vb3sx7ebx7QUkLX+JQqddS1Sba9bBqe7EXWbeQaANGZBn0liqOiyXDFpeWy
 DnFMHgQh0skbwJ66g44AQexczyKA+nBws7no+8jzd9deog0RPEw82fxaLvtmfsXR5mJ6W+
 KWO7IcMnHv6re2vrfvfSoy5OmNtbrKDE9K8/VNDDAt2XJoZ33Ce42ugL1hek7A==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1604326643; a=rsa-sha256; cv=none;
 b=ViaW+96wZWcFJYbSiWYXaHaiJJpaJS0jYV0U5vSaJ9Opehl4/lx8jLYB4F2x34dxf/MncrAKRpF5ygsVOBTQTsclo1DMXm9BuOsO2v4IEJn0RnbNVCRtVmqeYCEBp9CTj0lFvqKZggeZWotitq7zpJRYVMA4IU6dBXRHc5tkJY8Rh50P+gkz750z9/ydKLdg8UxjH/NhBRA2xmkMTOQahtUdTuNB2eQ7LTzRfbW09Xh7qZAG9gNdkWyA44RnGrOdUakXQnEKcio9bE1Ax/8CJcXLAX+RywhnDRDzzRnzHaU6Q5Vy7GkcqdWgti4Llrwo+XbB0c3MLmuNIBzTBlufcA==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=sekoia smtp.mailfrom=luc@lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 08:49:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jose Martins <josemartins90@gmail.com>, Marc Zyngier <maz@kernel.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16:39 Fri 09 Oct     , Peter Maydell wrote:
> In gicv3_init_cpuif() we copy the ARMCPU gicv3_maintenance_interrupt
> into the GICv3CPUState struct's maintenance_irq field.  This will
> only work if the board happens to have already wired up the CPU
> maintenance IRQ before the GIC was realized.  Unfortunately this is
> not the case for the 'virt' board, and so the value that gets copied
> is NULL (since a qemu_irq is really a pointer to an IRQState struct
> under the hood).  The effect is that the CPU interface code never
> actually raises the maintenance interrupt line.
> 
> Instead, since the GICv3CPUState has a pointer to the CPUState, make
> the dereference at the point where we want to raise the interrupt, to
> avoid an implicit requirement on board code to wire things up in a
> particular order.
> 
> Reported-by: Jose Martins <josemartins90@gmail.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Luc Michel <luc@lmichel.fr>

> ---
> 
> QEMU's implementation here is a bit odd because we've put all the
> logic into the "GIC" device where in real hardware it's split between
> a GIC device and the CPU interface part in the CPU.  If we had
> arranged it in that way then we wouldn't have this odd bit of code
> where the GIC device needs to raise an IRQ line that belongs to the
> CPU.
> 
> Not sure why we've never noticed this bug previously with KVM as a
> guest, you'd think we'd have spotted "maintenance interrupts just
> don't work"...
> ---
>  include/hw/intc/arm_gicv3_common.h | 1 -
>  hw/intc/arm_gicv3_cpuif.c          | 5 ++---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
> index 0331b0ffdb8..91491a2f664 100644
> --- a/include/hw/intc/arm_gicv3_common.h
> +++ b/include/hw/intc/arm_gicv3_common.h
> @@ -153,7 +153,6 @@ struct GICv3CPUState {
>      qemu_irq parent_fiq;
>      qemu_irq parent_virq;
>      qemu_irq parent_vfiq;
> -    qemu_irq maintenance_irq;
>  
>      /* Redistributor */
>      uint32_t level;                  /* Current IRQ level */
> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
> index 08e000e33c6..43ef1d7a840 100644
> --- a/hw/intc/arm_gicv3_cpuif.c
> +++ b/hw/intc/arm_gicv3_cpuif.c
> @@ -399,6 +399,7 @@ static void gicv3_cpuif_virt_update(GICv3CPUState *cs)
>      int irqlevel = 0;
>      int fiqlevel = 0;
>      int maintlevel = 0;
> +    ARMCPU *cpu = ARM_CPU(cs->cpu);
>  
>      idx = hppvi_index(cs);
>      trace_gicv3_cpuif_virt_update(gicv3_redist_affid(cs), idx);
> @@ -424,7 +425,7 @@ static void gicv3_cpuif_virt_update(GICv3CPUState *cs)
>  
>      qemu_set_irq(cs->parent_vfiq, fiqlevel);
>      qemu_set_irq(cs->parent_virq, irqlevel);
> -    qemu_set_irq(cs->maintenance_irq, maintlevel);
> +    qemu_set_irq(cpu->gicv3_maintenance_interrupt, maintlevel);
>  }
>  
>  static uint64_t icv_ap_read(CPUARMState *env, const ARMCPRegInfo *ri)
> @@ -2624,8 +2625,6 @@ void gicv3_init_cpuif(GICv3State *s)
>              && cpu->gic_num_lrs) {
>              int j;
>  
> -            cs->maintenance_irq = cpu->gicv3_maintenance_interrupt;
> -
>              cs->num_list_regs = cpu->gic_num_lrs;
>              cs->vpribits = cpu->gic_vpribits;
>              cs->vprebits = cpu->gic_vprebits;
> -- 
> 2.20.1
> 
> 

-- 

