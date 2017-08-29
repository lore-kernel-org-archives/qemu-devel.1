Received: from eggs.gnu.org ([2001:4830:134:3::10]:59051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmlx3-0004jW-Ok
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 15:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmlx2-0002a9-KP
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 15:13:29 -0400
References: <20170829122745.14309-1-stefanha@redhat.com>
	<20170829122745.14309-2-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cac1b4fa-1774-0871-ad93-1983aed8da68@redhat.com>
Date: Tue, 29 Aug 2017 14:13:16 -0500
MIME-Version: 1.0
In-Reply-To: <20170829122745.14309-2-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tO9m19jCn9x7tL2M4o4wBHMkLrCEFG9H7"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] nbd-client: avoid read_reply_co
 entry if send failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tO9m19jCn9x7tL2M4o4wBHMkLrCEFG9H7
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Message-ID: <cac1b4fa-1774-0871-ad93-1983aed8da68@redhat.com>
Subject: Re: [PATCH v2 1/3] nbd-client: avoid read_reply_co entry if send
 failed
References: <20170829122745.14309-1-stefanha@redhat.com>
 <20170829122745.14309-2-stefanha@redhat.com>
In-Reply-To: <20170829122745.14309-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/29/2017 07:27 AM, Stefan Hajnoczi wrote:
> The following segfault is encountered if the NBD server closes the UNIX=

> domain socket immediately after negotiation:
>=20

>=20
> In the mean time blk_co_preadv() can be called and nbd_coroutine_end()
> calls aio_wake() on read_reply_co.  At this point in time
> read_reply_co's ctx isn't set because it has never been entered yet.
>=20
> This patch simplifies the nbd_co_send_request() ->
> nbd_co_receive_reply() -> nbd_coroutine_end() lifecycle to just
> nbd_co_send_request() -> nbd_co_receive_reply().  The request is "ended=
"
> if an error occurs at any point.  Callers no longer have to invoke
> nbd_coroutine_end().

Vladimir's work also eliminated a separate call to nbd_coroutine_end.
There will be some interesting rebase issues to resolve between the two,
but I think we'll get there.

>=20
> This cleanup also eliminates the segfault because we don't call
> aio_co_schedule() to wake up s->read_reply_co if sending the request
> failed.  It is only necessary to wake up s->read_reply_co if a reply wa=
s
> received.
>=20
> Note this only happens with UNIX domain sockets on Linux.  It doesn't
> seem possible to reproduce this with TCP sockets.
>=20
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/nbd-client.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--tO9m19jCn9x7tL2M4o4wBHMkLrCEFG9H7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmlvM0ACgkQp6FrSiUn
Q2pb4gf8CE00iz42HyGeLinrqSPHtwopBlWOXH22YGmVOc62TWRWY3yUYdJ3A5Wn
Y/YKhWBHsnyi5OadB2D1SPbpfEgBzSYMcR0Z/hl2dviBr37H83Ew5pZm9i+waYoR
GrMDMSfwJqJYSdPzwi5tXrzdLsPRUV8NGTH2W+a6ir/lN3EhS1NIcqAG3HuS8WqV
zyFtdrXSS/QgRhvIBeSUI5lGxlBLOMVzdwJzwnmdu9CvN9vmZE39FI7ZalqUqt03
9jYH9lVlYjZ4Wc1SQW1gjpZ1wCh34yzahW1MHy0/TZKGkqOTSU5enQXek7T8eezB
eGdu58gl81M8cgjKKbft31UNgRmBmA==
=gCBX
-----END PGP SIGNATURE-----

--tO9m19jCn9x7tL2M4o4wBHMkLrCEFG9H7--
