Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D2EC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 18:36:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A382133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 18:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="muZXyMQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A382133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFN0V-0001YH-G8
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 14:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iFMyK-0008KE-Op
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 14:34:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iFMyJ-0002iV-M2
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 14:34:04 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46784)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iFMyJ-0002i3-EY
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 14:34:03 -0400
Received: by mail-pf1-x441.google.com with SMTP id q5so8642598pfg.13
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 11:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=2lnDo4LAhYTztHDWQTK8AHuV8AASUlMryESwQyVRmy8=;
 b=muZXyMQbpBzVu/qUDAzfuhXWKY7fm3e5GSAJI2eJ1SLUCBmYegxMq8japyNyevkFcn
 E19wiiyUaVNHD4cX2r+TFiZ//OUT0QixQ6qVHB60sOyQwHyuVth+f6aUFfRW4crsdBAc
 0aKrWz50yTs3E5wKZQBoRGa++3WR1+e3CO4Peur3822ot1LZFqkFjNPOLUOkp/nR6Q1R
 lsRAcxnUPOVARJdwAoY0F/2+UQ4Gqw9Frgz7MRBWh22QSZiDkyKFjYktwQBq8kAoyidv
 5mdqPadtfKD+glmyjvp7Et3SflifGdFQGApAMKqMnTu5uFt9fYvXg/zPY1WriN6RVvox
 zU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=2lnDo4LAhYTztHDWQTK8AHuV8AASUlMryESwQyVRmy8=;
 b=lUe3eQ0PC0e6+o4JUtIq1wYmX1uvJuYKYz/4JGoJJiTeRGUczCRThR8Tz1MlLc3wC6
 y/QFBDNvpZNn40E4/z41GMznajoYvUZOlvExxLvNDyNql+gZQ1HPR9oMJItTfLT1S6bj
 qH1gywkaCJVDhYdNs9gfzLbhZYlVY1E7Qn+DN1K0wSestItx/J85A36esmG0iDA0mF/i
 kRiDTkou7Ub+oyIBCsCxnFIOhXJ1F159B68SeTjNIvwtS5rVuRV4mAU+VGP9SkIMSgXp
 vs6c2ohcsA6pwQVlqttvqLF8m+zsaOxzLVmFztt/T29Gjr8h5Zb91wNpflmDDt0Ym4IU
 m88g==
X-Gm-Message-State: APjAAAUQQM7Pa9f7T5Yh4CalUyyPur4q76fomBVtoabj8QPJsLHW6OJU
 za60fdlQudyX+3+vpui+UYiMGJBsCKiXWQ==
X-Google-Smtp-Source: APXvYqzmqXVtU1JYh1FCI13QmGZFHTRam36X19LH77VsD0Enzd9VBxZOevRMCFmJC+Rl0tf712bhNA==
X-Received: by 2002:a17:90a:1b46:: with SMTP id
 q64mr7166825pjq.97.1569954841962; 
 Tue, 01 Oct 2019 11:34:01 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id b123sm23990829pgc.72.2019.10.01.11.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 11:34:01 -0700 (PDT)
Date: Tue, 01 Oct 2019 11:34:01 -0700 (PDT)
X-Google-Original-Date: Tue, 01 Oct 2019 11:31:56 PDT (-0700)
Subject: Re: [PATCH v1 18/28] target/riscv: Add hfence instructions
In-Reply-To: <d0a6c68c4af8e3f160cce19fea8bbd9f20aea0be.1566603412.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-11759a7c-bd92-4ae8-9d7c-4def81fe4feb@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: qemu-riscv@nongnu.org, Anup Patel <Anup.Patel@wdc.com>,
 qemu-devel@nongnu.org, Atish Patra <Atish.Patra@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Aug 2019 16:38:36 PDT (-0700), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/insn32.decode                    | 23 ++++++-----
