Received: from eggs.gnu.org ([2001:4830:134:3::10]:43910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5HiY-0006Uh-9g
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 16:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5HiX-00021u-6h
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 16:47:02 -0400
References: <20171015010131.12172-1-eblake@redhat.com>
	<20171017125710.11626-1-vsementsov@virtuozzo.com>
	<7480d774-569e-9b43-8f0c-7b3b4d9bfbf0@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <41d371a1-5665-c88e-03e2-b581301cd570@redhat.com>
Date: Thu, 19 Oct 2017 15:46:51 -0500
MIME-Version: 1.0
In-Reply-To: <7480d774-569e-9b43-8f0c-7b3b4d9bfbf0@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2fs0spAXv6LNru11hsXfWLjVwGRqewvwi"
Subject: Re: [Qemu-devel] [PATCH v4 RFC 9/8] nbd: Minimal structured read
 for client
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
--2fs0spAXv6LNru11hsXfWLjVwGRqewvwi
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, mreitz@redhat.com
Message-ID: <41d371a1-5665-c88e-03e2-b581301cd570@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 RFC 9/8] nbd: Minimal structured read for
 client
References: <20171015010131.12172-1-eblake@redhat.com>
 <20171017125710.11626-1-vsementsov@virtuozzo.com>
 <7480d774-569e-9b43-8f0c-7b3b4d9bfbf0@redhat.com>
In-Reply-To: <7480d774-569e-9b43-8f0c-7b3b4d9bfbf0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/17/2017 04:17 PM, Eric Blake wrote:
> On 10/17/2017 07:57 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Minimal implementation: for structured error only error_report error
>> message.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> ---

> But in the client, I then perform 'w 0 0' (a zero-byte write, which
> should fail because the server is read-only).  I see:
>=20
> C: 19481@1508268433.381446:nbd_send_request Sending request to server: =
{
> .from =3D 0, .len =3D 0, .handle =3D 93997172956880, .flags =3D 0x1, .t=
ype =3D 1
> (write) }
> S: 19479@1508268433.381516:nbd_receive_request Got request: { magic =3D=

> 0x25609513, .flags =3D 0x1, .type =3D 0x1, from =3D 0, len =3D 0 }
> S: 19479@1508268433.381527:nbd_co_receive_request_decode_type Decoding
> type: handle =3D 93997172956880, type =3D 1 (write)
> S: 19479@1508268433.381540:nbd_co_receive_request_payload_received
> Payload received: handle =3D 93997172956880, len =3D 0
> S: 19479@1508268433.381564:nbd_co_send_structured_error Send structured=

> error reply: handle =3D 93997172956880, error =3D 1 (EPERM), msg =3D ''=

> C: 19481@1508268433.381622:nbd_receive_structured_reply_chunk Got
> structured reply chunk: { flags =3D 0x1, type =3D 32769, handle =3D
> 93997172956880, length =3D 6 }
> C: wrote 0/0 bytes at offset 0
> C: 0 bytes, 1 ops; 0.0002 sec (0 bytes/sec and 4291.8455 ops/sec)
>=20
> Oops - the client claimed success, even though the server replied with
> EPERM.  And the server didn't do a good job of including details on the=

> error message.  So there's still some tweaks needed.

The server not sending details is a separate pre-existing issue; in
server.c, we set errp for NBD_CMD_WRITE_ZEROES but not for
NBD_CMD_WRITE.  You can get the server to cough up a message by using 'w
-z 0 1' instead.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2fs0spAXv6LNru11hsXfWLjVwGRqewvwi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnpDzsACgkQp6FrSiUn
Q2qLSQf/YCyBHxynFFAblGjZmO1YxuxX7+eW1axF7YYrApZHz8SWURphMWr3io4d
HHYO0JJtVSnefcgQWtvcYE99Znmo9yAlWav41kuLuABlSa0R1srphRQM8b1vqyAN
FArF1KGSI/BuYb9R1WRAOXCiBnDMLul+Z4rGVUVmqUrgfinFWNiaKC8LK5fsVD8p
I0lIADbnsKM92X20H9cElMQHkjEaMebYAvCYa+EUrVx5AlGTXR7PEnVwoNGEjIoN
stXP4x5mwPJWi2UGBb8NcDdFN+/eLmOUTulrOCNKil7sH3HgRQ9+FYUHUjqBBAF5
keKMK4ZAVByE20MneQV6XIR5cpmoWA==
=qP4S
-----END PGP SIGNATURE-----

--2fs0spAXv6LNru11hsXfWLjVwGRqewvwi--
