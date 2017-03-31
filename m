Received: from eggs.gnu.org ([2001:4830:134:3::10]:53674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctzc6-0002QY-8K
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 12:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctzc5-0008MG-Bu
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 12:41:26 -0400
References: <1490965980-513-1-git-send-email-peter.maydell@linaro.org>
	<9e359c38-a2aa-64e8-6c7c-0b793d2f2bb4@redhat.com>
	<20170331162043.GB18974@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <41840a4e-54e4-d2f4-296d-ad016717a0fb@redhat.com>
Date: Fri, 31 Mar 2017 18:41:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170331162043.GB18974@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0ENmfWtXul5f32WqdPfnIufsdc4f5Ir55"
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, patches@linaro.org, "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0ENmfWtXul5f32WqdPfnIufsdc4f5Ir55
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 patches@linaro.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <41840a4e-54e4-d2f4-296d-ad016717a0fb@redhat.com>
Subject: Re: [PATCH] block/parallels.c: avoid integer overflow in
 allocate_clusters()
References: <1490965980-513-1-git-send-email-peter.maydell@linaro.org>
 <9e359c38-a2aa-64e8-6c7c-0b793d2f2bb4@redhat.com>
 <20170331162043.GB18974@stefanha-x1.localdomain>
In-Reply-To: <20170331162043.GB18974@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 31.03.2017 18:20, Stefan Hajnoczi wrote:
> On Fri, Mar 31, 2017 at 03:47:39PM +0200, Max Reitz wrote:
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
>>
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
>=20
> Will you send a new patch that supercedes this one?

Well, since you're asking so nicely...

Max


--0ENmfWtXul5f32WqdPfnIufsdc4f5Ir55
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljehqYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AZ9EH+gNPqWTVe7UXyw0zc81pzfpLHtSJgeJT
E7ry31aAYUQY6ICJ0smoElOp/JvA5W62G+s+k9ngiuwoBkNLRm7IBhAHmePwceuX
eKhNsVYsy+zlw5icixRitWwcoWgsEBrA3aUmHtOpaM8FH1Hj1z7nqz/gVtBULjLy
7HVgKN4FA7JUzkK5wiDy2GklutrtTPwIjGW9spNdLs7maMAELIF0pV2aLB4qOf0L
cNT88/GFy+gFJB04KB753PPijvmSbg5c+RiQiidhR/l0IrAIcRAuHHG+AwL1qGoK
MYLcriRtrR1qb/4NQX9mbmKYPGFPFdQ04O41oNHNSG+2WLCOkrUKqfg=
=NqzU
-----END PGP SIGNATURE-----

--0ENmfWtXul5f32WqdPfnIufsdc4f5Ir55--
