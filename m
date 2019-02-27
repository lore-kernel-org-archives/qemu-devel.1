Received: from eggs.gnu.org ([209.51.188.92]:46366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyzDp-0002OW-D0
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:26:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyzDn-0001DD-AY
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:26:05 -0500
References: <20181214134240.217870-1-vsementsov@virtuozzo.com>
	<20181214134240.217870-6-vsementsov@virtuozzo.com>
	<15e27f9f-8788-66ce-7843-0922662e42b1@redhat.com>
	<1b6f86f0-1bf5-f306-b24a-ed37c3d9016a@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c097c89c-40ef-d3a5-ac4e-7adec1841029@redhat.com>
Date: Wed, 27 Feb 2019 13:48:41 +0100
MIME-Version: 1.0
In-Reply-To: <1b6f86f0-1bf5-f306-b24a-ed37c3d9016a@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Dwyj2hlxslYBTttqwJNZEXm4ChaX8snBy"
Subject: Re: [Qemu-devel] [PATCH v4 5/5] qcow2-refcount: don't mask
 corruptions under internal errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Dwyj2hlxslYBTttqwJNZEXm4ChaX8snBy
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>
Message-ID: <c097c89c-40ef-d3a5-ac4e-7adec1841029@redhat.com>
Subject: Re: [PATCH v4 5/5] qcow2-refcount: don't mask corruptions under
 internal errors
References: <20181214134240.217870-1-vsementsov@virtuozzo.com>
 <20181214134240.217870-6-vsementsov@virtuozzo.com>
 <15e27f9f-8788-66ce-7843-0922662e42b1@redhat.com>
 <1b6f86f0-1bf5-f306-b24a-ed37c3d9016a@virtuozzo.com>
In-Reply-To: <1b6f86f0-1bf5-f306-b24a-ed37c3d9016a@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.02.19 13:47, Vladimir Sementsov-Ogievskiy wrote:
> 27.02.2019 15:42, Max Reitz wrote:
>> On 14.12.18 14:42, Vladimir Sementsov-Ogievskiy wrote:
>>> No reasons for not reporting found corruptions as corruptions in case=

>>> of some internal errors, especially in case of just failed to fix l2
>>> entry (and in this case, missed corruptions may influence comparing
>>> logic, when we calculate difference between corruptions fields of two=

>>> results)
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>   block/qcow2-refcount.c | 31 ++++++++++++++-----------------
>>>   1 file changed, 14 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
>>> index 8da0e91dd3..b0e006e628 100644
>>> --- a/block/qcow2-refcount.c
>>> +++ b/block/qcow2-refcount.c
>>
>> [...]
>>
>>> @@ -1899,19 +1899,16 @@ static int check_oflag_copied(BlockDriverStat=
e *bs, BdrvCheckResult *res,
>>>                       fprintf(stderr, "%s OFLAG_COPIED data cluster: =
"
>>>                               "l2_entry=3D%" PRIx64 " refcount=3D%" P=
RIu64 "\n",
>>>                               repair ? "Repairing" : "ERROR", l2_entr=
y, refcount);
>>> -                    if (repair) {
>>> -                        l2_table[j] =3D cpu_to_be64(refcount =3D=3D =
1
>>> -                                    ? l2_entry |  QCOW_OFLAG_COPIED
>>> -                                    : l2_entry & ~QCOW_OFLAG_COPIED)=
;
>>> -                        l2_dirty++;
>>> -                    } else {
>>> -                        res->corruptions++;
>>> -                    }
>>> +                    l2_table[j] =3D cpu_to_be64(refcount =3D=3D 1
>>> +                                ? l2_entry |  QCOW_OFLAG_COPIED
>>> +                                : l2_entry & ~QCOW_OFLAG_COPIED);
>>> +                    l2_dirty++;
>>
>> I found the old logic to be easier to understand, actually.  It made i=
t
>> clear that if !repair, the L2 table is not going to be touched.
>>
>> Max
>>
>=20
> so,
>=20
>    if (repair) {
>       keep as is
>    }
>    res->corruptions++;
>=20
> ok?

Yep, that works for me.  Or above the fprintf() as you did it in other
places in this patch.

Max


--Dwyj2hlxslYBTttqwJNZEXm4ChaX8snBy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlx2hykACgkQ9AfbAGHV
z0CRLAgAuSh6PtA1bfg8KgG9t7v1US7ogZn2ysPOHqYEwmYBrTsocC1MNWDYSoX2
+0eLTUADtKDhDQ8Y9laTLLwo34fF5bzaH84f8X9LIjnMsdQ0HU0RCOUHZgMyR7iF
xmGnLSJPQdajLkzLFVWnKDO08FTA5GwWNF9BsvHpwczEc3OZi8B5DM+uNxgGetAl
kr3H5zWWycjTidcJSKeEH0AX/OMHBStS3GTul9CnzgC12FFIfTZCkprED2VrqnxQ
Fw5PVGgFE3A5ErewZpIxed3dX5omgM6x0kk0w/Xm9e5wSzs+VpICril4NPe61BYV
mQwnVRH45qcZkH+Hn3Dd4qkyNXBvQQ==
=qmST
-----END PGP SIGNATURE-----

--Dwyj2hlxslYBTttqwJNZEXm4ChaX8snBy--
