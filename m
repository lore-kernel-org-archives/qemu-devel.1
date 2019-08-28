Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEFCC3A5A3
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 00:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309E62173E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 00:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TXDjcjWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309E62173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2lVe-0005r8-9i
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 20:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2lUf-0005KF-74
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 20:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2lUe-0005sI-06
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 20:07:20 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:37588)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2lUd-0005qw-PF
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 20:07:19 -0400
Received: by mail-pf1-x442.google.com with SMTP id y9so444426pfl.4
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 17:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=n8q8YNKPvXrkleM20QsMvRxgJbJG7dT0flX7RMl6O6U=;
 b=TXDjcjWcQzT67pb+dJ85bq2u/1CP2jnNTZHp8mkDlOzvBsbz9NIx8PvDvfHS6OjuII
 xCV45R8UvVbkcZJoRln5JR+PSbceGaGrfcUGStU0oetrcTHJLkU4XfFb0st5GGDGBd24
 TjSwcAUdLJTyyJ9M2dFuV0LPOddtT4Q3iTQd4Dy5FCPZBT3o9pnGEBIa4Jq3G4hHGITB
 GdyhBdiifpGg1DL+6hlm2Imo2pGyGpxtRz6xdMM2hBrzfMr4tuopuI0AtwZzTaV0mWJo
 /cTuotmJTtZLL65GjsJ8bTtINfSMpIlNb+2stlU8V/7JKdcKFD2XmQ+ozJOzC5yg5BSm
 Sx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n8q8YNKPvXrkleM20QsMvRxgJbJG7dT0flX7RMl6O6U=;
 b=jVXzI6FRzqGkGzn5zd7Z6+sZeZ15gY5Q49miUBqt4za56id8H1IZEn1NJamiSNylT4
 iwBCpy4IoJnc9Oabj+sCavkGLa0Wo1rQqabZceOtbTTJGh6lGfY+Hd3TvTIuzxnGJ6cG
 TAfgiKn1frss1f16qYaOxdN3bQHGIOwDX6wpqmzIqTyI8cH7HJ+y2OnfJzcA44b/ub2B
 iEBawatDrm0vM6alERJCKEOYG7Twm8bkA4PqyoqBsaW/OpNp9C8pUWT97tW90Ccelq+5
 HrR+4Vf3ecl2YlwaW7/hhIvRbocIIqZ/bbrztolrW/yuqlVmBpB/ZucTjWav/4u7Ku1n
 jWHw==
X-Gm-Message-State: APjAAAUBNCDY0gqWDaBVtPYRfOj0pwSqMEspZnsnUmsSTUavS1RI4Zqb
 HSRRudAWXUH3RKyU6Kx9UEvYTw==
X-Google-Smtp-Source: APXvYqynL3dm9149OMTleoW49rUAT7U1fzVKvJT/3IDNn8DRi11TBXoHfoCLPRJsqypAISRjq0mM4g==
X-Received: by 2002:a63:7e17:: with SMTP id z23mr1025474pgc.14.1566950836668; 
 Tue, 27 Aug 2019 17:07:16 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a16sm477679pfk.5.2019.08.27.17.07.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Aug 2019 17:07:15 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-67-richard.henderson@linaro.org>
 <CAFEAcA9AbEzR97-2gvpPAbGrGHx_AxGgVhh4-BDufTQUX0gM1w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <7f4eac6e-486a-3d99-b533-5fd4ac41864d@linaro.org>
Date: Tue, 27 Aug 2019 17:07:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9AbEzR97-2gvpPAbGrGHx_AxGgVhh4-BDufTQUX0gM1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v2 66/68] target/arm: Convert T16,
 long branches
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/19 2:34 AM, Peter Maydell wrote:
>> +    tcg_gen_andi_i32(tmp, tmp, -4);
> 
> Minor nit, but can we use 0xfffffffc like the old code did,
> to avoid the reader having to do 2s-complement arithmetic
> in their head to figure out that we're clearing the low 2 bits?

I always preferred "x & -c" for exactly the same reason:
to avoid the reader having to do 2s compliment arithmetic
in their head to figure out that we're aligning to c.

But, sure, if you like.

> This would be a good place to put a comment equivalent to that
> in the old decoder:
> 
> # thumb_insn_is_16bit() ensures we won't be decoding these as
> # T16 instructions for a Thumb2 CPU, so these patterns must be
> # a Thumb1 split BL/BLX.
> 
>> +BLX_suffix      11101 imm:11                    &i
>> +BL_BLX_prefix   11110 imm:s11                   &i
>> +BL_suffix       11111 imm:11                    &i

I had placed that with trans_BL_BLX_prefix, but I suppose this
is a better place.


r~

