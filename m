Received: from eggs.gnu.org ([2001:4830:134:3::10]:56363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwtdv-0006qk-JD
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwtdt-0004NI-9p
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:27:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dwtdt-0004Mm-0Q
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:27:33 -0400
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
	<150642387446.3900.8629683985208127854.stgit@Misha-PC.lan02.inno>
	<CAKmqyKMrFGWDctvuPMFyEGqBm6QMF2VTArqV6v2rONVeUa8SrA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7db986e7-3cec-f606-530d-f442b7562be3@redhat.com>
Date: Tue, 26 Sep 2017 12:27:29 -0500
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMrFGWDctvuPMFyEGqBm6QMF2VTArqV6v2rONVeUa8SrA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Dj6jexTIOPGCAJDF1hOiqgvX4hA40reIn"
Subject: Re: [Qemu-devel] [PATCH 05/43] windbg: added helper features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>, Mihail Abakumov <mikhail.abakumov@ispras.ru>
Cc: Stefan Weil <sw@weilnetz.de>, lprosek@redhat.com, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, dovgaluk@ispras.ru, rkagan@virtuozzo.com, den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Dj6jexTIOPGCAJDF1hOiqgvX4hA40reIn
From: Eric Blake <eblake@redhat.com>
To: Alistair Francis <alistair23@gmail.com>,
 Mihail Abakumov <mikhail.abakumov@ispras.ru>
Cc: Stefan Weil <sw@weilnetz.de>, lprosek@redhat.com,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 dovgaluk@ispras.ru, rkagan@virtuozzo.com, den@openvz.org,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7db986e7-3cec-f606-530d-f442b7562be3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/43] windbg: added helper features
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
 <150642387446.3900.8629683985208127854.stgit@Misha-PC.lan02.inno>
 <CAKmqyKMrFGWDctvuPMFyEGqBm6QMF2VTArqV6v2rONVeUa8SrA@mail.gmail.com>
In-Reply-To: <CAKmqyKMrFGWDctvuPMFyEGqBm6QMF2VTArqV6v2rONVeUa8SrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/26/2017 12:13 PM, Alistair Francis wrote:

>> +#if (WINDBG_DEBUG_ON)
>> +
>> +# define WINDBG_DEBUG(...) do {    \
>> +    printf("Debug: " __VA_ARGS__); \
>> +    printf("\n");                  \
>> +} while (false)
>> +
>> +# define WINDBG_ERROR(...) do {    \
>> +    printf("Error: " __VA_ARGS__); \
>> +    printf("\n");                  \
>> +} while (false)
>=20
> Use qemu_log() instead of printf().
>=20
> Have a look as some other files for the usual way we handle debug print=
ing.
>=20
>> +
>> +#else
>> +
>> +# define WINDBG_DEBUG(...)
>> +# define WINDBG_ERROR(...) error_report(WINDBG ": " __VA_ARGS__)

What's more - as written, your approach is prone to bit-rot: the
debug/error statements are not compared against -Werror except for the
rare person that enables debugging.  Better is go make the macro
unconditionally expand to something that triggers -Wformat checking, but
guarded by an if(0) for normal use.  Or even switch to trace points
rather than debugging statements, so that you can control at runtime how
much debugging information you want, rather than having to recompile to
turn it on and off.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Dj6jexTIOPGCAJDF1hOiqgvX4hA40reIn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnKjgEACgkQp6FrSiUn
Q2pdTAf/WKAvYLMCIuHUa1qbd/zAOmVdHjTW7ODmylzOusc2cwtHfGNa95i0gwNL
lORMp4gPwNfM5UWkXDnLjw0WB6p3kimrjZM100Am06O3xawM6XK/xAx2zJquPv8G
cIBFF2Dz/I6GhD8h8lz4TFstTo8pBSLooTk5ulyj6zS/9v0Z9NXWj52tQ1PVO3Yp
BTbcPH/3AuINq30UAnayG/r9R1b619ylr9cKChvdl956akdvsENVGHz8PzoOy4lV
YvHh46b2t1H+/v7LfIhtWg+O1mWulGABr1tF94WwjErb50tyOrv+S/98x0aAmXk7
a7nRx35tpKJ20uVYsQfOeD0VIwNs9A==
=ZMns
-----END PGP SIGNATURE-----

--Dj6jexTIOPGCAJDF1hOiqgvX4hA40reIn--
