Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD902C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 21:54:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84AA820B1F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 21:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjscdsRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84AA820B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPYwo-0000Fq-OL
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 17:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jPYvo-0008Ct-He
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jPYvl-0003IK-0t
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:53:52 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:35159)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jPYvi-0003FG-HY; Fri, 17 Apr 2020 17:53:47 -0400
Received: by mail-il1-x142.google.com with SMTP id b18so3694972ilf.2;
 Fri, 17 Apr 2020 14:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uf5MSP2jxL1DcpQ4IxJOORoTzoM2loYOlqBg6a9/dxg=;
 b=pjscdsRWBPtjPO63pvjQqXHLm7NTgXgIkZP+I9nwkna1kannaDJI68K1C5JURXICrr
 6H2cMQClr3HE2F+Ni87zaeQaAm7kHJrd3lAaeivvbgY6Lcd8IftbdKUcS/YQBYKUt2nA
 cXPW6eWuY9UWZjecRdjxz2u2MPIn3KnciJ1W/sRbkIT2M2KyiBdjxDtiQA8Ctpmf7gk7
 pZIVorsUCoBEdriZfJp1q6ivlE7aUxCb9z5T0tIuj5thgFDS2m1eEHbuGvq+S37xCXl3
 s87D4EObRqk7U/HzcQ7SbhAWPcD1HY2BHSVLEEbkJBUNUiOxzuS71Pb3kwItrJOKmk63
 lrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uf5MSP2jxL1DcpQ4IxJOORoTzoM2loYOlqBg6a9/dxg=;
 b=IvsZqBhUqIfkhpOs+dOTxVmNVXbcrXB0M5BL0L8KhzpyvdR4MuRmjsb6POkQwmHpWb
 ci9/nqHV7F5bkHZbRyGFGaiIMQv5XgAiRy4CUOgQlNME9kaw09GA7OP0X3cU3tQeWW66
 OJauR3+plF36tkj7QK8pUj30hl4w42nYyOIjV0UousQy2rrVGd01/Zytsosa6Bfjxri3
 ElTds2hDziG+qTZr+u3i9nnIVLi3B7krN5Znf765V5spE8E/3LiqySRojnZj7KsrjCY3
 O8qZtnHzwk211PRQxNIJ5galZr3yrVFhfx7ebSJIXWvgqwodLYaHQ2t3PFnehXMoSeGU
 IUUA==
X-Gm-Message-State: AGi0PuZolIx0M1e2iEkhz+8zwGqxyc+5a+Lb/+6cOwqdyETj3f6MboQS
 DPeW821flO6KpHmTPQgiNYY6+F1gcT5DEyOu/1E=
X-Google-Smtp-Source: APiQypLFfuCh0VWx79ca+BAqmk5qZLRF+3FyV0fnFG18iDrKAgnyrgXDMKT3gyjJHtw1VqrU0azWogH1fi4N7C5wZ/g=
X-Received: by 2002:a92:d182:: with SMTP id z2mr5467869ilz.177.1587160425283; 
 Fri, 17 Apr 2020 14:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200330153633.15298-1-zhiwei_liu@c-sky.com>
 <20200330153633.15298-30-zhiwei_liu@c-sky.com>
In-Reply-To: <20200330153633.15298-30-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Apr 2020 14:45:22 -0700
Message-ID: <CAKmqyKN3yV5nC5punoLcY3+dA72se7OhxLACCgqE_ufnUBb50A@mail.gmail.com>
Subject: Re: [PATCH v7 29/61] target/riscv: vector narrowing fixed-point clip
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::142
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

