Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62999C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 18:03:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2501021721
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 18:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vw6oXNZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2501021721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHtpE-0002JN-6q
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 14:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iHtmb-000194-7D
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 14:00:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iHtmY-0001MY-8E
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 14:00:24 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:39809)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iHtmX-0001Lq-Li
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 14:00:21 -0400
Received: by mail-yw1-xc44.google.com with SMTP id n11so6755735ywn.6
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 11:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=r+RM4lBMtla/9Yyv69ydbLXfAKQsO1byO23ggPwHXe0=;
 b=Vw6oXNZl41cB1SQeOaUG33b8Rvh2LgfxGmsjteBzXcTcarU3LI2ONGTr7mlLaU94HP
 HGQmRvVvjL7vbamEVOFEzr6p7EZaoRB3+v2NgWWPaoneWdAwBIa6UlyrbGsCuFPkHfRj
 OX18Vzjmldao39dz98AnPsoFbV8lcwPOaF3V3C3oJnj1GMojsZBeGVsU/nRRO0FcfqNS
 utLedPMELRxPXH/M1pX8bYtCVeQIot+6d0OZZS6wFTtoRmXAqtW5ExSQRG3SBBtOhNP8
 A5LJ0b6gBgDtclAMYYoEvkvvFWrPJNquFLFoMjZZw0K6AFPtWBnKLalaY6aP0rJgQb3a
 anYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r+RM4lBMtla/9Yyv69ydbLXfAKQsO1byO23ggPwHXe0=;
 b=r/Ivg7HozsSkYdv+TBrGbj/C+KJH/ozXLo1qy119mvvzLdA1CG0G5/UAYTkJ2XqbBo
 OHVDXUvB6i9aJakWp+yF7OGkM57IJm4Qy2Im7W+SLGgkVXN35zeQTlbkfAzzMLdElEMc
 iHuYI3rBhsLdJLfY+M3nHXpdrE8UpikxoE822fru7fGui4cGh2CqH0Ibibep1bpFADk1
 0EibcX2umoK5h2dTVIWhaaPBybiaiboCFxLyON+RsFlGwUoFasf/LJHTw7SHXacmLEa5
 jo9N7piPY65i9M8tfuUpZ83Ewsol1+Gskh1URYk24hm/fE7PdRd3mC+PIlngKXAZ/rL/
 jfKA==
X-Gm-Message-State: APjAAAVzZuWK26fvD5p6blFCHP/V2+uWRRoVmAjVDza9lFALzw/AUYhC
 NK0E1kqo9kPrbeN4wTw1VYwthA==
X-Google-Smtp-Source: APXvYqyiyR4YoQVnEy7MYqyeK1L+JFteT0LosKnsYx4tudJEBL1zVP+CbiXAgv50omTc+Km79homuw==
X-Received: by 2002:a0d:fd06:: with SMTP id n6mr24439300ywf.100.1570557620492; 
 Tue, 08 Oct 2019 11:00:20 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id f68sm5256371ywb.96.2019.10.08.11.00.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 11:00:19 -0700 (PDT)
Subject: Re: [PATCH v9 08/13] tb-stats: reset the tracked TBs on a tb_flush
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191007152839.30804-1-alex.bennee@linaro.org>
 <20191007152839.30804-9-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <71068164-f2fb-571c-e7d8-6b600bd9fb2d@linaro.org>
Date: Tue, 8 Oct 2019 14:00:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007152839.30804-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, cota@braap.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/19 11:28 AM, Alex Bennée wrote:
> We keep track of translations but can only do so up until the
> translation cache is flushed. At that point we really have no idea if
> we can re-create a translation because all the active tracking
> information has been reset.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  accel/tcg/tb-stats.c      | 19 +++++++++++++++++++
>  accel/tcg/translate-all.c |  2 +-
>  include/exec/tb-stats.h   |  8 ++++++++
>  3 files changed, 28 insertions(+), 1 deletion(-)

I still don't understand what the tbs array is for,
but resetting it at flush is fine.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

