Received: from eggs.gnu.org ([2001:4830:134:3::10]:46969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gN1Cx-0001Cd-By
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 14:52:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gN1Cv-0005VA-EB
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 14:52:15 -0500
References: <20180809223117.7846-1-mreitz@redhat.com>
	<20180809223117.7846-4-mreitz@redhat.com>
	<e855b03b-67e0-d822-d9fe-dedc1456011e@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f5d4e779-26c3-fd93-cae9-7d202242fd8c@redhat.com>
Date: Wed, 14 Nov 2018 20:52:02 +0100
MIME-Version: 1.0
In-Reply-To: <e855b03b-67e0-d822-d9fe-dedc1456011e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Lx4qq5xfb3Y79rAWNMiNALBDq3YOY5MKa"
Subject: Re: [Qemu-devel] [PATCH v2 03/11] block: Filtered children access
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Lx4qq5xfb3Y79rAWNMiNALBDq3YOY5MKa
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <f5d4e779-26c3-fd93-cae9-7d202242fd8c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/11] block: Filtered children access
 functions
References: <20180809223117.7846-1-mreitz@redhat.com>
 <20180809223117.7846-4-mreitz@redhat.com>
 <e855b03b-67e0-d822-d9fe-dedc1456011e@redhat.com>
In-Reply-To: <e855b03b-67e0-d822-d9fe-dedc1456011e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.11.18 23:17, Eric Blake wrote:
> On 8/9/18 5:31 PM, Max Reitz wrote:
>> What bs->file and bs->backing mean depends on the node.=C2=A0 For filt=
er
>> nodes, both signify a node that will eventually receive all R/W
>> accesses.=C2=A0 For format nodes, bs->file contains metadata and data,=
 and
>> bs->backing will not receive writes -- instead, writes are COWed to
>> bs->file.=C2=A0 Usually.
>>
>> In any case, it is not trivial to guess what a child means exactly wit=
h
>> our currently limited form of expression.=C2=A0 It is better to introd=
uce
>> some functions that actually guarantee a meaning:
>>
>> - bdrv_filtered_cow_child() will return the child that receives reques=
ts
>> =C2=A0=C2=A0 filtered through COW.=C2=A0 That is, reads may or may not=
 be forwarded
