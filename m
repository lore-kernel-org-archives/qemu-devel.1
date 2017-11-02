Received: from eggs.gnu.org ([2001:4830:134:3::10]:59274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eALjV-0007WI-5z
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 16:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eALjS-0003J3-05
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 16:04:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eALjR-0003IV-NF
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 16:04:53 -0400
Date: Thu, 2 Nov 2017 16:04:47 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <655342677.16706255.1509653087535.JavaMail.zimbra@redhat.com>
In-Reply-To: <0e24381c-3621-1dcb-02fb-1dc4f15358b2@amsat.org>
References: <20171031152443.3670-1-michael.nawrocki@gtri.gatech.edu>
	<8dbe8e3a-f8d4-3fb0-2ac8-e200ebde3dcb@redhat.com>
	<0e24381c-3621-1dcb-02fb-1dc4f15358b2@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Enable 8-byte wide MMIO for 16550 serial
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>, Avi Kivity <avi@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Konrad Frederic <fred.konrad@greensocs.com>, qemu-devel@nongnu.org, mst@redhat.com



----- Original Message -----
> From: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>
> To: "Paolo Bonzini" <pbonzini@redhat.com>, "Mike Nawrocki" <michael.nawro=
cki@gtri.gatech.edu>, "Avi Kivity"
> <avi@redhat.com>, "Peter Maydell" <peter.maydell@linaro.org>, "Konrad Fre=
deric" <fred.konrad@greensocs.com>
> Cc: qemu-devel@nongnu.org, mst@redhat.com
> Sent: Thursday, November 2, 2017 8:28:09 PM
> Subject: Re: [Qemu-devel] [PATCH] Enable 8-byte wide MMIO for 16550 seria=
l devices
>=20
> Hi Mike, Paolo.
>=20
> >> diff --git a/hw/char/serial.c b/hw/char/serial.c
> >> index 376bd2f240..c16c19a406 100644
> >> --- a/hw/char/serial.c
> >> +++ b/hw/char/serial.c
> >> @@ -1005,7 +1005,7 @@ static void serial_mm_write(void *opaque, hwaddr
> >> addr,
> >>                              uint64_t value, unsigned size)
> >>  {
> >>      SerialState *s =3D opaque;
> >> -    value &=3D ~0u >> (32 - (size * 8));
> >> +    value &=3D ~((uint64_t)0) >> (64 - (size * 8));
> >>      serial_ioport_write(s, addr >> s->it_shift, value, 1);
> >>  }
> >=20
> > Couldn't this be simply "value &=3D 255"?  Otherwise looks good.
>=20
> This is not incorrect, but I don't think this is the correct fix.
> Isn't it what memory::access_with_adjusted_size() is supposed to do with
> .impl.max_access_size =3D 1?

The mm version doesn't have .impl.max_access_size=3D1.

Thanks,

Paolo

> This looks like the same issue I tried to fix here:
> http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02255.html
>=20
> I'll try to find some time to respin the full series with tests.
>=20
> >> @@ -1014,16 +1014,22 @@ static const MemoryRegionOps serial_mm_ops[3] =
=3D {
> >>          .read =3D serial_mm_read,
> >>          .write =3D serial_mm_write,
> >>          .endianness =3D DEVICE_NATIVE_ENDIAN,
> >> +        .valid.max_access_size =3D 8,
> >> +        .impl.max_access_size =3D 8,
> >>      },
> >>      [DEVICE_LITTLE_ENDIAN] =3D {
> >>          .read =3D serial_mm_read,
> >>          .write =3D serial_mm_write,
> >>          .endianness =3D DEVICE_LITTLE_ENDIAN,
> >> +        .valid.max_access_size =3D 8,
> >> +        .impl.max_access_size =3D 8,
> >>      },
> >>      [DEVICE_BIG_ENDIAN] =3D {
> >>          .read =3D serial_mm_read,
> >>          .write =3D serial_mm_write,
> >>          .endianness =3D DEVICE_BIG_ENDIAN,
> >> +        .valid.max_access_size =3D 8,
> >> +        .impl.max_access_size =3D 8,
>=20
