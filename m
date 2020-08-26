Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E5EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:17:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FC62208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kkod/4j1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC62208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAwEl-0008OC-I3
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 10:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAwEB-0007wb-GN
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:16:39 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAwE9-0003cn-Ep
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:16:39 -0400
Received: by mail-pg1-x541.google.com with SMTP id 67so1076034pgd.12
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 07:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IMi4MfHRZ9m9PqRyr2T0Uns27ZnXmEPDYxyqbpjQ0hE=;
 b=Kkod/4j10+Ug1/HRluvUN6sBeeKwW9X6OU3HBQ0rq29f6uq9KdjepDP48+92F1Y/h6
 A3vRURUeoF6fXAYr0kkijAoFM6ay+HA15r9Kr7A237ETlk9pxyYqvvmmDsgPVD/bP12E
 XNiAVXuUStssF9cgTmktnTqax+UmePkkl54PVsMShkoC/+X8qLg7Oa4eIfqopqe4zgs+
 s0+oz0eee8ZYYp5HbK706JYCvrRZxyAKxAy0MT9efytP5NFeek4asV553/EA4Gkk/yy/
 8wRFoHaswC/Nrpd3YWxMWgLAhYCUnL7eZzbWPm2KlEJCEqj51nnvobiUR0z2j8wfwWpv
 8N8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IMi4MfHRZ9m9PqRyr2T0Uns27ZnXmEPDYxyqbpjQ0hE=;
 b=Yd1YZs8j2IoXnOALz7V19HMmtKzO1IBGhFWd+V/47PMFd7fOr4+LLK40OIR3AhgMDS
 t5z6lhjC5oxI61nRiNYAtgUF92l9zuIAzto1vInpG+IihMO4m4bA54wTTOJf8U/vdzh5
 KMfHxQjFxomI8UVNAihu2bNUroaE1lREdYIZNEumMIZlOeux5/V4jrMCdATn4pmKbJLU
 /cHomWk2zxenvxv8Bj8y0ae4ceJV6Gn4uk5zFfZAAazdoZdiD33L1H1IaSuv++AXuV8a
 /LwIdZweef6F/oL349nN1y3JuUbgpqVvBmdjdhRe0LRnmYbNeKTx1VX1RRI6etSsECon
 +HPQ==
X-Gm-Message-State: AOAM532kckrrtUV/elymLehN2d0VsxM7ZP2S8bpmN1Z4f1SvEjndb0R7
 NGUaPZEjTNhVikit+0sajEfRQA==
X-Google-Smtp-Source: ABdhPJwMkxurzR1O8irqAGRHMD60dz5d1F6NrQEmwG8goYvRi1R2zFxlQLvunB1Wvaf0M1fncTMuyg==
X-Received: by 2002:aa7:858c:: with SMTP id w12mr7273660pfn.157.1598451395750; 
 Wed, 26 Aug 2020 07:16:35 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id s17sm2565815pgm.63.2020.08.26.07.16.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2020 07:16:34 -0700 (PDT)
Subject: Re: [RFC PATCH v3 07/34] Hexagon (target/hexagon) scalar core helpers
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-8-git-send-email-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7014720f-eda6-50f9-4594-8510d5745d63@linaro.org>
Date: Wed, 26 Aug 2020 07:16:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597765847-16637-8-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.239,
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
> The majority of helpers are generated.  Define the helper functions needed
> then include the generated file
> 
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>  target/hexagon/helper.h    |  33 ++++
>  target/hexagon/op_helper.c | 368 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 401 insertions(+)
>  create mode 100644 target/hexagon/helper.h
>  create mode 100644 target/hexagon/op_helper.c
> 
> diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
> new file mode 100644
> index 0000000..48b1917
> --- /dev/null
> +++ b/target/hexagon/helper.h
> @@ -0,0 +1,33 @@
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
> +DEF_HELPER_2(raise_exception, noreturn, env, i32)
> +DEF_HELPER_1(debug_start_packet, void, env)
> +DEF_HELPER_3(debug_check_store_width, void, env, int, int)
> +DEF_HELPER_3(debug_commit_end, void, env, int, int)
> +DEF_HELPER_3(merge_inflight_store1s, s32, env, s32, s32)
> +DEF_HELPER_3(merge_inflight_store1u, s32, env, s32, s32)
> +DEF_HELPER_3(merge_inflight_store2s, s32, env, s32, s32)
> +DEF_HELPER_3(merge_inflight_store2u, s32, env, s32, s32)
> +DEF_HELPER_3(merge_inflight_store4s, s32, env, s32, s32)
> +DEF_HELPER_3(merge_inflight_store4u, s32, env, s32, s32)
> +DEF_HELPER_3(merge_inflight_store8u, s64, env, s32, s64)

Please use DEF_HELPER_FLAGS_N when possible.

You should be able to know when

(1) No exceptions are possible, and nothing is touched except the inputs.  In
this case use TCG_CALL_NO_RWG_SE.

(2) No exceptions are possible, and nothing in env is touched for which you
have created a tcg variable in hexagon_translate_init().  In this case use
TCG_CALL_NO_RWG.

(3) Exceptions are possible, and no tcg variables are touched on the
non-exceptional path.  In this case use TCG_CALL_NO_WG.

> +static inline void log_pred_write(CPUHexagonState *env, int pnum,
> +                                  target_ulong val)

You might be better off letting the compiler decide about inlining.

> +/*
> + * Handle mem_noshuf
> + *
> + * This occurs when there is a load that might need data forwarded
> + * from an inflight store in slot 1.  Note that the load and store
> + * might have different sizes, so we can't simply compare the
> + * addresses.  We merge only the bytes that overlap (if any).
> + */
> +static int64_t merge_bytes(CPUHexagonState *env, target_ulong load_addr,
> +                           int64_t load_data, uint32_t load_width)
> +{
> +    /* Don't do anything if slot 1 was cancelled */
> +    const int store_slot = 1;
> +    if (env->slot_cancelled & (1 << store_slot)) {
> +        return load_data;
> +    }
> +
> +    int store_width = env->mem_log_stores[store_slot].width;
> +    target_ulong store_addr = env->mem_log_stores[store_slot].va;
> +    union {
> +        uint8_t bytes[8];
> +        uint32_t data32;
> +        uint64_t data64;
> +    } retdata, storedata;

Red flag here.  This is assuming that the host and the target are both
little-endian.

> +    int bigmask = ((-load_width) & (-store_width));
> +    if ((load_addr & bigmask) != (store_addr & bigmask)) {

Huh?  This doesn't detect overlap.  Counter example:

  load_addr = 0, load_width = 4,
  store_addr = 1, store_width = 1.

  bigmask = -4 & -1 -> -4.

  (0 & -4) != (1 & -4) -> 0 != 1


> +    while ((i < load_width) && (j < store_width)) {
> +        retdata.bytes[i] = storedata.bytes[j];
> +        i++;
> +        j++;
> +    }
> +    return retdata.data64;

This most definitely requires host-endian adjustment.

> +/* Helpful for printing intermediate values within instructions */
> +void HELPER(debug_value)(CPUHexagonState *env, int32_t value)
> +{
> +    HEX_DEBUG_LOG("value = 0x%x\n", value);
> +}
> +
> +void HELPER(debug_value_i64)(CPUHexagonState *env, int64_t value)
> +{
> +    HEX_DEBUG_LOG("value_i64 = 0x%lx\n", value);
> +}

I think we need to lose all of this.
There are other ways to debug TCG.


r~

