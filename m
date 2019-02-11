Received: from eggs.gnu.org ([209.51.188.92]:43038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtJYY-0006mA-Ax
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 16:56:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtJYU-0007ou-Fl
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 16:56:00 -0500
References: <20190211125601.86533-1-vsementsov@virtuozzo.com>
	<20190211125601.86533-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <487bcf49-65fb-16eb-0d0e-978fa324817a@redhat.com>
Date: Mon, 11 Feb 2019 15:55:15 -0600
MIME-Version: 1.0
In-Reply-To: <20190211125601.86533-4-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="p4GiDt0RticJIqjcC0BZyyYklKTtFYzkT"
Subject: Re: [Qemu-devel] [PATCH 3/4] nbd: do qemu_coroutine_yield during
 tls handshake
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p4GiDt0RticJIqjcC0BZyyYklKTtFYzkT
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <487bcf49-65fb-16eb-0d0e-978fa324817a@redhat.com>
Subject: Re: [PATCH 3/4] nbd: do qemu_coroutine_yield during tls handshake
References: <20190211125601.86533-1-vsementsov@virtuozzo.com>
 <20190211125601.86533-4-vsementsov@virtuozzo.com>
In-Reply-To: <20190211125601.86533-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/11/19 6:56 AM, Vladimir Sementsov-Ogievskiy wrote:
> We always call qio_channel_tls_handshake in nbd from couroutine. Take
> benefit of it and just yield instead of creating personal main loop.
>=20
> Mark and rename the function and it's callers correspondingly and
> trace-points too.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/client.c     | 26 +++++++++-----------------
>  nbd/common.c     |  6 ++----
>  nbd/server.c     | 45 +++++++++++++++++----------------------------
>  nbd/trace-events | 15 +++++++--------
>  4 files changed, 35 insertions(+), 57 deletions(-)
>=20
> diff --git a/nbd/client.c b/nbd/client.c
> index 2ba2220a4a..e3919be30e 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -578,13 +578,14 @@ static int nbd_request_simple_option(QIOChannel *=
ioc, int opt, Error **errp)
>      return 1;
>  }
> =20
> -static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
> -                                        QCryptoTLSCreds *tlscreds,
> -                                        const char *hostname, Error **=
errp)
> +static QIOChannel *nbd_co_receive_starttls(

Missing coroutine_fn ?

> +        QIOChannel *ioc, QCryptoTLSCreds *tlscreds, const char *hostna=
me,
> +        Error **errp)
>  {
>      int ret;
>      QIOChannelTLS *tioc;
> -    struct NBDTLSHandshakeData data =3D { 0 };
> +
> +    assert(qemu_in_coroutine());

Again, I'm not sure these assertions add much.

> =20
>      ret =3D nbd_request_simple_option(ioc, NBD_OPT_STARTTLS, errp);

Should we also be marking these helper functions as coroutine_fn by the
end of the series, once all callers are marked that way?

>      if (ret <=3D 0) {
> @@ -601,23 +602,13 @@ static QIOChannel *nbd_receive_starttls(QIOChanne=
l *ioc,
>          return NULL;
>      }
>      qio_channel_set_name(QIO_CHANNEL(tioc), "nbd-client-tls");
> -    data.loop =3D g_main_loop_new(g_main_context_default(), FALSE);
>      trace_nbd_receive_starttls_tls_handshake();
>      qio_channel_tls_handshake(tioc,
>                                nbd_tls_handshake,
> -                              &data,
> +                              qemu_coroutine_self(),
>                                NULL,
>                                NULL);
> -
> -    if (!data.complete) {
> -        g_main_loop_run(data.loop);
> -    }
> -    g_main_loop_unref(data.loop);
> -    if (data.error) {
> -        error_propagate(errp, data.error);
> -        object_unref(OBJECT(tioc));
> -        return NULL;
> -    }
> +    qemu_coroutine_yield();

Nice.

> +++ b/nbd/server.c
> @@ -668,16 +668,15 @@ static int nbd_negotiate_handle_info(NBDClient *c=
lient, uint16_t myflags,
> =20
>  /* Handle NBD_OPT_STARTTLS. Return NULL to drop connection, or else th=
e
>   * new channel for all further (now-encrypted) communication. */
> -static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
> -                                                 Error **errp)
> +static QIOChannel coroutine_fn *nbd_co_negotiate_handle_starttls(

Awkward split of the return type; the coroutine_fn should instead be
placed after the *, as in:

block/mirror.c:static MirrorOp *coroutine_fn active_write_prepare(...

> +        NBDClient *client, Error **errp)
>  {
>      QIOChannel *ioc;
>      QIOChannelTLS *tioc;
> -    struct NBDTLSHandshakeData data =3D { 0 };

All uses of this type have been deleted; you should also remove it from
nbd-internal.h.


> @@ -1093,7 +1082,7 @@ static int nbd_negotiate_options(NBDClient *clien=
t, uint16_t myflags,
>              return -EINVAL;
>          }
> =20
> -        trace_nbd_negotiate_options_check_option(option,
> +        trace_nbd_co_negotiate_options_check_option(option,
>                                                   nbd_opt_lookup(option=
));

Indentation looks off.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--p4GiDt0RticJIqjcC0BZyyYklKTtFYzkT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxh70MACgkQp6FrSiUn
Q2rUYwf/btZcE5rfsDwxs3DfPd/Yqq7+Zk0v5gExweYX8MKGLhC76Mt///dkx0rc
mOsGLHuq03+pM13zu9zCiitXoZF5O3FB9uVLgLrx2PrBfMuAGG1vylxRCT1aPNQO
35ar4SFS0cNNBKh8saKkdZXrIfbtbaCuZ8Q5VFxFhWgR1+3j2MueGb/ZG7uQZTlm
6Jlx7fl1ErqT26s4ImwcSJEQMFcg00u9CoTf8jyAmguAKkpsJ5VAcjQvxlZFVSjv
/pr5FSztsUMPL2ckzy8Drn3J4bZmzgtgClIWHv4MdlssuqpdcAdMyWK20KeyXg8g
Nacf9eFo/uutKOfyJu2gkmiKWDmsIQ==
=3Y1/
-----END PGP SIGNATURE-----

--p4GiDt0RticJIqjcC0BZyyYklKTtFYzkT--
