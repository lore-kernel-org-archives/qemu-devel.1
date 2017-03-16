Received: from eggs.gnu.org ([2001:4830:134:3::10]:38983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coMFc-0005ph-Hu
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 23:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coMFY-00028M-Jj
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 23:38:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1coMFY-000287-AQ
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 23:38:52 -0400
Date: Thu, 16 Mar 2017 11:38:44 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170316033844.GI11074@stefanha-x1.localdomain>
References: <20170315092940.1367-1-stefanha@redhat.com>
	<20170315092940.1367-2-stefanha@redhat.com>
	<5251b9a6-9e00-d11e-ac23-304accfda59a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pe+tqlI1iYzVj1X/"
Content-Disposition: inline
In-Reply-To: <5251b9a6-9e00-d11e-ac23-304accfda59a@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 1/8] block: add bdrv_measure() API
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


--pe+tqlI1iYzVj1X/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2017 at 02:01:03AM +0100, Max Reitz wrote:
> On 15.03.2017 10:29, Stefan Hajnoczi wrote:
> > bdrv_measure() provides a conservative maximum for the size of a new
> > image.  This information is handy if storage needs to be allocated (e.g.
> > a SAN or an LVM volume) ahead of time.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  qapi/block-core.json      | 19 +++++++++++++++++++
> >  include/block/block.h     |  4 ++++
> >  include/block/block_int.h |  2 ++
> >  block.c                   | 33 +++++++++++++++++++++++++++++++++
> >  4 files changed, 58 insertions(+)
> >=20
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 786b39e..673569d 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -463,6 +463,25 @@
> >             '*dirty-bitmaps': ['BlockDirtyInfo'] } }
> > =20
> >  ##
> > +# @BlockMeasureInfo:
> > +#
> > +# Image size calculation information.  This structure describes the si=
ze
> > +# requirements for creating a new image.
> > +#
> > +# @required-bytes: Amount of space required for image creation.  This =
value is
> > +#                  the host file size including sparse file regions.  =
A new 5
> > +#                  GB raw file therefore has a required size of 5 GB, =
not 0
> > +#                  bytes.
>=20
> This should probably note that it's a conservative estimation (and I
> agree that it should be). It's nice to have it in the commit message but
> few people are going to run git blame on the QAPI documentation to find
> out the rest of its story. :-)

Will fix.

> > +#
> > +# @fully-allocated-bytes: Space required once data has been written to=
 all
