Received: from eggs.gnu.org ([2001:4830:134:3::10]:34460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAjqD-0004bj-5A
	for Qemu-devel@nongnu.org; Fri, 03 Nov 2017 17:49:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAjq8-00059X-OR
	for Qemu-devel@nongnu.org; Fri, 03 Nov 2017 17:49:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eAjq8-00058s-Fk
	for Qemu-devel@nongnu.org; Fri, 03 Nov 2017 17:49:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39CE4BDFD
	for <Qemu-devel@nongnu.org>; Fri,  3 Nov 2017 21:49:23 +0000 (UTC)
References: <f88b9c1e-6331-8c7f-b748-62dc11a50c1e@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <19b8b458-3964-3d98-5459-30c5bf19d708@redhat.com>
Date: Fri, 3 Nov 2017 16:49:21 -0500
MIME-Version: 1.0
In-Reply-To: <f88b9c1e-6331-8c7f-b748-62dc11a50c1e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KNBFgxTtwAk2s3LP3r0rB037S2b4r0ibH"
Subject: Re: [Qemu-devel] coroutine question, for NBD debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KNBFgxTtwAk2s3LP3r0rB037S2b4r0ibH
From: Eric Blake <eblake@redhat.com>
To: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <19b8b458-3964-3d98-5459-30c5bf19d708@redhat.com>
Subject: Re: [Qemu-devel] coroutine question, for NBD debugging
References: <f88b9c1e-6331-8c7f-b748-62dc11a50c1e@redhat.com>
In-Reply-To: <f88b9c1e-6331-8c7f-b748-62dc11a50c1e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/03/2017 03:03 PM, Eric Blake wrote:
> In include/qemu/coroutine.h, we have:
>=20
> /**
>  * Yield the coroutine for a given duration
>  *
>  * Behaves similarly to co_sleep_ns(), but the sleeping coroutine will =
be
>  * resumed when using aio_poll().
>  */
> void coroutine_fn co_aio_sleep_ns(AioContext *ctx, QEMUClockType type,
>=20
> but there is no co_sleep_ns() anywhere.  What should the documentation
> actually state?

This part still needs fixing; but partially answering myself:

>=20
> Meanwhile, I'm trying to figure out if there is an easy way to hack
> qemu-nbd to send two structured replies interleaved (as in A.1, B.1,
> A.2, B.2) to ensure the NBD client coroutines properly handle
> interleaved responses, but adding a plain sleep() between A.1 and A.2
> does not work, and I'm not sure whether co_aio_sleep_ns() would work fo=
r
> the hack instead.
>=20
> The hack I'm currently playing with splits reads and structured errors
> into two parts, attempting to use sleeps to force the server to send
> replies out of order:
>=20

> +    sleep(2);

Using this instead of sleep():

+    co_aio_sleep_ns(client->exp->ctx, QEMU_CLOCK_REALTIME, 2000000000);

> coupled with a client that does:
>=20
> $ ./qemu-io -f raw nbd://localhost:10809/foo --trace=3D'nbd_*' -c
> 'aio_write -P 3 1 1' -c 'aio_read -P 1 1 1'
>=20

produced the trace I was looking for:

2837@1509745520.815687:nbd_send_request Sending request to server: {
=2Efrom =3D 1, .len =3D 1, .handle =3D 93924431318768, .flags =3D 0x1, .t=
ype =3D 1
(write) }
2837@1509745520.815764:nbd_send_request Sending request to server: {
=2Efrom =3D 1, .len =3D 1, .handle =3D 93924431318769, .flags =3D 0x0, .t=
ype =3D 0
(read) }
2837@1509745520.815913:nbd_receive_structured_reply_chunk Got structured
reply chunk: { flags =3D 0x0, type =3D 32769, handle =3D 93924431318768,
length =3D 25 }
2837@1509745520.856401:nbd_receive_structured_reply_chunk Got structured
reply chunk: { flags =3D 0x0, type =3D 1, handle =3D 93924431318769, leng=
th =3D 9 }
2837@1509745521.817279:nbd_receive_structured_reply_chunk Got structured
reply chunk: { flags =3D 0x1, type =3D 0, handle =3D 93924431318768, leng=
th =3D 0 }
aio_write failed: Operation not permitted
2837@1509745522.817474:nbd_receive_structured_reply_chunk Got structured
reply chunk: { flags =3D 0x1, type =3D 0, handle =3D 93924431318769, leng=
th =3D 0 }
read 1/1 bytes at offset 1
1 bytes, 1 ops; 0:00:02.00 (0.499560 bytes/sec and 0.4996 ops/sec)

which means I'm fairly confident that our client implementation is doing
the right thing with regards to complex out-of-order/interleaved
structured replies!  Always a nice thing to demonstrate.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KNBFgxTtwAk2s3LP3r0rB037S2b4r0ibH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAln85GEACgkQp6FrSiUn
Q2qi9wf/b5xKruF2relAoCSC+9laNWuhwzTyfGdKMv6VdDrb/6Dd0ms/mKvpGp29
jPD5OmvaxvwIl/LucpmvdvJnbEqO7KHCnVGT61fuyZQ3lPgB5UgPmXs8KT2rkWTj
e4qTn3SXW2eNYJ3cgt0TEct3GvvJdqahaoCklZkUP+xIBWQW3ekHbyXkBbR0vFZV
yE4hdGRIdj71HpMTFdtb+W8dy9M2Q9qdgYOReks9vp4E59IEvcEvJZzHnGqGSPkV
HWuiLLmP6R/Y0AL3zgK1MVd/m7YqQOsPWK41jCZ+A0//X3cGmM5iEiGcbNz1f7tl
qOHB8z13ThBTgJ78J0cVWUF7RujFJA==
=wqXa
-----END PGP SIGNATURE-----

--KNBFgxTtwAk2s3LP3r0rB037S2b4r0ibH--
