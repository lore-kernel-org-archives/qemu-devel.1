Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AD4C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:15:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B28C12081B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQh6D5W8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28C12081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icWNS-0001yV-Ri
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 10:15:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1icWMM-0001AU-CO
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:14:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1icWMJ-0004kA-L2
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:14:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43363
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1icWMJ-0004j8-G2
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575472470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DmIL8lWWj1hyNzh2lSYRiHrckJIy94t5tsFXYkLsG5U=;
 b=NQh6D5W8Y/4QPYZmzN/TjczP9TSAGFF/23Nvebbl+clHeUJsqrZHWoiRfFW2eB7Xm4oj0Z
 P9OnE5TGaplqgIfd1NuyeqbIjklwmWoHKqs1++9n1Vkys42iFriO5i6+nw4N8gkKXx2toc
 2VQLRLRto7191oG7chDJC3hMwa+XAAc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-JLPv9sH7OhmjcEpkYLoq_g-1; Wed, 04 Dec 2019 10:14:28 -0500
Received: by mail-wr1-f71.google.com with SMTP id z14so5218wrs.4
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 07:14:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W18PxyJxSWB9j8jjViZ8sbO8hMAPaqPBEkNc0R4KLPM=;
 b=NoOQpzbk9nHYQRELpOAD77kB/1wuAt+60/V+ao4Mhdwj+IDwPZl2RiR4CVVRaginO3
 GaVzFc56diPuQGIcO4IqhturQq9abbD7iHtdfGt/410ZihC3udi1libXzhqamY5O1Vag
 wZy63w19k5neWJzCk3k55FxVrA9xsKqQhl3kI8EbDo8oFfs2DnA/5jRtuu+7F0jyJzYM
 MWWDd4wm2PWJJHJhBbYI8h37F4TRGznmnKSsKYiqDJRCvkBWfwY6sVdk4+ngmdNG57Wn
 EIyT7uRZ9LBfsEi0Z0TRpWrDPcMBNyDOljfoYAxvc/17J1GeOtuuQ/lLt0A9TBAIN++h
 mj1Q==
X-Gm-Message-State: APjAAAXb7K/bm1RoLgFWa+/Hd4tUdGtq7wm340lpAzzMnrciudZxEmJa
 cpZ98GvSeKJgyjYVCYdHya6gnCARAlhejcTmFrWOB99JuCjgSwfeZG+bq2c2K4WdKgwRxUrv/Hx
 1cf9Ou7lpiQbBFUs=
X-Received: by 2002:a5d:6305:: with SMTP id i5mr4683914wru.119.1575472467053; 
 Wed, 04 Dec 2019 07:14:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqxM1dInIw8DQr/izmUcxozvnmIY0Zfs3JqycwXdjMouUAL76BSyVhrYLpwI+rZWSIgxQRVnZg==
X-Received: by 2002:a5d:6305:: with SMTP id i5mr4683894wru.119.1575472466759; 
 Wed, 04 Dec 2019 07:14:26 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id q6sm9075835wrx.72.2019.12.04.07.14.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2019 07:14:26 -0800 (PST)
Subject: Re: [PATCH 10/10] arm: allwinner-h3: add EMAC ethernet device
To: KONRAD Frederic <frederic.konrad@adacore.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-11-nieklinnenbank@gmail.com>
 <a234bebd-d794-7400-c9f8-77561ba46aa3@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0b549e25-cf45-e491-9342-58592514870f@redhat.com>
Date: Wed, 4 Dec 2019 16:14:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a234bebd-d794-7400-c9f8-77561ba46aa3@adacore.com>
Content-Language: en-US
X-MC-Unique: JLPv9sH7OhmjcEpkYLoq_g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, Jason Wang <jasowang@redhat.com>,
 Sai Pavan Boddu <saipava@xilinx.com>, Grant Likely <grant.likely@secretlab.ca>,
 b.galvani@gmail.com, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Sven Schnelle <svens@stackframe.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/3/19 10:33 AM, KONRAD Frederic wrote:
