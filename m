Received: from eggs.gnu.org ([2001:4830:134:3::10]:55587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVfDa-00023W-4i
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:35:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVfDY-0000yx-Hm
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:35:50 -0400
References: <20170707203049.534-1-eblake@redhat.com>
	<20170707203049.534-2-eblake@redhat.com>
	<b4c5c384-d759-44f8-bc9a-41f619133a83@virtuozzo.com>
	<91f92ed8-cc6d-d4d6-d217-95d91f6bea7c@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1dba6465-b2b4-b3f9-d1f6-54437ccae9e0@redhat.com>
Date: Thu, 13 Jul 2017 09:35:35 -0500
MIME-Version: 1.0
In-Reply-To: <91f92ed8-cc6d-d4d6-d217-95d91f6bea7c@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WWFhgnEMLJ0Dj37A0vd8v8agw8k7EW3pb"
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@virtuozzo.com, marcandre.lureau@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WWFhgnEMLJ0Dj37A0vd8v8agw8k7EW3pb
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@virtuozzo.com, marcandre.lureau@redhat.com,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <1dba6465-b2b4-b3f9-d1f6-54437ccae9e0@redhat.com>
Subject: Re: [PATCH v5 1/9] nbd: Create struct for tracking export info
References: <20170707203049.534-1-eblake@redhat.com>
 <20170707203049.534-2-eblake@redhat.com>
 <b4c5c384-d759-44f8-bc9a-41f619133a83@virtuozzo.com>
 <91f92ed8-cc6d-d4d6-d217-95d91f6bea7c@virtuozzo.com>
In-Reply-To: <91f92ed8-cc6d-d4d6-d217-95d91f6bea7c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/13/2017 07:31 AM, Vladimir Sementsov-Ogievskiy wrote:
> 13.07.2017 15:09, Vladimir Sementsov-Ogievskiy wrote:
>> 07.07.2017 23:30, Eric Blake wrote:
>>> The NBD Protocol is introducing some additional information
>>> about exports, such as minimum request size and alignment, as
>>> well as an advertised maximum request size.  It will be easier
>>> to feed this information back to the block layer if we gather
>>> all the information into a struct, rather than adding yet more
>>> pointer parameters during negotiation.
>>
>> // it was me who do so)
>>

>>> +int nbd_init(int fd, QIOChannelSocket *sioc, NBDExportInfo *info,
>>>                Error **errp)
>>>   {
>>> -    unsigned long sectors =3D size / BDRV_SECTOR_SIZE;
>>> -    if (size / BDRV_SECTOR_SIZE !=3D sectors) {
>>> -        error_setg(errp, "Export size %lld too large for 32-bit
>>> kernel",
>>> -                   (long long) size);
>>> +    unsigned long sectors =3D info->size / BDRV_SECTOR_SIZE;
>>> +    if (info->size / BDRV_SECTOR_SIZE !=3D sectors) {
>>> +        error_setg(errp, "Export size %" PRId64 " too large for
>>> 32-bit kernel",
>>
>> should be PRIu64

Even with an unsigned size, we can't support more than the maximum off_t
(2^63-1) rather than the full uint64_t range (2^64-1).  Any positive
size prints the same, and if any caller is passing in a negative size,
things are already weird.  But you are correct that matching unsigned to
PRIu64 is nicer, even if we already make blatant assumptions that all
platforms that qemu runs on can interchange signedness in printf without
repercussion.

>>
>>> +                   info->size);
>>>           return -E2BIG;
>>>       }
>>>
>> [...]
>>
>=20
> with fixed:
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> (if it is not too late ;)

Depends on whether Paolo wants to send a v2 pull request omitting the
NBD stuff (in which case I'll submit a separate NBD pull request), or
whether we just let the pull request happen (in which case I'll submit
followup patches to address your reviews).  It's slightly cleaner to get
it right from the get-go, but followups are better than nothing, so I'm
not too fussed either way.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--WWFhgnEMLJ0Dj37A0vd8v8agw8k7EW3pb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZ4U3AAoJEKeha0olJ0Nq3MQH/jVC42vWG1x1LQpAO+e1qyge
337rgzLOcjR5kOR9ahWmZrd/XO3134ptf7f4ZYSI4h633Q1yY8hi3l6H9pUHVHpF
9g6Y5CNv/zDh96E7f369fW8Adn8TTOnbKQFWuvWgj0H/vl01JijckEWqGgj7cPkW
j0itfX6LV9ixKC4yxZFVBQfdJCv9mwLMplsdvvrX0xOwTLhsdyo+oUtrTTjMV6nU
+pybLwDygWse7dBO1qstQofQ11enRuRQz1V5/tZETKBK11wOw4/lFeNd7GX4uEmq
9oMeZnPWokcCeBNnung6UQuIDZLcWXm3zeceYWioYGHiKAMIbJZbMV5sw6dJLA8=
=G3TC
-----END PGP SIGNATURE-----

--WWFhgnEMLJ0Dj37A0vd8v8agw8k7EW3pb--
