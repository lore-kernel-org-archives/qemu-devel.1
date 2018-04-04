Received: from eggs.gnu.org ([2001:4830:134:3::10]:36004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3k0n-0003v7-Pd
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:07:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3k0j-0003kX-EM
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:07:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55018 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f3k0j-0003jH-8E
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:07:41 -0400
References: <20180403050115.6037-1-peterx@redhat.com>
	<20180404142220.GT4467@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3d6c0d02-60ab-3501-611e-cd5f881d59e3@redhat.com>
Date: Wed, 4 Apr 2018 10:07:34 -0500
MIME-Version: 1.0
In-Reply-To: <20180404142220.GT4467@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zw940MYcoLRPZImCMn5Em0ufMAoYADhWE"
Subject: Re: [Qemu-devel] [PATCH for-2.12] monitor: bind dispatch bh to
 iohandler context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Peter Xu <peterx@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zw940MYcoLRPZImCMn5Em0ufMAoYADhWE
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, Peter Xu <peterx@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Message-ID: <3d6c0d02-60ab-3501-611e-cd5f881d59e3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12] monitor: bind dispatch bh to
 iohandler context
References: <20180403050115.6037-1-peterx@redhat.com>
 <20180404142220.GT4467@stefanha-x1.localdomain>
In-Reply-To: <20180404142220.GT4467@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/04/2018 09:22 AM, Stefan Hajnoczi wrote:
> On Tue, Apr 03, 2018 at 01:01:15PM +0800, Peter Xu wrote:
>> Eric Auger reported the problem days ago that OOB broke ARM when runni=
ng
>> with libvirt:
>>
>> http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06231.html
>>
>> This patch fixes the problem.
>>
>> It's not really needed now since we have turned OOB off now, but it's
>> still a bug fix, and it'll start to work when we turn OOB on for ARM.
>>
>> The problem was that the monitor dispatcher bottom half was bound to
>> qemu_aio_context, but that context seems to be for block only.
>=20
> No, it is not block-only.  iohandler_ctx is for the legacy
> qemu_set_fd_handler() API only and modern code should use
> qemu_aio_context.
>=20
> The difference between qemu_aio_context and iohandler_ctx is that
> aio_poll(qemu_aio_context) does not process iohandler_ctx (since it's a=

> difference context).  That is the legacy behavior that
> qemu_set_fd_handler() expects and it's implemented by keeping a separat=
e
> iohandler_ctx.

Do I need to put a hold on my pull request while we come to a better
understanding of root cause, or is this patch still okay to include?

>=20
>> For the
>> rest of the QEMU world we should be using iohandler context.  So
>> assigning monitor dispatcher bottom half to that context.
>=20
> This patch relies on the side-effect that iohandler_ctx is only called
> later by the main loop, which seems to prevent the crash below.
>=20
> What is the actual crash/problem?  You mentioned the GIC, but what does=

> that have to do with monitor code crashing?
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--zw940MYcoLRPZImCMn5Em0ufMAoYADhWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrE6jYACgkQp6FrSiUn
Q2rYLQf+LtfMDct/Yob+Z1fv3FFKlKQp5dmE6Szl+IIgBJbysP80GJtI9yRuNF6G
iJ5P3qd+HL1vTBwCOQ9dH+cIv2jlhGEfpKvDoeAmQVIVNHzDhm7fYGbowW0URYF9
Uq56pWbCYHD3AcUIi6ETgHrHyYim/LryYlul+H09mtrUbyllYBvPfQNU+ykhxlfE
VBpsesZgCu9t0RpIHcSkM9rAzp2U4K0e127S2ntu4tgtBOG5bozD0+Gnp44Xdsg+
x1lg2Jy294mT78nsD86BFkHYs3i6G4DkJWMuIE505UoM8BrxOOBhyqJK5nKMp3gJ
Smjer4/Z3znPbfoPR1jfo2OpaSapRQ==
=crMb
-----END PGP SIGNATURE-----

--zw940MYcoLRPZImCMn5Em0ufMAoYADhWE--
