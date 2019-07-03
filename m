Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB76C06511
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:40:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D30662189E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q9GhwxeO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30662189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiiIs-0007R0-3s
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 12:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37725)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hiiGn-0005ww-Pg
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hiiGm-0000zt-Hv
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:38:09 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52161)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hiiGm-0000yd-6m
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:38:08 -0400
Received: by mail-wm1-x342.google.com with SMTP id 207so2896613wma.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 09:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gqWP5SSxGp30JFoetdke1uxckIrhx8Qe6PCmPcFhYOU=;
 b=q9GhwxeOZQ6iJ4pgbieZLlPwoZS+C417h+RqaALivtElu0414ND9Js44VOl65Vj4Ld
 liIwnzn2NdX6CPYt1RU+ucWaktsfdwfy+uObLkQKXUdgECxV+sGD1JooeqdbpU9do+2b
 VIlhfyAzH4XX+gHkCTgnrZZy0L6BVlSL9n72l9QEYZJmoicX35eD4LVmcKE2bCrzaKeB
 EoBQPk6Ylpa4hdDjYlX8fGhWExicFei07HfxUbJIOThUPnng9XpBshslMtaEVObOEZ5o
 SvM96F3NLK+X6L2J8Y0AI557U5RqMRatmwS21CSEbKD4XUmeXBBxQ+bM5n+KcdaF4c9y
 NpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gqWP5SSxGp30JFoetdke1uxckIrhx8Qe6PCmPcFhYOU=;
 b=bJMopktapni88g5wqDr/VVmnb+VfmKyIRpnw96PdU4VvnEQhuf3l7Lqu2ey91Xu4iY
 5ATcmfHH1QPKp+B9kmWPdOcZN/nQnrY/Y54+M1IlrcLF9i+CB+lFZYXpQSEjVIVNSSin
 T5jumo89AgTQj8jxwK0Tvi812odm1C3jsnL/HOk/AD2fiay3gZ5dQ7i7RxMOxaXS4l6l
 7Xoj/oY7TR6G7eW78E48YhfqksJkvsSPWfxVgLV66JQakNpH5yPipMnWijcvO2cAiTFr
 m66hJTuyJJyvgL/v8pJAbRVKbAhLvmET3NSeQM3cQzvqZoK4cbWGoXbvkjMZ1cTmXrNw
 A/9Q==
X-Gm-Message-State: APjAAAVzPe7WEyewYiFmJz4FbK/pUnIDD/TWvzOXukLE9me3zumdxYS6
 DgPFwJDmdbKdf0yrtB7x9m/egA==
X-Google-Smtp-Source: APXvYqyYTve4Xch6JLJU8wAwpPWz/AtazX/D1FvgxxRIwzRcSz7xpdqm6Ws1yOKl0z59iHC8TyPD+Q==
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr9224055wmj.64.1562171887020;
 Wed, 03 Jul 2019 09:38:07 -0700 (PDT)
Received: from [192.168.3.43] (93-34-153-63.ip50.fastwebnet.it. [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id 18sm2744321wmg.43.2019.07.03.09.38.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 09:38:06 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190703155244.28166-1-alex.bennee@linaro.org>
 <20190703155244.28166-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <86d34c45-8a94-2d91-2e23-a3e6d7f8b116@linaro.org>
Date: Wed, 3 Jul 2019 18:38:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190703155244.28166-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v1 4/4] target/arm: remove run time
 semihosting checks
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/19 5:52 PM, Alex Bennée wrote:
> Now we do all our checking and use a common EXCP_SEMIHOST for
> semihosting operations we can make helper code a lot simpler.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/arm/helper.c | 84 +++++++++------------------------------------
>  1 file changed, 17 insertions(+), 67 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index ad29dc4072..5c1f741380 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -10364,83 +10364,33 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
>                    new_el, env->pc, pstate_read(env));
>  }
>  
> -static inline bool check_for_semihosting(CPUState *cs)
> +/*
> + * Check whether this exception is a semihosting call; if so
> + * then handle it and return true; otherwise return false.
> + *
> + * All the permission and validity checks are done at translate time.
> + */
> +static inline bool handle_semihosting(CPUState *cs)

Drop the inline, probably.

Since you are renaming away the "check", perhaps hoist

> +    if (cs->exception_index == EXCP_SEMIHOST) {

this check to the caller, change the return to void,

> @@ -10476,7 +10426,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
>       * code that caused the exception, not the target exception level,
>       * so must be handled here.
>       */
> -    if (check_for_semihosting(cs)) {
> +    if (handle_semihosting(cs)) {
>          return;
>      }

so we get

	if (cs->exception_index == EXCP_SEMIHOST) {
	    handle_semihosting(cs);
	    return;
	}


r~

