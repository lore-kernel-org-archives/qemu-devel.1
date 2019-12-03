Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872A2C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 16:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 537FB206EC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 16:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="OEJ3qSVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537FB206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icAwT-00071m-TI
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 11:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1icADO-0002iy-Hj
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 10:35:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1icADM-0001ew-E3
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 10:35:50 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:42236)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1icAD8-0001TX-5I; Tue, 03 Dec 2019 10:35:35 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id DCD3096EF0;
 Tue,  3 Dec 2019 15:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1575387330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3rtcgx24BVdxIE+n3CGbbouJnJV5jKm2LoYK00DXaEs=;
 b=OEJ3qSVVm5k8two2BmGqm8TXAADshyO7sFGozbodU4XCA3r+Un0ewHCkkL7ZpL31aqenJQ
 9rOoU0oL1aipTwBujtVobAn0hSD9xRF7NbL8B4ECbE9zDcwO8XhsMEfifAAofn6bKEKiNu
 Xe3VEztr3kecFoEY6AUIC0p84FGc2+8=
Subject: Re: [PATCH v6 3/9] qdev: add clock input&output support to devices.
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
 <20190904125531.27545-4-damien.hedde@greensocs.com>
 <a7d0808d-b57a-f8a7-93ea-ec69aee81cf9@redhat.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <b4f65dde-6752-abba-0b9b-d95cddd09f04@greensocs.com>
Date: Tue, 3 Dec 2019 16:35:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <a7d0808d-b57a-f8a7-93ea-ec69aee81cf9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1575387330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3rtcgx24BVdxIE+n3CGbbouJnJV5jKm2LoYK00DXaEs=;
 b=iNQjZ75iPSc3miDBaPymDurBw9qHFoIuohGqgdrP2jmS1vh9d5d5g3oUDhscGY+LPV1adZ
 pwthFQbMM/ZVsxSkmaUOpDf2NQEsmUlY5MgoJqZj8lOBWkL+jQ5Ju6Vwc0n5xjxOEWn6Kr
 90M/OmUOHo9JopDYsCzxy2odhHhP19g=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1575387330; a=rsa-sha256; cv=none;
 b=7k8HL8dK8tnvMqkFIiTRbMlA6Tb3/MudCDaFaG3shDmBB9qPtv2kRX3jicl6WIeZLGvJ2d
 KPJU45zNQFtVM5fdUU5G36bl0ykxstOAt+WkgU04kjj8VgpD6BX3i7E2WUdZOuDRL6TRRm
 jeGQJ3m9S+tmHpvGZcWKCVs8BmNWwZ0=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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



