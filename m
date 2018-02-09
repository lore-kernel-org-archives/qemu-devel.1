Received: from eggs.gnu.org ([2001:4830:134:3::10]:36546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ekADa-000168-3X
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:04:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ekADU-0003Uq-EP
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:04:02 -0500
Date: Fri, 9 Feb 2018 16:03:31 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180209150331.GG3998@localhost.localdomain>
References: <20180209113744.11842-1-berto@igalia.com>
	<66ffb17c-6238-db0e-5a50-16d83ee12482@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <66ffb17c-6238-db0e-5a50-16d83ee12482@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: Check the L1 table parameters from
 all internal snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 09.02.2018 um 14:04 hat Max Reitz geschrieben:
> On 2018-02-09 12:37, Alberto Garcia wrote:
> > The code that reads the qcow2 snapshot table takes the offset and size
> > of all snapshots' L1 table without doing any kind of checks.
> >=20
> > Although qcow2_snapshot_load_tmp() does verify that the table size is
> > valid, the table offset is not checked at all. On top of that there
> > are several other code paths that deal with internal snapshots that
> > don't use that function or do any other check.
> >=20
> > This patch verifies that all L1 tables are correctly aligned and the
> > size does not exceed the maximum allowed valued.
> >=20
> > The check from qcow2_snapshot_load_tmp() is removed since it's now
> > useless (opening an image will fail before that).
> >=20
> > Signed-off-by: Alberto Garcia <berto@igalia.com>
> > ---
> >  block/qcow2-snapshot.c     | 14 ++++++++++----
> >  tests/qemu-iotests/080     | 10 +++++++++-
> >  tests/qemu-iotests/080.out | 10 ++++++++--
> >  3 files changed, 27 insertions(+), 7 deletions(-)
>=20
> I don't like completely refusing to open a qcow2 image if one of the
> snapshots is invalid, without giving the user any way of fixing it.
>=20
> With this patch, the final two images created in 080 cannot be opened at
> all (not even with qemu-img info).  Without it, you can, you just can't
> load the snapshots.  (Well, in one case.  In the other, you can even do
> that, but that's a bug, as you correctly claim.)
>=20
> More importantly, though, without this patch, you can delete the
> snapshots.  qemu-img will complain a bit, and you'll have leaks
> afterwards, but that's nothing qemu-img check can't fix.  With this
> patch, you can't, because the image cannot be opened at all so it's
> basically gone for good (unless you get a hex editor).

How about we move the check to bdrv_open() as proposed, but make it
conditional so that it's skipped with BDRV_O_CHECK and then add a way to
fix the situation with qemu-img check -r?

Kevin

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJafbhDAAoJEH8JsnLIjy/WWTEP/iwhF9zt35buW4wIRz+sjUd8
UsWnJwVqgz8bXuIVAVGZi85xtXMwJHxXNZZpwAsnOD3qFncFUWQhQ0EXq2UvctHH
hmyFulBs0tDDV+9yDXt+rmX0Xc96hdph9f55MXWxH69K0E9Pn0FyagGKfkKiCgkQ
6cICe6BLxGO0Avy57kyxkPnUvVCGsHbcNgrla6HNt7m6VDOoKS2gSEjuq7KTjyIN
fw2Wm4Sdok/0DL1Uhqd7gxl0M5uRoXShBC1fcuDEZA9Tunn+JpQE4AGCHzg/eHrl
UnQfXUhii/0A2DXycm3Nw+taoccpbQNdH321YwtKYOq7POSCsgzkhjr3dWTvtk6o
eEYYqW/JlsVu7ihjvmH2KEiwAHpKDPcWVxbN07jW8JITF9nAkfzYwidju6eMBhRN
gM+nFE9CHs3W6XWVjSlhiDEer2S/SIMCcX8k04OMI75C5yYqNvcel1LpPqFA13y+
FGrHs2rLdD/23hxh0Rb+sTKKR4GqHZKyBto7QaRdLeOrpN6wbu/yh4A7XjlaowgP
gC5nsXDKoDDGMPeNbM3WE1lUu7hRMwqkDo43lhvrxovyNZ4PCAxfvqDHcoOEQE0J
HbglXdJt77Lby/O2q1/F7ssihFYJtE0adVtAsO9Nf3iUhsvMjlCjXpRhJojsR5xm
IISZCsc48nFHuMi+Ezum
=UTQG
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
