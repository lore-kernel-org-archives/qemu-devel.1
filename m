Received: from eggs.gnu.org ([2001:4830:134:3::10]:56064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cfncF-0002nn-JS
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cfncB-00005d-IK
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:02:55 -0500
Date: Mon, 20 Feb 2017 14:02:43 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170220130243.GD4814@noname.redhat.com>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-20-git-send-email-kwolf@redhat.com>
	<c8592787-34e5-1ab3-7e33-596f97520cd3@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <c8592787-34e5-1ab3-7e33-596f97520cd3@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 19/41] hw/block: Request permissions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 20.02.2017 um 13:25 hat Max Reitz geschrieben:
> On 13.02.2017 18:22, Kevin Wolf wrote:
> > This makes all device emulations with a qdev drive property request
> > permissions on their BlockBackend. We don't block anything yet.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  hw/block/block.c                 | 19 ++++++++++++++++++-
> >  hw/block/fdc.c                   | 25 +++++++++++++++++++++++--
> >  hw/block/m25p80.c                |  8 ++++++++
> >  hw/block/nand.c                  |  7 +++++++
> >  hw/block/nvme.c                  |  8 +++++++-
> >  hw/block/onenand.c               |  7 +++++++
> >  hw/block/pflash_cfi01.c          | 18 ++++++++++++------
> >  hw/block/pflash_cfi02.c          | 19 +++++++++++++------
> >  hw/block/virtio-blk.c            |  8 +++++++-
> >  hw/core/qdev-properties-system.c |  1 -
> >  hw/ide/qdev.c                    |  7 +++++--
> >  hw/nvram/spapr_nvram.c           |  8 ++++++++
> >  hw/scsi/scsi-disk.c              |  8 ++++++--
>=20
> Since I have no idea how scsi-generic and all of that works, just an
> innocent question: Do we need to set permissions there, too?

I couldn't see any use for it. With an SG BDS, you can't really do
anything anyway except directly attach it to scsi-generic. And the only
thing that scsi-generic does is invoking ioctls, which the block layer
doesn't understand but just pass though.

So I didn't feel that op blockers could provide anything here.

> >  hw/sd/sd.c                       |  6 ++++++
> >  hw/usb/dev-storage.c             |  6 +++++-
> >  include/hw/block/block.h         |  3 ++-
> >  tests/qemu-iotests/051.pc.out    |  6 +++---
> >  17 files changed, 137 insertions(+), 27 deletions(-)
>=20
> [...]
>=20
> > diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> > index 2d6eb46..190573c 100644
> > --- a/hw/block/m25p80.c
> > +++ b/hw/block/m25p80.c
> > @@ -1215,6 +1215,7 @@ static void m25p80_realize(SSISlave *ss, Error **=
errp)
> >  {
> >      Flash *s =3D M25P80(ss);
> >      M25P80Class *mc =3D M25P80_GET_CLASS(s);
> > +    int ret;
> > =20
> >      s->pi =3D mc->pi;
> > =20
> > @@ -1222,6 +1223,13 @@ static void m25p80_realize(SSISlave *ss, Error *=
*errp)
> >      s->dirty_page =3D -1;
> > =20
> >      if (s->blk) {
> > +        uint64_t perm =3D BLK_PERM_CONSISTENT_READ |
> > +                        (blk_is_read_only(s->blk) ? 0 : BLK_PERM_WRITE=
);
> > +        ret =3D blk_set_perm(s->blk, perm, BLK_PERM_ALL, errp);
>=20
> Not sure whether it should be changed in this patch, but I don't know
> whether BLK_PERM_ALL is right here; and from a quick glance it doesn't
> look like any of the following patches change it.
>=20
> (Same for all of the block device emulation code that invokes
> blk_set_perm() directly.)

Yeah, I'm not completely sure about the real requirements here either.
What I do know is that currently nothing is blocked (so doing the same
in the future won't make things worse at least), and that I don't want
to break exotic devices that I can't really test. So for these devices I
tended to be more permissive in case of doubt.

Kevin

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYqujzAAoJEH8JsnLIjy/Wu7sP/3RUDUB+OnI5z4ab8tvLFTrY
jfwyJcx4CgZXUPFaZLHgcmF2vB655NlJ1f9xYxVm63XUk8c3W0LuGfy56mhsNYBq
iJoISOmU3zvNh5ZOHWgIRDVjobnyKYUiaTqMRDt0MlBlxW9bF2jihHAWwWpLV7+i
mzGYmr30pnaZglqLg60JppQmNY8pDnJlBSHEkgI6pSozdC/yNV7Yh0gW1h0h7cIq
VgQCAtQaK880xdCbv6wK1s2YQVP4pJOBdof1bn7QCBvBHKstSnPMuzkuMp6q4oLj
D8H8QdOIhniQQylPZawVBNeFmX7hatIWkQoQg/NpgOVntYJtcCczc0JpajtgTtgz
1oGXYZUAznw0o7UEjOeEqfLXPQXJHT5olUdnq2yWOV86M/F9wHGhbMie+5wfCuG4
cmIyXBgzG9YPeblumeeF/ysZdDCJPzPp06mNXk+VpftRnPIJIQRlMo/hKIasqn1r
znTFHbj4MtSnPbBLuMuoa3/3RVrF1KY4KiXJak+JXw7DKqxKf6P4mYYu3Cta3Uju
8UciIoT6B83zpEIrczDI6UQBF7Rhyp69hD+MDnjG8IPZ0lMmYx8pDjwPUX+vgBnK
uEVxNgOYRKXr2i+wf2WleE7PuFQrSsPhJkWqqE7BpjcDYX+bbdhP8fpnNyJvVl08
VmhybSsulIv0UJWSlY7e
=XiJb
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
