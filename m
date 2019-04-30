Received: from eggs.gnu.org ([209.51.188.92]:39130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLUHp-0007Te-BB
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:03:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLUHo-0004mN-7n
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:03:13 -0400
References: <20190428110258.86681-1-liboxuan@connect.hku.hk>
	<a683a29f-ea7b-aaf9-258f-68f4ffcd9b96@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5fe13664-cabc-6fc9-7437-285cc1452944@redhat.com>
Date: Tue, 30 Apr 2019 10:03:05 -0500
MIME-Version: 1.0
In-Reply-To: <a683a29f-ea7b-aaf9-258f-68f4ffcd9b96@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2MqIhRHehvafaaPeCANYMcdExHqA49PDl"
Subject: Re: [Qemu-devel] [PATCH] virtio-mmio: Always compile debug prints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Boxuan Li <liboxuan@connect.hku.hk>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2MqIhRHehvafaaPeCANYMcdExHqA49PDl
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Boxuan Li <liboxuan@connect.hku.hk>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Message-ID: <5fe13664-cabc-6fc9-7437-285cc1452944@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-mmio: Always compile debug prints
References: <20190428110258.86681-1-liboxuan@connect.hku.hk>
 <a683a29f-ea7b-aaf9-258f-68f4ffcd9b96@redhat.com>
In-Reply-To: <a683a29f-ea7b-aaf9-258f-68f4ffcd9b96@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/30/19 5:15 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Li,
>=20
> On 4/28/19 1:02 PM, Boxuan Li wrote:
>> Wrap printf calls inside debug macros (DPRINTF) in `if` statement, and=

>> change output to stderr as well. This will ensure that printf function=

>> will always compile and prevent bitrot of the format strings.
>=20
> There is an effort in QEMU to replace the obsolete DPRINTF() macros by
> trace events (which prevent format strings bitroting).

Trace events are even more powerful than conditional debugs (in that you
can turn them on or off at runtime, instead of compile time). But
incremental improvements are still better than nothing.


>>
>> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
>> index 5807aa87fe..693b3c9eb4 100644
>> --- a/hw/virtio/virtio-mmio.c
>> +++ b/hw/virtio/virtio-mmio.c
>> @@ -28,15 +28,14 @@
>>  #include "hw/virtio/virtio-bus.h"
>>  #include "qemu/error-report.h"
>> =20
>> -/* #define DEBUG_VIRTIO_MMIO */
>> -
>> -#ifdef DEBUG_VIRTIO_MMIO

The old code let a user pass CFLAGS=3D-DDEBUG_VIRTIO_MMIO to turn things =
on...

>> -
>> -#define DPRINTF(fmt, ...) \
>> -do { printf("virtio_mmio: " fmt , ## __VA_ARGS__); } while (0)
>> -#else
>> -#define DPRINTF(fmt, ...) do {} while (0)
>> -#endif
>> +#define DEBUG_VIRTIO_MMIO 0

=2E..the new code requires a source code edit. This can be considered a
step backwards in developer friendliness.  Better might be:

#ifdef DEBUG_VIRTIO_MMIO
#define DEBUG_VIRTIO_MMIO_PRINT 1
#else
#define DEBUG_VIRTIO_MMIO_PRINT 0
#endif

>> +
>> +#define DPRINTF(fmt, ...)                                            =
\
>> +    do {                                                             =
\
>> +        if (DEBUG_VIRTIO_MMIO) {                                     =
\

and the corresponding use of DEBUG_VIRTIO_MMIO_PRINT here, so that you
preserve the ability to do a command-line CFLAGS=3D-D override, rather
than forcing a source code edit.

>> +            fprintf(stderr, "virtio_mmio: " fmt , ## __VA_ARGS__);   =
\

No space before ,

>> +        }                                                            =
\
>> +    } while (0)
>> =20
>>  /* QOM macros */
>>  /* virtio-mmio-bus */
>>
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--2MqIhRHehvafaaPeCANYMcdExHqA49PDl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzIY6kACgkQp6FrSiUn
Q2ohCAf+O2qzgwj4/OP37+rMmBJK9d1ZYizKAcHPgFU3kvzcvnkQRz8hs+FEWo7H
qN4R/RGqSiP7T+o/xqymHltFFumqegI1aG11IZf38qohr7j4MWVxdhWxFBwsgqXx
rcMe7pV/XroFXS2RlMi05Lp3uUIDFRq0DmL0L+xm+82eMveNlqJv6SRQIeV1idwm
ZPehg9LpWsTQvL4QhEwX7zsJ+EvXUMBtuGxaPX98hmE2euqo40CCi3D5tISdfIrN
W3PjG7MxMML7RJqupcatJ0DRr1FkKXAQRtml0LTpLjL7X7NYKxEYEHQQITA6+Ea9
P7Q4zhns+hMmoJYjEaOTppyIZft15w==
=DNmD
-----END PGP SIGNATURE-----

--2MqIhRHehvafaaPeCANYMcdExHqA49PDl--
