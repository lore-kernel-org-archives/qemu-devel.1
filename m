Received: from eggs.gnu.org ([2001:4830:134:3::10]:58169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCo49-0007KQ-Pi
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:44:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCo47-0003mV-KX
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:44:25 -0500
References: <20171108215703.9295-1-eblake@redhat.com>
	<20171108215703.9295-6-eblake@redhat.com>
	<0f12d1c5-64a8-7e45-b927-bf7ce52ac5b6@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <357c1ac7-8ec1-dd39-dbe3-027415b93e28@redhat.com>
Date: Thu, 9 Nov 2017 08:44:15 -0600
MIME-Version: 1.0
In-Reply-To: <0f12d1c5-64a8-7e45-b927-bf7ce52ac5b6@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2rwBls5bdSs7XaAlkt492O8pHbxs7VPdf"
Subject: Re: [Qemu-devel] [PATCH v2 5/7] nbd-client: Short-circuit 0-length
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2rwBls5bdSs7XaAlkt492O8pHbxs7VPdf
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com,
 Max Reitz <mreitz@redhat.com>
Message-ID: <357c1ac7-8ec1-dd39-dbe3-027415b93e28@redhat.com>
Subject: Re: [PATCH v2 5/7] nbd-client: Short-circuit 0-length operations
References: <20171108215703.9295-1-eblake@redhat.com>
 <20171108215703.9295-6-eblake@redhat.com>
 <0f12d1c5-64a8-7e45-b927-bf7ce52ac5b6@virtuozzo.com>
In-Reply-To: <0f12d1c5-64a8-7e45-b927-bf7ce52ac5b6@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/09/2017 03:20 AM, Vladimir Sementsov-Ogievskiy wrote:
> 09.11.2017 00:57, Eric Blake wrote:
>> The NBD spec was recently clarified to state that clients should
>> not send 0-length requests to the server, as the server behavior
>> is undefined [1].=C2=A0 We know that qemu-nbd's behavior is a successf=
ul
>> no-op (once it has filtered for read-only exports), but other NBD
>> implementations might return an error.=C2=A0 To avoid any questionable=

>> server implementations, it is better to just short-circuit such
>> requests on the client side (we are relying on the block layer to
>> already filter out requests such as invalid offset, write to a
>> read-only volume, and so forth).
>>
>> [1] https://github.com/NetworkBlockDevice/nbd/commit/ee926037
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20

>> @@ -705,6 +708,9 @@ int nbd_client_co_pwritev(BlockDriverState *bs,
>> uint64_t offset,
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(bytes <=3D NBD_MAX_BUFFER_SIZE);=

>>
>> +=C2=A0=C2=A0=C2=A0 if (!bytes) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +=C2=A0=C2=A0=C2=A0 }
>=20
> we don't do this check before flags manipulation to do not miss possibl=
e
> asserts...
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nbd_co_request(bs, &request, qio=
v);

Correct - I put the short-circuit as late as possible to ensure that
preconditions are still being met.  I can tweak the commit message to
make that more obvious, if desired.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2rwBls5bdSs7XaAlkt492O8pHbxs7VPdf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloEacAACgkQp6FrSiUn
Q2qtxgf/aczcGL8cFYGwDKeXvORYiLL6l+0/faKtrVsWjnhkPQPFtHAz6k7KVxuJ
hvMYz4v16RUGrWJExR1QPWbVoHcPGYeDRPhvjwxWrmNwDHfKe14nVeaaUSOTKdOy
B0JnF5zJ3Eg9cBIrq14Iw+CS8rJo7cfTUCM7VA6BOxprxi7D0orhZLO3OPCBTzwI
xZnKQuPS3SaJZ6mPgb2iagZVEE6mwgESZL0OAzLzVBxNojImj/SWlOD7YvGT/TZr
G8LIQWVGGCpSbRAze137kpRkQQc1VoMoq4NcihuVE4vN9C16RGlH035M0zDUTMrz
nL9284MH0Id2kjR6Aa2ZAGlgEbHnOQ==
=kpbY
-----END PGP SIGNATURE-----

--2rwBls5bdSs7XaAlkt492O8pHbxs7VPdf--
