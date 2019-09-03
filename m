Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565C2C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:36:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CBA22339D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rxpv7pGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CBA22339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5BnC-0004mk-Ql
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5BKz-0007gt-S5
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5BKy-0002xK-HQ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:07:21 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45930)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5BKy-0002ww-Bq
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:07:20 -0400
Received: by mail-ot1-x341.google.com with SMTP id g16so5437449otp.12
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BQiQNF8dhJP8ox+hPSxrVvY+j3aOupN7cxNiycpUbKY=;
 b=Rxpv7pGcWDNK+CdEuWb268IZZHigB1Eyk/td3dKpdFgZbUxuJUyowoMvfxQYOnCoRY
 pH7u0x1oeK5zW3YJhWsHMF5PZKAjY7KBIc98UD6iM+/pWR7DAFze7kvIb9jZ4gpfgXtj
 nRXYNzGl/96XbMtXiggWG8aAIPzD1O7ZPreuObTNPF3CLaiUjrXMe90FmolysjI47duP
 HO5Qz5p3niL0vtcoVsYBz3gp1r1Dj7Q/ijwyXw8vZovFJEofo5IuysyJRzo3Ym+bakbM
 54DGR2H0TdPmlIPYhaLQg+lrMxaEuCw6cubH0mM13Jj6IiUfEcEI0cqCgoN7NohZ7P+u
 ITfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BQiQNF8dhJP8ox+hPSxrVvY+j3aOupN7cxNiycpUbKY=;
 b=PqrGTe9lk+/wQCRL0NaK4rrxmRkSiEUkOIBPY/BHMT9oWviKxNYow8meerki4lAZJb
 VWjPPr7Xwk6uoW0TyBK+Zb8bmPy+BYx77J+KqxK2sWPo5tVSn3RDMBCkd75OowSzz0D5
 kgClFXKSvewgXbVBMID4pgqz5HwNCoSgNPqRN7A6r8BcrZJBOku8g8OMYvOOSONIezMP
 eT91/yiJELPBdrelB8t+bS3fpEFb58c0Z4KDXql3ODI6hEc24t2V7iAJ24HxI8G5T+Xp
 xwlXn6XlQIec+DIn6gYOqgzNhIUgMEpgwYIn6mKQB4BuXirF6FyED3ZgQYU0YF31GnjN
 V+3w==
X-Gm-Message-State: APjAAAXswkBriKNXtxP0JSt4ndzscoxFaQs7lSMk3MOgGeJhCuMQKCIy
 NYl15pvlKAXnj1fFwP9iwqXSbs49mO/oXMG/cHBHRw==
X-Google-Smtp-Source: APXvYqy89wKkOvIlDNXg009GC/VT4E0DTTTsctm+Bd1kfoaZlGj8VSuDNTen12DjbX1PjN6LAujp9u5KDCWsU2g41Zk=
X-Received: by 2002:a9d:5e10:: with SMTP id d16mr29562669oti.91.1567526839521; 
 Tue, 03 Sep 2019 09:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190903154810.27365-1-thuth@redhat.com>
 <20190903154810.27365-2-thuth@redhat.com>
In-Reply-To: <20190903154810.27365-2-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Sep 2019 17:07:08 +0100
Message-ID: <CAFEAcA-HyrDKoW0ja8NNQURu46eY-vN1RNMpC1R8U2Th=qPB-Q@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] target/arm: Make cpu_register()
 and set_feature() available for other files
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Sep 2019 at 16:54, Thomas Huth <thuth@redhat.com> wrote:
>
> Move the common set_feature() and unset_feature() functions from cpu.c and
> cpu64.c to cpu.h, and make cpu_register() (renamed to arm_cpu_register())
> available from there, too, so we can register CPUs also from other files
> in the future.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/arm/cpu.c   | 20 ++------------------
>  target/arm/cpu.h   | 18 ++++++++++++++++++
>  target/arm/cpu64.c | 16 ----------------
>  3 files changed, 20 insertions(+), 34 deletions(-)
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 0981303170..c5007edf1f 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3600,4 +3600,22 @@ static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
>  #define cpu_isar_feature(name, cpu) \
>      ({ ARMCPU *cpu_ = (cpu); isar_feature_##name(&cpu_->isar); })
>
> +static inline void set_feature(CPUARMState *env, int feature)
> +{
> +    env->features |= 1ULL << feature;
> +}
> +
> +static inline void unset_feature(CPUARMState *env, int feature)
> +{
> +    env->features &= ~(1ULL << feature);
> +}

I think these function names are too generic to have in a header
like cpu.h which is used all across the codebase. (For instance
target/arm/kvm64.c now has both a local set_feature() function
and this one from the header.)

Can they go in target/arm/internals.h instead?
The set of code that should be caring about setting
feature bits should be pretty small.

Maybe also they should be renamed.

thanks
-- PMM

