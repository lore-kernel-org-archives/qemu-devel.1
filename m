Received: from eggs.gnu.org ([2001:4830:134:3::10]:57054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cfneo-00040f-7B
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cfnen-0001GU-AE
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:05:34 -0500
Date: Mon, 20 Feb 2017 14:05:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170220130525.GE4814@noname.redhat.com>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-21-git-send-email-kwolf@redhat.com>
	<6f790f11-1427-7f23-83d1-d3212fb74ddc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
In-Reply-To: <6f790f11-1427-7f23-83d1-d3212fb74ddc@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 20/41] hw/block: Introduce share-rw
 qdev property
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


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 20.02.2017 um 13:28 hat Max Reitz geschrieben:
> On 13.02.2017 18:22, Kevin Wolf wrote:
> > By default, don't allow another writer for block devices that are
> > attached to a guest device. For the cases where this setup is intended
> > (e.g. using a cluster filesystem on the disk), the new option can be
> > used to allow it.
> >=20
> > This change affects only devices using DEFINE_BLOCK_PROPERTIES().
> > Devices directly using DEFINE_PROP_DRIVE() still accept writers
> > unconditionally.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  hw/block/block.c           | 14 ++++++------
> >  include/hw/block/block.h   |  4 +++-
> >  tests/qemu-iotests/172.out | 53 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 64 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/hw/block/block.c b/hw/block/block.c
> > index c3d3901..3c218eb 100644
> > --- a/hw/block/block.c
> > +++ b/hw/block/block.c
> > @@ -56,7 +56,7 @@ void blkconf_apply_backend_options(BlockConf *conf, b=
ool readonly,
> >  {
> >      BlockBackend *blk =3D conf->blk;
> >      BlockdevOnError rerror, werror;
> > -    uint64_t perm;
> > +    uint64_t perm, shared_perm;
> >      bool wce;
> >      int ret;
> > =20
> > @@ -65,11 +65,13 @@ void blkconf_apply_backend_options(BlockConf *conf,=
 bool readonly,
> >          perm |=3D BLK_PERM_WRITE;
> >      }
> > =20
> > -    /* TODO Remove BLK_PERM_WRITE unless explicitly configured so */
> > -    ret =3D blk_set_perm(blk, perm,
> > -                       BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHA=
NGED |
> > -                       BLK_PERM_GRAPH_MOD | BLK_PERM_RESIZE | BLK_PERM=
_WRITE,
> > -                       errp);
> > +    shared_perm =3D BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGE=
D |
> > +                  BLK_PERM_GRAPH_MOD | BLK_PERM_RESIZE;
>=20
> I'm not so sure BLK_PERM_RESIZE belongs here.

Where does it belong in your opinion?

An option that I considered was adding BLK_PERM_RESIZE in
blk_set_dev_ops() if op.resize_cb !=3D NULL, but it felt a bit too
implicit to me.

Or I guess we can just add another bool parameter?

Kevin

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYqumVAAoJEH8JsnLIjy/WO0UP/R9+9OQ9pxLts/Y5pvaWx1H7
MoUSpusnVFBsiubL4ao/MN+Fm+NkGQlwrwFC4UUliVRGw6zxemYLVKs756MqHYtr
zF4KC0wfufn1t37D7JTsUMp19gZosExKtscIepHy2q4ae0Us/rqzdoeburPbOLpp
hyQNn5HC9IL6+ioXmu0+/TmtzybSH15h+gzT7rDOMvMziC3N0c0kJEh/1r8kRVCv
yQ3tNHGJZvrhyisuPr7w4cbYO5NL7av01kPGQat9Z6x8D+AN8vy8opFX8vgcAoEv
/JB8ZL6RHLW+vkCfTX5dpaUJG3EMkp4kTcpStVxz6A/gO8d+hFA7qNwURnlW+G/A
iJ3yO+NUbb6cqJ6Oe2210WPtKkAaxly+G84XVR96cND5QsQhRcjwdLtnLW1ofaMN
JvvWspUMaDdBhmHKtD4kcV/KxmCmwc1N3k+dCY9tiz9ilmadLj/MPaGeYadO43l5
hxNkFs4FjhGzIZ/lmmd66Uz+7+OIpYlmLZrvRRIm+i3tI/9tgWSEMMWzwIcJV5L3
rOAdVurXE0TFPYRXD9jv20EjVZ3OyKxb7/MmwrsuxcWS4OOh038LeKGqrRsELbWN
BkebXC15LB/b4xsbLTqfdrykSbsjP+6fpVcY+Pi0/Zcnb7c+0DM1ug2GTo+2u65U
18Sx8TTGsjjTzhcW6Jjl
=uk06
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
