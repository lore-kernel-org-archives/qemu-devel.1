Received: from eggs.gnu.org ([2001:4830:134:3::10]:42534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egwId-0003Ah-LR
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:36:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egwIY-0005qH-Vc
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:35:55 -0500
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516297747-107232-5-git-send-email-anton.nefedov@virtuozzo.com>
	<e6a78f65-3be4-9c14-401c-ea7f1fd5fb9c@redhat.com>
	<931c225d-7d0a-ea1e-59a9-d9f7a257274a@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <58f2d14b-714e-afce-65b4-2ec048aa078e@redhat.com>
Date: Wed, 31 Jan 2018 18:35:41 +0100
MIME-Version: 1.0
In-Reply-To: <931c225d-7d0a-ea1e-59a9-d9f7a257274a@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IM0lmfA8WMcnDIYMdFyHW6H5M8KJtpPoT"
Subject: Re: [Qemu-devel] [PATCH v7 4/9] block: treat BDRV_REQ_ALLOCATE as
 serialising
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IM0lmfA8WMcnDIYMdFyHW6H5M8KJtpPoT
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 den@virtuozzo.com, berto@igalia.com
Message-ID: <58f2d14b-714e-afce-65b4-2ec048aa078e@redhat.com>
Subject: Re: [PATCH v7 4/9] block: treat BDRV_REQ_ALLOCATE as serialising
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1516297747-107232-5-git-send-email-anton.nefedov@virtuozzo.com>
 <e6a78f65-3be4-9c14-401c-ea7f1fd5fb9c@redhat.com>
 <931c225d-7d0a-ea1e-59a9-d9f7a257274a@virtuozzo.com>
In-Reply-To: <931c225d-7d0a-ea1e-59a9-d9f7a257274a@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-30 13:36, Anton Nefedov wrote:
>=20
>=20
> On 29/1/2018 10:48 PM, Max Reitz wrote:
>> On 2018-01-18 18:49, Anton Nefedov wrote:
>>> The idea is that ALLOCATE requests may overlap with other requests.
>>> Reuse the existing block layer infrastructure for serialising request=
s.
>>> Use the following approach:
>>> =C2=A0=C2=A0 - mark ALLOCATE serialising, so subsequent requests to t=
he area wait
>>> =C2=A0=C2=A0 - ALLOCATE request itself must never wait if another req=
uest is in
>>> flight
>>> =C2=A0=C2=A0=C2=A0=C2=A0 already. Return EAGAIN, let the caller recon=
sider.
>>>
>>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>> ---
>>> =C2=A0 block/io.c | 27 +++++++++++++++++++--------
>>> =C2=A0 1 file changed, 19 insertions(+), 8 deletions(-)
>>
>> The basic principle looks good to me.
>>
>>> diff --git a/block/io.c b/block/io.c
>>> index cf2f84c..4b0d34f 100644
>>> --- a/block/io.c
>>> +++ b/block/io.c
>>
>> [...]
>>
>>> @@ -1717,7 +1728,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *chi=
ld,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iovec h=
ead_iov;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mark_re=
quest_serialising(&req, align);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait_serialising_requests=
(&req);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait_serialising_requests=
(&req, false);
>>
>> What if someone calls bdrv_co_pwritev() with BDRV_REQ_ZERO_WRITE |
>> BDRV_REQ_ALLOCATE?=C2=A0=20
>=20
> Either
>=20
> =C2=A0=C2=A0=C2=A0 assert(!(qiov && (flags & BDRV_REQ_ALLOCATE)));
>=20
> will fail or bdrv_co_do_zero_pwritev() will be used.

Ah, right, I didn't see that condition there.

>> .. Then this should do exactly the same as
>> bdrv_co_do_zero_pwritev(), which it currently does not -- besides this=

>> serialization, this includes returning -ENOTSUP if there is a head or
>> tail to write.
>>
>=20
> Another question is if that assertion is ok.
> In other words: should (qiov!=3DNULL && REQ_ALLOCATE) be a valid case?
> e.g. with qiov filled with zeroes?

I think it's OK to leave the assertion that way.  But maybe move it
down, under the bdrv_co_do_zero_pwritev() call (and then omit the qiov
!=3D NULL, because that's guaranteed then)?

(But maybe not everyone's as blind as me.)

> I'd rather document that not supported (and leave the assertion).
>=20
> Actually, even (qiov!=3DNULL && REQ_ZERO_WRITE) looks kind of
> unsupported/broken? Alignment code in bdrv_co_pwritev() zeroes out the
> head and tail by passing the flag down bdrv_aligned_pwritev()

Yes.  Maybe we should have an assertion that you aren't allowed to pass
a qiov with REQ_ZERO_WRITE...

Max


--IM0lmfA8WMcnDIYMdFyHW6H5M8KJtpPoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpx/m0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AEF0H/A/8OL6a+mggaQ8eX7hUB25M6lxWPv8D
sCaFqjfM5hoxf8pTQYXMYga9VL6jY1snw/EwHLHAFJqqo/ThbGD/FA/cgud/+wC2
PyX1sC884lRWKA0+qh7oVgEMuJvMW+7OdptVYq65aIEPGQaYJrWUSZmSPcCdjbcX
JsbkBkdCw3ZCpVwZTa/aEUgCooULhHFoCgdISpCXXFExcwXFRGOo0PArPGbCzeCg
8aWhBnV8m8uN7WGXlVHD7u36nfPbtC7O3w7N7xiYXBTDrWSu8gI5MVDUhot6L/IC
HKFeYGA4NJbJS3SlJ/rNcgNO44dbz51HIBC+kftBzswvxTiCFRNOzVw=
=CWqZ
-----END PGP SIGNATURE-----

--IM0lmfA8WMcnDIYMdFyHW6H5M8KJtpPoT--
