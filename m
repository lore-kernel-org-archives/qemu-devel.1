Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14093C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA5AD20674
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXSBpNri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5AD20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBasZ-0000TT-Sh
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 05:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jBart-0008US-Az
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:08:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jBarr-00075p-Jx
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:08:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56684
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jBarr-000723-Fn
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583831282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jIsliUlvw1W3uVXLTXuZ8l7aiC7ikdmwkMJ7oc+Ix8g=;
 b=LXSBpNrihG2PV2JYT18KkcB9mv1tLq5+4QzDn77EP8dviQh5dOJtg/6MYm45Nfl5iYLwyc
 ptzySi+VNg+cqoV0qgKNA+N0ucNyErl+PwYF1x3Ak8aSFPGOHRAz//dz9TRHOQEoZSBOvO
 tLoEF7+AgtaABHKuft0cw2Bur8ngTHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-0uRaBVgDPb-UKC3_CtyOYg-1; Tue, 10 Mar 2020 05:07:59 -0400
X-MC-Unique: 0uRaBVgDPb-UKC3_CtyOYg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78AF218A6EC1;
 Tue, 10 Mar 2020 09:07:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C65775D9CA;
 Tue, 10 Mar 2020 09:07:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E001811386A6; Tue, 10 Mar 2020 10:07:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v4 2/3] mac_via: fix incorrect creation of mos6522 device
 in mac_via
References: <20200305065422.12707-1-pannengyuan@huawei.com>
 <20200305065422.12707-3-pannengyuan@huawei.com>
 <CAFEAcA_twjUHpvf5ZpzA_bKyf8MZ4BuSY0MvNTgSEyVTYf9mXQ@mail.gmail.com>
 <0b2d3222-d122-e0db-db04-1c4e3028f8f8@huawei.com>
 <CAFEAcA9PQd=PwuF+j=3kOA_eCiRd_8TLEwPx8qB-jWvV_9CcMQ@mail.gmail.com>
 <0c3ae5aa-36c3-a809-4a42-159348f44780@huawei.com>
 <CAFEAcA8_RkECOT=YJ3ML0wxBrKiqVw=CssORU=jyryfcNueB0w@mail.gmail.com>
