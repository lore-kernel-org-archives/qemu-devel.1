Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8860C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:40:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E3F6214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+Y0vlQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3F6214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSmdC-0000s8-1j
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 15:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSmbQ-0007sk-P7
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 15:38:24 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSmbP-0003kg-8m
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 15:38:24 -0400
Received: by mail-wr1-x441.google.com with SMTP id n15so447844wrq.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 12:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=H6lvvrTDuJgZ0YqC/VIjAwkVgAq82dCu4R7OrWWmnWw=;
 b=c+Y0vlQXYPG6xTOE219CeqpU4v85D3JldVpP7PEHg3gENhzTxVvleYKupQgHXA9YZe
 4GGxTpPyekziqjSxrh0I+jevqbYOLCCfP9nTZWIbYso1rW4KUisYrzb2uPIRlJ0YBLSw
 v8UGB+7Wzn30WISLhLuiG5K0j59/bu1whLkkJF32xdTrEpTIhM8dEVxqVo9gMvPYDxEM
 ZmIFdYj947xIi6tQbv3iZdQkFdi0QkT191EhzRm77v7ffXY6f2Cd8cm3LVPGNZC4o86+
 o1UDX5UlrOAEL29ldyDLYCn4xaG6e9eKajVR/qVRmxCIiifROrOzvxWVruB77mNvteYn
 qXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H6lvvrTDuJgZ0YqC/VIjAwkVgAq82dCu4R7OrWWmnWw=;
 b=IeQB4LV1qXK4e54nAtxoS6zzu+YmCVu7E1yWmx8x8JKE+Qv3kJd/ilbvptH05wLPQe
 C3/YLO/3AWTAtLe9XhMQdolkOUByY/TiOZE5pu+d31+vidfS8B6DhZ1vf5nDZ9j4DRvB
 TVUVdT0uYzHV1EslplldjK2iNZpywmH/tKBVUOEJzyHxiuW6RbgtfU5SRWH4znr/GpuN
 rkcTPYL3N07xzrlv3+A5Xko4oIndS6nkTrQ+2mFitv+Hk7il2FIT/rM0XfPYuA8KWP6t
 k5FveKFG/dUvkA3tEGvyedbyGkEw/L8ed8n7q5nwHTxgUfhTEAL4hRtCF6hQdft7DbkL
 vCgQ==
X-Gm-Message-State: AOAM532CSx7Gim3nYxK2m/RzCuPyEUm1ouDVUBhKBr6vBBbw78oitNU4
 KJ4ZNxlMf4SD9EAD/vnK438=
X-Google-Smtp-Source: ABdhPJzi+sbAWOHe3sYhjsIRhqhRJtIv/ClICu6hyUTGmfcrX+qNmFLP6kSk+VpcoBJGrawdZeDIMQ==
X-Received: by 2002:adf:e5cb:: with SMTP id a11mr316696wrn.353.1602704302090; 
 Wed, 14 Oct 2020 12:38:22 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id q9sm478721wrd.57.2020.10.14.12.38.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 12:38:21 -0700 (PDT)
Subject: Re: [PATCH] arm/trace: Fix hex printing
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, eric.auger@redhat.com
References: <20201014193355.53074-1-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ff8f8c96-6bea-e326-a72d-788e4203a3cf@amsat.org>
Date: Wed, 14 Oct 2020 21:38:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201014193355.53074-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 9:33 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Use of 0x%d - make up our mind as 0x%x

Uh...

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

(hw/arm/... in subject)

> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   hw/arm/trace-events | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index c8a4d80f6b..a335ee891d 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -41,7 +41,7 @@ smmuv3_get_cd(uint64_t addr) "CD addr: 0x%"PRIx64
>   smmuv3_decode_cd(uint32_t oas) "oas=%d"
>   smmuv3_decode_cd_tt(int i, uint32_t tsz, uint64_t ttb, uint32_t granule_sz, bool had) "TT[%d]:tsz:%d ttb:0x%"PRIx64" granule_sz:%d had:%d"
>   smmuv3_cmdq_cfgi_ste(int streamid) "streamid =%d"
> -smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%d - end=0x%d"
> +smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%x - end=0x%x"
>   smmuv3_cmdq_cfgi_cd(uint32_t sid) "streamid = %d"
>   smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache HIT for sid %d (hits=%d, misses=%d, hit rate=%d)"
>   smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid %d (hits=%d, misses=%d, hit rate=%d)"
> 


