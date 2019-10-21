Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19E4CA9EB7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:26:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B484222D1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gp90aU7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B484222D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMaVe-0004Qp-Dx
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 12:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iMaTi-0001jg-Ej
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:24:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iMaTh-0000Qy-6g
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:24:18 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iMaTh-0000Qf-0d
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:24:17 -0400
Received: by mail-pl1-x642.google.com with SMTP id k7so6871271pll.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 09:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Iv2zEtInALAh3VR3wNQNuIGstkTFEg/hZq3mm7Zu4ck=;
 b=gp90aU7ysMB1va39WHWHZ6TLPPwZVAtJHX/Bgcn4IQRSGENnlkGA7QeeXnIZy9tD25
 aQuRdkrtcufmxsPJBe7N4zQB9VfUAMEYhOLHvFAgVLWP9cZgnC/HPpG2x83EMV7YtB79
 q5aWQdPhCkrQU36ema03/T1aRp/2Uvn+cuygnMh80JRXdP8PCJvv5SljQbI2poPPeyZl
 BeEwtFXZ7jW6sDrlunsu1dOvThWlN5QfFKUySkdhdjpKy6JFuSxM7jQuphJ4urY8X5mE
 csEWz0UFPApSm40vaDK5g4HaiXHSivd0SlosHN/SJL48Oook8FUKXxw2HOYgpJN+J3hh
 CrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Iv2zEtInALAh3VR3wNQNuIGstkTFEg/hZq3mm7Zu4ck=;
 b=E3fRffS061Cslqf1yScHnbKRjkimZZ8Dr+TsjrmMqgX3dSUmME3G64p+8axgcUVRqk
 gAux6lNtM5HZpWH4biWfK6O6s1jSjWsndR9gqmMQKAVI+k4CMtsYMwfj05nCgijopOs1
 Bz7mmlq9DYyTcZM/TlKjQPTiHOh7RB3ZAInx+MJH/HOc1op0yvbMguI3D2JmjIPm0TJW
 uuiBBiZW1xCDLhGO9e58CdI3nAWkAg1MPpkmA+NLeuWPunKTx1lctGAHzE/8TzR/BokC
 wRXUDmnIFyWV54XUHf3RYcHYCqsKFUqoyu9+2Pkxuc8S8uUQlKBuZCARpO5ntdlb6jnh
 XFBA==
X-Gm-Message-State: APjAAAUUCinq/j2LBccnqsK7NYhwr5NNlZwOwwynfpBE6IGjk89jyPOF
 i7M71WU1mkpBUPKUImlDNHsNxg==
X-Google-Smtp-Source: APXvYqyGXwtkYMqzRIBGNSBBtXpdIjSxyDtTvJJGMqOFA1xj5XoeN57BWFmMmqiepfMT09/5j4eQSg==
X-Received: by 2002:a17:902:9888:: with SMTP id
 s8mr25735762plp.193.1571675054848; 
 Mon, 21 Oct 2019 09:24:14 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id y9sm14980644pgq.11.2019.10.21.09.24.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Oct 2019 09:24:14 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] hw/timer/slavio_timer: Remove useless check for
 NULL t->timer
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191021134357.14266-1-peter.maydell@linaro.org>
 <20191021134357.14266-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0df5c756-d645-1591-1bfc-138db3e97933@linaro.org>
Date: Mon, 21 Oct 2019 09:24:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021134357.14266-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/19 6:43 AM, Peter Maydell wrote:
> In the slavio timer devcie, the ptimer TimerContext::timer is
> always created by slavio_timer_init(), so there's no need to
> check it for NULL; remove the single unneeded NULL check.
> 
> This will be useful to avoid compiler/Coverity errors when
> a subsequent change adds a use of t->timer before the location
> we currently do the NULL check.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/timer/slavio_timer.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


