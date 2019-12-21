Return-Path: <SRS0=aHsE=2L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56387C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 11:16:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 214E52070C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 11:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+MRgrRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214E52070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iick6-0006lW-4k
	for qemu-devel@archiver.kernel.org; Sat, 21 Dec 2019 06:16:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44509)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iicjH-0006KO-BW
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 06:15:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iicjE-00030G-Cp
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 06:15:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48831
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iicjD-0002sW-LN
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 06:15:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576926922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TnZ7gaTqbNN6SAhELHPAPD65sZK7sU9LydQT6SQ2A28=;
 b=D+MRgrRJPFF+nbnKzy338hor4MUPOQHAfPIopQ7Uw2JqwO9PKcmkjoTua7PfvBzy+hV9G3
 0xPJax8yRhwCuuisbVqOcjQuHYG32z5fdZj3wBviScDleQaBm9d9BR8sSmo7wuLQ5Z7ClJ
 0B69oRVVaX0+Z+h9TBGtABEJcX52WGE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-oDq_m5EhNGuvdC1dpy_WKg-1; Sat, 21 Dec 2019 06:15:07 -0500
Received: by mail-wr1-f72.google.com with SMTP id u12so5080721wrt.15
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2019 03:15:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FNcBZP0Os+2NoFt3rfmsuz9tMpJXTzR60z1K3dQFlpQ=;
 b=AAWJPreQKwkAcJAULB+AX1d/XDSffK6+8rskORJdkyamcayUPM6mqY40eF+EqjcGry
 7NfmUujG6JaIroEQxxbr7WOp3i6kF6ijjVL3ojcyVt2NycjtvzjqNqnoJwq/K1q7xNkn
 Smk5KH/YkWN4pxc4X7YsOW+XgAbUwatnINC/3N3gb/RuHwMqMJ5vhE/7WizMst1+94X1
 e2H4q0VcEJNOrou/Wx0pkC6Y0xLv1Tqm7zrzcZjRhp6QHd3JHaCTxDe9LzWZ1vXCFVFV
 TJHzLrerHAMPapEj7g2xCNzLl2Rlvu+w8RiizeHqHzmDJ+bDMB5Y5trAEJQon3YxUwfW
 CcaQ==
X-Gm-Message-State: APjAAAVPwyp05YBNBk6BxbQYfnMxftjru4NrZr9VNHA/jCk4HdkdpCG6
 RzNY4EdVhoiJ0hnMOnvccMxVfmNBzkEc9U86bmSHHchGTevAkiqB53LxWf3W1DGQDC7SAZlXpP1
 6f7uJUchyGKNipWs=
X-Received: by 2002:a05:600c:2488:: with SMTP id
 8mr21223707wms.152.1576926906130; 
 Sat, 21 Dec 2019 03:15:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqx52v9qoz6pXtp+ysKq/ErQwpd9ZNg5wj84b7dJnGgFUlHWo7NAlsEcRnhcm4K9/FjpYM1TrQ==
X-Received: by 2002:a05:600c:2488:: with SMTP id
 8mr21223694wms.152.1576926905927; 
 Sat, 21 Dec 2019 03:15:05 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id a133sm12859328wme.29.2019.12.21.03.15.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Dec 2019 03:15:05 -0800 (PST)
Subject: Re: [PATCH v2 3/8] hw/avr: Add some ATmega microcontrollers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Michael Rolnik <mrolnik@gmail.com>
References: <20191221010226.9230-1-f4bug@amsat.org>
 <20191221010226.9230-4-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b8c186f8-9684-a636-d93e-027c218517c8@redhat.com>
Date: Sat, 21 Dec 2019 12:15:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191221010226.9230-4-f4bug@amsat.org>
Content-Language: en-US
X-MC-Unique: oDq_m5EhNGuvdC1dpy_WKg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/21/19 2:02 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Add some microcontrollers from the megaAVR family (ATmega series):
>=20
> - middle range: ATmega168 and ATmega328
> - high range: ATmega1280 and ATmega2560
>=20
> For product comparison:
>    https://www.microchip.com/wwwproducts/ProductCompare/ATmega168P/ATmega=
328P
>    https://www.microchip.com/wwwproducts/ProductCompare/ATmega1280/ATmega=
2560
>=20
> Datasheets:
>    http://ww1.microchip.com/downloads/en/DeviceDoc/ATmega48A-PA-88A-PA-16=
8A-PA-328-P-DS-DS40002061A.pdf
>    http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2549-8-bit-AVR-M=
icrocontroller-ATmega640-1280-1281-2560-2561_datasheet.pdf
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> v2:
> - Reword description adding more information (Aleksandar)
> - Use DEFINE_TYPES and memory_region_init_ram (Igor)
>=20
> Cc: Igor Mammedov <imammedo@redhat.com>
> ---
>   hw/avr/atmega.h      |  48 +++++
>   hw/avr/atmega.c      | 460 +++++++++++++++++++++++++++++++++++++++++++
>   hw/avr/Makefile.objs |   1 +
>   3 files changed, 509 insertions(+)
>   create mode 100644 hw/avr/atmega.h
>   create mode 100644 hw/avr/atmega.c
>=20
[...]
> diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
> index 626b7064b3..4b6b911820 100644
> --- a/hw/avr/Makefile.objs
> +++ b/hw/avr/Makefile.objs
> @@ -1 +1,2 @@
>   obj-y +=3D sample.o
> +obj-y +=3D atmega.o

Should this have a proper Kconfig entry, and in next patch Arduino=20
selects it? Probably cleaner and in match with other archs.


