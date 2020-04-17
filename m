Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3FDC38A29
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 11:10:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFC2B21D95
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 11:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XCqdspfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC2B21D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPOtP-0007oN-W8
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 07:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jPOsZ-0007Du-OH
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:09:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jPOsY-0002zr-Fe
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:09:51 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:33908)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jPOsY-0002zR-6m
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:09:50 -0400
Received: by mail-oo1-xc42.google.com with SMTP id q204so376363ooq.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 04:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L+a6vh1vUZ/GYvIsQQJcWYuzro5d5IT5YKmZYXp+FtQ=;
 b=XCqdspfAJJJBHPIqDiPxZzbqhdRwD+rB0tkhAk28fZQHxCZVFvBPaqMFFsbcLEJMiB
 YYOdnZy03qKoWuShVn7AFN7teT96Lewsi3X8XengNmj7ZfpLMEhH9OGK9wtv96UMr+6N
 GbiyB4p6mR/3yIgHsupbVS/PyxuVeznzrxJHayE8RaH7zskEeOFPNVKvPFA3A0ifnMgd
 g9cjzhX8+kx/BnfvnbJ/DXAF4TaS61q7ai8fpaPWPEAJ/09OK7e8P/UcrJ0R4o1drUSt
 ucEwP2s3gpTWuIfiZqgmyvYw2nvaGQN5GMNxDALbncGAYU7PrzqY6Qd28qpF1VTMDQBl
 IYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L+a6vh1vUZ/GYvIsQQJcWYuzro5d5IT5YKmZYXp+FtQ=;
 b=MPEfdawAvJ/CWgdZvcJePPXMjZ919ICEUPuFdgLISG/1vfGg40sW0NUpAcS7AZvU7r
 EUahPrklL6HEyxW+R3Kem13+AMyr4AXKZs+VPDCDre9ik4ZO2qeWSTlfyuo8YdrS7bLN
 beQiJAhyesy0JizlQMTMip+1y1HG0g4Wq87l/Nvj681DXxPC1LeOTVKtzrbFJIN8jgp+
 gZmGgmSaf0GgEBWrn2yCv3ImLyjvNOCcn8W4M7AwtZ0/35ce+izyEZWHdhWdyMQGJv+N
 ztpb8zvBYPvAmy2Khn9hksL+azI0vSfvq8uPas6g4gnI/Hsb+UKlDfV2tqRdY/QASsRH
 sKfw==
X-Gm-Message-State: AGi0PuYnWQIUs0qWaLPk/KrkpshfSNkm63iXsNSvhfGwuACHtPthz9dc
 H9D+gAOrjTEXPUfXhTvG0fzpGFcd6ImR3GQrjGU/BQ==
X-Google-Smtp-Source: APiQypI4VAXkXEn8MfLlMSE9RZMeskOWdKDt3PhXdlboy/MePoSTgGy3h5dZGJagFVlkZszYIrnmdCB/w1cZuofEqmU=
X-Received: by 2002:a4a:890b:: with SMTP id f11mr2021652ooi.85.1587121789362; 
 Fri, 17 Apr 2020 04:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200413091552.62748-1-zhukeqian1@huawei.com>
 <20200413091552.62748-3-zhukeqian1@huawei.com>
In-Reply-To: <20200413091552.62748-3-zhukeqian1@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Apr 2020 12:09:38 +0100
Message-ID: <CAFEAcA9iUAtVvuv_8AOm0TkYzDD54QHZEL_DKRv_b_YpaVTJ_g@mail.gmail.com>
Subject: Re: [PATCH 2/3] intc/gicv3_kvm: use kvm_gicc_access to get
 ICC_CTLR_EL1
To: Keqian Zhu <zhukeqian1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
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
Cc: wanghaibin.wang@huawei.com, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Apr 2020 at 10:18, Keqian Zhu <zhukeqian1@huawei.com> wrote:
>
> Replace kvm_device_access with kvm_gicc_access to simplify
> code.
>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> ---
>  hw/intc/arm_gicv3_kvm.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index ca43bf87ca..85f6420498 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -678,9 +678,8 @@ static void arm_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
>      }
>
>      /* Initialize to actual HW supported configuration */
> -    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
> -                      KVM_VGIC_ATTR(ICC_CTLR_EL1, c->gicr_typer),
> -                      &c->icc_ctlr_el1[GICV3_NS], false, &error_abort);
> +    kvm_gicc_access(s, ICC_CTLR_EL1, c->cpu->cpu_index,
> +                    &c->icc_ctlr_el1[GICV3_NS], false);

This works at the moment, but I'd rather we avoided looking into
cpu->cpu_index inside the GIC code. The cpu_index is the overall
index of the CPU of all CPUs in the system, which is not in
theory the same as "index of this CPU for this GIC". The two
currently match up because arm_gicv3_common_realize() populates
its s->cpu[i].cpu by calling qemu_get_cpu(i), but in future
we might change that code (eg so that the board code has to
explicitly wire up the CPUs to the GIC object by passing
pointers to the CPUs to the GIC via link properties). So I'd
rather not have the internals of the GIC code bake in the
assumption that 'global CPU index is the same as the index
of the CPU for this GIC object'.

(All the other places that call kvm_gicc_access() are doing it
as part of a loop from 0 to n->num_cpus, so they don't have this
issue.)

thanks
-- PMM

