Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8549DC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:55:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CC1F208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pizo1+BF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC1F208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33406 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfnnW-0007sJ-Dq
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 11:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34937)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hfnXe-0004o4-BQ
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hfnXc-000167-CR
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:39:30 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45212)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hfnXa-000138-K2
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:39:28 -0400
Received: by mail-wr1-x442.google.com with SMTP id f9so18388073wre.12
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 08:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lCDJTC6WA+l8tBCmzLMSHsK4MkvDe8DwdEoZdZKwBkE=;
 b=pizo1+BFwkEzlbY2wkUShLk7cWZqWy1pYEPGkNzPlEaGgcx6BmbbeXjgg7/R5x2H4R
 XNu6QoFA3DwhzH308t9eEwlNZWWAVvnsdfuP1pHRJk6a09LxPW6hYKxe+uaDRD8MXaeK
 2dG57RUueET6MgQS/pGUeTcZhSuueXUX87lgZYu+0Av4mvZ/lFhiEyJK7KdIRomCJpp9
 //0xws3MQH4vzABBGptkCdmbHFRf/tW0GjYp8JJKicF6sVCHoIITMjEbCuzW4SbT0ooA
 N/50xtbEEC6X1OYBZDIy5aUjT5xfA6+f9xfBi3vHMZ6X1bPvE1g5W1l361HbZJ2rDc8Q
 bzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lCDJTC6WA+l8tBCmzLMSHsK4MkvDe8DwdEoZdZKwBkE=;
 b=JzUFUC/OFEzlfxHrkGpIJ2wWBBl+vShDrCqKzwo9Sryi/u/IeA/9zjfupIkrnzK+L4
 Ag48+DWD0KIA5GGSpCBsi1mEh95NNeBo5h7k85MBbVworyA8dfFq/KkkdrMi1yxuUtev
 EsUT0p1ya/pm5xFDx/Pd9YxmDbsMXBCNrDc6s3w16MzKg81LwlLFk9X8qdllmhB8Te3e
 qizGXo+SrspaFuc5mNZxZ9jfS+zTTALZ5HDP7YyeiY9fJ+99mQPmJGk6oum2We2Yk6Eo
 OeDBE4FFbRbzjUkeBLuGW0f9pMYiLQhWvXGdlvwfsw8H69ZXz7VqZRLP6HtfkMxEN+vu
 nRLQ==
X-Gm-Message-State: APjAAAWtDcmX/MxNQ+JIXOEhZqKJybFt66Of6l/Zahlq28f5QdzhxW8L
 r3W4klZTB/FpiYY2obMhhl8I5w==
X-Google-Smtp-Source: APXvYqyat9rGILno5raa15hBSeamTMcNmvl24nhZYjbFdI6cvKCYhH/HuBo/Euu9J3tFtW8O+wDKOQ==
X-Received: by 2002:adf:fbc7:: with SMTP id d7mr7961685wrs.224.1561477163765; 
 Tue, 25 Jun 2019 08:39:23 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id x3sm15194507wrp.78.2019.06.25.08.39.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 08:39:23 -0700 (PDT)
To: Joel Sing <joel@sing.id.au>
References: <20190616191900.GH61734@hippo.sing.id.au>
 <41ef5fbf-f438-e60a-2fba-a72e3ad422f9@linaro.org>
 <20190624180837.GM61734@hippo.sing.id.au>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <8ec410f8-d2a0-69ef-e3b7-925ef09717df@linaro.org>
Date: Tue, 25 Jun 2019 17:39:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190624180837.GM61734@hippo.sing.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH] atomic failures on qemu-system-riscv64
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
Cc: me@carlosedp.com, qemu-riscv@nongnu.org, palmer@sifive.com,
 qemu-devel@nongnu.org, Alistair.Francis@wdc.com, marco@decred.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/24/19 8:08 PM, Joel Sing wrote:
> From 8ef31a2ce8ef1cbeee92995a0b2994f480e9bb6d Mon Sep 17 00:00:00 2001
> From: Joel Sing <joel@sing.id.au>
> Date: Tue, 25 Jun 2019 02:44:24 +1000
> Subject: [PATCH] Clear load reservations on qemu riscv target
> 
> This prevents a load reservation from being placed in one context/process,
> then being used in another, resulting in an SC succeeding incorrectly and
> breaking atomics.
> 
> Signed-off-by: Joel Sing <joel@sing.id.au>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +    /* Clear the load reservation - otherwise a reservation placed in one

Excepting this line, which will fail checkpatch.pl.
Needs to be formatted as

    /*
     * Clear the load...


r~