> Le 12/2/19 =C3=A0 10:09 PM, Niek Linnenbank a =C3=A9crit=C2=A0:
>> The Allwinner H3 System on Chip includes an Ethernet MAC (EMAC)
>> which provides 10M/100M/1000M Ethernet connectivity. This commit
>> adds support for the Allwinner H3 EMAC, including emulation for
>> the following functionality:
>>
>> =C2=A0 * DMA transfers
>> =C2=A0 * MII interface
>> =C2=A0 * Transmit CRC calculation
>>
>> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
>> ---
>> =C2=A0 hw/arm/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 +
>> =C2=A0 hw/arm/allwinner-h3.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 17 +
>> =C2=A0 hw/arm/orangepi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +
>> =C2=A0 hw/net/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 3 +
>> =C2=A0 hw/net/Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 hw/net/allwinner-h3-emac.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 786 +++++++++++++++++++++++++++++
>> =C2=A0 hw/net/trace-events=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 +
>> =C2=A0 include/hw/arm/allwinner-h3.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 2 +
>> =C2=A0 include/hw/net/allwinner-h3-emac.h |=C2=A0 69 +++
>> =C2=A0 9 files changed, 896 insertions(+)
>> =C2=A0 create mode 100644 hw/net/allwinner-h3-emac.c
>> =C2=A0 create mode 100644 include/hw/net/allwinner-h3-emac.h
>>
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> index ebf8d2325f..551cff3442 100644
>> --- a/hw/arm/Kconfig
>> +++ b/hw/arm/Kconfig
>> @@ -294,6 +294,7 @@ config ALLWINNER_A10
>> =C2=A0 config ALLWINNER_H3
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select ALLWINNER_A10_PIT
>> +=C2=A0=C2=A0=C2=A0 select ALLWINNER_H3_EMAC
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select SERIAL
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select ARM_TIMER
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select ARM_GIC
>> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
>> index c2972caf88..274b8548c0 100644
>> --- a/hw/arm/allwinner-h3.c
>> +++ b/hw/arm/allwinner-h3.c
>> @@ -53,6 +53,9 @@ static void aw_h3_init(Object *obj)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysbus_init_child_obj(obj, "mmc0", &s->mm=
c0, sizeof(s->mmc0),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 TYPE_AW_H3_SDHOST);
>> +
>> +=C2=A0=C2=A0=C2=A0 sysbus_init_child_obj(obj, "emac", &s->emac, sizeof(=
s->emac),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 TYPE_AW_H3_EMAC);
>> =C2=A0 }
>> =C2=A0 static void aw_h3_realize(DeviceState *dev, Error **errp)
>> @@ -237,6 +240,20 @@ static void aw_h3_realize(DeviceState *dev, Error=
=20
>> **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 /* EMAC */
>> +=C2=A0=C2=A0=C2=A0 if (nd_table[0].used) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_check_nic_model(&nd_tab=
le[0], TYPE_AW_H3_EMAC);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_set_nic_properties(DEVI=
CE(&s->emac), &nd_table[0]);
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 object_property_set_bool(OBJECT(&s->emac), true, "re=
alized", &err);
>> +=C2=A0=C2=A0=C2=A0 if (err !=3D NULL) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 sysbusdev =3D SYS_BUS_DEVICE(&s->emac);
>> +=C2=A0=C2=A0=C2=A0 sysbus_mmio_map(sysbusdev, 0, AW_H3_EMAC_BASE);
>> +=C2=A0=C2=A0=C2=A0 sysbus_connect_irq(sysbusdev, 0, s->irq[AW_H3_GIC_SP=
I_EMAC]);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Universal Serial Bus */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, AW_=
H3_EHCI0_BASE,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 s->irq[AW_H3_GIC_SPI_EHCI0]);
>> diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
>> index dee3efaf08..8a61eb0e69 100644
>> --- a/hw/arm/orangepi.c
>> +++ b/hw/arm/orangepi.c
>> @@ -61,6 +61,13 @@ static void orangepi_init(MachineState *machine)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 /* Setup EMAC properties */
>> +=C2=A0=C2=A0=C2=A0 object_property_set_int(OBJECT(&s->h3->emac), 1, "ph=
y-addr", &err);
>> +=C2=A0=C2=A0=C2=A0 if (err !=3D NULL) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_reportf_err(err, "Coul=
dn't set phy address: ");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Mark H3 object realized */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_set_bool(OBJECT(s->h3), t=
rue, "realized", &err);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err !=3D NULL) {
>> diff --git a/hw/net/Kconfig b/hw/net/Kconfig
>> index 3856417d42..36d3923992 100644
>> --- a/hw/net/Kconfig
>> +++ b/hw/net/Kconfig
>> @@ -74,6 +74,9 @@ config MIPSNET
>> =C2=A0 config ALLWINNER_EMAC
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
>> +config ALLWINNER_H3_EMAC
>> +=C2=A0=C2=A0=C2=A0 bool
>> +
>> =C2=A0 config IMX_FEC
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
>> diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
>> index 7907d2c199..5548deb07a 100644
>> --- a/hw/net/Makefile.objs
>> +++ b/hw/net/Makefile.objs
>> @@ -23,6 +23,7 @@ common-obj-$(CONFIG_XGMAC) +=3D xgmac.o
>> =C2=A0 common-obj-$(CONFIG_MIPSNET) +=3D mipsnet.o
>> =C2=A0 common-obj-$(CONFIG_XILINX_AXI) +=3D xilinx_axienet.o
>> =C2=A0 common-obj-$(CONFIG_ALLWINNER_EMAC) +=3D allwinner_emac.o
>> +common-obj-$(CONFIG_ALLWINNER_H3_EMAC) +=3D allwinner-h3-emac.o
>> =C2=A0 common-obj-$(CONFIG_IMX_FEC) +=3D imx_fec.o
>> =C2=A0 common-obj-$(CONFIG_CADENCE) +=3D cadence_gem.o
>> diff --git a/hw/net/allwinner-h3-emac.c b/hw/net/allwinner-h3-emac.c
>> new file mode 100644
>> index 0000000000..37f6f44406
>> --- /dev/null
>> +++ b/hw/net/allwinner-h3-emac.c
>> @@ -0,0 +1,786 @@
>> +/*
>> + * Allwinner H3 EMAC emulation
>> + *
>> + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
>> + *
>> + * This program is free software: you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation, either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.=C2=A0 If not, see <http://www.gnu.org/licen=
ses/>.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/sysbus.h"
>> +#include "migration/vmstate.h"
>> +#include "net/net.h"
>> +#include "hw/irq.h"
>> +#include "hw/qdev-properties.h"
>> +#include "qemu/log.h"
>> +#include "trace.h"
>> +#include "net/checksum.h"
>> +#include "qemu/module.h"
>> +#include "exec/cpu-common.h"
>> +#include "hw/net/allwinner-h3-emac.h"
>> +
>> +/* EMAC register offsets */
>> +#define REG_BASIC_CTL_0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x00=
00) /* Basic Control 0 */
>> +#define REG_BASIC_CTL_1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x00=
04) /* Basic Control 1 */
>> +#define REG_INT_STA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (0x0008) /* Interrupt Status */
>> +#define REG_INT_EN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (0x000C) /* Interrupt Enable */
>> +#define REG_TX_CTL_0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (0x0010) /* Transmit Control 0 */
>> +#define REG_TX_CTL_1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (0x0014) /* Transmit Control 1 */
>> +#define REG_TX_FLOW_CTL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x00=
1C) /* Transmit Flow Control */
>> +#define REG_TX_DMA_DESC_LIST=C2=A0=C2=A0 (0x0020) /* Transmit Descripto=
r List=20
>> Address */
>> +#define REG_RX_CTL_0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (0x0024) /* Receive Control 0 */
>> +#define REG_RX_CTL_1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (0x0028) /* Receive Control 1 */
>> +#define REG_RX_DMA_DESC_LIST=C2=A0=C2=A0 (0x0034) /* Receive Descriptor=
 List=20
