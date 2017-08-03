Received: from eggs.gnu.org ([2001:4830:134:3::10]:58000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddHwL-0007A1-OB
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddHwK-0004nI-Nd
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:21:33 -0400
References: <20170803150301.10177-1-kwolf@redhat.com>
	<20170803150301.10177-3-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8dfbc0ca-9a02-3620-d9e5-41aadee69d52@redhat.com>
Date: Thu, 3 Aug 2017 10:21:24 -0500
MIME-Version: 1.0
In-Reply-To: <20170803150301.10177-3-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XVXKnsVKWd8LmJH2x0puMlxSt7TjlcNR8"
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/5] block: Allow reopen rw
 without BDRV_O_ALLOW_RDWR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XVXKnsVKWd8LmJH2x0puMlxSt7TjlcNR8
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <8dfbc0ca-9a02-3620-d9e5-41aadee69d52@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/5] block: Allow reopen rw without
 BDRV_O_ALLOW_RDWR
References: <20170803150301.10177-1-kwolf@redhat.com>
 <20170803150301.10177-3-kwolf@redhat.com>
In-Reply-To: <20170803150301.10177-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/03/2017 10:02 AM, Kevin Wolf wrote:
> BDRV_O_ALLOW_RDWR is a flag that tells whether qemu can internally
> reopen a node read-write temporarily because the user requested
> read-write for the top-level image, but qemu decided that read-only is
> enough for this node (a backing file).
>=20
> bdrv_reopen() is different, it is also used for cases where the user
> changed their mind and wants to update the options. There is no reason
> to forbid making a node read-write in that case.

Hmm, I wonder.  https://bugzilla.redhat.com/show_bug.cgi?id=3D1465320
details a failure when starting qemu with a read-write NBD disk, then
taking several snapshots (nbd <- snap1 <- snap2 <- snap3), then where
intermediate commit (snap2 into nbd) works but live commit (snap3 into
nbd) fails with a message that nbd does not support reopening.  I'm
presuming that your series may help to address that; I'll give it a spin
and see what happens.  But first, the code review:

>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block.h |  3 ++-
>  block.c               | 11 +++++++----
>  2 files changed, 9 insertions(+), 5 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XVXKnsVKWd8LmJH2x0puMlxSt7TjlcNR8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmDP3QACgkQp6FrSiUn
Q2rtegf+Kt16kQIRzq6gPxzkH+AjB1aJP6WsES0m5SGompaESXgdy0iaMwIco907
k90hSPTPfPCXZcXzgcKq2WY3q9bFDMDWaNlI0cdoZll3fq3J0y6zsj59/bJ+nfBE
YuwRTNMmpmh+QDUWaoeIM2a2eKbfe2iUCXMXZ9QawVv/89Ir8TyyDfX9fNddWugI
Z7coJpBP5bsvGyxIryTTZlgi6PQPo6yPHlfl8bFpzkSHsfk6EhiaEZf6Z959ginS
tsp8BxI5PA9mWF4Lj+EPuWgZdxgJA5HHkohWzez2ll4WWeMkIO4i5OY6m1uc2C/O
7bRmnFomGl/aDZ98sZjRx4gww1LOBQ==
=4nrM
-----END PGP SIGNATURE-----

--XVXKnsVKWd8LmJH2x0puMlxSt7TjlcNR8--
