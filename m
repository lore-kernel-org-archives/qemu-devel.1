Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AF0C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70B7C20727
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZnRV0V5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B7C20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBJBR-0000iZ-J2
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 10:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jBJAn-0000J2-Hd
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:14:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jBJAm-0003I2-2X
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:14:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51969
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jBJAl-0003Ha-V9
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583763263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QNX4Im+hC3TemmHzBLATMy28GrMBg17xD63JDhgrKzk=;
 b=IZnRV0V5PyMSE4FpYMw5QFplIz7OyAUQCgS6eCGvb6mXQnimd1mIlemBkJfAGR3MGHD5KV
 TXlBnBD8ozatRe6h7AGWjx3uCjGpCnyUFOu0jrt56r4XcGSo4TXHBwnw20xY7Qn+pc+Zob
 nbpNKEWAJjzKerRKDDPMi1pD1hpO+ws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-j6CuuNmdPYOkRzDyZ0KjXQ-1; Mon, 09 Mar 2020 10:14:21 -0400
X-MC-Unique: j6CuuNmdPYOkRzDyZ0KjXQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C86C218A5515;
 Mon,  9 Mar 2020 14:14:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E15295C1C3;
 Mon,  9 Mar 2020 14:14:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 40A5311386A6; Mon,  9 Mar 2020 15:14:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH v4 2/3] mac_via: fix incorrect creation of mos6522 device
 in mac_via
References: <20200305065422.12707-1-pannengyuan@huawei.com>
 <20200305065422.12707-3-pannengyuan@huawei.com>
 <CAFEAcA_twjUHpvf5ZpzA_bKyf8MZ4BuSY0MvNTgSEyVTYf9mXQ@mail.gmail.com>
 <0b2d3222-d122-e0db-db04-1c4e3028f8f8@huawei.com>
 <CAFEAcA9PQd=PwuF+j=3kOA_eCiRd_8TLEwPx8qB-jWvV_9CcMQ@mail.gmail.com>
 <0c3ae5aa-36c3-a809-4a42-159348f44780@huawei.com>
 <CAFEAcA8_RkECOT=YJ3ML0wxBrKiqVw=CssORU=jyryfcNueB0w@mail.gmail.com>
 <87a74pso48.fsf@dusky.pond.sub.org>
 <2ff8e8e8-a281-1d50-417d-96383240c2df@huawei.com>
Date: Mon, 09 Mar 2020 15:14:17 +0100
In-Reply-To: <2ff8e8e8-a281-1d50-417d-96383240c2df@huawei.com> (Pan Nengyuan's
 message of "Mon, 9 Mar 2020 20:51:53 +0800")
Message-ID: <87ftehd39i.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pan Nengyuan <pannengyuan@huawei.com> writes:

> On 3/9/2020 8:34 PM, Markus Armbruster wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>=20
>>> On Mon, 9 Mar 2020 at 10:02, Pan Nengyuan <pannengyuan@huawei.com> wrot=
e:
>>>> On 3/9/2020 5:21 PM, Peter Maydell wrote:
>>>>> Could you explain more? My thought is that we should be using
>>>>> sysbus_init_child_obj() and we should be doing it in the init method.
>>>>> Why does that break the tests ? It's the same thing various other
>>>>> devices do.
>>>>
>>>> device-introspect-test do the follow check for each device type:
>>>>
>>>>     qtree_start =3D qtest_hmp(qts, "info qtree");
>>>>     ...
>>>>     qtest_qmp(qts, "{'execute': 'device-list-properties','arguments': =
{'typename': %s}}", type);
>>>>     ...
>>>>     qtree_end =3D qtest_hmp(qts, "info qtree");
>>>>     g_assert_cmpstr(qtree_start, =3D=3D, qtree_end);
>>>>
>>>> If we do qdev_set_parent_bus in init, it will check fail when type =3D=
 'mac_via'.
>>>> mac_via_init() is called by q800_init(). But it will not be called in =
qtest(-machine none) in the step qtree_start.
>>>> And after we call 'device-list-properties', mac_via_init() was called =
and set dev parent bus. We can find these
>>>> devices in the qtree_end. So it break the test on the assert.
>>>
>>> Markus, do you know what's happening here? Why is
>>> trying to use sysbus_init_child_obj() breaking the
>>> device-introspect-test for this particular device,
>>> but fine for the other places where we use it?
>>> (Maybe we're accidentally leaking a reference to
>>> something so the sub-device stays on the sysbus
>>> when it should have removed itself when the
>>> device was deinited ?)
>>=20
>> Pan Nengyuan, please provide the exact patch that fails for you.
>
> As the follow patch:
>
>>From 9b4f35e294597410cc03b967c127242ce099692e Mon Sep 17 00:00:00 2001
> From: Pan Nengyuan <pannengyuan@huawei.com>
> Date: Wed, 4 Mar 2020 11:29:28 +0800
> Subject: [PATCH] mac_via: fix incorrect creation of mos6522 device in mac=
_via
>
> This patch fix a bug in mac_via where it failed to actually realize devic=
es it was using.
> And move the init codes which inits the mos6522 objects and properties on=
 them from realize()
