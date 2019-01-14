Received: from eggs.gnu.org ([209.51.188.92]:35857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj3lE-00076w-N0
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj3lD-00060e-Gv
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:02:44 -0500
References: <1547473614-20033-1-git-send-email-thuth@redhat.com>
	<CAFEAcA9RQ+_vC3z4qxkX9Jsu4FKHGqi6qXxgbUKn=wpPzwy4Nw@mail.gmail.com>
	<20190114143144.GH3686@redhat.com>
	<0afe72f6-05fe-9547-5f54-46a47ba1ff30@redhat.com>
	<2d4074cf-2a2c-a4b7-ec50-3324af877ff9@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bc8478dd-5f25-47c8-51e0-45bc3c35c0ae@redhat.com>
Date: Mon, 14 Jan 2019 09:02:37 -0600
MIME-Version: 1.0
In-Reply-To: <2d4074cf-2a2c-a4b7-ec50-3324af877ff9@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Rgotqwtzq5AhhIbd80NdNm6NJvHAm3OQF"
Subject: Re: [Qemu-devel] [PATCH] configure: Work-around a bug in libiscsi
 1.9.0 when used in gnu99 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>, Peter Lieven <pl@kamp.de>, QEMU Developers <qemu-devel@nongnu.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Rgotqwtzq5AhhIbd80NdNm6NJvHAm3OQF
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>, Peter Lieven <pl@kamp.de>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bc8478dd-5f25-47c8-51e0-45bc3c35c0ae@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] configure: Work-around a bug in libiscsi
 1.9.0 when used in gnu99 mode
References: <1547473614-20033-1-git-send-email-thuth@redhat.com>
 <CAFEAcA9RQ+_vC3z4qxkX9Jsu4FKHGqi6qXxgbUKn=wpPzwy4Nw@mail.gmail.com>
 <20190114143144.GH3686@redhat.com>
 <0afe72f6-05fe-9547-5f54-46a47ba1ff30@redhat.com>
 <2d4074cf-2a2c-a4b7-ec50-3324af877ff9@redhat.com>
In-Reply-To: <2d4074cf-2a2c-a4b7-ec50-3324af877ff9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/14/19 8:53 AM, Thomas Huth wrote:
> On 2019-01-14 15:50, Eric Blake wrote:
>> On 1/14/19 8:31 AM, Daniel P. Berrang=C3=A9 wrote:
>>
>>>>
>>>> Can we suppress the warnings with #pragma instead ?
>>>> That would avoid compiling the .o file with different
>>>> C semantics.
>>>
>>> IIUC this is a built-in warning you can't disable, except by changing=

>>> the compilation mode to have gnu89 inline semantics :-(
>>
>> Could we instead fix the warning by one of:
>>
>> Using pragma to declare the header as a system header (used to silence=

>> warnings from misbehaving external headers),
>=20
> How do you do that?

Using -isystem instead of -I - but that means rewriting the output of
pkg-config.

>=20
>> and/or adding #defines around the inclusion of the header to neutraliz=
e
>> the poor warnings,
>=20
> You mean something like:
>=20
> #define inline /* nothing */

or
https://stackoverflow.com/questions/1867065/how-to-suppress-gcc-warnings-=
from-library-headers
mentions:

// save diagnostic state
#pragma GCC diagnostic push

// turn off the specific warning. Can also use "-Wall"
#pragma GCC diagnostic ignored "-Wunused-but-set-variable"

#include <boost/uuid/uuid.hpp>
#include <boost/uuid/uuid_generators.hpp>
#include <boost/uuid/uuid_io.hpp>
#include <boost/lexical_cast.hpp>

// turn the warnings back on
#pragma GCC diagnostic pop

>=20
> ?
>=20
> ... sounds quite ugly to me, too.
>=20
>> but without changing the compilation mode of the
>> entire project
>=20
> The patch is only changing libiscsi_cflags, so it's not affecting the
> entire project, but just the files that use libiscsi.

Even so, limiting the damage to just the wrapper file that includes the
problematic header rather than changing the command line for the entire
compilation of those files that use libiscsi is even more precise.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Rgotqwtzq5AhhIbd80NdNm6NJvHAm3OQF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw8pI0ACgkQp6FrSiUn
Q2q9bAf/VmPgn3Bkvaw+xpe9NhZIsTv/05YTT8iMTDM97WEvZGLPlqm0PL3UjJXX
Bqcyv6UYjbdqTARkcTZgSznp7XOrcNGKMShBIrcCsAuBb2qjV0HDeElmA6eRKFyT
Act73CdB8JtZ23saPvH/dPWmlDmOtnwqNOhTT6J1jt6lzkKq+upj0U36/iPyyhaQ
rXT919NH7TdHJYQsOmpM+hEMslAYhBwctFfC0O3lYiBoWRIF2LROrM0sr+zNepWU
BQZmJLVfOA8Q2eyTwt5xuVXej2QboSVZaPWcTGK2NyjbPmNR5cDRj4I9wvhfMfoj
RGw3oUQWUtA3tT2u1vF5AIgvToItwA==
=47nb
-----END PGP SIGNATURE-----

--Rgotqwtzq5AhhIbd80NdNm6NJvHAm3OQF--
