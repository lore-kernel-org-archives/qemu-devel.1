Return-Path: <SRS0=p7gi=6J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A044EC54FCB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 19:01:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AD4120704
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 19:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b7V1/fI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD4120704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSQ3H-0001av-Ec
	for qemu-devel@archiver.kernel.org; Sat, 25 Apr 2020 15:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jSQ2G-0000nb-Ju
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 15:00:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jSQ2E-0004u6-Vc
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 15:00:20 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:41622)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jSQ2E-0004ri-Dc
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 15:00:18 -0400
Received: by mail-pf1-x431.google.com with SMTP id 18so5305785pfv.8
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2020 12:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2yzfaR388T/3E3RNFSli0kuLnKDuKMC0a1kBW6RqCI8=;
 b=b7V1/fI/lJ/JGuRQq14/Y4EBSfINR3FARzXZrfKfsExg+Cs4V4vrDMAMKH03NSFeNz
 fTIrRKxTWzVzbfeIQ0XgACE/cWUX+Wp2W3+MwWNbB9fATX0QfwcJmikR14lWZNoXAB5+
 wbZkctR1IE5uwFYZyiWKvff7x6aOITXWdZ1L37N3fSRH8mp+aUi3JbHkRn4BoW8bEiyf
 5xGSFdnqSTHx9haoOjLZKZOab5AVYjCKYsWVly032cTdDMDWwhyg65468e+KssuV1RS7
 H0evfo8QjZABofVS2wnuNCxFNwoXzyzZW/TBM0Fg/B/x0r/SM8xdcBdmDcIvHsipynuq
 z9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2yzfaR388T/3E3RNFSli0kuLnKDuKMC0a1kBW6RqCI8=;
 b=VivlICY4lhDsIb+inorzk/NJtMTG59ebZuWfGrXuTgvZ2bhSICxk6sj1KmylbXGmVx
 4aH0/E4wJEWlL7u2A98OxqCfHRljWAHYkP5v3fS3xtRL+8kJ0j7N6HF9FIarAwqflSVM
 Ag1+bxSfeR5TAGYC/mfEEHXu6O3Y1dt58VVb7o98TjhLtK+lnflO/A57C7D/rUaV0HFu
 5uuD7m+h68GgLsFZk4RSRRYuhl2QVJgiY6EhQNOvsIMbwrN/rye3DOs8+V+CPRb9A9Bu
 94aZhuatZu1VR6xV2PC50q+VkUasAMl/4c+HyMhDsVuQ8C2PQa2ndj4Ev46QXpyFkRW4
 5ZjA==
X-Gm-Message-State: AGi0PuaC7uWGlbmm8jWopfFW2veh/woCV4UK0sm3/2/9D6Nc758o+RVe
 fpxaBUQ3voqGLa+6noPDMhNSl2d43cQ=
X-Google-Smtp-Source: APiQypKPpzURBtmOKm/vXpAqNp919a4hbz/eQpoJOyl9oXaceoT5HMq9iu+x552LcwaKS0KdvRzhqw==
X-Received: by 2002:a62:1ccb:: with SMTP id
 c194mr15518912pfc.325.1587841216341; 
 Sat, 25 Apr 2020 12:00:16 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id n34sm2905589pgl.43.2020.04.25.12.00.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Apr 2020 12:00:15 -0700 (PDT)
Subject: Re: ARM SVE issues with non "standard" vector lengths
From: Richard Henderson <richard.henderson@linaro.org>
To: Laurent Desnogues <laurent.desnogues@gmail.com>
References: <CABoDooMSCvi4sxWS-a3cQksD3V5tnHCUbGPsxW69Ou4d1rpQZQ@mail.gmail.com>
 <082800aa-0cab-f331-c9af-2e59f5d5897c@linaro.org>
Message-ID: <f8de973c-96a1-139f-2ba2-6c07a88f790e@linaro.org>
Date: Sat, 25 Apr 2020 12:00:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <082800aa-0cab-f331-c9af-2e59f5d5897c@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::431
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
Cc: qemu-arm <qemu-arm@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/25/20 11:49 AM, Richard Henderson wrote:
> On 4/23/20 6:59 AM, Laurent Desnogues wrote:
>> 2. sve_zip_p
>>
>> This generates extraneous data in the higher part of the result.
>>
>> I hit this when I got a wrong result on an instruction that ends up
>> using sve_cntp which counts all bits set in each 64-bit chunk. There
>> might be some other instructions beyond ZIP that generate extra data
>> that would break sve_cntp.  So perhaps it'd be easier to fix sve_cmtp
>> (and hope that it's the only function that uses bits beyond vector
>> length...).
> 
> I don't see how sve_zip_p can set high bits.  If vl is not a multiple of 512,
> it writes in units of uint16_t.  This cannot produce values outside range.

Bah.  I was looking at zip2 first.  zip1 uses the uint64_t path.
I see the problem now.


r~

