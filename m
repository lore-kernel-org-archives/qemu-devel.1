Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3441DC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:21:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3EB920740
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEg0xPDh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3EB920740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZEIh-000883-2F
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 08:21:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZE5C-0005W9-Mz
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:07:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZE5A-00072F-Pl
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:07:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40786
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZE59-00071k-3D
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:07:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574687230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=006G3GA3tOQGxBjDMES8FWn/jj2JIGTz+zvys5oFahI=;
 b=PEg0xPDhYKxEiNsEStQ0ZU3rKZjsNQKa96LE8FMHOJmlRmJFOKYM+80/zNOe3bxUtMcUkC
 /ogeRlb20ljp3Z6TnpB6qNuH95rXRmKJWfzrR0N96umFjQTSpWd6jFhW8y9FPADC1dSgBf
 ppBtkEiWnkWDjfx2DrX52N4BnaV/GdQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-0EUQYw9lOkCZOENYVCcGtA-1; Mon, 25 Nov 2019 08:07:09 -0500
Received: by mail-wm1-f71.google.com with SMTP id v8so4539478wml.4
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 05:07:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xTcSBEsYVgOHYuOYONZmSVsrznxxUGWIqiXuR9K4h38=;
 b=Fnf5VgmgYmIpRePZll6Eud82Tuvv8OxfLaFUm/WmiVUyeFZopfY7HyOMzr0ibF4To6
 KBXRaJkia6pc38L2i6Jtey+nmF7KYLdjvAwJ9x3HEkKEpckrH9aSjeq43owwlW6fybaI
 PI0CPz6f03AuS1gTqx8015Nj4ncRPxMR2mfrOeGMe9gC3yUb9IuCHxWJd1Eh5IH1PwKz
 rNTqDmFWzhl1NYaW8CVGwsISwyRDnUcdXOOtoXszLWEP78qG3QTG+SBCJfjfI75A9vhf
 tCgFPRzghRwcv5gDNAKK9JFjdM3JSc12hiFirPkUGRgePbod2nHadI1thR+UP/18l5jf
 C4eg==
X-Gm-Message-State: APjAAAXKJhbpgUNYvmtqeVxnnRmalsBbbWoWlB5u60N9ybxJy92ZLuWk
 d1E1cKOSe/S6Si1fC0TqrLIn1XKJ1d19+vWtZb7jMfbHB2BWB9eMP0/ErdujXJSwbYF5G35bpvu
 AB2ACyZgLmOhAwGA=
X-Received: by 2002:adf:e2cd:: with SMTP id d13mr31939252wrj.221.1574687228047; 
 Mon, 25 Nov 2019 05:07:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqwFy9gIaaRcMpT9IBCNntZdU9lOOndNH808/lBsZyk4EgUGSfV1iCBH3KdEsdeRdC/lBlZcsQ==
X-Received: by 2002:adf:e2cd:: with SMTP id d13mr31939213wrj.221.1574687227826; 
 Mon, 25 Nov 2019 05:07:07 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id f24sm8389062wmb.37.2019.11.25.05.07.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2019 05:07:07 -0800 (PST)
Subject: Re: [PATCH v6 1/9] hw/core/clock: introduce clock objects
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
 <20190904125531.27545-2-damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <560f9a2f-b604-69e7-7114-13e167102872@redhat.com>
Date: Mon, 25 Nov 2019 14:07:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190904125531.27545-2-damien.hedde@greensocs.com>
Content-Language: en-US
X-MC-Unique: 0EUQYw9lOkCZOENYVCcGtA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 alistair@alistair23.me, mark.burton@greensocs.com, marcandre.lureau@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com, edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/19 2:55 PM, Damien Hedde wrote:
> Introduce clock objects: ClockIn and ClockOut.
>=20
> These objects may be used to distribute clocks from an object to several
> other objects. Each ClockIn object contains the current state of the
> clock: the frequency; it allows an object to migrate its input clock stat=
e
> independently of other objects.
>=20
> A ClockIn may be connected to a ClockOut so that it receives update,
> through a callback, whenever the Clockout is updated using the
> ClockOut's set function.
>=20
> This is based on the original work of Frederic Konrad.
>=20
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   Makefile.objs         |   1 +
>   hw/core/Makefile.objs |   1 +
>   hw/core/clock.c       | 144 ++++++++++++++++++++++++++++++++++++++++++
>   hw/core/trace-events  |   6 ++
>   include/hw/clock.h    | 124 ++++++++++++++++++++++++++++++++++++
>   5 files changed, 276 insertions(+)
>   create mode 100644 hw/core/clock.c
>   create mode 100644 include/hw/clock.h
>=20
> diff --git a/Makefile.objs b/Makefile.objs
> index a723a47e14..4da623c759 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -153,6 +153,7 @@ trace-events-subdirs +=3D hw/audio
>   trace-events-subdirs +=3D hw/block
>   trace-events-subdirs +=3D hw/block/dataplane
>   trace-events-subdirs +=3D hw/char
> +trace-events-subdirs +=3D hw/core
>   trace-events-subdirs +=3D hw/dma
>   trace-events-subdirs +=3D hw/hppa
>   trace-events-subdirs +=3D hw/i2c
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index 69b408ad1c..c66a5b2c6b 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -7,6 +7,7 @@ common-obj-$(CONFIG_SOFTMMU) +=3D fw-path-provider.o
>   # irq.o needed for qdev GPIO handling:
>   common-obj-y +=3D irq.o
>   common-obj-y +=3D hotplug.o
> +common-obj-y +=3D clock.o
>   common-obj-$(CONFIG_SOFTMMU) +=3D nmi.o
>   common-obj-$(CONFIG_SOFTMMU) +=3D vm-change-state-handler.o
>  =20
> diff --git a/hw/core/clock.c b/hw/core/clock.c
> new file mode 100644
> index 0000000000..888f247f2a
> --- /dev/null
> +++ b/hw/core/clock.c
> @@ -0,0 +1,144 @@
> +/*
> + * Clock inputs and outputs
> + *
> + * Copyright GreenSocs 2016-2018

2019 now?

> + *
> + * Authors:
> + *  Frederic Konrad <fred.konrad@greensocs.com>
> + *  Damien Hedde <damien.hedde@greensocs.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */


