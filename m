Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D48C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 046CC2396D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g2ljGLeb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046CC2396D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKft3-00012s-OE
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kKfqQ-0007Ni-IG
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:48:22 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kKfqM-0000Ge-FR
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:48:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id j2so16523937wrx.7
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 03:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=3uTapVf4mWqY1AA8Mhz8NgpXokYZRvFUx7bT66gfDwE=;
 b=g2ljGLebX+ABnFio9ZnXz3fuBE48oLEra6vq4PLJ8bAkJ77rKQxN0sMjBL6/y3xeHP
 Uhozn3Y8CMMRwDN18riAFA72CF1SpaLzdjmZJVGkMJRNDbLo6OYgKY4qtzv8OmP/2rS9
 qjuHDb+H4GBP/8bvmFqH7Vjex0R67FzlTxbFfKhmWXoh9lkYVPHEU0CBt2IMcccxhrlv
 oNgtxJGGgBlZgRGAlEaNIjCU3XRhsy/qFUKyowkzRakEAA7E8Co4zrS+c32b+HNg37AD
 wraj6IDP6TAX+HFh6HbdTA4/32QLRgL+kh4vXXwbTlZ1BEcIcU4zPWNYpd1Holm7VwOp
 /aog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=3uTapVf4mWqY1AA8Mhz8NgpXokYZRvFUx7bT66gfDwE=;
 b=F3p4uGdkAX8mC1GaYfpCD1cANZcj4lj9CJW6Dy+S1TJBpJUhKAVBuAiA+NDNzLm940
 uqZdPb8bwPkfPKkXhWxqzqPZHDTHYsJSr1KQVbHV1QubOIjhFPKNVC8k61AgaMAyPPDf
 YS7D20efnWl8QXIiwh1peUZfoYqkrs4aIz8+Ld2Av6L46Ty4yHDBWeUuh6X/HvKhZny6
 iSH+cI3WrErLyBkkipFAuQC3oON64fMsY6sM1XyR4lVdmsaAcgNNToFY2lNVil7Karxb
 aQ86h0AgM+YG8FSKJH3vrPX5UeuqeBHiVajPL4HV/pxB2QJABf5IFvhc9woPgAlVKUP3
 Qmjg==
X-Gm-Message-State: AOAM530BLH1dkgmGMCs2R0I2mPtg/HJXIh+4eHwFuZLNRnqrqU2FdHFA
 IKXSE57Mppu48dbnxN4emj5NpQ==
X-Google-Smtp-Source: ABdhPJx+zs7+J08OP+hHrGltngZQuB/m5BLdKDejWhG7pdOgkJ0hrNr+8JHZJDIyvZGa3/0zp5P3xw==
X-Received: by 2002:adf:f084:: with SMTP id n4mr4624137wro.26.1600771694582;
 Tue, 22 Sep 2020 03:48:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a13sm3699804wme.26.2020.09.22.03.48.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 03:48:13 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E703E1FF7E;
 Tue, 22 Sep 2020 11:48:12 +0100 (BST)
References: <20200921174118.39352-1-richard.henderson@linaro.org>
 <20200921174118.39352-9-richard.henderson@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 08/11] disas: Configure capstone for aarch64 host
 without libvixl
In-reply-to: <20200921174118.39352-9-richard.henderson@linaro.org>
Date: Tue, 22 Sep 2020 11:48:12 +0100
Message-ID: <87v9g6m6j7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The ifdef tangle failed to set cap_arch if libvixl itself
> was not configured (e.g. due to lack of c++ compiler).
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  disas.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/disas.c b/disas.c
> index d0ccd4b727..01c8bc6c9e 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -428,9 +428,11 @@ static void initialize_debug_host(CPUDebug *s)
>  #else
>  #error unsupported RISC-V ABI
>  #endif
> -#elif defined(__aarch64__) && defined(CONFIG_ARM_A64_DIS)
> -    s->info.print_insn =3D print_insn_arm_a64;
> +#elif defined(__aarch64__)
>      s->info.cap_arch =3D CS_ARCH_ARM64;
> +# ifdef CONFIG_ARM_A64_DIS
> +    s->info.print_insn =3D print_insn_arm_a64;
> +# endif
>  #elif defined(__alpha__)
>      s->info.print_insn =3D print_insn_alpha;
>  #elif defined(__sparc__)


--=20
Alex Benn=C3=A9e

