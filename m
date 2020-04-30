Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76241C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:43:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 452AC2070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hjl+krql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 452AC2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUE9L-0002oA-BN
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUDmr-00075d-V0
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUDmj-0001PK-Iq
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:19:53 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36711)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUDmj-0001Ir-4W
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:19:45 -0400
Received: by mail-pl1-x642.google.com with SMTP id f15so2567095plr.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=F6g6mEtmbQ9LmExkmTM1p9gOg2bAjlBZQ54zFDHidOA=;
 b=Hjl+krqllC5v3LPYj5sCC4Ub+vGteAp049Xlj3CEJG8NDIlrvu1PSEM7R1cKeF75gP
 dQywNoOvdch8YlgmQQThPdL0PBZdLsTJKwh1w7+g4nlCxQKyrB354gBGTuqh37I/yQml
 yMYL1OMAuiah5F7S6aj2V8B4cPaXq1zvRNHgYE6PPMX/JaTGjUrbl92oB3+AFyS+j7/o
 FZ40dF5nVBccyTaWV5bM1urUoWxi1P/ZvUjxuHtfLQf4SGkmCxbbrG8FpV8aS2ZXHS+N
 +sSVgZxeyvfuLF28cdpfI4CxDdczGEdRfKLeGFo4+gpxbHo8yVGrIpBEfHYMtwizJH5I
 2cDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F6g6mEtmbQ9LmExkmTM1p9gOg2bAjlBZQ54zFDHidOA=;
 b=LWNz3afRGflTngNy3nsaX9bBbhSrcVImfbN4t8bBK/8Oe8KfiAHOc3feDDiYYeor+r
 3o/4hrBlz+AJ0GJRmH/pSOruuJqpVmdogpS+ws67Vp4PJ8NP9TtAFXU1UpWh7nbn/jzQ
 iWM5a6bgRWFZA7LoCDHkmAcQUwcxvvSSxz+YWLR/n+OMoeUkwFUjd/oRF/Rd2dnevmdE
 OSVwIEcx8FvM9ZSMrLb0z2MuuTslagtCOgrgjEMv8CTTB+1ImDgShF7AhaP/ykn8+hOA
 rX6IpZti0fmENvxmaS6+DznIfoNIJWJ7IzehJ1nbS6oz3WP4TCcQPvFA9ifZdJaJQMhK
 wDJA==
X-Gm-Message-State: AGi0PualEHS19I0Wcoa+AjrVyG36cYkT5wbQaAhfc6kXW+Gz7s9gxVb4
 /9frZKDTdobZTrTuCFb/ikD0iA==
X-Google-Smtp-Source: APiQypKt4PzyMNU1dHvU2hkJPvpkHyGGE1OwVnNn6Bqlw+s1SqqiWhrwDLToo/C8fdOIU2dln4dfVQ==
X-Received: by 2002:a17:902:32b:: with SMTP id 40mr249114pld.73.1588270782833; 
 Thu, 30 Apr 2020 11:19:42 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id j6sm384256pfe.134.2020.04.30.11.19.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 11:19:41 -0700 (PDT)
Subject: Re: [PATCH RFC] target/arm: Implement SVE2 bitwise shift immediate
To: Stephen Long <steplong@quicinc.com>, qemu-devel@nongnu.org
References: <20200430162828.13993-1-steplong@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <84356e80-96fb-e0e8-9fd1-a380c375680a@linaro.org>
Date: Thu, 30 Apr 2020 11:19:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430162828.13993-1-steplong@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::642
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

On 4/30/20 9:28 AM, Stephen Long wrote:
> Implements SQSHL/UQSHL, SRSHR/URSHR, and SQSHLU
> 
> Signed-off-by: Stephen Long <steplong@quicinc.com>
> ---
> 
> I'm not too sure about the casting I'm doing willy nilly in the helper
> functions, but I think they should be ok. Also, there might be some avenues
> for optimization when translating similar to asr_zpzi and lsl_zpzi.

No, the optimization would interfere with the saturation.

The casting is ok except for sqshlu.  Negative values should saturate to 0, but
by passing them to the uqshl helper, the inputs get treated as large unsigned
values and saturate to UINT_MAX.  You need to use do_suqrshl_bhs for that.


r~

