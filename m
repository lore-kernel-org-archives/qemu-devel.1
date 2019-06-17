Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D382DC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 22:45:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BBFB208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 22:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uyzDeTgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBFB208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52390 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd0NQ-0002hi-Tp
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 18:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37687)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hd0MQ-00029Z-92
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:44:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hd0MP-0000vX-GB
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:44:22 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43622)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hd0MP-0000v5-A2
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:44:21 -0400
Received: by mail-pf1-x444.google.com with SMTP id i189so6426636pfg.10
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 15:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=e7VSYR67XjUOkVyBOaz97kSsn3m/61t9G4EW7BvZFiw=;
 b=uyzDeTgVvkURCzcFpshsY3JBKFNPZbJNWXtb3faIL4z6ptGArO13xnI/D5wwhe3Uxs
 Ij3q+YQ3jIvNdWty7pAi12QdqDBudKm7hr24gucuIhCQWwLhXTnEELpwLhgKvOo0pfzE
 PYy4crNefQLzzosj2mcgljVf/9i5OjPLxmmAnkTsGshOL1FBuW+iVDOavuq7w22iHWTU
 cpSKb6p9OH/TwRDkrLSALB7S6zJUx/YyAu4uvh0TouC2eaX7TbMlrKlJUgZ/cyMUnQ3s
 5nZ+OdBw4bFjyIHC002414X7QHsuXFW5vEgsClRxrOQthQnpi0TmrARrM1k1wdYCc3ct
 Kpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=e7VSYR67XjUOkVyBOaz97kSsn3m/61t9G4EW7BvZFiw=;
 b=iEKRwVWK6Qfq2UvTdGrYhe+XohuFjXr5YeCAfCaBJ2zb2f0zj8qDrQ+RSCqhth2gew
 o2vHSAUINy1YWZofKX7bWIoYKBvRLps5sg21OO8RouF1u9uWrF6XcIvXKl3yqw0CmYhj
 gxxlL01qpvqSav1MOVBmzM0ijSdx+2hQGZmMxG+3UTV0VXxE/UbBHbUzukqlAwmXhWRj
 cWG8Qgbephvpd/ELWmIh6/wc6aMMsGvpWRE2BDJAQDwIF91pYMMAyeUeFm2d14Jrd+Um
 J1g7NfGtXCDU6+exilL713smRSEZAbAZK0IEsXR4sHmrlNUsUgGGbjm/aMTHjXkYJFKv
 rA/w==
X-Gm-Message-State: APjAAAVIWz0AVbZ49qyfF7Cf+uHbFDJY0WZ98J9rRiXVvYCBsuCOxrEI
 QkDnysF/+6AljCNZhisFDnrlNA==
X-Google-Smtp-Source: APXvYqzxDM+mu38RE/YeVRAm/mBeFCETEpBUJ/I+Cr2dSa57gosUsh7I5OqhDRmi+E6N08244uYFVw==
X-Received: by 2002:a17:90a:cb12:: with SMTP id
 z18mr1490697pjt.82.1560811459966; 
 Mon, 17 Jun 2019 15:44:19 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id 12sm12259332pfi.60.2019.06.17.15.44.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 15:44:19 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-37-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <347b1f29-ea26-15ba-90c2-8f78a26c892a@linaro.org>
Date: Mon, 17 Jun 2019 15:41:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614171200.21078-37-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v3 36/50] target/openrisc: fetch code with
 translator_ld
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
Cc: Stafford Horne <shorne@gmail.com>, "Emilio G. Cota" <cota@braap.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 10:11 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/openrisc/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


