Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22A4C4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 09:26:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAC3A2226B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 09:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="nTd5objj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC3A2226B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWFod-0000D9-ND
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 05:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangzhiqiang.bj@bytedance.com>)
 id 1kWFnr-000837-To
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 05:25:35 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:34598)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wangzhiqiang.bj@bytedance.com>)
 id 1kWFnm-0005yV-2C
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 05:25:34 -0400
Received: by mail-oi1-x232.google.com with SMTP id n3so5171185oie.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 02:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gfVkjwpbiECLvCjfzvHuq7dKhAsvpfbMAoS3bdNvz2Q=;
 b=nTd5objjA/6tqYNZ7aF0/2ipQtoSOiaY5bbxG20BTiKci7+c7J2NPASMcdZZq1rcTd
 3IuLknDm25dvsbdbPo4iKiTYemtRvB+qZzABk6qzCLsABIPRTh06gsACRNmhkODcw6Jh
 bgFQ6zo6YnllLqcYLfG4jVzT2tGnaAuWbtUseFPfYtt+7w+I46OPo1l3XU8JRtbO9dKf
 gP1bu07ElEh4+NENLEYwxRuwZO02aNMxaFoTA01AjsJDLik2Uk+5z3hEYJ7aKQhYqp3K
 6e+rHgTHfkU+4dztLc+y0nDN07/OEVbMxgIuMp5mQ+TNDTArmewyT21A/m/3WeyERuIz
 YPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gfVkjwpbiECLvCjfzvHuq7dKhAsvpfbMAoS3bdNvz2Q=;
 b=MuyfiuRh87AAQjNiP9f6roOpYdOs4ZkQMhMM55S6Jl8QVLT0gJv5le+sYpN6zkmA6e
 hWMO6cORk4bbi/MDk+i3QpaUVWjF6PZc2kVBDacWQ202wFOtriYZVhDeIA6h6FrL2bMI
 NE7OCAvOyei3WdwRy7oIUcPMmgNzDl/oNIWp5AsSCYPQQq+z/fWxnXUpLHMyt/+jAKjc
 ldNj+pBZZCFHkk8RXC1He0Z/WSpKjdamgOB90JhHp8i8iaFKAvQNP3bCeKf4L62dboSG
 A/lwLCEfsQZ16VM9/Bdp64UlbTY0/Hh2QXsTFjh2ACXusNC5NSD9HuscrdUYrmgBnImj
 mIYw==
X-Gm-Message-State: AOAM532r4C0zA4hDZlJuKIrrCXWn13VULHgsE9FzRE0at1Ao4+NZYby8
 U09KrfOqZ2JYhtLU27YZA1irvCnC7QJIwb7qRK+jSA==
X-Google-Smtp-Source: ABdhPJyVi6SFIFTj9coq2LHVh8L5knsP+Lz7TE5omIUVHbzG4moKWDngv/3sByx2W/1iWQhy7FPa1ktNNgioSoat1/U=
X-Received: by 2002:a05:6808:b24:: with SMTP id
 t4mr4259816oij.93.1603531527535; 
 Sat, 24 Oct 2020 02:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201008090244.3770-1-wangzhiqiang.bj@bytedance.com>
 <19801c31-77e3-f51f-24ce-124ae65cd698@kaod.org>
In-Reply-To: <19801c31-77e3-f51f-24ce-124ae65cd698@kaod.org>
From: John Wang <wangzhiqiang.bj@bytedance.com>
Date: Sat, 24 Oct 2020 17:25:18 +0800
Message-ID: <CAH0XSJvZTCjKKtXrBAqC6rtuqYSYMhiSXdzvL9FD0k9QRm0mMw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/2] hw/misc: add an EMC141{3,
 4} device model
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=wangzhiqiang.bj@bytedance.com; helo=mail-oi1-x232.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?6YOB6Zu3?= <yulei.sh@bytedance.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping :)