>> =C2=A0=C2=A0 (depending on the overlay's allocation status), but write=
s never go to
>> =C2=A0=C2=A0 this child.
>>
>> - bdrv_filtered_rw_child() will return the child that receives request=
s
>> =C2=A0=C2=A0 filtered through some very plain process.=C2=A0 Reads and=
 writes issued to
>> =C2=A0=C2=A0 the parent will go to the child as well (although timing,=
 etc. may be
>> =C2=A0=C2=A0 modified).
>>
>> - All drivers but quorum (but quorum is pretty opaque to the general
>> =C2=A0=C2=A0 block layer anyway) always only have one of these childre=
n: All read
>> =C2=A0=C2=A0 requests must be served from the filtered_rw_child (if it=
 exists), so
>> =C2=A0=C2=A0 if there was a filtered_cow_child in addition, it would n=
ot receive
>> =C2=A0=C2=A0 any requests at all.
>> =C2=A0=C2=A0 (The closest here is mirror, where all requests are passe=
d on to the
>> =C2=A0=C2=A0 source, but with write-blocking, write requests are "COWe=
d" to the
>> =C2=A0=C2=A0 target.=C2=A0 But that just means that the target is a sp=
ecial child that
>> =C2=A0=C2=A0 cannot be introspected by the generic block layer functio=
ns, and that
>> =C2=A0=C2=A0 source is a filtered_rw_child.)
>> =C2=A0=C2=A0 Therefore, we can also add bdrv_filtered_child() which re=
turns that
>> =C2=A0=C2=A0 one child (or NULL, if there is no filtered child).
>>
>> Also, many places in the current block layer should be skipping filter=
s
>> (all filters or just the ones added implicitly, it depends) when going=

>> through a block node chain.=C2=A0 They do not do that currently, but t=
his
>> patch makes them.
>=20
> The description makes sense; now on to the code.
>=20
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 qapi/block-core.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
>> =C2=A0 include/block/block.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 include/block/block_int.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 33 +++++-
>> =C2=A0 block.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 184 ++++++++++++++++++++++++++++-----
>> =C2=A0 block/backup.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +-
>> =C2=A0 block/block-backend.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 16 ++-
>> =C2=A0 block/commit.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 36 ++++---
>> =C2=A0 block/io.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 27 ++---
>> =C2=A0 block/mirror.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 37 ++++---
>> =C2=A0 block/qapi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 26 ++--=
-
>> =C2=A0 block/stream.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 15 ++-
>> =C2=A0 blockdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 84 ++++++++++++---
>> =C2=A0 migration/block-dirty-bitmap.c |=C2=A0=C2=A0 4 +-
>> =C2=A0 nbd/server.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8=
 +-
>> =C2=A0 qemu-img.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 12 ++-
>> =C2=A0 15 files changed, 363 insertions(+), 132 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index f20efc97f7..a71df88eb2 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2248,6 +2248,10 @@
>> =C2=A0 # On successful completion the image file is updated to drop th=
e
>> backing file
>> =C2=A0 # and the BLOCK_JOB_COMPLETED event is emitted.
>=20
> Context: this is part of block-stream.
>=20
>> =C2=A0 #
>> +# In case @device is a filter node, block-stream modifies the first
>> non-filter
>> +# overlay node below it to point to base's backing node (or NULL if
>> @base was
>> +# not specified) instead of modifying @device itself.
>=20
> That is, if we have:
>=20
> base <- filter1 <- active <- filter2
>=20
> and request a block-stream with "top":"filter2", it is no different in
> effect than if we had requested "top":"active", since filter nodes can'=
t
> be stream targets.=C2=A0 Makes sense.
>=20
> What happens if we request "base":"filter1"? Do we want to require base=

> to be a non-filter node?

Well, then you get this after streaming:

base <- active <- filter2

There is no good reason why you'd stream to remove filters (just doing a
reopen should be enough), but why not.  We can make the backing pointer
point to any child, so it doesn't matter what the child is.  The problem
is that we can only write backing file strings into actual COW overlay
nodes, so it does matter what the parent is.

>> +++ b/include/block/block_int.h
>> @@ -91,6 +91,7 @@ struct BlockDriver {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * certain callbacks that refer to=
 data (see block.c) to their
>> bs->file if
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the driver doesn't implement th=
em. Drivers that do not wish
>> to forward
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * must implement them and return =
-ENOTSUP.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Note that filters are not allowed to modif=
y data.
>=20
> They can modify offsets and timing, but not data?=C2=A0 Even if it is a=
n
> encryption filter?=C2=A0 I'm trying to figure out if LUKS behaves like =
a filter.

It doesn't.  It's a format.

First of all, LUKS has metadata, so it definitely is a format.

Second, even if it didn't, I think it is a very, very useful convention
to declare filters as things that do not modify data.  If a block driver
does modify data, there is absolutely no point in handling it any
different than a normal format driver.

>> +++ b/block.c
>> @@ -532,11 +532,12 @@ int bdrv_create_file(const char *filename,
>> QemuOpts *opts, Error **errp)
>> =C2=A0 int bdrv_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz=
)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriver *drv =3D bs->drv;
>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *filtered =3D bdrv_filtered_rw_bs=
(bs);
>=20
> Is it worth a micro-optimization of not calling this...
>=20
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (drv && drv->bdrv_probe_block=
sizes) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return drv->bdr=
v_probe_blocksizes(bs, bsz);
>=20
> ...until after checking drv->bdrv_probe_blocksizes?

I don't know? :-)

I wouldn't think so, as bdrv_filtered_rw_bs() is just so simple.

