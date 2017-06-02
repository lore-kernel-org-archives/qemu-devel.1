Received: from eggs.gnu.org ([2001:4830:134:3::10]:47276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dGlHJ-0004Po-7t
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 08:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dGlHE-0004Os-8x
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 08:02:05 -0400
Received: from 2.mo3.mail-out.ovh.net ([46.105.75.36]:57170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dGlHD-0004NE-Vl
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 08:02:00 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 932C9DE7CC
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 14:01:57 +0200 (CEST)
References: <1494827476-1487-1-git-send-email-clg@kaod.org>
	<1494827476-1487-6-git-send-email-clg@kaod.org>
	<CAFEAcA915cbt97g9f1iyTJ8CjZ96c1hbwHK2E-_57311dHSEuw@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2f880c89-2548-b6b9-2ddd-f99e975bb208@kaod.org>
Date: Fri, 2 Jun 2017 14:01:54 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA915cbt97g9f1iyTJ8CjZ96c1hbwHK2E-_57311dHSEuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/6] hw/misc: add a TMP42{1, 2,
 3} device model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 06/02/2017 12:51 PM, Peter Maydell wrote:
> On 15 May 2017 at 06:51, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>> Largely inspired by the TMP105 temperature sensor, here is a model for
>> the TMP42{1,2,3} temperature sensors.
>>
>> Specs can be found here :
>>
>>         http://www.ti.com/lit/gpn/tmp421
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> This turns out to segfault on OSX and BSD...
>=20
>> +static void tmp421_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
>> +    TMP421Class *sc =3D TMP421_CLASS(klass);
>> +
>> +    k->init =3D tmp421_init;
>> +    k->event =3D tmp421_event;
>> +    k->recv =3D tmp421_rx;
>> +    k->send =3D tmp421_tx;
>> +    dc->vmsd =3D &vmstate_tmp421;
>> +    sc->dev =3D (DeviceInfo *) data;
>=20
> ...because this write to sc->dev is off the end of a
> malloced block. You can see this with valgrind on Linux:
>=20
> $ valgrind ./build/x86/aarch64-softmmu/qemu-system-aarch64
> =3D=3D14009=3D=3D Memcheck, a memory error detector
> [...]
> =3D=3D14009=3D=3D Invalid write of size 8
> =3D=3D14009=3D=3D    at 0x67D3D9: tmp421_class_init (tmp421.c:374)
> =3D=3D14009=3D=3D    by 0x80CD51: type_initialize (object.c:334)
> =3D=3D14009=3D=3D    by 0x80CABC: type_initialize (object.c:286)
> =3D=3D14009=3D=3D    by 0x80DF49: object_class_foreach_tramp (object.c:=
805)
> =3D=3D14009=3D=3D    by 0x1B7AE33F: g_hash_table_foreach (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
> =3D=3D14009=3D=3D    by 0x80E028: object_class_foreach (object.c:827)
> =3D=3D14009=3D=3D    by 0x80E1F7: object_class_get_list (object.c:881)
> =3D=3D14009=3D=3D    by 0x5500A8: find_default_machine (vl.c:1488)
> =3D=3D14009=3D=3D    by 0x554039: select_machine (vl.c:2745)
> =3D=3D14009=3D=3D    by 0x55730E: main (vl.c:4091)
> =3D=3D14009=3D=3D  Address 0x2b4e7cd0 is 0 bytes after a block of size =
224 alloc'd
> =3D=3D14009=3D=3D    at 0x4C2FB55: calloc (in
> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> =3D=3D14009=3D=3D    by 0x1B7C4770: g_malloc0 (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
> =3D=3D14009=3D=3D    by 0x80CA8A: type_initialize (object.c:282)
> =3D=3D14009=3D=3D    by 0x80CABC: type_initialize (object.c:286)
> =3D=3D14009=3D=3D    by 0x80DF49: object_class_foreach_tramp (object.c:=
805)
> =3D=3D14009=3D=3D    by 0x1B7AE33F: g_hash_table_foreach (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
> =3D=3D14009=3D=3D    by 0x80E028: object_class_foreach (object.c:827)
> =3D=3D14009=3D=3D    by 0x80E1F7: object_class_get_list (object.c:881)
> =3D=3D14009=3D=3D    by 0x5500A8: find_default_machine (vl.c:1488)
> =3D=3D14009=3D=3D    by 0x554039: select_machine (vl.c:2745)
> =3D=3D14009=3D=3D    by 0x55730E: main (vl.c:4091)
> =3D=3D14009=3D=3D
>=20
>> +}
>> +
>> +static const TypeInfo tmp421_info =3D {
>> +    .name          =3D TYPE_TMP421,
>> +    .parent        =3D TYPE_I2C_SLAVE,
>> +    .instance_size =3D sizeof(TMP421State),
>> +    .instance_init =3D tmp421_initfn,
>> +    .class_init    =3D tmp421_class_init,
>=20
> ...which is because this TypeInfo doesn't set the
> .class_size field, so only sizeof(I2CSlaveClass) is
> allocated, not sizeof(TMP421Class).
>=20
> (http://wiki.qemu.org/Documentation/QOMConventions
> lists this as one of the things you need to do for a class
> that has a class struct).
>=20
>> +};
>> +
>> +static void tmp421_register_types(void)
>> +{
>> +    int i;
>> +
>> +    type_register_static(&tmp421_info);
>> +    for (i =3D 0; i < ARRAY_SIZE(devices); ++i) {
>> +        TypeInfo ti =3D {
>> +            .name       =3D devices[i].name,
>> +            .parent     =3D TYPE_TMP421,
>> +            .class_init =3D tmp421_class_init,
>> +            .class_data =3D (void *) &devices[i],
>=20
> This TypeInfo is a bit odd too, looking more closely at it.
> It defines a type that's a subclass of TYPE_TMP421, but which
> has a class_init method that's the same function as TYPE_TMP421's
> class_init method. That means we call it twice for the same
> class, which doesn't seem right.
>=20
>> +        };
>> +        type_register(&ti);
>> +    }
>> +}
>> +
>> +type_init(tmp421_register_types)
>> --
>> 2.7.4
>=20
> I'm going to drop this patch and the next one from my arm
> queue, but leave 1-4 in.

OK. I should be able to fix it before 2.10.=20

I would also like to spend some time on the rx8900 model Alastair=20
wrote. It would give an RTC to the romulus machine.=20

Thanks for the tests and analysis.=20

C.
