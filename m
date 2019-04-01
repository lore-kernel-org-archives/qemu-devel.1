Received: from eggs.gnu.org ([209.51.188.92]:60652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hB3Nm-0001fN-JF
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 16:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hB3Nl-0003zf-Iv
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 16:18:14 -0400
References: <20190213225311.17876-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6f315aa6-ca22-32fd-59d4-104b3db94842@redhat.com>
Date: Mon, 1 Apr 2019 15:18:07 -0500
MIME-Version: 1.0
In-Reply-To: <20190213225311.17876-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BlpOLMawQsRfvJV7dhEZFKCrOeBGQvXAN"
Subject: Re: [Qemu-devel] [PATCH v3 00/12] block: Deal with filters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BlpOLMawQsRfvJV7dhEZFKCrOeBGQvXAN
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <6f315aa6-ca22-32fd-59d4-104b3db94842@redhat.com>
Subject: Re: [PATCH v3 00/12] block: Deal with filters
References: <20190213225311.17876-1-mreitz@redhat.com>
In-Reply-To: <20190213225311.17876-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/13/19 4:52 PM, Max Reitz wrote:
> Note: This is technically the first part of my active mirror followup.
> But just very technically.  I noticed that that followup started to
> consist of two parts, namely (A) fix filtery things in the block layer,=

> and (B) fix active mirror.  So I decided to split it.  This is part A.
> Part B is =E2=80=9Cmirror: Mainly coroutine refinements=E2=80=9D.
>=20
>=20
> When we introduced filters, we did it a bit casually.  Sure, we talked =
a
> lot about them before, but that was mostly discussion about where
> implicit filters should be added to the graph (note that we currently
> only have two implicit filters, those being mirror and commit).  But in=

> the end, we really just designated some drivers filters (Quorum,
> blkdebug, etc.) and added some specifically (throttle, COR), without
> really looking through the block layer to see where issues might occur.=

>=20
> It turns out vast areas of the block layer just don=E2=80=99t know abou=
t filters
> and cannot really handle them.  Many cases will work in practice, in
> others, well, too bad, you cannot use some feature because some part
> deep inside the block layer looks at your filters and thinks they are
> format nodes.

In fact, I've hit one of those cases in trying to fix an NBD bug. If you
have: A <- B, where NBD is serving file B with forced 512-byte (or
larger) alignment, but file A has 1-byte alignment, then file A can
change status mid-sector, but file B should not advertise that
mid-sector change to the client.  So my naive thought of how to test that=
:

printf %01000d 0 > "$TEST_IMG_FILE"
$QEMU_IMG create -f qcow2 -b "$TEST_IMG_FILE" -F raw \
	  "$TEST_IMG_FILE.qcow2" 16k | _filter_img_create
nbd_server_start_unix_socket --image-opts "driver=3Dblkdebug,align=3D512,=
\
image.driver=3Dqcow2,image.file.driver=3Dfile,\
image.file.filename=3D$TEST_IMG_FILE.qcow2"

But as long as blkdebug does not know about qcow2's backing images, it
reports the entire qcow2 file as unallocated instead of seeing the
unaligned allocation from the backing file.

On the bright side, your series looks like it should fix it (although I
was unable to get it to apply cleanly to quickly test).

Hmm - maybe I can get away without needing blkdebug - qcow2 forces
512-byte alignment if it is encrypted, so if I create the overlay file
with encryption...

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--BlpOLMawQsRfvJV7dhEZFKCrOeBGQvXAN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyicgAACgkQp6FrSiUn
Q2rZ7QgAk4CIpYzABeP8zNx0ZKJizUIDkC0N+Q6vKFRQttQabZlEhSH2jaIgcj2e
iKzVq0mr4g7KGAJGeLu3sa9jqM3pxWYKQPhmxd7gicxw3yuizBmmytNos2xC7wb6
DJPH36wvIxcvnDZAKlyhAQy3qPKvwYUiPBK9xWtJhR3FwW1qtnAr2ToeHu+K1ZHb
nAEK6CkkWtVupovSkTUmwREEeox8PPBDB1bpL/9hxU027Gm7amBylo2y/ub+E4dr
py+Y2jnbrMDbwu2juL2YKlbRsiA57dUGIkRpDzvHIP7iT0iprrKvpy4LNfcHas+L
5x3KUu332y7t2GXXhYrwDJoeXQGndg==
=bbOS
-----END PGP SIGNATURE-----

--BlpOLMawQsRfvJV7dhEZFKCrOeBGQvXAN--
