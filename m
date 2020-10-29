Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6D7C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 21:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6AD320731
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 21:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7AiRGg0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6AD320731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYFZf-0003sv-JA
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 17:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kYFYr-0003J9-IF
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 17:34:21 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kYFYp-0002oh-MQ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 17:34:20 -0400
Received: by mail-wr1-x442.google.com with SMTP id i1so4374548wro.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 14:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1sy8DVNMPu+rgFgPT8IctlHI5O2i9OwiEragFTc6iDQ=;
 b=B7AiRGg0fN3cxyrdHHkv0Key42Dc3CQxGDfUcX24rh0XGjdmnrQHmheDAI49snKsxq
 bOGCo8ZnWGghbZ8M9ERRZDOggX7o5TXYnEW1NVArUf+TTZrZJBuFQmWB+pyUxaMxl3Jb
 EsACnquIbt/JCFp3XcEF7S/Ju65furYh/dh1foIOgfBHc373VOMpexVjl7nbRisCFvMZ
 p8ksEKuEeukQczaxawfuRsYJogON1xBeeo3OrW1IqU9CEf0ltfcZ/hJWcOvRdcjwTKFr
 qOgnkGFboxtQ2V0aXDU0omISVH6ASDVbJ8B3QNsCCfD01FcxeO+3EZrP5MFIQVSEtdNN
 pJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1sy8DVNMPu+rgFgPT8IctlHI5O2i9OwiEragFTc6iDQ=;
 b=AuXUUxIhcQNrmBYcumLU3QnJPb4YVfkGIOCw7UXCLf5g3zAEq5R7sVsQVt6hnR+ToR
 sjjkcwvMioyXEYs5qjOuOzmrNWCQDsKrPws+Tkl08jUAO2nWm4L3PiemAz0vac5l57cf
 Jn4yMPMMwY4RsZuMyVvA2dQB6tLmGIGxuBHVxL7pha7NDcxceQ39dsc9pddhHKTizvdc
 D32Sak6Yp/edf+aiOJ6L6a/DttY/v/oKd764HAAjLPAVR7d5vodFC2KtEuFbC2xkk9n8
 DnpkZBKwCAa1hjJjuFDek6+G2IpiPOWo6ULiD6RobhZZkasClOsrgVYQE83qwkpFKpw3
 idCg==
X-Gm-Message-State: AOAM530Vl2LBYQBRu6rBOTtEsYKREYN/Itrlr/SZi9shgw7thlLhhzui
 E2noG4Sk9+Qw6Wrte4eD1tw=
X-Google-Smtp-Source: ABdhPJwurKAZhhqGxmLjLrUJx+2JE1PqBihWA9LjmX32Tk3Y6TEpPAqEzdwIGqRZSGuNuyv9E5i1vQ==
X-Received: by 2002:adf:cd8d:: with SMTP id q13mr8107273wrj.268.1604007257010; 
 Thu, 29 Oct 2020 14:34:17 -0700 (PDT)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id a3sm1812777wmb.46.2020.10.29.14.34.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2020 14:34:16 -0700 (PDT)
Subject: Re: [PATCH for-5.2] util/cutils: Fix bounds check at freq_to_str()
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20201029203850.434351-1-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3b09535c-d763-7ed9-f547-0693637d86a8@amsat.org>
Date: Thu, 29 Oct 2020 22:34:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201029203850.434351-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.261,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Luc Michel <luc@lmichel.fr>, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/29/20 9:38 PM, Eduardo Habkost wrote:
> Fix bounds check for idx at freq_to_str(), to actually ensure idx
> never goes beyond the last element of the suffixes array.
> 
> Reported-by: Coverity (CID 1435957: OVERRUN)
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  util/cutils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/cutils.c b/util/cutils.c
> index c395974fab..0d9261e1e5 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -891,7 +891,7 @@ char *freq_to_str(uint64_t freq_hz)
>      double freq = freq_hz;
>      size_t idx = 0;
>  
> -    while (freq >= 1000.0 && idx < ARRAY_SIZE(suffixes)) {
> +    while (freq >= 1000.0 && idx < ARRAY_SIZE(suffixes) - 1) {

This was the first patch I wrote, but thought this wasn't the
simplest way. Probably too tired.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thanks.

>          freq /= 1000.0;
>          idx++;
>      }
> 

