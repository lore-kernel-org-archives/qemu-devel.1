Received: from eggs.gnu.org ([2001:4830:134:3::10]:58391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGYep-0004DS-A0
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:33:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGYeo-0000xP-6C
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:33:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dGYen-0000x0-Ty
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:33:30 -0400
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
	<20170530143052.165002-15-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <05dd8425-2773-0396-1532-e25c737c3753@redhat.com>
Date: Thu, 1 Jun 2017 17:33:27 -0500
MIME-Version: 1.0
In-Reply-To: <20170530143052.165002-15-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gGNt06uIuPer8oECKcewqxAbijrMh91ci"
Subject: Re: [Qemu-devel] [PATCH 14/19] nbd/server: nbd_negotiate: return 1
 on NBD_OPT_ABORT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gGNt06uIuPer8oECKcewqxAbijrMh91ci
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
Message-ID: <05dd8425-2773-0396-1532-e25c737c3753@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 14/19] nbd/server: nbd_negotiate: return 1 on
 NBD_OPT_ABORT
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
 <20170530143052.165002-15-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-15-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 09:30 AM, Vladimir Sementsov-Ogievskiy wrote:
> Separate case when client sent NBD_OPT_ABORT from other errors.
> It will be needed for the following patch, where errors will be
> reported.
> Considered case is not actually the error - it honestly follows NBD
> protocol. Therefore it should not be reported like an error.
> -EPIPE case means client not read server reply on NBD_OPT_ABORT,
> which is also OK.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/nbd/server.c b/nbd/server.c
> index 30dfb81a5c..0e53d3dd91 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -369,9 +369,13 @@ static QIOChannel *nbd_negotiate_handle_starttls(N=
BDClient *client,
>      return QIO_CHANNEL(tioc);
>  }
> =20
> -
> -/* Process all NBD_OPT_* client option commands.
> - * Return -errno on error, 0 on success. */
> +/* nbd_negotiate_options
> + * Process all NBD_OPT_* client option commands.
> + * Return:
> + * < 0 on error

Do you want to be specific that this is a negative errno value, or is it
just any negative value with no correlation to errno?

> + * 0   on successful negotiation
> + * 1   if client sent NBD_OPT_ABORT, i.e. on legal disconnect
> + */
>  static int nbd_negotiate_options(NBDClient *client)
>  {
>      int ret;
> @@ -483,7 +487,7 @@ static int nbd_negotiate_options(NBDClient *client)=

>                  }
>                  /* Let the client keep trying, unless they asked to qu=
it */
>                  if (clientflags =3D=3D NBD_OPT_ABORT) {
> -                    return -EINVAL;
> +                    return 1;
>                  }
>                  break;
>              }
> @@ -502,7 +506,7 @@ static int nbd_negotiate_options(NBDClient *client)=

>                   * guests that don't wait for our reply. */
>                  ret =3D nbd_negotiate_send_rep(client->ioc, NBD_REP_AC=
K,
>                                               clientflags);
> -                return ret < 0 ? ret : -EINVAL;
> +                return ret < 0 && ret !=3D -EPIPE ? ret : 1;

This should just be 'return 1;', which means you don't need to capture
and check 'ret'.

> =20
>              case NBD_OPT_EXPORT_NAME:
>                  return nbd_negotiate_handle_export_name(client, length=
);
> @@ -560,6 +564,12 @@ static int nbd_negotiate_options(NBDClient *client=
)
>      }
>  }
> =20
> +/* nbd_negotiate
> + * Return:
> + * < 0 on error

Again, if this is reliably a negative errno, specifically document that.

> + * 0   on successful negotiation
> + * 1   if client sent NBD_OPT_ABORT, i.e. on legal disconnect
> + */
>  static coroutine_fn int nbd_negotiate(NBDClient *client)
>  {
>      char buf[8 + 8 + 8 + 128];
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gGNt06uIuPer8oECKcewqxAbijrMh91ci
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZMJY3AAoJEKeha0olJ0NqzLsH/24P2TJRBQw63XnR/IMQXAG0
MMe4ojuWGKX7GNlt4BWJuH2imxjgurgvuWqFygySPiDELZsFzmKUwSFccXxTX8+r
Rq7jk4lmsIq3MSeL4H8K+XFtp16oQTvtqDBCLYfNm7EVThG7pn31Z8zmFBNavCMp
hQ59fpERCcEshwU+axSeh+AX6poAhEhSCL9B/vH2cDw0Ekbt8Z6r3G7xeoPI1Qob
B5G/0s0+eo4vf9tkykfxq8rCHxbrP9r2EHTF1AYP1mnnVAaNt7NXIIRawiOH18go
HahjiCJu+e0PeGC1stHbxD+/FPufYix0JsiQljSylCTFmCtOrQ6nygrzY0BFqe8=
=5koE
-----END PGP SIGNATURE-----

--gGNt06uIuPer8oECKcewqxAbijrMh91ci--
