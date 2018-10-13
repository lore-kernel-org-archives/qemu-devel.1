Received: from eggs.gnu.org ([2001:4830:134:3::10]:58542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gBJOF-0007j0-3d
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 08:51:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gBJOE-0000bM-2r
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 08:51:31 -0400
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
	<20180817122219.16206-8-vsementsov@virtuozzo.com>
	<d78f37ac-343d-20bf-a2ce-16ff2fa12677@redhat.com>
	<a02a1caf-53f5-e20a-93a4-67233032d76e@virtuozzo.com>
	<b78b66f6-018d-0ec9-a33a-3b8263867b8b@redhat.com>
	<04c11931-57be-d890-635a-178db8ab1468@virtuozzo.com>
	<d1ccc5e0-03fb-32a6-d99f-3eea28b273ed@redhat.com>
	<8dd2d90f-453b-aade-fbf3-ef8616a00ff8@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <20f9f207-c8b4-1955-e6d0-222de58ef08d@redhat.com>
Date: Sat, 13 Oct 2018 14:51:18 +0200
MIME-Version: 1.0
In-Reply-To: <8dd2d90f-453b-aade-fbf3-ef8616a00ff8@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qlbY04dbFgZXXFYknnAHOKus73l2e9aiq"
Subject: Re: [Qemu-devel] [PATCH v2 7/7] block/qcow2-refcount: fix
 out-of-file L2 entries to be read-as-zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qlbY04dbFgZXXFYknnAHOKus73l2e9aiq
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>
Message-ID: <20f9f207-c8b4-1955-e6d0-222de58ef08d@redhat.com>
Subject: Re: [PATCH v2 7/7] block/qcow2-refcount: fix out-of-file L2 entries
 to be read-as-zero
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
 <20180817122219.16206-8-vsementsov@virtuozzo.com>
 <d78f37ac-343d-20bf-a2ce-16ff2fa12677@redhat.com>
 <a02a1caf-53f5-e20a-93a4-67233032d76e@virtuozzo.com>
 <b78b66f6-018d-0ec9-a33a-3b8263867b8b@redhat.com>
 <04c11931-57be-d890-635a-178db8ab1468@virtuozzo.com>
 <d1ccc5e0-03fb-32a6-d99f-3eea28b273ed@redhat.com>
 <8dd2d90f-453b-aade-fbf3-ef8616a00ff8@virtuozzo.com>
In-Reply-To: <8dd2d90f-453b-aade-fbf3-ef8616a00ff8@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09.10.18 01:14, Vladimir Sementsov-Ogievskiy wrote:
>=20
>=20
> On 10/09/2018 01:21 AM, Max Reitz wrote:
>> On 09.10.18 00:14, Vladimir Sementsov-Ogievskiy wrote:
>>>
>>>
>>> On 10/09/2018 01:08 AM, Max Reitz wrote:
>>>> On 09.10.18 00:02, Vladimir Sementsov-Ogievskiy wrote:
>>>>>
>>>>>
>>>>> On 10/08/2018 11:51 PM, Max Reitz wrote:
>>>>>> On 17.08.18 14:22, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>> Rewrite corrupted L2 table entry, which reference space out of
>>>>>>> underlying file.
>>>>>>>
>>>>>>> Make this L2 table entry read-as-all-zeros without any allocation=
=2E
>>>>>>>
>>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo=
=2Ecom>
>>>>>>> ---
>>>>>>>     block/qcow2-refcount.c | 32 ++++++++++++++++++++++++++++++++
>>>>>>>     1 file changed, 32 insertions(+)
>>>>>>>
>>>>>>> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
>>>>>>> index 3c004e5bfe..3de3768a3c 100644
>>>>>>> --- a/block/qcow2-refcount.c
>>>>>>> +++ b/block/qcow2-refcount.c
>>>>>>> @@ -1720,8 +1720,30 @@ static int check_refcounts_l2(BlockDriverS=
tate *bs, BdrvCheckResult *res,
>>>>>>>                 /* Mark cluster as used */
>>>>>>>                 csize =3D (((l2_entry >> s->csize_shift) & s->csi=
ze_mask) + 1) *
>>>>>>>                         BDRV_SECTOR_SIZE;
>>>>>>> +            if (csize > s->cluster_size) {
>>>>>>> +                ret =3D fix_l2_entry_to_zero(
>>>>>>> +                        bs, res, fix, l2_offset, i, active,
>>>>>>> +                        "compressed cluster larger than cluster:=
 size 0x%"
>>>>>>> +                        PRIx64, csize);
>>>>>>> +                if (ret < 0) {
>>>>>>> +                    goto fail;
>>>>>>> +                }
>>>>>>> +                continue;
>>>>>>> +            }
>>>>>>> +
>>>>>>
>>>>>> This seems recoverable, isn't it?  Can we not try to just limit th=
e
>>>>>> csize, or decompress the cluster with the given csize from the giv=
en
>>>>>> offset, disregarding the cluster limit?
>>>>>
>>>>> Hm, you want to assume that csize is corrupted but coffset may be
>>>>> correct? Unlikely, I think.
>>>>
>>>> Better to reconstruct probably garbage data than to definitely garba=
ge
>>>> data (all zeroes) is what I think.
>>>>
>>>>> So, to carefully repair csize, we should decompress one cluster (or=
 one
>>>>> cluster - 1 byte) of data, trying to get one cluster of decompresse=
d
>>>>> data. If we succeed, we know csize, or we can safely set it to one =
cluster.
>>>>
>>>> Yes.
>>>>
>>>>> Or we can just set csize =3D 1 cluster, if it is larger. And leave
>>>>> problems to real execution which will lead to EIO in worst case.
>>>>
>>>> Or this, yes.
>>>>
>>>>>>>                 coffset =3D l2_entry & s->cluster_offset_mask &
>>>>>>>                           ~(BDRV_SECTOR_SIZE - 1);
>>>>>>> +            if (coffset >=3D bdrv_getlength(bs->file->bs)) {
>>>>>>> +                ret =3D fix_l2_entry_to_zero(
>>>>>>> +                        bs, res, fix, l2_offset, i, active,
>>>>>>> +                        "compressed cluster out of file: offset =
0x%" PRIx64,
>>>>>>> +                        coffset);
>>>>>>> +                if (ret < 0) {
>>>>>>> +                    goto fail;
>>>>>>> +                }
>>>>>>> +                continue;
>>>>>>> +            }
>>>>>>> +
>>>>>>>                 ret =3D qcow2_inc_refcounts_imrt(bs, res,
>>>>>>>                                                refcount_table, re=
fcount_table_size,
>>>>>>>                                                coffset, csize);
>>>>>>> @@ -1748,6 +1770,16 @@ static int check_refcounts_l2(BlockDriverS=
tate *bs, BdrvCheckResult *res,
>>>>>>>             {
>>>>>>>                 uint64_t offset =3D l2_entry & L2E_OFFSET_MASK;
>>>>>>>    =20
>>>>>>> +            if (offset >=3D bdrv_getlength(bs->file->bs)) {
>>>>>>> +                ret =3D fix_l2_entry_to_zero(
>>>>>>> +                        bs, res, fix, l2_offset, i, active,
>>>>>>> +                        "cluster out of file: offset 0x%" PRIx64=
, offset);
>>>>>>> +                if (ret < 0) {
>>>>>>> +                    goto fail;
>>>>>>> +                }
>>>>>>> +                continue;
>>>>>>> +            }
>>>>>>> +
>>>>>>
>>>>>> These other two look OK, but they have another issue:  If this is =
a v2
>>>>>> image, you cannot create zero clusters; so you'll have to unalloca=
te the
>>>>>> cluster in that case.
>>>>>
>>>>>
>>>>> Oho, it's a problem. It may be unsafe to discard clusters, making
>>>>> backing image available through the holes. What discard do on v2?
>>>>> Zeroing or holes?
>>>>
>>>> Oh, right!  discard on v2 punches a hole.  So I see three ways:
>>>> (1) You can do the same and point to that bit of code, or
>>>> (2) You allocate a data cluster full of zeroes in case of v2, or
>>>> (3) You just error out.
>>>>
>>>> (3) doesn't seem like the worst option.
>>>
>>>> Amending the image to be v3 is
>>>> always possible and trivial.
>>>
>>> how to do it for corrupted image?
>>
>> Oh, yeah, you can't open a corrupted image, can you...  I suppose we
>> want a way to force-clear the flag anyway. :-)
>=20
> am, which flag?

The corrupt flag in the image header.

Max


--qlbY04dbFgZXXFYknnAHOKus73l2e9aiq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvB6kYACgkQ9AfbAGHV
z0B9wQgAvUnOoqIpI+37WwspYdb0POzgkiRrsbgrtf9Uw2pBcQC1pPYmC6xHyalu
Vuhh2mrc2GHBpTfLmT3RpsmLTTA739/Ucxm7NPnSd3Ee0K3+txGM05sSFHPfd96i
F4v2cg8vmsc4bP6UDtCzzTFooUR3i9EJIYKND42+ulbF79jREQRziiEwrGsJLCcz
Xqysz31DUgwXJ55eXVhi54EM4zqMIVnVTX/VJAXz38VviZbZGcVapogFPs7iniJO
BJB0n0rY79k45RWS5GadAop8SPwZa0+JJMXN3Gp4rmf7bTORm5lEPNuraB+8KM5n
7dHfFl1Fb5iUi2oiPhbmBX8Mx/x96w==
=KwGG
-----END PGP SIGNATURE-----

--qlbY04dbFgZXXFYknnAHOKus73l2e9aiq--
