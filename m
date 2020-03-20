Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723B0C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 19:00:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FB4820767
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 19:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZf7AeLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB4820767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFMsP-0002me-ES
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 15:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jFMrX-0001pp-S3
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jFMrW-0004Te-63
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:59:19 -0400
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:33302)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jFMrW-0004TI-1S; Fri, 20 Mar 2020 14:59:18 -0400
Received: by mail-vs1-xe43.google.com with SMTP id y138so4721636vsy.0;
 Fri, 20 Mar 2020 11:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0M0E2zttYOPxL53Ls9Q2SzLCwAGDpgmUY9ECGRowG88=;
 b=RZf7AeLObTsomwrCq65MG7aB12hrTDrcZposFym4gArf1qUrePLNRjD4rFWQd+Br5o
 3jn1dF8oVdPA/unXw5h0VojQKDqiLE+/XQeiEm9OfvntohC9Y+bZ0U07oqFT1vU4nFoO
 OSzNrsnv3BHT9Zplg1eflGUAsmmldEd38HkjO4BQdg6Z55QlmmdmI1ukMKaANwMfxdmg
 eCNafErPYpywXO0Zl70dgRi1mnjx51ql43uf0Mn0QcbiT6YLIn7ONGubv1/mMfMGOWHB
 q6QZ1jcxhr4Q2AAh2DIHIkd/Wjy2aBKSQPisdNpm2nqtVUT1LMMxPnWXkXfmWtp81pOx
 +xPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0M0E2zttYOPxL53Ls9Q2SzLCwAGDpgmUY9ECGRowG88=;
 b=jd9GHvsyLwCib9h+d/EpI+Z4Hjfrl6w32ONalCLFn5mdPcjBEGgMhpwl8mjriolGPS
 8OejxnAStLM8j/fbYlV1KKmvZpshHnAmnzksNpF5iscDlrg+XUShHIg4Iyj5a1HF2P1V
 SKvCp85M0QOKzV/a0GsfhTtx23OTmmDx2kuyrVEf7w0paIxj7DlWcaNkqXCEHE9TxbB4
 PFjoLnI0B1zHbZVOvGhOdavHB8Dv/694RT6+k/wsvAhqkZJKjAtnqhf3ZKkGamjQ3MwG
 bs2JwFWlA5f+m59ZYJ27JQF/5qavARkaFD96k/+sWEE/MLP6xYHRFvoWLA5fbp+yTgRK
 F1gg==
X-Gm-Message-State: ANhLgQ1Sab1WYf0P6JCNg/tromb57l3dvmuwOzIzEpRSoaKqe4f4dfWQ
 6Sw0On9C9Fz9muh0A73GFa+KbiJ1z45DuRpgYIk=
X-Google-Smtp-Source: ADFU+vskFGFCuIZ4OgdOK2wQBZfQ6ugIw/SngXSPlx6WSwshNJXUTAJvM4vGXa3mdUwNEKfvjvgHlmo963ju7+ZRmXw=
X-Received: by 2002:a67:8a88:: with SMTP id m130mr2449574vsd.70.1584730757217; 
 Fri, 20 Mar 2020 11:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-20-zhiwei_liu@c-sky.com>
In-Reply-To: <20200317150653.9008-20-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 20 Mar 2020 11:51:19 -0700
Message-ID: <CAKmqyKOs8Xmt5FEsGSTYHs6+Y9Za+ymcTmNZ+73X2R4ivvH1hg@mail.gmail.com>
Subject: Re: [PATCH v6 19/61] target/riscv: vector integer divide instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e43
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
Cc: guoren@linux.alibaba.com, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, Chih-Min Chao <chihmin.chao@sifive.com>,
 wenmeng_zhang@c-sky.com, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 17, 2020 at 8:45 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   | 33 +++++++++++
