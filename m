Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA770C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 20:23:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9537721835
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 20:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W82Rgic1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9537721835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuj10-000422-LK
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 15:23:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iugMP-0000Hd-R6
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:33:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iugMN-0000xP-1f
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:33:40 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20203
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iugMM-0000wY-Dp
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579800817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o07gWkebbrxJDhRzeCl+Kxrs2Cf0u0YGKVb7Jgdq0/4=;
 b=W82Rgic1qJcgcYzmIgGHt6a74s5jXkGO+TwUqbF7J1IdFvxxfJUzTXheYek9oVtjOhkqdH
 EKeIVhgemGTrGe+3vsTAAmxJP82iJPTjBZfEfJP5Yk4Ddj/yHDegvCKbAKbxWbSRXa0bHE
 dhQWuOnzCWAaTkzFHpdPWMI3iCBJBwQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-uuvSgqzWP-a9QH7_-siMcg-1; Thu, 23 Jan 2020 12:27:30 -0500
Received: by mail-wr1-f71.google.com with SMTP id f17so2170216wrt.19
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 09:27:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n1ACcanPc4AuBx4IPxKIuth8RyD/GZI7DbLgHWsIpDs=;
 b=VVxFMqW3dMmzqlSUO2BhsYJ9WUdRUC3wYK3b7PO97LMarGNlKXn1b90Edp2IkuwJDM
 Sorbg+GhEEUGaaWOTKxnwIxA9OVqvY1OxikT4rhMetpLFDAg6u3VVaG6mk7/Q8wFmaJ4
 Cgofvd3adwizxA164Xr9b4LrMyNChK5f9+7Ol7vMWKHrEDR0Xwj3S3+ITdv3adt9qEXj
 h1FZ8GumrcZQDlRV6wlXtKwRxWnKxff5ZaQFyI80SenB4YjJyJc0IXBrj9mCx2VsooIN
 KJagUJw3qC8zQ0iu+D1B3aV1CCssvpfDfUocC1em1KzjTQWeGIC8RqxpYotVJMAtVoEt
 aH1g==
X-Gm-Message-State: APjAAAW+dLmAbbwQ4hki1E4RM3FwvzRwIkwQzim4SXyhlAWanPBv08kI
 yzEBhA8KfXzitzKrd0XFnzPcggXxR6DBnfvUvXBOKWOzjJXxY8YJWUh2nyVIBxVWf0k2S6/qPzD
 8ZB5bxh7sGPh5cgM=
X-Received: by 2002:a1c:9c87:: with SMTP id f129mr5435064wme.26.1579800449216; 
 Thu, 23 Jan 2020 09:27:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqz1284VPig2/8U3hSPzY29dBLhmKdpO+Bm9wOwhFaG1RwrG/QnE5g2BAnyVsw+9I4NIE1AOdQ==
X-Received: by 2002:a1c:9c87:: with SMTP id f129mr5435042wme.26.1579800449015; 
 Thu, 23 Jan 2020 09:27:29 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id a132sm3469750wme.3.2020.01.23.09.27.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2020 09:27:28 -0800 (PST)
Subject: Re: [PATCH rc1 18/24] hw/avr: Introduce ATMEL_ATMEGA_MCU config
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200123000307.11541-1-richard.henderson@linaro.org>
 <20200123000307.11541-19-richard.henderson@linaro.org>
 <18202992-bb80-d873-89e0-d1c31ff3fd22@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <486ecd04-381d-07d2-16b4-51b7a7b6ee7a@redhat.com>
Date: Thu, 23 Jan 2020 18:27:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <18202992-bb80-d873-89e0-d1c31ff3fd22@redhat.com>
Content-Language: en-US
X-MC-Unique: uuvSgqzWP-a9QH7_-siMcg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: S.E.Harris@kent.ac.uk, dovgaluk@ispras.ru, me@xcancerberox.com.ar,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, mrolnik@gmail.com,
 imammedo@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/23/20 6:04 AM, Thomas Huth wrote:
> On 23/01/2020 01.03, Richard Henderson wrote:
>> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Message-Id: <20200120220107.17825-13-f4bug@amsat.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   hw/avr/Kconfig | 5 +++++
>>   1 file changed, 5 insertions(+)
>>   create mode 100644 hw/avr/Kconfig
>>
>> diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
>> new file mode 100644
>> index 0000000000..da3b10afec
>> --- /dev/null
>> +++ b/hw/avr/Kconfig
>> @@ -0,0 +1,5 @@
>> +config ATMEL_ATMEGA_MCU
>> +    bool
>> +    select ATMEL_TIMER16
>> +    select ATMEL_USART
>> +    select ATMEL_POWER
>=20
> Just my 0.02 =E2=82=AC, but I'd rather squash it into the next patch.

You are correct. I used a preliminary patch because the 'sample' board=20
was still present in the series sent to Michael:
https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg04384.html

Since Richard the Arduino boards replace it, we should squash this.


