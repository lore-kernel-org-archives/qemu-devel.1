Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432AAC4332E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 142D220775
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N76Ut/pN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142D220775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFMqG-0000QN-9M
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 14:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jFMpa-0008Nz-5i
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jFMpY-0001QX-7g
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:57:18 -0400
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42]:37827)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jFMpY-0001Pq-0S; Fri, 20 Mar 2020 14:57:16 -0400
Received: by mail-vs1-xe42.google.com with SMTP id o3so4681473vsd.4;
 Fri, 20 Mar 2020 11:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ii3wz6ePBzKaL41DL80zX0fdXH6zeffllUYnRZOnsbg=;
 b=N76Ut/pNKFwA3gOTrwhZ8lsuP7ClPYmCAPzJIwDsn19+5zZSjTvnxT0tVZ7r05TM4Q
 v+Ho9FBAitWf+q4dvaDuAvhma/hWBBOMpr7WOAOPJ/vmIOX5NGV9Ff7Ynk+goKC2iybG
 cZnbbbmUrjJTWurnM1Lwnn0K5qJqJoZT8KIJAmiCh4ntQcbGqlM1mysQbbtBktI6WbIa
 D2dJL9WUMn1jd5rJF2vVDzrGkQ3sNW5Iy3RtbDztPvLiHO3w+gItVXJDDhRIeTuJKfvd
 0gAt4K9xkkPR17d+r+kUIPlSMbuk4GlBfFiE92EmRN6f80z5zpBScLGVjAEEWGBb929T
 EDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ii3wz6ePBzKaL41DL80zX0fdXH6zeffllUYnRZOnsbg=;
 b=MwIWQYpZ/8RBw8a/BpUIm9wJpzIdpi1geCOCqHcvPUHpMqxNJhHOb/bv22HzadEYF2
 iSSwUinl1OduhoQE4n6se28uA575374Ev3qg2MoX/F7U/RNvkc/irioj/lE00crGHFOP
 FHZlQ4r0YgYgpMEXRT1AdWNkmF1Jx5+6ZczV+6EPnYvc//Rgoji0M7MldjXH7pSvpQEo
 F01/OE1nEmXLUq0bV3+qAWPeqN8PRAqacnBbRZKGaCkUMqJSC4TExvShKCTmJ0etG3L3
 d809BI6++uubgTxfiS6LD+4xN5PKwsSoZMSwH9ptEKqYkpwFnk6hVf4IdlfVRq1XNufs
 RLHg==
X-Gm-Message-State: ANhLgQ3PCTBq+vghiqyfOQR63mnQScLiOL4MBplw5A/pfwSqC1KMCPtn
 p6caeDooWV+qmE5oXq9UbktNahdzise4wmgSkQ0=
X-Google-Smtp-Source: ADFU+vs4UNxWs4n76z+5hDUK56JiysqDu8zQ7M6V31lEoFQmQG4hasgKUw/6TVlQthQ6z1tvIRJaRs8deW2Sa0rBDPY=
X-Received: by 2002:a67:cd8e:: with SMTP id r14mr7290569vsl.172.1584730635259; 
 Fri, 20 Mar 2020 11:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-18-zhiwei_liu@c-sky.com>
In-Reply-To: <20200317150653.9008-18-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 20 Mar 2020 11:49:17 -0700
Message-ID: <CAKmqyKNoKRz8r1b845V+g-3G6QerfOE96OvsyMC192fgG4H5mA@mail.gmail.com>
Subject: Re: [PATCH v6 17/61] target/riscv: vector integer min/max instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e42
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

