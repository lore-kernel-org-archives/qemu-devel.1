Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9E1C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 17:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED11820720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 17:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eKxV11pY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED11820720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtwnw-0005CL-1d
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 13:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtwnD-0004ip-IG
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 13:26:35 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:35169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtwnA-0006Yh-Cy
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 13:26:35 -0400
Received: by mail-pj1-x1032.google.com with SMTP id f16so2905347pjt.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 10:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QB6DiqynFawFO7XR6DPmKDqa+G0c6yTUL4HGbuFrEEs=;
 b=eKxV11pYWztgBgXipjYgljUPgbfURUQsmDn9hkj4gHaBDLogjJoNMOqtSsKV4WL4rz
 Jzd37td18xg3R7vD9GYos7+k6Nft76LS27N7+CZX5mqpXCxAHBGdmDaDUTknP1a4llgd
 P6Vs14vOWlQeftws7Yi48SrY0Bl72X4cqwDwyZDuPuXqTd5nf+zBKFBLlZXz2F0rRHz4
 JfN6DKO6BjyOWl26efRwek01c08pnIQ68VFi0oTFGtZsgZNeLGv7uAiGfJJf25D0Tp3j
 nwvZ3KPviBgLSNQhhkCQEn4CecHGBjTZlAG/aF1kjbBqM4g4mcR12XdzWZ58pv0kenUg
 cwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QB6DiqynFawFO7XR6DPmKDqa+G0c6yTUL4HGbuFrEEs=;
 b=r3Pw1GdHvvfiec4KpJxWG9FzQSL0QdNOFTUXYVWvYoHNulo6Q3EOsYivsDneXGMwQD
 DDXY0lifLvEhtnM41TtQRLGs/WHgaWaS8hBH6W6qBWtlYwiC5oCn/+mVHZTuCXUSf8gd
 o2tVsCb06kToF0hDhKesySKx9+w23pUqR4jjReo+MuPaTkBP5FYpt5zaSB3p1QEg0xDe
 anvzfeUHZRYeIFebRVuTLKABU/p8qKSUSDC74/Xpl2folFLtIG8TgrW6s4r9rIBBQl4y
 f/VpdB+WhlOg+PSQV3ia5UjBWSMftoQB9zt5GTefNb39EcS5RYIO0tKslAecC2YHnj5G
 Hz6g==
X-Gm-Message-State: AOAM532iyzilItaU/Z7mBA0NmTk4sIQ0P81PdATEteCXPP46luJr5mDa
 M0Hpxodi6Bi6tMYCkhSF7ALPeg==
X-Google-Smtp-Source: ABdhPJxcBj7dyPDIQGpsLJhSLgiHjlbH2/LPFHVtES76TgxDHtHS8Sk6CmIe6YP8nxncKggtTPJCow==
X-Received: by 2002:a17:902:6194:: with SMTP id
 u20mr61787333plj.333.1594401990677; 
 Fri, 10 Jul 2020 10:26:30 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id t184sm6771331pfd.49.2020.07.10.10.26.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 10:26:29 -0700 (PDT)
Subject: Re: [RFC 07/65] target/riscv: rvv-0.9: add vector context status
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-8-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c4f3a769-c0d3-d965-4216-d31bad2a8206@linaro.org>
Date: Fri, 10 Jul 2020 10:26:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200710104920.13550-8-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 3:48 AM, frank.chang@sifive.com wrote:
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -376,6 +376,7 @@
>  #define MSTATUS_SPP         0x00000100
>  #define MSTATUS_MPP         0x00001800
>  #define MSTATUS_FS          0x00006000
> +#define MSTATUS_VS          0x00000600
>  #define MSTATUS_XS          0x00018000

Please sort VS up below SPP, so that the bits are in order.

