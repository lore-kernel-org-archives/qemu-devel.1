Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB73C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 19:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51500208B3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 19:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mi2lsQiL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51500208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlHLd-0002y9-M8
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 15:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlHKk-0002RE-KN
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 15:33:22 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45621)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlHKg-00070s-VM
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 15:33:22 -0400
Received: by mail-pf1-x442.google.com with SMTP id a127so9973976pfa.12
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 12:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ORlOaA2PbQqGiX0GiDqPOxc8JkZBiYTofpEQOQjS2Pc=;
 b=mi2lsQiLpyJhhn/qaEgNKoSB4BfygWFLr/iDE48Ht55jhhpX6sqerwyZmQWJzgc0F/
 4YDmpIzzSiGO3ggP3UZP8rwJNNnwJiJwPddqPbuWx8Ee1R+L54XB8uOP1HeCHzZarwwR
 HPgxihUCdtDY03Q93xrrq8/gnoDnoB6xFeEsJcUPJS/Ki8uDKM1+fI9HcXJjMow0Ea6B
 3qHEV4WYqua0tU7Rup9Oxh1Jg2MNYtJ0rmwgFvf6go22pYhYX4dFu9z3mYD/3B2s0pHx
 8CiyV9rMzrOnrKHySWFOGGufA42cpQJcp3eBDf3huCQ+MHfLnwEsz1/Gs3gH8Pm5JaRq
 1qcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ORlOaA2PbQqGiX0GiDqPOxc8JkZBiYTofpEQOQjS2Pc=;
 b=GGcx8s9kEZbL5F9ag34jFrMLA4bW6Ow/3VePBrOibEWnF2cYqg1R82HDcKDdspDvYb
 tcHA7ZeYYGJjofF6KWp+udQxRj3l/XXhkWoyAB5P2Ncx4n4XCl49VSYTmp0F0egViLr1
 GRdGGAnUdEjknSbculSxs7eqU+gd4YCArEyIug8AtcrogUdOral2MYAPp0NxUy8xP8fj
 DHkrYxjwXdvUdcvxLpOWXcozzZARulFEi/cROW/JNO9k3eH1OmAOKR6Ujr3/88rcP2Wh
 X5ni2uK0MuZw04Cr7y8Us+N06KrYExokue9y/OZ35/THz1WbA87oRqz6oZvcudRqKKBw
 Qcug==
X-Gm-Message-State: AOAM533dltydJcPXsIa96PEN2ibAZ/9mpwWePRfXPhQR0DPY07hljcZ6
 XPFvLIjppUcbd1ks6G6RROG+ow==
X-Google-Smtp-Source: ABdhPJwq6FKfrJuPHEnOBX2Nu8+p96fqTbNmjEqJpV8QLXRveZZeV4SIf4eKwU2jYxWN8gZpaQjtog==
X-Received: by 2002:a63:1305:: with SMTP id i5mr3195238pgl.140.1592335997315; 
 Tue, 16 Jun 2020 12:33:17 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id d5sm3207964pjo.20.2020.06.16.12.33.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2020 12:33:16 -0700 (PDT)
Subject: Re: [PATCH RFC v2] target/arm: Implement SVE2 FLOGB
To: Stephen Long <steplong@quicinc.com>, qemu-devel@nongnu.org
References: <20200430191405.21641-1-steplong@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7e1a5f0f-fed1-781b-7c38-7eade05e16f7@linaro.org>
Date: Tue, 16 Jun 2020 12:33:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200430191405.21641-1-steplong@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 12:14 PM, Stephen Long wrote:
> Signed-off-by: Stephen Long <steplong@quicinc.com>
> ---
> 
> I made the changes Richard requested. I took out the status field for
> the helper function.
> 
>  include/fpu/softfloat.h    |  5 +++
>  target/arm/helper-sve.h    |  4 +++
>  target/arm/sve.decode      |  4 +++
>  target/arm/sve_helper.c    | 63 ++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c |  9 ++++++
>  5 files changed, 85 insertions(+)
> 
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index ecb8ba0114..275d138145 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -260,6 +260,11 @@ static inline int float16_is_zero_or_denormal(float16 a)
>      return (float16_val(a) & 0x7c00) == 0;
>  }
>  
> +static inline bool float16_is_normal(float16 a)
> +{
> +    return (((float16_val(a) >> 10) + 1) & 0x1f) >= 2;
> +}

I split this out to its own patch.

> +static int16_t do_float16_logb_as_int(float16 a)
> +{
> +    if (float16_is_normal(a)) {
> +        return extract16(a, 10, 5) - 15;
> +    } else if (float16_is_infinity(a)) {
> +        return INT16_MAX;
> +    } else if (float16_is_any_nan(a) || float16_is_zero(a)) {
> +        return INT16_MIN;
> +    }
> +    // denormal

CODING_STYLE prohibits c++ comments.  Fixed.

> +static bool trans_FLOGB(DisasContext *s, arg_rpr_esz *a)
> +{
> +    static gen_helper_gvec_3 * const fns[] = {
> +        NULL,               gen_helper_flogb_h,
> +        gen_helper_flogb_s, gen_helper_flogb_d
> +    };
> +    return do_sve2_zpz_ool(s, a, fns[a->esz - 1]);

Incorrect subtract in the indexing.  Fixed.

Queued with the above changes.


r~

