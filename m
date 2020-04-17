Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCBFC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 22:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E46C420732
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 22:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCajHX21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46C420732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPZge-0000qX-39
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 18:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jPZfJ-00007v-P6
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 18:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jPZfG-0001js-6M
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 18:40:53 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:36750)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jPZfG-0001iS-1C; Fri, 17 Apr 2020 18:40:50 -0400
Received: by mail-il1-x141.google.com with SMTP id t8so3787734ilj.3;
 Fri, 17 Apr 2020 15:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h42oSFXPhsLmadCN/knTOlx3oag1JQc2lFqM/eLYHuQ=;
 b=LCajHX21c6sdRefuOBqGbjU/CzuXw9auV8ikZL328K68e6DlPp39ntufgzVNgocM6y
 xLqw2A5dLNDXlbtqTRmwvlvqVfijIR8yis+txbJPd6pfuh+iNaQYDca2zyQ1boIPIGgz
 DmyTDG4SHDXIByrZI3wtFA9V2TC/Skf6F0SYWcRbg4XIyCTrX9MV6Nwu6AQF9E0GLl2o
 bsXFaPsZBeKdva4p/ISJQOP+hPwoO29udclZp6ScmCqAyGczOlLlkmFEupgWft8w+Bja
 Kkv+dT/mm9xaGx+F9BHxzRTHaUaj4SbFoZLyUEIKZx9eKP0YHV0uWzrCj7nVdJQuNX7c
 XgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h42oSFXPhsLmadCN/knTOlx3oag1JQc2lFqM/eLYHuQ=;
 b=MZXuW7LQQ8iyTAqaVW+YNAp7i03Jo/3/eOUW5vV/75rW/0ymnZ9159yq4SpjosD636
 OZ7yvxLbaOOOGYg/NPZOJdXSju3apLqAZcI0EwSIvjQJ8Rsmqpkk1+F03UwrRidotvDD
 DG+w4BEMS5JOkTkS/oJVGYSRYMcDfSGz9QxOFjgvblh58xdPrQ5sRyHmlMTg0kxv1G2v
 H8oLouYZKPH9yhTweGe69JAMEosStIwnTXITbheSlJeN8A/O11q47VQX3LVW3EcX3p53
 TrvnGCLUXqcTRMCJ0ssYUh1vbPRvSpTkZnVKwRcLJwvQ1CCGAIc5aa6X/nCSdSu6zM7Y
 zsvQ==
X-Gm-Message-State: AGi0Pubbg7EtxhUSr1DTvbfWA2WBFu0XqPzRRkF0ddL/Q8XREgkzUu95
 ieVwQWBkx6TLHw4rGGVW95g3vX8AWRTN0TocVkc=
X-Google-Smtp-Source: APiQypLVY/TRGdvH7WIcclk9yTEon1s6WoQvCmkqKe9JrrZjIOgkkj/e1ZCNp8OQWwVicHAroZfUdDLKvRe6rNTCBEQ=
X-Received: by 2002:a92:9a5c:: with SMTP id t89mr5536999ili.267.1587163249150; 
 Fri, 17 Apr 2020 15:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200330153633.15298-1-zhiwei_liu@c-sky.com>
 <20200330153633.15298-40-zhiwei_liu@c-sky.com>
In-Reply-To: <20200330153633.15298-40-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Apr 2020 15:32:25 -0700
Message-ID: <CAKmqyKOjxPKkht+FhNN_Ede_Q_zmmLv5yc0KSbvcrdLk-MtShg@mail.gmail.com>
Subject: Re: [PATCH v7 39/61] target/riscv: vector floating-point compare
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::141
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