>> -=C2=A0=C2=A0=C2=A0 } else if (drv && drv->is_filter && bs->file) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bdrv_probe_blocksiz=
es(bs->file->bs, bsz);
>> +=C2=A0=C2=A0=C2=A0 } else if (filtered) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bdrv_probe_blocksiz=
es(filtered, bsz);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> But I don't mind if you leave it as written.
>=20
> Is blkdebug a filter, or something else?

I would have said it's a filter.

> That's a case of something
> that DOES change block sizes in relation to the child that it is
> filtering.=C2=A0 If we have qcow2 -> blkdebug -> file, and the qcow2 fo=
rmat
> layer wants to know the blocksizes of its child, does it really always
> want the sizes of 'file' rather than the (possibly changed) sizes of
> 'blkdebug'?

Hm.  See, that's why this series is so difficult, because all these
questions keep popping up. :-)

This is a very good question indeed.  I think for all filters but
blkdebug it makes sense to just pass this through to the filtered child,
because this should fundamentally go down to the protocol layer anyway.

However, when looking at who uses this function at all, it appears that
this is just used for guest device configuration (so the guest device's
cluster size matches the hosts).  qcow2 doesn't support this at all, so
if you use qcow2, you'll just get the default of BDRV_SECTOR_SIZE.  If
you want to override the auto-detection, you can set a device-level
option.  So I don't think we need support in blkdebug to emulate a
different block size, because of two reasons:

First, it wouldn't be a test of the block layer, because the block layer
really doesn't care about this (internally).

So second, it would only be a test of a guest.  But if you want to test
that, you can always just set the device-level option.

>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOTSUP;
>> @@ -551,11 +552,12 @@ int bdrv_probe_blocksizes(BlockDriverState *bs,
>> BlockSizes *bsz)
>> =C2=A0 int bdrv_probe_geometry(BlockDriverState *bs, HDGeometry *geo)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriver *drv =3D bs->drv;
>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *filtered =3D bdrv_filtered_rw_bs=
(bs);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (drv && drv->bdrv_probe_geome=
try) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return drv->bdr=
v_probe_geometry(bs, geo);
>> -=C2=A0=C2=A0=C2=A0 } else if (drv && drv->is_filter && bs->file) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bdrv_probe_geometry=
(bs->file->bs, geo);
>> +=C2=A0=C2=A0=C2=A0 } else if (filtered) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bdrv_probe_geometry=
(filtered, geo);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> At least you're consistent on skipping filters.

I tried my best to come up with something that makes sense.  Sometimes
it made me nearly go insane.

