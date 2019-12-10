Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C803C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 07:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA7B206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 07:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xs7R9qKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA7B206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieaHZ-0002gP-FH
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 02:50:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ieaGg-00027U-T4
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 02:49:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ieaGf-0005FV-HL
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 02:49:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39764
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ieaGf-0005FE-Do
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 02:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575964152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u4PkXnKRd3GOouAWzrRRlAm8so7Eo0Y984+shY8xYGY=;
 b=Xs7R9qKx3R2kg5izZuID95wBE2PfCHKPzRit4DTpDw+DrXg3eJVbHMP5LHKhSMZdcMEJJQ
 oacDlz0g7mpsdW4ro60p3jqh41G8EWSLy7jJfQUlEoATsiX8h4700z8as/xm1uhiXhoeQy
 RQ3Hqzk1yAfnDLvhAxxlAxi+MMMb/5k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-_dLgQ5TXNRS0tQrhWYQgVg-1; Tue, 10 Dec 2019 02:49:11 -0500
Received: by mail-wr1-f71.google.com with SMTP id u12so8602736wrt.15
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 23:49:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Nfd7QU5jJwPptNEVMPri1imjwNzI7fUtImWVOnEx3Ug=;
 b=XLLtR24cMFGsx0sO3qlzyF3fvAdEU9757/7y3aBhO9KOSdUATfwQ5sYSrvddUdl+Dm
 +gj4LMVMNpGBTCh8kQaFLvCGLpIwBqbVaNm4XtPDVKBIYKbSBY4H2YASwglvV9ZPpaya
 l4OdI4PlyrPhK39kQjN4484C/EJz/LHMoNXl3ONH9cTbDysxMjPHKd/4O+5H7Hlqpcfs
 Cl/Uab8bTIJ2VoLQlO2dDVrwQhoZaCxRRhiWs/BuDj5b7HIosLwHnweh6h2khp/DkLvN
 HV95lcJxyX+3zXzpPhAufrJBBzwPIzyMpgzVM7jU1VqXX7jkY67s8o/pqFC+y4hv9NfX
 HCLA==
X-Gm-Message-State: APjAAAVc6cVEwJq73vb53rQSugz5d6vHSHKeLq5OrVjMMQRsQqUspeXp
 2X0Pm+ODrMczLsbmNAr2ONIrtAlDx6W0ypPZholi0jdtI3xJKUsFXcq+yPSPvNzu3MJy2bPO1Rb
 CQK374PIGIahLS9c=
X-Received: by 2002:a1c:486:: with SMTP id 128mr3559688wme.163.1575964150247; 
 Mon, 09 Dec 2019 23:49:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqxyqSwShXSXT4O4HxftejY6uYA6R+wCIO1cko55fCFjIGNJ3gqApFF3XOFhwwA6lipx6/eAlQ==
X-Received: by 2002:a1c:486:: with SMTP id 128mr3559677wme.163.1575964150015; 
 Mon, 09 Dec 2019 23:49:10 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id w13sm2364554wru.38.2019.12.09.23.49.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2019 23:49:09 -0800 (PST)
Subject: Re: [PATCH 1/2] hw/sd: Configure number of slots exposed by the
 ASPEED SDHCI model
To: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org
References: <cover.da2612e7c1835c563b20851f0ac26c7b175428fc.1575938234.git-series.andrew@aj.id.au>
 <11e1d38d2374a48996a3496c906db215de246583.1575938234.git-series.andrew@aj.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f17f9d41-e7aa-b701-e48d-dd9fd5f71b8e@redhat.com>
Date: Tue, 10 Dec 2019 08:49:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <11e1d38d2374a48996a3496c906db215de246583.1575938234.git-series.andrew@aj.id.au>
Content-Language: en-US
X-MC-Unique: _dLgQ5TXNRS0tQrhWYQgVg-1
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
Cc: peter.maydell@linaro.org, joel@jms.id.au, qemu-devel@nongnu.org,
 clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/10/19 1:52 AM, Andrew Jeffery wrote:
