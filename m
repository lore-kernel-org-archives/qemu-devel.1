Received: from eggs.gnu.org ([2001:4830:134:3::10]:55274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2lFb-0001QQ-8u
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:42:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2lFa-0006Pf-A9
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:42:43 -0400
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
	<20171012095319.136610-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2250c65b-e347-5404-10de-4da240487fb3@redhat.com>
Date: Thu, 12 Oct 2017 16:42:31 -0500
MIME-Version: 1.0
In-Reply-To: <20171012095319.136610-5-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dN0EIEngUa6V3TfAoTKbXD7G44jLm1IMI"
Subject: Re: [Qemu-devel] [PATCH v3 04/13] nbd/server: structurize simple
 reply header sending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dN0EIEngUa6V3TfAoTKbXD7G44jLm1IMI
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <2250c65b-e347-5404-10de-4da240487fb3@redhat.com>
Subject: Re: [PATCH v3 04/13] nbd/server: structurize simple reply header
 sending
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
 <20171012095319.136610-5-vsementsov@virtuozzo.com>
In-Reply-To: <20171012095319.136610-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/2017 04:53 AM, Vladimir Sementsov-Ogievskiy wrote:
> Use packed structure instead of pointer arithmetics.

English is fun!  In the subject line, I'm fairly certain that
"structurize" is not likely to be in any dictionary, yet it is a perfect
word describing the patch, so I'm not touching it ;)

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/nbd.h |  6 ++++++
>  nbd/server.c        | 36 ++++++++++++++----------------------
>  2 files changed, 20 insertions(+), 22 deletions(-)
>=20

> +++ b/nbd/server.c
> @@ -902,26 +902,6 @@ static int nbd_receive_request(QIOChannel *ioc, NB=
DRequest *request,
>      return 0;
>  }
> =20
> -static int nbd_send_reply(QIOChannel *ioc, NBDReply *reply, Error **er=
rp)
> -{
> -    uint8_t buf[NBD_REPLY_SIZE];
> -
> -    reply->error =3D system_errno_to_nbd_errno(reply->error);
> -
> -    trace_nbd_send_reply(reply->error, reply->handle);

We lose a trace here...

>  static int nbd_co_send_simple_reply(NBDRequestData *req, NBDReply *rep=
ly,
>                                      int len, Error **errp)
>  {
>      NBDClient *client =3D req->client;
> +    NBDSimpleReply simple_reply;
>      int ret;
> =20
>      g_assert(qemu_in_coroutine());
> =20
>      trace_nbd_co_send_simple_reply(reply->handle, reply->error, len);
> =20
> +    set_be_simple_reply(&simple_reply, system_errno_to_nbd_errno(reply=
->error),
> +                        reply->handle);
> +

=2E..but it always occurred immediately after another trace that has
redundant information (well, the trace you kept shows pre- rather than
post-translation of errno value to NBD wire value, and the trace you
drop didn't show length).  I'm fine with the reduction, but it needs a
tweak to trace-events to reap the dead trace.

With that change,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--dN0EIEngUa6V3TfAoTKbXD7G44jLm1IMI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnf4ccACgkQp6FrSiUn
Q2oGYAf9E6gAi0OrxeJYJYm/aVHKZXaoWVQdLOyZZROq3EeY3tSGVQ0fFivihLjT
mWAGbWLYDhuhd7Ilx3MPPuuRBD416QDG3hbWLlQx6aL4uVpi7I8Xez/WOUaw1sSF
LYxQkjox+VntAfhZGRtA4BA2p966AEU8mLqyME0MWYvNlypdUGIBZFeDSCzul25Q
bz0/tSUvzozIbMK8Q8MfNilEb9b7X7anD5hFJ8KxSS7zjMV08FG4BepIqLDf0A9F
VHIx+JUYE+r8TDI9nZuTi54xYOXdfZIRcMyZqAJ4IlZPnQuiYCUYBsd96c879xsU
PG2juCoIAZ87+NqUyvUVkE+/GYcE2g==
=uNQ5
-----END PGP SIGNATURE-----

--dN0EIEngUa6V3TfAoTKbXD7G44jLm1IMI--
