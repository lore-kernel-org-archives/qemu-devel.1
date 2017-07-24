Received: from eggs.gnu.org ([2001:4830:134:3::10]:43120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZlM7-0002ep-0k
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZlM6-0005x6-1P
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:57:35 -0400
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-22-f4bug@amsat.org>
	<CAFEAcA_PRH_BuUOTtC=cvRFT7Gtiwt50T6C3avm+Sy13aDS4tg@mail.gmail.com>
	<ae090923-3523-3e56-fbc1-65b270680939@amsat.org>
	<e0d37c83-537a-5288-b033-e5be3b8858ca@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c1078250-30a0-0d4c-d830-88591fb6ba43@redhat.com>
Date: Mon, 24 Jul 2017 16:57:18 -0500
MIME-Version: 1.0
In-Reply-To: <e0d37c83-537a-5288-b033-e5be3b8858ca@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UuM0Tu06NIUC2HMBF20BUwnENd9njpm3b"
Subject: Re: [Qemu-devel] [PATCH for 2.10 21/35] arm/sysbus-fdt: fix null
 pointer dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UuM0Tu06NIUC2HMBF20BUwnENd9njpm3b
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <c1078250-30a0-0d4c-d830-88591fb6ba43@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.10 21/35] arm/sysbus-fdt: fix null
 pointer dereference
References: <20170724182751.18261-1-f4bug@amsat.org>
 <20170724182751.18261-22-f4bug@amsat.org>
 <CAFEAcA_PRH_BuUOTtC=cvRFT7Gtiwt50T6C3avm+Sy13aDS4tg@mail.gmail.com>
 <ae090923-3523-3e56-fbc1-65b270680939@amsat.org>
 <e0d37c83-537a-5288-b033-e5be3b8858ca@redhat.com>
In-Reply-To: <e0d37c83-537a-5288-b033-e5be3b8858ca@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/24/2017 04:52 PM, Eric Blake wrote:
> On 07/24/2017 04:48 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 07/24/2017 06:09 PM, Peter Maydell wrote:
>>> On 24 July 2017 at 19:27, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>>>> Use error_report() + exit() instead of error_setg(&error_fatal).
>>>>
>>>> hw/arm/sysbus-fdt.c:322:9: warning: Array access (from variable
>>>> 'node_path') results in a null pointer dereference
>>>>      if (node_path[1]) {
>>>>          ^~~~~~~~~~~~
>>>
>>> I don't understand what this warning is trying to say.
>>> We can't get to this point with a NULL node_path,
>>> because of the previous conditional, which is using
>>> error_setg(&error_fatal).
>>
>> Ok I see, Clang is unaware than error_setg(&error_fatal) is a noreturn=
=2E
>=20
> Indeed, and that's because error_setg(&error_fatal) is not in preferred=

> form.
>=20
>>
>> Patch dropped.
>=20
> That's a shame.  Rather, we should patch this file (and others) to avoi=
d
> all the inconsistent uses of error_setg(&error_*), to comply with the
> error.h documentation.

In other words, switching to the preferred spelling in the following file=
s:
device_tree.c
hw/arm/sysbus-fdt.c
hw/block/fdc.c
hw/ppc/spapr_drc.c

is desirable, and has the added benefit of also silencing a Coverity
false positive.  But it should be done in terms of switching to the
preferred spelling, as it touches more instances than just the one that
shuts up Coverity.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UuM0Tu06NIUC2HMBF20BUwnENd9njpm3b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll2bT4ACgkQp6FrSiUn
Q2pokggAphLmlsdXFNxF//VMyJjkgoD1HN7lpy1rM+HYZclyEaasn1AUatSL7amx
8JGC2XcmDKglkBEa4IRRWkI4G+xtWHEgdTDAfI98H07CpYPzneXAijivu+sBv/P7
MNpHr8jjcHrvvAsIALinaCyFDdOWt5QnI6ZxN1g0MuBfiviPsN6yEHJdneiZ0YKl
isZ/EN2xa50I9rmbM+LladwSIX3/v3yIp5S+/+nCzXSBScGpfUGKO1og9dgSBhgA
YPtuE+js1Q+YGb/K+ojhIDibdJw54GjlhK7arHaBRO3+Lov3swu/aLGOqXVWpTet
wzQKQ0vpl5ue007pIG7Qk7UlcmU5Og==
=WF4E
-----END PGP SIGNATURE-----

--UuM0Tu06NIUC2HMBF20BUwnENd9njpm3b--
