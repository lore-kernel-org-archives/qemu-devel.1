Return-Path: <SRS0=4+Bn=ZB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B176EC43331
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 15:57:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77FDF21848
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 15:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lhw4tYnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FDF21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTT77-0003aE-Me
	for qemu-devel@archiver.kernel.org; Sat, 09 Nov 2019 10:57:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iTT6J-00036n-BA
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 10:56:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iTT6I-0007Lg-7m
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 10:56:35 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42741)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iTT6I-0007L8-1d
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 10:56:34 -0500
Received: by mail-oi1-x242.google.com with SMTP id i185so7937110oif.9
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2019 07:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V0J39ZP+gqYtH1FsiwOzOQMPVqG43LmtvsVt/9EATI0=;
 b=lhw4tYnxaLtJhVn/kv0pYyxVffeF3PaUuxP7p9Fpbt2/GNC3uU+Ck1KADCeI4ku2Z5
 Xzw7gam0h72lV02AGEqBW7aWk7HyHggOxmMZdD0MF9uBExKZpC5pQlxz2vVC2Ci3KRIB
 TJ9kSjXLyo5d+vy8j2gDrYX3i8WXv4sWQodFw88rDUSewzKOpH1LRoR3HGoGHZwPYVBv
 u4eDtFqF+Blm0DpTqdlV0gMy+wxhy9VIeHG0k1OCB69MAhanpZbpAfxPkR6wgBYnD3Ed
 Q/ZWFmOWHVGfqT2Fc1XiGoKdDvj6gIwCM7cEbhdv/nFK5jy2OBvnkQEVl6XMzjxyQAyl
 thMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V0J39ZP+gqYtH1FsiwOzOQMPVqG43LmtvsVt/9EATI0=;
 b=tx5+yeCbEGOIWVTdDPd9ikrtO+yiYZdGsdG0RNzywfq1jPENgSTcf/L2mZIGztUx7I
 c+3rr2Y55hpI3GFcwe9bn5TdVQ+8JGrI1ekO/DkZcYYGD2eP7jJjxmvsMIsjh6oHki/3
 mCo6Ah+GHCiXKbmBcD5kTedrnKYWHFnCP+G8n0DWdwBLpKCxrOhQVKzDOGDtmkpIC2IR
 FRaarOvV2mY1IvC3koUMaeol9FMeMW2TNlHZ0REQk8aQAjd5Qnj2OHlvyyFMd+TjsPyL
 ouK0QRCysPj9qVkwV+ERjs06XTEFyEY98eA0V4r8Nn2X+JjhYqK/9woPqUgLNgBDjRkE
 gvEg==
X-Gm-Message-State: APjAAAUHXwmG9M+Kcpv8510l4Og+HxreL3qemj0s9QCdf72hRXGF3Jol
 IZBrutTPd3Xi9/e7bxykec/unwyHX9BhL2+WbWTWRg==
X-Google-Smtp-Source: APXvYqwXLfMPazDakHpZ1f42MzE2uWF80g/h7LXsMxSCtr0+m1Yh0ZRS+Ovm0y3B/4Yu55S3pJED+7jptfFAe4vmlC0=
X-Received: by 2002:a05:6808:7d1:: with SMTP id
 f17mr16124762oij.163.1573314992944; 
 Sat, 09 Nov 2019 07:56:32 -0800 (PST)
MIME-Version: 1.0
References: <20191108194758.17813-1-palmer@dabbelt.com>
 <20191108194758.17813-3-palmer@dabbelt.com>
In-Reply-To: <20191108194758.17813-3-palmer@dabbelt.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 9 Nov 2019 15:56:21 +0000
Message-ID: <CAFEAcA_Lj2SmxMTEN06+FxwQrkuR80Vw5=Dkh1achFUySSFAxA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ARM/virt: Use fdt_setprop_strings()
To: Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 Nov 2019 at 19:48, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> This new helper function encodes the idiom used by the ARM virt board to
> set a string array.  I don't currently have a working ARM userspace, so I haven't tested
> this, but I made the helper function because I wanted to use it for the
> RISC-V virt board where I have tested it.
>
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> ---
>  hw/arm/virt.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index d4bedc2607..4dc00f54d5 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -304,9 +304,8 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
>
>      armcpu = ARM_CPU(qemu_get_cpu(0));
>      if (arm_feature(&armcpu->env, ARM_FEATURE_V8)) {
> -        const char compat[] = "arm,armv8-timer\0arm,armv7-timer";
> -        qemu_fdt_setprop(vms->fdt, "/timer", "compatible",
> -                         compat, sizeof(compat));
> +        qemu_fdt_setprop_strings(vms->fdt, "/timer", "compatible",
> +                                 "arm,armv8-timer\0arm,armv7-timer\0");
>      } else {


This seems to be changing the property we put in -- in
the old code it is 'foo\0bar\0', but in the new code
there will end up being two \0 at the end: 'foo\0bar\0\0'.

thanks
-- PMM

