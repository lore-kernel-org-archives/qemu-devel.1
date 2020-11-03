Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BC1C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 19:56:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5439B20E65
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 19:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rDw6X3kl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5439B20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka2PS-0000Ds-3G
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 14:56:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ka2ON-0007S5-Lc
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 14:54:56 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42635)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ka2OK-0001a7-US
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 14:54:54 -0500
Received: by mail-pg1-x543.google.com with SMTP id u4so2708237pgr.9
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 11:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eDD9pZcUv9kiEIg0fEw1tNmd54O+9K55ilcE3Uho19c=;
 b=rDw6X3klCA7RI6u/DqHk0DET2E88CzR9sMM+PkSMPWpYgy4lOQHc7dPN/YJsyqfceq
 wn0i2vpjL+P0MXa3VVgflW4CGgTdCKiTyC7SWpuH+wCriH8SROj0OxIBM5vhJmOC1QBZ
 wFGREQvTy0U0bxGGDH9kl9vKuc9JOlyM3QK0N+qXpbZn1xSIJtPovoCqVWVrmsXeFOj6
 ogatKdMuyqqBp3T+WFeLdw11ntWM+LrluF4yv+praLdL9gPlY5S50tq7gqRp7VrHFhPS
 3RKPs9gevLkiTD7Bwozz3VR9ymivBAjvl6V8R7aUkBtikaBui9bFSWwuHsTToCd26oNM
 hiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eDD9pZcUv9kiEIg0fEw1tNmd54O+9K55ilcE3Uho19c=;
 b=CAOKifxOWC6+j39+EhkcZUs+jdsOKu0Zxxc0xr3sJx4g9IxM9v+N+Ne4L3zPZv8mbS
 PVpq2d9anyWwUw1xA9BLdNr2VprL71ARnyt+GsPOaAfEvcmtljs8bA/cyMS3kxbTM1pu
 iwdGW6Ws1+1ZkLMPLRu1lGRkCs+6I49OhNhxykte/mbvf6apiKdnUuJBmyu579GcPY2x
 t2jn6WcDTR3rIB7rDg68gd05po9OsSKJdG/ZkAkR+I2JuPVp/w4cKh8DfvtxXQJNzXSz
 Spnu2TPjLEMOkALpUs3k7X1/UTSgTDl1KzAzZoKlAVIKiTzjmnZL6q7VEmw+7+k5Me27
 tWWA==
X-Gm-Message-State: AOAM530N/Jg3Khx5gy88YxjK4GxAQ6CdD03DOuuKa8BzlTyl89UaFiyq
 nTJV/s+kXS2+EdBOinvZ/GPtS/KOEcGT4A==
X-Google-Smtp-Source: ABdhPJwbvF9v7eR/xtktT03HT6YxiMSRJxPdGqg8A1zSnpgnB4wksFp45OiqutVvMla7/eSL4vtelQ==
X-Received: by 2002:a17:90a:34cd:: with SMTP id
 m13mr821715pjf.201.1604433291128; 
 Tue, 03 Nov 2020 11:54:51 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id e10sm3558808pfl.162.2020.11.03.11.54.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 11:54:50 -0800 (PST)
Subject: Re: [PATCH 10/14] target/arm: do S1_ptw_translate() before address
 space lookup
To: remi.denis.courmont@huawei.com, qemu-arm@nongnu.org
References: <2172054.ElGaqSPkdT@basile.remlab.net>
 <20201102105802.39332-10-remi.denis.courmont@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8ebcf033-7044-ee14-8b84-3812ff041d5c@linaro.org>
Date: Tue, 3 Nov 2020 11:54:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201102105802.39332-10-remi.denis.courmont@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 2:57 AM, remi.denis.courmont@huawei.com wrote:
> From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> 
> In the secure stage 2 translation regime, the VSTCR.SW and VTCR.NSW
> bits can invert the secure flag for pagetable walks. This patchset
> allows S1_ptw_translate() to change the non-secure bit.
> 
> Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> ---
>  target/arm/helper.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 4c86e4f57c..7c70460e65 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -10403,7 +10403,7 @@ static bool get_level1_table_address(CPUARMState *env, ARMMMUIdx mmu_idx,
>  
>  /* Translate a S1 pagetable walk through S2 if needed.  */
>  static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
> -                               hwaddr addr, MemTxAttrs txattrs,
> +                               hwaddr addr, bool *is_secure,
>                                 ARMMMUFaultInfo *fi)
>  {
>      ARMMMUIdx s2_mmu_idx;
> @@ -10415,6 +10415,9 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
>          int s2prot;
>          int ret;
>          ARMCacheAttrs cacheattrs = {};
> +        MemTxAttrs txattrs = {};
> +
> +        assert(!*is_secure); /* TODO: S-EL2 */


Are you sure that you don't want to pass in txattrs via pointer instead?  This
change by itself looks questionable.  I guess I'll have to look forward to the
other patch...


r~

