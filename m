Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22769C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 21:30:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD86B2068F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 21:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jijf/4/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD86B2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ju0bD-0001Xa-1V
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 17:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ju0aJ-0000ey-Fw
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 17:29:31 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46181)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ju0aH-0003Jq-OO
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 17:29:31 -0400
Received: by mail-pf1-x444.google.com with SMTP id i14so3066794pfu.13
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 14:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Mriwhu1oAqjnkDnuHZ53nF1zsvnfS4zpaEp6S1zuV1Y=;
 b=Jijf/4/ZrDjeM7heFGv4fBCDMw4Rwl31jDj6zPbLlXJOmDdQf0YrNt2iMKmKPWyJKK
 sftBN6XpPsYC+ENztg8R1zSjLyuK8NRz2EMI171Ii7KU1+lOKT3FeMS6xHJZbEuSPexI
 WeO80dspsixvQePERLXXKu1xZkzSYpJaEKfDuX2UN70wndnQNWxy/KSC376PW5y8TKeZ
 epX7fRhwla6r44G0a9b4bPWRADF7x7gvXeV3Bg5Osajw0h2JACzBI0b+3WaVI7YuGnNT
 QKR63/VOvksjykBKTgUkiA79xb00W8hEXmjHlz0Bj9FyR0FmwFDKIGfLNDThI5F3qav1
 tEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Mriwhu1oAqjnkDnuHZ53nF1zsvnfS4zpaEp6S1zuV1Y=;
 b=Y7zhI2kdGExmDpzCqmPs6MwDjH1a2WaFTMnQ3aXAJHfjEnoIGnBeNDZatpBFvwKQw1
 y6PNRTm7jSPcFnM3YDYJCH4YXX9xT8sWV8uvFAdhQSSKCs7xKAx2jv4nMGAT8sA+WzQ/
 lFVm94ccC8LL3+TZALsT6lmdSrwJr8i6rw8OAqVQjfzKXtRbD5GLUaoNLtTszy0gQ8at
 uuL/43QV2BTH4+NuB0FsrAwJ2GvLnMUkPu/iXpRUozKeJQMhOtQ4/gwh3gceoKZbzdPM
 FJe4t8vkdw2QxCwOLgDyr8btpGNxODARLhmJ/1b0LEHk9wjj5oyfel+u7jvSY60/kg/E
 eejg==
X-Gm-Message-State: AOAM532M+thdfuIrwrwSrK1oYG4ekIt+d7/OXeDKQPYeDoziDsUr0PsL
 QYQAm+LUEwyGHNY8uRzYXT5Izw==
X-Google-Smtp-Source: ABdhPJzZgKWPaj+/DJSHj+CHPOVjNFs90p588Mi5rrW3RkaTbmTe7WcUdf4EM5Odd6vzclSliCOCcQ==
X-Received: by 2002:a62:7e0d:: with SMTP id z13mr60936625pfc.161.1594416568179; 
 Fri, 10 Jul 2020 14:29:28 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id u73sm7163330pfc.113.2020.07.10.14.29.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 14:29:27 -0700 (PDT)
Subject: Re: [PATCH v1 10/13] tests/plugins: add -Wno-unknown-warning-option
 to handle -Wpsabi
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200709141327.14631-1-alex.bennee@linaro.org>
 <20200709141327.14631-11-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9c736c87-34c7-375c-61b8-954aa70deab5@linaro.org>
Date: Fri, 10 Jul 2020 14:29:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200709141327.14631-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 f4bug@amsat.org, robhenry@microsoft.com, aaron@os.amperecomputing.com,
 cota@braap.org, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 7:13 AM, Alex Bennée wrote:
> Not all compilers support the -Wpsabi (clang-9 in my case).
> 
> Fixes: bac8d222a
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/plugin/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
> index 0cb8e35ae407..dcfbd99b15b8 100644
> --- a/tests/plugin/Makefile
> +++ b/tests/plugin/Makefile
> @@ -18,7 +18,7 @@ NAMES += hwprofile
>  
>  SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
>  
> -QEMU_CFLAGS += -fPIC -Wpsabi
> +QEMU_CFLAGS += -fPIC -Wno-unknown-warning-option -Wpsabi

Surely -Wno-unknown-warning-option is in the same boat?  E.g. I don't see any
version of gcc that supports it.

Originally, I tried to grab -Wno-psabi out of the existing QEMU_CFLAGS and
transforming it, but I couldn't make that work.


r~

>  QEMU_CFLAGS += -I$(SRC_PATH)/include/qemu
>  
>  all: $(SONAMES)
> 


