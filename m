Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA91C34047
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:40:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A458A24125
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UY1ZOmzR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A458A24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46rY-0000yi-Ml
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:40:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j46qj-0008Oo-A7
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:39:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j46qh-0006hp-QB
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:39:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25095
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j46qh-0006hI-M2
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:39:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582047595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dX1ahu9azHqYbp7//YJsWKqLC1rmZhia2mPwMrXtN6o=;
 b=UY1ZOmzRV0ATS7V+JO2TwnDvdzfQPHJuoNdlZ2MOlYMSAzbJp/U6caOW+N3hkKSXv/heJz
 5cFuB8qrCuwr6/B3msw3x6u/Ar9y2roJr3lhWmTqUnjgR/AANmoxhBke4AB1X28yLLDAaO
 IQd/si0m8eg4fcDAok/GgH69wCaYWKc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-gHqSzG43PVet2mtsRZCa0A-1; Tue, 18 Feb 2020 12:39:52 -0500
Received: by mail-wr1-f71.google.com with SMTP id t6so11211818wru.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:39:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MjfR0Czum3EeElSom3cvUsDT3Tgq3fOAfgL9bf/dH4M=;
 b=MmPEkRbKZdleL+PydsuaKhyPs7qPczUymxouvNSy8y/MIj1NMyNCrFxuc0tFX7UBNL
 CaUW/RooS27f7rPARmV24AuzY3TyO4xnKxaYgOtkmpD2PShEzGm4yJlOw8m0M+sh0ebn
 vEpMrwnD5qYK257mDm3mx0x7hpXFVbEYaqpn/+0oc1He5XR1cla6j0D4ugyHInsKRlTm
 fE9mNJQrQiCqpXN0qB3Ilwr7HkHmqk7RJDHC6xCewhjd15Si2aK8DyYtmC1lh3KI0noA
 BxmMqcpwAfFwptAICTd760hwGDTfXczc1iaPBGQxTRNFbawmuvFJBjrvedKJZNULCajR
 Abew==
X-Gm-Message-State: APjAAAVU7mq2GSGvcwi8SXLGBCVx+Pnmyc6x+TRMolIh0THO2eeKKt2e
 DjbrI2oYN5+j1ukebCY4jd4Gp9UC6/g26OsKN07MV6wy2Da1ypy6LHjy/r51uKoF2HdKRLuwD34
 1rjkQTrclmUKhe1M=
X-Received: by 2002:adf:8442:: with SMTP id 60mr30664840wrf.416.1582047591329; 
 Tue, 18 Feb 2020 09:39:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqxjIaDizpr2wk7IHambYORl0i1kCtlZgIPgTz9Hxv9r82EXVGJaiepIosRl4OAeHG+cpbID7w==
X-Received: by 2002:adf:8442:: with SMTP id 60mr30664814wrf.416.1582047591012; 
 Tue, 18 Feb 2020 09:39:51 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id s1sm6900076wro.66.2020.02.18.09.39.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 09:39:50 -0800 (PST)
Subject: Re: [PATCH v2 07/13] hw/arm/bcm2836: QOM'ify more by adding
 class_init() to each SoC type
To: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200217114533.17779-1-f4bug@amsat.org>
 <20200217114533.17779-8-f4bug@amsat.org> <20200218180426.008080b4@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <effdb318-dff9-e861-7bc6-8db65f15ad00@redhat.com>