Date: Tue, 10 Mar 2020 10:07:54 +0100
In-Reply-To: <CAFEAcA8_RkECOT=YJ3ML0wxBrKiqVw=CssORU=jyryfcNueB0w@mail.gmail.com>
 (Peter Maydell's message of "Mon, 9 Mar 2020 10:10:07 +0000")
Message-ID: <871rq08tn9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Pan Nengyuan <pannengyuan@huawei.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Widespread QOM usage anti-pattern ahead; cc: QOM maintainers.

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 9 Mar 2020 at 10:02, Pan Nengyuan <pannengyuan@huawei.com> wrote:
>> On 3/9/2020 5:21 PM, Peter Maydell wrote:
>> > Could you explain more? My thought is that we should be using
>> > sysbus_init_child_obj() and we should be doing it in the init method.
>> > Why does that break the tests ? It's the same thing various other
>> > devices do.
>>
>> device-introspect-test do the follow check for each device type:
>>
>>     qtree_start =3D qtest_hmp(qts, "info qtree");
>>     ...
>>     qtest_qmp(qts, "{'execute': 'device-list-properties','arguments': {'=
typename': %s}}", type);
>>     ...
>>     qtree_end =3D qtest_hmp(qts, "info qtree");
>>     g_assert_cmpstr(qtree_start, =3D=3D, qtree_end);
>>
>> If we do qdev_set_parent_bus in init, it will check fail when type =3D '=
mac_via'.
>> mac_via_init() is called by q800_init(). But it will not be called in qt=
est(-machine none) in the step qtree_start.
>> And after we call 'device-list-properties', mac_via_init() was called an=
d set dev parent bus. We can find these
>> devices in the qtree_end. So it break the test on the assert.
>
> Markus, do you know what's happening here? Why is
> trying to use sysbus_init_child_obj() breaking the
> device-introspect-test for this particular device,
> but fine for the other places where we use it?
> (Maybe we're accidentally leaking a reference to
> something so the sub-device stays on the sysbus
> when it should have removed itself when the
> device was deinited ?)

Two questions: (1) why does it break here, and (2) why doesn't it break
elsewhere.

First question: why does it break here?

It breaks here because asking for help with "device_add mac_via,help"
has a side effect visible in "info qtree".

>> Here is the output:
>>
>> # Testing device 'mac_via'
[Uninteresting stuff snipped...]

"info qtree" before asking for help:

>> qtree_start: bus: main-system-bus
>>   type System

"info qtree" after asking for help:

>> qtree_end: bus: main-system-bus
>>   type System
>>   dev: mos6522-q800-via2, id ""
>>     gpio-in "via2-irq" 8
>>     gpio-out "sysbus-irq" 1
>>     frequency =3D 0 (0x0)
>>     mmio ffffffffffffffff/0000000000000010
>>   dev: mos6522-q800-via1, id ""
>>     gpio-in "via1-irq" 8
>>     gpio-out "sysbus-irq" 1
>>     frequency =3D 0 (0x0)
>>     mmio ffffffffffffffff/0000000000000010

How come?

"device_add mac_via,help" shows properties of device "mac_via".  It does
so even though "mac_via" is not available with device_add.  Useful
because "info qtree" shows properties for such devices.

These properties are defined dynamically, either for the instance
(traditional) or the class.  The former typically happens in QOM
TypeInfo method .instance_init(), the latter in .class_init().

"Typically", because properties can be added elsewhere, too.  In
particular, QOM properties not meant for device_add are often created in
DeviceClass method .realize().  More on that below.

To make properties created in .instance_init() visible in help, we need
to create and destroy an instance.  This must be free of observable side
effects.

This has been such a fertile source of crashes that I added
device-introspect-test:

commit 2d1abb850fd15fd6eb75a92290be5f93b2772ec5
Author: Markus Armbruster <armbru@redhat.com>
Date:   Thu Oct 1 10:59:56 2015 +0200

    device-introspect-test: New, covering device introspection
   =20
    The test doesn't check that the output makes any sense, only that QEMU
    survives.  Useful since we've had an astounding number of crash bugs
    around there.
   =20
    In fact, we have a bunch of them right now: a few devices crash or
    hang, and some leave dangling pointers behind.  The test skips testing
    the broken parts.  The next commits will fix them up, and drop the
    skipping.
   =20
    Signed-off-by: Markus Armbruster <armbru@redhat.com>
    Reviewed-by: Eric Blake <eblake@redhat.com>
    Message-Id: <1443689999-12182-8-git-send-email-armbru@redhat.com>

Now let's examine device "mac_via".  It defines properties both in its
.class_init() and its .instance_init().

    static void mac_via_class_init(ObjectClass *oc, void *data)
    {
        DeviceClass *dc =3D DEVICE_CLASS(oc);

        dc->realize =3D mac_via_realize;
        dc->reset =3D mac_via_reset;
        dc->vmsd =3D &vmstate_mac_via;
--->    device_class_set_props(dc, mac_via_properties);
    }

where

    static Property mac_via_properties[] =3D {
        DEFINE_PROP_DRIVE("drive", MacVIAState, blk),
        DEFINE_PROP_END_OF_LIST(),
    };

And

    static void mac_via_init(Object *obj)
    {
        SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
        MacVIAState *m =3D MAC_VIA(obj);
        MOS6522State *ms;

        /* MMIO */
        memory_region_init(&m->mmio, obj, "mac-via", 2 * VIA_SIZE);
        sysbus_init_mmio(sbd, &m->mmio);

        memory_region_init_io(&m->via1mem, obj, &mos6522_q800_via1_ops,
                              &m->mos6522_via1, "via1", VIA_SIZE);
        memory_region_add_subregion(&m->mmio, 0x0, &m->via1mem);

        memory_region_init_io(&m->via2mem, obj, &mos6522_q800_via2_ops,
                              &m->mos6522_via2, "via2", VIA_SIZE);
        memory_region_add_subregion(&m->mmio, VIA_SIZE, &m->via2mem);

        /* ADB */
        qbus_create_inplace((BusState *)&m->adb_bus, sizeof(m->adb_bus),
                            TYPE_ADB_BUS, DEVICE(obj), "adb.0");

        /* Init VIAs 1 and 2 */
        sysbus_init_child_obj(OBJECT(m), "via1", &m->mos6522_via1,
                              sizeof(m->mos6522_via1), TYPE_MOS6522_Q800_VI=
A1);
        sysbus_init_child_obj(OBJECT(m), "via2", &m->mos6522_via2,
                              sizeof(m->mos6522_via2), TYPE_MOS6522_Q800_VI=
A2);

        /* Pass through mos6522 output IRQs */
        ms =3D MOS6522(&m->mos6522_via1);
        object_property_add_alias(OBJECT(m), "irq[0]", OBJECT(ms),
                                  SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abor=
t);
        ms =3D MOS6522(&m->mos6522_via2);
        object_property_add_alias(OBJECT(m), "irq[1]", OBJECT(ms),
                                  SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abor=
t);
    }

Resulting help:

  adb.0=3D<child<apple-desktop-bus>>
  drive=3D<str>            - Node name or ID of a block device to use as a =
backend
  irq[0]=3D<link<irq>>
  irq[1]=3D<link<irq>>
  mac-via[0]=3D<child<qemu:memory-region>>
  via1=3D<child<mos6522-q800-via1>>
  via1[0]=3D<child<qemu:memory-region>>
  via2=3D<child<mos6522-q800-via2>>
  via2[0]=3D<child<qemu:memory-region>>

Observe that mac_via_init() has obvious side effects.  In particular, it
creates two devices that are then visible in "info qtree", and that's
caught by device-introspect-test.

I believe these things need to be done in .realize().


Second question: why doesn't it break elsewhere?

We have >200 calls of sysbus_init_child_obj() in some 40 files.  I'm
arbitrarily picking hw/arm/allwinner-a10.c for a closer look.

It calls it from device allwinner-a10's .instance_init() method
aw_a10_init().  Side effect, clearly wrong.

But why doesn't it break device-introspect-test?  allwinner-a10 is a
direct sub-type of TYPE_DEVICE.  Neither "info qtree" nor "info
qom-tree" know how to show these.

Perhaps the side effect is visible if I peek into QOM with just the
right qom-list command.  Tell me, and I'll try to tighten
device-introspect-test accordingly.


Root cause of this issue: nobody knows how to use QOM correctly (first
order approximation).  In particular, people are perenially confused on
how to split work between .instance_init() and .realize().  We really,
really, really need to provide some guidance there!  Right now, all we
provide are hundreds of examples, many of them bad.


