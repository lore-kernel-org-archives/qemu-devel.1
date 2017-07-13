Received: from eggs.gnu.org ([2001:4830:134:3::10]:35773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVfYI-0006GB-HN
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVfYH-0004Mi-ID
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:57:14 -0400
References: <20170707203049.534-1-eblake@redhat.com>
	<20170707203049.534-2-eblake@redhat.com>
	<b4c5c384-d759-44f8-bc9a-41f619133a83@virtuozzo.com>
	<91f92ed8-cc6d-d4d6-d217-95d91f6bea7c@virtuozzo.com>
	<1dba6465-b2b4-b3f9-d1f6-54437ccae9e0@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <278f74d6-0ac7-ad54-2e0d-d1f47fe252a1@redhat.com>
Date: Thu, 13 Jul 2017 16:56:54 +0200
MIME-Version: 1.0
In-Reply-To: <1dba6465-b2b4-b3f9-d1f6-54437ccae9e0@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rE8xRGS06jg3DRgg6iBb6ETOvQnd8LQNV"
Subject: Re: [Qemu-devel] [PATCH v5 1/9] nbd: Create struct for tracking
 export info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: den@virtuozzo.com, marcandre.lureau@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rE8xRGS06jg3DRgg6iBb6ETOvQnd8LQNV
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: den@virtuozzo.com, marcandre.lureau@redhat.com, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <278f74d6-0ac7-ad54-2e0d-d1f47fe252a1@redhat.com>
Subject: Re: [PATCH v5 1/9] nbd: Create struct for tracking export info
References: <20170707203049.534-1-eblake@redhat.com>
 <20170707203049.534-2-eblake@redhat.com>
 <b4c5c384-d759-44f8-bc9a-41f619133a83@virtuozzo.com>
 <91f92ed8-cc6d-d4d6-d217-95d91f6bea7c@virtuozzo.com>
 <1dba6465-b2b4-b3f9-d1f6-54437ccae9e0@redhat.com>
In-Reply-To: <1dba6465-b2b4-b3f9-d1f6-54437ccae9e0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13/07/2017 16:35, Eric Blake wrote:
> On 07/13/2017 07:31 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 13.07.2017 15:09, Vladimir Sementsov-Ogievskiy wrote:
>>> 07.07.2017 23:30, Eric Blake wrote:
>>>> The NBD Protocol is introducing some additional information
>>>> about exports, such as minimum request size and alignment, as
>>>> well as an advertised maximum request size.  It will be easier
>>>> to feed this information back to the block layer if we gather
>>>> all the information into a struct, rather than adding yet more
>>>> pointer parameters during negotiation.
>>>
>>> // it was me who do so)
>>>
>=20
>>>> +int nbd_init(int fd, QIOChannelSocket *sioc, NBDExportInfo *info,
>>>>                Error **errp)
>>>>   {
>>>> -    unsigned long sectors =3D size / BDRV_SECTOR_SIZE;
>>>> -    if (size / BDRV_SECTOR_SIZE !=3D sectors) {
>>>> -        error_setg(errp, "Export size %lld too large for 32-bit
>>>> kernel",
>>>> -                   (long long) size);
>>>> +    unsigned long sectors =3D info->size / BDRV_SECTOR_SIZE;
>>>> +    if (info->size / BDRV_SECTOR_SIZE !=3D sectors) {
>>>> +        error_setg(errp, "Export size %" PRId64 " too large for
>>>> 32-bit kernel",
>>>
>>> should be PRIu64
>=20
> Even with an unsigned size, we can't support more than the maximum off_=
t
> (2^63-1) rather than the full uint64_t range (2^64-1).  Any positive
> size prints the same, and if any caller is passing in a negative size,
> things are already weird.  But you are correct that matching unsigned t=
o
> PRIu64 is nicer, even if we already make blatant assumptions that all
> platforms that qemu runs on can interchange signedness in printf withou=
t
> repercussion.
>=20
>>>
>>>> +                   info->size);
>>>>           return -E2BIG;
>>>>       }
>>>>
>>> [...]
>>>
>>
>> with fixed:
>>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> (if it is not too late ;)
>=20
> Depends on whether Paolo wants to send a v2 pull request omitting the
> NBD stuff (in which case I'll submit a separate NBD pull request), or
> whether we just let the pull request happen (in which case I'll submit
> followup patches to address your reviews).  It's slightly cleaner to ge=
t
> it right from the get-go, but followups are better than nothing, so I'm=

> not too fussed either way.

I've fixed the PRIu64 already when applying (and also the tracepoint in
patch 2).

Paolo



--rE8xRGS06jg3DRgg6iBb6ETOvQnd8LQNV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAllnijYACgkQv/vSX3jH
roOC9wf7BmuYb5LmYEdMWlQwgTe/WTrP9Y+UHaQEPMr8moXsU0UJT0p6ZVpDpI4h
VL5alsA05R+ex8RQfxyryR2mWyFsW2U9V/dx0bePAE/mYvdAHcFHdwC7vfpRMFGs
WADRiBZjzLba00whmqld+sJERKK8OP1P8mhV2zhHAUfhj/04DBYBR/PWxzWLM8TS
rV8VkGcPzOwnrWlamiF8KN1pvi0HkGLzowCoYaE4bLVZMlcCxp+XngJ/Oz3QtaP2
W4/cd1CPzj7xo7XkYUBZb/BzvmQ8OkoGRJQGgyHcGTSATMqYJvRS3aQyFd+0lZ7U
mYziP7Gms7NPTaktdJuGF2ggb/zIDg==
=EkID
-----END PGP SIGNATURE-----

--rE8xRGS06jg3DRgg6iBb6ETOvQnd8LQNV--
