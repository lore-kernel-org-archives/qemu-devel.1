Received: from eggs.gnu.org ([2001:4830:134:3::10]:45936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQeSQ-0004E4-9t
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQeSM-0006Yq-CC
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:46:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dQeSM-0006YU-21
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:46:22 -0400
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
	<20170621153424.16690-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <945a762c-bf5b-ab71-cea2-790f7fd311f5@redhat.com>
Date: Thu, 29 Jun 2017 13:46:16 -0500
MIME-Version: 1.0
In-Reply-To: <20170621153424.16690-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1CRbwfbVX0Se85VfsBouxoL1OvTQL6la4"
Subject: Re: [Qemu-devel] [PATCH v2 1/6] nbd/server: nbd_negotiate: return 1
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
Cc: stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1CRbwfbVX0Se85VfsBouxoL1OvTQL6la4
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <945a762c-bf5b-ab71-cea2-790f7fd311f5@redhat.com>
Subject: Re: [PATCH v2 1/6] nbd/server: nbd_negotiate: return 1 on
 NBD_OPT_ABORT
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
 <20170621153424.16690-2-vsementsov@virtuozzo.com>
In-Reply-To: <20170621153424.16690-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/21/2017 10:34 AM, Vladimir Sementsov-Ogievskiy wrote:
> Separate case when client sent NBD_OPT_ABORT from other errors.

Commit messages are best written in imperative tense (you can supply an
implicit "apply this patch in order to" prefix in front of the message,
and it should still generally read well); and that doesn't mix well with
past-tense descriptions.  I might have written:

Separate the case when a client sends NBD_OPT_ABORT from all other errors=
=2E

> It will be needed for the following patch, where errors will be
> reported.
> Considered case is not actually the error - it honestly follows NBD
> protocol. Therefore it should not be reported like an error.

This particular case is not actually an error - it honestly follows the
NBD protocol.

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>=20

> -
> -/* Process all NBD_OPT_* client option commands.
> - * Return -errno on error, 0 on success. */
> +/* nbd_negotiate_options
> + * Process all NBD_OPT_* client option commands.
> + * Return:
> + * -errno  on error
> + * 0       on successful negotiation
> + * 1       if client sent NBD_OPT_ABORT, i.e. on legal disconnect

"legal" often comes with connotations about law (and I don't want to get
mired in an open-source law discussion); I'd stick with "valid".

> + */
>  static int nbd_negotiate_options(NBDClient *client)
>  {
>      uint32_t flags;
> @@ -459,7 +463,7 @@ static int nbd_negotiate_options(NBDClient *client)=

>                  }
>                  /* Let the client keep trying, unless they asked to qu=
it */
>                  if (clientflags =3D=3D NBD_OPT_ABORT) {
> -                    return -EINVAL;
> +                    return 1;

Note: the reason we don't try to send an NBD_REP_ACK here (a guest that
forgot to start the TLS handshake) is because we don't want to ever
return NBD_REP_ACK when we are going to require TLS.  It's a bit odd
that we don't reply here, but DO reply to all other NBD_OPT_ABORT, but I
don't think it makes us any less compliant to the spec.

>                  }
>                  break;
>              }
> @@ -477,7 +481,7 @@ static int nbd_negotiate_options(NBDClient *client)=

>                   * disconnecting, but that we must also tolerate
>                   * guests that don't wait for our reply. */
>                  nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK, clien=
tflags);
> -                return -EINVAL;
> +                return 1;

If anything, we may want (as a separate patch) to add a comment to our
TLS behavior as to why we don't reply with NBD_REP_ACK.  But doesn't
affect this patch.

> =20
>              case NBD_OPT_EXPORT_NAME:
>                  return nbd_negotiate_handle_export_name(client, length=
);
> @@ -533,6 +537,12 @@ static int nbd_negotiate_options(NBDClient *client=
)
>      }
>  }
> =20
> +/* nbd_negotiate
> + * Return:
> + * -errno  on error
> + * 0       on successful negotiation
> + * 1       if client sent NBD_OPT_ABORT, i.e. on legal disconnect

Again on the wording.  With that touched up,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1CRbwfbVX0Se85VfsBouxoL1OvTQL6la4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVUr5AAoJEKeha0olJ0NqXZAH/j5B6zOcJ3MFXKEMN+UuZBiA
7CCS1KE4H4hhgvkp3GdLFFMR+Vm9q0X7Gbb1uFguHxb3n/eFQNjC7QQ1pz2dQmSO
d0QMYG9HOYZ8GjWTq0vBBgmOJa4TVP1owLDBUMYY81D6NpPDgM9KlSVAYOYjYmdg
xAPX4yN/SHYK8o8t4IUVVHeuIsl1YtcVmvAdJ4Bed0KoGfW1KRXObe3EVdjvYvWn
25RhAE7003D65fCKFjLe7ysRrX5e2xidtgNJCx2O+X3l3IXOedtEiWPBqG+KhoTc
u2JQWYeoU6oGx2uMQ2GuavEGGEdOJixpLC2vWMqjsabYRrbCzHcouc85I86pDBg=
=DgQm
-----END PGP SIGNATURE-----

--1CRbwfbVX0Se85VfsBouxoL1OvTQL6la4--
