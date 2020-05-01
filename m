Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3CCC4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7A3420857
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UbyLahzf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A3420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUX1y-0006M1-JC
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 10:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUWyi-0003LJ-Tw
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUWwh-0002uc-H0
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:49:24 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33039)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUWwh-0002qU-2L
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:47:19 -0400
Received: by mail-pf1-x444.google.com with SMTP id x77so1682232pfc.0
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 07:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=x3E54y2PVlDhAR4yBul4/Faq9ev2hdo62vxMpqDhulQ=;
 b=UbyLahzfCoLBOt2ZhfYRAwXkEiyW+MRJRNwpmXxNckiAJ1FwACoXgXiQkWn+QnoejI
 4QpsHz6zy1zUBTlv2jrSllhBcRhmRwMpcI3FXyRFMQOM4POze8mhX126x84PaV9R1eT9
 jeeo6H3rFqroVVuuNANo7P2fNjIWV7wD3trNKkzxKqvG+MaaegxSqVorJGQELMqEKlOx
 Ny1XQpuppCEXRfs6lDglYFMieillGk3hueygeRB1eQJ/XfABj/vMTWsZmTVGWdklfBlD
 lYA8E2GqMDwZ4BDKB1Xe3jCVxINH952Eyitw1u3FhBvUQKtuGQ1x1sxDGU0gz5c2Zfa/
 jcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x3E54y2PVlDhAR4yBul4/Faq9ev2hdo62vxMpqDhulQ=;
 b=mVOcQa0Iu8de47hMSkYBAwkDzD+1Bj6bMtvwQVc6JGOhzSWd07yBIodqL3JMeS7AAq
 z3UOXAikVYS33nNehYdXMrqW5abrsq4+amIMT7Z4TSlv+2jyQnChgnv94x3RZNSCCMkm
 AqOK+Z5GiQ/3tgHkSWRhzDKV1KqH3Ql9Cq//fnYU7mg+fLOQR9Cy1gOFlY4e/UcBjUNP
 pYYux1mxdGHOYXkjvofOl5g45e5or+MVyVsoPkXEmM5xwZY56plB3+txYvIKKUvYuau9
 SGc6aNXoR/lttOV0jCdfzM7qn01b30AapbDyIish1F245DZTJRT0gsapB7dqimE56Wzb
 yr0g==
X-Gm-Message-State: AGi0PubWAbFmNQmNbU8/idvKmXxzObx6szW2OsMKm8R+KYZ6b+glHrIz
 qR5/9F0h1yTLeFH7H6c8wR45CQ==
X-Google-Smtp-Source: APiQypI+6Buoijg+bAXNRy4429A/cC+vwuMZjyg0pOyqhIeiSWqXLKZ5W1lgPG17w34MHwSNCcZVow==
X-Received: by 2002:a63:683:: with SMTP id 125mr4343983pgg.45.1588344437691;
 Fri, 01 May 2020 07:47:17 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id c14sm2267622pgb.50.2020.05.01.07.47.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2020 07:47:17 -0700 (PDT)
Subject: Re: [PATCH v1 8/9] tests/tcg: add a multiarch linux-user gdb test
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200430190122.4592-1-alex.bennee@linaro.org>
 <20200430190122.4592-9-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9f767f68-3de4-8185-07a2-efccbfdf5499@linaro.org>
Date: Fri, 1 May 2020 07:47:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430190122.4592-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 12:01 PM, Alex Bennée wrote:
> When the gdbstub code was converted to the new API we missed a few
> snafus in the various guests. Add a simple gdb test script which can
> be used on all our linux-user guests to check for obvious failures.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - use EXTRA_RUNS to queue the tests so as not to break plugins
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


