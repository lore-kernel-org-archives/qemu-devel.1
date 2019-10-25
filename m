Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93FBCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:46:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC372054F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AttJ5msQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC372054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO6U1-0002Rc-4x
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 16:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iO6Qr-0008D7-24
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iO6Qp-0005XH-EA
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:43:36 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:35991)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iO6Qn-0005WJ-DZ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:43:33 -0400
Received: by mail-yw1-xc42.google.com with SMTP id p187so1324016ywg.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 13:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1AoLQyGuLkp+eXpsYDxzvNdI54xWSSxHc60d5u7DkuI=;
 b=AttJ5msQ6pAa5sHpQDOULZOPAg7P9/ZkxCND3Tl12meoPDrh9r/4hVK9x2MNJqpeUr
 OLpbytW2wyX6u3AzpRtVp4o5j1c798xO4vKoX4MUykvB5d8gpMGZQVCm2+UeszgVIQey
 XzGnJL/H0d/SdslLWKY3jaJ/3KOBaRC1jBsw+yBpEocUV6F4fKBKWS73+HCzbhn5+cGO
 0KjRP4iNjrGDP762OWBaYBnp0DfJOBFmX5qGV/e55Xqg/YIMoJOf0YJ5ZhZyRvP6xwRu
 k0nNZWjMuwkBImHfPPoroHRTT/amUrsMO8w6BmmVTXRfGf6xmEuCzi6GqUuOKPdVen4a
 0jLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1AoLQyGuLkp+eXpsYDxzvNdI54xWSSxHc60d5u7DkuI=;
 b=e8mR93yKJ9wOd/pkIwogxSMvZycuxLrTXm1f7INSy8N2ILeQ9tu9HsdX7MSX1RBRRI
 JQ1pWlOYn9WTn/+w10SMp+7Owl8JfOHvHqgJLw7fbQxb+6rrTO+lU4cPJ7E8NFda9PRH
 svfNQjFV792EI/GGVwTOKPbFtyScM3tIBeFHjDFS6vH8mjZdYndP6pVMAvgvgsqw/3pu
 9U2WlZKjG/3Oo2yd0jreyCdyX76R8O7KUza2opcaHZpdczB4+Q/s9qV2qrg/6ZMrfO+7
 KoiM1Xz29gfbuqRRv8GeQz3JBGJfk6ucwaPHDrM9hwWPqKN7h3oBkv1gNJ2/7VmmTX3N
 cUeg==
X-Gm-Message-State: APjAAAV89H4D3nT3HDaAtIYevwznUv1klffcDBGKLQy7RUqaELMMyNIi
 b/sALl343DAuf7czKVHmrmPzJw==
X-Google-Smtp-Source: APXvYqwR+Iv/NhmfgBuMkcJBFca154H4DIZxSornMfg9bo35Xj/A3HdqMZZF2yXnNng2+06rzmm3jg==
X-Received: by 2002:a81:35c9:: with SMTP id c192mr4120697ywa.57.1572036212428; 
 Fri, 25 Oct 2019 13:43:32 -0700 (PDT)
Received: from [172.20.40.202] ([206.121.8.178])
 by smtp.gmail.com with ESMTPSA id 141sm888114ywg.51.2019.10.25.13.43.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Oct 2019 13:43:31 -0700 (PDT)
Subject: Re: [PATCH v2 4/7] exec: Use const alias for TARGET_PAGE_BITS_VARY
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191023154505.30521-1-richard.henderson@linaro.org>
 <20191023154505.30521-5-richard.henderson@linaro.org>
 <CAFEAcA8unCxb-4E561fnOFd=LCXv1y7YSd9xUb2GAutjcYXeGg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <2d65342e-ed48-1fe6-7e6c-97f51ac21a76@linaro.org>
Date: Fri, 25 Oct 2019 16:43:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8unCxb-4E561fnOFd=LCXv1y7YSd9xUb2GAutjcYXeGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/25/19 10:51 AM, Peter Maydell wrote:
>> + * We want to declare the "target_page" variable as const, which tells
>> + * the compiler that it can cache any value that it reads across calls.
>> + * This avoids multiple assertions and multiple reads within any one user.
>> + *
>> + * This works because we initialize the target_page data very early, in a
>> + * location far removed from the functions that require the final results.
> 
> I have to say that this feels like a worryingly large amount
> of magic. Is this actually guaranteed to work by the compiler?

Yes.


r~

