Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D59C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D6121907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K6wFjP0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D6121907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4br-00076N-99
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 18:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iB4Tm-0007gm-8H
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iB4Tk-00073R-2R
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:00:45 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44038)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iB4Ti-00072y-Dx
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:00:42 -0400
Received: by mail-pg1-x541.google.com with SMTP id g3so1053624pgs.11
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 15:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=03E2kG3Ai5vEaanMicRt7GLZNCx3aLawxhWL/88f8ew=;
 b=K6wFjP0Ox0klPIUuZ9AyFRVq0oUT9Z9VWsMEpnVsDkUcViBPle99rgecfsRsJsC7mj
 nVYEiKnw3T5uHNr+pM0kmcAAaXrxRIfv8md8gcTr2rdTN3hgV6DXoT9zQ7HS2yd2qBnt
 ADAJEEDKLT4sC0CtH63UKG+/+myQs4K9FOs5ZOA4dqbj0B0LIe+k4kuoYsdoUhgOVtHY
 j2pju+WHupyTkaaNaJ5rRpDElGxyENIVT2YRmVxopuCYUoSSVl/2YTaPPBpXQA2zqf3c
 I843LGfSROsM9H7LEybcyh75+1j9GC7YrcFZ7SSnXR8Z3Ct8fCG5/a1ermm6gxB1IVRI
 nBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=03E2kG3Ai5vEaanMicRt7GLZNCx3aLawxhWL/88f8ew=;
 b=B8HujVLG/JPPT85elwN1dNjGCLTIJoWol2hOLi8L6kL+RgqJfR1NyTdj3Qlarrp9JN
 uediKC5Ym4fe7Y8qjIyt77Yz1+D1OJlDQs0FOnzI7b8cqa2hyycWz8TNpZ8IeRyEUJjj
 9zMMJ97T85U4E08nOaDaeBNLXSwe7OkGwybu7uVyMMK3wOd8mWiaaIqziUxtK9UbDc6O
 jD9wott9tlGnfqtP0zGLExQwj3ZSHHHwB0cm1KNcCPiqKUuH6+mt8Vw90JAAL1xvUO/D
 RaPX6e7UdCrHT06pbHzHsjnxK0pJ9OOyDeV8ltYpI+NLeAtcTxxkxNfSOFBnWHaSUmT7
 VRnA==
X-Gm-Message-State: APjAAAVIj/dWaGXX4hzl4tRCxyBLsfexmW9BrM0QMcHDOw8xzDNvtZuQ
 1FpI6lrMjie8gPar1vjrh8SD8w==
X-Google-Smtp-Source: APXvYqyFyFD+iPFJSxqTq5fm9iP0QHX8XGsJix/dzYmcckhQ3XSP8vNau7yXvEJZMgSGx8GtyzQb7A==
X-Received: by 2002:a63:ab08:: with SMTP id p8mr11687219pgf.340.1568930441201; 
 Thu, 19 Sep 2019 15:00:41 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id j126sm17817200pfb.186.2019.09.19.15.00.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 19 Sep 2019 15:00:40 -0700 (PDT)
Subject: Re: [PATCH v2 08/16] tests/tcg: re-enable linux-test for ppc64abi32
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190919171015.12681-1-alex.bennee@linaro.org>
 <20190919171015.12681-9-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <994706a0-9aeb-c7bc-a8cc-db0ae5603343@linaro.org>
Date: Thu, 19 Sep 2019 15:00:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919171015.12681-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/19/19 10:10 AM, Alex Bennée wrote:
> diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
> index 6c4a471aeae..e8a1a1495fc 100755
> --- a/tests/tcg/configure.sh
> +++ b/tests/tcg/configure.sh
> @@ -54,6 +54,7 @@ fi
>  : ${cross_cc_cflags_ppc="-m32"}
>  : ${cross_cc_ppc64="powerpc-linux-gnu-gcc"}
>  : ${cross_cc_cflags_ppc64="-m64"}
> +: ${cross_cc_cflags_ppc64abi32="-mcpu=power8"}

I don't see why this is required.  Indeed, ppc64abi32 was much more common when
G4 was the hot cpu of the day.


r~

