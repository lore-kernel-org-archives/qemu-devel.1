Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECA3C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:20:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2F520674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3HimXrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2F520674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyz3n-0005mt-Lf
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 09:20:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1iyz2u-0004st-0J
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:19:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1iyz2t-0000IL-1A
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:19:19 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41173)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1iyz2q-0008I8-8F; Tue, 04 Feb 2020 09:19:16 -0500
Received: by mail-pl1-x642.google.com with SMTP id t14so7332294plr.8;
 Tue, 04 Feb 2020 06:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ftb1eK4A7nz9bJZumLSepoTRLBcPi3e0VP/9N7S47X8=;
 b=i3HimXrFKb/AYK4EG3lbKUc05czkyC4ivnW60CpkSwPQ9KxKELFCkF358WC2vRIoZi
 Wij7dl3wkha73MIdlmOa6FfELyZ58BJNv/K8gWjXYgAy6+JpKKI1R8nS2Tizcj3/0sGi
 Q++g9fFzlY3sgPwWLfOP0fPddjbD/drWXCG/islo8iD+BB8q+Pc2vJ7ymJpNcL6lPPjT
 wazplvUk2GhQx5GW09LLelntL2BEwpgzgGtEjlUmklPtmwxebpuMea3WnKOD6h7ddci8
 RPOamyndlVFeglxIvanVoXgi2TusFAWFJUbIAlPil5L1jE6KVaeScqCueeHTwteRxtpf
 4Z8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ftb1eK4A7nz9bJZumLSepoTRLBcPi3e0VP/9N7S47X8=;
 b=KqYCY9J5fOHoj4j8H35k9YxY6LPN2Co87rqu1T7ZRncL4MXhXib/t3Og1UNvrG3fA4
 45eEixXL/FQAhWZvxO3JkgXdhcvEnjCLXw0wjedOQQQhu7p8iYgtpDfMbAl9UeSTotJI
 0FvghMp+EmpWlYXW8muKk+/xxMNHsQ43g2FxcCC32EujbJHCVnsT/IIYmGhVBNZPsWP8
 LEX6hgymnH3rbkV0ufMeBHAqMIla0l52nfd5l3XdYZ+yHqSIo2NxEEmfB1UuikxHW28w
 AKjFA2NShwA+fX9u0BJ1Bz+7k0W63t3j8wMey6MRr9AxCCD2i35mfzH0rojB3qCUBmj5
 HDrg==
X-Gm-Message-State: APjAAAU0ONDSUcociuktQnThoYnxUFvhiWsutwcfE236SS2WfAJ1UdWm
 Y93E0WKaS3J+FQd0cRNHiy0=
X-Google-Smtp-Source: APXvYqwgbi5KgPBpCRoHjI6c744FrB8EWw+mDYCL4z9SYZtgWu3ya2LrC43zpLWhEpwEKOiD4oCblA==
X-Received: by 2002:a17:90a:db0f:: with SMTP id
 g15mr6516742pjv.40.1580825954257; 
 Tue, 04 Feb 2020 06:19:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 t65sm24462939pfd.178.2020.02.04.06.19.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 06:19:13 -0800 (PST)
Subject: Re: [PATCH 3/3] aspeed/smc: Fix number of dummy cycles for
 FAST_READ_4 command
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Alistair Francis <alistair@alistair23.me>
References: <20200203180904.2727-1-linux@roeck-us.net>
 <20200203180904.2727-3-linux@roeck-us.net>
 <329f6d24-6d47-4e2e-1a66-7683bc0529a9@kaod.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <957018b6-4b38-4acf-da8b-dbe2fee24ec3@roeck-us.net>
Date: Tue, 4 Feb 2020 06:19:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <329f6d24-6d47-4e2e-1a66-7683bc0529a9@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Francisco Iglesias <frasse.iglesias@gmail.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/3/20 11:45 PM, Cédric Le Goater wrote:
> On 2/3/20 7:09 PM, Guenter Roeck wrote:
>> The Linux kernel recently started using FAST_READ_4 commands.
>> This results in flash read failures. At the same time, the m25p80
>> emulation is seen to read 8 more bytes than expected. Adjusting the
>> expected number of dummy cycles to match FAST_READ fixes the problem.
> 
> Which machine are you using for these tests ? the AST2500 evb using
> the w25q256 flash model ?
> 

Correct.

Guenter

> Any how, it looks correct.
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Fixes: f95c4bffdc4c ("aspeed/smc: snoop SPI transfers to fake dummy cycles")
> 
> I think commit ef06ca3946e2 ("xilinx_spips: Add support for RX discard
> and RX drain") needs a similar fix. Adding Francisco.
> 
> Thanks,
> 
> C.
> 
> 
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   hw/ssi/aspeed_smc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
>> index f0c7bbbad3..61e8fa57d3 100644
>> --- a/hw/ssi/aspeed_smc.c
>> +++ b/hw/ssi/aspeed_smc.c
>> @@ -762,11 +762,11 @@ static int aspeed_smc_num_dummies(uint8_t command)
>>       case FAST_READ:
>>       case DOR:
>>       case QOR:
>> +    case FAST_READ_4:
>>       case DOR_4:
>>       case QOR_4:
>>           return 1;
>>       case DIOR:
>> -    case FAST_READ_4:
>>       case DIOR_4:
>>           return 2;
>>       case QIOR:
>>
> 


