Received: from eggs.gnu.org ([209.51.188.92]:45722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hJKtX-0007fu-Lj
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:37:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hJKtU-00061F-AO
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:37:15 -0400
References: <20190410202033.28617-1-mreitz@redhat.com>
	<20190410202033.28617-3-mreitz@redhat.com>
	<5a335159-8a98-5c60-657d-920e1eb81065@virtuozzo.com>
	<f7fa24d8-7608-ecc8-475c-42e3d58ba272@redhat.com>
	<495b2cb1-4a99-59d7-b7af-97bb3b9a55c1@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <18f06b0a-294a-97ac-c12c-e454580cfbd2@redhat.com>
Date: Wed, 24 Apr 2019 18:36:59 +0200
MIME-Version: 1.0
In-Reply-To: <495b2cb1-4a99-59d7-b7af-97bb3b9a55c1@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oQaFWRsXfXlA08YdgtQEfzzND5yJprdln"
Subject: Re: [Qemu-devel] [PATCH v4 02/11] block: Filtered children access
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oQaFWRsXfXlA08YdgtQEfzzND5yJprdln
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <18f06b0a-294a-97ac-c12c-e454580cfbd2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 02/11] block: Filtered children access
 functions
References: <20190410202033.28617-1-mreitz@redhat.com>
 <20190410202033.28617-3-mreitz@redhat.com>
 <5a335159-8a98-5c60-657d-920e1eb81065@virtuozzo.com>
 <f7fa24d8-7608-ecc8-475c-42e3d58ba272@redhat.com>
 <495b2cb1-4a99-59d7-b7af-97bb3b9a55c1@virtuozzo.com>
In-Reply-To: <495b2cb1-4a99-59d7-b7af-97bb3b9a55c1@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.04.19 12:23, Vladimir Sementsov-Ogievskiy wrote:
> 17.04.2019 19:22, Max Reitz wrote:
>> On 16.04.19 12:02, Vladimir Sementsov-Ogievskiy wrote:
>>> 10.04.2019 23:20, Max Reitz wrote:
>>>> What bs->file and bs->backing mean depends on the node.  For filter
>>>> nodes, both signify a node that will eventually receive all R/W
>>>> accesses.  For format nodes, bs->file contains metadata and data, an=
d
>>>> bs->backing will not receive writes -- instead, writes are COWed to
>>>> bs->file.  Usually.
>>>>
>>>> In any case, it is not trivial to guess what a child means exactly w=
ith
>>>> our currently limited form of expression.  It is better to introduce=

