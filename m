Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FDEC4CEC7
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 18:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA87120692
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 18:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JrVHdwBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA87120692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9Cef-0004Bp-TL
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 14:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i9Cdv-0003ec-Ix
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 14:19:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i9Cdu-000757-O1
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 14:19:31 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:35601)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i9Cdu-00074o-Ik
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 14:19:30 -0400
Received: by mail-ed1-x544.google.com with SMTP id f24so12091167edv.2
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 11:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4B41yq9zdNdnJksgpIQB+qz5dKo7g8LzE3zX2pNz53Q=;
 b=JrVHdwBmRRSZvZEkASmqqTjCTnO2OYmvqk/FM6JO8bUH56R/5bPHFb+sBMBVfcdNKe
 e5G64RA6Qn2H45CpKsVkPSIqVozQN1sXLhcqKnA62EE4UBXYsT+JchBoOizxGRzM108R
 odFglAYdft5Kl+vHt55P+A0e83foE7QQW+SkaE0At+R8leQXe4S7wPp7N0dHVeCLo4FQ
 enpY++M7U/Lnkr2/FCkBdoMdeOWRF7yITFY1trBCRqwMiZKvX4HOUeeT8GHPz3uMLk8W
 PXwwrf4AWPSorXp/AAa3ay1OVGiSwgkhzgBUpJDtCGZOzZJjkUn4RnOFnZNS/5xzkt5v
 K6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4B41yq9zdNdnJksgpIQB+qz5dKo7g8LzE3zX2pNz53Q=;
 b=ih1bILkfuO8gdPjdJuUFf7K9CK1iVJP0ddERRqMOJYNhe8J4W8HyypWWVJPjsQNhnO
 5MIWO0VdbYl1SvRcWEc+FI2O32SuzPzQw29v7oOZdOK5TGI81JqeiCA6NZHqmchN3edh
 bbhKtcSOOgpjLSQvL3JcraJGW9DCS+G9+Y2qCoDpgXz8AF1yBFUcbo3aBUJpyYDvExhC
 cH5/+8vZhPE+8Vbwfb90B/dlo5SdDqJtsX+bdo68CfxzwhjSiY49DmA5Gq/nzlI37EDk
 mowkM77FVMWrT1pj5NkRSDdKpFEwH5f0uBC3Jy2uglopBhuquOzZ5Q4CDwHujcvzarUA
 6MEg==
X-Gm-Message-State: APjAAAV5MG8MoAzRmgrr1loOV/EXyk130IufhpC1m48sbwHtWX2SurHi
 VrLFm6aYc78UjROuiBy5/AYhYg==
X-Google-Smtp-Source: APXvYqxeEFi5rmHJrJm/1pMQ3VwLVr7ljjOQDjmrK7U1zimD6tUp8Oc7A+BLuC9s2CodyCEUz+/ziQ==
X-Received: by 2002:a50:8f81:: with SMTP id y1mr53635205edy.181.1568485169421; 
 Sat, 14 Sep 2019 11:19:29 -0700 (PDT)
Received: from [192.168.44.107] ([185.81.138.21])
 by smtp.gmail.com with ESMTPSA id y22sm630728eje.42.2019.09.14.11.19.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 14 Sep 2019 11:19:28 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190910193408.28917-1-alex.bennee@linaro.org>
 <20190910193408.28917-5-alex.bennee@linaro.org>
 <CAL1e-=giNc1e+kN04KqHFQGkJbP4BKziQyxVd3-RTtL+UOfSoQ@mail.gmail.com>
 <874l1j18vm.fsf@linaro.org> <5880b9c9-969f-fa79-f7f4-a45a6568635e@linaro.org>
 <87woeaahrm.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <edb400dc-9542-14b0-6eb2-0192c29cc808@linaro.org>
Date: Sat, 14 Sep 2019 14:19:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87woeaahrm.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::544
Subject: Re: [Qemu-devel] [PATCH v1 4/4] elf: move ELF_ARCH definition to
 elf-arch.h
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
Cc: peter.maydell@linaro.org, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/19 1:51 PM, Alex Bennée wrote:
> I think I'm going to stick with the gross TARGET for now. It mostly
> seems a way of avoiding building per-arch plugins. I assume most out of
> tree plugins will be targeted at a specific machine anyway.

Ok.

> Anyway I think that means I'll drop this series unless 1-3 are worth
> keeping as simple clean-ups leaving out 4?

Patch 1 was supposed to be in another patch set, right?
Patch 2, split, is still a good cleanup, I think.


r~

