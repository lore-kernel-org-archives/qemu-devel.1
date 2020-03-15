Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17012C2BB1D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 04:40:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE83C20722
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 04:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AGzYGI3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE83C20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDL4n-00040M-Mg
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 00:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDL3n-0003Xj-MX
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 00:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDL3k-0000nJ-Cd
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 00:39:35 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36446)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDL3k-0000j6-4o
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 00:39:32 -0400
Received: by mail-pg1-x544.google.com with SMTP id z4so1770230pgu.3
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 21:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=s16QEYtYuVl6kaAXf8JRCtqdRmKDf7BXnrBkTbNAeTQ=;
 b=AGzYGI3ic4ajQEZ1B8na2tMLl4kLvQ8+lo6nORHBW9zMO4ZDpajsutghfb5RQV0D00
 lDfgK32Xhzqvf8F8J/4Mnti7hn0xSxb8iBVsBIaIElYi9X0UfMUykIR7GdFUCx0VyQuT
 i0KtT54oarTgmRNOO9r7ITIK01BX+zO1iaeQJOFU+rWWb0AsywwI+aNkTQ3ZdTff0ZNA
 FJPON+8bsQhkhHS8WzSME+HkUaW+g9+9cODvTcJkkY1OLdpSDRhndHjA6sZdkH/dtRqT
 NXkpc2vUPMH9AgaCiZi9D/zCKFRIUDa6nvyCxAKjYnvTBBHvZLlyuRInw8Gz5MHbFVWs
 TTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s16QEYtYuVl6kaAXf8JRCtqdRmKDf7BXnrBkTbNAeTQ=;
 b=WSJOvB6em5Y/sVfs6QJ/7x0tWXBVdy1Rca4T0oDKbtPYbH1OiHVGW1uI8TCgWM5weh
 B4iePPI80BukGVvW2Ydw+mqqfJq8EhF84gWFefGauIu2zl86QoKDo/dRsJ4Vga+0mqoW
 VvjJ+7UztAI5IcOYfASEyeulBHnpbLcMrLQW6rCEe17SMicjZXE2jLmX0FKnJKYV03Ei
 2Ti6VE5Y49eegLFKLSLkswkzE+E+JVM6HVAFyeNghDBnlSODRBrubnSvsUxpB8/yZJ6p
 k9XeJv6HqG25YVKneJfBVzwluGFmQEw8okJGUFoBl4PJ/vBescVGJPnwqrIF5G9hQvSz
 6WHQ==
X-Gm-Message-State: ANhLgQ0yRO4fJ8xXmKfj/2HEZ6DKXa6Bcwf1DstHhnRvXKaMJwj7e8lX
 8MtlAIX/djUJFQnPIVVa/uhjUA==
X-Google-Smtp-Source: ADFU+vsHiq4xdcMVfgUEKzSxLlohDFiNX02XS+OvJHI4RFxvPteGb9rfF4m1J0BEv6bdjMKJLgEBGA==
X-Received: by 2002:a62:382:: with SMTP id 124mr21379290pfd.11.1584247170887; 
 Sat, 14 Mar 2020 21:39:30 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 j5sm22554886pfe.32.2020.03.14.21.39.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 21:39:30 -0700 (PDT)