>  target/riscv/insn32.decode              |  8 +++
>  target/riscv/insn_trans/trans_rvv.inc.c | 10 ++++
>  target/riscv/vector_helper.c            | 74 +++++++++++++++++++++++++
>  4 files changed, 125 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index f42a12eef3..357f149198 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -558,3 +558,36 @@ DEF_HELPER_6(vmulhsu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vmulhsu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vmulhsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vmulhsu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +
> +DEF_HELPER_6(vdivu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vdivu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vdivu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vdivu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vdiv_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vdiv_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vdiv_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vdiv_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vremu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vremu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vremu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vremu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vrem_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vrem_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vrem_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vrem_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vdivu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vdivu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vdivu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vdivu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vdiv_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vdiv_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vdiv_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vdiv_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vremu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vremu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vremu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vremu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vrem_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vrem_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vrem_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vrem_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index abfed469bc..7fb8f8fad8 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -371,6 +371,14 @@ vmulhu_vv       100100 . ..... ..... 010 ..... 1010111 @r_vm
>  vmulhu_vx       100100 . ..... ..... 110 ..... 1010111 @r_vm
>  vmulhsu_vv      100110 . ..... ..... 010 ..... 1010111 @r_vm
>  vmulhsu_vx      100110 . ..... ..... 110 ..... 1010111 @r_vm
> +vdivu_vv        100000 . ..... ..... 010 ..... 1010111 @r_vm
> +vdivu_vx        100000 . ..... ..... 110 ..... 1010111 @r_vm
> +vdiv_vv         100001 . ..... ..... 010 ..... 1010111 @r_vm
> +vdiv_vx         100001 . ..... ..... 110 ..... 1010111 @r_vm
> +vremu_vv        100010 . ..... ..... 010 ..... 1010111 @r_vm
> +vremu_vx        100010 . ..... ..... 110 ..... 1010111 @r_vm
> +vrem_vv         100011 . ..... ..... 010 ..... 1010111 @r_vm
> +vrem_vx         100011 . ..... ..... 110 ..... 1010111 @r_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index c276beabd6..ed53eaaef5 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -1462,3 +1462,13 @@ GEN_OPIVX_GVEC_TRANS(vmul_vx,  muls)
>  GEN_OPIVX_TRANS(vmulh_vx, opivx_check)
>  GEN_OPIVX_TRANS(vmulhu_vx, opivx_check)
>  GEN_OPIVX_TRANS(vmulhsu_vx, opivx_check)
> +
> +/* Vector Integer Divide Instructions */
> +GEN_OPIVV_TRANS(vdivu_vv, opivv_check)
> +GEN_OPIVV_TRANS(vdiv_vv, opivv_check)
> +GEN_OPIVV_TRANS(vremu_vv, opivv_check)
> +GEN_OPIVV_TRANS(vrem_vv, opivv_check)
> +GEN_OPIVX_TRANS(vdivu_vx, opivx_check)
> +GEN_OPIVX_TRANS(vdiv_vx, opivx_check)
> +GEN_OPIVX_TRANS(vremu_vx, opivx_check)
> +GEN_OPIVX_TRANS(vrem_vx, opivx_check)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 56ba9a7422..4fc7a08954 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -1741,3 +1741,77 @@ GEN_VEXT_VX(vmulhsu_vx_b, 1, 1, clearb)
>  GEN_VEXT_VX(vmulhsu_vx_h, 2, 2, clearh)
>  GEN_VEXT_VX(vmulhsu_vx_w, 4, 4, clearl)
>  GEN_VEXT_VX(vmulhsu_vx_d, 8, 8, clearq)
> +
> +/* Vector Integer Divide Instructions */
> +#define DO_DIVU(N, M) (unlikely(M == 0) ? (__typeof(N))(-1) : N / M)
> +#define DO_REMU(N, M) (unlikely(M == 0) ? N : N % M)
> +#define DO_DIV(N, M)  (unlikely(M == 0) ? (__typeof(N))(-1) :\
> +        unlikely((N == -N) && (M == (__typeof(N))(-1))) ? N : N / M)
> +#define DO_REM(N, M)  (unlikely(M == 0) ? N :\
> +        unlikely((N == -N) && (M == (__typeof(N))(-1))) ? 0 : N % M)
> +
> +RVVCALL(OPIVV2, vdivu_vv_b, OP_UUU_B, H1, H1, H1, DO_DIVU)
> +RVVCALL(OPIVV2, vdivu_vv_h, OP_UUU_H, H2, H2, H2, DO_DIVU)
> +RVVCALL(OPIVV2, vdivu_vv_w, OP_UUU_W, H4, H4, H4, DO_DIVU)
> +RVVCALL(OPIVV2, vdivu_vv_d, OP_UUU_D, H8, H8, H8, DO_DIVU)
> +RVVCALL(OPIVV2, vdiv_vv_b, OP_SSS_B, H1, H1, H1, DO_DIV)
> +RVVCALL(OPIVV2, vdiv_vv_h, OP_SSS_H, H2, H2, H2, DO_DIV)
> +RVVCALL(OPIVV2, vdiv_vv_w, OP_SSS_W, H4, H4, H4, DO_DIV)
> +RVVCALL(OPIVV2, vdiv_vv_d, OP_SSS_D, H8, H8, H8, DO_DIV)
> +RVVCALL(OPIVV2, vremu_vv_b, OP_UUU_B, H1, H1, H1, DO_REMU)
> +RVVCALL(OPIVV2, vremu_vv_h, OP_UUU_H, H2, H2, H2, DO_REMU)
> +RVVCALL(OPIVV2, vremu_vv_w, OP_UUU_W, H4, H4, H4, DO_REMU)
> +RVVCALL(OPIVV2, vremu_vv_d, OP_UUU_D, H8, H8, H8, DO_REMU)
> +RVVCALL(OPIVV2, vrem_vv_b, OP_SSS_B, H1, H1, H1, DO_REM)
> +RVVCALL(OPIVV2, vrem_vv_h, OP_SSS_H, H2, H2, H2, DO_REM)
> +RVVCALL(OPIVV2, vrem_vv_w, OP_SSS_W, H4, H4, H4, DO_REM)
> +RVVCALL(OPIVV2, vrem_vv_d, OP_SSS_D, H8, H8, H8, DO_REM)
> +GEN_VEXT_VV(vdivu_vv_b, 1, 1, clearb)
> +GEN_VEXT_VV(vdivu_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV(vdivu_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV(vdivu_vv_d, 8, 8, clearq)
> +GEN_VEXT_VV(vdiv_vv_b, 1, 1, clearb)
> +GEN_VEXT_VV(vdiv_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV(vdiv_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV(vdiv_vv_d, 8, 8, clearq)
> +GEN_VEXT_VV(vremu_vv_b, 1, 1, clearb)
> +GEN_VEXT_VV(vremu_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV(vremu_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV(vremu_vv_d, 8, 8, clearq)
> +GEN_VEXT_VV(vrem_vv_b, 1, 1, clearb)
> +GEN_VEXT_VV(vrem_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV(vrem_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV(vrem_vv_d, 8, 8, clearq)
> +
> +RVVCALL(OPIVX2, vdivu_vx_b, OP_UUU_B, H1, H1, DO_DIVU)
> +RVVCALL(OPIVX2, vdivu_vx_h, OP_UUU_H, H2, H2, DO_DIVU)
> +RVVCALL(OPIVX2, vdivu_vx_w, OP_UUU_W, H4, H4, DO_DIVU)
> +RVVCALL(OPIVX2, vdivu_vx_d, OP_UUU_D, H8, H8, DO_DIVU)
> +RVVCALL(OPIVX2, vdiv_vx_b, OP_SSS_B, H1, H1, DO_DIV)
> +RVVCALL(OPIVX2, vdiv_vx_h, OP_SSS_H, H2, H2, DO_DIV)
> +RVVCALL(OPIVX2, vdiv_vx_w, OP_SSS_W, H4, H4, DO_DIV)
> +RVVCALL(OPIVX2, vdiv_vx_d, OP_SSS_D, H8, H8, DO_DIV)
> +RVVCALL(OPIVX2, vremu_vx_b, OP_UUU_B, H1, H1, DO_REMU)
> +RVVCALL(OPIVX2, vremu_vx_h, OP_UUU_H, H2, H2, DO_REMU)
> +RVVCALL(OPIVX2, vremu_vx_w, OP_UUU_W, H4, H4, DO_REMU)
> +RVVCALL(OPIVX2, vremu_vx_d, OP_UUU_D, H8, H8, DO_REMU)
> +RVVCALL(OPIVX2, vrem_vx_b, OP_SSS_B, H1, H1, DO_REM)
> +RVVCALL(OPIVX2, vrem_vx_h, OP_SSS_H, H2, H2, DO_REM)
> +RVVCALL(OPIVX2, vrem_vx_w, OP_SSS_W, H4, H4, DO_REM)
> +RVVCALL(OPIVX2, vrem_vx_d, OP_SSS_D, H8, H8, DO_REM)
> +GEN_VEXT_VX(vdivu_vx_b, 1, 1, clearb)
> +GEN_VEXT_VX(vdivu_vx_h, 2, 2, clearh)
> +GEN_VEXT_VX(vdivu_vx_w, 4, 4, clearl)
> +GEN_VEXT_VX(vdivu_vx_d, 8, 8, clearq)
> +GEN_VEXT_VX(vdiv_vx_b, 1, 1, clearb)
> +GEN_VEXT_VX(vdiv_vx_h, 2, 2, clearh)
> +GEN_VEXT_VX(vdiv_vx_w, 4, 4, clearl)
> +GEN_VEXT_VX(vdiv_vx_d, 8, 8, clearq)
> +GEN_VEXT_VX(vremu_vx_b, 1, 1, clearb)
> +GEN_VEXT_VX(vremu_vx_h, 2, 2, clearh)
> +GEN_VEXT_VX(vremu_vx_w, 4, 4, clearl)
> +GEN_VEXT_VX(vremu_vx_d, 8, 8, clearq)
> +GEN_VEXT_VX(vrem_vx_b, 1, 1, clearb)
> +GEN_VEXT_VX(vrem_vx_h, 2, 2, clearh)
> +GEN_VEXT_VX(vrem_vx_w, 4, 4, clearl)
> +GEN_VEXT_VX(vrem_vx_d, 8, 8, clearq)
> --
> 2.23.0
>

