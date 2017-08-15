Received: from eggs.gnu.org ([2001:4830:134:3::10]:33220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhdEl-0003BE-MB
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhdEh-0001z4-RI
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:54:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dhdEh-0001yf-Hd
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:54:27 -0400
References: <20170814213426.24681-1-eblake@redhat.com>
	<7c221a24-bc5c-95a0-ea5e-141d66daafd2@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6c97fa2e-a04c-57e7-430d-8dcecb1875e8@redhat.com>
Date: Tue, 15 Aug 2017 09:54:24 -0500
MIME-Version: 1.0
In-Reply-To: <7c221a24-bc5c-95a0-ea5e-141d66daafd2@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qqfcpEF7NGgENpFOR189nD2cuqPxgJtXD"
Subject: Re: [Qemu-devel] [PATCH for-2.10 v2] nbd-client: Fix regression
 when server sends garbage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qqfcpEF7NGgENpFOR189nD2cuqPxgJtXD
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Message-ID: <6c97fa2e-a04c-57e7-430d-8dcecb1875e8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 v2] nbd-client: Fix regression when
 server sends garbage
References: <20170814213426.24681-1-eblake@redhat.com>
 <7c221a24-bc5c-95a0-ea5e-141d66daafd2@virtuozzo.com>
In-Reply-To: <7c221a24-bc5c-95a0-ea5e-141d66daafd2@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/15/2017 09:45 AM, Vladimir Sementsov-Ogievskiy wrote:
> 15.08.2017 00:34, Eric Blake wrote:
>> When we switched NBD to use coroutines for qemu 2.9 (in particular,
>> commit a12a712a), we introduced a regression: if a server sends us
>> garbage (such as a corrupted magic number), we quit the read loop
>> but do not stop sending further queued commands, resulting in the
>> client hanging when it never reads the response to those additional
>> commands.  In qemu 2.8, we properly detected that the server is no
>> longer reliable, and cancelled all existing pending commands with
>> EIO, then tore down the socket so that all further command attempts
>> get EPIPE.
>>
>> Restore the proper behavior of quitting (almost) all communication
>> with a broken server: Once we know we are out of sync or otherwise
>> can't trust the server, we must assume that any further incoming
>> data is unreliable and therefore end all pending commands with EIO,
>> and quit trying to send any further commands.  As an exception, we
>> still (try to) send NBD_CMD_DISC to let the server know we are going
>> away (in part, because it is easier to do that than to further
>> refactor nbd_teardown_connection, and in part because it is the
>> only command where we do not have to wait for a reply).
>>
>> Based on a patch by Vladimir Sementsov-Ogievskiy.
>>

>> +++ b/block/nbd-client.c
>> @@ -73,7 +73,7 @@ static coroutine_fn void nbd_read_reply_entry(void
>> *opaque)
>>       int ret;
>>       Error *local_err =3D NULL;
>>
>> -    for (;;) {
>> +    while (!s->quit) {
>=20
> looks like quit will never be true here
>=20
>>           assert(s->reply.handle =3D=3D 0);
>>           ret =3D nbd_receive_reply(s->ioc, &s->reply, &local_err);
>>           if (ret < 0) {
>> @@ -107,6 +107,9 @@ static coroutine_fn void nbd_read_reply_entry(void=

>> *opaque)
>>           qemu_coroutine_yield();
>>       }
>>
>> +    if (ret < 0) {
>> +        s->quit =3D true;
>=20
> so, you set quit only here.. if we fail on some write, reading coroutin=
e
> will not
> know about it and will continue reading..

Looks like you are correct - your version set the flag in more places
than me, but it looks like you're right that we DO want to set the flag
when writing hits a known failure.

Here's what I plan to squash in:

diff --git i/block/nbd-client.c w/block/nbd-client.c
index bb17e3da45..422ecb4307 100644
--- i/block/nbd-client.c
+++ w/block/nbd-client.c
@@ -161,6 +161,9 @@ static int nbd_co_send_request(BlockDriverState *bs,
     } else {
         rc =3D nbd_send_request(s->ioc, request);
     }
+    if (rc < 0) {
+        s->quit =3D true;
+    }
     qemu_co_mutex_unlock(&s->send_mutex);
     return rc;
 }

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qqfcpEF7NGgENpFOR189nD2cuqPxgJtXD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmTCyAACgkQp6FrSiUn
Q2qBBAgAqyr8ZsLCVTTo8gC8M8vhh9v8qMJ9aAICYvA5LJfcVi326oTCi40IItLy
X/qbanigw7U6y1sDxi87u6mu54ZjJnSAFupGFa+dIMlDbrbmAcx/laVpWnYl1lwT
fpw/yLWcnfwpUXwA23mt0sR1qvbDoFRoc1ir6aIkSW4+LBn7SWk4Q/yT2UbvhDhi
D8CufyUnwG3Rdy/yh+TlQa0QqbOq9FS9t7HMOTW9t6PnlGa1r+UHFLPW5p2UI43R
hIHMUubRkPkjWSVyQVlZUN0IeYRtMp5dG/tWE2O8EYYB3P30fUXfxXgqiDxGYHk7
nvRkwGD09y/8o0ftLjQh2gyRYDkl9w==
=ehhP
-----END PGP SIGNATURE-----

--qqfcpEF7NGgENpFOR189nD2cuqPxgJtXD--
