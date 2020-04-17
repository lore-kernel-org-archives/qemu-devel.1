Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9EBC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 21:45:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF55920780
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 21:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mo1kFHWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF55920780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPYnK-00031r-NE
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 17:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jPYli-0002MX-RJ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jPYlh-0001Sh-If
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:43:26 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:45796)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jPYlh-0001Rb-E1
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:43:25 -0400
Received: by mail-io1-xd41.google.com with SMTP id i19so3961235ioh.12
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 14:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aKBh7aAXfitj+UQkJGpS9Hq34XDnIvRSRCoqUs6jH8Y=;
 b=mo1kFHWLzjje7VASDZofo1/YOP1B4vy/7BaumoAtuCmO8qvqcSe0S2Y4uzeXJDP97n
 dIckMc5qjas+WLunm1tNNtqH5lw2qfS5XgjGjuAFlrFq4xuk0rHjaJNtT+LVEpw71NQ9
 nN0J/S2QELWhjKA/FiacmTTyEdZ5PFN3f/YIs6aiIXdpY7t6u4pPxe+0VsTaW4Ft1iLA
 GDv7pEou428imqRBKYbAkQnCeDnn/Zqp+OY3+6v0MSwXMdMvlBqZPREP9dbEBk4AgKyF
 Rm5fGW68NLdySL+lT1xVFNQFchSyOmXLX17CWl8ujK2+cXqZPocqF+64T5x1m3LiR0bN
 jK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aKBh7aAXfitj+UQkJGpS9Hq34XDnIvRSRCoqUs6jH8Y=;
 b=IOefplWT36Q5uh2FQey6HDBqgBQnDrPS0Jzgk9CtqBlyfSn0AlEKXZ+4iKR/AXJcu6
 LRBR3WEnjSb9WMN425/3XO8SfUj75s8zGUUhZV/Pa3Pd7tQ3K+BoaTTcpwga7n7VigwZ
 JIUTfg+uENacxqr2WCFeiEWeO4nGP7OnXFR3Cv8d0ahpcvdKfNyPRdagv6YU5chK0igt
 rjA8qcO1P/qNQyZZqERe1EMlBJDzb1IvAbBsmqM0VJd6o7uDHEA0h+pJTvUQdHHoIi6Q
 uU0l/JjknFvxRHVSlq9pcy2SPTag9ZnE7HhMaT+L5k1rvB7KpDfSkz8rW+ng0LBhRa0Z
 MTFg==
X-Gm-Message-State: AGi0PubEt+KzJz2gu38yN0eITEM/OGxiiqWBtgDlpIgjRKBlfllBDcaB
 TGUNCp0YMxr7Lm0b4DZkX7qmyGau7vMzWCi74/k=
X-Google-Smtp-Source: APiQypLBBeSGgJeiGOmjGYSNA/7WuIH9OH8vLwTBsWZotfI6NpnXUQFXkjAZzMcJ0oQ+qrBiRUDyuLGxj7KXWbLLE6Y=
X-Received: by 2002:a05:6602:d:: with SMTP id
 b13mr5233582ioa.176.1587159804685; 
 Fri, 17 Apr 2020 14:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200417191022.5247-1-edgar.iglesias@gmail.com>
 <20200417191022.5247-4-edgar.iglesias@gmail.com>
In-Reply-To: <20200417191022.5247-4-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Apr 2020 14:35:02 -0700
Message-ID: <CAKmqyKOScF=dWVepbs+4thLLFpqpR=7JC3XM89nABjA6-DVHYQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] target/microblaze: Add the div-zero-exception
 property
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
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

On Fri, Apr 17, 2020 at 12:15 PM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Add the div-zero-exception property to control if the core
> traps divizions by zero.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/microblaze/cpu.c       | 2 ++
>  target/microblaze/cpu.h       | 1 +
>  target/microblaze/op_helper.c | 5 +++--
>  3 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 36c20d9724..7a40e2fbad 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -280,6 +280,8 @@ static Property mb_properties[] = {
>                       cfg.iopb_bus_exception, false),
>      DEFINE_PROP_BOOL("ill-opcode-exception", MicroBlazeCPU,
>                       cfg.illegal_opcode_exception, false),
> +    DEFINE_PROP_BOOL("div-zero-exception", MicroBlazeCPU,
> +                     cfg.div_zero_exception, false),
>      DEFINE_PROP_BOOL("opcode-0x0-illegal", MicroBlazeCPU,
>                       cfg.opcode_0_illegal, false),
>      DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 71d7317a58..3c07f9b3f7 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -305,6 +305,7 @@ struct MicroBlazeCPU {
>          bool iopb_bus_exception;
>          bool illegal_opcode_exception;
>          bool opcode_0_illegal;
> +        bool div_zero_exception;
>          char *version;
>          uint8_t pvr;
>      } cfg;
> diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
> index 18677ddfca..f3b17a95b3 100644
> --- a/target/microblaze/op_helper.c
> +++ b/target/microblaze/op_helper.c
> @@ -132,11 +132,12 @@ uint32_t helper_carry(uint32_t a, uint32_t b, uint32_t cf)
>
>  static inline int div_prepare(CPUMBState *env, uint32_t a, uint32_t b)
>  {
> +    MicroBlazeCPU *cpu = env_archcpu(env);
> +
>      if (b == 0) {
>          env->sregs[SR_MSR] |= MSR_DZ;
>
> -        if ((env->sregs[SR_MSR] & MSR_EE)
> -            && !(env->pvr.regs[2] & PVR2_DIV_ZERO_EXC_MASK)) {
> +        if ((env->sregs[SR_MSR] & MSR_EE) && cpu->cfg.div_zero_exception) {
>              env->sregs[SR_ESR] = ESR_EC_DIVZERO;
>              helper_raise_exception(env, EXCP_HW_EXCP);
>          }
> --
> 2.20.1
>
>

