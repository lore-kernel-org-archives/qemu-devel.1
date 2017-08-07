Received: from eggs.gnu.org ([2001:4830:134:3::10]:46800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dek24-0008H7-2r
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:33:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dek1y-0001iV-US
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:33:28 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<20170804151440.320927-7-vsementsov@virtuozzo.com>
	<4dc2dde8-2177-3d1c-c168-f98d826922b5@redhat.com>
	<cf38e6aa-e934-bf75-48bf-3c3bbcb7f254@virtuozzo.com>
	<b204c5ab-2d4c-315d-7fe7-2111559052a8@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ec30e36d-e6b2-78f6-3cf9-eb8ef12a0532@redhat.com>
Date: Mon, 7 Aug 2017 10:33:08 -0500
MIME-Version: 1.0
In-Reply-To: <b204c5ab-2d4c-315d-7fe7-2111559052a8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KIoqtSPJ4lEHXretALTD0n5PNE2sR1ULk"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 06/17] block/nbd-client: fix
 nbd_read_reply_entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, P J P <ppandit@redhat.com>, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KIoqtSPJ4lEHXretALTD0n5PNE2sR1ULk
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org,
 P J P <ppandit@redhat.com>, mreitz@redhat.com
Message-ID: <ec30e36d-e6b2-78f6-3cf9-eb8ef12a0532@redhat.com>
Subject: Re: [Qemu-block] [PATCH 06/17] block/nbd-client: fix
 nbd_read_reply_entry
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
 <20170804151440.320927-7-vsementsov@virtuozzo.com>
 <4dc2dde8-2177-3d1c-c168-f98d826922b5@redhat.com>
 <cf38e6aa-e934-bf75-48bf-3c3bbcb7f254@virtuozzo.com>
 <b204c5ab-2d4c-315d-7fe7-2111559052a8@redhat.com>
In-Reply-To: <b204c5ab-2d4c-315d-7fe7-2111559052a8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/07/2017 10:13 AM, Eric Blake wrote:
> On 08/07/2017 07:56 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 07.08.2017 14:52, Eric Blake wrote:
>>> On 08/04/2017 10:14 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>> Set reply.handle to 0 on error path to prevent normal path of
>>>> nbd_co_receive_reply.
>=20

> ...and the client is recognizing that the server sent garbage, but then=

> proceeds to handle the packet anyway.  The ideal reaction is that the
> client should disconnect from the server, rather than handle the packet=
=2E
>  But because it didn't do that, the client is now unable to receive any=

> future messages from the server.  Compare the traces of:
>=20

> followed by a clean disconnect; vs. the buggy server:
>=20
> 29148@1502118384.385133:nbd_opt_go_success Export is good to go
> 29148@1502118384.385321:nbd_send_request Sending request to server: {
> .from =3D 0, .len =3D 1, .handle =3D 94152262559840, .flags =3D 0x0, .t=
ype =3D 0
> (read) }
> 29148@1502118396.494643:nbd_receive_reply Got reply: { magic =3D
> 0x1446698, .error =3D  0, handle =3D 94152262559840 }
> invalid magic (got 0x1446698)
> read 1/1 bytes at offset 0
> 1 bytes, 1 ops; 0:00:12.10 (0.082581 bytes/sec and 0.0826 ops/sec)
> 29148@1502118396.494746:nbd_send_request Sending request to server: {
> .from =3D 0, .len =3D 0, .handle =3D 94152262559840, .flags =3D 0x0, .t=
ype =3D 3
> (flush) }
>=20
> where the client is now hung.  Thankfully, the client is blocked in an
> idle loop (not eating CPU), so I don't know if this counts as the
> ability for a malicious server to cause a denial of service against qem=
u
> as an NBD client (in general, being unable to read further data from th=
e
> server because client internal state is now botched is not that much
> different from being unable to read further data from the server becaus=
e
> the client hung up on the invalid server), unless there is some way to
> cause qemu to die from an assertion failure rather than just get stuck.=


With just patch 6/17 applied, the client still hangs, but this time with
a different trace:

30053@1502119637.604092:nbd_opt_go_success Export is good to go
30053@1502119637.604256:nbd_send_request Sending request to server: {
=2Efrom =3D 0, .len =3D 1, .handle =3D 94716063746144, .flags =3D 0x0, .t=
ype =3D 0
(read) }
30053@1502119649.070156:nbd_receive_reply Got reply: { magic =3D
0x1446698, .error =3D  0, handle =3D 94716063746144 }
invalid magic (got 0x1446698)
read failed: Input/output error
30053@1502119649.070243:nbd_send_request Sending request to server: {
=2Efrom =3D 0, .len =3D 0, .handle =3D 94716063746144, .flags =3D 0x0, .t=
ype =3D 3
(flush) }

The client still tried to send a flush request to the server, when it
should REALLY quit talking to the server at all and just disconnect,
because the moment the client recognizes that the server has sent
garbage is the moment that the client can no longer assume that the
server will react correctly to any further commands.

So I don't think your patch is quite correct, even if you have
identified a shortfall in our client code.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KIoqtSPJ4lEHXretALTD0n5PNE2sR1ULk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmIiDQACgkQp6FrSiUn
Q2okzQf/Rl2Q3ON88rwzJwK8FUiguveibqz5+z2VD4l9ZT0Xi2Rp51xVfQcfv5Sa
Dvljqyd0kECH8ltgnru1y/0BmznPIJJcMrEDR+SYFxoLn71vSq/aW5LJKyIMHzM5
EI+VpYg+yIfclm0IWEN/xEJFFQIDHZLKo/wyBLlLDDwAM3CzTCe2tQ8tZUmwckfp
1jjmv5d9Uu3wO/jRGx0xdO+7yWBJ3otK+dENIz507Quyjt/K+jMJ5vCR+eXmzm86
cpJmyuEaNQZjrFh6IWbEoJ1eQi+D46yxa3CEnRpYqbckmOsh7C1YQYCPBYrOzbr2
xbPkXJ/VZziFsgy+BXOqF/fTxRrlsA==
=Icub
-----END PGP SIGNATURE-----

--KIoqtSPJ4lEHXretALTD0n5PNE2sR1ULk--
