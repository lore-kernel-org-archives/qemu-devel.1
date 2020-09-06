Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C22EC433E2
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 02:03:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB35420738
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 02:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b1cEDTQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB35420738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEk1o-0008DH-Lz
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 22:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEk1G-0007n5-Uh
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 22:03:02 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:55700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEk1E-0001xU-Vb
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 22:03:02 -0400
Received: by mail-pj1-x1041.google.com with SMTP id 2so4953283pjx.5
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 19:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HhTWQZ3pU6KdfKoPTW5sOF1zWhexwCqkuxGKLoGbVDk=;
 b=b1cEDTQjGW0qVWnMdILMzF/yL6RMUaX88yTY+P8pasm9aXER2D7YTZQEqFSN2i4l0C
 /to6mTG/VqpWzmByxPocF/D672ozDGENe4xp67k3dIqPU2DoOAuTA4s/cmydqadcx+c6
 pbiiePgqZXi5fcGja2mXQj2hgQm3BXv5p0rAVLEF6++UHS2I6ioMjzNc4oeyjJgDy61J
 Uf6Z2JQaETHmVntnDWE7uSQx464uw3Qsk5MwQnwvmaeeXiytsgMnhZt3UPoFTu1Xon9/
 On41zEe/OOpO+h9yQVnh6jLdwfWNCguF1w/wtEHBqiQwRvM8pNJgqYw3NW6xUJtVywL+
 s9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HhTWQZ3pU6KdfKoPTW5sOF1zWhexwCqkuxGKLoGbVDk=;
 b=PQpfd0jmSlAVUPfqdNecnchbasCtYjj37PYzjQkPFxD+XPOTO5+kEtwmjixbGs9ZsX
 ZV7dbhJwy230lRp3qjMjAsgJ6TJqUKg1+q7KTyxOzMglcUTjEhvjzmi3g4YlLLYV0QcE
 3KjNQc2mGmXYeFVxrcjbHjm8c1ZvCFWjqglc86Vo21Afkkweg8M2qJA0cGKD9ihYLk2C
 lEb7WbT3PKI55XNKk+uWbn+ZSm2vSA+ss0RhLPD0iCQfyJDQTeHZh/2lh0/RgKRTeBUM
 tS5rjFjH86JvnQJUrsbOnqYVhhcbvC52YbMrxR+bEIt2U1sVwNAfJ7c/EyXUGBzoYBTO
 Am/g==
X-Gm-Message-State: AOAM531CAuckNteMJlAt5d6Sb4e2ZIs1WjYx3Yo66Mr6Dk0HudWgdZFx
 f1ZnecO1Uhfpl87eO9bb6DIoVQ==
X-Google-Smtp-Source: ABdhPJwSGyHiAi3o+rzwAU/h3t1BnyyMQGXtnXD/O5++3jOuUrD7SZHG8FV1+VDXyoeypcNDAisA2A==
X-Received: by 2002:a17:90a:fa8b:: with SMTP id
 cu11mr13029850pjb.10.1599357778657; 
 Sat, 05 Sep 2020 19:02:58 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v10sm10334219pff.192.2020.09.05.19.02.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Sep 2020 19:02:57 -0700 (PDT)
Subject: Re: [RFC PATCH] docs/system/deprecated: mark ppc64abi32-linux-user
 for deprecation
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200904165140.10962-1-alex.bennee@linaro.org>
 <CAFEAcA9+hoPrkDNg21b03CT=YmTXuOLwKrornYn6J12bZ=B+OQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b6743c82-4129-5b43-af75-11ade37df303@linaro.org>
Date: Sat, 5 Sep 2020 19:02:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9+hoPrkDNg21b03CT=YmTXuOLwKrornYn6J12bZ=B+OQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "reviewer:Incompatible changes" <libvir-list@redhat.com>,
 Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/20 10:21 AM, Peter Maydell wrote:
> On Fri, 4 Sep 2020 at 17:52, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> It's buggy and we are not sure anyone uses it.
> 
>> +``ppc64abi32`` CPUs (since 5.2.0)
>> +'''''''''''''''''''''''''''''''''
>> +
>> +The ``ppc64abi32`` architecture has a number of issues which regularly
>> +trip up our CI testing and is suspected to be quite broken.
>> +Furthermore the maintainers are unsure what the correct behaviour
>> +should be and strongly suspect no one actually uses it.
> 
> IRC discussion suggests we do know what the correct behaviour
> is -- it should be "what the compat32 interface of a 64-bit
> PPC kernel gives you", it's just that the code doesn't do that
> (and never has?). It's like the mipsn32, mipsn32el, sparc32plus
> ABIs which we also implement (hopefully correctly...)
> 
> But "this has always been broken and nobody complained" is
> a good reason to deprecate anyway.

Indeed.  With the last sentence changed to

"For that reason the maintainers strongly suspect no one actually uses it."

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