>> Address */
>> +#define REG_FRM_FLT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (0x0038) /* Receive Frame Filter */
>> +#define REG_RX_HASH_0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (0x0040) /* Receive Hash Table 0 */
>> +#define REG_RX_HASH_1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (0x0044) /* Receive Hash Table 1 */
>> +#define REG_MII_CMD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (0x0048) /* Management Interface=20
>> Command */
>> +#define REG_MII_DATA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (0x004C) /* Management Interface Data */
>> +#define REG_ADDR_HIGH=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (0x0050) /* MAC Address High */
>> +#define REG_ADDR_LOW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (0x0054) /* MAC Address Low */
>> +#define REG_TX_DMA_STA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
(0x00B0) /* Transmit DMA Status */
>> +#define REG_TX_CUR_DESC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x00=
B4) /* Transmit Current=20
>> Descriptor */
>> +#define REG_TX_CUR_BUF=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
(0x00B8) /* Transmit Current Buffer */
>> +#define REG_RX_DMA_STA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
(0x00C0) /* Receive DMA Status */
>> +#define REG_RX_CUR_DESC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x00=
C4) /* Receive Current Descriptor */
>> +#define REG_RX_CUR_BUF=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
(0x00C8) /* Receive Current Buffer */
>> +#define REG_RGMII_STA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (0x00D0) /* RGMII Status */
>> +
>> +/* EMAC register flags */
>> +#define BASIC_CTL0_100Mbps=C2=A0=C2=A0=C2=A0=C2=A0 (0b11 << 2)
>> +#define BASIC_CTL0_FD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (1 << 0)
>> +#define BASIC_CTL1_SOFTRST=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 0)
>> +
>> +#define INT_STA_RGMII_LINK=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 16)
>> +#define INT_STA_RX_EARLY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 13)
>> +#define INT_STA_RX_OVERFLOW=C2=A0=C2=A0=C2=A0 (1 << 12)
>> +#define INT_STA_RX_TIMEOUT=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 11)
>> +#define INT_STA_RX_DMA_STOP=C2=A0=C2=A0=C2=A0 (1 << 10)
>> +#define INT_STA_RX_BUF_UA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 9)
>> +#define INT_STA_RX=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (1 << 8)
>> +#define INT_STA_TX_EARLY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 5)
>> +#define INT_STA_TX_UNDERFLOW=C2=A0=C2=A0 (1 << 4)
>> +#define INT_STA_TX_TIMEOUT=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 3)
>> +#define INT_STA_TX_BUF_UA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 2)
>> +#define INT_STA_TX_DMA_STOP=C2=A0=C2=A0=C2=A0 (1 << 1)
>> +#define INT_STA_TX=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (1 << 0)
>> +
>> +#define INT_EN_RX_EARLY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 <<=
 13)
