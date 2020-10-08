Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D45C4363D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 02:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C829207C3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 02:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="uVm+DR+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C829207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQLZT-0002Yp-2H
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 22:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangzhiqiang.bj@bytedance.com>)
 id 1kQLYQ-0001va-1G
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 22:21:14 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:35950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wangzhiqiang.bj@bytedance.com>)
 id 1kQLYJ-0003Ae-LM
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 22:21:12 -0400
Received: by mail-ot1-x334.google.com with SMTP id 60so4201664otw.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 19:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=u1cVdPZaYB0/ceTxA3xPCTby5JSelKTx2AbuzAApqDE=;
 b=uVm+DR+OLUHy0rpgKdEDj3FNGtp6MmcCPfXh7BiE3vmWyC61/L0a83NUcrwnN/2OSK
 tBiwL3TE8BScX5h2rvubApBRh/C8KZdg9934qPtBt//uHvLd+Tnk4O9mL9vPhQoqzL3j
 W3MqCoOCpg57P0CiZN/4xsDiqiqC/kNo9n+ulxaQK8m1bwm6mRD85FA3wNXVtT272Q6w
 c2Zp1l6KAvcwFE8dxuelApJKcTw7D9dGHD2R98kdiVzx3WZf3EWRcHzdnTiC3zp4kEkS
 pMiTe8peBX6kVvhBw1dL4Ir6ScBQ+zPyT6qsowgRDff9ZCg0KT7J7eJBcu9TeElH8K0X
 phHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=u1cVdPZaYB0/ceTxA3xPCTby5JSelKTx2AbuzAApqDE=;
 b=oj7673LzoW0n3MAqKkjkc6HRf8EYSTFLC2mhCxnmkCa42iecZm8INheeM8TNledeeK
 oYOTG2zdsR0V5dMhzJ1LtkDNCFxnvJTW/uLiVWzlMZXkkMJkURkNsYr/tb40VDq0NH3l
 b6iLZTog1K7XApOPINPnh+ZpVn4e/pjOA1ukot7KmiJPjx3ZXL7NfEm9+XKQFw5n4EDH
 VILNe29rMPpldudn6SNNIikmJEP4D/rbOM+NVqdIHNwv5i03qlhv2BzVsHKIPeApONkY
 KV2tIan9qRJpvCgSE0BsDS9hfg3PAltfwUI5toqTzBlRQPSIeZBXGYv6h9mKyWRa7/PR
 lKvg==
X-Gm-Message-State: AOAM533g8MHg1ziD3dzawv+Fzg9DC/FfGnD2dRQfeME3jnN898DWezSl
 FdtXGIICUYLU0GrE2vl4SdQfckcJlLZ0lEHyOrvS7A==
X-Google-Smtp-Source: ABdhPJwLouQEZfFw1WlR6QhOsqCHON7+qNPsY9gaVpkoRS+rmDJdU5cMqw792CtYDsrVhLwOxkN2pw8braSoieZhCSE=
X-Received: by 2002:a9d:7c87:: with SMTP id q7mr3648663otn.140.1602123665328; 
 Wed, 07 Oct 2020 19:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200929055309.509-1-wangzhiqiang.bj@bytedance.com>
 <48d16207-7ffe-97cb-c248-dc1d3515de77@kaod.org>
In-Reply-To: <48d16207-7ffe-97cb-c248-dc1d3515de77@kaod.org>
From: John Wang <wangzhiqiang.bj@bytedance.com>
Date: Thu, 8 Oct 2020 10:21:02 +0800
Message-ID: <CAH0XSJtH_syj_9qyYFmiJhLRNhkDVgtpwRo0YrE-6CULsJ+cXg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/2] hw/misc: add an EMC141{3,
 4} device model
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=wangzhiqiang.bj@bytedance.com; helo=mail-ot1-x334.google.com
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
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 Lotus Xu <xuxiaohan@bytedance.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 1, 2020 at 11:04 PM C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Hello,
>
> On 9/29/20 7:53 AM, John Wang wrote:
> > Largely inspired by the TMP423 temperature sensor, here is a model for
>
> It's a TMP421 temperature sensor

