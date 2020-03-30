Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8FFC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B96072073B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSBJM0Xf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96072073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIxhc-0001KX-TJ
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 12:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jIxgY-0008Pc-0u
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jIxgV-0008JP-Me
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:54:49 -0400
Received: from mail-vk1-xa44.google.com ([2607:f8b0:4864:20::a44]:45028)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jIxgV-0008II-Ha; Mon, 30 Mar 2020 12:54:47 -0400
Received: by mail-vk1-xa44.google.com with SMTP id s194so4867887vkb.11;
 Mon, 30 Mar 2020 09:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qzgEmJPSldBvGAe5huhoV5U7AvczI8efJnS8u3xEzbE=;
 b=CSBJM0XfgFzBHihwy/A2b6bDVCPy+eTj9sLfhfyyvOCFJHLchLUv5U+h7HxahOeZIH
 zZ53cT3lXzXchqWfo8BrWbOmuHotOW2ddfTY9+M5OFOR42gU6hNfYANtDvqlzJ65ciRh
 X6yqUchg/HD3jSSEBhVuIETq6P+dv8AGAPCqrr5ZOpv3eVQF+l214xkU0GHWSm3ieE4v
 H6DjyJJEic+IVNBglC0vWm0OHaZUn7XCRqTbaVUtgeXz6zQEKIHP3QnDrQWXB9ZXu6yD
 WoObyY4C0ngpBsMhuhNylr0cT3nDGvZo5sl2KgyDsEUuWo1vwp0e1HubQDVf1KgDCOuV
 pBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qzgEmJPSldBvGAe5huhoV5U7AvczI8efJnS8u3xEzbE=;
 b=i/iqjYj70Ns1dzIzwFKPBsZJjHOAx9Z3rJZaUhOmUj4ZNqcTfpC8539Hyf15Hjhmvv
 tn/FuHjRqZjCu/IUEjZP+2Hh7U4FtHFScdXLBOfqtYJ1919XjxAjxrD7M0N9uFYx2Y1i
 e0C+fPP6+1x1gfMaZxwP5BTHzTiynleYY2cHE/+l2u2LONcyIo0prI9SJ+gb5a/gFvkV
 omHZVtRAVcjppAGxLaatrQsQgadS7tT8Snfa+sgbwvARkTC8yNxbp5V81imX1qPD/x9m
 +oEH8SfwU4FCBs84k7cnQOY5/Qga4b5Z4sruhFBdpREn2iKZJ82zaJf5ncs37ExBrssa
 4iIg==
X-Gm-Message-State: AGi0Pub0piZYxAFry01/ftLPnfDQ9dMaDErUYALzjRdEzN6zlO9mMPXP
 jEUHhj4QSO6zfD0vgAVf8o3m9MvGmePnJaVVl/c=
X-Google-Smtp-Source: APiQypIV2XXCeHldc5puYDh98pMZJc0h6FiJw1RZOwmM9o9UrbHzEIoie4kabKoEVixmWTXbWg7MzzT24iLEppUynQM=
X-Received: by 2002:a1f:a2d0:: with SMTP id l199mr8387985vke.77.1585587286343; 
 Mon, 30 Mar 2020 09:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200330153633.15298-1-zhiwei_liu@c-sky.com>
 <20200330153633.15298-25-zhiwei_liu@c-sky.com>
In-Reply-To: <20200330153633.15298-25-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 30 Mar 2020 09:46:38 -0700
Message-ID: <CAKmqyKOA8f78KvuAP47z7uQnunpZ=MLpHA=DmxjypTMujbY_nQ@mail.gmail.com>
Subject: Re: [PATCH v7 24/61] target/riscv: vector single-width saturating add
 and subtract
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a44
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

