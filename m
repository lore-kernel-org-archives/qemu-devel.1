Received: from eggs.gnu.org ([2001:4830:134:3::10]:33250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ce3Sx-0000Un-9v
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:34:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ce3Sw-0001Rz-B3
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:34:07 -0500
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-10-git-send-email-kwolf@redhat.com>
	<0867a10b-b21f-da63-fb82-b1dd5cd38386@redhat.com>
	<20170215172941.GK4935@noname.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ae3b58fa-1ba0-b309-fc76-0b94cdc7e567@redhat.com>
Date: Wed, 15 Feb 2017 18:33:56 +0100
MIME-Version: 1.0
In-Reply-To: <20170215172941.GK4935@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iwj0WWBqPnIr4LN3vTLc2LNcHaP67DBmf"
Subject: Re: [Qemu-devel] [RFC PATCH 09/41] block: Default
 .bdrv_child_perm() for format drivers
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
--iwj0WWBqPnIr4LN3vTLc2LNcHaP67DBmf
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, famz@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <ae3b58fa-1ba0-b309-fc76-0b94cdc7e567@redhat.com>
Subject: Re: [RFC PATCH 09/41] block: Default .bdrv_child_perm() for format
 drivers
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
 <1487006583-24350-10-git-send-email-kwolf@redhat.com>
 <0867a10b-b21f-da63-fb82-b1dd5cd38386@redhat.com>
 <20170215172941.GK4935@noname.redhat.com>
In-Reply-To: <20170215172941.GK4935@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 15.02.2017 18:29, Kevin Wolf wrote:
> Am 15.02.2017 um 18:11 hat Max Reitz geschrieben:
>> On 13.02.2017 18:22, Kevin Wolf wrote:
>>> Almost all format drivers have the same characteristics as far as
>>> permissions are concerned: They have one or more children for storing=

>>> their own data and, more importantly, metadata (can be written to and=

>>> grow even without external write requests, must be protected against
>>> other writers and present consistent data) and optionally a backing f=
ile
>>> (this is just data, so like for a filter, it only depends on what the=

>>> parent nodes need).
>>>
>>> This provides a default implementation that can be shared by most of
>>> our format drivers.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  block.c                   | 37 +++++++++++++++++++++++++++++++++++++=

>>>  include/block/block_int.h |  8 ++++++++
>>>  2 files changed, 45 insertions(+)
>>>
>>> diff --git a/block.c b/block.c
>>> index 290768d..8e99bb5 100644
>>> --- a/block.c
>>> +++ b/block.c
>>> @@ -1459,6 +1459,43 @@ void bdrv_filter_default_perms(BlockDriverStat=
e *bs, BdrvChild *c,
>>>                 (c->shared_perm & DEFAULT_PERM_UNCHANGED);
>>>  }
>>> =20
>>> +void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
>>> +                               const BdrvChildRole *role,
>>> +                               uint64_t perm, uint64_t shared,
>>> +                               uint64_t *nperm, uint64_t *nshared)
>>> +{
>>> +    bool backing =3D (role =3D=3D &child_backing);
>>> +    assert(role =3D=3D &child_backing || role =3D=3D &child_file);
>>> +
>>> +    if (!backing) {
>>> +        /* Apart from the modifications below, the same permissions =
are
>>> +         * forwarded and left alone as for filters */
>>> +        bdrv_filter_default_perms(bs, c, role, perm, shared, &perm, =
&shared);
>>> +
>>> +        /* Format drivers may touch metadata even if the guest doesn=
't write */
>>> +        if (!bdrv_is_read_only(bs)) {
>>> +            perm |=3D BLK_PERM_WRITE | BLK_PERM_RESIZE;
>>> +        }
>>> +
>>> +        /* bs->file always needs to be consistent because of the met=
adata. We
>>> +         * can never allow other users to resize or write to it. */
>>> +        perm |=3D BLK_PERM_CONSISTENT_READ;
>>> +        shared &=3D ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
>>> +    } else {
>>> +        /* We want consistent read from backing files if the parent =
needs it.
>>> +         * No other operations are performed on backing files. */
>>> +        perm &=3D BLK_PERM_CONSISTENT_READ;
>>> +
>>> +        /* If the parent can deal with changing data, we're okay wit=
h a
>>> +         * writable backing file. */
>>
>> Are we OK with a resizable backing file, too? I'm not sure, actually.
>> Maybe we should just forbid it and hope nobody asks for it.
>=20
> That's pretty much the same thought that I had, so unless I'm mistaken,=

> this is exactly what the patch implements.

Yes, it is. I'm just dumping random thoughts. :-)

> I can't think of a reason why resizing a backing file would hurt as lon=
g
> as the parent allows writes to the backing file (though we might have t=
o
> audit that no driver caches the backing file size), but then I can't
> think of a reason either why anyone would want to do this.
>=20
> If we ever find out that there is a good reason, we can still change it=
=2E
>=20
> ...
>=20
> Hm, scratch that. I guess a commit block job with a smaller backing fil=
e
> is enough... Good thing that I neglected to get the RESIZE permission
> for s->base there. :-)

TIL commit resizes the base in that case.

Max


--iwj0WWBqPnIr4LN3vTLc2LNcHaP67DBmf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlikkQQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AO3gIAK9WUBZewAfr0xobz4FBbHtnSbc6GXW3
IlIiMIEfbdpnzofPVhne7NvKtW/wpIo1x1qbWJvZL6HKGEHvrUzeUGD3moV/Rye0
qZwGyGJ85BrpSFSZLMiOa2a/WI0W2jrwo7FJJcrvrG0SrTUOyTST3CBowlhBK+GP
8+aY0rw6gSF5yHtdyYQ3P4M3wYyMn1qtTmWZIcA9QHolkqCm2cdocKzIEk95g8tn
io72aD5eFXnc6NUI8MsP4d5wlJxgqB5EX4QQOG1h1Bilr6oyMpPSel3K5EQchSWG
8VTFhrrOql3e6XJ8+m9LEtTnOznlunWoQQv123gcrRItWqRYLFFk22w=
=dMU4
-----END PGP SIGNATURE-----

--iwj0WWBqPnIr4LN3vTLc2LNcHaP67DBmf--