>> +#define INT_EN_RX_OVERFLOW=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 12)
>> +#define INT_EN_RX_TIMEOUT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 11)
>> +#define INT_EN_RX_DMA_STOP=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 10)
>> +#define INT_EN_RX_BUF_UA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 9)
>> +#define INT_EN_RX=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 8)
>> +#define INT_EN_TX_EARLY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 <<=
 5)
>> +#define INT_EN_TX_UNDERFLOW=C2=A0=C2=A0=C2=A0 (1 << 4)
>> +#define INT_EN_TX_TIMEOUT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 3)
>> +#define INT_EN_TX_BUF_UA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 2)
>> +#define INT_EN_TX_DMA_STOP=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 1)
>> +#define INT_EN_TX=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 0)
>> +
>> +#define TX_CTL0_TX_EN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (1 << 31)
>> +#define TX_CTL1_TX_DMA_START=C2=A0=C2=A0 (1 << 31)
>> +#define TX_CTL1_TX_DMA_EN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 30)
>> +#define TX_CTL1_TX_FLUSH=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 0)
>> +
>> +#define RX_CTL0_RX_EN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (1 << 31)
>> +#define RX_CTL0_STRIP_FCS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 28)
>> +#define RX_CTL0_CRC_IPV4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 27)
>> +
>> +#define RX_CTL1_RX_DMA_START=C2=A0=C2=A0 (1 << 31)
>> +#define RX_CTL1_RX_DMA_EN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 30)
>> +#define RX_CTL1_RX_MD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (1 << 1)
>> +
>> +#define RX_FRM_FLT_DIS_ADDR=C2=A0=C2=A0=C2=A0 (1 << 31)
>> +
>> +#define MII_CMD_PHY_ADDR_SHIFT (12)
>> +#define MII_CMD_PHY_ADDR_MASK=C2=A0 (0xf000)
>> +#define MII_CMD_PHY_REG_SHIFT=C2=A0 (4)
>> +#define MII_CMD_PHY_REG_MASK=C2=A0=C2=A0 (0xf0)
>> +#define MII_CMD_PHY_RW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
(1 << 1)
>> +#define MII_CMD_PHY_BUSY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 0)
>> +
>> +#define TX_DMA_STA_STOP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0b00=
0)
>> +#define TX_DMA_STA_RUN_FETCH=C2=A0=C2=A0 (0b001)
>> +#define TX_DMA_STA_WAIT_STA=C2=A0=C2=A0=C2=A0 (0b010)
>> +
>> +#define RX_DMA_STA_STOP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0b00=
0)
>> +#define RX_DMA_STA_RUN_FETCH=C2=A0=C2=A0 (0b001)
>> +#define RX_DMA_STA_WAIT_FRM=C2=A0=C2=A0=C2=A0 (0b011)
>> +
>> +#define RGMII_LINK_UP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (1 << 3)
>> +#define RGMII_FD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 0)
>> +
>> +/* EMAC register reset values */
>> +#define REG_BASIC_CTL_1_RST=C2=A0=C2=A0=C2=A0 (0x08000000)
>> +
>> +/* EMAC constants */
>> +#define AW_H3_EMAC_MIN_PKT_SZ=C2=A0 (64)
>> +
>> +/* Transmit/receive frame descriptor */
>> +typedef struct FrameDescriptor {
>> +=C2=A0=C2=A0=C2=A0 uint32_t status;
>> +=C2=A0=C2=A0=C2=A0 uint32_t status2;
>> +=C2=A0=C2=A0=C2=A0 uint32_t addr;
>> +=C2=A0=C2=A0=C2=A0 uint32_t next;
>> +} FrameDescriptor;
>> +
>> +/* Frame descriptor flags */
>> +#define DESC_STATUS_CTL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 31)
>> +#define DESC_STATUS2_BUF_SIZE_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x7ff=
)
>> +
>> +/* Transmit frame descriptor flags */
>> +#define TX_DESC_STATUS_LENGTH_ERR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (=
1 << 14)
>> +#define TX_DESC_STATUS2_FIRST_DESC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << =
29)
>> +#define TX_DESC_STATUS2_LAST_DESC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (=
1 << 30)
>> +#define TX_DESC_STATUS2_CHECKSUM_MASK=C2=A0=C2=A0 (0x3 << 27)
>> +
>> +/* Receive frame descriptor flags */
>> +#define RX_DESC_STATUS_FIRST_DESC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (=
1 << 9)
>> +#define RX_DESC_STATUS_LAST_DESC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (1 << 8)
>> +#define RX_DESC_STATUS_FRM_LEN_MASK=C2=A0=C2=A0=C2=A0=C2=A0 (0x3fff0000=
)
>> +#define RX_DESC_STATUS_FRM_LEN_SHIFT=C2=A0=C2=A0=C2=A0 (16)
>> +#define RX_DESC_STATUS_NO_BUF=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (1 << 14)
>> +#define RX_DESC_STATUS_HEADER_ERR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (=
1 << 7)
>> +#define RX_DESC_STATUS_LENGTH_ERR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (=
1 << 4)
>> +#define RX_DESC_STATUS_CRC_ERR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (1 << 1)
>> +#define RX_DESC_STATUS_PAYLOAD_ERR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << =
0)
>> +#define RX_DESC_STATUS2_RX_INT_CTL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << =
31)
>> +
>> +/* MII register offsets */
>> +#define MII_REG_CR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 (0x0)
>> +#define MII_REG_ST=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 (0x1)
>> +#define MII_REG_ID_HIGH=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x2)
>> +#define MII_REG_ID_LOW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x3)
>> +
>> +/* MII register flags */
>> +#define MII_REG_CR_RESET=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 15)
>> +#define MII_REG_CR_POWERDOWN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 11)
>> +#define MII_REG_CR_10Mbit=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0)
>> +#define MII_REG_CR_100Mbit=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 13)
>> +#define MII_REG_CR_1000Mbit=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 6)
>> +#define MII_REG_CR_AUTO_NEG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 12)
>> +#define MII_REG_CR_AUTO_NEG_RESTART=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 9)
>> +#define MII_REG_CR_FULLDUPLEX=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (1 << 8)
>> +
>> +#define MII_REG_ST_100BASE_T4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (1 << 15)
>> +#define MII_REG_ST_100BASE_X_FD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (1 << 14)
>> +#define MII_REG_ST_100BASE_X_HD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (1 << 13)
>> +#define MII_REG_ST_10_FD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 12)
>> +#define MII_REG_ST_10_HD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 11)
>> +#define MII_REG_ST_100BASE_T2_FD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (1 << 10)
>> +#define MII_REG_ST_100BASE_T2_HD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (1 << 9)
>> +#define MII_REG_ST_AUTONEG_COMPLETE=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 5)
>> +#define MII_REG_ST_AUTONEG_AVAIL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (1 << 3)
>> +#define MII_REG_ST_LINK_UP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 2)
>> +
>> +/* MII constants */
>> +#define MII_PHY_ID_HIGH=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x0044)
>> +#define MII_PHY_ID_LOW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x1400)
>=20
> I wonder if we can't share all those mii stuff accross the network adapte=
rs
> instead of redoing the work everytime. I've some patches about it I may=
=20
> post
> them sometimes.

I started that too, salvaging patches from Grant Likely and Sai Pavan=20
Boddu, but I'm doing this in my hobbyist time so progress is slow. I=20
estimate I'v 80% of the work done.
Basically it adds a MDIO QBUS (as SD/I2C) and we can plug multiple QDEV=20
slaves. Benefits are easily tracing of the MDIO activity, and ability to=20
interchange the master/slaves for testing (think libqos qgraph).


