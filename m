Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03451C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:08:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF4E2218DE
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E0LyCXla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4E2218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIEVy-0007Zd-77
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 12:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iI1ti-0001lf-Pt
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 22:40:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iI1B1-0000i5-CJ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:54:08 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:36351)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iI1B1-0000hQ-6a
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:54:07 -0400
Received: by mail-yw1-xc42.google.com with SMTP id x64so238420ywg.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 18:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AI0lxvpzeyqMF1mskEdwNMTJzL8izBhG4L+cQezg9dI=;
 b=E0LyCXlaVp/9ErF5z41zmZJ3NtgBNT3nd8aH4RpdU2sdu/+cWTELLvPWzvH5c2cliQ
 AcciRjl2K0MoAipgfHZPmyBtfFuhpo7AMoDJ7e9VUT5hmN3wz6UVvTdbUOgHeKtEN7nY
 W2rU+rwnxDoySZpDskrC/y+nm7IF0lZQr6T6EXpwpC5z9DOh/6hIeMHn+sYoBuofHXrk
 1itBRapx06gWERJWrENxF1BK2HWPs2gtk8vQTQ94+47vHF7TE81TMc9tPdS0+OUl19R2
 MgeL3pdRIfboxY2kJVCk5v8R4MCSE/W3D/5YosXx/R+E2uhF2ACFJ9yz6Qkho91BKcky
 1qXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AI0lxvpzeyqMF1mskEdwNMTJzL8izBhG4L+cQezg9dI=;
 b=iGlz0LM79XIIBq48+7kO4o7KRDh2ps8gBBtDiiwDbicukfyCU70EuQAV7AJyVuvWVE
 AjH30wCIXfLYKvUp85Qyo43qqQuJUCCAQlxx2Y0zJYkiQh/VhZLDVwUjyjSeD9Esh8M7
 Im8e0v37PQDtNV+pCxEbgOh/H2CT4z9vT9jAm+rl6easbLhrsO/uuy420sGc5FiQfszQ
 kzUYSnGK/M/rqIqVSxXl4lQbzt8V4SlQcV9N32iRgildYIbTOGddVB+ZRoPXEcBt0fQM
 yG2HKlezwRcxCzfL4Xd/JCYYCstCpMNLYiVaDBTkzfl9QYy80phGEDLwaT/b/ZxOTCPA
 6IqQ==
X-Gm-Message-State: APjAAAUhH83pkNRfWdUd0BrtMbUaH4JMIbVYcR6M8XnMisQzkWIhFMzx
 PaEADDYFkq+TWBUeO1ruQLO0Jjm3jZ4=
X-Google-Smtp-Source: APXvYqzWTS7vEjiemzPMigYTPTloc+27tPe7W+nF5V+6Sj2irS/l19cO+vK70q7dTRPO5pQuWqf45Q==
X-Received: by 2002:a0d:d98e:: with SMTP id b136mr1064631ywe.78.1570586046513; 
 Tue, 08 Oct 2019 18:54:06 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id k6sm202373ywh.60.2019.10.08.18.54.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 18:54:05 -0700 (PDT)
Subject: Re: [PATCH v2 10/21] hw/timer/digic-timer.c: Switch to
 transaction-based ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20191008171740.9679-1-peter.maydell@linaro.org>
 <20191008171740.9679-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <25488035-58a7-25d5-d021-f25f7e144b01@linaro.org>
Date: Tue, 8 Oct 2019 21:53:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008171740.9679-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/19 1:17 PM, Peter Maydell wrote:
> Switch the digic-timer.c code away from bottom-half based ptimers to
> the new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the timer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/timer/digic-timer.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

