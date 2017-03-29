Received: from eggs.gnu.org ([2001:4830:134:3::10]:37612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctJ2F-0007z8-M9
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctJ2E-0003zZ-C5
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:13:35 -0400
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-4-git-send-email-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <58b223ea-7e67-e5f9-9631-1b3c0dc79835@redhat.com>
Date: Wed, 29 Mar 2017 21:13:24 +0200
MIME-Version: 1.0
In-Reply-To: <1490805920-17029-4-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uUeunhEQJMdaar8l9udDqVpLuDSPDxeAB"
Subject: Re: [Qemu-devel] [for-2.9 3/8] io vnc sockets: Clean up
 SocketAddressKind switches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uUeunhEQJMdaar8l9udDqVpLuDSPDxeAB
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com,
 pbonzini@redhat.com
Message-ID: <58b223ea-7e67-e5f9-9631-1b3c0dc79835@redhat.com>
Subject: Re: [for-2.9 3/8] io vnc sockets: Clean up SocketAddressKind switches
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
 <1490805920-17029-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1490805920-17029-4-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 29.03.2017 18:45, Markus Armbruster wrote:
> We have quite a few switches over SocketAddressKind.  Some have case
> labels for all enumeration values, others rely on a default label.
> Some abort when the value isn't a valid SocketAddressKind, others
> report an error then.
>=20
> Unify as follows.  Always provide case labels for all enumeration
> values, to clarify intent.  Abort when the value isn't a valid
> SocketAddressKind, because the program state is messed up then.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  io/dns-resolver.c   |  6 ++++--
>  ui/vnc.c            | 10 ++++++++--
>  util/qemu-sockets.c |  4 +---
>  3 files changed, 13 insertions(+), 7 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

Nit-picks below, as can be expected of me.

> diff --git a/io/dns-resolver.c b/io/dns-resolver.c
> index 0ac6b23..00fb575 100644
> --- a/io/dns-resolver.c
> +++ b/io/dns-resolver.c
> @@ -164,9 +164,11 @@ int qio_dns_resolver_lookup_sync(QIODNSResolver *r=
esolver,
>                                                  addrs,
>                                                  errp);
> =20
> +    case SOCKET_ADDRESS_KIND_FD:
> +        error_setg(errp, "Unsupported socket address type 'fd'");
> +        return -1;

Could do with an empty line here like the other cases have.

>      default:
> -        error_setg(errp, "Unknown socket address kind");
> -        return -1;
> +        abort();
>      }
>  }
> =20
> diff --git a/ui/vnc.c b/ui/vnc.c
> index fe0a46a..b6b58c4 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -129,10 +129,13 @@ static void vnc_init_basic_info(SocketAddress *ad=
dr,
>          info->family =3D NETWORK_ADDRESS_FAMILY_UNIX;
>          break;
> =20
> -    default:
> +    case SOCKET_ADDRESS_KIND_VSOCK:
> +    case SOCKET_ADDRESS_KIND_FD:
>          error_setg(errp, "Unsupported socket kind %d",
>                     addr->type);

Pre-existing, but: %s and SocketAddressKind_lookup[addr->type] would be
nicer.

>          break;
> +    default:
> +        abort();
>      }
> =20
>      return;
> @@ -411,10 +414,13 @@ VncInfo *qmp_query_vnc(Error **errp)
>              info->family =3D NETWORK_ADDRESS_FAMILY_UNIX;
>              break;
> =20
> -        default:
> +        case SOCKET_ADDRESS_KIND_VSOCK:
> +        case SOCKET_ADDRESS_KIND_FD:
>              error_setg(errp, "Unsupported socket kind %d",
>                         addr->type);

Same here.

Max

>              goto out_error;
> +        default:
> +            abort();
>          }
> =20
>          info->has_host =3D true;
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 9b73681..4ae37bd 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -1337,9 +1337,7 @@ char *socket_address_to_string(struct SocketAddre=
ss *addr, Error **errp)
>          break;
> =20
>      default:
> -        error_setg(errp, "socket family %d unsupported",
> -                   addr->type);
> -        return NULL;
> +        abort();
>      }
>      return buf;
>  }
>=20



--uUeunhEQJMdaar8l9udDqVpLuDSPDxeAB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljcB1QSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A61kIAKDoLj0ltUsmS0igw8pjB21IFB7U0i6y
Xr7Sd25YE4aW4gclZq2EoEGkE0cWaoNYaKm4F1hFDPZbMGehTwgZdyx0tIcivlj+
WhFUaQiCVMvUB+uWiW1VRHh9HQyzCygY2ZoewjKg91e4KNxgMbigIkdQ5A1fcEBL
mSdk7LbUa8tpNydhZff4XERycCBKIg3xjLS2yHXjxUkqrYpjN+QrO8fqDJL9FB8q
in5oHJmiFAQbMoGYjpl5+A2Jj/t7bPPcWASKFrKd3zVaQELvxJ74V5b9n/aFPINp
YB1OUlXuMWAIaDFAVbQE/QP/OpBZG7/n6e0Ur+H8hpX9OnN7wHH6F7A=
=uifD
-----END PGP SIGNATURE-----

--uUeunhEQJMdaar8l9udDqVpLuDSPDxeAB--
