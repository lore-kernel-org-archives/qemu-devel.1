Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B893C49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 08:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17946208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 08:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JbyC+GGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17946208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Khd-0002f5-6x
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 04:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8Kgg-00025T-Qi
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8Kgf-0005Eq-OX
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:42:46 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41397)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8Kgf-0005E2-J5
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:42:45 -0400
Received: by mail-oi1-x242.google.com with SMTP id w17so3253071oiw.8
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 01:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cI65MUPveMrT7l9BraFDGQca8s8WLn5iaBchREhiiec=;
 b=JbyC+GGlMBQlXXj6xmmLQmX2KSrWKYa3SCabOW8AsVyHFDlm1oKS2iL3fO5/7htszG
 +5mCwLH5HYlzSAbKaOPLb0oemGt+e0rYbx+fFPg7MGxo/RXFpqMX/Di2A06W4mJsfBia
 K15ABN1z/kIY+pzdFeuGRpkxC4C+aSUBWS2W+P/6FokVYVhWFw5+8g115wNgLH/y/czK
 7Arsyhl/ah/x5tDPhla1mwOF3BK8G62+p9EVtbRwRmXPnaZYQIIyaQl8xKyIPoMcpf+6
 9JLXZmsqTms6A91KrN/xzMr6TztZtk7QRG31HB2MDk0UBwZVcifCHZGJy4277kFwpikR
 IsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cI65MUPveMrT7l9BraFDGQca8s8WLn5iaBchREhiiec=;
 b=p+4GxIrtJsSMxTz8i0P+KvtR59R4rpU9Xkn/43Jtwp3fR+G8gNPp2MilIAefAeKK+9
 4AZ4sMGbw5wqIedUO/EN+dwPwtF8FCqZ7c+GqQVf5eTk297+7o/Mqh/LDJsAbP7KTaN4
 bPen1NOShW1MuM7pFwV+fg6VJTU0kMvM1DsWRnBvC8+DmGhHZb9Za1zAlBYDcRxbRM0+
 /fLz6Pq38pkdeJnXQxJZpp5i14rtK//P5bhug1OgkW9sTsQ3eB1opadw2yP+A92VgRnr
 uZW5zjiW1g+hBIQpTwYL3axcz1e5fdXXvaUOMfxDzuIbUtntZ4TisWYNi6Iv4lcC0hJX
 msLA==
X-Gm-Message-State: APjAAAWP6TrcK9/T3l5sBo4WnrBtPkTFxwD/izohsrmX//I6aMFIXonk
 WCYXTJayR+BQd2ThO4J7rAYg0oZNqrCevm3qG0JV8g==
X-Google-Smtp-Source: APXvYqyiAVu3KRTItTTkLHjaOgsX4xiMaH0pRVWejC2NeWD0XqoAPTtF7imXxjsSnPcNPffOSFYWlRx0rt1Gt0TrV3U=
X-Received: by 2002:aca:281a:: with SMTP id 26mr7693853oix.163.1568277764510; 
 Thu, 12 Sep 2019 01:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190911155125.11932-1-eric.auger@redhat.com>
 <20190911155125.11932-4-eric.auger@redhat.com>
In-Reply-To: <20190911155125.11932-4-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Sep 2019 09:42:33 +0100
Message-ID: <CAFEAcA-tZJ2C8=ZH5e7tXzigPu3SGjSJbnLybZTG+hZO-7ZV0A@mail.gmail.com>
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [RFC v2 3/3] virt: Check
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

On Wed, 11 Sep 2019 at 16:51, Eric Auger <eric.auger@redhat.com> wrote:
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
>  hw/arm/virt.c        |  4 ++++
>  target/arm/kvm.c     | 21 +++++++++++++++++++++
>  target/arm/kvm_arm.h | 15 +++++++++++++++
>  3 files changed, 40 insertions(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 0d1629ccb3..465e3140f7 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1575,6 +1575,10 @@ static void machvirt_init(MachineState *machine)
>          virt_max_cpus = GIC_NCPU;
>      }
>
> +    if (kvm_arm_irq_line_layout_mismatch(MACHINE(vms), max_cpus)) {
> +        exit(1);
> +    }
> +

Is there really no place to put this check in common code?

thanks
-- PMM

