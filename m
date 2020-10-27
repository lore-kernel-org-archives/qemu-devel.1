Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164CDC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 21:22:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68C3A221FB
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 21:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ru1c9M3E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C3A221FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXWQ4-0003Av-C4
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 17:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXWOk-0002DF-Re
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 17:20:54 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:43502)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXWOi-0003wz-RW
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 17:20:54 -0400
Received: by mail-ed1-x542.google.com with SMTP id dn5so2950534edb.10
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 14:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d0UbQvo8Vb3wDc/aJyL7VyV7Y6DvIzJ3l15+MRR+t/M=;
 b=ru1c9M3EPVQKRU7OXH0NpPO9pQ7KwB+L4L/EQSJA3KWr8bk55h7RZD92/QoRflod6q
 gLLU00LoyqQIP9A4dRp3Zbg/Jnp5XLqRzkdP8jm/5UOAUWadPM1h8m0d35uQBs9twpnD
 MJcf1kI2ZVb4U6gx4jhvcHKMEevJm65bIpQBz99JYY+VwNW/SUnZLURbf9gbmotoMXLn
 DM3s9dy4F8O9RtSZpMJHJRNbdnCNAKOEDVQlxJl560Dp7QQTVW1w1XrelLgF+NZgp3+s
 LqbdMzsIkk43DwEWEGXqjF/1LaNhT6Rmz6Qh/olIUP/8DRxTFM77w3MAl0o8/I5+P8Ik
 vAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d0UbQvo8Vb3wDc/aJyL7VyV7Y6DvIzJ3l15+MRR+t/M=;
 b=ua2GgotlTot2VY/kG4k5Du296nUDCysKlRSGFI8OsDeGuIhU+ffp93dPxE4o54yIoQ
 9RBg7eb2wyvcZRS7/3ssTCbAeYBDeTTnJapC3ZJQ4m7Dw4Z9UPWVclVRDy+j5EZO/+hp
 WX38kcCVXo0OZ7gtWUC5fL1fL1F+OM/w2fXs548tRb/uN+LxguUHTzv0SxWMO65W2grE
 WnD1s+fitIkxy/TOjNgFRPf4ugJGkXeWSdv/M07K0g7NC1jRYaIiIjFFKOadQtkRh+Dh
 v1azzZqK9OLP0X6VCGYwzNpZx5thNaeD47h+QDsAMQCW3//l5Pih1jXrW8qjPD5P16AU
 mykg==
X-Gm-Message-State: AOAM5336PPKgB3F4tygkKq17XK+SsD7c4bm9B2adG41fwW7jql5qWRFG
 UZpZrQ/DRbKEXFAczr1ZzrVomUPYXHpqkenhgKUfWw==
X-Google-Smtp-Source: ABdhPJxhKBsnrlh4qEzVXJOYba0Kccwr+goxR7w8UfSVC7voQImgwhCSMfw3fM3ek3Te8BbZ9eI+0eZquslGeeVBQEc=
X-Received: by 2002:a50:f41a:: with SMTP id r26mr4258583edm.251.1603833651094; 
 Tue, 27 Oct 2020 14:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201026212853.92880-1-keithp@keithp.com>
 <20201026212853.92880-2-keithp@keithp.com>
In-Reply-To: <20201026212853.92880-2-keithp@keithp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Oct 2020 21:20:39 +0000
Message-ID: <CAFEAcA-0_WLMP1Y1sgcu7Ng+0w8Ovt9DVWzYU8ZA_FA2+bwcUw@mail.gmail.com>
Subject: Re: [PATCH 1/4] semihosting: Move ARM semihosting code to shared
 directories
To: Keith Packard <keithp@keithp.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 qemu-arm <qemu-arm@nongnu.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 at 21:29, Keith Packard <keithp@keithp.com> wrote:
>
> This commit renames two files which provide ARM semihosting support so
> that they can be shared by other architectures:
>
>  1. target/arm/arm-semi.c     -> hw/semihosting/common-semi.c
>  2. linux-user/arm/semihost.c -> linux-user/semihost.c
>
> The build system was modified to reflect this change, but the contents
> of the two files are unchanged.
>
> Signed-off-by: Keith Packard <keithp@keithp.com>
> ---
> diff --git a/target/arm/arm-semi.c b/hw/semihosting/common-semi.c
> similarity index 100%
> rename from target/arm/arm-semi.c
> rename to hw/semihosting/common-semi.c
> diff --git a/hw/semihosting/meson.build b/hw/semihosting/meson.build
> index f40ac574c4..fbd2841e59 100644
> --- a/hw/semihosting/meson.build
> +++ b/hw/semihosting/meson.build
> @@ -2,3 +2,5 @@ specific_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
>    'config.c',
>    'console.c',
>  ))
> +
> +specific_ss.add(when: 'CONFIG_TCG', if_true: files ('common-semi.c'))

I think this adds this file to the compilation for all TCG targets;
you only want it for targets which have Arm-semihosting-ABI compatible
semihosting. (Various other targets either don't have semihosting
or have their own ABI.)

thanks
-- PMM