Will fix

>
> > the EMC1413 temperature sensors.
> >
> > Specs can be found here :
> >   https://pdf1.alldatasheet.com/datasheet-pdf/view/533713/SMSC/EMC1413.=
html
>
>
> Have you tested it under a current Linux kernel ?

Yes, I tested it, it works well.
>
> > Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>
> > ---
> >  hw/arm/Kconfig      |   1 +
> >  hw/misc/Kconfig     |   4 +
> >  hw/misc/emc1413.c   | 309 ++++++++++++++++++++++++++++++++++++++++++++
> >  hw/misc/meson.build |   1 +
> >  4 files changed, 315 insertions(+)
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
> > index 0000000000..2430c3f074
> > --- /dev/null
> > +++ b/hw/misc/emc1413.c
> > @@ -0,0 +1,309 @@
> > +/*
> > + * SMSC EMC1413 temperature sensor.
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
> > +typedef struct DeviceInfo {
> > +    uint8_t model;
> > +    const char *name;
> > +} DeviceInfo;
> > +
> > +static const DeviceInfo devices[] =3D {
> > +    { EMC1413_DEVICE_ID, "emc1413" },
> > +    { EMC1414_DEVICE_ID, "emc1414" },
> > +};
> >
>
> DeviceInfo is a bit redundant with EMC1413Class. We could define all
> the attributes under the class.

yes, will remove this

>
> > +struct EMC1413State {
> > +    I2CSlave i2c;
> > +    uint8_t temperature[4];
> > +    uint8_t min[4];
> > +    uint8_t max[4];
> > +    uint8_t len;
> > +    uint8_t data;
> > +    uint8_t pointer;
> > +
> > +};
> > +
> > +struct EMC1413Class {
> > +    I2CSlaveClass parent_class;
> > +    DeviceInfo *dev;
> > +};
> > +
> > +#define TYPE_EMC1413 "emc1413-generic"
> > +OBJECT_DECLARE_TYPE(EMC1413State, EMC1413Class, EMC1413)
> > +
> > +
> > +/* the EMC1413 registers */
> > +#define EMC1413_TEMP_HIGH0               0x00
> > +#define EMC1413_TEMP_HIGH1               0x01
> > +#define EMC1413_TEMP_HIGH2               0x23
> > +#define EMC1413_TEMP_HIGH3               0x2a
> > +#define EMC1413_TEMP_MAX_HIGH0           0x05
> > +#define EMC1413_TEMP_MIN_HIGH0           0x06
> > +#define EMC1413_TEMP_MAX_HIGH1           0x07
> > +#define EMC1413_TEMP_MIN_HIGH1           0x08
> > +#define EMC1413_TEMP_MAX_HIGH2           0x15
> > +#define EMC1413_TEMP_MIN_HIGH2           0x16
> > +#define EMC1413_TEMP_MAX_HIGH3           0x2c
> > +#define EMC1413_TEMP_MIN_HIGH3           0x2d
>
> There are much more and it might not be necessary to model
> them all. Do we care about the status or config reg ?

I think we don't care about them. The linux driver doesn't care about
`config reg`,
as for `status reg`, in our project (openbmc) we don't care about it.

