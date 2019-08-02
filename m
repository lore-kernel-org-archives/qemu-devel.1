Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FA2C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D14E52087E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a2DtwsCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14E52087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htaXS-0008G1-6j
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 12:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39182)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htaX3-0007hg-VI
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htaX3-0008Oi-00
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:35:53 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45115)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htaX2-0008OQ-Oc
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:35:52 -0400
Received: by mail-pf1-x441.google.com with SMTP id r1so36294022pfq.12
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 09:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ofHR5x+bnfIPl+rlR7IwCOhCOElxnwlX0H9IAE/w9mc=;
 b=a2DtwsCJJwkt7EWoz+CCYzpQ9lutYz3w1dyDa04Td3mu/m9GHzswyj/a9jLuXlwJ99
 XTLkx/BOpiRSO2nr7wp5iTI4PHkRHZQFM4+cYWkvw1NXdprMhti7nNKI/KdBEj15Vu5b
 LoIOwnbc1lySiOjIXHObrtZL7drd5wX1WSGhP7h8O4MHziWdnyv5WABIyoz3t1Qorufj
 azFrK1dp34JMhvoGOpzrejcv8aUomGOIEPIza1CY+I6woRm80ES7EUd3ynulZCyYQYmq
 fvDiyf4l3grVvi0HBif2hN/ZW8wtmzl57XUH51CA5Ef+KcMxjgxm+9YbK+TVUghIQ+Mq
 a+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ofHR5x+bnfIPl+rlR7IwCOhCOElxnwlX0H9IAE/w9mc=;
 b=ch+bCW2guX+M77t53uh651AGnYJ8e2Volfc2advGCdkSPGDSdlO+5uJkjKvLCnPZtp
 6iXBHDkBptJG6xIEfLXhzMMZY8sD/w/CWt+yJearXGA2ToRCWnqQXm21mkm0PozrtoqJ
 PtEb8+wm2bQP/+JQKzdsDrndAIAJnWUAT/T1fn5d97Ro4hIPAFhbpbNqe+dAWoeMU5m5
 9S62+/ejx/jolns+zarIimJNJL20xRny/KHD2gIR323CGqOzH/0RfzcC3rdAJDRHhRD8
 QQYqKVmHEfRkkNXTTdPRR7A6uXdaML1EpFxA3G7R+KzNfuvuJakWpNFv2Ky6D0U4xyM+
 ieBA==
X-Gm-Message-State: APjAAAUeYQF9V+alIENCUR6/Fz1pKJOOJqCYgt5+PirUhCzz8rVzHlps
 CZxi72HqSK54VHsbDUHHxhnqlQ==
X-Google-Smtp-Source: APXvYqzuP9aZLLdkCqSTmUzvqjZUlPQNljTGZqcRITtOxAkTUXAFEZvyteTuVwhPNNSd9k0v1rEM0w==
X-Received: by 2002:a62:1c93:: with SMTP id c141mr62500792pfc.9.1564763751885; 
 Fri, 02 Aug 2019 09:35:51 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t7sm7023610pjq.15.2019.08.02.09.35.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 09:35:51 -0700 (PDT)
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20190802122540.26385-1-drjones@redhat.com>
 <20190802122540.26385-8-drjones@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <045c61e9-ab5d-a068-dd54-441a6f864ea7@linaro.org>
Date: Fri, 2 Aug 2019 09:35:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802122540.26385-8-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v3 07/15] target/arm: Allow SVE to be
 disabled via a CPU property
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
Cc: peter.maydell@linaro.org, armbru@redhat.com, eric.auger@redhat.com,
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/2/19 5:25 AM, Andrew Jones wrote:
> Since 97a28b0eeac14 ("target/arm: Allow VFP and Neon to be disabled via
> a CPU property") we can disable the 'max' cpu model's VFP and neon
> features, but there's no way to disable SVE. Add the 'sve=on|off'
> property to give it that flexibility. We also rename
> cpu_max_get/set_sve_vq to cpu_max_get/set_sve_max_vq in order for them
> to follow the typical *_get/set_<property-name> pattern.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  target/arm/cpu.c         |  3 ++-
>  target/arm/cpu64.c       | 42 ++++++++++++++++++++++++++++++++++------
>  target/arm/monitor.c     |  2 +-
>  tests/arm-cpu-features.c |  1 +
>  4 files changed, 40 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