> > +#                         sectors
> > +#
> > +# Since: 2.10
> > +##
> > +{ 'struct': 'BlockMeasureInfo',
> > +  'data': {'required-bytes': 'int', 'fully-allocated-bytes': 'int'} }
> > +
> > +##
> >  # @query-block:
> >  #
> >  # Get a list of BlockInfo for all virtual block devices.
> > diff --git a/include/block/block.h b/include/block/block.h
> > index 5149260..43c789f 100644
> > --- a/include/block/block.h
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
> >  void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr);
> >  void bdrv_refresh_limits(BlockDriverState *bs, Error **errp);
> >  int bdrv_commit(BlockDriverState *bs);
> > diff --git a/include/block/block_int.h b/include/block/block_int.h
> > index 6c699ac..45a7fbe 100644
> > --- a/include/block/block_int.h
> > +++ b/include/block/block_int.h
> > @@ -201,6 +201,8 @@ struct BlockDriver {
> >      int64_t (*bdrv_getlength)(BlockDriverState *bs);
> >      bool has_variable_length;
> >      int64_t (*bdrv_get_allocated_file_size)(BlockDriverState *bs);
> > +    void (*bdrv_measure)(QemuOpts *opts, BlockDriverState *in_bs,
> > +                         BlockMeasureInfo *info, Error **errp);
> > =20
> >      int coroutine_fn (*bdrv_co_pwritev_compressed)(BlockDriverState *b=
s,
> >          uint64_t offset, uint64_t bytes, QEMUIOVector *qiov);
> > diff --git a/block.c b/block.c
> > index cb57370..532a4d1 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -3260,6 +3260,39 @@ int64_t bdrv_get_allocated_file_size(BlockDriver=
State *bs)
> >      return -ENOTSUP;
> >  }
> > =20
> > +/*
> > + * bdrv_measure:
> > + * @drv: Format driver
> > + * @opts: Creation options
> > + * @in_bs: Existing image containing data for new image (may be NULL)
> > + * @info: Result object
> > + * @errp: Error object
> > + *
> > + * Calculate file size required to create a new image.
> > + *
> > + * If @in_bs is given then space for allocated clusters and zero clust=
ers
> > + * from that image are included in the calculation.  If @opts contains=
 a
> > + * backing file that is shared by @in_bs then backing clusters are omi=
tted
> > + * from the calculation.
>=20
> This seems to run a bit contrary to the documentation of
> BlockMeasureInfo.required-bytes, and I don't fully understand it either.
>=20
> What does "space for zero clusters" mean? Do zero clusters take space?
> Does it depend on the image format? (i.e. would they take space for raw
> but not for qcow2?)

Yes, zero clusters are an image format-specific feature.  A contrived
example:

  in_bs: qcow2 version=3D3 with zero clusters
  Output format: qcow2 version=3D2 (zero clusters not supported!)
  Image creation options: backing file given

We must take care to allocate clusters in the new image for zero
clusters in in_bs.  We cannot simply skip allocating those zero clusters
since there is a backing file and the contents of the backing file
must not be visible where there is a zero cluster.

This is a scenario where zero clusters must be included in the
size calculation.

Perhaps this is an internal detail and it shouldn't be mentioned in the
doc comment?

> And is space for unallocated clusters included or not? Do unallocated
> clusters without a backing image count as zero clusters?

This depends on the output image format.  The raw format requires space
even for unallocated regions.  The qcow2 format is compact and only
requires space for allocated clusters.

> If that space is not included, then it would run contrary to the QAPI
> documentation which states that it should be included.

Sorry, the raw format example in the QAPI doc is misleading without a
qcow2 example.  The point of the raw format example was not to state
that unallocated regions are included for *all* image formats.  It was
just to show how the raw format behaves.

I'll reword things in the next revision.

> Finally, how are you supposed to check whether the backing file in @opts
> is shared by @in_bs?

qemu-img convert -B <base> and -o backing_file=3D<base> simply do not
check.  They rely on good old-fashioned^W^W^Wthe bad practice of
trusting the user to provide valid input.

qemu-img measure will work like this:
1. If the new image has a backing file, use has_zero_init=3Dfalse
   semantics.
2. Do *not* rely on bdrv_get_block_status_above() because it's hard to
   check how the backing chains of in_bs and the new image compare.

This means the result will be conservative - perhaps clusters could have
been shared with the backing file.

> > + *
> > + * If @in_bs is NULL then the calculation includes no allocated cluste=
rs
> > + * unless a preallocation option is given in @opts.
>=20
> But the BlockMeasureInfo.required-bytes documentation states that a new
> 5 GB raw image should still report 5 GB of required space.

Even with 0 allocated clusters, the raw format always reports the
virtual disk size (5 GB).  There is no contradiction here.

Stefan

--pe+tqlI1iYzVj1X/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYygjEAAoJEJykq7OBq3PIb78IAIPYLrm1xbDTsIJABGAzpzXJ
7xgyNb5rvDS1/UF15Hyy0QVHZjPmiZlraLEqqvHjmiMpiGo9WcH+zllT4/ne6OaZ
GD+f9ThBOE1tMO+eJ+DLDKq15eHxwXjqdXX5dA8rwF0CEpasx6bOJeIufsb56mxJ
wPnHfKGu+1YRnVCwUZcyieMl1U7hW3PxFHdlnCNde6xCUSUgKdV4eqLUzTp2eoEK
PeTDgLKdHvab9me9aMG9IR6cElXSNotxTWrf4qAOZC5JY6yVARcR46/c+rzVcIM9
ijQ1YMGgqRESUoR1OAaQxsubcHx6MHyuJZhMHhKk0hLde5EhU6KjMkqKThvR9Zs=
=y1gB
-----END PGP SIGNATURE-----

--pe+tqlI1iYzVj1X/--
