Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B22C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 16:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E9C020863
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 16:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DACrEz6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9C020863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i85AM-0007TV-4T
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 12:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chihmin.chao@sifive.com>) id 1i856z-0004DH-Jy
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 12:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1i856w-0001RU-Ir
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 12:04:53 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:46303)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1i856w-0001R2-Az
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 12:04:50 -0400
Received: by mail-io1-xd43.google.com with SMTP id d17so25150600ios.13
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 09:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NpxJWpS8/LST6Afz5+sKG/0CQ6l7N8dpKlYJAnkHE2s=;
 b=DACrEz6OkERkS6gR2xU5YRmirFivqPY9qFgdMh8ao+EyXzX10TJtMauo+WSrfnP53r
 fdXLxmDIfgwYCN4X0acigDQRV7IyupVQrlySBdb9cUYvd22tnSVk2M/9yzjeggptBK9q
 TtG0ztm874dQM5yvFkYX2lZ3hqm9TGbodXhmSKx3lb/LcQkQRRgS8m4uS31xSlrxqtHp
 2YvvGWzGo0OJdUGKuQNL59qf79IOkJH7hVToztGHxr6PRdDY9vppZrpgch/zec7GCnq3
 Dz5e/z09K8m/1jbTZiiyblWt62n+Qt4Bzda8ePRFMhvUNixUph6q/g1Tjkks/GGIcX1b
 ww6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NpxJWpS8/LST6Afz5+sKG/0CQ6l7N8dpKlYJAnkHE2s=;
 b=JAyQzhRVqogrft22QO7IgV+O/RMdm4BOJKga+VHuoEIWrWUVnxUdfyEekb0NYdkX7a
 xqucYEXTgYtvg9pwa9BuMwlrRAAYweXBldDbYjkbLaYCKGIAeLgxvlwvNSm/TWOKg5Er
 QrVQGzus5SgMsL7ziUavhmBJ6laJ4yAoKu2M5OfK9ufRfKkTCTUJtIAUpnEKP5A3cXkt
 Zt263tjm85gdt0JWsWHhtjDEJqVBraOhnKmUlEKhNdIoxPw8edQgldRt+8JvBQ8zFbzH
 0XbmEPiRiFrEyI3eQO0QS52BJ6yHKHPCLRwKURsojYWK+zBKgmG4D+KCjI4gcR8izTUc
 rA8w==
X-Gm-Message-State: APjAAAVig2J4pMUJxL6QU622MEHgHgY8hQNBUeYb1T/GBDPkhQuz9obG
 vbB/aLwqOHClZrFpyw4B0yNmDv3+W4HDg/nZR7F4hA==
X-Google-Smtp-Source: APXvYqycntMLAPsX39w2VHJ6TCzDl3rB2FHJ96lRCR2v/iJwJwyZF6k6fn/tMOPkVCAeuRAtbepGu73HgjyqcS3ksEQ=
X-Received: by 2002:a5d:9f0f:: with SMTP id q15mr2397000iot.163.1568217889497; 
 Wed, 11 Sep 2019 09:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
 <1568183141-67641-5-git-send-email-zhiwei_liu@c-sky.com>
In-Reply-To: <1568183141-67641-5-git-send-email-zhiwei_liu@c-sky.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Thu, 12 Sep 2019 00:04:38 +0800
Message-ID: <CAEiOBXWsuVeQ82ockYf=Vwqaxfzoc9fin+w3itNZZho2tO+6Mg@mail.gmail.com>
To: liuzhiwei <zhiwei_liu@c-sky.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH v2 04/17] RISC-V: add vector
 extension configure instruction
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
Cc: Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, riku.voipio@iki.fi,
 laurent@vivier.eu, wxy194768@alibaba-inc.com,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wenmeng_zhang@c-sky.com, Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 11, 2019 at 2:38 PM liuzhiwei <zhiwei_liu@c-sky.com> wrote:

