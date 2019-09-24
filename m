Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3739FC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 09:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0379F20872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 09:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j4tKQdc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0379F20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iChYc-0007Ad-WE
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 05:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iChTA-00027o-Hc
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iChT8-0003lk-UQ
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:50:52 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36500)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iChT3-0003kJ-IW
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:50:47 -0400
Received: by mail-ot1-x344.google.com with SMTP id 67so919279oto.3
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 02:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Rb/CI/UDcICyJhhVG9b3e0movg5c/F1agPe9IRth4mg=;
 b=j4tKQdc8ubJZe35qvKYdF+zyW0JCXvpyBMloHkE0upAoEXgZSrQoYEHdFox/j3/Wjx
 WmcG6edaV4Aupt/IfpAWRK8d1G4CCEm8r0cuyliYLtP/AcB7ZlNiRL9t5mV4wDv0w9fL
 VJqzakgI8lDyCchdviDPH6CCL/X0tOhUts2XEkUggh47PZrYGtK/mMVGILxzkRD5fAzx
 ujn0i+LcWoSz7GfSzmIczFJUBAlOIrKs4DoA/XHTKvTRs79KuC63PClFLdMxJho1VXyx
 RNO+myMAYbF9mXKgMcww+cRQwKKxanOFgST0w+Ko2WzsXsYOrOwQ989tWxdq0WUXBla+
 Z3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Rb/CI/UDcICyJhhVG9b3e0movg5c/F1agPe9IRth4mg=;
 b=emb+Z1B3V8qFXTMi/tKEdhxLx+QNG8JJ9dksYeyCYcePtdZbcAR1qb73lJTCEfP0eq
 xqtYFnjFVtxhCX1gD1fmE2TDewJPom92z+qHrz5Njyolicz5BO2djgLt1isblkp9jwYD
 PHvH9o0CB0tdItO5RgnLnSWqbGlpFyzoYwsyjtDUJtKWm/eWxTY07nqt+KB0F/Wwi9CE
 Aqxt8bZ1EyBac0zC6/d5S+EjE0huA+cK+nAmSBFfn9y+kGau9mxxJq8ye5mKsaGI2n4F
 rcLXSptYz8cZI77L10OvUZqX6NPXQgXR1ok+RXu5kYc+5ZfC7qgA9vtSbQ2mjWx1lmpG
 xG4w==
X-Gm-Message-State: APjAAAVYMJbFjtDmMB5XgTePxHurwGgvvEOo8+lrwCcPFvAP5vcecVsA
 w14ijzzCPw692Tx8bBfI6ppwNsVcJO0GDTICJPsiAg==
X-Google-Smtp-Source: APXvYqx/yryZboylnU7k25e3/vfd7dzpCdQnivzpgn2VC8wmXwLIYDgiOsNWsx00vCanIO7wmnVmje0eTfIiyCK1aHU=
X-Received: by 2002:a9d:4615:: with SMTP id y21mr1023464ote.97.1569318642069; 
 Tue, 24 Sep 2019 02:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190924084201.107958-1-anup.patel@wdc.com>
 <20190924084201.107958-2-anup.patel@wdc.com>
In-Reply-To: <20190924084201.107958-2-anup.patel@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Sep 2019 10:50:31 +0100
Message-ID: <CAFEAcA-cm2GaKHg7_VcSb-OHp8GA9KuWiyWbc6r3F1p7tLc35A@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw: timer: Add Goldfish RTC device
To: Anup Patel <Anup.Patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Sep 2019 at 09:45, Anup Patel <Anup.Patel@wdc.com> wrote:
>
> This patch adds model for Google Goldfish virtual platform RTC device.
>
> We will be adding Goldfish RTC device to the QEMU RISC-V virt machine
> for providing real date-time to Guest Linux. The corresponding Linux
> driver for Goldfish RTC device is already available in upstream Linux.
>
> For now, VM migration support is not available for Goldfish RTC device
> but it will be added later when we implement VM migration for KVM RISC-V.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
> +
> +static Property goldfish_rtc_properties[] = {
> +    DEFINE_PROP_UINT64("tick-offset", GoldfishRTCState, tick_offset, 0),
> +    DEFINE_PROP_UINT64("alarm-next", GoldfishRTCState, alarm_next, 0),
> +    DEFINE_PROP_UINT32("alarm-running", GoldfishRTCState, alarm_running, 0),
> +    DEFINE_PROP_UINT32("irq-pending", GoldfishRTCState, irq_pending, 0),
> +    DEFINE_PROP_UINT32("irq-enabled", GoldfishRTCState, irq_enabled, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};

What are all these properties trying to do ?

> +
> +static void goldfish_rtc_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    dc->props = goldfish_rtc_properties;

Missing reset function.

If you don't want to implement migration support now
you should at least put in something that block migration.
(Personally I prefer to just write the vmstate, it's as
easy as writing the code to block migrations.)

thanks
-- PMM

