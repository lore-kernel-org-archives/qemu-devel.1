Received: from eggs.gnu.org ([209.51.188.92]:55260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hG4Iy-0004Jw-Uq
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hG4Iy-0000jN-2s
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:18:00 -0400
References: <20190415155452.5115-1-kwolf@redhat.com>
	<20190415155452.5115-3-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cd898659-76d9-5041-d560-3dd1c7e03011@redhat.com>
Date: Mon, 15 Apr 2019 11:17:50 -0500
MIME-Version: 1.0
In-Reply-To: <20190415155452.5115-3-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ouv4dC9zsheUuGwvMZWCh7jCEkxXhRrhY"
Subject: Re: [Qemu-devel] [PATCH for-4.0? 2/4] qcow2: Fix preallocation
 bdrv_pwrite to wrong file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ouv4dC9zsheUuGwvMZWCh7jCEkxXhRrhY
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org
Message-ID: <cd898659-76d9-5041-d560-3dd1c7e03011@redhat.com>
Subject: Re: [PATCH for-4.0? 2/4] qcow2: Fix preallocation bdrv_pwrite to
 wrong file
References: <20190415155452.5115-1-kwolf@redhat.com>
 <20190415155452.5115-3-kwolf@redhat.com>
In-Reply-To: <20190415155452.5115-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/15/19 10:54 AM, Kevin Wolf wrote:
> With an external data file, preallocate_co() must write the final byte
> to the external data file, not to the qcow2 image file.
>=20
> This is harmless for preallocation of newly created images (only the
> qcow2 file size is increased to the virtual disk size while it should b=
e
> much smaller), but with preallocated resize, it could in theory cause
> visible corruption if the metadata of the image is larger than the data=

> (e.g. lots of bitmaps).

Can we come up with such an image - maybe one with 512-byte cluster
sizing and only 1k in guest-visible length?  Since each bitmap is
cluster-aligned, it seems like you'd only need a couple of bitmaps to
easily reach that point.

We're awfully late for 4.0, but as we already have -rc4 coming due, and
as this is a data-corruption bug in a new feature, I can buy the
argument of getting this one into 4.0, particularly if you can design
the iotest along the lines of my ideas to prove that yes, indeed, we are
accidentally wiping out qcow2 metadata for visible image corruption.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Ouv4dC9zsheUuGwvMZWCh7jCEkxXhRrhY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly0rq4ACgkQp6FrSiUn
Q2qJbAgArd/B95BVkKMtFcqLWmoaNCjxOMugr52M+grS0tpotJ9ctb9Ag3v0cAMu
GHYqvwM5Z6jpPIKg6fSHBpb/hFB52S27DfosKuivIwGvnP43CiClNnN6XaN5Q86Y
qkpVrWoUURpjXMxJyuZZ5wVie/YsiCYLwqvpNCPMZ6h+EoMZP7oeCuhMUWV3m/tX
abjKdzG+5gJUPTxxPtEoIff97d2tZq/GRnBYyPFVWJpxVnQ6UUhk7tFCdMcfff6n
MT9Q2aKizpMuFd/uD18vb8E9l3EGVnjkttA2NgefVBDPVtDknFUlqIgIA8R9Gs2H
sDdSKdawQOFj6GTV1JR0uHsWLqLlTQ==
=PKow
-----END PGP SIGNATURE-----

--Ouv4dC9zsheUuGwvMZWCh7jCEkxXhRrhY--
