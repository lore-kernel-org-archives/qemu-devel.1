Received: from eggs.gnu.org ([2001:4830:134:3::10]:60693)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1eAJcb-0000fS-9R
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:49:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1eAJcY-0002wS-7H
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:49:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:56349)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1eAJcX-0002v4-R1
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:49:38 -0400
References: <20171028194833.23858-1-n54@gmx.com>
	<CAFEAcA8Rw99f6aB-=4bahwyxpPMYiyG0aCCAyqBmva3vMYrJDA@mail.gmail.com>
	<891b1cf9-6d6f-ace6-c6af-ec9ef4e83139@gmx.com>
	<CAFEAcA-d3z-968piK2X0-8GBdGVqZjqrCnoKkvrjOxOu8PULXQ@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <bab3e4fa-5485-8c8b-dccd-c87256106d58@gmx.com>
Date: Thu, 2 Nov 2017 18:52:04 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-d3z-968piK2X0-8GBdGVqZjqrCnoKkvrjOxOu8PULXQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="acCoXuWD8RVtTfoKimJcm3EkoW6hDVujr"
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Use sysctl(2) call to resolve
 exec_dir on NetBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Antonio_Huete_Jim=c3=a9nez?= <tuxillo@quantumachine.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--acCoXuWD8RVtTfoKimJcm3EkoW6hDVujr
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Antonio_Huete_Jim=c3=a9nez?= <tuxillo@quantumachine.net>
Message-ID: <bab3e4fa-5485-8c8b-dccd-c87256106d58@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Use sysctl(2) call to resolve
 exec_dir on NetBSD
References: <20171028194833.23858-1-n54@gmx.com>
 <CAFEAcA8Rw99f6aB-=4bahwyxpPMYiyG0aCCAyqBmva3vMYrJDA@mail.gmail.com>
 <891b1cf9-6d6f-ace6-c6af-ec9ef4e83139@gmx.com>
 <CAFEAcA-d3z-968piK2X0-8GBdGVqZjqrCnoKkvrjOxOu8PULXQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-d3z-968piK2X0-8GBdGVqZjqrCnoKkvrjOxOu8PULXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.11.2017 18:29, Peter Maydell wrote:
> On 2 November 2017 at 17:27, Kamil Rytarowski <n54@gmx.com> wrote:
>> On 02.11.2017 17:55, Peter Maydell wrote:
>>> It's a shame the BSDs can't agree on a single way to implement this :=
-(
>=20
>> It's better to assume that there is no such entity as a shared BSD cod=
e
>> in modern BSD Operating Systems. My opinion is to drop CONFIG_BSD
>> entirely from qemu and treat __NetBSD__, __FreeBSD__ and __OpenBSD__ a=
s
>> diverse targets.
>=20
> Mmm, that's probably the best way to do it. (Better still,
> wherever possible check features rather than OS type).
>=20

Correct.

We already end up with check for CONFIG_BSD and specific BSD variation.

chardev/char-parallel.c:#ifdef CONFIG_BSD
chardev/char-parallel.c-#if defined(__FreeBSD__) ||
defined(__FreeBSD_kernel__)

util/qemu-openpty.c:#elif defined CONFIG_BSD
util/qemu-openpty.c-# include <termios.h>
util/qemu-openpty.c-# if defined(__FreeBSD__) ||
defined(__FreeBSD_kernel__) || defined(__DragonFly__)

block.c:#ifdef CONFIG_BSD
block.c-#include <sys/ioctl.h>
block.c-#include <sys/queue.h>
block.c-#ifndef __DragonFly__

Sometimes automatic detection whether a struct or function exists can
lead to problems as they might have different purpose. This is common
especially for sysctl(2) calls.

> It does mean that more minor BSD variants like DragonFly are
> in a worse place, because nobody much is going to care about
> supporting them, and they can't get automatic support by
> being "like all of the others".
>=20

Fixing and maintaining DragonFly requires non-trivial (at lest in terms
of dedicated time) effort. I wouldn't be surprised that part of qemu
problems originates from the base-system bugs (this happens in every BSD
and OS).

CC: Antonio who expressed interest in the DFLY port.

> thanks
> -- PMM
>=20



--acCoXuWD8RVtTfoKimJcm3EkoW6hDVujr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZ+1tKAAoJEEuzCOmwLnZs/RMP/2a7wCLxXrwuiVpKHyRA4GSp
OAv03ZXbhTs7Ekf68dQ7YwBjEsjxM2GLHM0uIzDPCH0mIO1NI0Caz5GRBf3WYVTl
+7sIZJDTDAOLWihacJ/l0+aM2l8Jhq2SqTIp7C1DBgSmDYgTX8TSPnL2OF/rsYrb
vmLccqbALCzDahaGKFwUkvIco6CuAXMFmruLUuMb696B1bGjH1NQLuAS5IJg4bmj
9j67O1Zwu93Mop76sFTZCWmMTDKHZHignCyq235KQ5yyg/nP87WS3ieAISrJ0ibx
PCbLWf66zP5r5DwfaWx5SsZ+FP9h5ALVQTBdc1vUPvy6q31Xa4Ysf2o9rG2sOoJv
u1x0tQYDD0DsgdI85oMg8WWmvsZ2Um9UlMVVP559OGk++vBxG+0yIndiY//JLqxk
xtZCUrENe3lXNarBbz+gjlR8OTBrY8WaCq8U829M8RrYBospGFDxUW1UGrQE3pOI
nupjDvGG1BNQfP8jE1YQGOYUgL18lQXCt8t6NqbTk1FccKeMXInwWvFtOnDhmtBj
qaU2LwrA2pYyT5NieDv/DqQYDxyu+FxxC2bmGpHH4rgaXORDAwGj8GOv10KX3SC0
pOD2+9Yqj4P1g6pH2NqOzTEng/OM02jlX3L+WcwJjHvWsIdVP6B6fnjx9ZxVHYXg
JIuvVRb21DMYTUbK7sr6
=TSK9
-----END PGP SIGNATURE-----

--acCoXuWD8RVtTfoKimJcm3EkoW6hDVujr--