On Tue, Mar 17, 2020 at 8:41 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   | 33 ++++++++++++
>  target/riscv/insn32.decode              |  8 +++
>  target/riscv/insn_trans/trans_rvv.inc.c | 10 ++++
>  target/riscv/vector_helper.c            | 71 +++++++++++++++++++++++++
>  4 files changed, 122 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 4e6c47c2d2..c7d4ff185a 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -492,3 +492,36 @@ DEF_HELPER_6(vmsgt_vx_b, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vmsgt_vx_h, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vmsgt_vx_w, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vmsgt_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +
> +DEF_HELPER_6(vminu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vminu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vminu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vminu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmin_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmin_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmin_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmin_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmaxu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmaxu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmaxu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmaxu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmax_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmax_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmax_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmax_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vminu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vminu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vminu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vminu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmin_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmin_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmin_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmin_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmaxu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmaxu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmaxu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmaxu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmax_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmax_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmax_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vmax_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index df6181980d..aafbdc6be7 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -355,6 +355,14 @@ vmsgtu_vx       011110 . ..... ..... 100 ..... 1010111 @r_vm
>  vmsgtu_vi       011110 . ..... ..... 011 ..... 1010111 @r_vm
>  vmsgt_vx        011111 . ..... ..... 100 ..... 1010111 @r_vm
>  vmsgt_vi        011111 . ..... ..... 011 ..... 1010111 @r_vm
> +vminu_vv        000100 . ..... ..... 000 ..... 1010111 @r_vm
> +vminu_vx        000100 . ..... ..... 100 ..... 1010111 @r_vm
> +vmin_vv         000101 . ..... ..... 000 ..... 1010111 @r_vm
> +vmin_vx         000101 . ..... ..... 100 ..... 1010111 @r_vm
> +vmaxu_vv        000110 . ..... ..... 000 ..... 1010111 @r_vm
> +vmaxu_vx        000110 . ..... ..... 100 ..... 1010111 @r_vm
> +vmax_vv         000111 . ..... ..... 000 ..... 1010111 @r_vm
> +vmax_vx         000111 . ..... ..... 100 ..... 1010111 @r_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index 53c00d914f..53c49ee15c 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -1442,3 +1442,13 @@ GEN_OPIVI_TRANS(vmsleu_vi, 1, vmsleu_vx, opivx_cmp_check)
>  GEN_OPIVI_TRANS(vmsle_vi, 0, vmsle_vx, opivx_cmp_check)
>  GEN_OPIVI_TRANS(vmsgtu_vi, 1, vmsgtu_vx, opivx_cmp_check)
>  GEN_OPIVI_TRANS(vmsgt_vi, 0, vmsgt_vx, opivx_cmp_check)
> +
> +/* Vector Integer Min/Max Instructions */
> +GEN_OPIVV_GVEC_TRANS(vminu_vv, umin)
> +GEN_OPIVV_GVEC_TRANS(vmin_vv,  smin)
> +GEN_OPIVV_GVEC_TRANS(vmaxu_vv, umax)
> +GEN_OPIVV_GVEC_TRANS(vmax_vv,  smax)
> +GEN_OPIVX_TRANS(vminu_vx, opivx_check)
> +GEN_OPIVX_TRANS(vmin_vx,  opivx_check)
> +GEN_OPIVX_TRANS(vmaxu_vx, opivx_check)
> +GEN_OPIVX_TRANS(vmax_vx,  opivx_check)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index d1fc543e98..32c2760a8a 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -848,6 +848,10 @@ GEN_VEXT_AMO(vamomaxuw_v_w, uint32_t, uint32_t, idx_w, clearl)
>  #define OP_SSS_H int16_t, int16_t, int16_t, int16_t, int16_t
>  #define OP_SSS_W int32_t, int32_t, int32_t, int32_t, int32_t
>  #define OP_SSS_D int64_t, int64_t, int64_t, int64_t, int64_t
> +#define OP_UUU_B uint8_t, uint8_t, uint8_t, uint8_t, uint8_t
> +#define OP_UUU_H uint16_t, uint16_t, uint16_t, uint16_t, uint16_t
> +#define OP_UUU_W uint32_t, uint32_t, uint32_t, uint32_t, uint32_t
> +#define OP_UUU_D uint64_t, uint64_t, uint64_t, uint64_t, uint64_t
>
>  /* operation of two vector elements */
>  typedef void opivv2_fn(void *vd, void *vs1, void *vs2, int i);
> @@ -1514,3 +1518,70 @@ GEN_VEXT_CMP_VX(vmsgt_vx_b, int8_t,  H1, DO_MSGT)
>  GEN_VEXT_CMP_VX(vmsgt_vx_h, int16_t, H2, DO_MSGT)
>  GEN_VEXT_CMP_VX(vmsgt_vx_w, int32_t, H4, DO_MSGT)
>  GEN_VEXT_CMP_VX(vmsgt_vx_d, int64_t, H8, DO_MSGT)
> +
> +/* Vector Integer Min/Max Instructions */
> +RVVCALL(OPIVV2, vminu_vv_b, OP_UUU_B, H1, H1, H1, DO_MIN)
> +RVVCALL(OPIVV2, vminu_vv_h, OP_UUU_H, H2, H2, H2, DO_MIN)
> +RVVCALL(OPIVV2, vminu_vv_w, OP_UUU_W, H4, H4, H4, DO_MIN)
> +RVVCALL(OPIVV2, vminu_vv_d, OP_UUU_D, H8, H8, H8, DO_MIN)
> +RVVCALL(OPIVV2, vmin_vv_b, OP_SSS_B, H1, H1, H1, DO_MIN)
> +RVVCALL(OPIVV2, vmin_vv_h, OP_SSS_H, H2, H2, H2, DO_MIN)
> +RVVCALL(OPIVV2, vmin_vv_w, OP_SSS_W, H4, H4, H4, DO_MIN)
> +RVVCALL(OPIVV2, vmin_vv_d, OP_SSS_D, H8, H8, H8, DO_MIN)
> +RVVCALL(OPIVV2, vmaxu_vv_b, OP_UUU_B, H1, H1, H1, DO_MAX)
> +RVVCALL(OPIVV2, vmaxu_vv_h, OP_UUU_H, H2, H2, H2, DO_MAX)
> +RVVCALL(OPIVV2, vmaxu_vv_w, OP_UUU_W, H4, H4, H4, DO_MAX)
> +RVVCALL(OPIVV2, vmaxu_vv_d, OP_UUU_D, H8, H8, H8, DO_MAX)
> +RVVCALL(OPIVV2, vmax_vv_b, OP_SSS_B, H1, H1, H1, DO_MAX)
> +RVVCALL(OPIVV2, vmax_vv_h, OP_SSS_H, H2, H2, H2, DO_MAX)
> +RVVCALL(OPIVV2, vmax_vv_w, OP_SSS_W, H4, H4, H4, DO_MAX)
> +RVVCALL(OPIVV2, vmax_vv_d, OP_SSS_D, H8, H8, H8, DO_MAX)
> +GEN_VEXT_VV(vminu_vv_b, 1, 1, clearb)
> +GEN_VEXT_VV(vminu_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV(vminu_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV(vminu_vv_d, 8, 8, clearq)
> +GEN_VEXT_VV(vmin_vv_b, 1, 1, clearb)
> +GEN_VEXT_VV(vmin_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV(vmin_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV(vmin_vv_d, 8, 8, clearq)
> +GEN_VEXT_VV(vmaxu_vv_b, 1, 1, clearb)
> +GEN_VEXT_VV(vmaxu_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV(vmaxu_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV(vmaxu_vv_d, 8, 8, clearq)
> +GEN_VEXT_VV(vmax_vv_b, 1, 1, clearb)
> +GEN_VEXT_VV(vmax_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV(vmax_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV(vmax_vv_d, 8, 8, clearq)
> +
> +RVVCALL(OPIVX2, vminu_vx_b, OP_UUU_B, H1, H1, DO_MIN)
> +RVVCALL(OPIVX2, vminu_vx_h, OP_UUU_H, H2, H2, DO_MIN)
> +RVVCALL(OPIVX2, vminu_vx_w, OP_UUU_W, H4, H4, DO_MIN)
> +RVVCALL(OPIVX2, vminu_vx_d, OP_UUU_D, H8, H8, DO_MIN)
> +RVVCALL(OPIVX2, vmin_vx_b, OP_SSS_B, H1, H1, DO_MIN)
> +RVVCALL(OPIVX2, vmin_vx_h, OP_SSS_H, H2, H2, DO_MIN)
> +RVVCALL(OPIVX2, vmin_vx_w, OP_SSS_W, H4, H4, DO_MIN)
> +RVVCALL(OPIVX2, vmin_vx_d, OP_SSS_D, H8, H8, DO_MIN)
> +RVVCALL(OPIVX2, vmaxu_vx_b, OP_UUU_B, H1, H1, DO_MAX)
> +RVVCALL(OPIVX2, vmaxu_vx_h, OP_UUU_H, H2, H2, DO_MAX)
> +RVVCALL(OPIVX2, vmaxu_vx_w, OP_UUU_W, H4, H4, DO_MAX)
> +RVVCALL(OPIVX2, vmaxu_vx_d, OP_UUU_D, H8, H8, DO_MAX)
> +RVVCALL(OPIVX2, vmax_vx_b, OP_SSS_B, H1, H1, DO_MAX)
> +RVVCALL(OPIVX2, vmax_vx_h, OP_SSS_H, H2, H2, DO_MAX)
> +RVVCALL(OPIVX2, vmax_vx_w, OP_SSS_W, H4, H4, DO_MAX)
> +RVVCALL(OPIVX2, vmax_vx_d, OP_SSS_D, H8, H8, DO_MAX)
> +GEN_VEXT_VX(vminu_vx_b, 1, 1, clearb)
> +GEN_VEXT_VX(vminu_vx_h, 2, 2, clearh)
> +GEN_VEXT_VX(vminu_vx_w, 4, 4, clearl)
> +GEN_VEXT_VX(vminu_vx_d, 8, 8, clearq)
> +GEN_VEXT_VX(vmin_vx_b, 1, 1, clearb)
> +GEN_VEXT_VX(vmin_vx_h, 2, 2, clearh)
> +GEN_VEXT_VX(vmin_vx_w, 4, 4, clearl)
> +GEN_VEXT_VX(vmin_vx_d, 8, 8, clearq)
> +GEN_VEXT_VX(vmaxu_vx_b, 1, 1, clearb)
> +GEN_VEXT_VX(vmaxu_vx_h, 2, 2, clearh)
> +GEN_VEXT_VX(vmaxu_vx_w, 4, 4, clearl)
> +GEN_VEXT_VX(vmaxu_vx_d, 8, 8,  clearq)
> +GEN_VEXT_VX(vmax_vx_b, 1, 1, clearb)
> +GEN_VEXT_VX(vmax_vx_h, 2, 2, clearh)
> +GEN_VEXT_VX(vmax_vx_w, 4, 4, clearl)
> +GEN_VEXT_VX(vmax_vx_d, 8, 8, clearq)
> --
> 2.23.0
>

