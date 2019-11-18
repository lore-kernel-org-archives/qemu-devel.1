Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F37CC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:50:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 638882192B
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EAbBifxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638882192B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWlAV-00007i-Ii
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 12:50:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iWl97-0007xz-W4
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:49:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iWl96-0003xY-5j
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:49:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24783
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iWl96-0003xS-2S
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:49:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574099343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8uiU4rq86oXPePs9s+kNA7up4twD58636FSWZMd0zag=;
 b=EAbBifxoagKkBllK2/ONoijC8PXs3whIdBKDuBQVqMHm3fpkKjcD2veqY7GDfoJwaxU++I
 hmNC4fvoRGE+NuJGpqQp6hjyXBnQ6cAf2byXpazz/pvBpeqrluN66mEKl7IcsAq6Wz6y/H
 Qk7o3b5wYqv/Hg1IGtJPSypfg9fkb9E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-NCPLtByVMvuR-mLQ7-DEGQ-1; Mon, 18 Nov 2019 12:49:00 -0500
Received: by mail-wr1-f69.google.com with SMTP id e3so15776712wrs.17
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 09:48:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nmpz5zZisvgmpXO3F5mGN69D+5HVCgoutUU6rqLL/Wo=;
 b=cb4zCbLLXfo3RZLlSCbTzyfupnyRkUHckXzhnHnRdC9G/fSt2mOufzQbVpUx66ISTH
 VomXMxMW0qfituwMSiGEhAKXZi0p8LCq4pg2/xC4i5IOVZbfIVPqsY6lAgA8mFPJfEgL
 tYqKhJ/7FID06b62JQjuqCIthNZV/CJmcd2jsxJ2TMPphe/GtunyCSkJyN9WGRL2u142
 lWyBkLWEJa3dMXK+fBSluvsLX5WZc2jd2HThGyZgJPpZ56NAkRSXr/0LAzyn6WduA/zv
 ye5aFVZEO/9BW7F/x4+DARl/nQX/vft5j3wMsmYWgbbIXeZ/Jb/TKtE81tFwp5+FSkcX
 1fzg==
X-Gm-Message-State: APjAAAXsQo6oDyq4hp9w41xjfzzN3vwi7PiP7arHM1nO71rRvLofsr9/
 I1BMiii0m5C89dLX00GNHsFP4TosF96DCpWitRiFVpCK0qGtztojx+RsW58L3NpDWe5HGkqmkdj
 p1fmDDUoFpeft40I=
X-Received: by 2002:adf:e8ce:: with SMTP id k14mr30915081wrn.393.1574099338844; 
 Mon, 18 Nov 2019 09:48:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqxgQ5QUtei42rzilD8Lbq2iHeGG0EY6lbsWnuI9xC4Z6PfS3uPn4qvxSNDzJ0570fAshB4LUA==
X-Received: by 2002:adf:e8ce:: with SMTP id k14mr30915019wrn.393.1574099338344; 
 Mon, 18 Nov 2019 09:48:58 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id f14sm23625258wrv.17.2019.11.18.09.48.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2019 09:48:57 -0800 (PST)
Subject: Re: [PATCH] misc/pca9552: Add qom set and get
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>
References: <20191118061757.52550-1-joel@jms.id.au>
 <42f378d5-e7ea-11ce-11d5-9589fe7194d2@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9f810374-97d4-8162-c92d-a1513c1a23a0@redhat.com>
Date: Mon, 18 Nov 2019 18:48:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <42f378d5-e7ea-11ce-11d5-9589fe7194d2@kaod.org>
Content-Language: en-US
X-MC-Unique: NCPLtByVMvuR-mLQ7-DEGQ-1
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Rashmica Gupta <rashmica.g@gmail.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Odd... I only received C=C3=A9dric answer, not Joel patch.