Subject: Re: [PATCH v5 56/60] target/riscv: floating-point scalar move
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-57-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8b9161d1-f64f-5677-70a7-ec197d9d3d43@linaro.org>
Date: Sat, 14 Mar 2020 21:39:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-57-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 7:58 AM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/helper.h                   |  9 +++++
>  target/riscv/insn32.decode              |  2 ++
>  target/riscv/insn_trans/trans_rvv.inc.c | 47 +++++++++++++++++++++++++
>  target/riscv/vector_helper.c            | 36 +++++++++++++++++++
>  4 files changed, 94 insertions(+)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 41cecd266c..7a689a5c07 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1111,3 +1111,12 @@ DEF_HELPER_3(vmv_s_x_b, void, ptr, tl, env)
>  DEF_HELPER_3(vmv_s_x_h, void, ptr, tl, env)
>  DEF_HELPER_3(vmv_s_x_w, void, ptr, tl, env)
>  DEF_HELPER_3(vmv_s_x_d, void, ptr, tl, env)
> +
> +DEF_HELPER_2(vfmv_f_s_b, i64, ptr, env)
> +DEF_HELPER_2(vfmv_f_s_h, i64, ptr, env)
> +DEF_HELPER_2(vfmv_f_s_w, i64, ptr, env)
> +DEF_HELPER_2(vfmv_f_s_d, i64, ptr, env)
> +DEF_HELPER_3(vfmv_s_f_b, void, ptr, i64, env)
> +DEF_HELPER_3(vfmv_s_f_h, void, ptr, i64, env)
> +DEF_HELPER_3(vfmv_s_f_w, void, ptr, i64, env)
> +DEF_HELPER_3(vfmv_s_f_d, void, ptr, i64, env)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 7e1efeec05..bfdce0979c 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -557,6 +557,8 @@ viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
>  vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
>  vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
>  vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
> +vfmv_f_s        001100 1 ..... 00000 001 ..... 1010111 @r2rd
> +vfmv_s_f        001101 1 00000 ..... 101 ..... 1010111 @r2
>  
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index 7720ffecde..99cd45b0aa 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -2269,3 +2269,50 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
>      }
>      return false;
>  }
> +
> +/* Floating-Point Scalar Move Instructions */
> +typedef void (* gen_helper_vfmv_f_s)(TCGv_i64, TCGv_ptr, TCGv_env);
> +static bool trans_vfmv_f_s(DisasContext *s, arg_vfmv_f_s *a)
> +{
> +    if (vext_check_isa_ill(s, RVV)) {
> +        TCGv_ptr src2;
> +        gen_helper_vfmv_f_s fns[4] = {
> +            gen_helper_vfmv_f_s_b, gen_helper_vfmv_f_s_h,
> +            gen_helper_vfmv_f_s_w, gen_helper_vfmv_f_s_d
> +        };
> +
> +        src2 = tcg_temp_new_ptr();
> +        tcg_gen_addi_ptr(src2, cpu_env, vreg_ofs(s, a->rs2));
> +
> +        fns[s->sew](cpu_fpr[a->rd], src2, cpu_env);
> +
> +        tcg_temp_free_ptr(src2);
> +        return true;
> +    }
> +    return false;
> +}

SEW == MO_8 should raise illegal instruction exception.

Need a check for fp enabled.  Presumably

    if (s->mstatus_fs == 0 || !has_ext(s, RVF)) {
        return false;
    }

Need to mark_fs_dirty().

Like integer vmv.x.s, this can be done inline.  The nan-boxing is trivial as well.

For 0.8, we will have to validate the nan-boxing for SEW=MO_64 && !RVD.  That's
still not hard to do inline.



> +
> +typedef void (* gen_helper_vfmv_s_f)(TCGv_ptr, TCGv_i64, TCGv_env);
> +static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
> +{
> +    if (vext_check_isa_ill(s, RVV | RVF) ||
> +        vext_check_isa_ill(s, RVV | RVD)) {
> +        TCGv_ptr dest;
> +        TCGv_i64 src1;
> +        gen_helper_vfmv_s_f fns[4] = {
> +            gen_helper_vfmv_s_f_b, gen_helper_vfmv_s_f_h,
> +            gen_helper_vfmv_s_f_w, gen_helper_vfmv_s_f_d
> +        };
> +
> +        src1 = tcg_temp_new_i64();
> +        dest = tcg_temp_new_ptr();
> +        tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, a->rd));
> +
> +        fns[s->sew](dest, src1, cpu_env);
> +
> +        tcg_temp_free_i64(src1);
> +        tcg_temp_free_ptr(dest);
> +        return true;
> +    }
> +    return false;
> +}

Again, SEW == MO_8 is illegal.  Missing fp enable check.

I don't believe RVD without RVF is legal; you should not need to check for both.

Missing nan-boxing for SEW==MO_64 && FLEN==32 (!RVD).  Which I think should be
done here inline, so that the uint64_t passed to the helper is always correct.


r~

