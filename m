Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A64BC2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:51:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487A2206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5eNztw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487A2206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHABe-0003p4-Gd
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 13:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jHAAH-0002SK-BJ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:50:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jHAAF-00054T-Nw
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:50:05 -0400
Received: from mail-ua1-x941.google.com ([2607:f8b0:4864:20::941]:39673)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jHAAF-00053z-K0; Wed, 25 Mar 2020 13:50:03 -0400
Received: by mail-ua1-x941.google.com with SMTP id o16so1076867uap.6;
 Wed, 25 Mar 2020 10:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ieONrgCMVlSNEaui7/pnG4c9RgEkO8/mNP48GoRUSAs=;
 b=J5eNztw6dnhzD9ngvw0X1mvT5ZwAQZAfSkXNrP+9N0cA7l8YjpfUxqjw8N1YHKmn2P
 Xe5ojj8PJmEKxaCNFrHvtzlBbySpE00OAgSDA1scf/xFjkjppNSEonAhy5TbHZCRH0Xb
 3xlL2Q16+lSTI3FDvCYFX6FcTcnabB2xB4CYB+oVFOHZ4/GmrcfDiVFiojqHf4v+XU2f
 1z2//J0jHLn2mj2aD7n4VgYBz55b4U4QtyIzgThM5YoHgiGPJFe9qGzC5fLJ1LIOkK3Z
 8xR1a0sNhVbUQMRWDJVms7LuAC2x8zWJeOcwfm2Eit3RipuazG0vpIvhm6ENFgQm91C1
 ZTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ieONrgCMVlSNEaui7/pnG4c9RgEkO8/mNP48GoRUSAs=;
 b=F5HflMi0eMJ0dKAtbLRwXnSoyZXDX6Bc1h5Ap8g9s7KScsw4nL9m7e9v7XvfpwWApr
 SZpKORICJ8/7076cnCxJOAt9svY0yfNwkQJNtXCZ/a5xHgf+NYGE6GZXgwc3XJoVNPra
 88R6Ayr+4XhmPnhGwK2FQn33vMQaLVgYxHT4l/7wJ3jElCUsnU4ANjt+Xn8jkF/f8dZy
 U+9a7hI9DoqvMvInPOJ8/UqusliW9C1iEobJ/4zs5DvUQe0g9hrUB1kbHj3QwOWFVE3Q
 37A9H3aA1AsSeoDHVHltQejdEBqKgsD3ngQQMs+hLo+oFS84kflnTSE5fK59Y7WRsiXx
 GxYg==
X-Gm-Message-State: ANhLgQ0uab2qoyHavKcSUTmKZuCM9coB+Xjg/A0mioA9TRbSRlWXKxsH
 IGiREwDt8ljAxf7Oa05haIx9x5+dM2dDryiybO8=
X-Google-Smtp-Source: ADFU+vv0faZ8+4S19gDGH6kPl4ykco2QZVd03J6OYmlGlNBhm6BmYElIK2jwM2W+aNdPabt/ETWlM4xZVaPa+vzAkCo=
X-Received: by 2002:ab0:2881:: with SMTP id s1mr3375367uap.8.1585158602942;
 Wed, 25 Mar 2020 10:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-23-zhiwei_liu@c-sky.com>
In-Reply-To: <20200317150653.9008-23-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Mar 2020 10:42:03 -0700
Message-ID: <CAKmqyKOjTezWbJz60SiZ8sHyFYREnfNzG91MCWzQQjCa+GdqRA@mail.gmail.com>
Subject: Re: [PATCH v6 22/61] target/riscv: vector widening integer
 multiply-add instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::941
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