On 11/18/19 11:00 AM, C=C3=A9dric Le Goater wrote:
> On 18/11/2019 07:17, Joel Stanley wrote:
>> Following the pattern of the work recently done with the ASPEED GPIO
>> model, this adds support for inspecting and modifying the PCA9552 LEDs
>> from the monitor.
>>
>>   (qemu) qom-set  /machine/unattached/device[17] led0 on
>>   (qemu) qom-get  /machine/unattached/device[17] led0
>>   "on"
>>
>>   (qemu) qom-set  /machine/unattached/device[17] led0 off
>>   (qemu) qom-get  /machine/unattached/device[17] led0
>>   "off"
>>
>>   (qemu) qom-set  /machine/unattached/device[17] led0 pwm0
>>   (qemu) qom-get  /machine/unattached/device[17] led0
>>   "pwm0"
>>
>>   (qemu) qom-set  /machine/unattached/device[17] led0 pwm1
>>   (qemu) qom-get  /machine/unattached/device[17] led0
>>   "pwm1"
>=20
> It would be nice to revive the QOM get patchset from David.
>=20
> =09http://patchwork.ozlabs.org/patch/666458/
>=20
> Did we reach some consensus ?
>=20
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>=20
> Some comments below.
>=20
>> ---
>> The qom device in mainline qemu is a different path. Using the monitor
>> examine `info qom-tree /machine/unattached/` to discover it.
>>
>> This can be tested with a Witherspoon image.
>>
>> $ wget https://openpower.xyz/job/openbmc-build/distro=3Dubuntu,label=3Db=
uilder,target=3Dwitherspoon/lastSuccessfulBuild/artifact/deploy/images/with=
erspoon/obmc-phosphor-image-witherspoon.ubi.mtd
>>
>> $ qemu-system-arm -M witherspoon-bmc -serial pty -monitor pty -nographic=
 \
>>   -drive file=3Dobmc-phosphor-image-witherspoon.ubi.mtd,format=3Draw,if=
=3Dmtd
>> char device redirected to /dev/pts/5 (label compat_monitor0)
>> char device redirected to /dev/pts/10 (label serial0)
>>
>> $ screen /dev/pts/5
>> QEMU 4.1.91 monitor - type 'help' for more information
>> (qemu) qom-get  /machine/unattached/device[17] led0
>> "off"
>>
>> $ screen /dev/pts/19
>> root@witherspoon:~# cd /sys/class/gpio/
>> root@witherspoon:/sys/class/gpio# echo 248 > export
>> root@witherspoon:/sys/class/gpio# cat gpio248/value
>> 0
>>
>> (qemu) qom-set  /machine/unattached/device[17] led0 on
>>
>> root@witherspoon:/sys/class/gpio# echo out > gpio248/direction
>> root@witherspoon:/sys/class/gpio# cat gpio248/value
>> 1
>>
>> (qemu) qom-get  /machine/unattached/device[17] led0
>> "on"
>>
>> (qemu) qom-set  /machine/unattached/device[17] led0 off
>> (qemu) qom-get  /machine/unattached/device[17] led0
>> "off"
>>
>> root@witherspoon:/sys/class/gpio# cat gpio248/value
>> 0

I am assuming this is 5.0 material.

This is a good starting point, and is useful.

However this would be useful for other boards/devices too.

What about defining a InterfaceInfo[] for external GPIOs?

Shouldn't we use the qemu_irq type for that then?

>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>>   hw/misc/pca9552.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 91 insertions(+)
>>
>> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
>> index 73be28d9369c..0362aac8c862 100644
>> --- a/hw/misc/pca9552.c
>> +++ b/hw/misc/pca9552.c
>> @@ -15,12 +15,16 @@
>>   #include "hw/misc/pca9552.h"
>>   #include "hw/misc/pca9552_regs.h"
>>   #include "migration/vmstate.h"
>> +#include "qapi/error.h"
>> +#include "qapi/visitor.h"
>>  =20
>>   #define PCA9552_LED_ON   0x0
>>   #define PCA9552_LED_OFF  0x1
>>   #define PCA9552_LED_PWM0 0x2
>>   #define PCA9552_LED_PWM1 0x3
>>  =20
>> +static const char *led_state[] =3D {"on", "off", "pwm0", "pwm1"};

BTW "pwm0/pwm1" as "state" is confuse, but I understand this is how the=20
PCA9552 datasheet describes it.

