Received: from eggs.gnu.org ([2001:4830:134:3::10]:51098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehG34-0000T9-1L
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:41:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehG2z-0001Xo-R2
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:41:10 -0500
References: <1517494591-39369-1-git-send-email-anton.nefedov@virtuozzo.com>
	<3ad2256a-01cd-6c9b-9a34-663aa077f26f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <87883f3d-9098-2233-b643-c310c9ae2d23@redhat.com>
Date: Thu, 1 Feb 2018 08:40:51 -0600
MIME-Version: 1.0
In-Reply-To: <3ad2256a-01cd-6c9b-9a34-663aa077f26f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nYvmfR7JVju9Oq52C8EelIbLo2x5OsGTF"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: fix write with zero
 flag set and iovector provided
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nYvmfR7JVju9Oq52C8EelIbLo2x5OsGTF
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, stefanha@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com
Message-ID: <87883f3d-9098-2233-b643-c310c9ae2d23@redhat.com>
Subject: Re: [Qemu-block] [Qemu-devel] [PATCH] block: fix write with zero flag
 set and iovector provided
References: <1517494591-39369-1-git-send-email-anton.nefedov@virtuozzo.com>
 <3ad2256a-01cd-6c9b-9a34-663aa077f26f@redhat.com>
In-Reply-To: <3ad2256a-01cd-6c9b-9a34-663aa077f26f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/01/2018 08:36 AM, Eric Blake wrote:
> On 02/01/2018 08:16 AM, Anton Nefedov wrote:
>> The normal bdrv_co_pwritev() use is either
>>   - BDRV_REQ_ZERO_WRITE reset and iovector provided
>=20
> s/reset/clear/
>=20
>>   - BDRV_REQ_ZERO_WRITE set and iovector =3D=3D NULL
>>
>> while
>>   - the flag reset and iovector =3D=3D NULL is an assertion failure
>=20
> again
>=20
>>     in bdrv_co_do_zero_pwritev()
>>   - the flag set and iovector provided is in fact allowed
>>     (the flag prevails and zeroes are written)
>>
>> However the alignment logic does not support the latter case so the pa=
dding
>> areas get overwritten with zeroes.
>>
>> Solution could be to forbid such case or just use bdrv_co_do_zero_pwri=
tev()
>> alignment for it which also makes the code a bit more obvious anyway.
>>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> ---
>>  block/io.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/io.c b/block/io.c
>> index 7ea4023..cf63fd0 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -1701,7 +1701,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *chil=
d,
>>       */
>>      tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_WRITE=
);
>> =20
>> -    if (!qiov) {
>> +    if (flags & BDRV_REQ_ZERO_WRITE) {
>>          ret =3D bdrv_co_do_zero_pwritev(child, offset, bytes, flags, =
&req);
>=20
> So now, the flag rules, but we assert that !qiov (so it would only brea=
k
> a caller that passed the flag but used qiov, which you argued shouldn't=

> exist).

Sorry, I hit send too soon.  I'm asking if we should have assert(!qiov)
right before calling bdrv_co_do_zero_pwritev (it would break a caller
that passed the flag and qiov, but you were arguing that such callers
previously misbehaved, so we don't want such callers).

But adding such an assertion may trigger failures that we'd have to fix,
while leaving things without the assertion conservatively seems okay.

>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nYvmfR7JVju9Oq52C8EelIbLo2x5OsGTF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpzJvMACgkQp6FrSiUn
Q2oXygf/abLHJ7CtrXl+m9p/QrkCbm1nFZO80OSTkNrEmh7RZYOdx+s4zdbsW4wO
Ko9VrGyl8q2BSKIW79+l9nnGn6mPvHnAKpWz+VeOvw9vF4F9hQ42tehG2f/WMDZy
L+S4PhpUY1k4t48TlHRUwo1ZBJUeo2OG/EYCTdMJRrIxujqDm+1W7/Cn13qHIIOe
WJBH7km/zuQD4hGLz2ePWtKHrxxBb8JOPD8lISeMGhjeVN1k0EQRJ5dyUFtMcQGG
gFkFfvD8BdujjtjLPbXrZRj9u3pVG4btr4BYMTCCfDHXH5ZPKrnmX1RqcYyvoMSF
yYCX1S7fKyENjGAlIuuVFImwZ8hpMw==
=NRaC
-----END PGP SIGNATURE-----

--nYvmfR7JVju9Oq52C8EelIbLo2x5OsGTF--