Date: Tue, 18 Feb 2020 18:39:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218180426.008080b4@redhat.com>
Content-Language: en-US
X-MC-Unique: gHqSzG43PVet2mtsRZCa0A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/18/20 6:04 PM, Igor Mammedov wrote:
> On Mon, 17 Feb 2020 12:45:27 +0100
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
>=20
>> Remove usage of TypeInfo::class_data. Instead fill the fields in
>> the corresponding class_init().
>>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>   hw/arm/bcm2836.c | 109 ++++++++++++++++++++++-------------------------
>>   1 file changed, 51 insertions(+), 58 deletions(-)
>>
>> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
>> index 24109fef1d..683d04d6ea 100644
>> --- a/hw/arm/bcm2836.c
>> +++ b/hw/arm/bcm2836.c
>> @@ -16,57 +16,30 @@
>>   #include "hw/arm/raspi_platform.h"
>>   #include "hw/sysbus.h"
>>  =20
>> -typedef struct BCM283XInfo BCM283XInfo;
>> -
>>   typedef struct BCM283XClass {
>>       /*< private >*/
>>       DeviceClass parent_class;
>>       /*< public >*/
>> -    const BCM283XInfo *info;
>> -} BCM283XClass;
>> -
>> -struct BCM283XInfo {
>> -    const char *name;
>=20
>>       const char *cpu_type;
>=20
> probably could be cleaned up by using machine->cpu_type/machine_class->de=
fault_cpu_type
> (no need to change this patch as it's separate issue)

Hmm the core_type is tied to the SoC, not to the machine. The machine=20
only selects a SoC and gets the cpu cores that come with it. The problem=20
is QEMU does not provide interface to select SoC from cmdline, only CPU.

>=20
>=20
>>       hwaddr peri_base; /* Peripheral base address seen by the CPU */
>>       hwaddr ctrl_base; /* Interrupt controller and mailboxes etc. */
>>       int clusterid;
>> -};
>> +} BCM283XClass;
>>  =20
>>   #define BCM283X_CLASS(klass) \
>>       OBJECT_CLASS_CHECK(BCM283XClass, (klass), TYPE_BCM283X)
>>   #define BCM283X_GET_CLASS(obj) \
>>       OBJECT_GET_CLASS(BCM283XClass, (obj), TYPE_BCM283X)
>>  =20
>> -static const BCM283XInfo bcm283x_socs[] =3D {
>> -    {
>> -        .name =3D TYPE_BCM2836,
>> -        .cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a7"),
>> -        .peri_base =3D 0x3f000000,
>> -        .ctrl_base =3D 0x40000000,
>> -        .clusterid =3D 0xf,
>> -    },
>> -#ifdef TARGET_AARCH64
>> -    {
>> -        .name =3D TYPE_BCM2837,
>> -        .cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a53"),
>> -        .peri_base =3D 0x3f000000,
>> -        .ctrl_base =3D 0x40000000,
>> -        .clusterid =3D 0x0,
>> -    },
>> -#endif
>> -};
>> -
>>   static void bcm2836_init(Object *obj)
>>   {
>>       BCM283XState *s =3D BCM283X(obj);
>>       BCM283XClass *bc =3D BCM283X_GET_CLASS(obj);
>> -    const BCM283XInfo *info =3D bc->info;
>>       int n;
>>  =20
>>       for (n =3D 0; n < BCM283X_NCPUS; n++) {
>>           object_initialize_child(obj, "cpu[*]", &s->cpu[n].core,
>> -                                sizeof(s->cpu[n].core), info->cpu_type,
>> +                                sizeof(s->cpu[n].core), bc->cpu_type,
>>                                   &error_abort, NULL);
>>       }
>>  =20
>> @@ -85,7 +58,6 @@ static void bcm2836_realize(DeviceState *dev, Error **=
errp)
>>   {
>>       BCM283XState *s =3D BCM283X(dev);
>>       BCM283XClass *bc =3D BCM283X_GET_CLASS(dev);
>> -    const BCM283XInfo *info =3D bc->info;
>>       Object *obj;
>>       Error *err =3D NULL;
>>       int n;
>> @@ -119,7 +91,7 @@ static void bcm2836_realize(DeviceState *dev, Error *=
*errp)
>>       }
>>  =20
>>       sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 0,
>> -                            info->peri_base, 1);
>> +                            bc->peri_base, 1);
>>  =20
>>       /* bcm2836 interrupt controller (and mailboxes, etc.) */
>>       object_property_set_bool(OBJECT(&s->control), true, "realized", &e=
rr);
>> @@ -128,7 +100,7 @@ static void bcm2836_realize(DeviceState *dev, Error =
**errp)
>>           return;
>>       }
>>  =20
>> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->control), 0, info->ctrl_base);
>> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->control), 0, bc->ctrl_base);
>>  =20
>>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
>>           qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-irq", 0));
>> @@ -137,11 +109,11 @@ static void bcm2836_realize(DeviceState *dev, Erro=
r **errp)
>>  =20
>>       for (n =3D 0; n < BCM283X_NCPUS; n++) {
>>           /* TODO: this should be converted to a property of ARM_CPU */
>> -        s->cpu[n].core.mp_affinity =3D (info->clusterid << 8) | n;
>> +        s->cpu[n].core.mp_affinity =3D (bc->clusterid << 8) | n;
>>  =20
>>           /* set periphbase/CBAR value for CPU-local registers */
>>           object_property_set_int(OBJECT(&s->cpu[n].core),
>> -                                info->peri_base,
>> +                                bc->peri_base,
>>                                   "reset-cbar", &err);
>>           if (err) {
>>               error_propagate(errp, err);
>> @@ -190,38 +162,59 @@ static Property bcm2836_props[] =3D {
>>   static void bcm283x_class_init(ObjectClass *oc, void *data)
>>   {
>>       DeviceClass *dc =3D DEVICE_CLASS(oc);
>> -    BCM283XClass *bc =3D BCM283X_CLASS(oc);
>>  =20
>> -    bc->info =3D data;
>> -    dc->realize =3D bcm2836_realize;
>> -    device_class_set_props(dc, bcm2836_props);
>>       /* Reason: Must be wired up in code (see raspi_init() function) */
>>       dc->user_creatable =3D false;
>>   }
>>  =20
>> -static const TypeInfo bcm283x_type_info =3D {
>> -    .name =3D TYPE_BCM283X,
>> -    .parent =3D TYPE_DEVICE,
>> -    .instance_size =3D sizeof(BCM283XState),
>> -    .instance_init =3D bcm2836_init,
>> -    .class_size =3D sizeof(BCM283XClass),
>> -    .abstract =3D true,
>> +static void bcm2836_class_init(ObjectClass *oc, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
>> +    BCM283XClass *bc =3D BCM283X_CLASS(oc);
>> +
>> +    bc->cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a7");
>> +    bc->peri_base =3D 0x3f000000;
>> +    bc->ctrl_base =3D 0x40000000;
>> +    bc->clusterid =3D 0xf;
>> +    dc->realize =3D bcm2836_realize;
>> +    device_class_set_props(dc, bcm2836_props);
>>   };
>>  =20
>> -static void bcm2836_register_types(void)
>> +#ifdef TARGET_AARCH64
>> +static void bcm2837_class_init(ObjectClass *oc, void *data)
>>   {
>> -    int i;
>> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
>> +    BCM283XClass *bc =3D BCM283X_CLASS(oc);
>>  =20
>> -    type_register_static(&bcm283x_type_info);
>> -    for (i =3D 0; i < ARRAY_SIZE(bcm283x_socs); i++) {
>> -        TypeInfo ti =3D {
>> -            .name =3D bcm283x_socs[i].name,
>> -            .parent =3D TYPE_BCM283X,
>> -            .class_init =3D bcm283x_class_init,
>> -            .class_data =3D (void *) &bcm283x_socs[i],
>> -        };
>> -        type_register(&ti);
>> +    bc->cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a53");
>> +    bc->peri_base =3D 0x3f000000;
>> +    bc->ctrl_base =3D 0x40000000;
>> +    bc->clusterid =3D 0x0;
>> +    dc->realize =3D bcm2836_realize;
>> +    device_class_set_props(dc, bcm2836_props);
> both children do use the same values for almost all fields.
> I'd set in children class_init()s only cpu_type/clusterid
> and keep common bits in base class.

Yes so far, but then the BCM2711/BCM2838 for raspi4 changes all fields.

>=20
>> +};
>> +#endif
>> +
>> +static const TypeInfo bcm283x_types[] =3D {
>> +    {
>> +        .name           =3D TYPE_BCM2836,
>> +        .parent         =3D TYPE_BCM283X,
>> +        .class_init     =3D bcm2836_class_init,
>> +#ifdef TARGET_AARCH64
>> +    }, {
>> +        .name           =3D TYPE_BCM2837,
>> +        .parent         =3D TYPE_BCM283X,
>> +        .class_init     =3D bcm2837_class_init,
>> +#endif
>> +    }, {
>> +        .name           =3D TYPE_BCM283X,
>> +        .parent         =3D TYPE_DEVICE,
>> +        .instance_size  =3D sizeof(BCM283XState),
>> +        .instance_init  =3D bcm2836_init,
>> +        .class_size     =3D sizeof(BCM283XClass),
>> +        .class_init     =3D bcm283x_class_init,
>> +        .abstract       =3D true,
>>       }
>> -}
>> +};
>>  =20
>> -type_init(bcm2836_register_types)
>> +DEFINE_TYPES(bcm283x_types)
>=20