On Mon, Mar 30, 2020 at 9:55 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   |  37 +++++
>  target/riscv/insn32.decode              |  12 ++
>  target/riscv/insn_trans/trans_rvv.inc.c |  35 +++++
>  target/riscv/vector_helper.c            | 174 ++++++++++++++++++++++++
>  4 files changed, 258 insertions(+)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index d6e7ce57be..bedd4d0114 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -953,3 +953,40 @@ DEF_HELPER_6(vfsgnjn_vf_d, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_6(vfsgnjx_vf_h, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_6(vfsgnjx_vf_w, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_6(vfsgnjx_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> +
> +DEF_HELPER_6(vmfeq_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmfeq_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmfeq_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmfne_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmfne_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmfne_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmflt_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmflt_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmflt_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmfle_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmfle_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmfle_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmfeq_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vmfeq_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vmfeq_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vmfne_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vmfne_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vmfne_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vmflt_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vmflt_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vmflt_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vmfle_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vmfle_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vmfle_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vmfgt_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vmfgt_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vmfgt_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vmfge_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vmfge_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vmfge_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vmford_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmford_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmford_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vmford_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vmford_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vmford_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index ce2f497ed2..b0f1c54d53 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -500,6 +500,18 @@ vfsgnjn_vv      001001 . ..... ..... 001 ..... 1010111 @r_vm
>  vfsgnjn_vf      001001 . ..... ..... 101 ..... 1010111 @r_vm
>  vfsgnjx_vv      001010 . ..... ..... 001 ..... 1010111 @r_vm
>  vfsgnjx_vf      001010 . ..... ..... 101 ..... 1010111 @r_vm
> +vmfeq_vv        011000 . ..... ..... 001 ..... 1010111 @r_vm
> +vmfeq_vf        011000 . ..... ..... 101 ..... 1010111 @r_vm
> +vmfne_vv        011100 . ..... ..... 001 ..... 1010111 @r_vm
> +vmfne_vf        011100 . ..... ..... 101 ..... 1010111 @r_vm
> +vmflt_vv        011011 . ..... ..... 001 ..... 1010111 @r_vm
> +vmflt_vf        011011 . ..... ..... 101 ..... 1010111 @r_vm
> +vmfle_vv        011001 . ..... ..... 001 ..... 1010111 @r_vm
> +vmfle_vf        011001 . ..... ..... 101 ..... 1010111 @r_vm
> +vmfgt_vf        011101 . ..... ..... 101 ..... 1010111 @r_vm
> +vmfge_vf        011111 . ..... ..... 101 ..... 1010111 @r_vm
> +vmford_vv       011010 . ..... ..... 001 ..... 1010111 @r_vm
> +vmford_vf       011010 . ..... ..... 101 ..... 1010111 @r_vm
>
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index 4963004dd4..9d13bb4c79 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -2163,3 +2163,38 @@ GEN_OPFVV_TRANS(vfsgnjx_vv, opfvv_check)
>  GEN_OPFVF_TRANS(vfsgnj_vf, opfvf_check)
>  GEN_OPFVF_TRANS(vfsgnjn_vf, opfvf_check)
>  GEN_OPFVF_TRANS(vfsgnjx_vf, opfvf_check)
> +
> +/* Vector Floating-Point Compare Instructions */
> +static bool opfvv_cmp_check(DisasContext *s, arg_rmrr *a)
> +{
> +    return (vext_check_isa_ill(s) &&
> +            vext_check_reg(s, a->rs2, false) &&
> +            vext_check_reg(s, a->rs1, false) &&
> +            (s->sew != 0) &&
> +            ((vext_check_overlap_group(a->rd, 1, a->rs1, 1 << s->lmul) &&
> +              vext_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul)) ||
> +             (s->lmul == 0)));
> +}
> +
> +GEN_OPFVV_TRANS(vmfeq_vv, opfvv_cmp_check)
> +GEN_OPFVV_TRANS(vmfne_vv, opfvv_cmp_check)
> +GEN_OPFVV_TRANS(vmflt_vv, opfvv_cmp_check)
> +GEN_OPFVV_TRANS(vmfle_vv, opfvv_cmp_check)
> +GEN_OPFVV_TRANS(vmford_vv, opfvv_cmp_check)
> +
> +static bool opfvf_cmp_check(DisasContext *s, arg_rmrr *a)
> +{
> +    return (vext_check_isa_ill(s) &&
> +            vext_check_reg(s, a->rs2, false) &&
> +            (s->sew != 0) &&
> +            (vext_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul) ||
> +             (s->lmul == 0)));
> +}
> +
> +GEN_OPFVF_TRANS(vmfeq_vf, opfvf_cmp_check)
> +GEN_OPFVF_TRANS(vmfne_vf, opfvf_cmp_check)
> +GEN_OPFVF_TRANS(vmflt_vf, opfvf_cmp_check)
> +GEN_OPFVF_TRANS(vmfle_vf, opfvf_cmp_check)
> +GEN_OPFVF_TRANS(vmfgt_vf, opfvf_cmp_check)
> +GEN_OPFVF_TRANS(vmfge_vf, opfvf_cmp_check)
> +GEN_OPFVF_TRANS(vmford_vf, opfvf_cmp_check)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 3f01fdd83c..92227228b7 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -3928,3 +3928,177 @@ RVVCALL(OPFVF2, vfsgnjx_vf_d, OP_UUU_D, H8, H8, fsgnjx64)
>  GEN_VEXT_VF(vfsgnjx_vf_h, 2, 2, clearh)
>  GEN_VEXT_VF(vfsgnjx_vf_w, 4, 4, clearl)
>  GEN_VEXT_VF(vfsgnjx_vf_d, 8, 8, clearq)
> +
> +/* Vector Floating-Point Compare Instructions */
> +#define GEN_VEXT_CMP_VV_ENV(NAME, ETYPE, H, DO_OP)            \
> +void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
> +                  CPURISCVState *env, uint32_t desc)          \
> +{                                                             \
> +    uint32_t mlen = vext_mlen(desc);                          \
> +    uint32_t vm = vext_vm(desc);                              \
> +    uint32_t vl = env->vl;                                    \
> +    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);        \
> +    uint32_t i;                                               \
> +                                                              \
> +    for (i = 0; i < vl; i++) {                                \
> +        ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
> +        ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {            \
> +            continue;                                         \
> +        }                                                     \
> +        vext_set_elem_mask(vd, mlen, i, DO_OP(s2, s1,         \
> +                           &env->fp_status));                 \
> +    }                                                         \
> +    for (; i < vlmax; i++) {                                  \
> +        vext_set_elem_mask(vd, mlen, i, 0);                   \
> +    }                                                         \
> +}
> +
> +static uint8_t float16_eq_quiet(uint16_t a, uint16_t b, float_status *s)
> +{
> +    int compare = float16_compare_quiet(a, b, s);
> +    return compare == float_relation_equal;
> +}
> +
> +GEN_VEXT_CMP_VV_ENV(vmfeq_vv_h, uint16_t, H2, float16_eq_quiet)
> +GEN_VEXT_CMP_VV_ENV(vmfeq_vv_w, uint32_t, H4, float32_eq_quiet)
> +GEN_VEXT_CMP_VV_ENV(vmfeq_vv_d, uint64_t, H8, float64_eq_quiet)
> +
> +#define GEN_VEXT_CMP_VF(NAME, ETYPE, H, DO_OP)                      \
> +void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
> +                  CPURISCVState *env, uint32_t desc)                \
> +{                                                                   \
> +    uint32_t mlen = vext_mlen(desc);                                \
> +    uint32_t vm = vext_vm(desc);                                    \
> +    uint32_t vl = env->vl;                                          \
> +    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);              \
> +    uint32_t i;                                                     \
> +                                                                    \
> +    for (i = 0; i < vl; i++) {                                      \
> +        ETYPE s2 = *((ETYPE *)vs2 + H(i));                          \
> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {                  \
> +            continue;                                               \
> +        }                                                           \
> +        vext_set_elem_mask(vd, mlen, i, DO_OP(s2, (ETYPE)s1,        \
> +                           &env->fp_status));                       \
> +    }                                                               \
> +    for (; i < vlmax; i++) {                                        \
> +        vext_set_elem_mask(vd, mlen, i, 0);                         \
> +    }                                                               \
> +}
> +
> +GEN_VEXT_CMP_VF(vmfeq_vf_h, uint16_t, H2, float16_eq_quiet)
> +GEN_VEXT_CMP_VF(vmfeq_vf_w, uint32_t, H4, float32_eq_quiet)
> +GEN_VEXT_CMP_VF(vmfeq_vf_d, uint64_t, H8, float64_eq_quiet)
> +
> +static uint8_t vmfne16(uint16_t a, uint16_t b, float_status *s)
> +{
> +    int compare = float16_compare_quiet(a, b, s);
> +    return compare != float_relation_equal;
> +}
> +
> +static uint8_t vmfne32(uint32_t a, uint32_t b, float_status *s)
> +{
> +    int compare = float32_compare_quiet(a, b, s);
> +    return compare != float_relation_equal;
> +}
> +
> +static uint8_t vmfne64(uint64_t a, uint64_t b, float_status *s)
> +{
> +    int compare = float64_compare_quiet(a, b, s);
> +    return compare != float_relation_equal;
> +}
> +
> +GEN_VEXT_CMP_VV_ENV(vmfne_vv_h, uint16_t, H2, vmfne16)
> +GEN_VEXT_CMP_VV_ENV(vmfne_vv_w, uint32_t, H4, vmfne32)
> +GEN_VEXT_CMP_VV_ENV(vmfne_vv_d, uint64_t, H8, vmfne64)
> +GEN_VEXT_CMP_VF(vmfne_vf_h, uint16_t, H2, vmfne16)
> +GEN_VEXT_CMP_VF(vmfne_vf_w, uint32_t, H4, vmfne32)
> +GEN_VEXT_CMP_VF(vmfne_vf_d, uint64_t, H8, vmfne64)
> +
> +static uint8_t float16_lt(uint16_t a, uint16_t b, float_status *s)
> +{
> +    int compare = float16_compare(a, b, s);
> +    return compare == float_relation_less;
> +}
> +
> +GEN_VEXT_CMP_VV_ENV(vmflt_vv_h, uint16_t, H2, float16_lt)
> +GEN_VEXT_CMP_VV_ENV(vmflt_vv_w, uint32_t, H4, float32_lt)
> +GEN_VEXT_CMP_VV_ENV(vmflt_vv_d, uint64_t, H8, float64_lt)
> +GEN_VEXT_CMP_VF(vmflt_vf_h, uint16_t, H2, float16_lt)
> +GEN_VEXT_CMP_VF(vmflt_vf_w, uint32_t, H4, float32_lt)
> +GEN_VEXT_CMP_VF(vmflt_vf_d, uint64_t, H8, float64_lt)
> +
> +static uint8_t float16_le(uint16_t a, uint16_t b, float_status *s)
> +{
> +    int compare = float16_compare(a, b, s);
> +    return compare == float_relation_less ||
> +           compare == float_relation_equal;
> +}
> +
> +GEN_VEXT_CMP_VV_ENV(vmfle_vv_h, uint16_t, H2, float16_le)
> +GEN_VEXT_CMP_VV_ENV(vmfle_vv_w, uint32_t, H4, float32_le)
> +GEN_VEXT_CMP_VV_ENV(vmfle_vv_d, uint64_t, H8, float64_le)
> +GEN_VEXT_CMP_VF(vmfle_vf_h, uint16_t, H2, float16_le)
> +GEN_VEXT_CMP_VF(vmfle_vf_w, uint32_t, H4, float32_le)
> +GEN_VEXT_CMP_VF(vmfle_vf_d, uint64_t, H8, float64_le)
> +
> +static uint8_t vmfgt16(uint16_t a, uint16_t b, float_status *s)
> +{
> +    int compare = float16_compare(a, b, s);
> +    return compare == float_relation_greater;
> +}
> +
> +static uint8_t vmfgt32(uint32_t a, uint32_t b, float_status *s)
> +{
> +    int compare = float32_compare(a, b, s);
> +    return compare == float_relation_greater;
> +}
> +
> +static uint8_t vmfgt64(uint64_t a, uint64_t b, float_status *s)
> +{
> +    int compare = float64_compare(a, b, s);
> +    return compare == float_relation_greater;
> +}
> +
> +GEN_VEXT_CMP_VF(vmfgt_vf_h, uint16_t, H2, vmfgt16)
> +GEN_VEXT_CMP_VF(vmfgt_vf_w, uint32_t, H4, vmfgt32)
> +GEN_VEXT_CMP_VF(vmfgt_vf_d, uint64_t, H8, vmfgt64)
> +
> +static uint8_t vmfge16(uint16_t a, uint16_t b, float_status *s)
> +{
> +    int compare = float16_compare(a, b, s);
> +    return compare == float_relation_greater ||
> +           compare == float_relation_equal;
> +}
> +
> +static uint8_t vmfge32(uint32_t a, uint32_t b, float_status *s)
> +{
> +    int compare = float32_compare(a, b, s);
> +    return compare == float_relation_greater ||
> +           compare == float_relation_equal;
> +}
> +
> +static uint8_t vmfge64(uint64_t a, uint64_t b, float_status *s)
> +{
> +    int compare = float64_compare(a, b, s);
> +    return compare == float_relation_greater ||
> +           compare == float_relation_equal;
> +}
> +
> +GEN_VEXT_CMP_VF(vmfge_vf_h, uint16_t, H2, vmfge16)
> +GEN_VEXT_CMP_VF(vmfge_vf_w, uint32_t, H4, vmfge32)
> +GEN_VEXT_CMP_VF(vmfge_vf_d, uint64_t, H8, vmfge64)
> +
> +static uint8_t float16_unordered_quiet(uint16_t a, uint16_t b, float_status *s)
> +{
> +    int compare = float16_compare_quiet(a, b, s);
> +    return compare == float_relation_unordered;
> +}
> +
> +GEN_VEXT_CMP_VV_ENV(vmford_vv_h, uint16_t, H2, !float16_unordered_quiet)
> +GEN_VEXT_CMP_VV_ENV(vmford_vv_w, uint32_t, H4, !float32_unordered_quiet)
> +GEN_VEXT_CMP_VV_ENV(vmford_vv_d, uint64_t, H8, !float64_unordered_quiet)
> +GEN_VEXT_CMP_VF(vmford_vf_h, uint16_t, H2, !float16_unordered_quiet)
> +GEN_VEXT_CMP_VF(vmford_vf_w, uint32_t, H4, !float32_unordered_quiet)
> +GEN_VEXT_CMP_VF(vmford_vf_d, uint64_t, H8, !float64_unordered_quiet)
> --
> 2.23.0
>