> From: LIU Zhiwei <zhiwei_liu@c-sky.com>
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/Makefile.objs              |   2 +-
>  target/riscv/helper.h                   |   3 +
>  target/riscv/insn32.decode              |   5 ++
>  target/riscv/insn_trans/trans_rvv.inc.c |  46 ++++++++++++
>  target/riscv/translate.c                |   1 +
>  target/riscv/vector_helper.c            | 126
> ++++++++++++++++++++++++++++++++
>  6 files changed, 182 insertions(+), 1 deletion(-)
>  create mode 100644 target/riscv/insn_trans/trans_rvv.inc.c
>  create mode 100644 target/riscv/vector_helper.c
>
> diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
> index b1c79bc..d577cef 100644
> --- a/target/riscv/Makefile.objs
> +++ b/target/riscv/Makefile.objs
> @@ -1,4 +1,4 @@
> -obj-y += translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o
> gdbstub.o pmp.o
> +obj-y += translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o
> vector_helper.o gdbstub.o pmp.o
>
>  DECODETREE = $(SRC_PATH)/scripts/decodetree.py
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index debb22a..652f8c3 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -76,3 +76,6 @@ DEF_HELPER_2(mret, tl, env, tl)
>  DEF_HELPER_1(wfi, void, env)
>  DEF_HELPER_1(tlb_flush, void, env)
>  #endif
> +/* Vector functions */
> +DEF_HELPER_4(vector_vsetvli, void, env, i32, i32, i32)
> +DEF_HELPER_4(vector_vsetvl, void, env, i32, i32, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 77f794e..5dc009c 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -62,6 +62,7 @@
>  @r_rm    .......   ..... ..... ... ..... ....... %rs2 %rs1 %rm %rd
>  @r2_rm   .......   ..... ..... ... ..... ....... %rs1 %rm %rd
>  @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
> +@r2_zimm . zimm:11  ..... ... ..... ....... %rs1 %rd
>
>  @sfence_vma ....... ..... .....   ... ..... ....... %rs2 %rs1
>  @sfence_vm  ....... ..... .....   ... ..... ....... %rs1
> @@ -203,3 +204,7 @@ fcvt_w_d   1100001  00000 ..... ... ..... 1010011
> @r2_rm
>  fcvt_wu_d  1100001  00001 ..... ... ..... 1010011 @r2_rm
>  fcvt_d_w   1101001  00000 ..... ... ..... 1010011 @r2_rm
>  fcvt_d_wu  1101001  00001 ..... ... ..... 1010011 @r2_rm
> +
> +# *** RV32V Extension ***
> +vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
> +vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c
> b/target/riscv/insn_trans/trans_rvv.inc.c
> new file mode 100644
> index 0000000..82e7ad6
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -0,0 +1,46 @@
> +/*
> + * RISC-V translation routines for the RVV Standard Extension.
> + *
> + * Copyright (c) 2019 C-SKY Limited. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#define GEN_VECTOR_R(INSN) \
> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a) \
> +{                                                      \
> +    TCGv_i32 s1 = tcg_const_i32(a->rs1);               \
> +    TCGv_i32 s2 = tcg_const_i32(a->rs2);               \
> +    TCGv_i32 d  = tcg_const_i32(a->rd);                \
> +    gen_helper_vector_##INSN(cpu_env, s1, s2, d);    \
> +    tcg_temp_free_i32(s1);                             \
> +    tcg_temp_free_i32(s2);                             \
> +    tcg_temp_free_i32(d);                              \
> +    return true;                                       \
> +}
> +
> +#define GEN_VECTOR_R2_ZIMM(INSN) \
> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a) \
> +{                                                      \
> +    TCGv_i32 s1 = tcg_const_i32(a->rs1);               \
> +    TCGv_i32 zimm = tcg_const_i32(a->zimm);            \
> +    TCGv_i32 d  = tcg_const_i32(a->rd);                \
> +    gen_helper_vector_##INSN(cpu_env, s1, zimm, d);      \
> +    tcg_temp_free_i32(s1);                             \
> +    tcg_temp_free_i32(zimm);                           \
> +    tcg_temp_free_i32(d);                              \
> +    return true;                                       \
> +}
> +
> +GEN_VECTOR_R2_ZIMM(vsetvli)
> +GEN_VECTOR_R(vsetvl)
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 8d6ab73..587c23e 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -706,6 +706,7 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
>  #include "insn_trans/trans_rva.inc.c"
>  #include "insn_trans/trans_rvf.inc.c"
>  #include "insn_trans/trans_rvd.inc.c"
> +#include "insn_trans/trans_rvv.inc.c"
>  #include "insn_trans/trans_privileged.inc.c"
>
>  /*
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> new file mode 100644
> index 0000000..b279e6f
> --- /dev/null
> +++ b/target/riscv/vector_helper.c
> @@ -0,0 +1,126 @@
> +/*
> + * RISC-V Vectore Extension Helpers for QEMU.
> + *
> + * Copyright (c) 2019 C-SKY Limited. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "exec/exec-all.h"
> +#include "exec/helper-proto.h"
> +#include <math.h>
> +
> +#define VECTOR_HELPER(name) HELPER(glue(vector_, name))
> +
> +static inline void vector_vtype_set_ill(CPURISCVState *env)
> +{
> +    env->vfp.vtype = ((target_ulong)1) << (sizeof(target_ulong) - 1);
> +    return;
> +}
> +
>
   env->vfp.vtype = ((target_ulong)1) << (sizeof(target_ulong) * 8 - 1);

> +static inline int vector_vtype_get_sew(CPURISCVState *env)
> +{
> +    return (env->vfp.vtype >> 2) & 0x7;
> +}
> +
>
 extract64(env->vfp.vtype, 2, 3);

> +static inline int vector_get_width(CPURISCVState *env)
> +{
> +    return  8 * (1 << vector_vtype_get_sew(env));
> +}
> +
> +static inline int vector_get_lmul(CPURISCVState *env)
> +{
> +    return 1 << (env->vfp.vtype & 0x3);
> +}
> +
>
 extract64(env->vfp.vtype, 0, 2);

> +static inline int vector_get_vlmax(CPURISCVState *env)
> +{
> +    return vector_get_lmul(env) * VLEN / vector_get_width(env);
> +}
> +
> +void VECTOR_HELPER(vsetvl)(CPURISCVState *env, uint32_t rs1, uint32_t rs2,
> +    uint32_t rd)
> +{
> +    int sew, max_sew, vlmax, vl;
> +
> +    if (rs2 == 0) {
> +        vector_vtype_set_ill(env);
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +        return;
> +    }
> +    env->vfp.vtype = env->gpr[rs2];
> +    sew = 1 << vector_get_width(env) / 8;
> +    max_sew = sizeof(target_ulong);
> +
> +    if (env->misa & RVD) {
> +        max_sew = max_sew > 8 ? max_sew : 8;
> +    } else if (env->misa & RVF) {
> +        max_sew = max_sew > 4 ? max_sew : 4;
> +    }


As far as i understand, max_sew is defined by ELEN but not by existing
floating-point extensions.
ELEN should be configurable through command line cpu parameter.



+    if (sew > max_sew) {
> +        vector_vtype_set_ill(env);
> +        return;
> +    }
> +
> +    vlmax = vector_get_vlmax(env);
> +    if (rs1 == 0) {
> +        vl = vlmax;
> +    } else if (env->gpr[rs1] <= vlmax) {
> +        vl = env->gpr[rs1];
> +    } else if (env->gpr[rs1] < 2 * vlmax) {
> +        vl = ceil(env->gpr[rs1] / 2);
> +    } else {
> +        vl = vlmax;
> +    }
> +    env->vfp.vl = vl;
> +    env->gpr[rd] = vl;
> +    env->vfp.vstart = 0;
> +    return;
> +}
> +
> +void VECTOR_HELPER(vsetvli)(CPURISCVState *env, uint32_t rs1, uint32_t
> zimm,
> +    uint32_t rd)
> +{
> +    int sew, max_sew, vlmax, vl;
> +
> +    env->vfp.vtype = zimm;
> +    sew = vector_get_width(env) / 8;
> +    max_sew = sizeof(target_ulong);
> +
> +    if (env->misa & RVD) {
> +        max_sew = max_sew > 8 ? max_sew : 8;
> +    } else if (env->misa & RVF) {
> +        max_sew = max_sew > 4 ? max_sew : 4;
> +    }
> +    if (sew > max_sew) {
> +        vector_vtype_set_ill(env);
> +        return;
> +    }
> +

The same comment described above.

> +    vlmax = vector_get_vlmax(env);
> +    if (rs1 == 0) {
> +        vl = vlmax;
> +    } else if (env->gpr[rs1] <= vlmax) {
> +        vl = env->gpr[rs1];
> +    } else if (env->gpr[rs1] < 2 * vlmax) {
> +        vl = ceil(env->gpr[rs1] / 2);
> +    } else {
> +        vl = vlmax;
> +    }
> +    env->vfp.vl = vl;
> +    env->gpr[rd] = vl;
> +    env->vfp.vstart = 0;
> +    return;
> +}
> --
> 2.7.4
>
>
>
