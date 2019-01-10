Received: from eggs.gnu.org ([209.51.188.92]:37555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghipX-00077t-Fq
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 17:29:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghipV-00024y-Sq
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 17:29:39 -0500
References: <20190110071330.28136-1-eblake@redhat.com>
	<20190110071330.28136-4-eblake@redhat.com>
	<82d35e0c-6fda-f87b-586b-79952fcb37a3@virtuozzo.com>
	<078428bd-2e1a-a9e0-e580-c2d1dc56e44b@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <80af6d04-0f29-15b5-cd0d-5718b235b298@redhat.com>
Date: Thu, 10 Jan 2019 16:29:22 -0600
MIME-Version: 1.0
In-Reply-To: <078428bd-2e1a-a9e0-e580-c2d1dc56e44b@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KN8a2BcHLmiYBhz0cFiZYYfeg79JLSIZ2"
Subject: Re: [Qemu-devel] [PATCH v2 3/6] nbd: Allow bitmap export during QMP
 nbd-server-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KN8a2BcHLmiYBhz0cFiZYYfeg79JLSIZ2
From: Eric Blake <eblake@redhat.com>
To: Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <80af6d04-0f29-15b5-cd0d-5718b235b298@redhat.com>
Subject: Re: [PATCH v2 3/6] nbd: Allow bitmap export during QMP nbd-server-add
References: <20190110071330.28136-1-eblake@redhat.com>
 <20190110071330.28136-4-eblake@redhat.com>
 <82d35e0c-6fda-f87b-586b-79952fcb37a3@virtuozzo.com>
 <078428bd-2e1a-a9e0-e580-c2d1dc56e44b@virtuozzo.com>
In-Reply-To: <078428bd-2e1a-a9e0-e580-c2d1dc56e44b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/10/19 9:11 AM, Nikolay Shirokovskiy wrote:

>>> The experimental command included an optional 'bitmap-export-name'
>>> field for remapping the name exposed over NBD to be different from
>>> the bitmap name stored on disk.
>>
>>
>> Nikolay, do you have comments on this?
>>
>>
>>    However, my libvirt demo code
>>> for implementing differential backups on top of persistent bitmaps
>>> did not need to take advantage of that feature (it is instead
>>> possible to create a new temporary bitmap with the desired name,
>>> use block-dirty-bitmap-merge to merge one or more persistent
>>> bitmaps into the temporary, then associate the temporary with the
>>> NBD export, if control is needed over the exported bitmap name).
>=20
> With bitmap-export-name we can use shorter bitmap names in NBD export.
> For example it can be just UUID of corresponding snapshot. With merge
> strategy this should be at least export-$UUID because $UUID is already
> used for bitmaps created during snapshots.
>=20
> Nikolay

If I need to add in an x-bitmap-export-name, as a separate patch, we can
still do that; but I still think libvirt found it fairly easy to just
always create a non-persistent bitmap with the desired name, merge in
the bitmap(s) that belong to the incremental or differential snapshots,
and then expose that temporary bitmap (at which point, you are no longer
tied to the name of the persistent bitmaps, and thus don't need
bitmap-export-name to provide a shorter export name of an actual
persistent bitmap).  Be aware that the rest of this series drops
x-nbd-server-add-bitmap entirely; as well as John's pending changes that
drop the x- prefix from dirty-bitmap-enable/merge/disable, and changed
the merge semantics to take an array; so even if you've had demo code
working against the experimental names, you do have to plan to make some
tweaks. Speak up now [well, before 4.0 is final] if we are about to lock
something into stable that you can't manage to work with (as I have been
doing the same testing with my libvirt code, updating it to use the
stable names and retesting).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--KN8a2BcHLmiYBhz0cFiZYYfeg79JLSIZ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw3x0IACgkQp6FrSiUn
Q2ojcQf/T0QdhrpZdXIeb76jNuQ9/FvCE3xp0sC2uSJkMZPg7iXifZb78cog7VHB
bPPV7AwiuwOttwhKNf8JCIJ6XJt3jzR5WTixMABg494qqzJibiRAR7jDIOR2Gd5n
LXzBUZ/Uy+uXgii55JKXqgoHu0VvLS3kjw0u9pjcYoix7dDfsEyqc6iFeHw88YMD
y9d+DRnPbQgapBgxwgDCAN/SavoaIugdGU7KYxaDZ0q+IAuIPcUykA+aerT5ZdgY
nuflR70K+z0mb5Hvg3eGZOBfoGrLomISgHWRI1/K8hAnoVEZSKeJQyTdkDzD2ti/
FS6fkzy+uXEbiltzzmPpyMPmLgkJEw==
=J8aF
-----END PGP SIGNATURE-----

--KN8a2BcHLmiYBhz0cFiZYYfeg79JLSIZ2--