>
> > +static void emc1413_get_temperature(Object *obj, Visitor *v, const cha=
r *name,
> > +                                   void *opaque, Error **errp)
> > +{
> > +    EMC1413State *s =3D EMC1413(obj);
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
> > +static void emc1413_set_temperature(Object *obj, Visitor *v, const cha=
r *name,
> > +                                   void *opaque, Error **errp)
> > +{
> > +    EMC1413State *s =3D EMC1413(obj);
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
> > +struct emc1413_reg {
> > +    uint8_t addr;
> > +    uint8_t *data;
> > +};
> > +
> > +static void emc1413_read(EMC1413State *s)
> > +{
> > +    EMC1413Class *sc =3D EMC1413_GET_CLASS(s);
> > +    uint8_t smsc_manufacturer_id =3D 0x5d;
> > +    uint8_t revision =3D 0x04;
> > +    struct emc1413_reg emc1413_regs[] =3D {
> > +        {DEVICE_ID_REG, &sc->dev->model},
> > +        {MANUFACTURER_ID_REG, &smsc_manufacturer_id},
> > +        {REVISION_REG, &revision},
>
> These attributes belong to the DeviceInfo structure or EMC1413Class if yo=
u
> decide to remove DeviceInfo.

yes

>
> > +        {EMC1413_TEMP_HIGH0, &s->temperature[0]},
> > +        {EMC1413_TEMP_HIGH1, &s->temperature[1]},
> > +        {EMC1413_TEMP_HIGH2, &s->temperature[2]},
> > +        {EMC1413_TEMP_HIGH3, &s->temperature[3]},
> > +        {EMC1413_TEMP_MAX_HIGH0, &s->max[0]},
> > +        {EMC1413_TEMP_MAX_HIGH1, &s->max[1]},
> > +        {EMC1413_TEMP_MAX_HIGH2, &s->max[2]},
> > +        {EMC1413_TEMP_MAX_HIGH3, &s->max[3]},
> > +        {EMC1413_TEMP_MIN_HIGH0, &s->min[0]},
> > +        {EMC1413_TEMP_MIN_HIGH1, &s->min[1]},
> > +        {EMC1413_TEMP_MIN_HIGH2, &s->min[2]},
> > +        {EMC1413_TEMP_MIN_HIGH3, &s->min[3]},
> > +    };
> > +    size_t i;
> > +    for (i =3D 0; i < ARRAY_SIZE(emc1413_regs); i++) {
> > +        if (emc1413_regs[i].addr =3D=3D s->pointer) {
> > +            s->data =3D *(emc1413_regs[i].data);
> > +            return;
> > +        }
> > +    }
> > +}
> > +
> > +static void emc1413_write(EMC1413State *s)
> > +{
> > +    struct emc1413_reg emc1413_regs[] =3D {
> > +        {EMC1413_TEMP_MAX_HIGH0, &s->max[0]},
> > +        {EMC1413_TEMP_MAX_HIGH1, &s->max[1]},
> > +        {EMC1413_TEMP_MAX_HIGH2, &s->max[2]},
> > +        {EMC1413_TEMP_MAX_HIGH3, &s->max[3]},
> > +        {EMC1413_TEMP_MIN_HIGH0, &s->min[0]},
> > +        {EMC1413_TEMP_MIN_HIGH1, &s->min[1]},
> > +        {EMC1413_TEMP_MIN_HIGH2, &s->min[2]},
> > +        {EMC1413_TEMP_MIN_HIGH3, &s->min[3]},
> > +    };
> > +    size_t i;
> > +    for (i =3D 0; i < ARRAY_SIZE(emc1413_regs); i++) {
> > +        if (emc1413_regs[i].addr =3D=3D s->pointer) {
> > +            *(emc1413_regs[i].data) =3D s->data;
> > +            return;
> > +        }
> > +    }
> > +}
> > +
> > +static uint8_t emc1413_rx(I2CSlave *i2c)
> > +{
> > +    EMC1413State *s =3D EMC1413(i2c);
> > +
> > +    if (s->len =3D=3D 0) {
> > +        s->len++;
> > +        return s->data;
> > +    } else {
> > +        return 0xff;
> > +    }
> > +}
> > +
> > +static int emc1413_tx(I2CSlave *i2c, uint8_t data)
> > +{
> > +    EMC1413State *s =3D EMC1413(i2c);
> > +
> > +    if (s->len =3D=3D 0) {
> > +        /* first byte is the reg pointer */
> > +        s->pointer =3D data;
> > +        s->len++;
> > +    } else if (s->len =3D=3D 1) {
> > +        s->data =3D data;
> > +        emc1413_write(s);
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static int emc1413_event(I2CSlave *i2c, enum i2c_event event)
> > +{
> > +    EMC1413State *s =3D EMC1413(i2c);
> > +
> > +    if (event =3D=3D I2C_START_RECV) {
> > +        emc1413_read(s);
> > +    }
> > +
> > +    s->len =3D 0;
> > +    return 0;
> > +}
> > +
> > +static const VMStateDescription vmstate_emc1413 =3D {
> > +    .name =3D "EMC1413",
> > +    .version_id =3D 0,
> > +    .minimum_version_id =3D 0,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT8(len, EMC1413State),
> > +        VMSTATE_UINT8(data, EMC1413State),
> > +        VMSTATE_UINT8(pointer, EMC1413State),
> > +        VMSTATE_UINT8_ARRAY(temperature, EMC1413State, 4),
> > +        VMSTATE_I2C_SLAVE(i2c, EMC1413State),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static void emc1413_reset(I2CSlave *i2c)
> > +{
> > +    EMC1413State *s =3D EMC1413(i2c);
> > +
> > +    memset(s->temperature, 0, sizeof(s->temperature));
> > +    memset(s->min, 0, sizeof(s->min));
> > +    memset(s->max, 0x55, sizeof(s->max));
> > +    s->pointer =3D 0;
> > +    s->len =3D 0;
> > +}
> > +
> > +static void emc1413_realize(DeviceState *dev, Error **errp)
> > +{
> > +    EMC1413State *s =3D EMC1413(dev);
> > +
> > +    emc1413_reset(&s->i2c);
> > +}
> > +
> > +static void emc1413_initfn(Object *obj)
> > +{
> > +    object_property_add(obj, "temperature0", "int",
> > +                        emc1413_get_temperature,
> > +                        emc1413_set_temperature, NULL, NULL);
> > +    object_property_add(obj, "temperature1", "int",
> > +                        emc1413_get_temperature,
> > +                        emc1413_set_temperature, NULL, NULL);
> > +    object_property_add(obj, "temperature2", "int",
> > +                        emc1413_get_temperature,
> > +                        emc1413_set_temperature, NULL, NULL);
> > +    object_property_add(obj, "temperature3", "int",
> > +                        emc1413_get_temperature,
> > +                        emc1413_set_temperature, NULL, NULL);
> > +}
> > +
> > +static void emc1413_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
> > +    EMC1413Class *sc =3D EMC1413_CLASS(klass);
> > +
> > +    dc->realize =3D emc1413_realize;
> > +    k->event =3D emc1413_event;
> > +    k->recv =3D emc1413_rx;
> > +    k->send =3D emc1413_tx;
> > +    dc->vmsd =3D &vmstate_emc1413;
> > +    sc->dev =3D (DeviceInfo *) data;
> > +}
> > +
> > +static const TypeInfo emc1413_info =3D {
> > +    .name          =3D TYPE_EMC1413,
> > +    .parent        =3D TYPE_I2C_SLAVE,
> > +    .instance_size =3D sizeof(EMC1413State),
> > +    .class_size    =3D sizeof(EMC1413Class),
> > +    .instance_init =3D emc1413_initfn,
> > +    .abstract      =3D true,
> > +};
> > +
> > +static void emc1413_register_types(void)
> > +{
> > +    int i;
> > +
> > +    type_register_static(&emc1413_info);
> > +    for (i =3D 0; i < ARRAY_SIZE(devices); ++i) {
> > +        TypeInfo ti =3D {
> > +            .name       =3D devices[i].name,
> > +            .parent     =3D TYPE_EMC1413,
> > +            .class_init =3D emc1413_class_init,
> > +            .class_data =3D (void *) &devices[i],
> > +        };
> > +        type_register(&ti);
> > +    }
> > +}
> > +
> > +type_init(emc1413_register_types)
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