> The AST2600 includes a second cut-down version of the SD/MMC controller
> found in the AST2500, named the eMMC controller. It's cut down in the
> sense that it only supports one slot rather than two, but it brings the
> total number of slots supported by the AST2600 to three.
>=20
> The existing code assumed that the SD controller always provided two
> slots. Rework the SDHCI object to expose the number of slots as a
> property to be set by the SoC configuration.
>=20
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/arm/aspeed.c              |  2 +-
>   hw/arm/aspeed_ast2600.c      |  2 ++
>   hw/arm/aspeed_soc.c          |  3 +++
>   hw/sd/aspeed_sdhci.c         | 11 +++++++++--
>   include/hw/sd/aspeed_sdhci.h |  1 +
>   5 files changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 028191ff36fc..862549b1f3a9 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -259,7 +259,7 @@ static void aspeed_board_init(MachineState *machine,
>           cfg->i2c_init(bmc);
>       }
>  =20
> -    for (i =3D 0; i < ARRAY_SIZE(bmc->soc.sdhci.slots); i++) {
> +    for (i =3D 0; i < bmc->soc.sdhci.num_slots; i++) {
>           SDHCIState *sdhci =3D &bmc->soc.sdhci.slots[i];
>           DriveInfo *dinfo =3D drive_get_next(IF_SD);
>           BlockBackend *blk;
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index 931887ac681f..931ee5aae183 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -208,6 +208,8 @@ static void aspeed_soc_ast2600_init(Object *obj)
>       sysbus_init_child_obj(obj, "sdc", OBJECT(&s->sdhci), sizeof(s->sdhc=
i),
>                             TYPE_ASPEED_SDHCI);
>  =20
> +    object_property_set_int(OBJECT(&s->sdhci), 2, "num-slots", &error_ab=
ort);
> +
>       /* Init sd card slot class here so that they're under the correct p=
arent */
>       for (i =3D 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
>           sysbus_init_child_obj(obj, "sdhci[*]", OBJECT(&s->sdhci.slots[i=
]),
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index f4fe243458fd..3498f55603f2 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -215,6 +215,9 @@ static void aspeed_soc_init(Object *obj)
>       sysbus_init_child_obj(obj, "sdc", OBJECT(&s->sdhci), sizeof(s->sdhc=
i),
>                             TYPE_ASPEED_SDHCI);
>  =20
> +    object_property_set_int(OBJECT(&s->sdhci), ASPEED_SDHCI_NUM_SLOTS,
> +                            "num-slots", &error_abort);
> +
>       /* Init sd card slot class here so that they're under the correct p=
arent */
>       for (i =3D 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
>           sysbus_init_child_obj(obj, "sdhci[*]", OBJECT(&s->sdhci.slots[i=
]),
> diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
> index cff3eb7dd21e..939d1510dedb 100644
> --- a/hw/sd/aspeed_sdhci.c
> +++ b/hw/sd/aspeed_sdhci.c
> @@ -13,6 +13,7 @@
>   #include "qapi/error.h"
>   #include "hw/irq.h"
>   #include "migration/vmstate.h"
> +#include "hw/qdev-properties.h"
>  =20
>   #define ASPEED_SDHCI_INFO            0x00
>   #define  ASPEED_SDHCI_INFO_RESET     0x00030000
> @@ -120,14 +121,14 @@ static void aspeed_sdhci_realize(DeviceState *dev, =
Error **errp)
>  =20
>       /* Create input irqs for the slots */
>       qdev_init_gpio_in_named_with_opaque(DEVICE(sbd), aspeed_sdhci_set_i=
rq,
> -                                        sdhci, NULL, ASPEED_SDHCI_NUM_SL=
OTS);
> +                                        sdhci, NULL, sdhci->num_slots);
>  =20
>       sysbus_init_irq(sbd, &sdhci->irq);
>       memory_region_init_io(&sdhci->iomem, OBJECT(sdhci), &aspeed_sdhci_o=
ps,
>                             sdhci, TYPE_ASPEED_SDHCI, 0x1000);
>       sysbus_init_mmio(sbd, &sdhci->iomem);
>  =20
> -    for (int i =3D 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
> +    for (int i =3D 0; i < sdhci->num_slots; ++i) {
>           Object *sdhci_slot =3D OBJECT(&sdhci->slots[i]);
>           SysBusDevice *sbd_slot =3D SYS_BUS_DEVICE(&sdhci->slots[i]);
>  =20
> @@ -174,6 +175,11 @@ static const VMStateDescription vmstate_aspeed_sdhci=
 =3D {
>       },
>   };
>  =20
> +static Property aspeed_sdhci_properties[] =3D {
> +    DEFINE_PROP_UINT8("num-slots", AspeedSDHCIState, num_slots, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>   static void aspeed_sdhci_class_init(ObjectClass *classp, void *data)
>   {
>       DeviceClass *dc =3D DEVICE_CLASS(classp);
> @@ -181,6 +187,7 @@ static void aspeed_sdhci_class_init(ObjectClass *clas=
sp, void *data)
>       dc->realize =3D aspeed_sdhci_realize;
>       dc->reset =3D aspeed_sdhci_reset;
>       dc->vmsd =3D &vmstate_aspeed_sdhci;
> +    dc->props =3D aspeed_sdhci_properties;
>   }
>  =20
>   static TypeInfo aspeed_sdhci_info =3D {
> diff --git a/include/hw/sd/aspeed_sdhci.h b/include/hw/sd/aspeed_sdhci.h
> index dfdab4379021..dffbb46946b9 100644
> --- a/include/hw/sd/aspeed_sdhci.h
> +++ b/include/hw/sd/aspeed_sdhci.h
> @@ -24,6 +24,7 @@ typedef struct AspeedSDHCIState {
>       SysBusDevice parent;
>  =20
>       SDHCIState slots[ASPEED_SDHCI_NUM_SLOTS];
> +    uint8_t num_slots;
>  =20
>       MemoryRegion iomem;
>       qemu_irq irq;
>=20


