Received: from eggs.gnu.org ([2001:4830:134:3::10]:33809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ciM5P-00053C-Re
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:15:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ciM5O-0002bR-BT
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:15:35 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-19-git-send-email-kwolf@redhat.com>
	<3a201ea1-81fe-e4f3-7474-364b7cc8f091@redhat.com>
	<20170227123302.GD6356@noname.redhat.com>
	<b735ce93-e4a3-5f25-f641-108d8f9cccc7@redhat.com>
	<20170227140521.GE6356@noname.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d9bbc446-bfd8-22ca-9f85-653be66e1b75@redhat.com>
Date: Mon, 27 Feb 2017 15:15:22 +0100
MIME-Version: 1.0
In-Reply-To: <20170227140521.GE6356@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="12x3tKseL6U9mS2gkjXS3uvViruu02qW5"
Subject: Re: [Qemu-devel] [PATCH 18/54] block: Default .bdrv_child_perm()
 for format drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--12x3tKseL6U9mS2gkjXS3uvViruu02qW5
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, famz@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <d9bbc446-bfd8-22ca-9f85-653be66e1b75@redhat.com>
Subject: Re: [PATCH 18/54] block: Default .bdrv_child_perm() for format
 drivers
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-19-git-send-email-kwolf@redhat.com>
 <3a201ea1-81fe-e4f3-7474-364b7cc8f091@redhat.com>
 <20170227123302.GD6356@noname.redhat.com>
 <b735ce93-e4a3-5f25-f641-108d8f9cccc7@redhat.com>
 <20170227140521.GE6356@noname.redhat.com>
In-Reply-To: <20170227140521.GE6356@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 27.02.2017 15:05, Kevin Wolf wrote:
> Am 27.02.2017 um 13:34 hat Max Reitz geschrieben:
>> On 27.02.2017 13:33, Kevin Wolf wrote:
>>> Am 25.02.2017 um 12:57 hat Max Reitz geschrieben:
>>>> On 21.02.2017 15:58, Kevin Wolf wrote:
>>>>> Almost all format drivers have the same characteristics as far as
>>>>> permissions are concerned: They have one or more children for stori=
ng
>>>>> their own data and, more importantly, metadata (can be written to a=
nd
>>>>> grow even without external write requests, must be protected agains=
t
>>>>> other writers and present consistent data) and optionally a backing=
 file
>>>>> (this is just data, so like for a filter, it only depends on what t=
he
>>>>> parent nodes need).
>>>>>
>>>>> This provides a default implementation that can be shared by most o=
f
>>>>> our format drivers.
>>>>>
>>>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>>>> ---
>>>>>  block.c                   | 42 +++++++++++++++++++++++++++++++++++=
+++++++
>>>>>  include/block/block_int.h |  8 ++++++++
>>>>>  2 files changed, 50 insertions(+)
>>>>>
>>>>> diff --git a/block.c b/block.c
>>>>> index 523cbd3..f2e7178 100644
>>>>> --- a/block.c
>>>>> +++ b/block.c
>>>>> @@ -1554,6 +1554,48 @@ void bdrv_filter_default_perms(BlockDriverSt=
ate *bs, BdrvChild *c,
>>>>>                 (c->shared_perm & DEFAULT_PERM_UNCHANGED);
>>>>>  }
>>>>> =20
>>>>> +void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,=

>>>>> +                               const BdrvChildRole *role,
>>>>> +                               uint64_t perm, uint64_t shared,
>>>>> +                               uint64_t *nperm, uint64_t *nshared)=