On Mon, Mar 30, 2020 at 9:35 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   |  13 +++
>  target/riscv/insn32.decode              |   6 +
>  target/riscv/insn_trans/trans_rvv.inc.c |   8 ++
>  target/riscv/vector_helper.c            | 141 ++++++++++++++++++++++++
>  4 files changed, 168 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index f36f840714..7f7fdcb451 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -784,3 +784,16 @@ DEF_HELPER_6(vssra_vx_b, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vssra_vx_h, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vssra_vx_w, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vssra_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +
> +DEF_HELPER_6(vnclip_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vnclip_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vnclip_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vnclipu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vnclipu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vnclipu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vnclipu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vnclipu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vnclipu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vnclip_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vnclip_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vnclip_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 2ecac3d96d..8b898f9bad 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -437,6 +437,12 @@ vssrl_vi        101010 . ..... ..... 011 ..... 1010111 @r_vm
>  vssra_vv        101011 . ..... ..... 000 ..... 1010111 @r_vm
>  vssra_vx        101011 . ..... ..... 100 ..... 1010111 @r_vm
>  vssra_vi        101011 . ..... ..... 011 ..... 1010111 @r_vm
> +vnclipu_vv      101110 . ..... ..... 000 ..... 1010111 @r_vm
> +vnclipu_vx      101110 . ..... ..... 100 ..... 1010111 @r_vm
> +vnclipu_vi      101110 . ..... ..... 011 ..... 1010111 @r_vm
> +vnclip_vv       101111 . ..... ..... 000 ..... 1010111 @r_vm
> +vnclip_vx       101111 . ..... ..... 100 ..... 1010111 @r_vm
> +vnclip_vi       101111 . ..... ..... 011 ..... 1010111 @r_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index d5aaf18a07..d03ec2688f 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -1799,3 +1799,11 @@ GEN_OPIVX_TRANS(vssrl_vx,  opivx_check)
>  GEN_OPIVX_TRANS(vssra_vx,  opivx_check)
>  GEN_OPIVI_TRANS(vssrl_vi, 1, vssrl_vx, opivx_check)
>  GEN_OPIVI_TRANS(vssra_vi, 0, vssra_vx, opivx_check)
> +
> +/* Vector Narrowing Fixed-Point Clip Instructions */
> +GEN_OPIVV_NARROW_TRANS(vnclipu_vv)
> +GEN_OPIVV_NARROW_TRANS(vnclip_vv)
> +GEN_OPIVX_NARROW_TRANS(vnclipu_vx)
> +GEN_OPIVX_NARROW_TRANS(vnclip_vx)
> +GEN_OPIVI_NARROW_TRANS(vnclipu_vi, 1, vnclipu_vx)
> +GEN_OPIVI_NARROW_TRANS(vnclip_vi, 1, vnclip_vx)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 00ee42ea83..502656d005 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -874,6 +874,12 @@ GEN_VEXT_AMO(vamomaxuw_v_w, uint32_t, uint32_t, idx_w, clearl)
>  #define WOP_SSU_B int16_t, int8_t, uint8_t, int16_t, uint16_t
>  #define WOP_SSU_H int32_t, int16_t, uint16_t, int32_t, uint32_t
>  #define WOP_SSU_W int64_t, int32_t, uint32_t, int64_t, uint64_t
> +#define NOP_SSS_B int8_t, int8_t, int16_t, int8_t, int16_t
> +#define NOP_SSS_H int16_t, int16_t, int32_t, int16_t, int32_t
> +#define NOP_SSS_W int32_t, int32_t, int64_t, int32_t, int64_t
> +#define NOP_UUU_B uint8_t, uint8_t, uint16_t, uint8_t, uint16_t
> +#define NOP_UUU_H uint16_t, uint16_t, uint32_t, uint16_t, uint32_t
> +#define NOP_UUU_W uint32_t, uint32_t, uint64_t, uint32_t, uint64_t
>
>  /* operation of two vector elements */
>  typedef void opivv2_fn(void *vd, void *vs1, void *vs2, int i);
> @@ -3008,6 +3014,7 @@ vssra64(CPURISCVState *env, int vxrm, int64_t a, int64_t b)
>      res   = (a >> shift)  + round;
>      return res;
>  }
> +
>  RVVCALL(OPIVV2_RM, vssra_vv_b, OP_SSS_B, H1, H1, H1, vssra8)
>  RVVCALL(OPIVV2_RM, vssra_vv_h, OP_SSS_H, H2, H2, H2, vssra16)
>  RVVCALL(OPIVV2_RM, vssra_vv_w, OP_SSS_W, H4, H4, H4, vssra32)
> @@ -3025,3 +3032,137 @@ GEN_VEXT_VX_RM(vssra_vx_b, 1, 1, clearb)
>  GEN_VEXT_VX_RM(vssra_vx_h, 2, 2, clearh)
>  GEN_VEXT_VX_RM(vssra_vx_w, 4, 4, clearl)
>  GEN_VEXT_VX_RM(vssra_vx_d, 8, 8, clearq)
> +
> +/* Vector Narrowing Fixed-Point Clip Instructions */
> +static inline int8_t
> +vnclip8(CPURISCVState *env, int vxrm, int16_t a, int8_t b)
> +{
> +    uint8_t round, shift = b & 0xf;
> +    int16_t res;
> +
> +    round = get_round(vxrm, a, shift);
> +    res   = (a >> shift)  + round;
> +    if (res > INT8_MAX) {
> +        env->vxsat = 0x1;
> +        return INT8_MAX;
> +    } else if (res < INT8_MIN) {
> +        env->vxsat = 0x1;
> +        return INT8_MIN;
> +    } else {
> +        return res;
> +    }
> +}
> +
> +static inline int16_t
> +vnclip16(CPURISCVState *env, int vxrm, int32_t a, int16_t b)
> +{
> +    uint8_t round, shift = b & 0x1f;
> +    int32_t res;
> +
> +    round = get_round(vxrm, a, shift);
> +    res   = (a >> shift)  + round;
> +    if (res > INT16_MAX) {
> +        env->vxsat = 0x1;
> +        return INT16_MAX;
> +    } else if (res < INT16_MIN) {
> +        env->vxsat = 0x1;
> +        return INT16_MIN;
> +    } else {
> +        return res;
> +    }
> +}
> +
> +static inline int32_t
> +vnclip32(CPURISCVState *env, int vxrm, int64_t a, int32_t b)
> +{
> +    uint8_t round, shift = b & 0x3f;
> +    int64_t res;
> +
> +    round = get_round(vxrm, a, shift);
> +    res   = (a >> shift)  + round;
> +    if (res > INT32_MAX) {
> +        env->vxsat = 0x1;
> +        return INT32_MAX;
> +    } else if (res < INT32_MIN) {
> +        env->vxsat = 0x1;
> +        return INT32_MIN;
> +    } else {
> +        return res;
> +    }
> +}
> +
> +RVVCALL(OPIVV2_RM, vnclip_vv_b, NOP_SSS_B, H1, H2, H1, vnclip8)
> +RVVCALL(OPIVV2_RM, vnclip_vv_h, NOP_SSS_H, H2, H4, H2, vnclip16)
> +RVVCALL(OPIVV2_RM, vnclip_vv_w, NOP_SSS_W, H4, H8, H4, vnclip32)
> +GEN_VEXT_VV_RM(vnclip_vv_b, 1, 1, clearb)
> +GEN_VEXT_VV_RM(vnclip_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_RM(vnclip_vv_w, 4, 4, clearl)
> +
> +RVVCALL(OPIVX2_RM, vnclip_vx_b, NOP_SSS_B, H1, H2, vnclip8)
> +RVVCALL(OPIVX2_RM, vnclip_vx_h, NOP_SSS_H, H2, H4, vnclip16)
> +RVVCALL(OPIVX2_RM, vnclip_vx_w, NOP_SSS_W, H4, H8, vnclip32)
> +GEN_VEXT_VX_RM(vnclip_vx_b, 1, 1, clearb)
> +GEN_VEXT_VX_RM(vnclip_vx_h, 2, 2, clearh)
> +GEN_VEXT_VX_RM(vnclip_vx_w, 4, 4, clearl)
> +
> +static inline uint8_t
> +vnclipu8(CPURISCVState *env, int vxrm, uint16_t a, uint8_t b)
> +{
> +    uint8_t round, shift = b & 0xf;
> +    uint16_t res;
> +
> +    round = get_round(vxrm, a, shift);
> +    res   = (a >> shift)  + round;
> +    if (res > UINT8_MAX) {
> +        env->vxsat = 0x1;
> +        return UINT8_MAX;
> +    } else {
> +        return res;
> +    }
> +}
> +
> +static inline uint16_t
> +vnclipu16(CPURISCVState *env, int vxrm, uint32_t a, uint16_t b)
> +{
> +    uint8_t round, shift = b & 0x1f;
> +    uint32_t res;
> +
> +    round = get_round(vxrm, a, shift);
> +    res   = (a >> shift)  + round;
> +    if (res > UINT16_MAX) {
> +        env->vxsat = 0x1;
> +        return UINT16_MAX;
> +    } else {
> +        return res;
> +    }
> +}
> +
> +static inline uint32_t
> +vnclipu32(CPURISCVState *env, int vxrm, uint64_t a, uint32_t b)
> +{
> +    uint8_t round, shift = b & 0x3f;
> +    int64_t res;
> +
> +    round = get_round(vxrm, a, shift);
> +    res   = (a >> shift)  + round;
> +    if (res > UINT32_MAX) {
> +        env->vxsat = 0x1;
> +        return UINT32_MAX;
> +    } else {
> +        return res;
> +    }
> +}
> +
> +RVVCALL(OPIVV2_RM, vnclipu_vv_b, NOP_UUU_B, H1, H2, H1, vnclipu8)
> +RVVCALL(OPIVV2_RM, vnclipu_vv_h, NOP_UUU_H, H2, H4, H2, vnclipu16)
> +RVVCALL(OPIVV2_RM, vnclipu_vv_w, NOP_UUU_W, H4, H8, H4, vnclipu32)
> +GEN_VEXT_VV_RM(vnclipu_vv_b, 1, 1, clearb)
> +GEN_VEXT_VV_RM(vnclipu_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_RM(vnclipu_vv_w, 4, 4, clearl)
> +
> +RVVCALL(OPIVX2_RM, vnclipu_vx_b, NOP_UUU_B, H1, H2, vnclipu8)
> +RVVCALL(OPIVX2_RM, vnclipu_vx_h, NOP_UUU_H, H2, H4, vnclipu16)
> +RVVCALL(OPIVX2_RM, vnclipu_vx_w, NOP_UUU_W, H4, H8, vnclipu32)
> +GEN_VEXT_VX_RM(vnclipu_vx_b, 1, 1, clearb)
> +GEN_VEXT_VX_RM(vnclipu_vx_h, 2, 2, clearh)
> +GEN_VEXT_VX_RM(vnclipu_vx_w, 4, 4, clearl)
> --
> 2.23.0
>