>> +
>>   static uint8_t pca9552_pin_get_config(PCA9552State *s, int pin)
>>   {
>>       uint8_t reg   =3D PCA9552_LS0 + (pin / 4);
>> @@ -169,6 +173,84 @@ static int pca9552_event(I2CSlave *i2c, enum i2c_ev=
ent event)
>>       return 0;
>>   }
>>  =20
>> +static void pca9552_get_led(Object *obj, Visitor *v, const char *name,
>> +                            void *opaque, Error **errp)
>> +{
>> +    PCA9552State *s =3D PCA9552(obj);
>> +    int led, rc, reg;
>> +    char *str;
>> +    uint8_t state;
>> +
>> +    rc =3D sscanf(name, "led%2d", &led);
>> +    if (rc !=3D 1) {
>> +        error_setg(errp, "%s: error reading %s", __func__, name);
>> +        return;
>> +    }
>> +    if (led < 0 || led > s->nr_leds) {
>> +        error_setg(errp, "%s invalid led %s", __func__, name);
>> +        return;
>> +    }
>> +    /*
>> +     * Get the LSx register as the qom interface should expose the devi=
ce
>> +     * state, not the modeled 'input line' behaviour which would come f=
rom
>> +     * reading the INPUTx reg
>> +     */
>> +    reg =3D PCA9552_LS0 + led / 4;
>> +    state =3D (pca9552_read(s, reg) >> (led % 8)) & 0x3;
>=20
> Could we add accessors to extract the register fields and to clarify
> the layout ?
>=20
>> +    str =3D g_strdup(led_state[state]);
>> +    visit_type_str(v, name, &str, errp);
>> +}
>> +
>> +/*
>> + * Return an LED selector register value based on an existing one, with
>> + * the appropriate 2-bit state value set for the given LED number (0-3)=
.
>> + */
>> +static inline uint8_t pca955x_ledsel(uint8_t oldval, int led_num, int s=
tate)
>> +{
>> +        return (oldval & (~(0x3 << (led_num << 1)))) |
>> +                ((state & 0x3) << (led_num << 1));
>> +}
>> +
>> +static void pca9552_set_led(Object *obj, Visitor *v, const char *name,
>> +                            void *opaque, Error **errp)
>> +{
>> +    PCA9552State *s =3D PCA9552(obj);
>> +    Error *local_err =3D NULL;
>> +    int led, rc, reg, val;
>> +    uint8_t state;
>> +    char *state_str;
>> +
>> +    visit_type_str(v, name, &state_str, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +    rc =3D sscanf(name, "led%2d", &led);
>> +    if (rc !=3D 1) {
>> +        error_setg(errp, "%s: error reading %s", __func__, name);
>> +        return;
>> +    }
>> +    if (led < 0 || led > s->nr_leds) {
>> +        error_setg(errp, "%s invalid led %s", __func__, name);
>> +        return;
>> +    }
>> +
>> +    for (state =3D 0; state < ARRAY_SIZE(led_state); state++) {
>> +        if (!strcmp(state_str, led_state[state])) {
>> +            break;
>> +        }
>> +    }
>> +    if (state >=3D ARRAY_SIZE(led_state)) {
>> +        error_setg(errp, "%s invalid led state %s", __func__, state_str=
);
>> +        return;
>> +    }
>> +
>> +    reg =3D PCA9552_LS0 + led / 4;
>> +    val =3D pca9552_read(s, reg);
>> +    val =3D pca955x_ledsel(val, led % 4, state);
>> +    pca9552_write(s, reg, val);
>> +}
>> +
>>   static const VMStateDescription pca9552_vmstate =3D {
>>       .name =3D "PCA9552",
>>       .version_id =3D 0,
>> @@ -204,6 +286,7 @@ static void pca9552_reset(DeviceState *dev)
>>   static void pca9552_initfn(Object *obj)
>>   {
>>       PCA9552State *s =3D PCA9552(obj);
>> +    int led;
>>  =20
>>       /* If support for the other PCA955X devices are implemented, these
>>        * constant values might be part of class structure describing the
>> @@ -211,6 +294,14 @@ static void pca9552_initfn(Object *obj)
>>        */
>>       s->max_reg =3D PCA9552_LS3;
>>       s->nr_leds =3D 16;
>> +
>> +    for (led =3D 0; led < s->nr_leds; led++) {
>> +        char *name;
>> +
>> +        name =3D g_strdup_printf("led%d", led);
>> +        object_property_add(obj, name, "bool", pca9552_get_led, pca9552=
_set_led,
>> +                            NULL, NULL, NULL);
>=20
> It misses a :
>=20
>     g_free(name)
>=20
> C.
>=20
>> +    }
>>   }
>>  =20
>>   static void pca9552_class_init(ObjectClass *klass, void *data)
>>
>=20
>=20


