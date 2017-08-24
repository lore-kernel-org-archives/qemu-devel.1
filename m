Received: from eggs.gnu.org ([2001:4830:134:3::10]:49905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkw4A-0004kN-OH
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 13:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkw49-0004Es-Lt
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 13:37:14 -0400
References: <20170824153345.2244-1-stefanha@redhat.com>
	<20170824153345.2244-2-stefanha@redhat.com>
	<a839e5fa-0495-902c-5a20-6592ab07bb9e@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <12b5540c-de00-ac37-f1f6-5ed423856541@redhat.com>
Date: Thu, 24 Aug 2017 12:37:02 -0500
MIME-Version: 1.0
In-Reply-To: <a839e5fa-0495-902c-5a20-6592ab07bb9e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="51QeN086cJ8RUPpgrI8KgQxfPQHAo6Bhf"
Subject: Re: [Qemu-devel] [PATCH 1/3] nbd-client: enter read_reply_co during
 init to avoid crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--51QeN086cJ8RUPpgrI8KgQxfPQHAo6Bhf
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <12b5540c-de00-ac37-f1f6-5ed423856541@redhat.com>
Subject: Re: [PATCH 1/3] nbd-client: enter read_reply_co during init to avoid
 crash
References: <20170824153345.2244-1-stefanha@redhat.com>
 <20170824153345.2244-2-stefanha@redhat.com>
 <a839e5fa-0495-902c-5a20-6592ab07bb9e@redhat.com>
In-Reply-To: <a839e5fa-0495-902c-5a20-6592ab07bb9e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/24/2017 11:21 AM, Paolo Bonzini wrote:
> On 24/08/2017 17:33, Stefan Hajnoczi wrote:
>> This patch enters read_reply_co directly in
>> nbd_client_attach_aio_context().  This is safe because new_context is
>> acquired by the caller.  This ensures that read_reply_co reaches its
>> first yield point and its ctx is set up.
>=20
> I'm not very confident with this patch.  aio_context_acquire/release is=

> going to go away, and this then becomes possible
>=20
> 	main context			new_context
> 	qemu_aio_coroutine_enter
> 					send request
> 					wait for reply
> 	read first reply
> 	wake coroutine
>=20
> where the "wake coroutine" part thinks it's running in new_context, and=

> thus simply enters the coroutine instead of using the bottom half.
>=20
> But blk_co_preadv() should need the read_reply_co itself, in order to b=
e
> woken up after reading the reply header.  The core issue here is that
> nbd_co_receive_reply was never called, I suspect.  And if it was never
> called, read_reply_co should not be woken up by nbd_coroutine_end.
>=20
> So the fix is:
>=20
> 1) assign NULL to s->recv_coroutine[i] when nbd_co_send_request fails
>=20
> 2) move this to nbd_co_receive_reply:
>=20
>     s->recv_coroutine[i] =3D NULL;
>=20
>     /* Kick the read_reply_co to get the next reply.  */
>     if (s->read_reply_co) {
>         aio_co_wake(s->read_reply_co);
>     }
>=20
> Does this make sense?  (Note that the read_reply_co idea actually came
> from you, or from my recollections of your proposed design :)).

How much of this overlaps with Vladimir's proposal?
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg00846.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--51QeN086cJ8RUPpgrI8KgQxfPQHAo6Bhf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmfDr4ACgkQp6FrSiUn
Q2qYhQf/UrjunoBboGBNRQIwHpINbytl50q41U0NCcGH3+wi5Z7jYv/Wf6a37qWq
5nj0Uirv64xRn/BFBDYAgNmH0HAqEMZoSdlC9QG0b85xjGkYM6BUnbJhOhrc2PLE
29s0O5g/gZrQ/5amUMpBGYkr5JPcUHhdK8Lro8xFSegAmYZfaQm7uNf8zEDwQ7zh
N3rIBcfJ3N4uMZH/tHXE+MeZSwL8aKtXtyXyBxvzdTh3jLUOjSteCVIL0WF29l0d
ro4EpXzZ7JVJJG1q7bjydgtqPs22vL9V1BcdxM2ePcCsCr/5CAanu147mAiNJlvV
hfmazWnGXj803WZAT7sIO8CzViv5hA==
=5YLw
-----END PGP SIGNATURE-----

--51QeN086cJ8RUPpgrI8KgQxfPQHAo6Bhf--