On Mon, Mar 30, 2020 at 9:25 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   |  33 ++
>  target/riscv/insn32.decode              |  10 +
>  target/riscv/insn_trans/trans_rvv.inc.c |  16 +
>  target/riscv/vector_helper.c            | 385 ++++++++++++++++++++++++
>  4 files changed, 444 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 279b2e049f..9416ebb090 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -686,3 +686,36 @@ DEF_HELPER_4(vmv_v_x_b, void, ptr, i64, env, i32)
>  DEF_HELPER_4(vmv_v_x_h, void, ptr, i64, env, i32)
>  DEF_HELPER_4(vmv_v_x_w, void, ptr, i64, env, i32)
>  DEF_HELPER_4(vmv_v_x_d, void, ptr, i64, env, i32)
> +
> +DEF_HELPER_6(vsaddu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vsaddu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vsaddu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vsaddu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vsadd_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vsadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vsadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vsadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vssubu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vssubu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vssubu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vssubu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vssub_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vssub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vssub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vssub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vsaddu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vsaddu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vsaddu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vsaddu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vsadd_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vsadd_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vsadd_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vsadd_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vssubu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vssubu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vssubu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vssubu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vssub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vssub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vssub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vssub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index adb76956c9..c9a4050adc 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -407,6 +407,16 @@ vmv_v_i         010111 1 00000 ..... 011 ..... 1010111 @r2
>  vmerge_vvm      010111 0 ..... ..... 000 ..... 1010111 @r_vm_0
>  vmerge_vxm      010111 0 ..... ..... 100 ..... 1010111 @r_vm_0
>  vmerge_vim      010111 0 ..... ..... 011 ..... 1010111 @r_vm_0
> +vsaddu_vv       100000 . ..... ..... 000 ..... 1010111 @r_vm
> +vsaddu_vx       100000 . ..... ..... 100 ..... 1010111 @r_vm
> +vsaddu_vi       100000 . ..... ..... 011 ..... 1010111 @r_vm
> +vsadd_vv        100001 . ..... ..... 000 ..... 1010111 @r_vm
> +vsadd_vx        100001 . ..... ..... 100 ..... 1010111 @r_vm
> +vsadd_vi        100001 . ..... ..... 011 ..... 1010111 @r_vm
> +vssubu_vv       100010 . ..... ..... 000 ..... 1010111 @r_vm
> +vssubu_vx       100010 . ..... ..... 100 ..... 1010111 @r_vm
> +vssub_vv        100011 . ..... ..... 000 ..... 1010111 @r_vm
> +vssub_vx        100011 . ..... ..... 100 ..... 1010111 @r_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index 36c50f81c6..7f9ab4b8b7 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -1755,3 +1755,19 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
>  GEN_OPIVV_TRANS(vmerge_vvm, opivv_vadc_check)
>  GEN_OPIVX_TRANS(vmerge_vxm, opivx_vadc_check)
>  GEN_OPIVI_TRANS(vmerge_vim, 0, vmerge_vxm, opivx_vadc_check)
> +
> +/*
> + *** Vector Fixed-Point Arithmetic Instructions
> + */
> +
> +/* Vector Single-Width Saturating Add and Subtract */
> +GEN_OPIVV_TRANS(vsaddu_vv, opivv_check)
> +GEN_OPIVV_TRANS(vsadd_vv,  opivv_check)
> +GEN_OPIVV_TRANS(vssubu_vv, opivv_check)
> +GEN_OPIVV_TRANS(vssub_vv,  opivv_check)
> +GEN_OPIVX_TRANS(vsaddu_vx,  opivx_check)
> +GEN_OPIVX_TRANS(vsadd_vx,  opivx_check)
> +GEN_OPIVX_TRANS(vssubu_vx,  opivx_check)
> +GEN_OPIVX_TRANS(vssub_vx,  opivx_check)
> +GEN_OPIVI_TRANS(vsaddu_vi, 1, vsaddu_vx, opivx_check)
> +GEN_OPIVI_TRANS(vsadd_vi, 0, vsadd_vx, opivx_check)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index b38e50e36f..7f34fcccce 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -2111,3 +2111,388 @@ GEN_VEXT_VMERGE_VX(vmerge_vxm_b, int8_t,  H1, clearb)
>  GEN_VEXT_VMERGE_VX(vmerge_vxm_h, int16_t, H2, clearh)
>  GEN_VEXT_VMERGE_VX(vmerge_vxm_w, int32_t, H4, clearl)
>  GEN_VEXT_VMERGE_VX(vmerge_vxm_d, int64_t, H8, clearq)
> +
> +/*
> + *** Vector Fixed-Point Arithmetic Instructions
> + */
> +
> +/* Vector Single-Width Saturating Add and Subtract */
> +
> +/*
> + * As fixed point instructions probably have round mode and saturation,
> + * define common macros for fixed point here.
> + */
> +typedef void opivv2_rm_fn(void *vd, void *vs1, void *vs2, int i,
> +                          CPURISCVState *env, int vxrm);
> +
> +#define OPIVV2_RM(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)     \
> +static inline void                                                  \
> +do_##NAME(void *vd, void *vs1, void *vs2, int i,                    \
> +          CPURISCVState *env, int vxrm)                             \
> +{                                                                   \
> +    TX1 s1 = *((T1 *)vs1 + HS1(i));                                 \
> +    TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
> +    *((TD *)vd + HD(i)) = OP(env, vxrm, s2, s1);                    \
> +}
> +
> +static inline void
> +vext_vv_rm_1(void *vd, void *v0, void *vs1, void *vs2,
> +             CPURISCVState *env,
> +             uint32_t vl, uint32_t vm, uint32_t mlen, int vxrm,
> +             opivv2_rm_fn *fn)
> +{
> +    for (uint32_t i = 0; i < vl; i++) {
> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {
> +            continue;
> +        }
> +        fn(vd, vs1, vs2, i, env, vxrm);
> +    }
> +}
> +
> +static inline void
> +vext_vv_rm_2(void *vd, void *v0, void *vs1, void *vs2,
> +             CPURISCVState *env,
> +             uint32_t desc, uint32_t esz, uint32_t dsz,
> +             opivv2_rm_fn *fn, clear_fn *clearfn)
> +{
> +    uint32_t vlmax = vext_maxsz(desc) / esz;
> +    uint32_t mlen = vext_mlen(desc);
> +    uint32_t vm = vext_vm(desc);
> +    uint32_t vl = env->vl;
> +
> +    switch (env->vxrm) {
> +    case 0: /* rnu */
> +        vext_vv_rm_1(vd, v0, vs1, vs2,
> +                     env, vl, vm, mlen, 0, fn);
> +        break;
> +    case 1: /* rne */
> +        vext_vv_rm_1(vd, v0, vs1, vs2,
> +                     env, vl, vm, mlen, 1, fn);
> +        break;
> +    case 2: /* rdn */
> +        vext_vv_rm_1(vd, v0, vs1, vs2,
> +                     env, vl, vm, mlen, 2, fn);
> +        break;
> +    default: /* rod */
> +        vext_vv_rm_1(vd, v0, vs1, vs2,
> +                     env, vl, vm, mlen, 3, fn);
> +        break;
> +    }
> +
> +    clearfn(vd, vl, vl * dsz,  vlmax * dsz);
> +}
> +
> +/* generate helpers for fixed point instructions with OPIVV format */
> +#define GEN_VEXT_VV_RM(NAME, ESZ, DSZ, CLEAR_FN)                \
> +void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,     \
> +                  CPURISCVState *env, uint32_t desc)            \
> +{                                                               \
> +    vext_vv_rm_2(vd, v0, vs1, vs2, env, desc, ESZ, DSZ,         \
> +                 do_##NAME, CLEAR_FN);                          \
> +}
> +
> +static inline uint8_t saddu8(CPURISCVState *env, int vxrm, uint8_t a, uint8_t b)
> +{
> +    uint8_t res = a + b;
> +    if (res < a) {
> +        res = UINT8_MAX;
> +        env->vxsat = 0x1;
> +    }
> +    return res;
> +}
> +
> +static inline uint16_t saddu16(CPURISCVState *env, int vxrm, uint16_t a,
> +                               uint16_t b)
> +{
> +    uint16_t res = a + b;
> +    if (res < a) {
> +        res = UINT16_MAX;
> +        env->vxsat = 0x1;
> +    }
> +    return res;
> +}
> +
> +static inline uint32_t saddu32(CPURISCVState *env, int vxrm, uint32_t a,
> +                               uint32_t b)
> +{
> +    uint32_t res = a + b;
> +    if (res < a) {
> +        res = UINT32_MAX;
> +        env->vxsat = 0x1;
> +    }
> +    return res;
> +}
> +
> +static inline uint64_t saddu64(CPURISCVState *env, int vxrm, uint64_t a,
> +                               uint64_t b)
> +{
> +    uint64_t res = a + b;
> +    if (res < a) {
> +        res = UINT64_MAX;
> +        env->vxsat = 0x1;
> +    }
> +    return res;
> +}
> +
> +RVVCALL(OPIVV2_RM, vsaddu_vv_b, OP_UUU_B, H1, H1, H1, saddu8)
> +RVVCALL(OPIVV2_RM, vsaddu_vv_h, OP_UUU_H, H2, H2, H2, saddu16)
> +RVVCALL(OPIVV2_RM, vsaddu_vv_w, OP_UUU_W, H4, H4, H4, saddu32)
> +RVVCALL(OPIVV2_RM, vsaddu_vv_d, OP_UUU_D, H8, H8, H8, saddu64)
> +GEN_VEXT_VV_RM(vsaddu_vv_b, 1, 1, clearb)
> +GEN_VEXT_VV_RM(vsaddu_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_RM(vsaddu_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_RM(vsaddu_vv_d, 8, 8, clearq)
> +
> +typedef void opivx2_rm_fn(void *vd, target_long s1, void *vs2, int i,
> +                          CPURISCVState *env, int vxrm);
> +
> +#define OPIVX2_RM(NAME, TD, T1, T2, TX1, TX2, HD, HS2, OP)          \
> +static inline void                                                  \
> +do_##NAME(void *vd, target_long s1, void *vs2, int i,               \
> +          CPURISCVState *env, int vxrm)                             \
> +{                                                                   \
> +    TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
> +    *((TD *)vd + HD(i)) = OP(env, vxrm, s2, (TX1)(T1)s1);           \
> +}
> +
> +static inline void
> +vext_vx_rm_1(void *vd, void *v0, target_long s1, void *vs2,
> +             CPURISCVState *env,
> +             uint32_t vl, uint32_t vm, uint32_t mlen, int vxrm,
> +             opivx2_rm_fn *fn)
> +{
> +    for (uint32_t i = 0; i < vl; i++) {
> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {
> +            continue;
> +        }
> +        fn(vd, s1, vs2, i, env, vxrm);
> +    }
> +}
> +
> +static inline void
> +vext_vx_rm_2(void *vd, void *v0, target_long s1, void *vs2,
> +             CPURISCVState *env,
> +             uint32_t desc, uint32_t esz, uint32_t dsz,
> +             opivx2_rm_fn *fn, clear_fn *clearfn)
> +{
> +    uint32_t vlmax = vext_maxsz(desc) / esz;
> +    uint32_t mlen = vext_mlen(desc);
> +    uint32_t vm = vext_vm(desc);
> +    uint32_t vl = env->vl;
> +
> +    switch (env->vxrm) {
> +    case 0: /* rnu */
> +        vext_vx_rm_1(vd, v0, s1, vs2,
> +                     env, vl, vm, mlen, 0, fn);
> +        break;
> +    case 1: /* rne */
> +        vext_vx_rm_1(vd, v0, s1, vs2,
> +                     env, vl, vm, mlen, 1, fn);
> +        break;
> +    case 2: /* rdn */
> +        vext_vx_rm_1(vd, v0, s1, vs2,
> +                     env, vl, vm, mlen, 2, fn);
> +        break;
> +    default: /* rod */
> +        vext_vx_rm_1(vd, v0, s1, vs2,
> +                     env, vl, vm, mlen, 3, fn);
> +        break;
> +    }
> +
> +    clearfn(vd, vl, vl * dsz,  vlmax * dsz);
> +}
> +
> +/* generate helpers for fixed point instructions with OPIVX format */
> +#define GEN_VEXT_VX_RM(NAME, ESZ, DSZ, CLEAR_FN)          \
> +void HELPER(NAME)(void *vd, void *v0, target_ulong s1,    \
> +        void *vs2, CPURISCVState *env, uint32_t desc)     \
> +{                                                         \
> +    vext_vx_rm_2(vd, v0, s1, vs2, env, desc, ESZ, DSZ,    \
> +                 do_##NAME, CLEAR_FN);                    \
> +}
> +
> +RVVCALL(OPIVX2_RM, vsaddu_vx_b, OP_UUU_B, H1, H1, saddu8)
> +RVVCALL(OPIVX2_RM, vsaddu_vx_h, OP_UUU_H, H2, H2, saddu16)
> +RVVCALL(OPIVX2_RM, vsaddu_vx_w, OP_UUU_W, H4, H4, saddu32)
> +RVVCALL(OPIVX2_RM, vsaddu_vx_d, OP_UUU_D, H8, H8, saddu64)
> +GEN_VEXT_VX_RM(vsaddu_vx_b, 1, 1, clearb)
> +GEN_VEXT_VX_RM(vsaddu_vx_h, 2, 2, clearh)
> +GEN_VEXT_VX_RM(vsaddu_vx_w, 4, 4, clearl)
> +GEN_VEXT_VX_RM(vsaddu_vx_d, 8, 8, clearq)
> +
> +static inline int8_t sadd8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
> +{
> +    int8_t res = a + b;
> +    if ((res ^ a) & (res ^ b) & INT8_MIN) {
> +        res = a > 0 ? INT8_MAX : INT8_MIN;
> +        env->vxsat = 0x1;
> +    }
> +    return res;
> +}
> +
> +static inline int16_t sadd16(CPURISCVState *env, int vxrm, int16_t a, int16_t b)
> +{
> +    int16_t res = a + b;
> +    if ((res ^ a) & (res ^ b) & INT16_MIN) {
> +        res = a > 0 ? INT16_MAX : INT16_MIN;
> +        env->vxsat = 0x1;
> +    }
> +    return res;
> +}
> +
> +static inline int32_t sadd32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
> +{
> +    int32_t res = a + b;
> +    if ((res ^ a) & (res ^ b) & INT32_MIN) {
> +        res = a > 0 ? INT32_MAX : INT32_MIN;
> +        env->vxsat = 0x1;
> +    }
> +    return res;
> +}
> +
> +static inline int64_t sadd64(CPURISCVState *env, int vxrm, int64_t a, int64_t b)
> +{
> +    int64_t res = a + b;
> +    if ((res ^ a) & (res ^ b) & INT64_MIN) {
> +        res = a > 0 ? INT64_MAX : INT64_MIN;
> +        env->vxsat = 0x1;
> +    }
> +    return res;
> +}
> +
> +RVVCALL(OPIVV2_RM, vsadd_vv_b, OP_SSS_B, H1, H1, H1, sadd8)
> +RVVCALL(OPIVV2_RM, vsadd_vv_h, OP_SSS_H, H2, H2, H2, sadd16)
> +RVVCALL(OPIVV2_RM, vsadd_vv_w, OP_SSS_W, H4, H4, H4, sadd32)
> +RVVCALL(OPIVV2_RM, vsadd_vv_d, OP_SSS_D, H8, H8, H8, sadd64)
> +GEN_VEXT_VV_RM(vsadd_vv_b, 1, 1, clearb)
> +GEN_VEXT_VV_RM(vsadd_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_RM(vsadd_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_RM(vsadd_vv_d, 8, 8, clearq)
> +
> +RVVCALL(OPIVX2_RM, vsadd_vx_b, OP_SSS_B, H1, H1, sadd8)
> +RVVCALL(OPIVX2_RM, vsadd_vx_h, OP_SSS_H, H2, H2, sadd16)
> +RVVCALL(OPIVX2_RM, vsadd_vx_w, OP_SSS_W, H4, H4, sadd32)
> +RVVCALL(OPIVX2_RM, vsadd_vx_d, OP_SSS_D, H8, H8, sadd64)
> +GEN_VEXT_VX_RM(vsadd_vx_b, 1, 1, clearb)
> +GEN_VEXT_VX_RM(vsadd_vx_h, 2, 2, clearh)
> +GEN_VEXT_VX_RM(vsadd_vx_w, 4, 4, clearl)
> +GEN_VEXT_VX_RM(vsadd_vx_d, 8, 8, clearq)
> +
> +static inline uint8_t ssubu8(CPURISCVState *env, int vxrm, uint8_t a, uint8_t b)
> +{
> +    uint8_t res = a - b;
> +    if (res > a) {
> +        res = 0;
> +        env->vxsat = 0x1;
> +    }
> +    return res;
> +}
> +
> +static inline uint16_t ssubu16(CPURISCVState *env, int vxrm, uint16_t a,
> +                               uint16_t b)
> +{
> +    uint16_t res = a - b;
> +    if (res > a) {
> +        res = 0;
> +        env->vxsat = 0x1;
> +    }
> +    return res;
> +}
> +
> +static inline uint32_t ssubu32(CPURISCVState *env, int vxrm, uint32_t a,
> +                               uint32_t b)
> +{
> +    uint32_t res = a - b;
> +    if (res > a) {
> +        res = 0;
> +        env->vxsat = 0x1;
> +    }
> +    return res;
> +}
> +
> +static inline uint64_t ssubu64(CPURISCVState *env, int vxrm, uint64_t a,
> +                               uint64_t b)
> +{
> +    uint64_t res = a - b;
> +    if (res > a) {
> +        res = 0;
> +        env->vxsat = 0x1;
> +    }
> +    return res;
> +}
> +
> +RVVCALL(OPIVV2_RM, vssubu_vv_b, OP_UUU_B, H1, H1, H1, ssubu8)
> +RVVCALL(OPIVV2_RM, vssubu_vv_h, OP_UUU_H, H2, H2, H2, ssubu16)
> +RVVCALL(OPIVV2_RM, vssubu_vv_w, OP_UUU_W, H4, H4, H4, ssubu32)
> +RVVCALL(OPIVV2_RM, vssubu_vv_d, OP_UUU_D, H8, H8, H8, ssubu64)
> +GEN_VEXT_VV_RM(vssubu_vv_b, 1, 1, clearb)
> +GEN_VEXT_VV_RM(vssubu_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_RM(vssubu_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_RM(vssubu_vv_d, 8, 8, clearq)
> +
> +RVVCALL(OPIVX2_RM, vssubu_vx_b, OP_UUU_B, H1, H1, ssubu8)
> +RVVCALL(OPIVX2_RM, vssubu_vx_h, OP_UUU_H, H2, H2, ssubu16)
> +RVVCALL(OPIVX2_RM, vssubu_vx_w, OP_UUU_W, H4, H4, ssubu32)
> +RVVCALL(OPIVX2_RM, vssubu_vx_d, OP_UUU_D, H8, H8, ssubu64)
> +GEN_VEXT_VX_RM(vssubu_vx_b, 1, 1, clearb)
> +GEN_VEXT_VX_RM(vssubu_vx_h, 2, 2, clearh)
> +GEN_VEXT_VX_RM(vssubu_vx_w, 4, 4, clearl)
> +GEN_VEXT_VX_RM(vssubu_vx_d, 8, 8, clearq)
> +
> +static inline int8_t ssub8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
> +{
> +    int8_t res = a - b;
> +    if ((res ^ a) & (a ^ b) & INT8_MIN) {
> +        res = a > 0 ? INT8_MAX : INT8_MIN;
> +        env->vxsat = 0x1;
> +    }
> +    return res;
> +}
> +
> +static inline int16_t ssub16(CPURISCVState *env, int vxrm, int16_t a, int16_t b)
> +{
> +    int16_t res = a - b;
> +    if ((res ^ a) & (a ^ b) & INT16_MIN) {
> +        res = a > 0 ? INT16_MAX : INT16_MIN;
> +        env->vxsat = 0x1;
> +    }
> +    return res;
> +}
> +
> +static inline int32_t ssub32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
> +{
> +    int32_t res = a - b;
> +    if ((res ^ a) & (a ^ b) & INT32_MIN) {
> +        res = a > 0 ? INT32_MAX : INT32_MIN;
> +        env->vxsat = 0x1;
> +    }
> +    return res;
> +}
> +
> +static inline int64_t ssub64(CPURISCVState *env, int vxrm, int64_t a, int64_t b)
> +{
> +    int64_t res = a - b;
> +    if ((res ^ a) & (a ^ b) & INT64_MIN) {
> +        res = a > 0 ? INT64_MAX : INT64_MIN;
> +        env->vxsat = 0x1;
> +    }
> +    return res;
> +}
> +
> +RVVCALL(OPIVV2_RM, vssub_vv_b, OP_SSS_B, H1, H1, H1, ssub8)
> +RVVCALL(OPIVV2_RM, vssub_vv_h, OP_SSS_H, H2, H2, H2, ssub16)
> +RVVCALL(OPIVV2_RM, vssub_vv_w, OP_SSS_W, H4, H4, H4, ssub32)
> +RVVCALL(OPIVV2_RM, vssub_vv_d, OP_SSS_D, H8, H8, H8, ssub64)
> +GEN_VEXT_VV_RM(vssub_vv_b, 1, 1, clearb)
> +GEN_VEXT_VV_RM(vssub_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_RM(vssub_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_RM(vssub_vv_d, 8, 8, clearq)
> +
> +RVVCALL(OPIVX2_RM, vssub_vx_b, OP_SSS_B, H1, H1, ssub8)
> +RVVCALL(OPIVX2_RM, vssub_vx_h, OP_SSS_H, H2, H2, ssub16)
> +RVVCALL(OPIVX2_RM, vssub_vx_w, OP_SSS_W, H4, H4, ssub32)
> +RVVCALL(OPIVX2_RM, vssub_vx_d, OP_SSS_D, H8, H8, ssub64)
> +GEN_VEXT_VX_RM(vssub_vx_b, 1, 1, clearb)
> +GEN_VEXT_VX_RM(vssub_vx_h, 2, 2, clearh)
> +GEN_VEXT_VX_RM(vssub_vx_w, 4, 4, clearl)
> +GEN_VEXT_VX_RM(vssub_vx_d, 8, 8, clearq)
> --
> 2.23.0
>

