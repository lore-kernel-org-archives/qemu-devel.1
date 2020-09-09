Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9968C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:05:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E47A21D7F
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7hKUW9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E47A21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFzmr-0008C3-4u
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 09:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFzkv-0006E8-PL
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:03:21 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFzkt-0001vv-QE
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:03:21 -0400
Received: by mail-wm1-x343.google.com with SMTP id y15so2288254wmi.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 06:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yowadfvDXDGudzwCxAmkIYNU8MFhavwJf7L478FjO6g=;
 b=j7hKUW9TtOXOr6gIhgzZy5BwtdyQOGKWmm8TwX6eNbnf4yAbP9EBKmXjC5Ig1HbwuF
 85/GMO3+9Atm8HruGys6TO4zFU+v9hYEkSUennNWGSq+95+9jcQ+qVkTfDbDXjREvatb
 2a7hRCw+HYGf+Yz/H0f94MWwsvCw50PNdT+kVd8tr7UXWdoM5p6poIyaBoeISsicwRS6
 CWaExLeJixdkqBvpRu/PtSQdOxKOzmn+nLsdOu5n5T5UAhKrNLajjIlSOO3ehsdcWlFW
 t5uzsOhR56dmJtNT0jQ2tGZgmNYLCy5sxlTR9x8JYA1WiUJpEOb6YoyaD9RhSM6NwfZq
 6fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yowadfvDXDGudzwCxAmkIYNU8MFhavwJf7L478FjO6g=;
 b=KheCjyB4Vu+U071N0VoEJepyP9LqE4x+zZe23hzJCtvEjyCR0v4sJTXyGFX7cFt/A2
 5IvMuPB3e8PoSJ9mXtWXdyMVdc0mp2eKmWnHavVVnnSp2wPT/+V+tASVS78gKrhqEMax
 V3lq4xCUS09iJD+5Gs2cE8sOZY29pUi/fuzd4S2QpS2jN65Lblec3TbX9yeRqI9REw30
 rr2GYRU632xhqnAkUk8ISwhVyn3fbPz59dLIxc54XQU3zXVVCF8oN90AeFbU1ELvpTyT
 TDw/Z5kge0pNzAReRmOOjsnXVrjjEbmFcXJUXFVYB1uWd982/5KDo6g1Ue5QT8rp8SKy
 EiDQ==
X-Gm-Message-State: AOAM530pAvDd0wwWjPLEk3lGcjoVABUhdwE+jbjJd5KNgPfhBZfs+kKd
 cF8kNW8c0a9BiyVcGwXPrsk=
X-Google-Smtp-Source: ABdhPJzqW2aaC397HdK/uKrbhU/VtVG07Fg3RpV8nq4wmi4HglnILCD+dk+C47TAg6FVien4PDOsUQ==
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr3716514wmh.177.1599656598164; 
 Wed, 09 Sep 2020 06:03:18 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id y6sm4042007wrt.80.2020.09.09.06.03.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 06:03:17 -0700 (PDT)
Subject: Re: [PATCH v2 03/10] tests/meson.build: fp tests don't need CONFIG_TCG
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200909112742.25730-1-alex.bennee@linaro.org>
 <20200909112742.25730-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <076a3151-7ebd-3c0f-8b1e-b7dfef5f6160@amsat.org>
Date: Wed, 9 Sep 2020 15:03:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200909112742.25730-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-3.576,
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, cota@braap.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/20 1:27 PM, Alex Bennée wrote:
> As the tests build only softfloat.c no actual TCG machinary is neede

Typo "needed".

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> to test them (as is evidenced by GCC check-softfloat). Might as well
> fix the wording on Travis while at it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20200903112107.27367-7-alex.bennee@linaro.org>
> ---
>  .travis.yml       | 2 +-
>  tests/meson.build | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 1d0ade0a133..65341634d02 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -138,7 +138,7 @@ jobs:
>  
>  
>      # Just build tools and run minimal unit and softfloat checks
> -    - name: "GCC check-softfloat (user)"
> +    - name: "GCC check-unit and check-softfloat"
>        env:
>          - BASE_CONFIG="--enable-tools"
>          - CONFIG="--disable-user --disable-system"
> diff --git a/tests/meson.build b/tests/meson.build
> index 998e4c48f90..dae8a77df14 100644
> --- a/tests/meson.build
> +++ b/tests/meson.build
> @@ -259,8 +259,9 @@ test('decodetree', sh,
>       workdir: meson.current_source_dir() / 'decode',
>       suite: 'decodetree')
>  
> +subdir('fp')
> +
>  if 'CONFIG_TCG' in config_host
> -  subdir('fp')
>    if 'CONFIG_PLUGIN' in config_host
>      subdir('plugin')
>    endif
> 

