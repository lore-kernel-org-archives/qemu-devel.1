Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B85FC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF0542071A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUyW1Y0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0542071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYW28-0005w9-PL
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 11:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kYVxa-0000nh-Qt
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:04:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38449)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kYVxZ-0005Qf-5r
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604070295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GAqXPOXuukhZqK51Op/yU86BQwqXYj+LR6xYpLcHoAQ=;
 b=bUyW1Y0bLE8V1F1YtnwctEVgScm5/9wWrzY4CzCFFkISn600wF1KpVvGxzqi4jxrmPpxii
 1OcELXUnUH3N1LUMENlGRbCv0IQsgBC1LeJNyGy32dan1t8vF5UOIr6g1QPDEmV1S5sSmA
 KcXxHrQT0WvnCRsLEhDmRuNZoO0W3S4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-_iL_x7MhMTizw2jEPwWz6A-1; Fri, 30 Oct 2020 11:04:52 -0400
X-MC-Unique: _iL_x7MhMTizw2jEPwWz6A-1
Received: by mail-wr1-f70.google.com with SMTP id e3so2763088wrn.19
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 08:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GAqXPOXuukhZqK51Op/yU86BQwqXYj+LR6xYpLcHoAQ=;
 b=ZhUSpzKQuEqi7eE9y+kySLxNLHuxn9i7b0u3LquJ+miqESsK4knaMpVkTS79qo4/EV
 7vLmJef/lKOg8BU7uWu7SEtWCQ7D8D27KuppHsLm6QA5exQ/p14ifZ4UfmymDBzsfUCH
 xPyXmfQSjG8j20sb7rYc61pQuvEdDU/cZKLtP99kntDqg1zh2yotQUBv2TEmpapO+DNV
 uhi38eNgkqW7reLi8HvF3DXMpNTigy7t6PcRDyI3RvL/KAKHdvaEzJNTtRM0tpZeKIKI
 S9ZJIjlI6HHbzSvZAR3eDj17AwCTQAuiHMtokP//uJqwdTz7m9A8xTL/DsSj9qV929C1
 LQ4A==
X-Gm-Message-State: AOAM533Dcgf3tJuXzH6hwvu0aeMbGI5lPbu5ceHbFHP2i7OHmYgJJ3px
 AIg3G+J7Irt5aaiuFQyrpwjnIED/UqD6kIwZ+x502j6g60EZBhoquwOy7RJrX2dLpglbufdzjHF
 dgjpEzfomfQGOy5U=
X-Received: by 2002:a1c:3c84:: with SMTP id j126mr3229574wma.151.1604070289730; 
 Fri, 30 Oct 2020 08:04:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSKKMNoe2Dzjvk/533kxY1Uw2IFgkKmW7wKnk44aUdPCbkWgTD8GqOQQMGL7Ntr4PJHnhg+Q==
X-Received: by 2002:a1c:3c84:: with SMTP id j126mr3229533wma.151.1604070289422; 
 Fri, 30 Oct 2020 08:04:49 -0700 (PDT)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id j13sm11257191wru.86.2020.10.30.08.04.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2020 08:04:48 -0700 (PDT)
Subject: Re: [PATCH-for-5.2] hw/arm/smmuv3: Fix potential integer overflow
 (CID 1432363)
To: qemu-devel@nongnu.org
References: <20201030144617.1535064-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0d4a12de-95ec-0698-f8c6-8f1b7bd146e2@redhat.com>
Date: Fri, 30 Oct 2020 16:04:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201030144617.1535064-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/30/20 3:46 PM, Philippe Mathieu-Daudé wrote:
> Use the BIT_ULL() macro to ensure we use 64-bit arithmetic.
> This fixes the following Coverity issue (OVERFLOW_BEFORE_WIDEN):
> 
>   CID 1432363 (#1 of 1): Unintentional integer overflow:
> 
>   overflow_before_widen:
>     Potentially overflowing expression 1 << scale with type int
>     (32 bits, signed) is evaluated using 32-bit arithmetic, and
>     then used in a context that expects an expression of type
>     hwaddr (64 bits, unsigned).
> 

Fixes: d52915616c0 ("hw/arm/smmuv3: Get prepared for range invalidation")

> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/arm/smmuv3.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 2017ba7a5a7..22607c37841 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -17,6 +17,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/bitops.h"
>  #include "hw/irq.h"
>  #include "hw/sysbus.h"
>  #include "migration/vmstate.h"
> @@ -864,7 +865,7 @@ static void smmuv3_s1_range_inval(SMMUState *s, Cmd *cmd)
>          scale = CMD_SCALE(cmd);
>          num = CMD_NUM(cmd);
>          ttl = CMD_TTL(cmd);
> -        num_pages = (num + 1) * (1 << (scale));
> +        num_pages = (num + 1) * BIT_ULL(scale);
>      }
>  
>      if (type == SMMU_CMD_TLBI_NH_VA) {
> 


