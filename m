Received: from eggs.gnu.org ([2001:4830:134:3::10]:39554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coMHp-0006uM-KY
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 23:41:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coMHo-0002is-Pt
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 23:41:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1coMHo-0002iY-H5
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 23:41:12 -0400
Date: Thu, 16 Mar 2017 11:41:07 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170316034107.GK11074@stefanha-x1.localdomain>
References: <20170315092940.1367-1-stefanha@redhat.com>
	<20170315092940.1367-6-stefanha@redhat.com>
	<4db9211c-4136-335c-8d97-c0ec13da2aa3@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zPXeIxDajdrcF2en"
Content-Disposition: inline
In-Reply-To: <4db9211c-4136-335c-8d97-c0ec13da2aa3@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 5/8] qcow2: add bdrv_measure() support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, Alberto Garcia <berto@igalia.com>


--zPXeIxDajdrcF2en
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2017 at 02:57:13AM +0100, Max Reitz wrote:
> On 15.03.2017 10:29, Stefan Hajnoczi wrote:
> > Use qcow2_calc_prealloc_size() to get the required file size.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > TODO:
> >  * Query block status and only count allocated clusters if in_bs !=3D N=
ULL
> >  * Exclude backing file clusters if in_bs !=3D NULL and -o backing_file=
=3D
> >    is given
> > ---
> >  block/qcow2.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++
> >  1 file changed, 53 insertions(+)
> >=20
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index 19be468..a4caf97 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> > @@ -2940,6 +2940,58 @@ static coroutine_fn int qcow2_co_flush_to_os(Blo=
ckDriverState *bs)
> >      return 0;
> >  }
> > =20
> > +static void qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
> > +                          BlockMeasureInfo *info, Error **errp)
> > +{
> > +    Error *local_err =3D NULL;
> > +    uint64_t allocated_bytes =3D 0;
> > +    uint64_t prealloc_size;
> > +    uint64_t size;
> > +    uint64_t refcount_bits;
> > +    size_t cluster_size;
> > +    int version;
> > +
> > +    size =3D ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
> > +                    BDRV_SECTOR_SIZE);
> > +
> > +    cluster_size =3D qcow2_opt_get_cluster_size_del(opts, &local_err);
> > +    if (local_err) {
> > +        goto err;
> > +    }
> > +
> > +    version =3D qcow2_opt_get_version_del(opts, &local_err);
> > +    if (local_err) {
> > +        goto err;
> > +    }
> > +
> > +    refcount_bits =3D qcow2_opt_get_refcount_bits_del(opts, version, &=
local_err);
> > +    if (local_err) {
> > +        goto err;
> > +    }
> > +
> > +    if (in_bs) {
> > +        int64_t ssize =3D bdrv_getlength(in_bs);
> > +        if (ssize < 0) {
> > +            error_setg_errno(errp, -ssize, "Unable to get image size");
> > +            return;
> > +        }
> > +
> > +        size =3D ssize;
> > +
> > +        /* TODO How many clusters are allocated modulo backing file in=
 opts? */
> > +    }
> > +
> > +    prealloc_size =3D qcow2_calc_prealloc_size(size, cluster_size,
> > +                                             ctz32(refcount_bits));
> > +    info->required_bytes =3D prealloc_size - (align_offset(size, clust=
er_size) -
> > +                                            allocated_bytes);
>=20
> But what if @opts contains a preallocation option?

Will implement in the next revision.

Thanks,
Stefan

--zPXeIxDajdrcF2en
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYyglTAAoJEJykq7OBq3PI5N8IALjLWz8lV1KZbOJRYuEz2Xdb
TJfpJLyZPyiXWoO2bHGDD4Il93Vi1fmgVea1+a3FPesZ585Odqcvyp/f4POjzWu6
OSx1JQY9fctEztRXSVfaSUUOKrNwm6/OwuPu1yB+Q9Pn4h+FN+aOZjOgcVVXgoUz
8zvDIYL5pMXUGWTYoRqQLKeVWAnMeSNdEjyRyWCG5h9BlvwEZDQF3xLXzqTIp418
WGEgySxoNs3TgAvncWoNdjx9YPUBkbAa3kuKf9yvHehfpoWa3Ne5EJWXARo/vWz9
k7P958cO9aKgie4bLb3LnsBEPj9m3vff1mBIZmVVENubgCfeiatIJlEx+jCXS+w=
=X1vC
-----END PGP SIGNATURE-----

--zPXeIxDajdrcF2en--
