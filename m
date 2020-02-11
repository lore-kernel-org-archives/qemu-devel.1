Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BC6C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:37:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F349D206ED
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qjv/canZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F349D206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1aPY-0007AY-4w
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 13:37:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j1aMr-0004mY-6L
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:34:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j1aMq-0008Dw-96
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:34:41 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:51412)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j1aMq-0008An-0k
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:34:40 -0500
Received: by mail-pj1-x1041.google.com with SMTP id fa20so1700365pjb.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 10:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=n4m+epJYNb0ai4smVW5s9ALgRfzKmsG8W7U/CC+sWfo=;
 b=Qjv/canZctlDmlw8InLEI6KTj1dK/yh4f3AZmZN5SSbiZk53GD6Cq7pDpNpfTKAxss
 o5I+PHNWZIqRRDKMCq3f7jcy843dBCuD5J77/r5TmLV9Wv5h4SCa34bRei7QVK6igqq0
 cfbMgyjSmTiyJjQnK5HY2wbFAqED6hYaSEaqXRfz+vSLYyGC93TgM4lfF0lQ0xAx3BJd
 j1UYWZEAYc6r555qUkVOj8N3FBtQ2NM2e8NzzJTdYLj4nKVbe8M2trRrYT7Zhl9ayn3V
 KFblrhiPxh6ptYHUGuXNZnL6Ii9XW1bcjYHnGXNhgOotkzB1RMz8ikiGPe7i9vazVvm4
 AA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n4m+epJYNb0ai4smVW5s9ALgRfzKmsG8W7U/CC+sWfo=;
 b=MjQvS3gLq8mGhv2GnEoxxhaKJzoQbUheWsmpkqoD7oUqi0ha/ZA8kNXfBAE0g03L2+
 TC+xUfrImbaHEBqdeJ673qqUyqWJfiKXaKqM24rKgKc7EEtaWgbDL8hluZOFqZlG8yry
 W8BbbZNt1Vew6is2yXdkTrf8TbqDd8DT5NIAb+I+QyCRE31XPGmWYoT2SIbxzclmG5T+
 4nATxCf1rzD0bAYgglU1L37ksNqjYOrVqgUCVxRIlQOJ/rhyBtXA6mp+//1Rgy2Y79Ua
 UJgeRVNca9pMTPnHfgQJ1aMzh6rOaTEnFfs6fqZff1dXG1gkD/0Ejb89gHhEkOnW9P8q
 YMzg==
X-Gm-Message-State: APjAAAUCt7ia//FShjVTf52fKtIiBU1qkl2p4SL9oJXC/JFPc/wdA9jp
 wEgwqxZnFT5ErFPtYdqw2Y4+vw==
X-Google-Smtp-Source: APXvYqzfdOrg7z9m2m3etGYrS+pb/ztzzIUqIYBIrr0E6VrW9NKrA1sbx5OTXTQ0kfHMNmgZBv8M/w==
X-Received: by 2002:a17:90a:cb96:: with SMTP id
 a22mr5119541pju.96.1581446078867; 
 Tue, 11 Feb 2020 10:34:38 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 s14sm4743221pgv.74.2020.02.11.10.34.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 10:34:37 -0800 (PST)
Subject: Re: [PATCH 06/13] target/arm: Use FIELD macros for clearing ID_DFR0
 PERFMON field
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200211173726.22541-1-peter.maydell@linaro.org>
 <20200211173726.22541-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1125c0a0-aac7-2edd-1cd5-b122f3c3a609@linaro.org>
Date: Tue, 11 Feb 2020 10:34:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211173726.22541-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 9:37 AM, Peter Maydell wrote:
> We already define FIELD macros for ID_DFR0, so use them in the
> one place where we're doing direct bit value manipulation.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> We have lots of this non-FIELD style in the code, of course;
> I change this one purely because it otherwise looks a bit odd
> sat next to the ID_AA64DFR0 line that was changed in the previous
> patch...
> ---
>  target/arm/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


