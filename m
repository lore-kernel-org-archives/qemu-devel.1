Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4CAC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 21:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 373E12137B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 21:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1LLGdMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373E12137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPYiZ-0000L7-CU
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 17:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jPYhn-0008FR-4j
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:39:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jPYhl-0001gI-Vp
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:39:23 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:40429)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jPYhl-0001e7-P1
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:39:21 -0400
Received: by mail-il1-x141.google.com with SMTP id f2so3623359ilq.7
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 14:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ciLcWXal68MTEKmCfzhFtQVPdRcC04oPpmsAtsP3yYY=;
 b=m1LLGdMSE3fEvOK0n6nDFRMFXim1/d+Cz+i//7ommzSQYyO1fMHWyQGeq3agF9T+HY
 xd5X+GMp/eIa1GmAjrKtos0Ks1UygGMs2lhEHg1NyHfg2SW5zz0UabDW4TV7CWIKf7wl
 Kg56sbfe97WaCaWt3/4RKebZprAYDC2U1FaFje5oA4KKskFB3bH8YLM8bNiKF2Z4eKld
 Oe9NCWOY1he6MuB/uD+55ATzAo9n7CMO8re+tLf3+q2VYdvWi0xC73VVEf8+S+ELjPEW
 VNcxyFXvsHCxinhGOnhzW7wIKrncDCD6fKcNhRGRBNRVrBMsMOvpKFxy9lR/nOSmLFU/
 rrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ciLcWXal68MTEKmCfzhFtQVPdRcC04oPpmsAtsP3yYY=;
 b=OEo39XUbCVyQkKD+QRsHdzLclY4epStzrogveRR6I6/mZrMZaQOg9xcHIv/+zNEBW6
 gM8KWFrbkPsYm7T48f/8S3gHSyXQUm6mcqkB7LSgcGyj6weYfTA9ypjBFh2qLawTS2AO
 8RXgpIsLeJ+w/OhfXV2ESeDE9Cx377XOu+sf6dnTfXE0x/6R3+QOjAGU+XAfbydfmzPa
 9VXZfL4fLPv/Q0ZjkeC6vGfodGhMeZSahfacbmyRfuipAeROOOmUzAklpWcDUA3mkhVN
 v9qiUBZeL2Y3EjPX5k5Toe9yA8MIsiSYhF25A09dyXNVWLw/SBvsoYWvKuO0GyG4/7YZ
 mR/A==
X-Gm-Message-State: AGi0PuZh3hPhR4b67NIpxNtUrphra9Kzu9qDBUgS3vCxT8H3mUR9LWMO
 rUIA3bM+uS0ygFFBvdX/scObxLaOdlyvhgLZr0c=
X-Google-Smtp-Source: APiQypJaUn8TqubPWSobT0rM5TftdAGh/9JPe8AaxEFwXxNfwda36Viojc6Al75/RPHbmYrQE8kxXT/woP68PuPbqGA=
X-Received: by 2002:a92:d182:: with SMTP id z2mr5422106ilz.177.1587159560653; 
 Fri, 17 Apr 2020 14:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200417191022.5247-1-edgar.iglesias@gmail.com>
 <20200417191022.5247-2-edgar.iglesias@gmail.com>
In-Reply-To: <20200417191022.5247-2-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Apr 2020 14:30:57 -0700
Message-ID: <CAKmqyKM2hsMJ94yHPCjUBcMYn1eR924T8_jZq2HzpK0SrmHATg@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] target/microblaze: Add the opcode-0x0-illegal CPU
 property
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::141
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

On Fri, Apr 17, 2020 at 12:12 PM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Add the opcode-0x0-illegal CPU property to control if the core
> should trap opcode zero as illegal.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/microblaze/cpu.c       | 6 +++++-
>  target/microblaze/cpu.h       | 1 +
>  target/microblaze/translate.c | 2 +-
>  3 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index a2c2f271df..1044120702 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -206,7 +206,9 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
>                          (cpu->cfg.dopb_bus_exception ?
>                                                   PVR2_DOPB_BUS_EXC_MASK : 0) |
>                          (cpu->cfg.iopb_bus_exception ?
> -                                                 PVR2_IOPB_BUS_EXC_MASK : 0);
> +                                                 PVR2_IOPB_BUS_EXC_MASK : 0) |
> +                        (cpu->cfg.opcode_0_illegal ?
> +                                                 PVR2_OPCODE_0x0_ILL_MASK : 0);
>
>      env->pvr.regs[5] |= cpu->cfg.dcache_writeback ?
>                                          PVR5_DCACHE_WRITEBACK_MASK : 0;
> @@ -274,6 +276,8 @@ static Property mb_properties[] = {
>      /* Enables bus exceptions on failed instruction fetches.  */
>      DEFINE_PROP_BOOL("iopb-bus-exception", MicroBlazeCPU,
>                       cfg.iopb_bus_exception, false),
> +    DEFINE_PROP_BOOL("opcode-0x0-illegal", MicroBlazeCPU,
> +                     cfg.opcode_0_illegal, false),
>      DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
>      DEFINE_PROP_UINT8("pvr", MicroBlazeCPU, cfg.pvr, C_PVR_FULL),
>      DEFINE_PROP_END_OF_LIST(),
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 1a700a880c..d51587b342 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -303,6 +303,7 @@ struct MicroBlazeCPU {
>          bool endi;
>          bool dopb_bus_exception;
>          bool iopb_bus_exception;
> +        bool opcode_0_illegal;
>          char *version;
>          uint8_t pvr;
>      } cfg;
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 37a844db99..222632b670 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1573,7 +1573,7 @@ static inline void decode(DisasContext *dc, uint32_t ir)
>      LOG_DIS("%8.8x\t", dc->ir);
>
>      if (ir == 0) {
> -        trap_illegal(dc, dc->cpu->env.pvr.regs[2] & PVR2_OPCODE_0x0_ILL_MASK);
> +        trap_illegal(dc, dc->cpu->cfg.opcode_0_illegal);
>          /* Don't decode nop/zero instructions any further.  */
>          return;
>      }
> --
> 2.20.1
>
>

