Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A917C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1724721823
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJytLYSQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1724721823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXOEU-0005fR-9t
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 06:33:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iXODY-00058t-OB
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iXODT-0007TT-Bc
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:32:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24480
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iXODT-0007RT-5B
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:32:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574249530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/JgdlCQYl45ZG1KuUlcgoaDF4DVZdtXJ4z9bLmaP+ck=;
 b=fJytLYSQqDvyhnynzmHH3OvarGsw5z1wDCrLMLmL244jAjyIQy3c5QEg/mv5H0Tn309etp
 YsgAYCnB5+O1wwkeL0WJ2vLK8BqNmrXjXoYGVLpAxCCHHZYL/r+hfJt2gypO0L6ZUpYwzA
 rQElJuzupGIN5ByzTim+Snafebj55RM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-SHyWThuAP2iLeM0T-4HBRQ-1; Wed, 20 Nov 2019 06:30:58 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3758E802689;
 Wed, 20 Nov 2019 11:30:57 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B67D5ED24;
 Wed, 20 Nov 2019 11:30:55 +0000 (UTC)
Date: Wed, 20 Nov 2019 11:30:52 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] misc/pca9552: Add qom set and get
Message-ID: <20191120113052.GB2858@work-vm>
References: <20191118061757.52550-1-joel@jms.id.au>
 <42f378d5-e7ea-11ce-11d5-9589fe7194d2@kaod.org>
MIME-Version: 1.0
In-Reply-To: <42f378d5-e7ea-11ce-11d5-9589fe7194d2@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: SHyWThuAP2iLeM0T-4HBRQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Rashmica Gupta <rashmica.g@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* C=E9dric Le Goater (clg@kaod.org) wrote:
> On 18/11/2019 07:17, Joel Stanley wrote:
> > Following the pattern of the work recently done with the ASPEED GPIO
> > model, this adds support for inspecting and modifying the PCA9552 LEDs
> > from the monitor.
> >=20
> >  (qemu) qom-set  /machine/unattached/device[17] led0 on
> >  (qemu) qom-get  /machine/unattached/device[17] led0
> >  "on"
> >=20
> >  (qemu) qom-set  /machine/unattached/device[17] led0 off
> >  (qemu) qom-get  /machine/unattached/device[17] led0
> >  "off"
> >=20
> >  (qemu) qom-set  /machine/unattached/device[17] led0 pwm0
> >  (qemu) qom-get  /machine/unattached/device[17] led0
> >  "pwm0"
> >=20
> >  (qemu) qom-set  /machine/unattached/device[17] led0 pwm1
> >  (qemu) qom-get  /machine/unattached/device[17] led0
> >  "pwm1"
>=20
> It would be nice to revive the QOM get patchset from David.=20
>=20
> =09http://patchwork.ozlabs.org/patch/666458/
>=20
> Did we reach some consensus ?=20

I don't think so; there were some other people implementing
similar patches; it got bogged down in the question of string visitors
and I hadn't dug to see if that's got fixed in the last 3 years.

Dave


