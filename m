Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F5CC00523
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 23:41:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F1E21835
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 23:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MMPXUzHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F1E21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inWZo-0001WW-Gv
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 18:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1inWZA-0000zZ-Hw
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 18:41:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1inWZ8-00089B-Sl
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 18:41:16 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:35250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1inWZ8-00086q-KE
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 18:41:14 -0500
Received: by mail-pj1-x1042.google.com with SMTP id s7so5287230pjc.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 15:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ckqU1DFkeXaBLh1Z/pUX3jG28tYO74vwqFpUuM0oUPI=;
 b=MMPXUzHcV4YqKt4NsyowW2cxQapjVsNi3+ENUK4kbWqN8OcdKKT9tgj8LTl/8epkNA
 XcNtYdUxJQ1BWGZbFgmGTGBbqI0miIEGPZ9k0MRHjZqZJVM9t+kdEW0GVEI7Ut6RUpEG
 vSB6rQ0JSJB5+RysNISpaq44pLC9ZyaiZd+F8zzBSVbNL7r6sbn6zTKBnjmhSSiJQU5x
 sezIyY3Ha4kY0SMJo2pafbZww+HD7UM/fVAYZbh+JlADXLB+xJQGxez5JJujmwmvJNu9
 b3Gys0HLRvOYFd7Q25F8VwGZpg4x3LJ9ZlhxQdCJoSP/6GjS984HxpCqrALzecWuTOLO
 eSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ckqU1DFkeXaBLh1Z/pUX3jG28tYO74vwqFpUuM0oUPI=;
 b=rqlO5tBfjYZoKjV1A2FFuzzQZhbZWZi2NwLVCdPWLHIpmY9k1FUCq5hLYzOWhWFr8p
 5o/Fopx9vt7lwOJO6BYE+kZgp8Bv4PWuG5nJgmUETXZN/k1mlG3LU/u4OIzloH3W1cLG
 HDNZ8aHyOWWINQ7EIITHIMpKcyL4ZnVRTHrVVR3qlSxZo9lXZy5t/0/EUMchuQwjYybv
 bWQcL1EwSSyj+FrIcBXyUNXCQyb8uK8hRTdqKQQob86jVy5ewIBsmY/jPhcDPhX4XuRE
 Q/hsQBrfpqkkPa4dNGBfRILr/fRDzDSxY+ZxIDilb+pF26mFLvY2uDxNki57GfEErwtd
 QtfQ==
X-Gm-Message-State: APjAAAXgyFw2gQnKakZal0mAQYXjYmU5dRsvWgStIIvwKOF3aDprUEEH
 rr/I8veBI2+F09gKEWF3/zE3+A==
X-Google-Smtp-Source: APXvYqyjlymtJEtLE3BCFifMnkpdfnxDrbWi0mz0ldwBRhKTrfCpQ/j913/3jVANshTmHoKd/2kfsA==
X-Received: by 2002:a17:90b:147:: with SMTP id
 em7mr30029432pjb.49.1578094873207; 
 Fri, 03 Jan 2020 15:41:13 -0800 (PST)
Received: from [10.103.5.8] (59-100-211-22.bri.static-ipl.aapt.com.au.
 [59.100.211.22])
 by smtp.gmail.com with ESMTPSA id i2sm62440210pgi.94.2020.01.03.15.41.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2020 15:41:12 -0800 (PST)
Subject: Re: [PATCH v3 4/4] RISC-V: add vector extension configure instruction
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200103033347.20909-1-zhiwei_liu@c-sky.com>
 <20200103033347.20909-5-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
