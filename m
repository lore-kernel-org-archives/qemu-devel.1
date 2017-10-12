Received: from eggs.gnu.org ([2001:4830:134:3::10]:39697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2m4k-0006jQ-Nw
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 18:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2m4j-0004nC-Qj
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 18:35:34 -0400
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
	<20171012095319.136610-8-vsementsov@virtuozzo.com>
	<f0852a65-aacc-6bc2-1b48-cf9ed197e361@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e77940fe-3d7d-862a-ef77-a2d802da4171@redhat.com>
Date: Thu, 12 Oct 2017 17:35:23 -0500
MIME-Version: 1.0
In-Reply-To: <f0852a65-aacc-6bc2-1b48-cf9ed197e361@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="X8UReiqLLG1x65gxB1lTWov8p4mTLEXdD"
Subject: Re: [Qemu-devel] [PATCH v3 07/13] nbd-server: simplify reply
 transmission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X8UReiqLLG1x65gxB1lTWov8p4mTLEXdD
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, mreitz@redhat.com
Message-ID: <e77940fe-3d7d-862a-ef77-a2d802da4171@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 07/13] nbd-server: simplify reply
 transmission
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
 <20171012095319.136610-8-vsementsov@virtuozzo.com>
 <f0852a65-aacc-6bc2-1b48-cf9ed197e361@redhat.com>
In-Reply-To: <f0852a65-aacc-6bc2-1b48-cf9ed197e361@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/2017 05:27 PM, Eric Blake wrote:
> On 10/12/2017 04:53 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Send qiov via qio_channel_writev_all instead of calling nbd_write twic=
e
>> with a cork.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> ---
>>  nbd/server.c | 50 ++++++++++++++++++++++++--------------------------
>>  1 file changed, 24 insertions(+), 26 deletions(-)
>>
>=20
>> @@ -1203,36 +1220,17 @@ static int nbd_co_send_simple_reply(NBDClient =
*client,
>>                                      size_t len,
>>                                      Error **errp)
>>  {
>> -    NBDSimpleReply simple_reply;
>> -    int ret;
>> -
>> -    g_assert(qemu_in_coroutine());
>> +    NBDSimpleReply reply;
>=20
> Why the rename from simple_reply to reply?
>=20
>> +    struct iovec iov[] =3D {
>> +        {.iov_base =3D &reply, .iov_len =3D sizeof(reply)},
>=20
> I guess it made this line shorter.  But we could reduce some churn by
> naming it 'reply' in the first place, back in earlier patches.  At the
> same time, I'm not going to bother if there's not a reason to respin th=
e
> series (or at least the first half).

Answering myself - you couldn't use the name 'reply' until 5/13 removed
it as a parameter name, even though you introduced the name
'simple_reply' in 4/13.  Okay, the rename is fine here.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--X8UReiqLLG1x65gxB1lTWov8p4mTLEXdD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnf7isACgkQp6FrSiUn
Q2q6pwf9GHMi4u3qns4NZ6ofU5SZCnFszvCbpdApqIdHlq8Fj3yUin1Pr9gWVeic
dxPrQnN83VPEMUq2BcXYN3cGhfJpjgpUAvpYLxztt8hGE/+q/1tXo+vgxc0HPPHl
FH8hofrhmcafgVPqbLH1QBVH3pDd+Pl9VaMMHPnTEOEB5k6Xd1H3UgF02oU6ikTy
O2HhAO/JztIvaG5H/6ny3k2xLbMiWtD4y2BC27QepNvGrlIJU4lWN9+ETmqEitCG
5UaKHnL6AMzsu3PZf2D/1TCBMXnhU1FkY5FkD2KB5a0CPm4VH68i88PXoxUQq5sH
GhOM0LmVriFVZelzuYzUFcfYZu8Lnw==
=Keay
-----END PGP SIGNATURE-----

--X8UReiqLLG1x65gxB1lTWov8p4mTLEXdD--
