Received: from eggs.gnu.org ([2001:4830:134:3::10]:34318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkXqO-0001ZL-GL
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkXqN-0004Xn-DP
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:45:24 -0400
References: <20170822125113.5025-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bc6fdd49-95c6-bb42-a818-33ce99f88f9d@redhat.com>
Date: Wed, 23 Aug 2017 10:45:06 -0500
MIME-Version: 1.0
In-Reply-To: <20170822125113.5025-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BCEJL9ETl7nvuFthKnA7eLh5eio7DqH6G"
Subject: Re: [Qemu-devel] [PATCH] nbd-client: avoid spurious
 qio_channel_yield() re-entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BCEJL9ETl7nvuFthKnA7eLh5eio7DqH6G
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bc6fdd49-95c6-bb42-a818-33ce99f88f9d@redhat.com>
Subject: Re: [PATCH] nbd-client: avoid spurious qio_channel_yield() re-entry
References: <20170822125113.5025-1-stefanha@redhat.com>
In-Reply-To: <20170822125113.5025-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/22/2017 07:51 AM, Stefan Hajnoczi wrote:
> The following scenario leads to an assertion failure in
> qio_channel_yield():
>=20
> 1. Request coroutine calls qio_channel_yield() successfully when sendin=
g
>    would block on the socket.  It is now yielded.
> 2. nbd_read_reply_entry() calls nbd_recv_coroutines_enter_all() because=

>    nbd_receive_reply() failed.
> 3. Request coroutine is entered and returns from qio_channel_yield().
>    Note that the socket fd handler has not fired yet so
>    ioc->write_coroutine is still set.
> 4. Request coroutine attempts to send the request body with nbd_rwv()
>    but the socket would still block.  qio_channel_yield() is called
>    again and assert(!ioc->write_coroutine) is hit.
>=20
> The problem is that nbd_read_reply_entry() does not distinguish between=

> request coroutines that are waiting to receive a reply and those that
> are not.
>=20
> This patch adds a per-request bool receiving flag so
> nbd_read_reply_entry() can avoid spurious aio_wake() calls.
>=20
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Using the steps in
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg03853.html,
I've verified that this avoids the hang that is otherwise present, so
I'm adding:

Tested-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BCEJL9ETl7nvuFthKnA7eLh5eio7DqH6G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmdowIACgkQp6FrSiUn
Q2qxegf/S9f/WXPKZyMAZkaU6ShxFP+lCerCHxwgp/UwryXgg7zfaK73lFLBroy8
iHhdPi23v6a1OEPR41f8jhXkno/2gDirijicKaVB6HKAgkPyIgCnfe/rctFNJG1B
OzZLnmzWyuC5L6XGNU3pE0/NE7hqvj2aennOa0ec1ggyRRtJrYFPcKWP/oYiGjeD
f0Iy0rHf8UV8xs+6CCQJ37O8YF+Wz+zTSgolnpKDBXFbxvG7YJeEkKvtvfJ/8DkK
/rMQ4Qdfd0hRWh83ZUdRZntINTvlo9ZRu2qyW5pNYg2TO2SPWhIJXTYXiaGlXfQU
YtWwOxH5sVMMdlfncdlolU1L2YKAXg==
=jJQS
-----END PGP SIGNATURE-----

--BCEJL9ETl7nvuFthKnA7eLh5eio7DqH6G--
