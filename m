Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6078C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F13620730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYqOxdGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F13620730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyzD3-000792-Ii
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 09:29:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1iyzC0-0005lz-Sh
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:28:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1iyzBz-0003JZ-RP
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:28:44 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42468)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1iyzBx-000332-C2; Tue, 04 Feb 2020 09:28:41 -0500
Received: by mail-pg1-x544.google.com with SMTP id w21so3984751pgl.9;
 Tue, 04 Feb 2020 06:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BXoc4wax9AubX/kELszQsgm/+uB9WOGe3eqVjGcpiX0=;
 b=EYqOxdGk3QW4rrHmD8OwzhRHSopSbc/4P7aowIJGn2Jk+qdEQWP+Tv9ckviOdF9fmf
 XyoxsBsBGS6hBoVMooeD/knR8xU85NapjDV6lYdhc1CGTacHwj9oRl4pyPBqhdMyYEHi
 mS/udBeUcNqka0iT8Xe/37lhRired4e3Du8pOwwANAwGc/V6BJFstPT+347Zmf7IYVnL
 m6eVKV0t/yaa4kIpg+I1k26pwT4cn8E6ZaXymSk4sXVUeNs1ZONsD+GavnYjEXWNvP6M
 OHgVv5GQ1IwJA9LIKg2/JM8bSZeeERiPR3YBWeAY3qJB6ZkrQ8YeynU70lzjtPhti9GJ
 Wqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BXoc4wax9AubX/kELszQsgm/+uB9WOGe3eqVjGcpiX0=;
 b=bZzRBJTvstm4JSSB5QKLDqy5RMWE1JwgtA0iA3g139bKRr43VMT6idHb8YjwIYOkY2
 pHxhNsiT//cZFD4MSxrgHq48rtyKCmFmRVF/MlAs3jwSgbzsldzpTWD2I2sHen5lyDCD
 jf6TyHJZ3xX9kK9nIdaGSACP0gKSOcI/2/CPqLaLZxD2DmPUtpTyt+XVcR0kebXT2c9U
 AVswwgcZC3XrweOrLZ3Q8BSbRM2qm6Si55B+oAsCsR6tYKJqPpjHfA4fEbO5Js+IdhCG
 nxnFT4QGodtQJFLG7YhplmaeQkUavyF1Z29rAWmIneNfy+RNesiWEYguKxBvtJ6ddN7g
 H7Gg==
X-Gm-Message-State: APjAAAW8X3eV1e4/VSsYFzWjayRzkmgzxIpkux+3ecurHA8/OAXYypn+
 MKazkO0fF1bwJrh/A2RPzDU=
X-Google-Smtp-Source: APXvYqyE1uiUwETlh+5dSAeoiT4vF2tQLeoyrf+abBc98JR+PpEniVddTAlCkbAh4BXyhnNtF6hdpA==
X-Received: by 2002:a62:e719:: with SMTP id s25mr29906695pfh.40.1580826520115; 
 Tue, 04 Feb 2020 06:28:40 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 g22sm24113391pgk.85.2020.02.04.06.28.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 06:28:39 -0800 (PST)
Subject: Re: [PATCH 2/3] m25p80: Improve command handling for Jedec and
 unsupported commands
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Alistair Francis <alistair@alistair23.me>
References: <20200203180904.2727-1-linux@roeck-us.net>
 <20200203180904.2727-2-linux@roeck-us.net>
 <accf297f-0c54-7475-8817-c1014999a57d@kaod.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <7fe70871-c0e3-4ff6-bfda-17b45aa50c5e@roeck-us.net>
Date: Tue, 4 Feb 2020 06:28:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <accf297f-0c54-7475-8817-c1014999a57d@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
 qemu-block@nongnu.org, Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 12:53 AM, Cédric Le Goater wrote:
> On 2/3/20 7:09 PM, Guenter Roeck wrote:
>> Always report 6 bytes of JEDEC data. Fill remaining data with 0.
>>
>> For unsupported commands, keep sending a value of 0 until the chip
>> is deselected.
>>
>> Both changes avoid attempts to decode random commands. Up to now this
>> happened if the reported Jedec data was shorter than 6 bytes but the
>> host read 6 bytes, and with all unsupported commands.
> 
> Do you have a concrete example for that ? machine and flash model.
> 

I noticed it while tracking down the bug fixed in patch 3 of the series,
ie with AST2500 evb using w25q256 flash, but it happens with all machines
using SPI NOR flash (ie all aspeed bmc machines) when running the Linux
kernel. Most of the time it doesn't cause harm, unless the host sends
an "address" as part of an unsupported command which happens to include
a valid command code.

>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   hw/block/m25p80.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>> index 63e050d7d3..aca75edcc1 100644
>> --- a/hw/block/m25p80.c
>> +++ b/hw/block/m25p80.c
>> @@ -1040,8 +1040,11 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>>           for (i = 0; i < s->pi->id_len; i++) {
>>               s->data[i] = s->pi->id[i];
>>           }
>> +        for (; i < SPI_NOR_MAX_ID_LEN; i++) {
>> +            s->data[i] = 0;
>> +        }
> 
> It seems that data should be reseted in m25p80_cs() also.
> 
Are you sure ?

The current implementation sets s->data[] as needed when command decode
is complete. That seems less costly to me.

Thanks,
Guenter

>>   
>> -        s->len = s->pi->id_len;
>> +        s->len = SPI_NOR_MAX_ID_LEN;
>>           s->pos = 0;
>>           s->state = STATE_READING_DATA;
>>           break;
>> @@ -1158,6 +1161,11 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>>           s->quad_enable = false;
>>           break;
>>       default:
>> +        s->pos = 0;
>> +        s->len = 1;
>> +        s->state = STATE_READING_DATA;
>> +        s->data_read_loop = true;
>> +        s->data[0] = 0;
>>           qemu_log_mask(LOG_GUEST_ERROR, "M25P80: Unknown cmd %x\n", value);
>>           break;
>>       }
>>
> 


