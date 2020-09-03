Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84B9C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 19:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86DB320658
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 19:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ccWI29rE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86DB320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDuW7-0007a8-MW
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 15:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDuVI-00072w-0s
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 15:02:36 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46643)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDuVG-0006vo-8r
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 15:02:35 -0400
Received: by mail-pf1-x441.google.com with SMTP id b124so3057731pfg.13
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 12:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IC3vYma4eWF3jzMK863ZK6QzfbnlMC2GNJ0eCbQQry4=;
 b=ccWI29rE5VhZZQMOgbkFGdcMtcerFc9oZCDcnwzuaNXLiyNO2C+fWI3vo9nR1cmVpI
 eGoWqxAKVjI/HT+pD3CjnmYNgaM9TKqjFGliRUFCgmSipNtiFWefkNY59ZFdtnfIe4HL
 +tsyWguGqI/6UY4qpcCb+kkIP8urzBa1UHxBlEK2iYVGhcFB2YwhC1jcyyAqxziqN4m5
 pvgn+XoGVJzHDddOb56wg6ueHMYDgTIamgFAFnPphOKeuWsAZW1Sm7Th8NrPBklX5SWr
 ItJydxFgcZkmkcHZud6glUTDf2adqyYjHh5tS+L91jOt7FmbFxRySWSFEL/9oXCiEY5f
 2xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IC3vYma4eWF3jzMK863ZK6QzfbnlMC2GNJ0eCbQQry4=;
 b=frLapNKAhUUIMeL+1Kr3Z0FY45sAzXJOk5LZ2ZwKlQXK2FKzvLA6uYdq1ht8kPWYNw
 RJTj90oSLuKCueX5adKrWvCn8XZHMRkkp9thw0JRirzHHAFspFtUKTMfkEio6VZq9etw
 sN6SycbSxRvSnjPsl3xbdxFVMTeQMovluQVZzNdKTXurQrdKN46ap1zB5DnWhnlxtyZ4
 fAtufSreqCJywg+ZeulkY8fL/UdZSnVG600upWymt19kH8eUOuzaN3g4Hmmh8GF2y++b
 p/9bE3oM8D6A8YGhwWZvBAa/XbP4lAvlyujjaRoyAjk+34VzsXuvadubfiiRlLLM0i+A
 W6eg==
X-Gm-Message-State: AOAM532oCct/HzBasrs7K356UxcQwZyUAPdudieaax6be4NB9Y5+hTqQ
 LoQw5s9rAFI/i7csG30QXpztGQ==
X-Google-Smtp-Source: ABdhPJxcPQmv+2NKZ6Cop3ln38XAsQ6Sb330F5HQY4ScnpMZqsIRgcu7soQBvaEvJRMfUkYxxgPDdQ==
X-Received: by 2002:a63:4cc:: with SMTP id 195mr4135308pge.376.1599159751851; 
 Thu, 03 Sep 2020 12:02:31 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id h65sm3935647pfb.210.2020.09.03.12.02.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 12:02:30 -0700 (PDT)
Subject: Re: [PATCH v1 2/8] crypto: fix build with gcrypt enabled
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200903112107.27367-1-alex.bennee@linaro.org>
 <20200903112107.27367-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <48499efb-ecbf-a388-4b19-bf6f1ade3a4b@linaro.org>
Date: Thu, 3 Sep 2020 12:02:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903112107.27367-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.403,
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 f4bug@amsat.org, cota@braap.org, stefanha@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 4:21 AM, Alex Bennée wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> If nettle is disabled and gcrypt enabled, the compiler and linker flags
> needed for gcrypt are not passed.
> 
> Gnutls was also not added as a dependancy when gcrypt is enabled.
> 
> Attempting to add the library dependencies at the same time as the
> source dependencies is error prone, as there are alot of different
> rules for picking which sources to use, and some of the source files
> use code level conditionals intead. It is thus clearer to add the
> library dependencies separately.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20200901133050.381844-2-berrange@redhat.com>
> ---
>  configure          |  2 ++
>  crypto/meson.build | 42 +++++++++++++++++++++++++++++++-----------
>  meson.build        |  5 +++++
>  3 files changed, 38 insertions(+), 11 deletions(-)

Tested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