> > Signed-off-by: Joel Stanley <joel@jms.id.au>
>=20
> Some comments below.
>=20
> > ---
> > The qom device in mainline qemu is a different path. Using the monitor
> > examine `info qom-tree /machine/unattached/` to discover it.
> >=20
> > This can be tested with a Witherspoon image.
> >=20
> > $ wget https://openpower.xyz/job/openbmc-build/distro=3Dubuntu,label=3D=
builder,target=3Dwitherspoon/lastSuccessfulBuild/artifact/deploy/images/wit=
herspoon/obmc-phosphor-image-witherspoon.ubi.mtd
> >=20
> > $ qemu-system-arm -M witherspoon-bmc -serial pty -monitor pty -nographi=
c \
> >  -drive file=3Dobmc-phosphor-image-witherspoon.ubi.mtd,format=3Draw,if=
=3Dmtd
> > char device redirected to /dev/pts/5 (label compat_monitor0)
> > char device redirected to /dev/pts/10 (label serial0)
> >=20
> > $ screen /dev/pts/5
> > QEMU 4.1.91 monitor - type 'help' for more information
> > (qemu) qom-get  /machine/unattached/device[17] led0
> > "off"
> >=20
> > $ screen /dev/pts/19
> > root@witherspoon:~# cd /sys/class/gpio/
> > root@witherspoon:/sys/class/gpio# echo 248 > export
> > root@witherspoon:/sys/class/gpio# cat gpio248/value
> > 0
> >=20
> > (qemu) qom-set  /machine/unattached/device[17] led0 on
> >=20
> > root@witherspoon:/sys/class/gpio# echo out > gpio248/direction
> > root@witherspoon:/sys/class/gpio# cat gpio248/value
> > 1
> >=20
> > (qemu) qom-get  /machine/unattached/device[17] led0
> > "on"
> >=20
> > (qemu) qom-set  /machine/unattached/device[17] led0 off
> > (qemu) qom-get  /machine/unattached/device[17] led0
> > "off"
> >=20
> > root@witherspoon:/sys/class/gpio# cat gpio248/value
> > 0
> >=20
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> >  hw/misc/pca9552.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> >=20
> > diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
> > index 73be28d9369c..0362aac8c862 100644
> > --- a/hw/misc/pca9552.c
> > +++ b/hw/misc/pca9552.c
> > @@ -15,12 +15,16 @@
> >  #include "hw/misc/pca9552.h"
> >  #include "hw/misc/pca9552_regs.h"
> >  #include "migration/vmstate.h"
> > +#include "qapi/error.h"
> > +#include "qapi/visitor.h"
> > =20
> >  #define PCA9552_LED_ON   0x0
> >  #define PCA9552_LED_OFF  0x1
> >  #define PCA9552_LED_PWM0 0x2
> >  #define PCA9552_LED_PWM1 0x3
> > =20
> > +static const char *led_state[] =3D {"on", "off", "pwm0", "pwm1"};
> > +
> >  static uint8_t pca9552_pin_get_config(PCA9552State *s, int pin)
> >  {
> >      uint8_t reg   =3D PCA9552_LS0 + (pin / 4);
> > @@ -169,6 +173,84 @@ static int pca9552_event(I2CSlave *i2c, enum i2c_e=
vent event)
> >      return 0;
> >  }
> > =20
> > +static void pca9552_get_led(Object *obj, Visitor *v, const char *name,
> > +                            void *opaque, Error **errp)
> > +{
> > +    PCA9552State *s =3D PCA9552(obj);
> > +    int led, rc, reg;
> > +    char *str;
> > +    uint8_t state;
> > +
> > +    rc =3D sscanf(name, "led%2d", &led);
> > +    if (rc !=3D 1) {
> > +        error_setg(errp, "%s: error reading %s", __func__, name);
> > +        return;
> > +    }
> > +    if (led < 0 || led > s->nr_leds) {
> > +        error_setg(errp, "%s invalid led %s", __func__, name);
> > +        return;
> > +    }
> > +    /*
> > +     * Get the LSx register as the qom interface should expose the dev=
ice
> > +     * state, not the modeled 'input line' behaviour which would come =
from
> > +     * reading the INPUTx reg
> > +     */
> > +    reg =3D PCA9552_LS0 + led / 4;
> > +    state =3D (pca9552_read(s, reg) >> (led % 8)) & 0x3;
>=20
> Could we add accessors to extract the register fields and to clarify=20
> the layout ?=20
>=20
> > +    str =3D g_strdup(led_state[state]);
> > +    visit_type_str(v, name, &str, errp);
> > +}
> > +
> > +/*
> > + * Return an LED selector register value based on an existing one, wit=
h
> > + * the appropriate 2-bit state value set for the given LED number (0-3=
).
> > + */
> > +static inline uint8_t pca955x_ledsel(uint8_t oldval, int led_num, int =
state)
> > +{
> > +        return (oldval & (~(0x3 << (led_num << 1)))) |
> > +                ((state & 0x3) << (led_num << 1));
> > +}
> > +
> > +static void pca9552_set_led(Object *obj, Visitor *v, const char *name,
> > +                            void *opaque, Error **errp)
> > +{
> > +    PCA9552State *s =3D PCA9552(obj);
> > +    Error *local_err =3D NULL;
> > +    int led, rc, reg, val;
> > +    uint8_t state;
> > +    char *state_str;
> > +
> > +    visit_type_str(v, name, &state_str, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +    rc =3D sscanf(name, "led%2d", &led);
> > +    if (rc !=3D 1) {
> > +        error_setg(errp, "%s: error reading %s", __func__, name);
> > +        return;
> > +    }
> > +    if (led < 0 || led > s->nr_leds) {
> > +        error_setg(errp, "%s invalid led %s", __func__, name);
> > +        return;
> > +    }
> > +
> > +    for (state =3D 0; state < ARRAY_SIZE(led_state); state++) {
> > +        if (!strcmp(state_str, led_state[state])) {
> > +            break;
> > +        }
> > +    }
> > +    if (state >=3D ARRAY_SIZE(led_state)) {
> > +        error_setg(errp, "%s invalid led state %s", __func__, state_st=
r);
> > +        return;
> > +    }
> > +
> > +    reg =3D PCA9552_LS0 + led / 4;
> > +    val =3D pca9552_read(s, reg);
> > +    val =3D pca955x_ledsel(val, led % 4, state);
> > +    pca9552_write(s, reg, val);
> > +}
> > +
> >  static const VMStateDescription pca9552_vmstate =3D {
> >      .name =3D "PCA9552",
> >      .version_id =3D 0,
> > @@ -204,6 +286,7 @@ static void pca9552_reset(DeviceState *dev)
> >  static void pca9552_initfn(Object *obj)
> >  {
> >      PCA9552State *s =3D PCA9552(obj);
> > +    int led;
> > =20
> >      /* If support for the other PCA955X devices are implemented, these
> >       * constant values might be part of class structure describing the
> > @@ -211,6 +294,14 @@ static void pca9552_initfn(Object *obj)
> >       */
> >      s->max_reg =3D PCA9552_LS3;
> >      s->nr_leds =3D 16;
> > +
> > +    for (led =3D 0; led < s->nr_leds; led++) {
> > +        char *name;
> > +
> > +        name =3D g_strdup_printf("led%d", led);
> > +        object_property_add(obj, name, "bool", pca9552_get_led, pca955=
2_set_led,
> > +                            NULL, NULL, NULL);
>=20
> It misses a :
>=20
>    g_free(name)
>=20
> C.
>=20
> > +    }
> >  }
> > =20
> >  static void pca9552_class_init(ObjectClass *klass, void *data)
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


