Received: from eggs.gnu.org ([2001:4830:134:3::10]:59589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dhd9w-0000tJ-Ml
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:49:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dhd9s-0007aL-5X
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:49:32 -0400
Date: Tue, 15 Aug 2017 15:49:10 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170815144910.GA14000@stefanha-x1.localdomain>
References: <20170814213426.24681-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <20170814213426.24681-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10 v2] nbd-client: Fix
 regression when server sends garbage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2017 at 04:34:26PM -0500, Eric Blake wrote:
> When we switched NBD to use coroutines for qemu 2.9 (in particular,
> commit a12a712a), we introduced a regression: if a server sends us
> garbage (such as a corrupted magic number), we quit the read loop
> but do not stop sending further queued commands, resulting in the
> client hanging when it never reads the response to those additional
> commands.  In qemu 2.8, we properly detected that the server is no
> longer reliable, and cancelled all existing pending commands with
> EIO, then tore down the socket so that all further command attempts
> get EPIPE.
>=20
> Restore the proper behavior of quitting (almost) all communication
> with a broken server: Once we know we are out of sync or otherwise
> can't trust the server, we must assume that any further incoming
> data is unreliable and therefore end all pending commands with EIO,
> and quit trying to send any further commands.  As an exception, we
> still (try to) send NBD_CMD_DISC to let the server know we are going
> away (in part, because it is easier to do that than to further
> refactor nbd_teardown_connection, and in part because it is the
> only command where we do not have to wait for a reply).
>=20
> Based on a patch by Vladimir Sementsov-Ogievskiy.
>=20
> A malicious server can be created with the following hack,
> followed by setting NBD_SERVER_DEBUG to a non-zero value in the
> environment when running qemu-nbd:
>=20
> | --- a/nbd/server.c
> | +++ b/nbd/server.c
> | @@ -919,6 +919,17 @@ static int nbd_send_reply(QIOChannel *ioc, NBDRepl=
y *reply, Error **errp)
> |      stl_be_p(buf + 4, reply->error);
> |      stq_be_p(buf + 8, reply->handle);
> |
> | +    static int debug;
> | +    static int count;
> | +    if (!count++) {
> | +        const char *str =3D getenv("NBD_SERVER_DEBUG");
> | +        if (str) {
> | +            debug =3D atoi(str);
> | +        }
> | +    }
> | +    if (debug && !(count % debug)) {
> | +        buf[0] =3D 0;
> | +    }
> |      return nbd_write(ioc, buf, sizeof(buf), errp);
> |  }
>=20
> Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>=20
> Supercedes both Vladimir and my earlier attempts:
> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02131.html
> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg01501.html
>=20
>  block/nbd-client.h |  1 +
>  block/nbd-client.c | 14 ++++++++++----
>  2 files changed, 11 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZkwnmAAoJEJykq7OBq3PI+CAIAKLV/py0dDbbs6QhFn0gt9iJ
ovjwKt5tZ2r8Ff3JvHOFQD3qpEHtPOUMJl0bao4VPW2KtyHA2JgAKhU/hmQDJ6ld
dBzJ+2VpnsoOK8MTO0CHKao7tiUZKeX8d8s79dv69BzNREJnY2Bjq8cq3jTQhtcN
yDsjGb1HCPKKAcSPOzXwy8VlIWQPHAoow0xJlIBlwu2K3jnDzhHQRdhgZhvCLIo3
KqlkRcisHbp5SXJQ/+9IwG1ptTnLnECsxASfBtQWRQ0UdHxBo0O4Y4tx5fmHa0DG
mkErVS8F8pdAY1CMpwx7fnI4NFwBtD/wz5ApXp70tkLe4NwbV4/NuAbavdOA2JM=
=fuuN
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
