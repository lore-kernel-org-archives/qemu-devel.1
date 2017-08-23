Received: from eggs.gnu.org ([2001:4830:134:3::10]:36283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkWWF-0004qf-Qt
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkWWE-0005dD-QF
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:20:31 -0400
References: <20170822125113.5025-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cbdf8d3f-8e30-bc18-a453-ba1529d850f5@redhat.com>
Date: Wed, 23 Aug 2017 09:20:15 -0500
MIME-Version: 1.0
In-Reply-To: <20170822125113.5025-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BUk3SBq2JhSOD7vbxuoh15thKF8bGjMhQ"
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
--BUk3SBq2JhSOD7vbxuoh15thKF8bGjMhQ
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cbdf8d3f-8e30-bc18-a453-ba1529d850f5@redhat.com>
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
> ---
> This should fix the issue that Dave is seeing but I'm concerned that
> there are more problems in nbd-client.c.  We don't have good
> abstractions for writing coroutine socket I/O code.  Something like Go'=
s
> channels would avoid manual low-level coroutine calls.  There is
> currently no way to cancel qio_channel_yield() so requests doing I/O ma=
y
> remain in-flight indefinitely and nbd-client.c doesn't join them...

Is this patch needed for 2.10-rc4, or does Fam's series cover the issue?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BUk3SBq2JhSOD7vbxuoh15thKF8bGjMhQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmdjyIACgkQp6FrSiUn
Q2pPSwf/bovwXXEGn8aQBzZQkPKKNbuOqKv+xIcsjVmux0r70QDpaUAqyAsy1NGM
1W6CB03WRPECG8qioC81hOVLM4bhp2QJd6DOYhcNNYIlcWvYBNPqonoT1hpKv1LI
RjGhOjD/WLdmOKr5ZP8PxvfS6r4ttML6Z4xnOSWucSpvWmdrU+cDPutWqDrkbOjZ
ZyJbCyKLjHQ4lUZCQZgbzkN3aKdLQvA0eHMFWK9k/gincbv5YOwBE3RZn52lZjJk
gFDG5QNI4TLDPgp+nPOfoEfmXxY9tSGyr4MkeQVFbkDBOGs4TQEBRPl9ZOvAIQLn
yThTtdAM6tUrKPIsRgx2byuew+qi+Q==
=ujn9
-----END PGP SIGNATURE-----

--BUk3SBq2JhSOD7vbxuoh15thKF8bGjMhQ--