>>>>> +{
>>>>> +    bool backing =3D (role =3D=3D &child_backing);
>>>>> +    assert(role =3D=3D &child_backing || role =3D=3D &child_file);=

>>>>> +
>>>>> +    if (!backing) {
>>>>> +        /* Apart from the modifications below, the same permission=
s are
>>>>> +         * forwarded and left alone as for filters */
>>>>> +        bdrv_filter_default_perms(bs, c, role, perm, shared, &perm=
, &shared);
>>>>> +
>>>>> +        /* Format drivers may touch metadata even if the guest doe=
sn't write */
>>>>> +        if (!bdrv_is_read_only(bs)) {
>>>>> +            perm |=3D BLK_PERM_WRITE | BLK_PERM_RESIZE;
>>>>> +        }
>>>>> +
>>>>> +        /* bs->file always needs to be consistent because of the m=
etadata. We
>>>>> +         * can never allow other users to resize or write to it. *=
/
>>>>> +        perm |=3D BLK_PERM_CONSISTENT_READ;
>>>>> +        shared &=3D ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
>>>>> +    } else {
>>>>> +        /* We want consistent read from backing files if the paren=
t needs it.
>>>>> +         * No other operations are performed on backing files. */
>>>>> +        perm &=3D BLK_PERM_CONSISTENT_READ;
>>>>> +
>>>>> +        /* If the parent can deal with changing data, we're okay w=
ith a
>>>>> +         * writable and resizable backing file. */
>>>>> +        if (shared & BLK_PERM_WRITE) {
>>>>> +            shared =3D BLK_PERM_WRITE | BLK_PERM_RESIZE;
>>>>
>>>> Wouldn't this break CONSISTENT_READ?
>>>
>>> WRITE (even for multiple users) and CONSISTENT_READ aren't mutually
>>> exclusive. I was afraid that I didn't define CONSISTENT_READ right, b=
ut
>>> it appears that the definition is fine:
>>>
>>>  * A user that has the "permission" of consistent reads is guaranteed=
 that
>>>  * their view of the contents of the block device is complete and
>>>  * self-consistent, representing the contents of a disk at a specific=

>>>  * point.
>>
>> Right, but writes to the backing file at least to me appear to be a
>> different matter. If those don't break CONSISTENT_READ, then I don't s=
ee
>> how commit breaks CONSISTENT_READ for the intermediate nodes.
>=20
> There's probably multiple ways to interpret such actions. You could
> understand a commit job as writing the desired image to the base node
> and at the same time it's a shared writer for the intermediate nodes
> that happens to write garbage.

Agreed.

>                                The question is if this is a useful way
> of seeing it when the job is to prevent accidental data corruption.

Agreed. But then I would infer that any write to a backing file breaks
CONSISTENT_READ on the overlay.

> Note that we need writable backing files for commit, so taking away
> BLK_PERM_WRITE from shared wouldn't work. We could probably make it
> dependent on cleared CONSISTENT_READ (commit jobs don't require this
> anyway), if you think that the current version is too permissive.

I agree that we need to be able to share WRITE for a backing file. But I
think this should only be set if the overlay's parents do not require
CONSISTENT_READ from the overlay.

Max


--12x3tKseL6U9mS2gkjXS3uvViruu02qW5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli0NHoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A/R4H/2fwAsLWOmSbjDTYhzoMWEhpwgrlNJOS
1bshp+HDRpug7s50WL+nHbhPlLrxmBf83vCXxSVa9b4ht62l+EMKanT6BsOJNOx1
tnKK5HPtzUw7bn430bcsxfrI5710QoLMqy3/ZiIwkA2x3vQaFM4JsRJw4EN9CilN
7ZNg4MIu4qd6r8tGaCQYnwhciVGJAcd5YelOWr1Q4VLZMebsW8igHm1p5jw3aqIG
MqXwEFCzBtjAKvyDKWB79B+Pl0DagzZN6JOtPHE9IylAJIV+ua2Wd5fQbkpGEuzf
IUzPSFY790VDLd1vLpHRKknYcW72YWJJHxypD6qHp5VZCQeZb+d2lPg=
=r9dM
-----END PGP SIGNATURE-----

--12x3tKseL6U9mS2gkjXS3uvViruu02qW5--
