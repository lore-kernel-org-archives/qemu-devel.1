Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF91C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 03:04:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE229206DE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 03:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YYvC0Dmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE229206DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i64Xj-0008Ud-Dh
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 23:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i64WS-0007zN-9k
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 23:02:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i64WQ-0004pE-Nq
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 23:02:51 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:45657)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i64WQ-0004mv-Gm
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 23:02:50 -0400
Received: by mail-io1-xd44.google.com with SMTP id f12so9425461iog.12
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 20:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tPjrxSpg0VUXdoD54SOmEG5RPuzf4G6Eimww2PODS4w=;
 b=YYvC0DmhRPGBOgtFuUJA1cGbS8QCNF94USz2SNufa4CG3eXYaIQwUuI+TtLkuBSiIc
 akaHcP/+SyqjEaLrBId5zILue3T053ebWTaI80FNweE3tOZiRmW/t4wocMrkORMmdCDl
 lUFCqFOFXRE7S0zIqW9uEdapSrCGsCR45PhiY47J8kf2nNE/wsZl3cgv8dVVkhsj4cAI
 zP3vTGrfTM6SRVhl+dTB8hGUQ7biudwQZcoR9a9oyyAeQBC5sg8JSoNLmFbGmRqAeWPJ
 m8zqr4Arcks6RSVVrkwlh0NpdHr9KRjHnlojPCvhSTesQ22kxXcQA9+jasHuTioyeBOC
 wX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tPjrxSpg0VUXdoD54SOmEG5RPuzf4G6Eimww2PODS4w=;
 b=fvgP/Dt0grAtVlRvDxy9Dx9sk2FCjagMFwAkhStfYd2eDU5m8lMbHBAPjxq0ZN1SVI
 Gv1q56U44BaXvVbDhYLvGxdopbNACL0IelFqcXZelKipPohEtQl4uZBCnDmIhNbgdUoi
 hsNwRKt8PdpFdMOI/SqNWu2Et5UUADKZWuTdllATRVkYhEHI2YHE6292WZ/VUAU/wE0J
 NgJr9Qsp8wDAlSWZEU+klyjJOLtUHMAp/ia4l2gky1Fo2IWCosl09Y4W0TGZ5b4jiVgj
 d3hgjDUGwQeNj2BXj19uF8azcPcPQJoxlki/5m0JATPGMTpvqusGnncX8P60o/DHN0V0
 vg0w==
X-Gm-Message-State: APjAAAV8yuexlQIzV0OfysmkilPvbR5uFh5LqVBTJqCWDqCbQ23UkFYr
 Emvi/IC/M3A0V4boFsjRtuwYPxHm3rlE8g==
X-Google-Smtp-Source: APXvYqwXh4nCbnDBGJkSN7UUhfqY/y9KjHZXsAosSATxI/HcrYllj00waLM4U2m+Im+4GfaYh9fBNw==
X-Received: by 2002:a02:6a56:: with SMTP id m22mr7618815jaf.114.1567738968413; 
 Thu, 05 Sep 2019 20:02:48 -0700 (PDT)
Received: from ?IPv6:2607:fea8:a260:81:78cf:74ad:c2b2:73ef?
 ([2607:fea8:a260:81:78cf:74ad:c2b2:73ef])
 by smtp.gmail.com with ESMTPSA id l186sm7993113ioa.54.2019.09.05.20.02.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Sep 2019 20:02:47 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Laurent Desnogues <laurent.desnogues@gmail.com>
References: <20190820210720.18976-1-richard.henderson@linaro.org>
 <20190820210720.18976-18-richard.henderson@linaro.org>
 <877e6m937n.fsf@linaro.org>
 <CABoDooPis6VR-3zw6EcCerwmTfZ_c2gqbCtVDSnpB30q-Oh01A@mail.gmail.com>
 <874l1q91z7.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <90c9a537-6786-060a-35cb-ab29dd8c45c3@linaro.org>
Date: Thu, 5 Sep 2019 23:02:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <874l1q91z7.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v5 17/17] target/arm: Rely on
 hflags correct in cpu_get_tb_cpu_state
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/5/19 11:50 AM, Alex Bennée wrote:
> I wish there was an assert form that would handily print out the
> difference between the two values. I wonder if glib has one...

g_assert_cmphex(), but checkpatch.pl flags its use because there's a glib
environment variable that disables the assert.


r~

