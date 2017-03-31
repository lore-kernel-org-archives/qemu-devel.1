Received: from eggs.gnu.org ([2001:4830:134:3::10]:42909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctxyh-0003go-Hr
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:56:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctxyg-0005vC-Dp
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:56:39 -0400
References: <1490965980-513-1-git-send-email-peter.maydell@linaro.org>
	<9e359c38-a2aa-64e8-6c7c-0b793d2f2bb4@redhat.com>
	<682f7310-d197-70e5-075a-2bec7a3e5c62@openvz.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3fcf3715-3db4-acd4-52a2-6b74c6c2b495@redhat.com>
Date: Fri, 31 Mar 2017 16:56:26 +0200
MIME-Version: 1.0
In-Reply-To: <682f7310-d197-70e5-075a-2bec7a3e5c62@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NpbAgmuh0wmbdOsgQeddsqR0rOmjJbsUU"
Subject: Re: [Qemu-devel] [PATCH] block/parallels.c: avoid integer overflow
 in allocate_clusters()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NpbAgmuh0wmbdOsgQeddsqR0rOmjJbsUU
From: Max Reitz <mreitz@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <3fcf3715-3db4-acd4-52a2-6b74c6c2b495@redhat.com>
Subject: Re: [PATCH] block/parallels.c: avoid integer overflow in
 allocate_clusters()
References: <1490965980-513-1-git-send-email-peter.maydell@linaro.org>
 <9e359c38-a2aa-64e8-6c7c-0b793d2f2bb4@redhat.com>
 <682f7310-d197-70e5-075a-2bec7a3e5c62@openvz.org>
In-Reply-To: <682f7310-d197-70e5-075a-2bec7a3e5c62@openvz.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 31.03.2017 16:54, Denis V. Lunev wrote:
> On 03/31/2017 04:47 PM, Max Reitz wrote:
>> On 31.03.2017 15:13, Peter Maydell wrote:
>>> Coverity (CID 1307776) points out that in the multiply:
>>>   space =3D to_allocate * s->tracks;
>>> we are trying to calculate a 64 bit result but the types
>>> of to_allocate and s->tracks mean that we actually calculate
>>> a 32 bit result. Add an explicit cast to force a 64 bit
>>> multiply.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>> NB: compile-and-make-check tested only...
>>> ---
>>>  block/parallels.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/block/parallels.c b/block/parallels.c
>>> index 4173b3f..3886c30 100644
>>> --- a/block/parallels.c
>>> +++ b/block/parallels.c
>>> @@ -206,7 +206,7 @@ static int64_t allocate_clusters(BlockDriverState=
 *bs, int64_t sector_num,
>>>      }
>>> =20
>>>      to_allocate =3D DIV_ROUND_UP(sector_num + *pnum, s->tracks) - id=
x;
>>> -    space =3D to_allocate * s->tracks;
>>> +    space =3D (int64_t)to_allocate * s->tracks;
>>>      if (s->data_end + space > bdrv_getlength(bs->file->bs) >> BDRV_S=
ECTOR_BITS) {
>>>          int ret;
>>>          space +=3D s->prealloc_size;
>> I think the division is technically fine because to_allocate will
>> roughly be *pnum / s->tracks (and since *pnum is an int, the
>> multiplication cannot overflow).
>>
>> However, it's still good to fix this, but I would do it differently:
>> Make idx, to_allocate, and i all uint64_t or int64_t instead of
>> uint32_t. This would also prevent accidental overflow when storing the=

>> result of the division in:
>>
>> idx =3D sector_num / s->tracks;
>> if (idx >=3D s->bat_size) {
>>     [...]
>>
>> The much greater problem to me appears to be that we don't check that
>> idx + to_allocate <=3D s->bat_size. I'm not sure whether there can be =
a
>> buffer overflow in the for loop below, but I'm not sure I really want =
to
>> know either... I think the block_status() call limits *pnum so that
>> there will not be an overflow, but then we should at least assert this=
=2E
>>
>> Max
>>
> technically we are protected by the check in
>=20
> static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
>     BdrvTrackedRequest *req, int64_t offset, unsigned int bytes,
>     int64_t align, QEMUIOVector *qiov, int flags)
> ...
>     /* Forward the request to the BlockDriver, possibly fragmenting it =
*/
>     total_bytes =3D bdrv_getlength(bs);
>     if (total_bytes < 0) {
>         ret =3D total_bytes;
>         goto out;
>     }
>=20
>     max_bytes =3D ROUND_UP(MAX(0, total_bytes - offset), align);
>     if (bytes <=3D max_bytes && bytes <=3D max_transfer) {
>         ret =3D bdrv_driver_preadv(bs, offset, bytes, qiov, 0);
>         goto out;
>     }
>=20
> which guarantees that the request is always inside the length of the
> device. Thus we should be on the safe side with the mentioned
> access as bat_size is calculated from the size of the entire virtual
> disk.

Right, but then we wouldn't need the check on idx. With the way things
are, it looks a bit confusing. Maybe we should just make it an assertion?=


assert(idx < s->bat_size && idx + to_allocate <=3D s->bat_size);

Max


--NpbAgmuh0wmbdOsgQeddsqR0rOmjJbsUU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljebhoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AcHsIAIvJP+C04J22Vq2RVi5X3w9knPoS+RLp
LXJ8oXj3MqI7qqlK10nTd38fGP0L7TI9OiAiYZIJ3mvvH/YcQKRA3tF5rvjHcEH+
UV9Jf6Fp8dsTAkiBdtRGSlAb3/Fxhvjabsn4VKIiOUDGMcJuX1O6qUtH9BZ8+TPe
R9glaUH+QPOIzUITlafRD2nSYyhjDMshpGHBzsrdD+RECEFWvC4w20IyQKBrWqLH
Anvp6swz0ouczvBr5YJdcfYjC2UXpY0ruBVRiZrKe3kYZQNz5WqZ84HQR6UKswgQ
SFyZlkltpk+zpFtmI64myCteu5UUHV2xmtfYG3dPMffRSa1BUr7nexc=
=4rWn
-----END PGP SIGNATURE-----

--NpbAgmuh0wmbdOsgQeddsqR0rOmjJbsUU--
