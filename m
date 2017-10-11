Received: from eggs.gnu.org ([2001:4830:134:3::10]:53770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e2FEX-0007tu-On
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 07:31:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e2FES-000706-G6
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 07:31:25 -0400
References: <20171009215533.12530-1-mreitz@redhat.com>
	<20171009215533.12530-3-mreitz@redhat.com>
	<474ed8c0-6ffc-b565-45c0-c9890826897c@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6fe61402-ff70-72cd-07e5-57638a6ffb89@redhat.com>
Date: Wed, 11 Oct 2017 13:31:11 +0200
MIME-Version: 1.0
In-Reply-To: <474ed8c0-6ffc-b565-45c0-c9890826897c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NreIsfpXNKaxX7GgMi6lSjXgtg8MwGdws"
Subject: Re: [Qemu-devel] [PATCH 2/3] qcow2: Always execute preallocate() in
 a coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NreIsfpXNKaxX7GgMi6lSjXgtg8MwGdws
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <6fe61402-ff70-72cd-07e5-57638a6ffb89@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] qcow2: Always execute preallocate() in a
 coroutine
References: <20171009215533.12530-1-mreitz@redhat.com>
 <20171009215533.12530-3-mreitz@redhat.com>
 <474ed8c0-6ffc-b565-45c0-c9890826897c@redhat.com>
In-Reply-To: <474ed8c0-6ffc-b565-45c0-c9890826897c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-10-10 00:28, Eric Blake wrote:
> On 10/09/2017 04:55 PM, Max Reitz wrote:
>> Some qcow2 functions (at least perform_cow()) expect s->lock to be
>> taken.  Therefore, if we want to make use of them, we should execute
>> preallocate() (as "preallocate_co") in a coroutine so that we can use
>> the qemu_co_mutex_* functions.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/qcow2.c | 41 ++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 34 insertions(+), 7 deletions(-)
>>
>=20
>> +++ b/block/qcow2.c
>> @@ -2460,6 +2460,14 @@ static int qcow2_set_up_encryption(BlockDriverS=
tate *bs, const char *encryptfmt,
>>  }
>> =20
>> =20
>> +typedef struct PreallocCo {
>> +    BlockDriverState *bs;
>> +    uint64_t offset;
>> +    uint64_t new_length;
>> +
>> +    int ret;
>> +} PreallocCo;
>=20
> Because you create a typedef here...
>=20
>=20
>> +static void coroutine_fn preallocate_co(void *opaque)
>>  {
>> +    struct PreallocCo *params =3D opaque;
>=20
> you could drop 'struct' here, the way you already dropped it...

Ah, yes, that was from before I added the typedef...  Will fix.

Max

>=20
>> +static int preallocate(BlockDriverState *bs,
>> +                       uint64_t offset, uint64_t new_length)
>> +{
>> +    PreallocCo params =3D {
>> +        .bs         =3D bs,
>> +        .offset     =3D offset,
>> +        .new_length =3D new_length,
>> +        .ret        =3D -EINPROGRESS,
>> +    };
>=20
> ...here.  But that doesn't change semantics, so either way,
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20



--NreIsfpXNKaxX7GgMi6lSjXgtg8MwGdws
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlneAP8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AEVEIAIYPrdv7WUhlXYtFM3x4Gk4FqRHm4uYB
E/AhYTxHxYDQf+t6emByo6zu0hA7e868R6rAVrsZkHPmDXZUTgQ02uH3vfZe/6Cq
Ph5H6ojQ7RkFG2CfX6idvKzf2raUYfgB2XfvAYLNMGtl4twWQHYDZaG7g12VsyZ5
8YmNxhVvpXrOnl658sbsobs/NN/UL8oqmOTBN5NRYsuN1HlKo2otA76HyKFv8fay
6OJj6PKVPdZebLPP+kyHrcDSEnbOBDh0WFeNHIf3cP2jNbrcGIo6pMY/LkHiYrvK
e6bifQj6f3PBuKrGLvLegKrEXakSVcILe3j1u8zl7V6zOhtdBlnBVNg=
=546d
-----END PGP SIGNATURE-----

--NreIsfpXNKaxX7GgMi6lSjXgtg8MwGdws--
