Received: from eggs.gnu.org ([2001:4830:134:3::10]:57704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBR6Q-0002XY-BN
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:33:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBR62-0000Mf-Id
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:33:22 -0400
References: <20180423223337.82366-1-eblake@redhat.com>
	<20180423223337.82366-5-eblake@redhat.com>
	<3fb4c5dd-bb6f-e965-30f2-cafd0e3a2d2c@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bfc9a420-5b63-9083-e499-a1b0946eeb06@redhat.com>
Date: Wed, 25 Apr 2018 15:31:03 -0500
MIME-Version: 1.0
In-Reply-To: <3fb4c5dd-bb6f-e965-30f2-cafd0e3a2d2c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9lr9lKhnGMXUG23W7klxCtH7R1nyHQwl5"
Subject: Re: [Qemu-devel] [PATCH v5 4/5] qcow2: Don't allow overflow during
 cluster allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9lr9lKhnGMXUG23W7klxCtH7R1nyHQwl5
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, berto@igalia.com
Message-ID: <bfc9a420-5b63-9083-e499-a1b0946eeb06@redhat.com>
Subject: Re: [PATCH v5 4/5] qcow2: Don't allow overflow during cluster
 allocation
References: <20180423223337.82366-1-eblake@redhat.com>
 <20180423223337.82366-5-eblake@redhat.com>
 <3fb4c5dd-bb6f-e965-30f2-cafd0e3a2d2c@redhat.com>
In-Reply-To: <3fb4c5dd-bb6f-e965-30f2-cafd0e3a2d2c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2018 09:44 AM, Max Reitz wrote:

> Here's what you do:
> (1) Create a 513 TB image with cluster_size=3D2M,refcount_bits=3D1
> (2) Take a hex editor and enter 16 refblocks into the reftable
> (3) Fill all of those refblocks with 1s
>=20
> (Funny side note: qemu-img check thinks that image is clean because it
> doesn't check refcounts beyond the image end...)
>=20
> I've attached a compressed test image (unsurprisingly, it compresses
> really well).
>=20
> Before this series:
> $ ./qemu-io -c 'write -c 0 2M' test.qcow2
> qcow2: Marking image as corrupt: Preventing invalid write on metadata
> (overlaps with refcount block); further corruption events will be suppr=
essed
> write failed: Input/output error
>=20
> Aw.
>=20
> After this series:
> $ ./qemu-io -c 'write -c 0 2M' test.qcow2
> write failed: Input/output error

Hmm, I wonder if ENOSPC is a better failure than EIO if the reason we
can't write a compressed cluster is because the image has grown too large=
=2E

>=20
> (Normal writes just work fine.)

I also wonder if there should be a knob to control whether attempts to
write a compressed cluster should fail vs. silently fall back to a
normal write when encountering this too-large situation (that is, a
trade-off between keeping guest writes working no matter what, even if
we lose out on compression savings, vs. learning as soon as possible
when compression is no longer possible).  Then again, other than
carefully-crafted super-sparse files, it's much harder to argue that
you'll hit this in real usage scenarios, so it may not be worth the effor=
t.

>=20
>=20
> Maybe you want to add a test still -- creating the image is rather quic=
k
> (well, you have to write 64 MB of 1s, but other than that).  The only
> thing that takes a bit of time is qemu figuring out where the first fre=
e
> cluster is...  That takes like 15 seconds here.
>=20
> And another issue of course is...
>=20
> $ ls -lhs test.qcow2
> 42M -rw-r--r--. 1 maxx maxx 513T 25. Apr 16:42 test.qcow2
>=20
> Yeah, that.  Depends on the host file system, of course, whether that i=
s
> a real issue. O:-)

Well, I'm writing the iotest now, and thus will post a v6 of this series.=


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--9lr9lKhnGMXUG23W7klxCtH7R1nyHQwl5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrg5YcACgkQp6FrSiUn
Q2oFXwgAkPnDLbu4V9qj1F/awb3AJzQtJkhhRx8MrKA/dDaX+D7l7hWHSld0q2yc
+hHwa6PeGwoFPuQY34GsgfAoK//DvSJhzikzsWBDjz2xmCPjbFl7I3kwRZ1dv6I5
EmLp2U+2Dl6dR2RrPf/vQYBabj8wCjDfZhvJsEMLpo+Ypl3pBGctuM5mf4GsGz+2
lbfYZEji9AcFrI5AWStUHz620YoJTXtkKO2JLMAxjJjw5zvD7iel7zKb5FkchSkk
P7q/HXenKLIEcdP+uH7vffFmDSAiLknp6yNCW0bmD0EJ9Op7NaTXIpC8o6bGYP7d
B1pWKf+ifnmopyR+YOXiODSwtQF/0A==
=AmVB
-----END PGP SIGNATURE-----

--9lr9lKhnGMXUG23W7klxCtH7R1nyHQwl5--
