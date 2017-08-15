Received: from eggs.gnu.org ([2001:4830:134:3::10]:41774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhf3w-0005TW-0v
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:51:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhf3u-0002dm-RD
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:51:28 -0400
References: <20170815150907.21495-1-eblake@redhat.com>
	<20170815150907.21495-8-eblake@redhat.com>
	<e0254924-0e90-4e56-f734-d74c8c2ea8ee@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2d3ed7c8-f561-cdae-e7e5-411dff341dd8@redhat.com>
Date: Tue, 15 Aug 2017 11:51:18 -0500
MIME-Version: 1.0
In-Reply-To: <e0254924-0e90-4e56-f734-d74c8c2ea8ee@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PwlwIgcgiB7MS83Dnn4sTMTvHkB1AunW7"
Subject: Re: [Qemu-devel] [PULL 7/7] nbd-client: Fix regression when server
 sends garbage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PwlwIgcgiB7MS83Dnn4sTMTvHkB1AunW7
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <2d3ed7c8-f561-cdae-e7e5-411dff341dd8@redhat.com>
Subject: Re: [Qemu-devel] [PULL 7/7] nbd-client: Fix regression when server
 sends garbage
References: <20170815150907.21495-1-eblake@redhat.com>
 <20170815150907.21495-8-eblake@redhat.com>
 <e0254924-0e90-4e56-f734-d74c8c2ea8ee@virtuozzo.com>
In-Reply-To: <e0254924-0e90-4e56-f734-d74c8c2ea8ee@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/15/2017 10:50 AM, Vladimir Sementsov-Ogievskiy wrote:
> 15.08.2017 18:09, Eric Blake wrote:
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

>> +++ b/block/nbd-client.c
>> @@ -73,7 +73,7 @@ static coroutine_fn void nbd_read_reply_entry(void
>> *opaque)
>>       int ret;
>>       Error *local_err =3D NULL;
>>
>> -    for (;;) {
>> +    while (!s->quit) {
>>           assert(s->reply.handle =3D=3D 0);
>>           ret =3D nbd_receive_reply(s->ioc, &s->reply, &local_err);
>>           if (ret < 0) {
>=20
> I think we should check quit here, if it is true, we should not continu=
e
> normal path of handling reply

I don't think it matters.  If nbd_receive_reply() correctly got data off
the wire for this particular coroutine's request, we might as well act
on that data, regardless of what other coroutines have learned in the
meantime.

This is already in the pull request for -rc3, but if you can come up
with a scenario that still behaves incorrectly, we can do a followup
patch for -rc4 (although I'm hoping we don't have to change it any
further for 2.10).  Otherwise, I'm fine if your refactoring work for
2.11 addresses the issue as part of making the code easier to read.

>> @@ -154,6 +161,9 @@ static int nbd_co_send_request(BlockDriverState *b=
s,
>>       } else {
>>           rc =3D nbd_send_request(s->ioc, request);
>>       }
>> +    if (rc < 0) {
>> +        s->quit =3D true;
>> +    }
>>       qemu_co_mutex_unlock(&s->send_mutex);
>=20
> and here, if rc =3D=3D 0 and quite is true, we should not return 0
>=20
>>       return rc;

We don't - we return rc, which is negative.

>>   }
>> @@ -168,8 +178,7 @@ static void nbd_co_receive_reply(NBDClientSession =
*s,
>>       /* Wait until we're woken up by nbd_read_reply_entry.  */
>>       qemu_coroutine_yield();
>>       *reply =3D s->reply;
>> -    if (reply->handle !=3D request->handle ||
>> -        !s->ioc) {
>> +    if (reply->handle !=3D request->handle || !s->ioc || s->quit) {
>>           reply->error =3D EIO;
>=20
> here, if s->quit is false, we should set it to inform other coroutines

We can't get into nbd_co_receive_reply() unless the two handles were
once equal, and the only code that changes them to be not equal is when
we are shutting down.  Checking s->quit is a safety valve if some other
coroutine detects corruption first, but this coroutine does not need to
set s->quit because it is either already set, or we are already shutting
down.

>=20
>>       } else {
>>           if (qiov && reply->error =3D=3D 0) {
>=20
> and here follows a call to nbd_rwv(), where s->quit should be
> appropriately handled..

Reading from a corrupt server is not as bad as writing to the corrupt
server; the patch for 2.10 is solely focused on preventing writes where
we need a followup read (because once we know the server is corrupt, we
can't guarantee the followup reads will come).

Again, if you can prove we have a scenario that is still buggy (client
can crash or hang), then it is -rc4 material; if not, then this is all
the more that 2.10 needs, and your refactoring work for 2.11 should
clean up a lot of this mess in the first place as you make the
coroutines easier to follow.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PwlwIgcgiB7MS83Dnn4sTMTvHkB1AunW7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmTJoYACgkQp6FrSiUn
Q2oOEgf+O8naMnvEWCWNqsl9jXO2vAKPrCrOYgaKA+YZzHAdZ6l0l9OsufC/67Jr
UBZKod9Yrx2ol1aIAfkiR+SDkCk72cL5dNLNBHD6Fw7Y715qhVoo6/f0/FbqBBqo
71q8SlfOErY0W6d1IO6voV7QZAyfvg3888woBcK4JPHG1hgsNaETI9fk+C9CzUxK
P0jy5BWa5neYYjPOrWq+f/wXHYUFY6CJYQH2zPxx8yAHhUjG0mZB3Xz1BuLx0WHt
Cyv+hQGjeTRJE/vRDMpBIfG+7cDWErOzauHb5MBiDgoPbRLxEKBoVl1Cp5oiGKtl
gqvR5lhx2gi3t8BbZBRhrKSRct+Znw==
=eN4L
-----END PGP SIGNATURE-----

--PwlwIgcgiB7MS83Dnn4sTMTvHkB1AunW7--