>>>> some functions that actually guarantee a meaning:
>>>>
>>>> - bdrv_filtered_cow_child() will return the child that receives requ=
ests
>>>>     filtered through COW.  That is, reads may or may not be forwarde=
d
>>>>     (depending on the overlay's allocation status), but writes never=
 go to
>>>>     this child.
>>>>
>>>> - bdrv_filtered_rw_child() will return the child that receives reque=
sts
>>>>     filtered through some very plain process.  Reads and writes issu=
ed to
>>>>     the parent will go to the child as well (although timing, etc. m=
ay be
>>>>     modified).
>>>>
>>>> - All drivers but quorum (but quorum is pretty opaque to the general=

>>>>     block layer anyway) always only have one of these children: All =
read
>>>>     requests must be served from the filtered_rw_child (if it exists=
), so
>>>>     if there was a filtered_cow_child in addition, it would not rece=
ive
>>>>     any requests at all.
>>>>     (The closest here is mirror, where all requests are passed on to=
 the
>>>>     source, but with write-blocking, write requests are "COWed" to t=
he
>>>>     target.  But that just means that the target is a special child =
that
>>>>     cannot be introspected by the generic block layer functions, and=
 that
>>>>     source is a filtered_rw_child.)
>>>>     Therefore, we can also add bdrv_filtered_child() which returns t=
hat
>>>>     one child (or NULL, if there is no filtered child).
>>>>
>>>> Also, many places in the current block layer should be skipping filt=
ers
>>>> (all filters or just the ones added implicitly, it depends) when goi=
ng
>>>> through a block node chain.  They do not do that currently, but this=

>>>> patch makes them.
>>>>
>>>> One example for this is qemu-img map, which should skip filters and =
only
>>>> look at the COW elements in the graph.  The change to iotest 204's
>>>> reference output shows how using blkdebug on top of a COW node used =
to
>>>> make qemu-img map disregard the rest of the backing chain, but with =
this
>>>> patch, the allocation in the base image is reported correctly.
>>>>
>>>> Furthermore, a note should be made that sometimes we do want to acce=
ss
>>>> bs->backing directly.  This is whenever the operation in question is=
 not
>>>> about accessing the COW child, but the "backing" child, be it COW or=

>>>> not.  This is the case in functions such as bdrv_open_backing_file()=
 or
>>>> whenever we have to deal with the special behavior of @backing as a
>>>> blockdev option, which is that it does not default to null like all
>>>> other child references do.
>>>>
>>>> Finally, the query functions (query-block and query-named-block-node=
s)
>>>> are modified to return any filtered child under "backing", not just
>>>> bs->backing or COW children.  This is so that filters do not interru=
pt
>>>> the reported backing chain.  This changes the output of iotest 184, =
as
>>>> the throttled node now appears as a backing child.
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>    qapi/block-core.json           |   4 +
>>>>    include/block/block.h          |   1 +
>>>>    include/block/block_int.h      |  40 +++++--
>>>>    block.c                        | 210 +++++++++++++++++++++++++++-=
-----
>>>>    block/backup.c                 |   8 +-
>>>>    block/block-backend.c          |  16 ++-
>>>>    block/commit.c                 |  33 +++---
>>>>    block/io.c                     |  45 ++++---
>>>>    block/mirror.c                 |  21 ++--
>>>>    block/qapi.c                   |  30 +++--
>>>>    block/stream.c                 |  13 +-
>>>>    blockdev.c                     |  88 +++++++++++---
>>>>    migration/block-dirty-bitmap.c |   4 +-
>>>>    nbd/server.c                   |   6 +-
>>>>    qemu-img.c                     |  29 ++---
>>>>    tests/qemu-iotests/184.out     |   7 +-
>>>>    tests/qemu-iotests/204.out     |   1 +
>>>>    17 files changed, 411 insertions(+), 145 deletions(-)
>>>
>>> really huge... didn't you consider conversion file-by-file?
>>
>> Frankly, no, I just didn=E2=80=99t consider it.
>>
>> Hm.  I don=E2=80=99t know, 30-patch series always look so frightening.=

>>
>>>> diff --git a/block.c b/block.c
>>>> index 16615bc876..e8f6febda0 100644
>>>> --- a/block.c
>>>> +++ b/block.c
>>>
>>> [..]
>>>
>>>>   =20
>>>> @@ -3467,14 +3469,17 @@ static int bdrv_reopen_parse_backing(BDRVReo=
penState *reopen_state,
>>>>        /*
>>>>         * Find the "actual" backing file by skipping all links that =
point
>>>>         * to an implicit node, if any (e.g. a commit filter node).
>>>> +     * We cannot use any of the bdrv_skip_*() functions here becaus=
e
>>>> +     * those return the first explicit node, while we are looking f=
or
>>>> +     * its overlay here.
>>>>         */
>>>>        overlay_bs =3D bs;
>>>> -    while (backing_bs(overlay_bs) && backing_bs(overlay_bs)->implic=
it) {
>>>> -        overlay_bs =3D backing_bs(overlay_bs);
>>>> +    while (overlay_bs->backing && bdrv_filtered_bs(overlay_bs)->imp=
licit) {
>>>
>>> So, you don't want to skip implicit filters with 'file' child? Then, =
why not to use
>>> child_bs(overlay_bs->backing), like in following if condition?
>>
>> I think it was an artifact of writing the patch.  I started with
>> bdrv_filtered_bs() and then realized this depends on ->backing,
>> actually.  There was no functional difference so I left it as it was.
>>
>> But you=E2=80=99re right, it is more clear to use child_bs(overlay_bs-=
>backing)
>> isntead.
>>
>>> Could we instead make backing-based filters equal to file-based, to m=
ake it possible
>>> to use file-based filters in backing-chain related scenarios (like up=
coming copy-on-read
>>> filter for stream)? So, to expand backing-chain concept to include fi=
lters with file child?
>>
>> If I understand you correctly, that=E2=80=99s basically the purpose of=
 this
>> series and especially this patch here.  As far as it is possible and
>> reasonable, I want filters that use bs->backing and bs->file behave th=
e
>> same.
>>
>> However, there are cases where this is not possible and
>> bdrv_reopen_parse_backing() is one such case.  bs->backing and bs->fil=
e
>> correspond to QAPI names, namely 'backing' and 'file'.  If that
>> distinction was already visible to the user, we cannot change it now.
>>
>> We definitely cannot make file-based filters use bs->backing now becau=
se
>> you can create them over QAPI and they use 'file' as their child name.=

>> Can we make backing-based filters use bs->file?  Seems more likely,
>> because all of them are implicit nodes, so the user usually doesn=E2=80=
=99t see
>> them.  But usually isn=E2=80=99t always; they do become user-visible o=
nce the
>> user specifies a node-name for mirror or commit.
>>
>> I found it more reasonable to introduce new functions that explicitly
>> express what kind of child they expect and then apply them everywhere =
as
>> I saw fit, instead of making the mirror/commit filter drivers use
>> bs->file and hope it works; not least because I=E2=80=99d still have t=
o go
>> through the whole block layer and check every instance of bs->backing =
to
>> see whether it really needs bs->backing or whether it should use eithe=
r
>> of bs->backing or bs->file.
>>
>>>> +        overlay_bs =3D bdrv_filtered_bs(overlay_bs);
>>>>        }
>>>>   =20
>>>>        /* If we want to replace the backing file we need some extra =
checks */
>>>> -    if (new_backing_bs !=3D backing_bs(overlay_bs)) {
>>>> +    if (new_backing_bs !=3D child_bs(overlay_bs->backing)) { >     =
      /* Check for implicit nodes between bs and its backing file */
>>>>            if (bs !=3D overlay_bs) {
>>>>                error_setg(errp, "Cannot change backing link if '%s' =
has "
>>>
>>> [..]
>>>
>>>> @@ -4203,8 +4208,8 @@ int bdrv_change_backing_file(BlockDriverState =
*bs,
>>>>    BlockDriverState *bdrv_find_overlay(BlockDriverState *active,
>>>>                                        BlockDriverState *bs)
>>>>    {
>>>> -    while (active && bs !=3D backing_bs(active)) {
>>>> -        active =3D backing_bs(active);
>>>> +    while (active && bs !=3D bdrv_filtered_bs(active)) {
>>>
>>> hmm and here you actually support backing-chain with file-child-based=
 filters in it..
>>
>> Yes, because this is not about the QAPI 'backing' link.  This function=

>> should continue to work even if there are filters in the backing chain=
=2E
>=20
> this is a generic function to find overlay in backing chain and it may =
be used from different places,
> for example it is used in Andrey's series about filter for block-stream=
=2E

Well, all places that use it accept backing chains with filters inside
of them.

> It is used from qmp_block_commit, isn't it about QAPI?

By "QAPI 'backing' link" I mean the user-visible block graph.  Hm.  I
wrote in my other mail that you could use query-named-block-nodes to see
that graph; apparently you can=E2=80=99t.  So besides x-debug-query-block=
-graph,
we still don=E2=80=99t have any facility to query the block graph?  I don=
=E2=80=99t know
what to say.

Anyway, you can still construct the graph with blockdev-add, so it is
user-visible.  And in that block graph, there is a 'backing' link, and
there is a 'file' link -- this is what I mean with "QAPI link".

We have commands that are abstract and don=E2=80=99t work on specific gra=
ph
links.  For instance, block-commit commits across a backing chain, so it
doesn=E2=80=99t matter whether the graph link is called 'backing' or what=
ever,
what is important is that it=E2=80=99s a COW link.  But we should also ig=
nore
filters on the way, so this patch makes block-commit and others use
those more abstract child access functions.

But whenever it is about exactly the "file" or the "backing" link, we
have to use bs->file and bs->backing, respectively.  That's just how it
currently is.

>>>> +        active =3D bdrv_filtered_bs(active);
>>>>        }
>>>>   =20
>>>>        return active;
>>>> @@ -4226,11 +4231,11 @@ bool bdrv_is_backing_chain_frozen(BlockDrive=
rState *bs, BlockDriverState *base,
>>>>    {
>>>>        BlockDriverState *i;
>>>>   =20
>>>> -    for (i =3D bs; i !=3D base; i =3D backing_bs(i)) {
>>>> +    for (i =3D bs; i !=3D base; i =3D child_bs(i->backing)) {
>>>
>>> and here don't..
>>
>> Yes, because this function is about the QAPI 'backing' link.
>=20
> And this again a generic thing, that may be used in same places as bdrv=
_find_overlay,

But it isn=E2=80=99t.

> and it is used in series about block-stream filter too. So, for further=
 developments
> we'll have to keep in mind all these differences between generic block =
layer functions,
> which supports .file children inside backing chain and which are not...=


I was wrong about bdrv_is_backing_chain_frozen(), if that helps (as I
wrote in my other (previous) mail).

But for example bdrv_set_backing_hd() always has to use bs->backing,
because that=E2=80=99s what it=E2=80=99s about (and I do change its descr=
iptive comment
to reflect that, so you don=E2=80=99t need to keep it in mind).  Same for=

bdrv_open_backing_file().

Hm, what other cases are there...

bdrv_reopen_parse_backing(): Fundamentally, this too is about the
user-visible "backing" link (as specified through x-blockdev-reopen).
But the loop it contains is more difficult to translate than I had
thought.  At some point, there needs to be a bs->backing link, because
that is what this function is about, but it should also skip all
implicit filters in the way, I think.  So e.g. this should be recognized:=


bs  ---backing-->  COR ---file-->  base

@overlay_bs should be COR, I think...?  I mean, as long as COR is an
implicit node.  So the loop really should use bdrv_filtered_bs()
everywhere, and then the same afterwards.  I think that we should also
ensure that @bs can support a ->backing child, but how would I check
that?  Maybe it=E2=80=99s safe to just omit such a check...

But then another issue comes in: The link to replace (in the above case
from "COR" to "base") is no longer necessarily a backing link.  So
bdrv_reopen_commit() has to be capable of replacing both bs->backing and
bs->file.

Actually, how does bdrv_reopen_commit() handle implicit nodes at all?
bdrv_reopen_parse_backing() just sets reopen_state->replace_backing_bs
and ->new_backing_bs.  It doesn=E2=80=99t communicate anything about over=
lay_bs.
 bdrv_reopen_commit() then asserts that !bs->backing->bs->implicit and
replaces bs->backing.  So it seems to just fail on the implicit nodes
that bdrv_reopen_parse_backing() took care to skip...


OK, what else...  bdrv_reopen_prepare() checks
reopen_state->bs->backing, which I claim is correct because while there
may be implicit filters in the chain, the first link has to be a
->backing link.

bdrv_backing_overridden() has to query bs->backing because this function
is used when it is about a specific characteristic of the backing link:
There is a non-null default (given by the image header), so if the
current bs->backing matches this default, you do not have to specify the
backing filename in either blockdev-add or a filename.  Same in
bdrv_refresh_filename().


I hope that was all...?

Max


--oQaFWRsXfXlA08YdgtQEfzzND5yJprdln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzAkKsACgkQ9AfbAGHV
z0BPwgf+MkCce7cM9USU6fLSgwoVPqpzolIxKOvvROu9LgrwAmZEQvhb9pG2ApBe
5nttwz9I3oHrRd6Y1aZLFRL7c45GpKiSQk2eEhX+41za4jz+OfhCBAXjdxydytBw
x8GJ88Ussi3aiLxsAOXgJXulle9dHm1Xz4Y8mlTD7j1AmA2e/iAwmvmwn6/i4eN6
mMkkWW6MjRHB9kvELy5viqsqVanu4P/CBNXOUPgirSd8AXGu4WlJAlAgDglAQSld
BSSqrJNlDGvMM5Cvh7ZANmfsaWcKLjf5vzSwsYZoMOA2NpGnMcYQtusbAexbWs8+
XwXxQi/jpOtwjGZPf4CNeOJkznZahA==
=xFtm
-----END PGP SIGNATURE-----

--oQaFWRsXfXlA08YdgtQEfzzND5yJprdln--