On Tue, Mar 17, 2020 at 8:51 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   | 22 ++++++++++++
>  target/riscv/insn32.decode              |  7 ++++
>  target/riscv/insn_trans/trans_rvv.inc.c |  9 +++++
>  target/riscv/vector_helper.c            | 45 +++++++++++++++++++++++++
>  4 files changed, 83 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 098288df76..1f0d3d60e3 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -643,3 +643,25 @@ DEF_HELPER_6(vnmsub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vnmsub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vnmsub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vnmsub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +
> +DEF_HELPER_6(vwmaccu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwmaccu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwmaccu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwmacc_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwmaccsu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwmaccsu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwmaccsu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vwmaccu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwmaccu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwmaccu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwmacc_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwmacc_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwmacc_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwmaccsu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwmaccsu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwmaccsu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwmaccus_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwmaccus_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vwmaccus_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index b49b60aea1..9735ac3565 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -393,6 +393,13 @@ vmadd_vv        101001 . ..... ..... 010 ..... 1010111 @r_vm
>  vmadd_vx        101001 . ..... ..... 110 ..... 1010111 @r_vm
>  vnmsub_vv       101011 . ..... ..... 010 ..... 1010111 @r_vm
>  vnmsub_vx       101011 . ..... ..... 110 ..... 1010111 @r_vm
> +vwmaccu_vv      111100 . ..... ..... 010 ..... 1010111 @r_vm
> +vwmaccu_vx      111100 . ..... ..... 110 ..... 1010111 @r_vm
> +vwmacc_vv       111101 . ..... ..... 010 ..... 1010111 @r_vm
> +vwmacc_vx       111101 . ..... ..... 110 ..... 1010111 @r_vm
> +vwmaccsu_vv     111110 . ..... ..... 010 ..... 1010111 @r_vm
> +vwmaccsu_vx     111110 . ..... ..... 110 ..... 1010111 @r_vm
> +vwmaccus_vx     111111 . ..... ..... 110 ..... 1010111 @r_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index 6d2ccbd615..269d04c7fb 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -1490,3 +1490,12 @@ GEN_OPIVX_TRANS(vmacc_vx, opivx_check)
>  GEN_OPIVX_TRANS(vnmsac_vx, opivx_check)
>  GEN_OPIVX_TRANS(vmadd_vx, opivx_check)
>  GEN_OPIVX_TRANS(vnmsub_vx, opivx_check)
> +
> +/* Vector Widening Integer Multiply-Add Instructions */
> +GEN_OPIVV_WIDEN_TRANS(vwmaccu_vv, opivv_widen_check)
> +GEN_OPIVV_WIDEN_TRANS(vwmacc_vv, opivv_widen_check)
> +GEN_OPIVV_WIDEN_TRANS(vwmaccsu_vv, opivv_widen_check)
> +GEN_OPIVX_WIDEN_TRANS(vwmaccu_vx)
> +GEN_OPIVX_WIDEN_TRANS(vwmacc_vx)
> +GEN_OPIVX_WIDEN_TRANS(vwmaccsu_vx)
> +GEN_OPIVX_WIDEN_TRANS(vwmaccus_vx)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index f65ed6abbc..5adce9e0a3 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -1954,3 +1954,48 @@ GEN_VEXT_VX(vnmsub_vx_b, 1, 1, clearb)
>  GEN_VEXT_VX(vnmsub_vx_h, 2, 2, clearh)
>  GEN_VEXT_VX(vnmsub_vx_w, 4, 4, clearl)
>  GEN_VEXT_VX(vnmsub_vx_d, 8, 8, clearq)
> +
> +/* Vector Widening Integer Multiply-Add Instructions */
> +RVVCALL(OPIVV3, vwmaccu_vv_b, WOP_UUU_B, H2, H1, H1, DO_MACC)
> +RVVCALL(OPIVV3, vwmaccu_vv_h, WOP_UUU_H, H4, H2, H2, DO_MACC)
> +RVVCALL(OPIVV3, vwmaccu_vv_w, WOP_UUU_W, H8, H4, H4, DO_MACC)
> +RVVCALL(OPIVV3, vwmacc_vv_b, WOP_SSS_B, H2, H1, H1, DO_MACC)
> +RVVCALL(OPIVV3, vwmacc_vv_h, WOP_SSS_H, H4, H2, H2, DO_MACC)
> +RVVCALL(OPIVV3, vwmacc_vv_w, WOP_SSS_W, H8, H4, H4, DO_MACC)
> +RVVCALL(OPIVV3, vwmaccsu_vv_b, WOP_SSU_B, H2, H1, H1, DO_MACC)
> +RVVCALL(OPIVV3, vwmaccsu_vv_h, WOP_SSU_H, H4, H2, H2, DO_MACC)
> +RVVCALL(OPIVV3, vwmaccsu_vv_w, WOP_SSU_W, H8, H4, H4, DO_MACC)
> +GEN_VEXT_VV(vwmaccu_vv_b, 1, 2, clearh)
> +GEN_VEXT_VV(vwmaccu_vv_h, 2, 4, clearl)
> +GEN_VEXT_VV(vwmaccu_vv_w, 4, 8, clearq)
> +GEN_VEXT_VV(vwmacc_vv_b, 1, 2, clearh)
> +GEN_VEXT_VV(vwmacc_vv_h, 2, 4, clearl)
> +GEN_VEXT_VV(vwmacc_vv_w, 4, 8, clearq)
> +GEN_VEXT_VV(vwmaccsu_vv_b, 1, 2, clearh)
> +GEN_VEXT_VV(vwmaccsu_vv_h, 2, 4, clearl)
> +GEN_VEXT_VV(vwmaccsu_vv_w, 4, 8, clearq)
> +
> +RVVCALL(OPIVX3, vwmaccu_vx_b, WOP_UUU_B, H2, H1, DO_MACC)
> +RVVCALL(OPIVX3, vwmaccu_vx_h, WOP_UUU_H, H4, H2, DO_MACC)
> +RVVCALL(OPIVX3, vwmaccu_vx_w, WOP_UUU_W, H8, H4, DO_MACC)
> +RVVCALL(OPIVX3, vwmacc_vx_b, WOP_SSS_B, H2, H1, DO_MACC)
> +RVVCALL(OPIVX3, vwmacc_vx_h, WOP_SSS_H, H4, H2, DO_MACC)
> +RVVCALL(OPIVX3, vwmacc_vx_w, WOP_SSS_W, H8, H4, DO_MACC)
> +RVVCALL(OPIVX3, vwmaccsu_vx_b, WOP_SSU_B, H2, H1, DO_MACC)
> +RVVCALL(OPIVX3, vwmaccsu_vx_h, WOP_SSU_H, H4, H2, DO_MACC)
> +RVVCALL(OPIVX3, vwmaccsu_vx_w, WOP_SSU_W, H8, H4, DO_MACC)
> +RVVCALL(OPIVX3, vwmaccus_vx_b, WOP_SUS_B, H2, H1, DO_MACC)
> +RVVCALL(OPIVX3, vwmaccus_vx_h, WOP_SUS_H, H4, H2, DO_MACC)
> +RVVCALL(OPIVX3, vwmaccus_vx_w, WOP_SUS_W, H8, H4, DO_MACC)
> +GEN_VEXT_VX(vwmaccu_vx_b, 1, 2, clearh)
> +GEN_VEXT_VX(vwmaccu_vx_h, 2, 4, clearl)
> +GEN_VEXT_VX(vwmaccu_vx_w, 4, 8, clearq)
> +GEN_VEXT_VX(vwmacc_vx_b, 1, 2, clearh)
> +GEN_VEXT_VX(vwmacc_vx_h, 2, 4, clearl)
> +GEN_VEXT_VX(vwmacc_vx_w, 4, 8, clearq)
> +GEN_VEXT_VX(vwmaccsu_vx_b, 1, 2, clearh)
> +GEN_VEXT_VX(vwmaccsu_vx_h, 2, 4, clearl)
> +GEN_VEXT_VX(vwmaccsu_vx_w, 4, 8, clearq)
> +GEN_VEXT_VX(vwmaccus_vx_b, 1, 2, clearh)
> +GEN_VEXT_VX(vwmaccus_vx_h, 2, 4, clearl)
> +GEN_VEXT_VX(vwmaccus_vx_w, 4, 8, clearq)
> --
> 2.23.0
>

