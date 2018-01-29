Received: from eggs.gnu.org ([2001:4830:134:3::10]:57702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egDtP-0004bA-Nc
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egDtO-0005rQ-I3
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:10:55 -0500
Date: Mon, 29 Jan 2018 19:10:46 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180129181046.GQ6141@localhost.localdomain>
References: <20180111195225.4226-1-kwolf@redhat.com>
	<20180111195225.4226-5-kwolf@redhat.com>
	<99b05d90-756d-be4c-f6b5-240a26176d57@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aZoGpuMECXJckB41"
Content-Disposition: inline
In-Reply-To: <99b05d90-756d-be4c-f6b5-240a26176d57@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 04/10] qcow2: Pass
 BlockdevCreateOptions to qcow2_create2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org


--aZoGpuMECXJckB41
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 29.01.2018 um 18:12 hat Max Reitz geschrieben:
> On 2018-01-11 20:52, Kevin Wolf wrote:
> > All of the simple options are now passed to qcow2_create2() in a
> > BlockdevCreateOptions object. Still missing: node-name and the
> > encryption options.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/qcow2.c | 186 ++++++++++++++++++++++++++++++++++++++++++++++----=
--------
> >  1 file changed, 148 insertions(+), 38 deletions(-)
> >=20
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index b02bc39a01..09e567324d 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
>=20
> [...]
>=20
> > @@ -2690,12 +2697,11 @@ static uint64_t qcow2_opt_get_refcount_bits_del=
(QemuOpts *opts, int version,
> >      return refcount_bits;
> >  }
> > =20
> > -static int qcow2_create2(BlockDriverState *bs, int64_t total_size,
> > -                         const char *backing_file, const char *backing=
_format,
> > -                         int flags, size_t cluster_size, PreallocMode =
prealloc,
> > -                         QemuOpts *opts, int version, int refcount_ord=
er,
> > -                         const char *encryptfmt, Error **errp)
> > +static int qcow2_create2(BlockDriverState *bs,
> > +                         BlockdevCreateOptions *create_options,
>=20
> I'd personally really prefer this to be const...
>=20
> > +                         QemuOpts *opts, const char *encryptfmt, Error=
 **errp)
> >  {
> > +    BlockdevCreateOptionsQcow2 *qcow2_opts;
> >      QDict *options;
> > =20
> >      /*
> > @@ -2712,10 +2718,88 @@ static int qcow2_create2(BlockDriverState *bs, =
int64_t total_size,
>=20
> [...]
>=20
> > +
> > +    if (!qcow2_opts->has_preallocation) {
> > +        qcow2_opts->preallocation =3D PREALLOC_MODE_OFF;
> > +    }
> > +    if (qcow2_opts->backing_file &&
> > +        qcow2_opts->preallocation !=3D PREALLOC_MODE_OFF)
> > +    {
> > +        error_setg(errp, "Backing file and preallocation cannot be use=
d at "
> > +                   "the same time");
> > +        return -EINVAL;
> > +    }
> > +
> > +    if (!qcow2_opts->has_lazy_refcounts) {
> > +        qcow2_opts->lazy_refcounts =3D false;
>=20
> ...because modifying some ideally QMP-provided objects just looks wrong.

Isn't this pretty standard, though? Most commands don't use boxed
options, so there they only modify stack variables, but if you look at
boxed ones like do_blockdev_backup() or qmp_drive_mirror(), they do the
same.

> [...]
>=20
> > @@ -2804,18 +2888,26 @@ static int qcow2_create2(BlockDriverState *bs, =
int64_t total_size,
>=20
> [...]
>=20
> >      /* Want a backing file? There you go.*/
> > -    if (backing_file) {
> > -        ret =3D bdrv_change_backing_file(blk_bs(blk), backing_file, ba=
cking_format);
> > +    if (qcow2_opts->has_backing_file) {
> > +        const char *backing_format =3D NULL;
> > +
> > +        if (qcow2_opts->has_backing_fmt) {
> > +            backing_format =3D BlockdevDriver_str(qcow2_opts->backing_=
fmt);
> > +        }
>=20
> has_backing_fmt && !has_backing_file should probably be an error.

Yes.

Kevin

--aZoGpuMECXJckB41
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJab2OmAAoJEH8JsnLIjy/WURoP/2JSBnQBAVc9xQcSFnJY6rhN
eDmtrEz448HTjAazWGrfAQZpesswJOu45TjxqPlZUAGxOvmT+fRChsfXY1QyNDAw
v1TBgzjmUWss43O9pJ5vgSoKaifS/KGUQpyxkzmc0SV9SUlcYyQKWheWLlW3ZxMz
I3xqu2DY4oCXTlKrrljYc9iS6atizbX0EBURTH9c10Kb+6erHRxvuB+IUGXE3xxq
4haHMq0uvNPlv0QpYJwKKGejLtZFKnzsvdOQwdSwRsMZ4RwS6wONMLUlFBCiIPs1
JcIW8wu7NyiNnpwtb7LJWDfMrarZRfcryoqO0/rvsnoMSlW/uwkDCrTk8913NaO6
sBc11R2pPQR84avFwwMURzJs9lqds0XwAjkHHlBFzz086bCpTxhC3cSe9MwksU1e
MMAmOa1RUp12JzMn1j4BbW6Yp3E25qtb0dfK6bHAF6uTZI+QgRAbUo9MRzGPIwz1
V0SY0CqinDxoWYZK83U/n3xSczHvrD6yGJw1SN+cVyeUXwy22NKPILtE6C3TS2yO
9lh4PO3x2xzc5SchbDPMLFZ0zhDrWZGRhheN07Uup2w5N4iMB9gtvCN/VkYQiKo7
kqm/ANT5LpQKLf+mjqVzg38/MT4UZZp5DSWxBHRrVoaecNUB/8VhGbjpFuA/eFoj
/DRZZUb8LYPlucZxyJcv
=LSIX
-----END PGP SIGNATURE-----

--aZoGpuMECXJckB41--