>  .../riscv/insn_trans/trans_privileged.inc.c   | 40 +++++++++++++++++++
>  2 files changed, 54 insertions(+), 9 deletions(-)
>
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 77f794ed70..cfd9ca6d2b 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -63,20 +63,25 @@
>  @r2_rm   .......   ..... ..... ... ..... ....... %rs1 %rm %rd
>  @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
>
> +@hfence_gvma ....... ..... .....   ... ..... ....... %rs2 %rs1
> +@hfence_bvma ....... ..... .....   ... ..... ....... %rs2 %rs1
> +
>  @sfence_vma ....... ..... .....   ... ..... ....... %rs2 %rs1
>  @sfence_vm  ....... ..... .....   ... ..... ....... %rs1
>
>
>  # *** Privileged Instructions ***
> -ecall      000000000000     00000 000 00000 1110011
> -ebreak     000000000001     00000 000 00000 1110011
> -uret       0000000    00010 00000 000 00000 1110011
> -sret       0001000    00010 00000 000 00000 1110011
> -hret       0010000    00010 00000 000 00000 1110011
> -mret       0011000    00010 00000 000 00000 1110011
> -wfi        0001000    00101 00000 000 00000 1110011
> -sfence_vma 0001001    ..... ..... 000 00000 1110011 @sfence_vma
> -sfence_vm  0001000    00100 ..... 000 00000 1110011 @sfence_vm
> +ecall       000000000000     00000 000 00000 1110011
> +ebreak      000000000001     00000 000 00000 1110011
> +uret        0000000    00010 00000 000 00000 1110011
> +sret        0001000    00010 00000 000 00000 1110011
> +hret        0010000    00010 00000 000 00000 1110011
> +mret        0011000    00010 00000 000 00000 1110011
> +wfi         0001000    00101 00000 000 00000 1110011
> +hfence_gvma 0110001    ..... ..... 000 00000 1110011 @hfence_gvma
> +hfence_bvma 0010001    ..... ..... 000 00000 1110011 @hfence_bvma
> +sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
> +sfence_vm   0001000    00100 ..... 000 00000 1110011 @sfence_vm
>
>  # *** RV32I Base Instruction Set ***
>  lui      ....................       ..... 0110111 @u
> diff --git a/target/riscv/insn_trans/trans_privileged.inc.c b/target/riscv/insn_trans/trans_privileged.inc.c
> index c5e4b3e49a..b9b5a89b52 100644
> --- a/target/riscv/insn_trans/trans_privileged.inc.c
> +++ b/target/riscv/insn_trans/trans_privileged.inc.c
> @@ -108,3 +108,43 @@ static bool trans_sfence_vm(DisasContext *ctx, arg_sfence_vm *a)
>  #endif
>      return false;
>  }
> +
> +static bool trans_hfence_gvma(DisasContext *ctx, arg_sfence_vma *a)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    if (ctx->priv_ver >= PRIV_VERSION_1_10_0 &&
> +        has_ext(ctx, RVH)) {
> +        /* Hpervisor extensions exist */
> +        /*
> +         * if (env->priv == PRV_M ||
> +         *   (env->priv == PRV_S &&
> +         *    !riscv_cpu_virt_enabled(env) &&
> +         *    get_field(ctx->mstatus_fs, MSTATUS_TVM))) {
> +         */
> +            gen_helper_tlb_flush(cpu_env);
> +            return true;
> +        /* } */
> +    }
> +#endif
> +    return false;
> +}
> +
> +static bool trans_hfence_bvma(DisasContext *ctx, arg_sfence_vma *a)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    if (ctx->priv_ver >= PRIV_VERSION_1_10_0 &&
> +        has_ext(ctx, RVH)) {
> +        /* Hpervisor extensions exist */
> +        /*
> +         * if (env->priv == PRV_M ||
> +         *   (env->priv == PRV_S &&
> +         *    !riscv_cpu_virt_enabled(env) &&
> +         *    get_field(ctx->mstatus_fs, MSTATUS_TVM))) {
> +         */
> +            gen_helper_tlb_flush(cpu_env);
> +            return true;
> +        /* } */
> +    }
> +#endif
> +    return false;
> +}

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

