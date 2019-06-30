Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53382C5B57E
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 15:13:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B5C620665
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 15:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sv4cdwIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5C620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhbWd-0008KE-Ci
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 11:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33323)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hhbUy-0006vU-Bj
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 11:12:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hhbUx-0002qw-H1
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 11:12:12 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54177)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hhbUx-0002q0-9e
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 11:12:11 -0400
Received: by mail-wm1-x342.google.com with SMTP id x15so13377454wmj.3
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 08:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/p22dw6KTA+N/JSddeYHFaGB32dW2re/HR95baSWdXk=;
 b=sv4cdwIo0tSXBN3IaAIJSsKEiYssCdwtVWql3QrUyDR9qtv2t9FexoxhczZ4LMVxkK
 62NR64HVBhcEgUKCqULZYcbI4/VYpoRq6sO7+CroDXg4IgR7Pt6Zp3mxUjnOAre6ZX6L
 fG7UXfPvoufzIeWV1awOM+db97fB6ZsJ7FvhIBkPiY88qk+WieSaSVNL/Uw54txR5PWp
 3a+glmIjpIdBjOjel6OEv6eGr6/q4TbORGYiUh+qTQq8/Phcue0ZhPKtAU0hVlLMC69J
 +Wf94o8b+AxWVoWfpH5ScgQcT/MV/9RLnUMEL2X1RCqG9ktV1j4uf/ksO/7eh9+UE8Km
 63Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/p22dw6KTA+N/JSddeYHFaGB32dW2re/HR95baSWdXk=;
 b=JxdRQkL7N5g1crqkr4NNd6w70rQKuIAVT3Nl2RzLOl8dCBIOs+xcP/6OeYfm3z/4I9
 MMu7RVlEv6QwYJcU37/3FElN/jqM6yi2tNeU5SgY98DsGHja0rWK5NFxpdi30OsPX4+b
 cONSkmyN9xhr+mV816dCxmoMW7E4+lhyH3UUCF0JEqPqQ3HRv3X7VBllU9XXE0yU0xDK
 SZSeJPhGTClHgbsXelY8CD08eY6ZgH3Stv7IC8LlaCUoHWheHvovLW3VzWYPN0CYNxaA
 rsrRz0g9ypIl56pFxQd+bwXyNOzgeIQjxF5v4YqdMKtXHV6gvP2Dj80WWvm6+cAXJOdn
 o31g==
X-Gm-Message-State: APjAAAUOku65+lkrUlHNOnbidi6eXKyMI+kPq4f2b+f9d8NGgj7Ok8ei
 jfeOExVCDZmil1CPAOUVFx5H5A==
X-Google-Smtp-Source: APXvYqzpQtons5uXYSUCa8S3PGFV/wr85CDNaMK6zXe4ub5iaJhF8wNgUkbPZXzx1uea3cj1ShXbsA==
X-Received: by 2002:a1c:f515:: with SMTP id t21mr14756330wmh.39.1561907529540; 
 Sun, 30 Jun 2019 08:12:09 -0700 (PDT)
Received: from [192.168.3.43] (93-34-153-63.ip50.fastwebnet.it. [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id q15sm5879452wrr.19.2019.06.30.08.12.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 30 Jun 2019 08:12:08 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190629130017.2973-1-richard.henderson@linaro.org>
 <20190629130017.2973-16-richard.henderson@linaro.org>
 <CAL1e-=ghMjUtEyqKX+s15RcyQp6uQO_hJ_u4RTSJ5ZyPvFnymw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b376dc86-6879-2a72-3261-7fdf06172456@linaro.org>
Date: Sun, 30 Jun 2019 17:12:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=ghMjUtEyqKX+s15RcyQp6uQO_hJ_u4RTSJ5ZyPvFnymw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v6 15/16] tcg/ppc: Update vector support to
 v2.07
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
Cc: mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 amarkovic@wavecomp.com, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/19 3:37 PM, Aleksandar Markovic wrote:
>>  bool have_isa_2_06;
>>  bool have_isa_2_06_vsx;
>> +bool have_isa_2_07_vsx;
> 
> Does this flag indicate support for PowerISA 2.07 or VSX?

VSX & 2.07,

>> +    if (hwcap2 & PPC_FEATURE2_ARCH_2_07) {
>> +        if (hwcap & PPC_FEATURE_HAS_VSX) {
>> +            have_isa_2_07_vsx = true;
>> +        }
>> +    }

Like so.

While it would have been possible to have one single have_isa_vsx, we would
then also have to check a second flag to see which revision.  Therefore I
created these composite flags so that we only have to check one.


r~