>> @@ -4068,7 +4074,19 @@ BlockDriverState *bdrv_lookup_bs(const char
>> *device,
>> =C2=A0 bool bdrv_chain_contains(BlockDriverState *top, BlockDriverStat=
e *base)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (top && top !=3D base) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 top =3D backing_bs(top);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 top =3D bdrv_filtered_bs(t=
op);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return top !=3D NULL;
>> +}
>> +
>> +/* Same as bdrv_chain_contains(), but skip implicitly added R/W filte=
r
>> + * nodes and do not move past explicitly added R/W filters. */
>> +bool bdrv_legacy_chain_contains(BlockDriverState *top,
>> BlockDriverState *base)
>> +{
>> +=C2=A0=C2=A0=C2=A0 top =3D bdrv_skip_implicit_filters(top);
>> +=C2=A0=C2=A0=C2=A0 while (top && top !=3D base) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 top =3D bdrv_skip_implicit=
_filters(bdrv_filtered_cow_bs(top));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> Is there a goal of getting rid of bdrv_legacy_chain_contains() in the
> future?=C2=A0 If so, should the commit message and/or code comments men=
tion
> that?

The only thing that's using it is qmp_block_commit.  I think the
long-term goal is to get rid of the commit job and replace it by
blockdev-copy, which would make the use of that function moot, but I
suppose we have to keep it around as long as block-commit is there.

>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return top !=3D NULL;
>> @@ -4140,20 +4158,24 @@ int bdrv_has_zero_init_1(BlockDriverState *bs)=

>> =C2=A0 =C2=A0 int bdrv_has_zero_init(BlockDriverState *bs)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *filtered;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!bs->drv) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If BS is a copy on write imag=
e, it is initialized to
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the contents of the b=
ase image, which may not be zeroes.=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 if (bs->backing) {
>> +=C2=A0=C2=A0=C2=A0 if (bdrv_filtered_cow_child(bs)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>=20
> Not for this patch, but should we ask the filtered_cow_child if it is
> known to be all-zero content before blindly returning 0 here? Some
> children may be able to efficiently report if they have all-zero conten=
t
> [for example, see the recent thread about NBD performace drop due to
> explicitly zeroing the remote device, which could be skipped if it is
> known that the remote device started life uninitialized]

The question is, why would you have an empty backing file?

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bs->drv->bdrv_has_zero_init) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bs->drv-=
>bdrv_has_zero_init(bs);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 if (bs->file && bs->drv->is_filter) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bdrv_has_zero_init(=
bs->file->bs);
>> +
>> +=C2=A0=C2=A0=C2=A0 filtered =3D bdrv_filtered_rw_bs(bs);
>> +=C2=A0=C2=A0=C2=A0 if (filtered) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bdrv_has_zero_init(=
filtered);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> You argued earlier that a filter can't change contents - but is that
> just guest-visible contents? If LUKS is a filter node, then a file that=

> is zero-initialized is NOT zero-initialized after passing through LUKS
> encryption (decrypting the zeros returns garbage; conversely, writing
> zeros into LUKS results in random-looking bits in the file).=C2=A0 I gu=
ess
> I'm leaning more and more towards LUKS is not a filter, but a format.

Yeah.  I think it's just not useful to consider LUKS a filter, because
if filters can change data -- then what good is having the "filter"
category?

>> @@ -4198,8 +4220,9 @@ int bdrv_get_info(BlockDriverState *bs,
>> BlockDriverInfo *bdi)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEDI=
UM;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!drv->bdrv_get_info) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bs->file && drv->is_fi=
lter) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn bdrv_get_info(bs->file->bs, bdi);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverState *filtered=
 =3D bdrv_filtered_rw_bs(bs);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (filtered) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn bdrv_get_info(filtered, bdi);
>=20
> Is this right for blkdebug?

I think it is.  If it wants to intercept this function, it's free to
implement .bdrv_get_info.

The alternative is returning -ENOTSUP, and I don't see how that's any
better than passing data through from the child.

>> @@ -5487,3 +5519,105 @@ bool
>> bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name=
,
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return drv->bdrv_can_store_new_d=
irty_bitmap(bs, name,
>> granularity, errp);
>> =C2=A0 }
>> +
>> +/*
>> + * Return the child that @bs acts as an overlay for, and from which
>> data may be
>> + * copied in COW or COR operations.=C2=A0 Usually this is the backing=
 file.
>> + */
>> +BdrvChild *bdrv_filtered_cow_child(BlockDriverState *bs)
>> +{
>> +=C2=A0=C2=A0=C2=A0 if (!bs || !bs->drv) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (bs->drv->is_filter) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +=C2=A0=C2=A0=C2=A0 }
>=20
> Here, filters end the search...

Yes, because COW parents have is_filter =3D=3D false...

>> +
>> +=C2=A0=C2=A0=C2=A0 return bs->backing;
>> +}
>> +
>> +/*
>> + * If @bs acts as a pass-through filter for one of its children,
>> + * return that child.=C2=A0 "Pass-through" means that write operation=
s to
>> + * @bs are forwarded to that child instead of triggering COW.
>> + */
>> +BdrvChild *bdrv_filtered_rw_child(BlockDriverState *bs)
>> +{
>> +=C2=A0=C2=A0=C2=A0 if (!bs || !bs->drv) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!bs->drv->is_filter) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +=C2=A0=C2=A0=C2=A0 }
>=20
> ...while here, non-filters end the search. I think I follow your
> semantics (we were abusing bs->backing for filters, and your code is no=
w
> trying to distinguish what was really meant)

