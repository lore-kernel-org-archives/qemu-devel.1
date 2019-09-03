Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42214C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 18:24:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CE2E20828
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 18:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="prC22F6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE2E20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5DTT-0002ZV-2M
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 14:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5DSU-00022H-1i
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 14:23:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5DSS-0008PO-Sp
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 14:23:13 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40410)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5DSS-0008Ol-KR
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 14:23:12 -0400
Received: by mail-pg1-x541.google.com with SMTP id w10so9591637pgj.7
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 11:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+VUwAlVM2cI1IKg+ezBoLvZ9Bv6e+ecmrYteWE86y0E=;
 b=prC22F6I/2VPj7J9DvqwUqgaJcT2Ax9D8TPD24Vn+3STBCVF9EGZYx1gqGDHCI9Vla
 5Zu17+DSTxjPRLUROez1BaLWd22cICcqTr/b2yrCsfxLByaVGQUFlTFbw+sVHlQAr8uG
 BV+8b/5pufA7gTVP/NhUB64Y/CKpuB22q1DAV4SVWcoLIpqwtafLEs7oZLsVj9j79s53
 VKdDtmKT7GfLz4dh014CCvafX7h1/TlJfoLqP4eKw6fzwqPj05W89eW3kMDm1jmqgAzH
 xB5fMMnkZCG9zZke622zbT1M1F8hE1geCpVbBG1gq+t+T15/7Fc8hhz88IAlcw9CoWFh
 VZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+VUwAlVM2cI1IKg+ezBoLvZ9Bv6e+ecmrYteWE86y0E=;
 b=cDZ2I8TuJf2nPVzrkBbbCVEwCWbVdNKWe0yXkH4z0ok2+4FEELFHWwX/N5RNeHFewR
 aGU30WweeDGOYX1Ka0pdjxHAev1/JjUDxKHfELNqhCPgO83QRpKrYZgzzi4cf9ORmJ5A
 TY3cZwU3qbjIxcRiU9KvKdxn+uVA9mYJobKCvjOM1c6E76ydUCM4m0AzpB22l46tfto8
 EkscbC4W4Is1aomoE4+Ny6bXd0HgPoxdmPac9AvY2nZtOXGEhli4mC+/8i0iIR5vB2pe
 nK1nLTzz56xy8CdUsufyU2C5eAogdDQ6qH2r2BtMcrTgt46HeOOaAAzaUtSl3kHoF6me
 HIww==
X-Gm-Message-State: APjAAAXfVsjbD5eXFdJjT+IHnyg39P1v7dC55kBwXHwvF1O/262Ybw5V
 tQFutqIXcggJHb+J9oT4zfcNAg==
X-Google-Smtp-Source: APXvYqxkfZ7jbMPRemj2jqcowRS3G2WI1uqazHScX7VWtaBYxoVHHK1qje/0uJKgZxj6XBoW1O+d2w==
X-Received: by 2002:a17:90a:bf01:: with SMTP id c1mr709756pjs.30.1567534991103; 
 Tue, 03 Sep 2019 11:23:11 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z29sm26893145pff.23.2019.09.03.11.23.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Sep 2019 11:23:10 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190903154810.27365-1-thuth@redhat.com>
 <20190903154810.27365-4-thuth@redhat.com>
 <bb6eb994-532e-7afc-bb27-aa5d56080b50@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <42d43c33-e316-81de-4ec6-13c8a6d04660@linaro.org>
Date: Tue, 3 Sep 2019 11:23:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bb6eb994-532e-7afc-bb27-aa5d56080b50@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [RFC PATCH 3/3] target/arm: Make m_helper.c
 optional via CONFIG_ARM_V7M
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
Cc: qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/19 9:19 AM, Philippe Mathieu-Daudé wrote:
> On 9/3/19 5:48 PM, Thomas Huth wrote:
>> We've already got the CONFIG_ARM_V7M switch, but it currently can
>> not be disabled yet. The m_helper.c code should not be compiled
>> into the binary if the switch is not enabled. We also have to
>> provide some stubs in a separate file to make sure that we still
>> can link the other code without CONFIG_ARM_V7M.
> 
> If there is no M support, the translate code shouldn't even generate M
> calls, so the stub shouldn't be necessary.

No, the symbols are still required for link.

> Anyhow I guess this code will be simplified by the ongoing decodetree
> conversion from Richard.

No, the decodetree conversion will not affect this at all.


r~

