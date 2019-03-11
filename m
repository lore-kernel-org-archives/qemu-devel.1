Received: from eggs.gnu.org ([209.51.188.92]:45636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3PCj-0007Ey-PY
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h3P2Q-0005hY-K9
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:48:35 -0400
References: <20190305234337.18353-1-jsnow@redhat.com>
	<3a8ed35f-e50b-c411-2004-38917d2164c6@redhat.com>
	<d6458782-9335-e3f4-f8cb-51e46b790aad@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4c132978-2965-fa82-601a-69bff47590cf@redhat.com>
Date: Mon, 11 Mar 2019 12:48:24 -0500
MIME-Version: 1.0
In-Reply-To: <d6458782-9335-e3f4-f8cb-51e46b790aad@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4U1KAjJyWdcP8hFeaPkQYVCbrsBB5wnk5"
Subject: Re: [Qemu-devel] [PATCH 0/5] block/qcow2-bitmap: Enable resize with
 persistent bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4U1KAjJyWdcP8hFeaPkQYVCbrsBB5wnk5
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <4c132978-2965-fa82-601a-69bff47590cf@redhat.com>
Subject: Re: [PATCH 0/5] block/qcow2-bitmap: Enable resize with persistent
 bitmaps
References: <20190305234337.18353-1-jsnow@redhat.com>
 <3a8ed35f-e50b-c411-2004-38917d2164c6@redhat.com>
 <d6458782-9335-e3f4-f8cb-51e46b790aad@virtuozzo.com>
In-Reply-To: <d6458782-9335-e3f4-f8cb-51e46b790aad@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/11/19 12:36 PM, Vladimir Sementsov-Ogievskiy wrote:

>> FWIW - I have not yet reviewed this series closely, but I think it wou=
ld
>> be wise to get this initial cut in before softfreeze (we can make
>> further tweaks to fix bugs in assumptions during rc1 and rc2, but it's=
 a
>> lot harder to add the series at all if it misses softfreeze).
>>
>=20
> I still not convinced that we need bitmap flushing. I think (and Den su=
pports
> me) that it's a bad idea. It makes things more difficult without a reas=
on,
> except improving debugging with --force-share which should never be use=
d in
> production.

And I'm still not convinced that adding bitmap flushing will add a
benchmarkable delay to operation. Although debugging may not be needed
in a production environment, having it after a failure can be a lifesaver=
=2E

Looking at this from another point of view: if this series goes in now
(with its use of limited bitmap flushing on resize in order to make
coding bitmap resize easier, rather than global bitmap flushing after
every bitmap add/delete), then the only time that flushing to disk
happens is during resize (which is currently flat-out forbidden), so it
will not penalize existing use cases. And we still have rc1/rc2 to fix
any bugs if we can come up with some other way to get resize to work
without flushing (or even revert things if it proves to be too
invasive). But as a feature addition, if this series does not go in now,
then bitmap resize is stuck waiting for 4.2, regardless of what we can
figure out during rc1/rc2.

>=20
> Bitmaps are stored in qcow2_inactivate() which is true place for flushi=
ng caches.
>=20

There doesn't have to be just one place for flushing caches.  In terms
of IOPs, how much overhead does a flush cost in relation to everything
else?  And how infrequent are bitmap resize, add, and delete events?
Optimizing to the bare minimum of flushes just because it adds minimal
overhead may be premature optimization if that overhead is in the noise
anyway.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--4U1KAjJyWdcP8hFeaPkQYVCbrsBB5wnk5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyGn2gACgkQp6FrSiUn
Q2rCCAf/UaVKZI8orwXGJeWP0fZgAfiwR8K8KKuoZNZkA2Qqlz+pmYIj+PBljriK
1K6bzDTuRd4SYngDJUmP6mmYfOYNSU67DW5zjVqrSKgm1rTt9QmNgW8X3MmNpzDc
g+ivF+ebUka0VXDyUH7U8okqzeNMVawpKkGPvP3Zqw93kTk1HsPj1flTvYBoWKjj
S6itlL4ZFllWY4LHfrSnWDNDZyy8w5MsczmYglGMdFPBJ7d5pvtyNrx16tEVDbUS
EhGUSuOeLTjNEKK3tHSsxiMGY8PZOGRoLL7FcWSCSCpm9g0pDPFfyq42gF+QPri3
S8LTLDHdogjPco3ikxTlEMmntIhHzA==
=N2AK
-----END PGP SIGNATURE-----

--4U1KAjJyWdcP8hFeaPkQYVCbrsBB5wnk5--
