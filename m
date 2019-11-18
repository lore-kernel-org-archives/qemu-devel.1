Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C41C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 08:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8530820740
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 08:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U48cRy6m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8530820740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWceD-0002kW-Nw
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 03:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iWcdJ-0001Xl-Ut
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:43:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iWcdI-0008W3-Tc
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:43:41 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34076)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iWcdI-0008VR-NB
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:43:40 -0500
Received: by mail-wm1-x343.google.com with SMTP id j18so15347910wmk.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 00:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OThwzwcmfVdhWRvXT7ysvqywDTFm+pWTsMJCbHwbx5s=;
 b=U48cRy6mRRZweTCUpDWLJBdMBfqFooq/U5oMW5uYlHcnNPb8hHlnQICpqnp1LLzT4I
 Ehvtax1UK7zN2LV7iTJiwsqskdppuqeOnO7JJRB3+4LuuTGyh4IJykmFGcjfsPY8UKnD
 FYRUPXOm7Oa7wO8Qlw1md3zWdHQHh6mh90+k0d+H4lF+zgtSaDlgihs0YeQHgJcBCFIk
 zlnw3joUmj4qcpTfsHPeecdwfqT17xm7sq14KCbkXtVk0XLXQVCK9KRnLN/hqaRxLy9X
 /HZZOOE5waPwTjTnWAQNqUvsHIxvJFjwZXMembiE5Ss5IhKtPMackhB7rJFQSAkoLXp6
 kOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OThwzwcmfVdhWRvXT7ysvqywDTFm+pWTsMJCbHwbx5s=;
 b=lWYZgeLXisytSH/Uf6H1ndk7kFRbn3TDcydUUc8hKerCZH26lnUrFT5BWaA4CrXEAk
 yyT4bNy3VBnWAE8YW6YBcD3CZLQa86PSgfpAMWeSJNcnNz1P199AbKvZudjSZk0Fg+ha
 JkD+WPGEnnbPElUW4BjFs4lyn0py0g2963yrAxSK0Zt0H0ZX6hAt4fPaPXoykNKVO36Z
 AmbzBOwEnJ56ywT6rIOLYa1qlKtjJW0M9CA35AT/zdusY7OYbvkh37BvPJwG9N/0LyM3
 gwogseSwzYQUTk5XoqxfablJzngx8Qcfj1ga2kc35cAKMAASsTdhZbdmyHIKlUPtvDjr
 wcTg==
X-Gm-Message-State: APjAAAU8Sj5L/yukZa0x5X1LAaimV3x0foldiHGpYQYpSB9Bnuv4aYqI
 TPL1or61pynbfRnAwF1VZbvmCQ==
X-Google-Smtp-Source: APXvYqz20zl4rmnZduEDPX62eX094sM8D1GenICsD68Nju1I7JuHhvj1+4XOkVZ6N7PFZOPWxGNl0Q==
X-Received: by 2002:a1c:de88:: with SMTP id v130mr29402088wmg.89.1574066619549; 
 Mon, 18 Nov 2019 00:43:39 -0800 (PST)
Received: from [192.168.8.102] (65.red-79-149-41.dynamicip.rima-tde.net.
 [79.149.41.65])
 by smtp.gmail.com with ESMTPSA id x9sm21554339wru.32.2019.11.18.00.43.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Nov 2019 00:43:39 -0800 (PST)
Subject: Re: [RFC PATCH 10/11] target/arm: explicitly encode regnum in our XML
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191115173000.21891-1-alex.bennee@linaro.org>
 <20191115173000.21891-11-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d2778bae-5d04-5954-e552-9a426683ed34@linaro.org>
Date: Mon, 18 Nov 2019 09:43:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191115173000.21891-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, luis.machado@linaro.org,
 alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/15/19 6:29 PM, Alex Bennée wrote:
> This is described as optional but I'm not convinced of the numbering
> when multiple target fragments are sent.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/arm/cpu.h     |  2 +-
>  target/arm/gdbstub.c | 16 ++++++++++------
>  target/arm/helper.c  |  2 +-
>  3 files changed, 12 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

