Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AD1C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 21:29:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3EE92082C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 21:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TRagGfuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3EE92082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8ABa-0001rQ-1F
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 17:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i8AAu-0001R4-5Q
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 17:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i8AAt-0008C0-Av
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 17:29:16 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:41131)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i8AAt-0008Bl-62
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 17:29:15 -0400
Received: by mail-qk1-x742.google.com with SMTP id p10so4364474qkg.8
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 14:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kT3nruvKwxbHC0sC8Svchk206ypv3CoeuW4FscKC4wE=;
 b=TRagGfuOC3DE79iJua5tTB4g9lJh/xnrcx5AxmjH8RGd20ei+vk5PCcnCcd0l/gv8J
 7Eud26WcCOb09LZ4kPf0HzyTJ32FVaj5SOo/ISQaqG81EGCcGOLQgAW+kRXO0BetLRs9
 kqf2SEg1f/iG4W4dCvwwt0RLm+tZ6h+yOSMzRUDN2FfIOKccRr+0urFemnXbjo1e9reb
 p4TAHqC1XAQ4H5iJw7nNRKGGDUwGhvOUYfWknS1U7CsBVSuOXgdorGg10DvGWg8AycNN
 OpumNlihyMmaj1z39R+6T/5fv4QI9jQgiEv2EqKjxa0fPFnweuPL7pV1xBQ1TLFa8dfa
 EyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kT3nruvKwxbHC0sC8Svchk206ypv3CoeuW4FscKC4wE=;
 b=Je5cX0TbDeB8ire1gcNujLBq2NLfEfTpVgJGAXKLvc9xZZ3kBQ4bqw6lgOq/btOCaH
 /8SVGMPK/90b0Oe2jn+t8o2fEDlu69e0EtDHOSxkoE/vpE1kG8x30ixKJRMKt+n0JK1W
 kAKxySx2RYAHFzBXunN7YRuuj5vKEAk6uUbWXZEI6MkzzKsxPrwzJuojsgZIz/Eo8NzU
 /tFP5Icw90GekKGJAdLcN1npDcsxdLEvLS++GTwySf3xyVGY4BGD5q9ckoURjeovQKOh
 LRj3cRWtABvOLnFa3r4HcYnzsTGUKXPlPwOidw9dJ2OsjtEA07xfkPfkmGZT6czwgi4F
 7srg==
X-Gm-Message-State: APjAAAVlHVMtH1xYufCjFX5FkuMGfgezMT801trmGoTVSgOOxJVkJ6kr
 6o7zlRyPoD5heZyuAZnwSF2peg==
X-Google-Smtp-Source: APXvYqx80lO+DwTaQ0JOSZsRdNbkVe9wpgaKhm6yMIIr4Ln8ixQeVjCfXKExbx7CJwMD+kJ3pmls1A==
X-Received: by 2002:a37:a709:: with SMTP id q9mr36874070qke.135.1568237354710; 
 Wed, 11 Sep 2019 14:29:14 -0700 (PDT)
Received: from [172.20.5.51] ([67.69.50.154])
 by smtp.gmail.com with ESMTPSA id r19sm12384365qte.63.2019.09.11.14.29.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 14:29:14 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190906075750.14791-1-david@redhat.com>
 <20190906075750.14791-22-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a00e2e4f-9f1e-71c3-f501-6b5bc95add87@linaro.org>
Date: Wed, 11 Sep 2019 17:29:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906075750.14791-22-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
Subject: Re: [Qemu-devel] [PATCH v2 21/28] s390x/tcg: XC: Fault-safe handling
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/6/19 3:57 AM, David Hildenbrand wrote:
> We can process a maximum of 256 bytes, crossing two pages. While at it,
> increment the length once.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mem_helper.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