On 11/25/19 2:30 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Nitpick: remove trailing dot in patch subject
>=20
> On 9/4/19 2:55 PM, Damien Hedde wrote:
>> Add functions to easily add input or output clocks to a device.
>> A clock objects is added as a child of the device.
>=20
> <newline>?
>=20
>> The api is very similar the gpio's one.
>=20
> Maybe "This API is very similar to the QDEV GPIO API."
>=20
>>
>> This is based on the original work of Frederic Konrad.
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>>
>> ---
>> I've removed the reviewed-by/tested-by of Philippe because I did a sma=
ll
>> modification.
>>
>> qdev_connect_clock() which allowed to connect an input to an output is
>> now split in 2:
>> + qdev_get_clock_in() which gets a given input from a device
>> + qdev_connect_clock_out() which connect a given output to a clock
>> (previously fetched by qdev_get_clock_in())
>> This part is located in (qdev-clock.[c|h]).
>> It better matches gpios api and also add the possibility to connect a
>> device's input clock to a random output clock (used in patch 9).
>>
>> Also add missing qdev-clock in the test-qdev-global-props so that test=
s
>> pass.
>> ---
>> =C2=A0 hw/core/Makefile.objs=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 hw/core/qdev-clock.c=C2=A0=C2=A0=C2=A0 | 155 ++++++++++++++++++=
++++++++++++++++++++++
>> =C2=A0 hw/core/qdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 32 +++++++++
>> =C2=A0 include/hw/qdev-clock.h |=C2=A0 67 +++++++++++++++++
>> =C2=A0 include/hw/qdev-core.h=C2=A0 |=C2=A0 14 ++++
>> =C2=A0 tests/Makefile.include=C2=A0 |=C2=A0=C2=A0 1 +
>=20
> Please setup the scripts/git.orderfile to ease reviews.
>=20
>> =C2=A0 6 files changed, 270 insertions(+), 1 deletion(-)
>> =C2=A0 create mode 100644 hw/core/qdev-clock.c
>> =C2=A0 create mode 100644 include/hw/qdev-clock.h
>>
>> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
>> index 8fcebf2e67..4523d3b5c7 100644
>> --- a/hw/core/Makefile.objs
>> +++ b/hw/core/Makefile.objs
>> @@ -1,5 +1,5 @@
>> =C2=A0 # core qdev-related obj files, also used by *-user:
>> -common-obj-y +=3D qdev.o qdev-properties.o
>> +common-obj-y +=3D qdev.o qdev-properties.o qdev-clock.o
>> =C2=A0 common-obj-y +=3D bus.o reset.o
>> =C2=A0 common-obj-y +=3D resettable.o
>> =C2=A0 common-obj-$(CONFIG_SOFTMMU) +=3D qdev-fw.o
>> diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
>> new file mode 100644
>> index 0000000000..bebdd8fa15
>> --- /dev/null
>> +++ b/hw/core/qdev-clock.c
>> @@ -0,0 +1,155 @@
>> +/*
>> + * Device's clock
>> + *
>> + * Copyright GreenSocs 2016-2018
>=20
> 2019
>=20
>> + *
>> + * Authors:
>> + *=C2=A0 Frederic Konrad <fred.konrad@greensocs.com>
>> + *=C2=A0 Damien Hedde <damien.hedde@greensocs.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or
>> later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/qdev-clock.h"
>> +#include "hw/qdev-core.h"
>> +#include "qapi/error.h"
>> +
>> +static NamedClockList *qdev_init_clocklist(DeviceState *dev, const
>> char *name,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool forward)
>=20
> Indentation off.
>=20
>> +{
>> +=C2=A0=C2=A0=C2=A0 NamedClockList *ncl;
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The clock path will be computed by the dev=
ice's realize
>> function call.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * This is required to ensure the clock's can=
onical path is right
>> and log
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * messages are meaningfull.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 assert(name);
>> +=C2=A0=C2=A0=C2=A0 assert(!dev->realized);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* The ncl structure will be freed in device's fin=
alize function
>> call */
>> +=C2=A0=C2=A0=C2=A0 ncl =3D g_malloc0(sizeof(*ncl));
>=20
> Similar but easier to review:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ncl =3D g_new0(NamedClockList, 1)
>=20
>> +=C2=A0=C2=A0=C2=A0 ncl->name =3D g_strdup(name);
>> +=C2=A0=C2=A0=C2=A0 ncl->forward =3D forward;
>> +
>> +=C2=A0=C2=A0=C2=A0 QLIST_INSERT_HEAD(&dev->clocks, ncl, node);
>> +=C2=A0=C2=A0=C2=A0 return ncl;
>> +}
>> +
>> +ClockOut *qdev_init_clock_out(DeviceState *dev, const char *name)
>> +{
>> +=C2=A0=C2=A0=C2=A0 NamedClockList *ncl;
>> +=C2=A0=C2=A0=C2=A0 Object *clk;
>> +
>> +=C2=A0=C2=A0=C2=A0 ncl =3D qdev_init_clocklist(dev, name, false);
>> +
>> +=C2=A0=C2=A0=C2=A0 clk =3D object_new(TYPE_CLOCK_OUT);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* will fail if name already exists */
>> +=C2=A0=C2=A0=C2=A0 object_property_add_child(OBJECT(dev), name, clk, =
&error_abort);
>> +=C2=A0=C2=A0=C2=A0 object_unref(clk); /* remove the initial ref made =
by object_new */
>> +
>> +=C2=A0=C2=A0=C2=A0 ncl->out =3D CLOCK_OUT(clk);
>> +=C2=A0=C2=A0=C2=A0 return ncl->out;
>> +}
>> +
>> +ClockIn *qdev_init_clock_in(DeviceState *dev, const char *name,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Clo=
ckCallback *callback, void *opaque)
>=20
> Indentation off.
>=20
>> +{
>> +=C2=A0=C2=A0=C2=A0 NamedClockList *ncl;
>> +=C2=A0=C2=A0=C2=A0 Object *clk;
>> +
>> +=C2=A0=C2=A0=C2=A0 ncl =3D qdev_init_clocklist(dev, name, false);
>> +
>> +=C2=A0=C2=A0=C2=A0 clk =3D object_new(TYPE_CLOCK_IN);
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * the ref initialized by object_new will be =
cleared during dev
>> finalize.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * It allows us to safely remove the callback=
.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* will fail if name already exists */
>> +=C2=A0=C2=A0=C2=A0 object_property_add_child(OBJECT(dev), name, clk, =
&error_abort);
>> +
>> +=C2=A0=C2=A0=C2=A0 ncl->in =3D CLOCK_IN(clk);
>> +=C2=A0=C2=A0=C2=A0 if (callback) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock_set_callback(ncl->in=
, callback, opaque);
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 return ncl->in;
>> +}
>> +
>> +static NamedClockList *qdev_get_clocklist(DeviceState *dev, const
>> char *name)
>> +{
>> +=C2=A0=C2=A0=C2=A0 NamedClockList *ncl;
>> +
>> +=C2=A0=C2=A0=C2=A0 QLIST_FOREACH(ncl, &dev->clocks, node) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (strcmp(name, ncl->name=
) =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn ncl;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return NULL;
>> +}
>> +
>> +void qdev_pass_clock(DeviceState *dev, const char *name,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceState *containe=
r, const char *cont_name)
>> +{
>> +=C2=A0=C2=A0=C2=A0 NamedClockList *original_ncl, *ncl;
>> +=C2=A0=C2=A0=C2=A0 Object **clk;
>=20
> Is it really a Object** or a Object*?

An Object** because it tells where the Object* is stored for the link
property below.

>=20
>> +
>> +=C2=A0=C2=A0=C2=A0 assert(container && cont_name);
>> +
>> +=C2=A0=C2=A0=C2=A0 original_ncl =3D qdev_get_clocklist(container, con=
t_name);
>> +=C2=A0=C2=A0=C2=A0 assert(original_ncl); /* clock must exist in origi=
n */
>> +
>> +=C2=A0=C2=A0=C2=A0 ncl =3D qdev_init_clocklist(dev, name, true);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (ncl->out) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk =3D (Object **)&ncl->o=
ut;
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk =3D (Object **)&ncl->i=
n;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 /* will fail if name already exists */
>> +=C2=A0=C2=A0=C2=A0 object_property_add_link(OBJECT(dev), name,
>> object_get_typename(*clk),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 clk, NULL, OBJ_PROP_LINK_STRONG,
>> &error_abort);
>> +}
>> +

--
Damien

