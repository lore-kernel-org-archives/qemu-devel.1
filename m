Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4200BC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 10:17:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F60A20674
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 10:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qtowk1Nf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F60A20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6BJI-0001Rt-66
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 06:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i6BIK-0000tw-NP
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i6BIJ-0007aD-IJ
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:16:44 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37213)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i6BIJ-0007Zq-Cj
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:16:43 -0400
Received: by mail-ot1-x341.google.com with SMTP id s28so5226211otd.4
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 03:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JhYDg3Hv4gco9LB6XeZ1unYrJu/xgj/tQEkCfCDtBNQ=;
 b=qtowk1NfwnkLW1Z4RhFXze1ftyz2OkOfplJ0FVOzV3oCePLurshMigXlAdVh4WV5vL
 fLy9HRQ53YMgNmTKIEbbCOAB6qbkIw1nIbQbtKW6mFwt5pTa03eRk5sZYi59eQjZtxgA
 u/igyYMpzAl87TLCi5qNFmOUFZAn8ON2Jy/xX78L8mXezt/9CO1F8KyL5jtV3JyHyhbg
 KKL2Lw/9D5gerA4I/yUfKay5v6S3UwnmThy+vBA46GDhX6LbRkAaoLSd96Q0ri2dGAdM
 TkyoOWVnnTqwy0lcrLxQiyu53jFhPNbu4IbOpMtkX5tTL0fA6Q88zssReEEUCM805wbL
 QA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JhYDg3Hv4gco9LB6XeZ1unYrJu/xgj/tQEkCfCDtBNQ=;
 b=LZ34SW9t7DAQqwjOcXjqY4ZA2rdm56JMUd5xKiu9i5d1iHKMyLex0OjqWGAENgteWa
 mCbTe5UIIGCyOsgcET43jM2mYrb6Z3bosTd/yfE66cC7WUx2PWUX/Ynw7DhcDsCJfr3n
 pD91HRH83l8V4BoUuVfQgjm3RtQnfS+60Fskh1PwIjQop/Z0PXfUMGOHTomVKL/91cIk
 esfnHS0wygSZVPpbfKpRqe276gooYPPGGGC5A58aKcpYw3V2ExcDA4ohmu0SlDCqVWn6
 xxcVo0uOqFTEoF9hhJ6fhstpBWH+La5llzNkzkDYOxQxxdJUh7JACoNiSg+donFWHvsj
 NxDw==
X-Gm-Message-State: APjAAAUAtK4aIlMTDDvplH5TRUssmNzxsNIaZYpGGW4ctQzu1QxuSgNZ
 T/hVtX8ZgtL0vOx/6+T6rLevwmcm/QK5I5jIWdwfDQ==
X-Google-Smtp-Source: APXvYqw8KtdIndK0F44S4Fl787wXdyJKwwlp1BPeQzmB+jazQBoAkGyJX+cU61ZkrOoToweO1oNys9M7W+9PSnIgLf4=
X-Received: by 2002:a9d:7504:: with SMTP id r4mr6253648otk.221.1567765002624; 
 Fri, 06 Sep 2019 03:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190827160554.30995-1-eric.auger@redhat.com>
 <20190827160554.30995-4-eric.auger@redhat.com>
In-Reply-To: <20190827160554.30995-4-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Sep 2019 11:16:31 +0100
Message-ID: <CAFEAcA8PCRxTnfhOuo2e4C2xVnn7EX1RWEcKurhNohi-WS+qow@mail.gmail.com>
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [RFC 3/3] virt: Check
 KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 for smp_cpus > 256
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
Cc: Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Aug 2019 at 17:06, Eric Auger <eric.auger@redhat.com> wrote:
>
> Host kernel within [4.18, 5.3] report an erroneous KVM_MAX_VCPUS=512
> for ARM. The actual capability to instantiate more than 256 vcpus
> was fixed in 5.4 with the upgrade of the KVM_IRQ_LINE ABI to support
> vcpu id encoded on 12 bits instead of 8 and a redistributor consuming
> a single KVM IO device instead of 2.
>
> So let's check this capability when attempting to use more than 256
> vcpus.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/virt.c        |  7 +++++++
>  target/arm/kvm.c     |  7 +++++++
>  target/arm/kvm_arm.h | 13 +++++++++++++
>  3 files changed, 27 insertions(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 0d1629ccb3..bcc8d64384 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1575,6 +1575,13 @@ static void machvirt_init(MachineState *machine)
>          virt_max_cpus = GIC_NCPU;
>      }
>
> +    if (kvm_enabled() && max_cpus > 256 &&
> +        !kvm_arm_irq_line_layout_2(MACHINE(vms))) {
> +        error_report("Using more than 256 vcpus require a host kernel "
> +                     "with KVM_CAP_ARM_IRQ_LINE_LAYOUT_2");
> +        exit(1);
> +    }

Is there some place we could put this check that isn't specific
to the virt board, so that we don't need to duplicate it in
any other future KVM-supporting boards we add?

thanks
-- PMM

