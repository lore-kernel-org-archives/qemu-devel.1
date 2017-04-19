Received: from eggs.gnu.org ([2001:4830:134:3::10]:37685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d0pe5-0006Qp-Me
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 09:27:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d0pe2-00073y-F0
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 09:27:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1d0pe2-00073n-54
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 09:27:42 -0400
Date: Wed, 19 Apr 2017 14:27:37 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170419132737.GF3343@stefanha-x1.localdomain>
References: <20170418135726.28022-1-stefanha@redhat.com>
	<20170418135726.28022-2-stefanha@redhat.com>
	<09309ca7-dea8-db26-5544-402964224ee1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p8PhoBjPxaQXD0vg"
Content-Disposition: inline
In-Reply-To: <09309ca7-dea8-db26-5544-402964224ee1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/9] block: add bdrv_measure() API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>


--p8PhoBjPxaQXD0vg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2017 at 10:08:20AM -0500, Eric Blake wrote:
> On 04/18/2017 08:57 AM, Stefan Hajnoczi wrote:
> > bdrv_measure() provides a conservative maximum for the size of a new
> > image.  This information is handy if storage needs to be allocated (e.g.
> > a SAN or an LVM volume) ahead of time.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Alberto Garcia <berto@igalia.com>
> > ---
> >  qapi/block-core.json      | 25 +++++++++++++++++++++++++
> >  include/block/block.h     |  4 ++++
> >  include/block/block_int.h |  2 ++
> >  block.c                   | 35 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 66 insertions(+)
> >=20
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 033457c..1ea5536 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -463,6 +463,31 @@
> >             '*dirty-bitmaps': ['BlockDirtyInfo'] } }
> > =20
> >  ##
> > +# @BlockMeasureInfo:
> > +#
> > +# Image size calculation information.  This structure describes the si=
ze
> > +# requirements for creating a new image file.
> > +#
> > +# The size requirements depend on the new image file format.  File siz=
e always
> > +# equals virtual disk size for the 'raw' format.  Compact formats such=
 as
> > +# 'qcow2' represent unallocated and zero regions efficiently so file s=
ize may
> > +# be smaller than virtual disk size.
>=20
> I guess that implies that holes due to a file system that supports them
> is NOT considered a compact format under qemu's control.  Or maybe
> another way of wording it is that we are reporting the size of all guest
> contents that are associated with a host offset by this layer (all
> sectors of a raw format have a host offset, even if that offset falls in
> the hole of a sparse file; but sectors of qcow2 do not necessarily have
> a host offset if they are unallocated or zero).
>=20
> But I'm not sure my alternative wording adds anything, so I'm also fine
> if you don't feel like tweaking it any further.

Thanks for the feedback.  I'll clarify what "size" means.

> > +#
> > +# The values are upper bounds that are guaranteed to fit the new image=
 file.
> > +# Subsequent modification, such as internal snapshot or bitmap creatio=
n, may
> > +# require additional space and is not covered here.
> > +#
> > +# @required: Size required for a new image file, in bytes.
> > +#
> > +# @fully-allocated: Image file size, in bytes, once data has been writ=
ten
> > +#                   to all sectors.
> > +#
> > +# Since: 2.10
> > +##
> > +{ 'struct': 'BlockMeasureInfo',
> > +  'data': {'required': 'int', 'fully-allocated': 'int'} }
> > +
>=20
> > +++ b/include/block/block.h
> > @@ -298,6 +298,10 @@ int bdrv_truncate(BdrvChild *child, int64_t offset=
);
> >  int64_t bdrv_nb_sectors(BlockDriverState *bs);
> >  int64_t bdrv_getlength(BlockDriverState *bs);
> >  int64_t bdrv_get_allocated_file_size(BlockDriverState *bs);
> > +void bdrv_measure(BlockDriver *drv, QemuOpts *opts,
> > +                  BlockDriverState *in_bs,
> > +                  BlockMeasureInfo *info,
> > +                  Error **errp);
>=20
> Would it be any better to have BlockMeasureInfo* be the return value (or
> NULL on error), instead of an output-only parameter?  Of course, that
> changes the allocation scheme (as written, a caller can stack-allocate
> or malloc the pointer it passes in, but with a return value of a
> pointer, it will always be malloc'd); on the other hand, the allocation
> scheme may matter down the road if the struct ever gains a non-scalar
> member where stack-allocation becomes harder to clean up than just
> calling qapi_free_BlockMeasureInfo().

Yes, that makes the function more self-explanatory.

> > +++ b/include/block/block_int.h
> > @@ -201,6 +201,8 @@ struct BlockDriver {
> >      int64_t (*bdrv_getlength)(BlockDriverState *bs);
> >      bool has_variable_length;
> >      int64_t (*bdrv_get_allocated_file_size)(BlockDriverState *bs);
> > +    void (*bdrv_measure)(QemuOpts *opts, BlockDriverState *in_bs,
> > +                         BlockMeasureInfo *info, Error **errp);
>=20
> I know we haven't done a good job in the past, but should we start
> trying to do better at documenting callback constraints of new things
> added in this header?

=2Ebdrv_measure() is a 1:1 pass-through of the public bdrv_measure()
function.  All the public function does is to dereference
drv->bdrv_measure.

I think that's why many of the other callbacks also have no
documentation - they inherit semantics from the public function.  We
don't need to duplicate the doc comments.

--p8PhoBjPxaQXD0vg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY92XJAAoJEJykq7OBq3PISksIAJn82PFkT6SqDu+E/LOxzL1P
fKkMV8fMdeljlSql3ynX2ahzIm+QSmoKZJ+emK9FIT4/48uSTR0Q5dvbiR9OiyAK
Lq9hn4Jw/biQucMsBJT/3FaGekV+1dUpsuODEkQf+YrZAbrqk1G4GExbdt+FgMVg
jgGC7Ka0AOgmN+epED+Cjuy2k+9mnvc8xKf03ahdj4999wV+iFHl4adlIDtbLy4u
+ENzRHDfltlfv/upUcx2tBQWGqCMoDK9RlcCki9VZpR8zWz0JUomo7s6pSCeQo1G
EuP+JRsL3CVTpmBP0TpGnRTIQ5Q2I2x4O+dtgdpW7kxlXstJRX3FdM9YOtAIVdo=
=IUog
-----END PGP SIGNATURE-----

--p8PhoBjPxaQXD0vg--
