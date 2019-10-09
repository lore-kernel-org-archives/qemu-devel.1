Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E919C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C69020B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jSqLmJy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C69020B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIElH-0004AR-0L
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 12:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iI1tj-0001hy-DP
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 22:40:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iI19u-0000D1-OI
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:52:59 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:43467)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iI19u-0000Cs-HA
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:52:58 -0400
Received: by mail-yw1-xc42.google.com with SMTP id q7so223072ywe.10
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 18:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KgvMEbdhTtgvvv1qwZwFb0OJP2Tb4E0OinKBcfN1thw=;
 b=jSqLmJy9OxgdDiIwg/ClL6h9j+YsQiFsj4O0Z5eV804cRcsNbJ8cSy3JdlO/Uop6zI
 bN6PPVAq2x8q+AzBPdWpjnHJHnRtNCZrras1rHHe2RVTqYzkcEZ9fuJt1HIHqDTMPcUZ
 +/HPFfg2/ZdhN6WQo6a7v2woMoVq0CO5itRkXzeLt1pB2u/j7NaUeZ4Aj74pxL+JiDSM
 c71cMd2K2KyBhZwTRHGjwswI7jUPwSDjQa5eK/eycWFMmyluC63SJZn2sSkzCf3f7VnA
 rT+xQXV7um4vZNuHvMpApYzd4vtyCl4ZPgQxvvRbUd/RVsvWreFZMFfLXwRlr1NPD+iE
 vy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KgvMEbdhTtgvvv1qwZwFb0OJP2Tb4E0OinKBcfN1thw=;
 b=pHUtRltzUmEeJVdP/2YxIAdsvMctPQWt7EjoKG7D/BGDSpn4v4lwY2hkWrugTX5YHK
 0DcAid3qxpK3hMo0DwwKHm8FNdFWmk2GtdC8qW6TU7V66SCk6GDQzQ+vIMSdz5Aj5L2Y
 1+PNJZckcWXPkHudG5/1n1g7vGJelzHQQaFpA4cKA7nZEkbnPekUlrzP/5oetacOcyRO
 oSgu/W6iNAv7LvSid6waMldp2wvUcsILPbpnRysFJlgapXp/Y+zxx4ePybzCtIKFGn/+
 bU3xKoGzB5b9ifTfX9w5JyV9EGV0lJ8YA3SkiHSFMItqjcQrJl5fIQ6X5TF/YhcCKq96
 BURQ==
X-Gm-Message-State: APjAAAUV2og8o3Zg5Q7Q/JwATwkfQuagiGsSMS4c8RMUCsyBQXudHsJ9
 8ayRAkO4wfgC1n2uVo+uXorFUQ==
X-Google-Smtp-Source: APXvYqwpn6+m2oMm4IsX3RH0zahGrn7uzX5P+y7aqT74y1CTi48i/VStV+nbkOj5kbD+nzaI1rdyyQ==
X-Received: by 2002:a0d:dd8c:: with SMTP id g134mr977310ywe.303.1570585977926; 
 Tue, 08 Oct 2019 18:52:57 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id u138sm211977ywf.7.2019.10.08.18.52.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 18:52:57 -0700 (PDT)
Subject: Re: [PATCH v2 09/21] hw/timer/cmsdk-apb-timer.c: Switch to
 transaction-based ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20191008171740.9679-1-peter.maydell@linaro.org>
 <20191008171740.9679-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <7a7fe093-917a-5622-9a2a-dcdae3489b3b@linaro.org>
Date: Tue, 8 Oct 2019 21:52:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008171740.9679-10-peter.maydell@linaro.org>
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
> Switch the cmsdk-apb-timer code away from bottom-half based ptimers
> to the new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the timer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/timer/cmsdk-apb-timer.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

