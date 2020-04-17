Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7DBC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 21:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70DBD2137B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 21:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOipecDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DBD2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPYk6-0001np-Jt
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 17:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jPYib-0000XC-7V
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:40:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jPYia-0003Sr-2v
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:40:13 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:39284)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jPYiZ-0003RG-UF
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:40:12 -0400
Received: by mail-il1-x144.google.com with SMTP id c17so3642866ilk.6
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 14:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Fbmk+f/pqj/4MqCkXTr0meqI9JTIJTQNFEAyyHw5thU=;
 b=IOipecDDL2A1Ox4La4bFdHcgwM2DcqbSnfNfasLBwGfqkHFbRTtybSdsyFg3l2LL1D
 CJKInUV4rkKm9HJJvbTD0Ea6+iloWzt1aWsLep9e4trVxCowNk+Do1AosoZCALT1K0DF
 Li24TDucglNsMuxHuOD8NBjwqWveAo7Vp0XwqaAV3DkJmrgdEgBXJYLH10egvRsbEc8W
 DKcc25/mJVU2/7qT8Q+TZZWmoxVeanfmUZL95oMCvE2WwsmKzKdPYUOzj1YUa/IcWn6B
 C3BDsGKw08kWxmXdBSWNUsunp6RsMOm/nbHqsq1RjhMShDV6Hsqp8ATaUsaWjhTYbpFM
 9Aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Fbmk+f/pqj/4MqCkXTr0meqI9JTIJTQNFEAyyHw5thU=;
 b=ZrIOZI39bcUtoE4SS2CLsL+ODFSn1UOJxqE0Qzl+U9T/YMxy5B5328IW+Urqf33yID
 jUgNqVR+37TVlnKAs0nvh3wcCB3WySS7WGvKTD02hun/jgC0+Imockziw9dkwZAt6LDF
 tArFzITK2HC+KRDZDpo6oIApwF6dOe+aAlgV8tRBJ+VzbVaO9b7ZZO5nhoHY2RBib590
 OTQSnN8yZxDUbV0UOgKzxMs5jfAsUIQaHKgxArNMSoDf74/LaqvNZ5tVhMFVPFs+ynVE
 CzkTBs3yj2eG7gN0qfVyzjG8O2h6WqAapK79CHdz7tKKGTyYFxW7BOQfLvRZd/YcDMd9
 46TQ==
X-Gm-Message-State: AGi0PubH3sCch3bNis/9LIeiQ2brzoc4dAgUdFFpmrYXRJ5h34NEjxot
 XJkuwcAdoksPk0WPTLHQj5yeVy6NArGDsEPEMM8=
X-Google-Smtp-Source: APiQypKzXWdPpwFHA7MJA8jxz0wIrvAVCPMovEAy50ZLl1QbT6LCLrZMnNOdWFw5sFDPn8lh4FMFGTOTXMbbpQoNzO0=
X-Received: by 2002:a92:9a5c:: with SMTP id t89mr5310263ili.267.1587159611082; 
 Fri, 17 Apr 2020 14:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200417191022.5247-1-edgar.iglesias@gmail.com>
 <20200417191022.5247-3-edgar.iglesias@gmail.com>
In-Reply-To: <20200417191022.5247-3-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Apr 2020 14:31:48 -0700
Message-ID: <CAKmqyKPALjiu5FKFri9XSMW5+9xArtwf97KE7wkA8WdB7dsMmg@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] target/microblaze: Add the ill-opcode-exception
 property
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::144
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

On Fri, Apr 17, 2020 at 12:14 PM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Add the ill-opcode-exception property to control if illegal
> instructions will raise exceptions.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/microblaze/cpu.c       | 4 ++++
>  target/microblaze/cpu.h       | 1 +
>  target/microblaze/translate.c | 2 +-
>  3 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 1044120702..36c20d9724 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -207,6 +207,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
>                                                   PVR2_DOPB_BUS_EXC_MASK : 0) |
>                          (cpu->cfg.iopb_bus_exception ?
>                                                   PVR2_IOPB_BUS_EXC_MASK : 0) |
> +                        (cpu->cfg.illegal_opcode_exception ?
> +                                                PVR2_ILL_OPCODE_EXC_MASK : 0) |
>                          (cpu->cfg.opcode_0_illegal ?
>                                                   PVR2_OPCODE_0x0_ILL_MASK : 0);
>
> @@ -276,6 +278,8 @@ static Property mb_properties[] = {
>      /* Enables bus exceptions on failed instruction fetches.  */
>      DEFINE_PROP_BOOL("iopb-bus-exception", MicroBlazeCPU,
>                       cfg.iopb_bus_exception, false),
> +    DEFINE_PROP_BOOL("ill-opcode-exception", MicroBlazeCPU,
> +                     cfg.illegal_opcode_exception, false),
>      DEFINE_PROP_BOOL("opcode-0x0-illegal", MicroBlazeCPU,
>                       cfg.opcode_0_illegal, false),
>      DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index d51587b342..71d7317a58 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -303,6 +303,7 @@ struct MicroBlazeCPU {
>          bool endi;
>          bool dopb_bus_exception;
>          bool iopb_bus_exception;
> +        bool illegal_opcode_exception;
>          bool opcode_0_illegal;
>          char *version;
>          uint8_t pvr;
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 222632b670..b4a78551ef 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -185,7 +185,7 @@ static void write_carryi(DisasContext *dc, bool carry)
>  static bool trap_illegal(DisasContext *dc, bool cond)
>  {
>      if (cond && (dc->tb_flags & MSR_EE_FLAG)
> -        && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)) {
> +        && dc->cpu->cfg.illegal_opcode_exception) {
>          tcg_gen_movi_i64(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
>          t_gen_raise_exception(dc, EXCP_HW_EXCP);
>      }
> --
> 2.20.1
>
>