On Fri, Oct 9, 2020 at 1:19 AM C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 10/8/20 11:02 AM, John Wang wrote:
> > Largely inspired by the TMP421 temperature sensor, here is a model for
> > the EMC1413 temperature sensors.
> >
> > Specs can be found here :
> >   https://pdf1.alldatasheet.com/datasheet-pdf/view/533713/SMSC/EMC1413.=
html
> >
> > Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>
> > ---
> > v2:
> >   - Remove DeviceInfo
>
> I will look at doing the same in TMP421. All the temperature devices
> have a lot in common.
>
> Philippe,
>
> Did you have a patchset introducing a common framework ?
>
> Thanks,
>
> C.
>
>
>
> >   - commit message: TMP423 -> TMP421
> > ---
> >  hw/arm/Kconfig      |   1 +
> >  hw/misc/Kconfig     |   4 +
> >  hw/misc/emc1413.c   | 305 ++++++++++++++++++++++++++++++++++++++++++++
> >  hw/misc/meson.build |   1 +
> >  4 files changed, 311 insertions(+)
> >  create mode 100644 hw/misc/emc1413.c
> >
> > diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> > index f303c6bead..8801ada145 100644
> > --- a/hw/arm/Kconfig
> > +++ b/hw/arm/Kconfig
> > @@ -402,6 +402,7 @@ config ASPEED_SOC
> >      select SSI_M25P80
> >      select TMP105
> >      select TMP421
> > +    select EMC1413
> >      select UNIMP
> >
> >  config MPS2
> > diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> > index 3185456110..91badf2d4d 100644
> > --- a/hw/misc/Kconfig
> > +++ b/hw/misc/Kconfig
> > @@ -13,6 +13,10 @@ config TMP421
> >      bool
> >      depends on I2C
> >
> > +config EMC1413
> > +    bool
> > +    depends on I2C
> > +
> >  config ISA_DEBUG
> >      bool
> >      depends on ISA_BUS
> > diff --git a/hw/misc/emc1413.c b/hw/misc/emc1413.c
> > new file mode 100644
> > index 0000000000..160a59495a
> > --- /dev/null
> > +++ b/hw/misc/emc1413.c
> > @@ -0,0 +1,305 @@
> > +/*
> > + * SMSC EMC141X temperature sensor.
> > + *
> > + * Copyright (c) 2020 Bytedance Corporation
> > + * Written by John Wang <wangzhiqiang.bj@bytedance.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation; either version 2 or
> > + * (at your option) version 3 of the License.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License a=
long
> > + * with this program; if not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/i2c/i2c.h"
> > +#include "migration/vmstate.h"
> > +#include "qapi/error.h"
> > +#include "qapi/visitor.h"
> > +#include "qemu/module.h"
> > +#include "qom/object.h"
> > +
> > +#define DEVICE_ID_REG                    0xfd
> > +#define MANUFACTURER_ID_REG              0xfe
> > +#define REVISION_REG                     0xff
> > +#define EMC1413_DEVICE_ID                0x21
> > +#define EMC1414_DEVICE_ID                0x25
> > +
> > +struct EMC141XState {
> > +    I2CSlave i2c;
> > +    uint8_t temperature[4];
> > +    uint8_t min[4];
> > +    uint8_t max[4];
> > +    uint8_t len;
> > +    uint8_t data;
> > +    uint8_t pointer;
> > +};
> > +
> > +struct EMC141XClass {
> > +    I2CSlaveClass parent_class;
> > +    uint8_t model;
> > +};
> > +
> > +#define TYPE_EMC141X "emc141x"
> > +OBJECT_DECLARE_TYPE(EMC141XState, EMC141XClass, EMC141X)
> > +
> > +
> > +/* the EMC141X registers */
> > +#define EMC141X_TEMP_HIGH0               0x00
> > +#define EMC141X_TEMP_HIGH1               0x01
> > +#define EMC141X_TEMP_HIGH2               0x23
> > +#define EMC141X_TEMP_HIGH3               0x2a
> > +#define EMC141X_TEMP_MAX_HIGH0           0x05
> > +#define EMC141X_TEMP_MIN_HIGH0           0x06
> > +#define EMC141X_TEMP_MAX_HIGH1           0x07
> > +#define EMC141X_TEMP_MIN_HIGH1           0x08
> > +#define EMC141X_TEMP_MAX_HIGH2           0x15
> > +#define EMC141X_TEMP_MIN_HIGH2           0x16
> > +#define EMC141X_TEMP_MAX_HIGH3           0x2c
> > +#define EMC141X_TEMP_MIN_HIGH3           0x2d
> > +
> > +static void emc141x_get_temperature(Object *obj, Visitor *v, const cha=
r *name,
> > +                                   void *opaque, Error **errp)
> > +{
> > +    EMC141XState *s =3D EMC141X(obj);
> > +    int64_t value;
> > +    int tempid;
> > +
> > +    if (sscanf(name, "temperature%d", &tempid) !=3D 1) {
> > +        error_setg(errp, "error reading %s: %s", name, g_strerror(errn=
o));
> > +        return;
> > +    }
> > +
> > +    if (tempid >=3D 4 || tempid < 0) {
> > +        error_setg(errp, "error reading %s", name);
> > +        return;
> > +    }
> > +
> > +    value =3D s->temperature[tempid] * 1000;
> > +
> > +    visit_type_int(v, name, &value, errp);
> > +}
> > +
> > +static void emc141x_set_temperature(Object *obj, Visitor *v, const cha=
r *name,
> > +                                   void *opaque, Error **errp)
> > +{
> > +    EMC141XState *s =3D EMC141X(obj);
> > +    int64_t temp;
> > +    int tempid;
> > +
> > +    if (!visit_type_int(v, name, &temp, errp)) {
> > +        return;
> > +    }
> > +
> > +    if (sscanf(name, "temperature%d", &tempid) !=3D 1) {
> > +        error_setg(errp, "error reading %s: %s", name, g_strerror(errn=
o));
> > +        return;
> > +    }
> > +
> > +    if (tempid >=3D 4 || tempid < 0) {
> > +        error_setg(errp, "error reading %s", name);
> > +        return;
> > +    }
> > +
> > +    s->temperature[tempid] =3D temp / 1000;
> > +}
> > +
> > +struct emc141x_reg {
> > +    uint8_t addr;
> > +    uint8_t *data;
> > +};
> > +
> > +static void emc141x_read(EMC141XState *s)
> > +{
> > +    EMC141XClass *sc =3D EMC141X_GET_CLASS(s);
> > +    uint8_t smsc_manufacturer_id =3D 0x5d;
> > +    uint8_t revision =3D 0x04;
> > +    struct emc141x_reg emc141x_regs[] =3D {
> > +        {DEVICE_ID_REG, &sc->model},
> > +        {MANUFACTURER_ID_REG, &smsc_manufacturer_id},
> > +        {REVISION_REG, &revision},
> > +        {EMC141X_TEMP_HIGH0, &s->temperature[0]},
> > +        {EMC141X_TEMP_HIGH1, &s->temperature[1]},
> > +        {EMC141X_TEMP_HIGH2, &s->temperature[2]},
> > +        {EMC141X_TEMP_HIGH3, &s->temperature[3]},
> > +        {EMC141X_TEMP_MAX_HIGH0, &s->max[0]},
> > +        {EMC141X_TEMP_MAX_HIGH1, &s->max[1]},
> > +        {EMC141X_TEMP_MAX_HIGH2, &s->max[2]},
> > +        {EMC141X_TEMP_MAX_HIGH3, &s->max[3]},
> > +        {EMC141X_TEMP_MIN_HIGH0, &s->min[0]},
> > +        {EMC141X_TEMP_MIN_HIGH1, &s->min[1]},
> > +        {EMC141X_TEMP_MIN_HIGH2, &s->min[2]},
> > +        {EMC141X_TEMP_MIN_HIGH3, &s->min[3]},
> > +    };
> > +    size_t i;
> > +    for (i =3D 0; i < ARRAY_SIZE(emc141x_regs); i++) {
> > +        if (emc141x_regs[i].addr =3D=3D s->pointer) {
> > +            s->data =3D *(emc141x_regs[i].data);
> > +            return;
> > +        }
> > +    }
> > +}
> > +
> > +static void emc141x_write(EMC141XState *s)
> > +{
> > +    struct emc141x_reg emc141x_regs[] =3D {
> > +        {EMC141X_TEMP_MAX_HIGH0, &s->max[0]},
> > +        {EMC141X_TEMP_MAX_HIGH1, &s->max[1]},
> > +        {EMC141X_TEMP_MAX_HIGH2, &s->max[2]},
> > +        {EMC141X_TEMP_MAX_HIGH3, &s->max[3]},
> > +        {EMC141X_TEMP_MIN_HIGH0, &s->min[0]},
> > +        {EMC141X_TEMP_MIN_HIGH1, &s->min[1]},
> > +        {EMC141X_TEMP_MIN_HIGH2, &s->min[2]},
> > +        {EMC141X_TEMP_MIN_HIGH3, &s->min[3]},
> > +    };
> > +    size_t i;
> > +    for (i =3D 0; i < ARRAY_SIZE(emc141x_regs); i++) {
> > +        if (emc141x_regs[i].addr =3D=3D s->pointer) {
> > +            *(emc141x_regs[i].data) =3D s->data;
> > +            return;
> > +        }
> > +    }
> > +}
> > +
> > +static uint8_t emc141x_rx(I2CSlave *i2c)
> > +{
> > +    EMC141XState *s =3D EMC141X(i2c);
> > +
> > +    if (s->len =3D=3D 0) {
> > +        s->len++;
> > +        return s->data;
> > +    } else {
> > +        return 0xff;
> > +    }
> > +}
> > +
> > +static int emc141x_tx(I2CSlave *i2c, uint8_t data)
> > +{
> > +    EMC141XState *s =3D EMC141X(i2c);
> > +
> > +    if (s->len =3D=3D 0) {
> > +        /* first byte is the reg pointer */
> > +        s->pointer =3D data;
> > +        s->len++;
> > +    } else if (s->len =3D=3D 1) {
> > +        s->data =3D data;
> > +        emc141x_write(s);
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static int emc141x_event(I2CSlave *i2c, enum i2c_event event)
> > +{
> > +    EMC141XState *s =3D EMC141X(i2c);
> > +
> > +    if (event =3D=3D I2C_START_RECV) {
> > +        emc141x_read(s);
> > +    }
> > +
> > +    s->len =3D 0;
> > +    return 0;
> > +}
> > +
> > +static const VMStateDescription vmstate_emc141x =3D {
> > +    .name =3D "EMC141X",
> > +    .version_id =3D 0,
> > +    .minimum_version_id =3D 0,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT8(len, EMC141XState),
> > +        VMSTATE_UINT8(data, EMC141XState),
> > +        VMSTATE_UINT8(pointer, EMC141XState),
> > +        VMSTATE_UINT8_ARRAY(temperature, EMC141XState, 4),
> > +        VMSTATE_UINT8_ARRAY(min, EMC141XState, 4),
> > +        VMSTATE_UINT8_ARRAY(max, EMC141XState, 4),
> > +        VMSTATE_I2C_SLAVE(i2c, EMC141XState),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static void emc141x_reset(I2CSlave *i2c)
> > +{
> > +    EMC141XState *s =3D EMC141X(i2c);
> > +
> > +    memset(s->temperature, 0, sizeof(s->temperature));
> > +    memset(s->min, 0, sizeof(s->min));
> > +    memset(s->max, 0x55, sizeof(s->max));
> > +    s->pointer =3D 0;
> > +    s->len =3D 0;
> > +}
> > +
> > +static void emc141x_realize(DeviceState *dev, Error **errp)
> > +{
> > +    EMC141XState *s =3D EMC141X(dev);
> > +
> > +    emc141x_reset(&s->i2c);
> > +}
> > +
> > +static void emc141x_initfn(Object *obj)
> > +{
> > +    object_property_add(obj, "temperature0", "int",
> > +                        emc141x_get_temperature,
> > +                        emc141x_set_temperature, NULL, NULL);
> > +    object_property_add(obj, "temperature1", "int",
> > +                        emc141x_get_temperature,
> > +                        emc141x_set_temperature, NULL, NULL);
> > +    object_property_add(obj, "temperature2", "int",
> > +                        emc141x_get_temperature,
> > +                        emc141x_set_temperature, NULL, NULL);
> > +    object_property_add(obj, "temperature3", "int",
> > +                        emc141x_get_temperature,
> > +                        emc141x_set_temperature, NULL, NULL);
> > +}
> > +
> > +static void emc141x_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
> > +    EMC141XClass *sc =3D EMC141X_CLASS(klass);
> > +
> > +    dc->realize =3D emc141x_realize;
> > +    k->event =3D emc141x_event;
> > +    k->recv =3D emc141x_rx;
> > +    k->send =3D emc141x_tx;
> > +    dc->vmsd =3D &vmstate_emc141x;
> > +    sc->model =3D (uintptr_t)data;
> > +}
> > +
> > +static const TypeInfo emc141x_info =3D {
> > +    .name          =3D TYPE_EMC141X,
> > +    .parent        =3D TYPE_I2C_SLAVE,
> > +    .instance_size =3D sizeof(EMC141XState),
> > +    .class_size    =3D sizeof(EMC141XClass),
> > +    .instance_init =3D emc141x_initfn,
> > +    .abstract      =3D true,
> > +};
> > +
> > +static const TypeInfo emc1413_info =3D {
> > +    .name          =3D "emc1413",
> > +    .parent        =3D TYPE_EMC141X,
> > +    .class_init    =3D emc141x_class_init,
> > +    .class_data    =3D (void *)EMC1413_DEVICE_ID,
> > +};
> > +
> > +static const TypeInfo emc1414_info =3D {
> > +    .name          =3D "emc1414",
> > +    .parent        =3D TYPE_EMC141X,
> > +    .class_init    =3D emc141x_class_init,
> > +    .class_data    =3D (void *)EMC1414_DEVICE_ID,
> > +};
> > +
> > +static void emc141x_register_types(void)
> > +{
> > +    type_register_static(&emc141x_info);
> > +    type_register_static(&emc1413_info);
> > +    type_register_static(&emc1414_info);
> > +}
> > +
> > +type_init(emc141x_register_types)
> > diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> > index 793d45b1dc..08821c72ba 100644
> > --- a/hw/misc/meson.build
> > +++ b/hw/misc/meson.build
> > @@ -9,6 +9,7 @@ softmmu_ss.add(when: 'CONFIG_PCI_TESTDEV', if_true: fil=
es('pci-testdev.c'))
> >  softmmu_ss.add(when: 'CONFIG_SGA', if_true: files('sga.c'))
> >  softmmu_ss.add(when: 'CONFIG_TMP105', if_true: files('tmp105.c'))
> >  softmmu_ss.add(when: 'CONFIG_TMP421', if_true: files('tmp421.c'))
> > +softmmu_ss.add(when: 'CONFIG_EMC1413', if_true: files('emc1413.c'))
> >  softmmu_ss.add(when: 'CONFIG_UNIMP', if_true: files('unimp.c'))
> >  softmmu_ss.add(when: 'CONFIG_EMPTY_SLOT', if_true: files('empty_slot.c=
'))
> >
> >
>

