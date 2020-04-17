Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6981C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 21:47:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF87820780
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 21:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2siIM1W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF87820780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPYpq-0005rr-UB
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 17:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jPYnS-0003pN-IA
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:45:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jPYnR-0004rv-Bu
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:45:14 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:36013)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jPYnR-0004qb-7I
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:45:13 -0400
Received: by mail-io1-xd44.google.com with SMTP id n10so4014193iom.3
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 14:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oeqObuSy/Jdf5M8kyibJVn05yJxK19FjOQ8Z0cVEUe0=;
 b=F2siIM1Wv7Q9iIEvmYf+xYjkvMjtyp+3PK54yz324tpJJZ/2EgE/IQ+pPzXD9nXxd4
 I6a53fRvzpmKP8dTms6aCWdxMkkX3ZFVNNpRe6DEj3CUiCyHeAlj8acz+cbi1b0Zu//u
 s+iCgSOdsSuyOSC05WcD1eWrN2mmYRTisvEO8jFHrcGiSef/8Ai5F4z1kQSPsNb9wzpP
 WWrCUd/XvYT9/8TszYIjk14QcjD5LHoRkajvO+Nk9ripLkfn5TLlzfPbiHGpJ5bBNa3A
 zEqr/3Tswv+Q9zuEqOfQOPj0yRvaXAF2TS9eBknay9E//JCvhw8LsJZUt38XJ5L+3pmW
 XAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oeqObuSy/Jdf5M8kyibJVn05yJxK19FjOQ8Z0cVEUe0=;
 b=MJhW5GsFwcHK14ux9noLiSaesPQ0mUIiPU8NFcgXptNrfsmVz/likcQidEv66fkJ6u
 qvbXHqlVEnIzZ050Ds+nUp4K19fKXfJH/OTgOz79g4+VuN3oG62gfX2NG2kdcwFS1kns
 A1/d86OhX9H9O5A0jZMkMZogwzb+YhD/MWwdQERbnUh1k5whvSBTgvdtpCspQMwjeZlj
 I+o/vlCdOaWfp8utVOBxWuDpGMOPtg3fnwDJcofufV8L4wp/Y9MbEr0cnb+oTkW/oTkt
 6W8O0sHIfRdjxEk8wncd3JJhg8H7BUGMyAkvkdaZThzsocb/bjQFuCsENeCrAn6ZFA9N
 AhnQ==
X-Gm-Message-State: AGi0PuaSPWKHiR6S0PqoaERiZpVWkYPEs8n+BnQiN5iky9W84HII5az1
 P8Ag4JOHgcJXofuoV4tw0084gmgBDJs8T3IPl4k=
X-Google-Smtp-Source: APiQypLtyFM7unV7T3Ru4X+A52fpl0yQo7pnp0n1iFAzOgWDdEGYhW6tbo1cnyg74Im36UUJ/Uv002SOxUQI9V7aFXc=
X-Received: by 2002:a02:1a01:: with SMTP id 1mr5470202jai.26.1587159911147;
 Fri, 17 Apr 2020 14:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200417191022.5247-1-edgar.iglesias@gmail.com>
 <20200417191022.5247-7-edgar.iglesias@gmail.com>
In-Reply-To: <20200417191022.5247-7-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Apr 2020 14:36:48 -0700
Message-ID: <CAKmqyKNYCTLBH+knr1DR-mBR5Lyimsr+EYufDUDX0WTfHOmbDQ@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] target/microblaze: Add the pvr-user2 property
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
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
Cc: figlesia@xilinx.com, Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 17, 2020 at 12:13 PM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Add the pvr-user2 property to control the user-defined
> PVR1 User2 register.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/microblaze/cpu.c | 2 ++
>  target/microblaze/cpu.h | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 0759b23a83..d024ec80eb 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -196,6 +196,7 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
>                          (cpu->cfg.pvr == C_PVR_FULL ? PVR0_PVR_FULL_MASK : 0) |
>                          cpu->cfg.pvr_user1;
>
> +    env->pvr.regs[1] = cpu->cfg.pvr_user2;
>      env->pvr.regs[2] |= (cpu->cfg.use_fpu ? PVR2_USE_FPU_MASK : 0) |
>                          (cpu->cfg.use_fpu > 1 ? PVR2_USE_FPU2_MASK : 0) |
>                          (cpu->cfg.use_hw_mul ? PVR2_USE_HW_MUL_MASK : 0) |
> @@ -292,6 +293,7 @@ static Property mb_properties[] = {
>      DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
>      DEFINE_PROP_UINT8("pvr", MicroBlazeCPU, cfg.pvr, C_PVR_FULL),
>      DEFINE_PROP_UINT8("pvr-user1", MicroBlazeCPU, cfg.pvr_user1, 0),
> +    DEFINE_PROP_UINT32("pvr-user2", MicroBlazeCPU, cfg.pvr_user2, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 7bb5a3d6c6..a31134b65c 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -308,6 +308,7 @@ struct MicroBlazeCPU {
>          bool div_zero_exception;
>          bool unaligned_exceptions;
>          uint8_t pvr_user1;
> +        uint32_t pvr_user2;
>          char *version;
>          uint8_t pvr;
>      } cfg;
> --
> 2.20.1
>
>

