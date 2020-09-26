Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEF9C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 20:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3841920715
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 20:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRCH59Jk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3841920715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMGxu-0001gd-Cb
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 16:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMGvn-00005L-CM; Sat, 26 Sep 2020 16:36:31 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33559)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMGvi-0002Lm-BT; Sat, 26 Sep 2020 16:36:31 -0400
Received: by mail-wm1-x344.google.com with SMTP id e11so1774120wme.0;
 Sat, 26 Sep 2020 13:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BQEM8GyrRfT9S+MUOhVXhzGx7HhUGi/JUVZeZqV6V6g=;
 b=PRCH59JkuL0oscz4LFmFU2pUsqVGCgcHdk8hg5g9BfPg2fNsmxQEtuhOWcFZ0O7wkU
 YM9ix4PDdiyhlLfXBLW4dp142ICoCelciIoruOl7XN9HlgCPrTcAD7L2jjHyVnGcvkMj
 r5fgDeeQD/1dyL4FKIwE2xVEIhNH5gGgl7c2JQTXOixXOjxi0oL8PwLT13D2j0QQnNde
 +PXIkWsq9TDS0vtYPZXl1hmqc9PEtZxvUPGpMzMuYq2v184cACTqgu4byZ5pbjxD4qT8
 it/uyeGR1/FsU/nbab9ShM50tQi3FN2msbqbJNyIZOnamY/BThU88bIEnHxgLFB9kauV
 gu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BQEM8GyrRfT9S+MUOhVXhzGx7HhUGi/JUVZeZqV6V6g=;
 b=f1+2bWur0qq/A1Y16ja/fcHPAD8RqDb8JF6RQlMWNpPtuCKyjirljyGZXyiqHtGB8m
 0IRVrGubNIez4Pbwx5vCiA/vn6tfljnBdRGTXlUJgrYFURbSh0C25uredDn+L9CVpbOd
 MYa0eZqjxr+eVyrGkgPC6rM7TkNdkbrS1gApPO0GQ8RdDsgwCRGaf2kFhlr4tbqP+j8U
 /t/e521skGhMm8CSwYsdAllz3rC+ZGnYOoUH+zYk+AqGXxCecpj+Zi2cZNJi32E+5p7+
 W+yryNBJ4mhVxG2zKClPNEsDl4cHLFMVQNz/5ohZ2bcOcACEjOidccJl87FlUkPmKPrb
 S3aw==
X-Gm-Message-State: AOAM533qu4aTwu0PiWy+DkF6z+CopajcIj0KLnbEBbXxlqNNHSjf/piZ
 HzLzrJGQTqYiO0qF6T9yHztv/nhpEo0=
X-Google-Smtp-Source: ABdhPJzr682hy6RTUgUkC2Y6jbkEKyB+e3uS6tdLifNqAetI6tx0QNewnDhyt0WUflQ1TVRzC4UbqQ==
X-Received: by 2002:a7b:c14d:: with SMTP id z13mr3844705wmi.19.1601152584509; 
 Sat, 26 Sep 2020 13:36:24 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id d2sm7662571wro.34.2020.09.26.13.36.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2020 13:36:23 -0700 (PDT)
Subject: Re: [PATCH 01/14] hw/core/clock: provide the VMSTATE_ARRAY_CLOCK macro
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20200925101731.2159827-1-luc@lmichel.fr>
 <20200925101731.2159827-2-luc@lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5f6a9c59-5d17-2ef6-563d-d180270bbc3b@amsat.org>
Date: Sat, 26 Sep 2020 22:36:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925101731.2159827-2-luc@lmichel.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.213,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 12:17 PM, Luc Michel wrote:
> Signed-off-by: Luc Michel <luc@lmichel.fr>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/hw/clock.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/hw/clock.h b/include/hw/clock.h
> index d357594df9..c93e6113cd 100644
> --- a/include/hw/clock.h
> +++ b/include/hw/clock.h
> @@ -79,10 +79,15 @@ struct Clock {
>  extern const VMStateDescription vmstate_clock;
>  #define VMSTATE_CLOCK(field, state) \
>      VMSTATE_CLOCK_V(field, state, 0)
>  #define VMSTATE_CLOCK_V(field, state, version) \
>      VMSTATE_STRUCT_POINTER_V(field, state, version, vmstate_clock, Clock)
> +#define VMSTATE_ARRAY_CLOCK(field, state, num) \
> +    VMSTATE_ARRAY_CLOCK_V(field, state, num, 0)
> +#define VMSTATE_ARRAY_CLOCK_V(field, state, num, version)          \
> +    VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(field, state, num, version, \
> +                                       vmstate_clock, Clock)
>  
>  /**
>   * clock_setup_canonical_path:
>   * @clk: clock
>   *
> 