> into init(). However, we keep qdev_set_parent_bus in realize(), otherwise=
 it will cause
> device-introspect-test test fail. Then do the realize mos6522 device in t=
he mac_vir_realize.
>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
>  hw/misc/mac_via.c | 40 ++++++++++++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 14 deletions(-)
>
> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
> index b7d0012794..4c5c432140 100644
> --- a/hw/misc/mac_via.c
> +++ b/hw/misc/mac_via.c
> @@ -868,24 +868,21 @@ static void mac_via_reset(DeviceState *dev)
>  static void mac_via_realize(DeviceState *dev, Error **errp)
>  {
>      MacVIAState *m =3D MAC_VIA(dev);
> -    MOS6522State *ms;
>      struct tm tm;
>      int ret;
> +    Error *err =3D NULL;
>
> -    /* Init VIAs 1 and 2 */
> -    sysbus_init_child_obj(OBJECT(dev), "via1", &m->mos6522_via1,
> -                          sizeof(m->mos6522_via1), TYPE_MOS6522_Q800_VIA=
1);
> -
> -    sysbus_init_child_obj(OBJECT(dev), "via2", &m->mos6522_via2,
> -                          sizeof(m->mos6522_via2), TYPE_MOS6522_Q800_VIA=
2);
> +    object_property_set_bool(OBJECT(&m->mos6522_via1), true, "realized",=
 &err);
> +    if (err !=3D NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>
> -    /* Pass through mos6522 output IRQs */
> -    ms =3D MOS6522(&m->mos6522_via1);
> -    object_property_add_alias(OBJECT(dev), "irq[0]", OBJECT(ms),
> -                              SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abort=
);
> -    ms =3D MOS6522(&m->mos6522_via2);
> -    object_property_add_alias(OBJECT(dev), "irq[1]", OBJECT(ms),
> -                              SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abort=
);
> +    object_property_set_bool(OBJECT(&m->mos6522_via2), true, "realized",=
 &err);
> +    if (err !=3D NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>
>      /* Pass through mos6522 input IRQs */
>      qdev_pass_gpios(DEVICE(&m->mos6522_via1), dev, "via1-irq");
> @@ -932,6 +929,7 @@ static void mac_via_init(Object *obj)
>  {
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
>      MacVIAState *m =3D MAC_VIA(obj);
> +    MOS6522State *ms;
>
>      /* MMIO */
>      memory_region_init(&m->mmio, obj, "mac-via", 2 * VIA_SIZE);
> @@ -948,6 +946,20 @@ static void mac_via_init(Object *obj)
>      /* ADB */
>      qbus_create_inplace((BusState *)&m->adb_bus, sizeof(m->adb_bus),
>                          TYPE_ADB_BUS, DEVICE(obj), "adb.0");
> +
> +    /* Init VIAs 1 and 2 */
> +    sysbus_init_child_obj(OBJECT(m), "via1", &m->mos6522_via1,
> +                          sizeof(m->mos6522_via1), TYPE_MOS6522_Q800_VIA=
1);
> +    sysbus_init_child_obj(OBJECT(dev), "via2", &m->mos6522_via2,
> +                          sizeof(m->mos6522_via2), TYPE_MOS6522_Q800_VIA=
2);
> +
> +    /* Pass through mos6522 output IRQs */
> +    ms =3D MOS6522(&m->mos6522_via1);
> +    object_property_add_alias(OBJECT(m), "irq[0]", OBJECT(ms),
> +                              SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abort=
);
> +    ms =3D MOS6522(&m->mos6522_via2);
> +    object_property_add_alias(OBJECT(m), "irq[1]", OBJECT(ms),
> +                              SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abort=
);
>  }
>
>  static void postload_update_cb(void *opaque, int running, RunState state=
)
> --
> 2.18.2

In file included from /work/armbru/qemu/include/hw/vmstate-if.h:12,
                 from /work/armbru/qemu/include/migration/vmstate.h:30,
                 from /work/armbru/qemu/hw/misc/mac_via.c:20:
/work/armbru/qemu/hw/misc/mac_via.c: In function =E2=80=98mac_via_init=E2=
=80=99:
/work/armbru/qemu/hw/misc/mac_via.c:953:34: error: =E2=80=98dev=E2=80=99 un=
declared (first use in this function); did you mean =E2=80=98div=E2=80=99?
  953 |     sysbus_init_child_obj(OBJECT(dev), "via2", &m->mos6522_via2,
      |                                  ^~~

Try again?


