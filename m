Received: from eggs.gnu.org ([2001:4830:134:3::10]:45505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dLBko-0007KF-44
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dLBkn-0004RI-2e
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:06:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dLBkm-0004R1-PJ
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:06:49 -0400
Date: Wed, 14 Jun 2017 13:25:28 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170614122528.GC11398@stefanha-x1.localdomain>
References: <20170613133329.23653-1-stefanha@redhat.com>
	<20170613133329.23653-7-stefanha@redhat.com>
	<w511sqoncym.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Content-Disposition: inline
In-Reply-To: <w511sqoncym.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH v7 6/9] qcow2: add bdrv_measure() support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Nir Soffer <nsoffer@redhat.com>, John Snow <jsnow@redhat.com>, mreitz@redhat.com


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2017 at 05:07:13PM +0200, Alberto Garcia wrote:
> On Tue 13 Jun 2017 03:33:26 PM CEST, Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
> > Use qcow2_calc_prealloc_size() to get the required file size.
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Alberto Garcia <berto@igalia.com>
>=20
> You kept my R-b here but one of the changes was in this patch:

Sorry, I forgot to remove it when making the change.

> > +    info =3D g_new(BlockMeasureInfo, 1);
> > +    info->fully_allocated =3D
> > +        qcow2_calc_prealloc_size(virtual_size, cluster_size,
> > +                                 ctz32(refcount_bits));
> > +    if (DIV_ROUND_UP(info->fully_allocated, cluster_size) > INT_MAX) {
> > +        g_free(info);
> > +        error_setg(&local_err, "The image size is too large "
> > +                               "(try using a larger cluster size)");
> > +        goto err;
> > +    }
>=20
> This has the opposite problem than the previous version: valid image
> sizes are now rejected by the 'measure' command.
>=20
> $ qemu-img create -f qcow2 img.qcow2 1P
> Formatting 'img.qcow2', fmt=3Dqcow2 size=3D1125899906842624 encryption=3D=
off cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>=20
> $ build/qemu-img measure -O qcow2 --size 1P
> qemu-img: The image size is too large (try using a larger cluster size)

Hmm...if host file size (not virtual disk size) is 1P then qemu-img
check fails:

int qcow2_check_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                          BdrvCheckMode fix)
{
    int64_t size, highest_cluster, nb_clusters;
    ...

    size =3D bdrv_getlength(bs->file->bs);
    if (size < 0) {
        res->check_errors++;
        return size;
    }

    nb_clusters =3D size_to_clusters(s, size);
    if (nb_clusters > INT_MAX) {
        res->check_errors++;
        return -EFBIG;
    }

This is also where I got the limit from.  It was introduced in:

commit 0abe740f1de899737242bcba1fb4a9857f7a3087
Author: Kevin Wolf <kwolf@redhat.com>
Date:   Wed Mar 26 13:05:52 2014 +0100

    qcow2: Protect against some integer overflows in bdrv_check

At that point the code used ints so the overflow check was necessary.
Now the code uses 64-bit types so INT_MAX is obsolete.

I will send a separate patch to fix qemu-img check.

> The actual limit is:
>=20
> #define QCOW_MAX_L1_SIZE 0x2000000
>=20
> That's 4194304 entries, each one can address cluster_size^2 / 8 bytes
>=20
> So using that formula, here is the maximum virtual size depending on the
> cluster size:
>=20
> |--------------+------------------|
> | Cluster size | Max virtual size |
> |--------------+------------------|
> | 512 bytes    | 128 GB           |
> | 1 KB         | 512 GB           |
> | 2 KB         | 2 TB             |
> | 4 KB         | 8 TB             |
> | 8 KB         | 32 TB            |
> | 16 KB        | 128 TB           |
> | 32 KB        | 512 TB           |
> | 64 KB        | 2 PB             |
> | 128 KB       | 8 PB             |
> | 256 KB       | 32 PB            |
> | 512 KB       | 128 PB           |
> | 1 MB         | 512 PB           |
> | 2 MB         | 2 EB             |
> |--------------+------------------|
>=20
> I just created a 2 EB image and it works fine, Linux can detect it
> without problems, I can create a file system, etc.
>=20
> If you specify a larger size, qcow2_grow_l1_table() fails with -EFIB.

Thanks, will fix!

Stefan

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZQSs4AAoJEJykq7OBq3PI3nMIAJgx1A2trQXuaZrkhbmkjdPV
nlyMFWdyFd/xwFNDlS4RyYnzJKAIItSydwWTN8S7yfMCKNNP7GxKg2m9aQQMeGQZ
/LSgd3v+MqSkP+fNCxKBoSH9D+DYld9fvwwglIMl2A340V7sAPMIc/AMnPk+NWEV
/mN3E983+qyHT1juiB9YwicVQbJZ5OFoMVOucKcNOrNBCnS+1ADpk39+uUahlCTy
jDFlBfWiODOYwUa2cg9qM7K+NidgAYZ1Istb4faAskkHnMMBzCCMB1TblZ5MBLaK
st2Say2jziKqXvhwu9b4J7TzjbbcT3OzAt4oBF6+8du9784aKc4qiJ2HU1QaKKI=
=8ZDE
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--
