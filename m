Received: from eggs.gnu.org ([2001:4830:134:3::10]:54756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQf63-0004FF-Qr
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQf5z-0007W0-PD
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:27:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dQf5z-0007Vk-GX
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:27:19 -0400
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
	<20170621153424.16690-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <695de534-7f65-c6cc-00ac-4d35e3eb6e7d@redhat.com>
Date: Thu, 29 Jun 2017 14:27:13 -0500
MIME-Version: 1.0
In-Reply-To: <20170621153424.16690-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tAWKPv0t6oP6UkCjPIXcqfKPU2W4ImBrU"
Subject: Re: [Qemu-devel] [PATCH v2 2/6] nbd/server: use errp instead of LOG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tAWKPv0t6oP6UkCjPIXcqfKPU2W4ImBrU
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <695de534-7f65-c6cc-00ac-4d35e3eb6e7d@redhat.com>
Subject: Re: [PATCH v2 2/6] nbd/server: use errp instead of LOG
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
 <20170621153424.16690-3-vsementsov@virtuozzo.com>
In-Reply-To: <20170621153424.16690-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/21/2017 10:34 AM, Vladimir Sementsov-Ogievskiy wrote:
> Move to modern errp scheme from just LOGging errors.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 268 +++++++++++++++++++++++++++++++++++----------------=
--------
>  1 file changed, 161 insertions(+), 107 deletions(-)

Unfortunately longer, but I'm okay with that (and we already did it
client-side, so this is just a case of a patch series being spread out
over time).


> =20
>  /* Send an error reply.
>   * Return -errno on error, 0 on success. */
> -static int GCC_FMT_ATTR(4, 5)
> +static int GCC_FMT_ATTR(5, 6)
>  nbd_negotiate_send_rep_err(QIOChannel *ioc, uint32_t type,
> -                           uint32_t opt, const char *fmt, ...)
> +                           uint32_t opt, Error **errp, const char *fmt=
, ...)
>  {

Markus, this violates our usual idiom of errp last in code that is not
directly operating on an Error (the actual Error implementation in
error.c being the main obvious exception that lists errp first), but I
don't see any better approach. Do you have any thoughts on it?

> -    if (nbd_read(client->ioc, name, length, NULL) < 0) {
> -        LOG("read failed");
> +    if (nbd_read(client->ioc, name, length, errp) < 0) {
> +        error_prepend(errp, "read failed: ");
>          return -EINVAL;
>      }

I'm still not convinced we need quite as many error_prepend() calls (it
may be simpler to just use the underlying error message as-is, without
trying to prepend) - but deciding where it is fluff is a cleanup while
this patch is all about a mechanical conversion, so I'm not going to
hold up this patch while we solve that debate.


>      tioc =3D qio_channel_tls_new_server(ioc,
>                                        client->tlscreds,
>                                        client->tlsaclname,
> -                                      NULL);
> +                                      errp);

Yay for wiring things up to no longer ignore original error messages.

> @@ -352,14 +367,16 @@ static QIOChannel *nbd_negotiate_handle_starttls(=
NBDClient *client,
>  /* nbd_negotiate_options
>   * Process all NBD_OPT_* client option commands.
>   * Return:
> - * -errno  on error
> - * 0       on successful negotiation
> - * 1       if client sent NBD_OPT_ABORT, i.e. on legal disconnect
> + * -errno  on error, errp is set
> + * 0       on successful negotiation, errp is not set
> + * 1       if client sent NBD_OPT_ABORT, i.e. on legal disconnect,
> + *         errp is not set

You'll have some rebase churn based on my comments on 1/6 (where I
suggested s/legal/valid/).  I'm not sure the change about documenting
whether errp is set is even necessary (we have enough common usage of
errp, that it is kind of easy to just assume that everyone knows errp is
set only on negative return); but it doesn't hurt to keep it.

> @@ -480,25 +497,33 @@ static int nbd_negotiate_options(NBDClient *clien=
t)
>                  /* NBD spec says we must try to reply before
>                   * disconnecting, but that we must also tolerate
>                   * guests that don't wait for our reply. */
> -                nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK, clien=
tflags);
> +                nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK, clien=
tflags,
> +                                       &local_err);
> +
> +                if (local_err !=3D NULL) {
> +                    TRACE("Reply to NBD_OPT_ABORT request failed: %s",=

> +                          error_get_pretty(local_err));
> +                    error_free(local_err);
> +                }
> +

Not sure this is necessary.  I would have just used:

nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK, clientflags, NULL);

and then you don't even need a local_err variable.


> @@ -1089,6 +1121,7 @@ static coroutine_fn void nbd_trip(void *opaque)
>      int ret;
>      int flags;
>      int reply_data_len =3D 0;
> +    Error *local_err =3D NULL;
> =20
>      TRACE("Reading request.");
>      if (client->closing) {
> @@ -1097,7 +1130,7 @@ static coroutine_fn void nbd_trip(void *opaque)

> @@ -1128,7 +1161,7 @@ static coroutine_fn void nbd_trip(void *opaque)
>          if (request.flags & NBD_CMD_FLAG_FUA) {
>              ret =3D blk_co_flush(exp->blk);
>              if (ret < 0) {
> -                LOG("flush failed");
> +                error_setg_errno(&local_err, -ret, "flush failed");
>                  reply.error =3D -ret;
>                  break;
>              }

>  reply:
> +    if (local_err) {
> +        /* If we are here local_err is not fatal error, already stored=
 in
> +         * reply.error */
> +        error_report_err(local_err);
> +        local_err =3D NULL;
> +    }

So we still end up printing the error directly to stderr, the way LOG()
used to do; but in light of the recent CVEs on 'qemu-nbd -t' not being
robust to misbehaved clients, it does feel like the right thing (the
server detecting an error does not mean that the server should quit,
merely that it should log that a client is no longer connected).

Overall the change looks good to me, but I'll wait to see if Markus has
any design advice before giving my R-b.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--tAWKPv0t6oP6UkCjPIXcqfKPU2W4ImBrU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVVSRAAoJEKeha0olJ0NqRBsIALCM66tKkNgSQR+YgIWnvApd
LXTPoZ3mMAVZ+z9qCGKU4qBltNPDensmGhdhFgupkePpt5Q/9sIMrj7+gH/VczfO
++mGoFxYYZVrUP8RHLHHGwuKfQvnODPms7aIlWO6nir+Kq+k0cFG1tY70PKudL05
BTCMyaA8TUNhHyzcPlEZ6EFNvRwY8CgDOAUup5AGkoDTR5CgBDrB6bl3YuEY873b
Ta0QCn45l+mHpWrMGUtyz9SufquYGt5TUCOVH7UdaKjbFQ7WVQDwY3D06TO+tQ+F
VcqnyFZNTWIXsY2O/JOItS3n7k6u68OIWJwkRlgKi0mCdgS8Wjkz2anO1EchOqE=
=TORm
-----END PGP SIGNATURE-----

--tAWKPv0t6oP6UkCjPIXcqfKPU2W4ImBrU--
