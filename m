Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A04C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 13:22:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2124D206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 13:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xNLnmxNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2124D206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i82Zh-0007uR-89
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 09:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i82Xk-0006BF-6S
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:20:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i82Xj-0006QG-7s
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:20:20 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:46685)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i82Xj-0006Pf-3X
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:20:19 -0400
Received: by mail-qt1-x841.google.com with SMTP id v11so25095202qto.13
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 06:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=C6lRFvOrOa03jxjRsf5KJpQQNXd7FdMtgIb0XAopz4A=;
 b=xNLnmxNH6ysxjICIYRbVJmk86JixJImJ8JssWwm6V1xyTPp7W5JjIUFc3qixjQdW4x
 hr3oM7s2uZ9z868FGPzZklkdaBO7QPSQfJ/ENnM44AW6xlXClI96z8IbrkZQvxnAu/rg
 UXqRrthJGG4bRFXwIM4fvOqx4YdKHv1QV8yKsp1Q6K8o5Zp7oi8dl2RRmgH2xuFpdw1+
 PEA5XCjpsOTHpXWp/JnawS9SuuLBBGqokUmR7/jnaG997/nOhYKgrpWMhg3W/8A+YGbs
 1EzhIZs1QautkvelhhNpvJ65I/Azcvd5wcIBCo4j4jMgOQl9s13OKQMM7BIv1Uh/txZk
 LoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C6lRFvOrOa03jxjRsf5KJpQQNXd7FdMtgIb0XAopz4A=;
 b=MAhNJBULTXm9GxCDaZqll7lKpcq3GGVx7j3SfDJlinHOVyBIfSc6fUJsT3cmFZ8VgA
 dJd8zhbcXjYsK8N7pNvwcv6CiBEWfoOHa54IeZWp25UuDAS2NAkqTww8RituWZFCejxV
 UrzCpwgtQUHqgAeAM4hatBfqfMznOvil+HP8Q2seGZbzORxt54M53C03CI4BZD1mlnPu
 IxIOUS5T9b04t+Z+JvT7YrB4VtdjUyHHuIZqrxib84W1oCXnw/hTTqVg8tndXh7ThzYr
 7wdBBVnLaclRXi+5CGVkU7f6LEbM7ZKN8bUt5gs+3y/u0DUfpbPttNhN1HY5Amt7E6wj
 oopA==
X-Gm-Message-State: APjAAAWgMW5A03l9jv4XOiatR48lBOFmDhzJQDqjCrMvVtObDsx0lH+e
 C56EztjIHiKYGRwUpcCvJqvqlg==
X-Google-Smtp-Source: APXvYqxW00EZbCOWEQn2bR80Qh2CTBWj9Eo1/wFlMkg2nqUtHFnJOYpoEq+K86YHecv+pwLwgltwrw==
X-Received: by 2002:ad4:4bca:: with SMTP id l10mr22677242qvw.139.1568208018267; 
 Wed, 11 Sep 2019 06:20:18 -0700 (PDT)
Received: from [192.168.5.185] (otwaon236nw-grc-01-64-229-69-35.dsl.bell.ca.
 [64.229.69.35])
 by smtp.gmail.com with ESMTPSA id o52sm14326500qtf.56.2019.09.11.06.20.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 06:20:17 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190911014353.5926-1-richard.henderson@linaro.org>
 <20190911014353.5926-3-richard.henderson@linaro.org>
 <500ed763-5c50-0be5-993d-9b8b1b68b932@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1f4aac93-c0ee-0152-4186-c59f9f1191fe@linaro.org>
Date: Wed, 11 Sep 2019 09:20:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <500ed763-5c50-0be5-993d-9b8b1b68b932@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: Re: [Qemu-devel] [PATCH 2/3] cputlb: Replace switches in
 load/store_helper with callback
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
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk, tony.nguyen@bt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/19 9:07 AM, Philippe Mathieu-Daudé wrote:
>>  {
>>      return load_helper(env, addr, oi, retaddr, MO_LEUW, false,
>> -                       full_le_lduw_mmu);
>> +                       full_le_lduw_mmu, direct_lduw_le);
> 
> Why not cast lduw_be_p? (except for direct_ldub).
> 
>       return load_helper(env, addr, oi, retaddr, MO_LEUW, false,
>                        full_le_lduw_mmu, (DirectLoadHelper)lduw_be_p);
> 
> Useful to set breakpoint while debugging?

Because the types in the function signature are different,
and such a cast will cause misbehavior.


r~

