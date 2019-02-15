Received: from eggs.gnu.org ([209.51.188.92]:59061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gugcg-00062J-GE
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:46:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gugce-0005vf-BL
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:45:58 -0500
References: <20190213225311.17876-1-mreitz@redhat.com>
	<20190213225311.17876-4-mreitz@redhat.com>
	<895b530e-a81a-f8de-3be5-12e30c6190b7@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <760e0829-27cb-e732-fa0b-4a9d065002b0@redhat.com>
Date: Fri, 15 Feb 2019 17:45:38 +0100
MIME-Version: 1.0
In-Reply-To: <895b530e-a81a-f8de-3be5-12e30c6190b7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jkmUgn18nipwlC6adETuy3oRKFTCbMuRn"
Subject: Re: [Qemu-devel] [PATCH v3 03/12] block: Filtered children access
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jkmUgn18nipwlC6adETuy3oRKFTCbMuRn
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <760e0829-27cb-e732-fa0b-4a9d065002b0@redhat.com>
Subject: Re: [PATCH v3 03/12] block: Filtered children access functions
References: <20190213225311.17876-1-mreitz@redhat.com>
 <20190213225311.17876-4-mreitz@redhat.com>
 <895b530e-a81a-f8de-3be5-12e30c6190b7@redhat.com>
In-Reply-To: <895b530e-a81a-f8de-3be5-12e30c6190b7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.02.19 03:25, Eric Blake wrote:
> On 2/13/19 4:53 PM, Max Reitz wrote:
>> What bs->file and bs->backing mean depends on the node.  For filter
>> nodes, both signify a node that will eventually receive all R/W
>> accesses.  For format nodes, bs->file contains metadata and data, and
>> bs->backing will not receive writes -- instead, writes are COWed to
>> bs->file.  Usually.
>>
>> In any case, it is not trivial to guess what a child means exactly wit=
h
>> our currently limited form of expression.  It is better to introduce
>> some functions that actually guarantee a meaning:
>>
>> - bdrv_filtered_cow_child() will return the child that receives reques=
ts
>>   filtered through COW.  That is, reads may or may not be forwarded
>>   (depending on the overlay's allocation status), but writes never go =
to
>>   this child.
>>
>> - bdrv_filtered_rw_child() will return the child that receives request=
s
>>   filtered through some very plain process.  Reads and writes issued t=
o
>>   the parent will go to the child as well (although timing, etc. may b=
e
>>   modified).
>>
>> - All drivers but quorum (but quorum is pretty opaque to the general
>>   block layer anyway) always only have one of these children: All read=

>>   requests must be served from the filtered_rw_child (if it exists), s=
o
>>   if there was a filtered_cow_child in addition, it would not receive
>>   any requests at all.
>>   (The closest here is mirror, where all requests are passed on to the=

>>   source, but with write-blocking, write requests are "COWed" to the
>>   target.  But that just means that the target is a special child that=

>>   cannot be introspected by the generic block layer functions, and tha=
t
>>   source is a filtered_rw_child.)
>>   Therefore, we can also add bdrv_filtered_child() which returns that
>>   one child (or NULL, if there is no filtered child).
>>
>> Also, many places in the current block layer should be skipping filter=
s
>> (all filters or just the ones added implicitly, it depends) when going=

>> through a block node chain.  They do not do that currently, but this
>> patch makes them.
>>
>> One example for this is qemu-img map, which should skip filters and on=
ly
>> look at the COW elements in the graph.  The change to iotest 204's
>> reference output shows how using blkdebug on top of a COW node used to=

>> make qemu-img map disregard the rest of the backing chain, but with th=
is
>> patch, the allocation in the base image is reported correctly.
>>
>> Furthermore, a note should be made that sometimes we do want to access=

>> bs->backing directly.  This is whenever the operation in question is n=
ot
>> about accessing the COW child, but the "backing" child, be it COW or
>> not.  This is the case in functions such as bdrv_open_backing_file() o=
r
>> whenever we have to deal with the special behavior of @backing as a
>> blockdev option, which is that it does not default to null like all
>> other child references do.
>>
>> Finally, the query functions (query-block and query-named-block-nodes)=

>> are modified to return any filtered child under "backing", not just
>> bs->backing or COW children.  This is so that filters do not interrupt=

>> the reported backing chain.  This changes the output of iotest 184, as=

>> the throttled node now appears as a backing child.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>=20
>> +++ b/qapi/block-core.json
>> @@ -2417,6 +2417,10 @@
>>  # On successful completion the image file is updated to drop the back=
ing file
>>  # and the BLOCK_JOB_COMPLETED event is emitted.
>>  #
>> +# In case @device is a filter node, block-stream modifies the first n=
on-filter
>> +# overlay node below it to point to base's backing node (or NULL if @=
base was
>> +# not specified) instead of modifying @device itself.
>=20
> Maybe s/In case/If/

Works for me.

>> +/*
>> + * For a backing chain, return the first non-filter backing image.
>> + */
>> +BlockDriverState *bdrv_backing_chain_next(BlockDriverState *bs)
>> +{
>> +    return bdrv_skip_rw_filters(bdrv_filtered_cow_bs(bdrv_skip_rw_fil=
ters(bs)));
>=20
> Quite a mouthful, but looks correct.
>=20
>=20
>> +++ b/block/io.c
>> @@ -118,8 +118,17 @@ static void bdrv_merge_limits(BlockLimits *dst, c=
onst BlockLimits *src)
>>  void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
>>  {
>>      BlockDriver *drv =3D bs->drv;
>> +    BlockDriverState *storage_bs;
>> +    BlockDriverState *cow_bs =3D bdrv_filtered_cow_bs(bs);
>=20
> If the backing file is filtered by a blkdebug layer that intentionally
> is trying to advertise alternative block sizes...
>=20
>>      Error *local_err =3D NULL;
>> =20
>> +    /*
>> +     * FIXME: There should be a function for this, and in fact there
>> +     * will be as of a follow-up patch.
>> +     */
>> +    storage_bs =3D
>> +        child_bs(bs->file) ?: bdrv_filtered_rw_bs(bs);
>> +
>>      memset(&bs->bl, 0, sizeof(bs->bl));
>> =20
>>      if (!drv) {
>> @@ -131,13 +140,13 @@ void bdrv_refresh_limits(BlockDriverState *bs, E=
rror **errp)
>>                                  drv->bdrv_aio_preadv) ? 1 : 512;
>> =20
>>      /* Take some limits from the children as a default */
>> -    if (bs->file) {
>> -        bdrv_refresh_limits(bs->file->bs, &local_err);
>> +    if (storage_bs) {
>> +        bdrv_refresh_limits(storage_bs, &local_err);
>>          if (local_err) {
>>              error_propagate(errp, local_err);
>>              return;
>>          }
>> -        bdrv_merge_limits(&bs->bl, &bs->file->bs->bl);
>> +        bdrv_merge_limits(&bs->bl, &storage_bs->bl);
>>      } else {
>>          bs->bl.min_mem_alignment =3D 512;
>>          bs->bl.opt_mem_alignment =3D getpagesize();
>> @@ -146,13 +155,13 @@ void bdrv_refresh_limits(BlockDriverState *bs, E=
rror **errp)
>>          bs->bl.max_iov =3D IOV_MAX;
>>      }
>> =20
>> -    if (bs->backing) {
>> -        bdrv_refresh_limits(bs->backing->bs, &local_err);
>> +    if (cow_bs) {
>> +        bdrv_refresh_limits(cow_bs, &local_err);
>=20
> ...then this change means that the active layer no longer picks up the
> blkdebug block sizes, but the original COW layer sizes.

How so?

I don't see how this changes current behavior with just COW/blkdebug
nodes at all.  For blkdebug, bs->file is the storage_bs.  For COW nodes,
bs->file is the storage_bs and bs->backing is the cow_bs.  So these code
changes do nothing in that case.

(They only change something for filter nodes that use bs->backing for
their filtered node; because that is translated to storage_bs now.)


Note that bdrv_filtered_cow_bs() does not skip filters (i.e. the
blkdebug node).  That would be bdrv_backing_chain_next().

> Is that
> intentional?  I don't think it is fatal to the patch (as blkdebug is no=
t
> used in production, but only in testing), but it may cause some
> head-scratching when trying to test behaviors of a COW child with
> different block sizes than the active layer by using blkdebug on top of=

> the COW child.  I guess I'll find out soon enough (on my todo list is
> fixing NBD to never split an NBD_CMD_READ or NBD_CMD_BLOCK_STATUS reply=

> below the granularity advertised at the active layer, even if the
> backing file has a smaller granularity - and using blkdebug to force th=
e
> backing file granularity was my original plan of attack - but it is not=

> until this patch is applied that NBD can even locate the bitmap in a
> backing file when a filter is interposed)
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

Max


--jkmUgn18nipwlC6adETuy3oRKFTCbMuRn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxm7LIACgkQ9AfbAGHV
z0Bmwgf/T8DI3kNIxZ9OgHR6wowuZgacSOOcNAtoozKNlFEA74LaIhq/eppMDt6r
mNUaREaHPo/5+B5VQ7cu8r5mIWbUGZQy21k1gVc6oWHzFsLN1KxAdfSVlh4Xb3gS
DB/XZTOirFY52QwlbNKCvUWCsLCjBG93iUM0vfFsmVkf/i5iTxVyq8gejK8iXaQS
Lhze+2puh+iOust947ikgButx1cbDPUvsjtNA2/zjMtl0FXOdfueabdPBD7kSFys
m0VgQ2rmmQwjBps0ASDYRg6qG9seIXyT5IDjPbrAOyxlX/SBOWIRiyM5B0Y1yZFu
xNQI5PjizjmYPxso5NreCvqba9dQCg==
=ehTS
-----END PGP SIGNATURE-----

--jkmUgn18nipwlC6adETuy3oRKFTCbMuRn--
