Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDD3C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:36:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D9A4216FD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nUPUfff/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D9A4216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgCmH-0006Tu-8F
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 14:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44076)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgCfN-0001OO-0Q
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgCfM-0007qD-4V
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:08 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46426)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgCfL-0007pQ-QS
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:08 -0400
Received: by mail-wr1-x444.google.com with SMTP id n4so3836221wrw.13
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 11:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=n3YkOEVUPRaKEULHS1Gzl/S5jvMt2zT4d79BA6WQFVk=;
 b=nUPUfff/KnbTyMMuxIhQQZv7OGI3M+SeT9dQXn/6E59qCbH5KWRRDfFleZEXeuqtfn
 go7qU8c2sx+PzsfGPl3MQWA7qfvQbSzVZCW2yTdEBD7tCvBiwhLRWIVnnNwgVGedJNWA
 3pcedqAYfocS27RInRRAEVI3moAyexRQ1Y8nkgdxBeNfYNQVX8y3rKWwqFN8EgXcv1eb
 2/2Frav3uj7Rx6tJyVnR6RR1xxOtQm6nARK9R87dYXS7FAxvRnM0+C4g/cyIHqlKvQFl
 nie/KXCssGCCN6KZIa59dXNiW95g+KpPz3Ijn95r1klLHeI8RZmevvtelZj9r9esdd0a
 Lc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n3YkOEVUPRaKEULHS1Gzl/S5jvMt2zT4d79BA6WQFVk=;
 b=scAtKzNFsGxGc4MHOxAJ3DWs7Okr6YHtEgQQCau/aIR3ePQcqC5NjYuiRpgXwRzqAm
 h+5SJZ7xLh4qlmfmj52Ge4Xo/Dh0Fu6EfI0NMmsD6Wswt8oaW1/8CmSgjBW3KpyntQRX
 eEbSz93xQqDDhl+AjeL33nDFwYTF5n5SSCCgtQQq15QQps0scPj52QsYX4wvwFySOMpk
 X8EOfGhTqH33uWNsE9+/Q7BlmsPiT5X94dXVncluhnX1VarCuWFF+hojFzGsPD7506rZ
 M6vh70NxyQKq5jL0fcy25UMV6Fwir1RLtmolOeC+awRAdRHiILL9CNYYcvUIsifvPG6P
 K0Vw==
X-Gm-Message-State: APjAAAUblwrb/SbKvaEjICQWWQQJTPUUh/eHA+V+fZvcxg1uL0CW3HM6
 52eXfFHUgWR39l5O+f5xHvRsjw==
X-Google-Smtp-Source: APXvYqxybi8namo91aFfecG4kz0eAl6/gCup4PhnmwiRIaFVK9V/ovRxWhW4fDPaWrjOdQlVXstdsg==
X-Received: by 2002:adf:e705:: with SMTP id c5mr4864776wrm.270.1561573746682; 
 Wed, 26 Jun 2019 11:29:06 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id v65sm3260625wme.31.2019.06.26.11.29.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 11:29:05 -0700 (PDT)
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-9-drjones@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <cb58767c-be9a-b1dc-2969-2a90e3a2f528@linaro.org>
Date: Wed, 26 Jun 2019 12:53:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190621163422.6127-9-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v2 08/14] target/arm/kvm64: Fix error
 returns
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
Cc: peter.maydell@linaro.org, armbru@redhat.com, eric.auger@redhat.com,
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/21/19 6:34 PM, Andrew Jones wrote:
> A couple return -EINVAL's forgot their '-'s.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>  target/arm/kvm64.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


