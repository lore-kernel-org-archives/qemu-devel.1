Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9429CC32771
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 00:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6084E2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 00:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nX3wPstb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6084E2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwEaZ-0005OM-ID
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 19:18:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iwEZk-0004wz-Ri
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 19:17:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iwEZj-0003Yw-NV
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 19:17:52 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:46388)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iwEZj-0003Wj-EX
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 19:17:51 -0500
Received: by mail-lj1-x243.google.com with SMTP id x14so10483665ljd.13
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 16:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l9shY1FcVDYWjipBhk84QS7HbgTa6bQ4AdMWhW8BEwI=;
 b=nX3wPstb9/QLW3iZvpKqhAWoUNFkMZJG+/ZhuI1lpS+iu2sAGZKcWKOjFBUpxzy6XV
 a2FFQ6jNEZCI1Qm0csr/7OMZV5DyKSt+8qWujcCOhOkqttQtcQCdKzJ3iXRfP3ggjafZ
 4SF0PxOg9GC1l/9JTzXIJ7GfpCAoNpIX1Tm/3oYjcI714BTSUAr6w1Pyfic2QYCLqYbO
 Qk2NA3m85JFq6F2zZhuc889xaKw2LkB4Bav+Zpm/OYKezuF+mDJ28e/YhUipgtIUucUk
 4+ruY8+/8shu2Ds25IR0SibXMVlKnJTuXSuMqgqq0xhCnwKVSLhFB8NsFm8cssQ1OwMq
 Lb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l9shY1FcVDYWjipBhk84QS7HbgTa6bQ4AdMWhW8BEwI=;
 b=g8jbcGPBMIce7gJuTNest/HJRHxWat5xa9H+js5s4JoAWQUgFgzir/f+BJ/wbVKROu
 AiUBBUoLqGo0DwpwBfkPYy9dNRttVIpMHxE8+OtuMAPWjvqmzn90x+J33tDLNGgnlN5W
 baxhZavQX775nVqkN2IEkZ6hkP2FM+mLlwwXYUzOus5vzB8vJN2dDCsiI/wZ0FfHWb7M
 9zka6lCwL7Knw3lVYmm0rKfLLDP5/ZCjvYFW1tzCZHaZ9HRvgbl07z7EjQaMorpsM+Kn
 50M5qvA+PEwB2WInN9g2oHNFlBRY7sHwmEuiBv86S5RK7stL98edDNEBgZCzAnP6qHkS
 EhJw==
X-Gm-Message-State: APjAAAXXVfVrHr2298uCSBeN1mT1EHxlTp0V32bupr8KgbZZpJMQJAWB
 BrpbauLUEyc1shea3bfpC4USMN5closOUgmWs+w=
X-Google-Smtp-Source: APXvYqzotwvEbPdNBt/ay41Y7GNro98ZAwExZt0/dSYepJGKC7Bg+bxIzYOntKEKiCIGPHLyT2AYjpIbQ6x1u4eCfF4=
X-Received: by 2002:a2e:a36a:: with SMTP id i10mr3618254ljn.107.1580170669433; 
 Mon, 27 Jan 2020 16:17:49 -0800 (PST)
MIME-Version: 1.0
References: <20200127141051.12543-1-ianjiang.ict@gmail.com>
In-Reply-To: <20200127141051.12543-1-ianjiang.ict@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 27 Jan 2020 16:17:22 -0800
Message-ID: <CAKmqyKOcCDqoM0_ORP6CDsMFMc9u7+gehnq62f0p+w1ARoNiow@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add helper to make NaN-boxing for FP register
To: Ian Jiang <ianjiang.ict@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 27, 2020 at 6:11 AM Ian Jiang <ianjiang.ict@gmail.com> wrote:
>
> The function that makes NaN-boxing when a 32-bit value is assigned
> to a 64-bit FP register is split out to a helper gen_nanbox_fpr().
> Then it is applied in translating of the FLW instruction.
>
> This also applies for other instructions when the RVD extension is
> present, such as FMV.W.W, FADD.S, FSUB.S and so on.
>
> Signed-off-by: Ian Jiang <ianjiang.ict@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rvf.inc.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
> index e23cd639a6..3bfd8881e7 100644
> --- a/target/riscv/insn_trans/trans_rvf.inc.c
> +++ b/target/riscv/insn_trans/trans_rvf.inc.c
> @@ -23,6 +23,20 @@
>          return false;                       \
>  } while (0)
>
> +/*
> + * RISC-V requires NaN-boxing of narrower width floating
> + * point values.  This applies when a 32-bit value is
> + * assigned to a 64-bit FP register.  Thus this does not
> + * apply when the RVD extension is not present.
> + */
> +static void gen_nanbox_fpr(DisasContext *ctx, int regno)
> +{
> +    if (has_ext(ctx, RVD)) {
> +        tcg_gen_ori_i64(cpu_fpr[regno], cpu_fpr[regno],
> +                        MAKE_64BIT_MASK(32, 32));
> +    }
> +}
> +
>  static bool trans_flw(DisasContext *ctx, arg_flw *a)
>  {
>      TCGv t0 = tcg_temp_new();
> @@ -32,8 +46,7 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
>      tcg_gen_addi_tl(t0, t0, a->imm);
>
>      tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], t0, ctx->mem_idx, MO_TEUL);
> -    /* RISC-V requires NaN-boxing of narrower width floating point values */
> -    tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd], 0xffffffff00000000ULL);
> +    gen_nanbox_fpr(ctx, a->rd);
>
>      tcg_temp_free(t0);
>      mark_fs_dirty(ctx);
> --
> 2.17.1
>
>

