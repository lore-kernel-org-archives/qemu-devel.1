Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40029C38A30
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 18:06:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10409206D6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 18:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+qyckNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10409206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQaoG-0004Wa-7y
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 14:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39056 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jQane-00043s-5u
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:05:42 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jQana-0000bs-1o
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:05:41 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:46582)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jQanZ-0000au-KR
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:05:37 -0400
Received: by mail-io1-xd43.google.com with SMTP id i3so12019460ioo.13
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 11:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oocbVISTNdw51WmZebw7l80BwX58MKMF5pst+yHUbqg=;
 b=g+qyckNHxhtuvFofTA2hhJpbuB+XvNTA18z9p5U/asG/UGBbFiR9CboSkuaaeVyZI3
 3+/0QRwLIwT2ZnMQ5lgQ/rp/4JjssNHloHBlncGEZh18QF9t25+qo7I5/PgFbwMi7D9O
 Ymj8KBzKs/Nzhd1ujRXBAIFF9BYCBZIai08b7fvCx48mOXS/yEtvhREisxUIOjevUVQC
 wt4Rj6FLX7F9LPLorGZzMDShNeD0P8Ihb3OA4TRpDC7BKkhFLnHh5YXMX0/HnDdfWfsf
 GFThXa4T6ACXslb7+1rZzyM5W25cmBe+CQhqWeTYpMjxHIyhNri1nUkjNiPTfnOtWp/s
 acBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oocbVISTNdw51WmZebw7l80BwX58MKMF5pst+yHUbqg=;
 b=qokMMt4y8N9mTfwz4CN02YoxDLV4sMNnEqejupBoDhpovfazpnwrcFxr4eyeoDc5y4
 K13yCoYmfOoC8Sf3EJxNNvw/TJYe3FaX+ntYDT0CUDbSfShjpAE8skEsn0GfzW+k4YxG
 zqMnZcS8A7sQ/WLUa3eyOWmQiIGwKC0D+5RbIh0cj9QlD3UdIUkRMeA8u0mWfvJmcP/4
 76hZ7sadNzbl1QeOMNqSunMIAH4Zq2l9MlK7K/k2J/sI60RnENTVWHj7+n1PwavZljyK
 H35N4nmrqlnXdgtqO8yj0xNln6K7f5vxL4XlGFiXbgCBMNEbtZz1kVyjYcxeQYuuZyia
 Ix/g==
X-Gm-Message-State: AGi0PubPl8TkGK1MBiCugs2vPryZGOZr3kaNJFCOttBWzbbhNfS8F5Bs
 /QXYI9YO6X4v0ZfE34JJVH9JWWifvlM/bUGZhtg=
X-Google-Smtp-Source: APiQypIUi4NU8dNBLENI2KA8VoScUIlYCQ+S11gohgu+jCQQjcImKouvvKrQ74tnCFoovLztXpSI9CfviDAJODjQJuU=
X-Received: by 2002:a5d:984b:: with SMTP id p11mr16886128ios.175.1587405936271; 
 Mon, 20 Apr 2020 11:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200420175250.25777-1-edgar.iglesias@gmail.com>
 <20200420175250.25777-4-edgar.iglesias@gmail.com>
In-Reply-To: <20200420175250.25777-4-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 Apr 2020 10:57:09 -0700
Message-ID: <CAKmqyKOqy+=HZtrhw1EHqNGsiXXi39d6C6c3Hm-Q0456kDgJQA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] target/microblaze: Add the div-zero-exception
 property
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d43
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

On Mon, Apr 20, 2020 at 10:54 AM Edgar E. Iglesias
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
>  target/microblaze/cpu.c       | 4 ++++
>  target/microblaze/cpu.h       | 1 +
>  target/microblaze/op_helper.c | 5 +++--
>  3 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 36c20d9724..53e80f4e5d 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -207,6 +207,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
>                                                   PVR2_DOPB_BUS_EXC_MASK : 0) |
>                          (cpu->cfg.iopb_bus_exception ?
>                                                   PVR2_IOPB_BUS_EXC_MASK : 0) |
> +                        (cpu->cfg.div_zero_exception ?
> +                                                 PVR2_DIV_ZERO_EXC_MASK : 0) |
>                          (cpu->cfg.illegal_opcode_exception ?
>                                                  PVR2_ILL_OPCODE_EXC_MASK : 0) |
>                          (cpu->cfg.opcode_0_illegal ?
> @@ -280,6 +282,8 @@ static Property mb_properties[] = {
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