> @@ -180,6 +180,7 @@ static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
>          return -1;
>      }
>      env->mstatus |= MSTATUS_FS;
> +    env->mstatus |= MSTATUS_VS;
>  #endif
>      env->frm = (val & FSR_RD) >> FSR_RD_SHIFT;
>      if (vs(env, csrno) >= 0) {

Does rvv 0.9 still have the vector fields in FCSR, or are they only present in
the new VCSR?

> @@ -420,7 +442,7 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
>      mask = MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
>          MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
>          MSTATUS_MPP | MSTATUS_MXR | MSTATUS_TVM | MSTATUS_TSR |
> -        MSTATUS_TW;
> +        MSTATUS_TW | MSTATUS_VS;

Since 0.7.1 does not have the VS field, you might want to force VS to dirty in
the written mstatus.  Correspondingly, you should remove VS from the returned
mstatus in read_mstatus.

You appear to be missing a change to riscv_cpu_swap_hypervisor_regs.

That makes all of the riscv_cpu_vector_enabled checks return true for 0.7.1,
which afaik is correct.

> @@ -245,7 +250,9 @@ static bool ld_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
>      data = FIELD_DP32(data, VDATA, VM, a->vm);
>      data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
>      data = FIELD_DP32(data, VDATA, NF, a->nf);
> -    return ldst_us_trans(a->rd, a->rs1, data, fn, s);
> +    ret = ldst_us_trans(a->rd, a->rs1, data, fn, s);
> +    mark_vs_dirty(s);
> +    return ret;

Just push the mark_vs_dirty call into ldst_us_trans.

> @@ -382,7 +390,9 @@ static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
>      data = FIELD_DP32(data, VDATA, VM, a->vm);
>      data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
>      data = FIELD_DP32(data, VDATA, NF, a->nf);
> -    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
> +    ret  = ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
> +    mark_vs_dirty(s);
> +    return ret;

Likewise.

> @@ -510,7 +521,9 @@ static bool ld_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
>      data = FIELD_DP32(data, VDATA, VM, a->vm);
>      data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
>      data = FIELD_DP32(data, VDATA, NF, a->nf);
> -    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s);
> +    ret = ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s);
> +    mark_vs_dirty(s);
> +    return ret;

Likewise.

> @@ -632,7 +646,9 @@ static bool ldff_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
>      data = FIELD_DP32(data, VDATA, VM, a->vm);
>      data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
>      data = FIELD_DP32(data, VDATA, NF, a->nf);
> -    return ldff_trans(a->rd, a->rs1, data, fn, s);
> +    ret = ldff_trans(a->rd, a->rs1, data, fn, s);
> +    mark_vs_dirty(s);

Likewise.

> @@ -741,7 +758,9 @@ static bool amo_op(DisasContext *s, arg_rwdvm *a, uint8_t seq)
>      data = FIELD_DP32(data, VDATA, VM, a->vm);
>      data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
>      data = FIELD_DP32(data, VDATA, WD, a->wd);
> -    return amo_trans(a->rd, a->rs1, a->rs2, data, fn, s);
> +    ret = amo_trans(a->rd, a->rs1, a->rs2, data, fn, s);
> +    mark_vs_dirty(s);
> +    return ret;

Likewise.

> @@ -911,9 +932,12 @@ do_opivx_gvec(DisasContext *s, arg_rmrr *a, GVecGen2sFn *gvec_fn,
>  
>          tcg_temp_free_i64(src1);
>          tcg_temp_free(tmp);
> +        mark_vs_dirty(s);
>          return true;
>      }
> -    return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s);
> +    ret = opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s);
> +    mark_vs_dirty(s);
> +    return ret;

Likewise.  And more.

> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 9632e79cf3..a806e33301 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -47,6 +47,7 @@ typedef struct DisasContext {
>      bool virt_enabled;
>      uint32_t opcode;
>      uint32_t mstatus_fs;
> +    uint32_t mstatus_vs;

Missing a change to riscv_tr_init_disas_context to initialize this.


r~