=2E..while R/W filter parents have is_filter =3D=3D true.  So that's why =
it's
the opposite.

>> +
>> +=C2=A0=C2=A0=C2=A0 return bs->backing ?: bs->file;
>> +}
>> +
>> +/*
>> + * Return any filtered child, independently on how it reacts to write=

>=20
> s/on/of/

Indeed.

>> + * accesses and whether data is copied onto this BDS through COR.
>> + */

[...]

>> +++ b/block/io.c
>> @@ -120,6 +120,7 @@ static void bdrv_merge_limits(BlockLimits *dst,
>> const BlockLimits *src)
>> =C2=A0 void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriver *drv =3D bs->drv;
>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *cow_bs =3D bdrv_filtered_cow_bs(=
bs);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(&bs->bl, 0, sizeof(bs->bl=
));
>> @@ -148,13 +149,13 @@ void bdrv_refresh_limits(BlockDriverState *bs,
>> Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->bl.max_iov =
=3D IOV_MAX;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (bs->backing) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_refresh_limits(bs->ba=
cking->bs, &local_err);
>> +=C2=A0=C2=A0=C2=A0 if (cow_bs) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_refresh_limits(cow_bs=
, &local_err);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local_err) =
{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 error_propagate(errp, local_err);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_merge_limits(&bs->bl,=
 &bs->backing->bs->bl);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_merge_limits(&bs->bl,=
 &cow_bs->bl);
>=20
> Is this doing the right things with blkdebug?

First, blkdebug doesn't have a COW child, does it?

Second, we still always invoke the driver's implementation (if there is
one).  All of the code at the beginning of the function just chooses
some defaults.  So blkdebug can still override everything.

But there is indeed something wrong here.  And that is: What is with R/W
filter drivers that use bs->backing?  After this patch, they won't get
any defaults.

So I think the change that is needed is:
- The bs->file branch should be transformed into a bdrv_storage_bs()
  branch (this is done by the next patch already, good)
- The bs->backing branch should be transformed into a bdrv_filtered_bs()
  branch

Then we have the following cases:
- R/W filters will go into the second branch rather than the first, but
  that's OK, because the code is the same anyway.
  (But all filters that used bs->backing already did go into the second
  branch, so...)
- COW nodes (with both a storage child and a filtered child) will
  continue to go into both branches and get a joined result.
- Non-COW format nodes will continue to go into the first branch.

Before we have bs_storage_bs() (that is, before the next patch), I think
it's OK to make filter nodes that use bs->file go into both branches
(because bs->file is set for them, so they'll go into the first branch,
and then, as filters, they'll go into the second branch).


So I think all that's needed is s/cow_bs/filtered_bs/ and
s/bdrv_filtered_cow_bs/bdrv_filtered_bs/.

Max


--Lx4qq5xfb3Y79rAWNMiNALBDq3YOY5MKa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvsfOIACgkQ9AfbAGHV
z0A9PAf/TkvZqORgV7zJAwLQfmM3G4kwmF23sKNLMoU1/7cnS1QTAy6L5NvOSpfR
Bor2UIsuCKKFP+Wp5fFoYGQwY1w/IO64Fnrm8h4qz9hcgZ3UxyKdxgjqgnzWVakw
hYr5RFCknNq/cbOjNx/4XkGHNKEQvTPbd0UiI2qsRvElngZ20jMTYnma/JaOjbna
/0M8i0WxuK5BcO5Xb2ei94QtUPEP/8amvkZLbiE7jBvaxSO0+hi0c1uFmL3y9aZf
7E8VIsY5lcd9bL+wKlLR3JL7o5UbjT0G/inuf72OPlongW8k3D3AaxrG5PgFKrlx
v43uZo6hAQ5xJJTFOZYeiPiCHcOVkw==
=ug9d
-----END PGP SIGNATURE-----

--Lx4qq5xfb3Y79rAWNMiNALBDq3YOY5MKa--
