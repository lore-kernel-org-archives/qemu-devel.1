Received: from eggs.gnu.org ([209.51.188.92]:37106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtJHe-0003bL-Jv
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 16:38:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtJHV-0006nc-1s
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 16:38:30 -0500
References: <20190211125601.86533-1-vsementsov@virtuozzo.com>
	<20190211125601.86533-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9cf487db-acce-723e-3cf4-22485e4bb118@redhat.com>
Date: Mon, 11 Feb 2019 15:38:11 -0600
MIME-Version: 1.0
In-Reply-To: <20190211125601.86533-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="n7SFRrTJDfgizfVqwOBHdBwsNylWZYxUM"
Subject: Re: [Qemu-devel] [PATCH 2/4] nbd/client: do negotiation in coroutine
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
--n7SFRrTJDfgizfVqwOBHdBwsNylWZYxUM
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <9cf487db-acce-723e-3cf4-22485e4bb118@redhat.com>
Subject: Re: [PATCH 2/4] nbd/client: do negotiation in coroutine
References: <20190211125601.86533-1-vsementsov@virtuozzo.com>
 <20190211125601.86533-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190211125601.86533-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/11/19 6:55 AM, Vladimir Sementsov-Ogievskiy wrote:
> As a first step to non-blocking negotiation, move it to coroutine.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/client.c | 123 +++++++++++++++++++++++++++++++++++++++++++++------=

>  1 file changed, 109 insertions(+), 14 deletions(-)
>=20
> diff --git a/nbd/client.c b/nbd/client.c
> index 10a52ad7d0..2ba2220a4a 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -859,13 +859,14 @@ static int nbd_list_meta_contexts(QIOChannel *ioc=
,
>   *          2: server is newstyle, but lacks structured replies
>   *          3: server is newstyle and set up for structured replies
>   */
> -static int nbd_start_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscr=
eds,
> -                               const char *hostname, QIOChannel **outi=
oc,
> -                               bool structured_reply, bool *zeroes,
> -                               Error **errp)
> +static int coroutine_fn nbd_co_start_negotiate(
> +        QIOChannel *ioc, QCryptoTLSCreds *tlscreds, const char *hostna=
me,
> +        QIOChannel **outioc, bool structured_reply, bool *zeroes, Erro=
r **errp)
>  {
>      uint64_t magic;
> =20
> +    assert(qemu_in_coroutine());
> +

Do we need this assert, since this function is static, and only called by=
:

>      trace_nbd_start_negotiate(tlscreds, hostname ? hostname : "<null>"=
);
> =20
>      if (zeroes) {
> @@ -990,19 +991,20 @@ static int nbd_negotiate_finish_oldstyle(QIOChann=
el *ioc, NBDExportInfo *info,
>   * Returns: negative errno: failure talking to server
>   *          0: server is connected
>   */
> -int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
> -                          const char *hostname, QIOChannel **outioc,
> -                          NBDExportInfo *info, Error **errp)
> +static int coroutine_fn nbd_co_receive_negotiate(
> +        QIOChannel *ioc, QCryptoTLSCreds *tlscreds, const char *hostna=
me,
> +        QIOChannel **outioc, NBDExportInfo *info, Error **errp)
>  {
>      int result;
>      bool zeroes;
>      bool base_allocation =3D info->base_allocation;
> =20
> +    assert(qemu_in_coroutine());
>      assert(info->name);
>      trace_nbd_receive_negotiate_name(info->name);
> =20
> -    result =3D nbd_start_negotiate(ioc, tlscreds, hostname, outioc,
> -                                 info->structured_reply, &zeroes, errp=
);
> +    result =3D nbd_co_start_negotiate(ioc, tlscreds, hostname, outioc,=

> +                                   info->structured_reply, &zeroes, er=
rp);

other functions in the same file that have also made the same assertion?
 For that matter, does the assert() add any value over the fact that we
already annotated things as coroutine_fn?

I know that at some point, there was a proposal on the list for having
the compiler enforce coroutine_fn annotations (ensuring that a
coroutine_fn only calls other coroutine_fns, and that coroutines can
only be started on an entry point properly marked), but that's a
different task for another day.


> +static int nbd_receive_common(CoroutineEntry *entry,
> +                              NbdReceiveNegotiateCo *data)
> +{
> +    data->ret =3D -EINPROGRESS;
> +
> +    if (qemu_in_coroutine()) {
> +        entry(data);
> +    } else {
> +        AioContext *ctx =3D qio_channel_get_attached_aio_context(data-=
>ioc);
> +        bool attach =3D !ctx;

There's where you used the function added in 1/4.

> +
> +        if (attach) {
> +            ctx =3D qemu_get_current_aio_context();
> +            qio_channel_attach_aio_context(data->ioc, ctx);
> +        }
> +
> +        qemu_aio_coroutine_enter(ctx, qemu_coroutine_create(entry, dat=
a));
> +        AIO_WAIT_WHILE(ctx, data->ret =3D=3D -EINPROGRESS);
> +
> +        if (attach) {
> +            qio_channel_detach_aio_context(data->ioc);
> +        }
> +    }
> +
> +    return data->ret;
> +}

Looks reasonable.

> +
> +int nbd_receive_negotiate(
> +        QIOChannel *ioc, QCryptoTLSCreds *tlscreds, const char *hostna=
me,
> +        QIOChannel **outioc, NBDExportInfo *info, Error **errp)
> +{

Why the reflowed parameter list, compared to its existing listing (as
shown by the - lines where you added nbd_receive_co_negotiate)? That's
only cosmetic, so I can live with it, but it seems like it makes the
diff slightly larger.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--n7SFRrTJDfgizfVqwOBHdBwsNylWZYxUM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxh60MACgkQp6FrSiUn
Q2ri2Af/Yqyi1v2beebgISEH+t1YxaKLqGAhnUHvoZdlsUrEFZG5gSiV/FNzwD4x
WOuJ+QDUzOYUb1qHiiAaDjhitYex225JlRW6/Sd7McTLivKoBooIbJnJfOvWwVTL
GNAy52qY+Yl+zS2uN87CysY5yNGNdn6TdAsmJCLUZcUIjD2SOs20FrvECGfID6Cc
bWs7m55iZpJhFY55cRg0O6u6lgPNW2TUo+lFJ7RJWDRIgdidh4vwEg40Qbp8KNrM
rQ97A0bDMdud8ipy2XPp9rb8r5lH3wmfSpjdusaoeHnsDQZ0OddDuAdMWeKGYmrt
0c7MX0U2va8LPC4EjFIyg7cAksYyQw==
=e/Tr
-----END PGP SIGNATURE-----

--n7SFRrTJDfgizfVqwOBHdBwsNylWZYxUM--