X-Enigmail-Draft-Status: N11100
Message-ID: <94fd7ef0-3ee7-d836-3feb-00a8b93ab585@linaro.org>
Date: Sat, 4 Jan 2020 10:41:04 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200103033347.20909-5-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/3/20 2:33 PM, LIU Zhiwei wrote:
> vsetvl and vsetvli are two configure instructions for vl, vtype. TB flags
> should update after configure instructions. The (ill, lmul, sew ) of vtype
> and the bit of (VSTART == 0 && VL == VLMAX) will be placed within tb_flags.
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/Makefile.objs              |  2 +-
>  target/riscv/cpu.c                      |  1 +
>  target/riscv/cpu.h                      | 55 ++++++++++++++++++++-----
>  target/riscv/helper.h                   |  2 +
>  target/riscv/insn32.decode              |  5 +++
>  target/riscv/insn_trans/trans_rvv.inc.c | 52 +++++++++++++++++++++++
>  target/riscv/translate.c                | 17 +++++++-
>  target/riscv/vector_helper.c            | 51 +++++++++++++++++++++++
>  8 files changed, 172 insertions(+), 13 deletions(-)
>  create mode 100644 target/riscv/insn_trans/trans_rvv.inc.c
>  create mode 100644 target/riscv/vector_helper.c
> 
> diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
> index b1c79bc1d1..d577cef9e0 100644
> --- a/target/riscv/Makefile.objs
> +++ b/target/riscv/Makefile.objs
> @@ -1,4 +1,4 @@
> -obj-y += translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o gdbstub.o pmp.o
> +obj-y += translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o vector_helper.o gdbstub.o pmp.o
>  
>  DECODETREE = $(SRC_PATH)/scripts/decodetree.py
>  
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index c2370a0a57..3ff7b50bff 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -347,6 +347,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>          }
>      }
>      if (cpu->cfg.vext_spec) {
> +        env->vext.vtype = ~((target_ulong)-1 >> 1);

Better as FIELD_DP64(0, VTYPE, VILL, 1),


> +struct VTYPE {
> +#ifdef HOST_WORDS_BIGENDIAN
> +    target_ulong vill:1;
> +    target_ulong reserved:sizeof(target_ulong) * 8 - 7;
> +    target_ulong sew:3;
> +    target_ulong lmul:2;
> +#else
> +    target_ulong lmul:2;
> +    target_ulong sew:3;
> +    target_ulong reserved:sizeof(target_ulong) * 8 - 7;
> +    target_ulong vill:1;
> +#endif
> +};

Do not use bit fields to describe target register layout.
Use FIELD().

> -#define TB_FLAGS_MMU_MASK   3
> -#define TB_FLAGS_MSTATUS_FS MSTATUS_FS
> +typedef CPURISCVState CPUArchState;
> +typedef RISCVCPU ArchCPU;
> +#include "exec/cpu-all.h"
> +
> +FIELD(TB_FLAGS, MMU, 0, 2)
> +FIELD(TB_FLAGS, FS, 13, 2)

The change to use FIELD for MMU and FS should be made separately from adding
the vector state.

> +FIELD(TB_FLAGS, VL_EQ_VLMAX, 16, 1)
> +FIELD(TB_FLAGS, LMUL, 17, 2)
> +FIELD(TB_FLAGS, SEW, 19, 3)
> +FIELD(TB_FLAGS, VILL, 22, 1)

Why are you leaving holes in TB_FLAGS?  I know why the original hole was there,
since it corresponded to simple masks on other registers.

> +    vlmax = (1 << vtype->lmul) * cpu->cfg.vlen / (8 * (1 << vtype->sew));

Wow, this can be simplified a lot.

   (1 << LMUL) * VLEN / (8 * (1 << SEW))
 = (VLEN << LMUL) / (8 << SEW)
 = (VLEN << LMUL) >> (SEW + 3)
 = VLEN >> (SEW + 3 - LMUL)


> +    vl_eq_vlmax = (env->vext.vstart == 0) && (vlmax == env->vext.vl);
> +
> +    flags = FIELD_DP32(flags, TB_FLAGS, VILL, vtype->vill);
> +    flags = FIELD_DP32(flags, TB_FLAGS, SEW, vtype->sew);
> +    flags = FIELD_DP32(flags, TB_FLAGS, LMUL, vtype->lmul);
> +    flags = FIELD_DP32(flags, TB_FLAGS, VL_EQ_VLMAX, vl_eq_vlmax);

I wonder if perhaps this all ought to be nested under

  if (env->misa & RVV) {
      ...
  } else {
      flag = FIELD_DP32(flags, TB_FLAGS, VILL, 1);
  }

so that, for the normal case when RVV is disabled, we don't bother computing
all of those bits.

> +static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl * a)
> +{
> +    TCGv s1, s2, d;
> +    d = tcg_temp_new();
> +    s1 = tcg_temp_new();
> +    s2 = tcg_temp_new();
> +    gen_get_gpr(s1, a->rs1);
> +    gen_get_gpr(s2, a->rs2);
> +    gen_helper_vector_vsetvli(d, cpu_env, s1, s2);
> +    tcg_gen_st_tl(d, cpu_env, offsetof(CPURISCVState, vext.vl));

Why are you performing the store to vl inline, as opposed to within the helper
funtion?

> +    exit_tb(ctx);

A normal exit is correct for vsetvl, because the new state is variable.

> +static bool trans_vsetvli(DisasContext *ctx, arg_vsetvli * a)
> +{
> +    TCGv s1, s2, d;
> +    d = tcg_temp_new();
> +    s1 = tcg_temp_new();
> +    s2 = tcg_const_tl(a->zimm);
> +    gen_get_gpr(s1, a->rs1);
> +    gen_helper_vector_vsetvli(d, cpu_env, s1, s2);
> +    tcg_gen_st_tl(d, cpu_env, offsetof(CPURISCVState, vext.vl));
> +    exit_tb(ctx);

You could use

  gen_goto_tb(ctx, 0, ctx->base.pc_next)

here, because the new state is unknown but constant.  It will be the same every
time the instruction is executed, and thus can compute the new state only once,
saving that computation in the link to the next tb.

> +target_ulong VECTOR_HELPER(vsetvli)(CPURISCVState *env, target_ulong s1,
> +    target_ulong s2)
> +{
> +    int vlmax, vl;
> +    RISCVCPU *cpu = env_archcpu(env);
> +    struct VTYPE *vtype = (struct VTYPE *)&s2;

FIELD_EX64 for all uses of VTYPE.

> +
> +    if (vtype->sew > cpu->cfg.elen) { /* only set vill bit. */
> +        env->vext.vtype = ~((target_ulong)-1 >> 1);

FIELD_DP64.

> +    vlmax = (1 << vtype->lmul) * cpu->cfg.vlen / (8 * (1 << vtype->sew));

Same simplification as before.  Perhaps extract this to an inline function for
clarity, documenting the algebraic simplification only once.


r~

