Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E210C433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 01:49:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ABBF207BB
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 01:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KtfzVwMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ABBF207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBpzV-0002lP-G8
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 21:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBpyz-0002LF-81
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 21:48:41 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:38886)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBpyx-0003ql-6R
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 21:48:40 -0400
Received: by mail-pj1-x1042.google.com with SMTP id ls14so358967pjb.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 18:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Cpf9yT/AJLDE2lMvgHH5qdWP3debsO1XSq9IFauO0Kw=;
 b=KtfzVwMcskSz6Dm+0Qi4cu2uUCybHpI1/2hZ8bQzninq9oSkpiUh15FPzbmsxKEhIg
 LvJdk7+bgyaK2PzUVr8sYx+MXnfK4uCyuIbmhhBINUVB6vZPcUOO3vlrQr0VeiP7ipVg
 rQcwQWr8UI8fYw14134HndPOhODIxru8JgNgzY4bHfjkXVhUkyo0jwcsK3Ezmy4s0uuM
 Cwnl+BcpffGGrRiwwob5SUNAfnJ3wQBvg4S3GCzydkEWEedn29AtMQTEIJxhbJu+7Z/O
 2efiCxwyIi+1hJZ0vOo7H+dT555z8l2SOV0VRL2QJk6gXQgHeK+IX4qlvOan1DHcYehs
 enog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Cpf9yT/AJLDE2lMvgHH5qdWP3debsO1XSq9IFauO0Kw=;
 b=CtDeSgwe6o4TAn5TVoWZlhEXu0G+AZVITFuHiwEFnH1NPCHPwoF+SmxlyAiYwqyQnN
 FfwuBe3gDaOUkq7dCppkCmDuuEGdgUfbb2qr5ktey0tHeV18QEy0/pfbmtccdOFCNoEk
 XK9EQF7BG1xp8MjO8kOp1ULNiCmLTrGLyIYqfuPX0uFKZbeLE3MmFHN2HG5dcvEvJrrM
 Nkdd4OicMWrtPRip7jznzFZPlc+uaxV5wehKWJ2jYuvGarOveOvUMC69co0jJv7eNyqn
 DSqme7luLrARb5anNwHmFIAsko79WeieuO37DkkdYzTV/ApHQHKu+EknxP82rT5XosC2
 g3vw==
X-Gm-Message-State: AOAM5311/P5pcJOsURLw8uvIiaZK1tAAVer/DiDipoV56P48pNMmRFFr
 NVUBBJQ/x5t7QuooZqVD96rcfA==
X-Google-Smtp-Source: ABdhPJxCYqmadROvsOOmlbYXkbn816NJOH2gX30kRzuRcAAkEB8w4UjYn1ISqEoPxmd47oKhoFVNMw==
X-Received: by 2002:a17:902:c3d3:: with SMTP id
 j19mr1241464plj.15.1598665717395; 
 Fri, 28 Aug 2020 18:48:37 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id t19sm516789pjy.22.2020.08.28.18.48.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 18:48:36 -0700 (PDT)
Subject: Re: [RFC PATCH v3 28/34] Hexagon (target/hexagon) TCG generation
 helpers
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-29-git-send-email-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4c1cefd2-5e45-db8c-ec0f-917fcbbd3376@linaro.org>
Date: Fri, 28 Aug 2020 18:48:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597765847-16637-29-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: ale@rev.ng, riku.voipio@iki.fi, philmd@redhat.com, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 8:50 AM, Taylor Simpson wrote:
> Helpers for reading and writing registers
> Helpers for load-locked/store-conditional
> 
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>  target/hexagon/genptr_helpers.h | 244 ++++++++++++++++++++++++++++++++++++++++
>  target/hexagon/op_helper.c      |  18 +++
>  2 files changed, 262 insertions(+)
>  create mode 100644 target/hexagon/genptr_helpers.h
> 
> diff --git a/target/hexagon/genptr_helpers.h b/target/hexagon/genptr_helpers.h
> new file mode 100644
> index 0000000..ffcb1e3
> --- /dev/null
> +++ b/target/hexagon/genptr_helpers.h
> @@ -0,0 +1,244 @@
> +/*
> + *  Copyright(c) 2019-2020 Qualcomm Innovation Center, Inc. All Rights Reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HEXAGON_GENPTR_HELPERS_H
> +#define HEXAGON_GENPTR_HELPERS_H
> +
> +#include "tcg/tcg.h"
> +
> +static inline TCGv gen_read_reg(TCGv result, int num)
> +{
> +    tcg_gen_mov_tl(result, hex_gpr[num]);
> +    return result;
> +}
> +
> +static inline TCGv gen_read_preg(TCGv pred, uint8_t num)
> +{
> +    tcg_gen_mov_tl(pred, hex_pred[num]);
> +    return pred;
> +}
> +
> +static inline void gen_log_reg_write(int rnum, TCGv val, int slot,
> +                                     int is_predicated)

These are quite large.  Why are they marked inline?

> +        /* Low word */
> +        tcg_gen_extrl_i64_i32(val32, val);
> +        tcg_gen_mov_tl(hex_new_value[rnum], val32);

Why are you extracting into a temporary?
This could be done with

    tcg_gen_extr_i64_i32(hex_new_value[rnum],
                         hex_new_value[rnum + 1], val);

> +static inline void gen_read_p3_0(TCGv control_reg)
> +{
> +    TCGv pval = tcg_temp_new();
> +    int i;
> +    tcg_gen_movi_tl(control_reg, 0);
> +    for (i = NUM_PREGS - 1; i >= 0; i--) {
> +        tcg_gen_shli_tl(control_reg, control_reg, 8);
> +        tcg_gen_andi_tl(pval, hex_pred[i], 0xff);
> +        tcg_gen_or_tl(control_reg, control_reg, pval);

tcg_gen_deposit_tl(control_reg, control_reg,
                   hex_pred[i], i * 8, 8);

> +    for (i = 0; i < NUM_PREGS; i++) {
> +        tcg_gen_andi_tl(pred_val, control_reg, 0xff);
> +        tcg_gen_mov_tl(hex_pred[i], pred_val);
> +        tcg_gen_shri_tl(control_reg, control_reg, 8);

tcg_gen_extract_tl(hex_pred[i], control_reg, i * 8, 8);

> +static inline void log_store32(CPUHexagonState *env, target_ulong addr,
> +                               int32_t val, int width, int slot)
> +{
> +    HEX_DEBUG_LOG("log_store%d(0x%x, %d [0x%x])\n", width, addr, val, val);
> +    env->mem_log_stores[slot].va = addr;
> +    env->mem_log_stores[slot].width = width;
> +    env->mem_log_stores[slot].data32 = val;
> +}
> +
> +static inline void log_store64(CPUHexagonState *env, target_ulong addr,
> +                               int64_t val, int width, int slot)
> +{
> +    HEX_DEBUG_LOG("log_store%d(0x%x, %ld [0x%lx])\n", width, addr, val, val);
> +    env->mem_log_stores[slot].va = addr;
> +    env->mem_log_stores[slot].width = width;
> +    env->mem_log_stores[slot].data64 = val;
> +}

... or fold this re-addition back into where it was accidentally removed.  ;-)


r~

