Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AE0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B14FB2077C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzRzIqyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14FB2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuiY9-0002tL-T5
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iugBU-00038F-2r
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:22:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iugBS-0007vt-01
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:22:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47887
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iugBR-0007vN-OY
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579800140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dt1vx9CQ8Rq88eZh2Kp4Sz9fZc6c3t91NtQLNsBP9SM=;
 b=VzRzIqyIhv98MlGxAFf75dFKKpL0Bwk5ieMycKDWZoNNmVwHkIVZ7zpYKQzGslKvTRVJ7H
 xgBHB4XgcgvZBT1LZoR7QZFW/P2iUrpNvgpT84WXHaxDQ3tdxUuWhdplXNwTOgvDQjMNiW
 FR0cCGh1bOcyFXN6mxo0tRfVRVg3oK4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-ejyoMx2fMmK-JaUtXzA5Xg-1; Thu, 23 Jan 2020 12:21:59 -0500
Received: by mail-wm1-f70.google.com with SMTP id n17so965776wmk.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 09:21:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rgMr5G+dNZcGxS6gXizKYDjDxNrxoiX+1AWd+DLUd/I=;
 b=ej0at8jVsm9ikIBt4L4mF227s/0Fk1NA25tYwYMnN77FVj0O3rHdqyV9uTnZoBmH6t
 Zn7OXG9FsgAE64P2Awev0QD8CuvdZbsQY3HuraVZGLkFesM1wLDrAX3uX5HUzPo3kT0r
 xFzYT0MYdhduxwXVLS1MYqf+lx44tF5PaASvPXGv+lyQsee56QqeLMhhRwGgO+Zf0Ddk
 gDpkKX00ILfuKlF2iKkw5ZvGXKbR+KjxxDtWR8hxcPBhL3+TgXSE3MF1ND0azO1OqSZW
 s7uAY1OQzVhjCLwfNbpMaPGuNFDLXzT+qyvtA2Na6mqFmukk0WZM67ACrrCBVoH1Judw
 IsJw==
X-Gm-Message-State: APjAAAXhnj31/pBc9zEHUGRfFJ1tJOjYFfyHMm0pm+678PG8bM9kcsaF
 vL67mE696FA2PFwn5eYWfMYJtkp8lV1OAHWUNsVU85dI1OxvRQS06/jsGsgdEPyMNFmvj8TmmA9
 Li+CYYK+dnBd7KOo=
X-Received: by 2002:a1c:b486:: with SMTP id d128mr5018004wmf.69.1579800117889; 
 Thu, 23 Jan 2020 09:21:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqybgcYWdaL7/QxqSp/tvdaoTZ+LRM4Ael34FImn/+keqpJlPm7JoxuoAkPR5ovXQGX2/eUpzw==
X-Received: by 2002:a1c:b486:: with SMTP id d128mr5017984wmf.69.1579800117614; 
 Thu, 23 Jan 2020 09:21:57 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id c9sm3730970wme.41.2020.01.23.09.21.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2020 09:21:57 -0800 (PST)
Subject: Re: [PATCH v3 2/2] MAINTAINERS: Add an entry for the Siemens SX1
 (OMAP310) machines
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200120185928.25115-1-philmd@redhat.com>
 <20200120185928.25115-3-philmd@redhat.com>
 <CAFEAcA8-aM=B6G-Zin-yEJycf6v1Brhxkn8it30jPDqrKkyWgA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a8520409-2402-8ae8-f37d-264c2ecdbc10@redhat.com>
Date: Thu, 23 Jan 2020 18:21:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8-aM=B6G-Zin-yEJycf6v1Brhxkn8it30jPDqrKkyWgA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: ejyoMx2fMmK-JaUtXzA5Xg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/23/20 3:55 PM, Peter Maydell wrote:
> On Mon, 20 Jan 2020 at 19:00, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>
>> Add the Siemens SX1 (OMAP310) cellphones with the other ARM machines.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   MAINTAINERS | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 52fbc18566..27fbe1abb4 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -560,6 +560,12 @@ F: include/hw/arm/digic.h
>>   F: hw/*/digic*
>>   F: include/hw/*/digic*
>>
>> +Siemens SX1 (OMAP310)
>> +M: Peter Maydell <peter.maydell@linaro.org>
>> +L: qemu-arm@nongnu.org
>> +S: Maintained
>> +F: hw/arm/omap_sx1.c
>=20
> At least as far as I'm concerned this is 'Odd Fixes'
> status at best. I don't even have any test images
> for it.

Yes, 'Odd Fixes' sounds right (I copied the OMAP section).

Are you OK if we deprecate it?


