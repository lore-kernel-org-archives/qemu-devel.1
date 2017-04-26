Received: from eggs.gnu.org ([2001:4830:134:3::10]:58387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3SsN-0004cT-NM
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 15:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3SsM-0002sj-BB
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 15:45:23 -0400
References: <1493192202-3184-1-git-send-email-armbru@redhat.com>
	<1493192202-3184-7-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2b5e5672-bedd-bbf6-52b2-31e8812ce2dc@redhat.com>
Date: Wed, 26 Apr 2017 14:45:10 -0500
MIME-Version: 1.0
In-Reply-To: <1493192202-3184-7-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IVVf7LeI4qILh9rUEr8glJmX6c4u8WKhv"
Subject: Re: [Qemu-devel] [PATCH 6/7] sockets: Limit SocketAddressLegacy
 except to external interfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IVVf7LeI4qILh9rUEr8glJmX6c4u8WKhv
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org
Message-ID: <2b5e5672-bedd-bbf6-52b2-31e8812ce2dc@redhat.com>
Subject: Re: [PATCH 6/7] sockets: Limit SocketAddressLegacy except to external
 interfaces
References: <1493192202-3184-1-git-send-email-armbru@redhat.com>
 <1493192202-3184-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1493192202-3184-7-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2017 02:36 AM, Markus Armbruster wrote:

I think it reads fine if you shorten the subject via s/except //

> SocketAddressLegacy is a simple union, and simple unions are awkward:
> they have their variant members wrapped in a "data" object on the
> wire, and require additional indirections in C.  SocketAddress is the
> equivalent flat union.  Convert all users of SocketAddressLegacy to
> SocketAddress, except for existing external interfaces.
>=20
> See also commit fce5d53..9445673 and 85a82e8..c5f1ae3.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/blockdev-nbd.c
> @@ -99,9 +99,8 @@ static QCryptoTLSCreds *nbd_get_tls_creds(const char =
*id, Error **errp)
>  }
> =20
> =20
> -void qmp_nbd_server_start(SocketAddressLegacy *addr,
> -                          bool has_tls_creds, const char *tls_creds,
> -                          Error **errp)
> +void nbd_server_start(SocketAddress *addr, const char *tls_creds,
> +                      Error **errp)
>  {
=2E..
> @@ -145,6 +144,16 @@ void qmp_nbd_server_start(SocketAddressLegacy *add=
r,
>      nbd_server =3D NULL;
>  }
> =20
> +void qmp_nbd_server_start(SocketAddressLegacy *addr,
> +                          bool has_tls_creds, const char *tls_creds,
> +                          Error **errp)
> +{
> +    SocketAddress *addr_flat =3D socket_address_flatten(addr);
> +
> +    nbd_server_start(addr_flat, tls_creds, errp);

We didn't always guarantee that tls_creds was initialized when
has_tls_creds was false, but it's been quite some time that we fixed
that.  So what you have works, and I'm not sure if it's worth using the
longer:
has_tls_creds ? tls_creds : NULL

> +++ b/chardev/char-socket.c
> @@ -52,7 +52,7 @@ typedef struct {
>      int *write_msgfds;
>      size_t write_msgfds_num;
> =20
> -    SocketAddressLegacy *addr;
> +    SocketAddress *addr;
>      bool is_listen;
>      bool is_telnet;
> =20
> @@ -337,30 +337,30 @@ static void tcp_chr_free_connection(Chardev *chr)=

>      s->connected =3D 0;
>  }
> =20
> -static char *SocketAddress_to_str(const char *prefix, SocketAddressLeg=
acy *addr,
> +static char *SocketAddressto_str(const char *prefix, SocketAddress *ad=
dr,
>                                    bool is_listen, bool is_telnet)

Is this rename(s/_to/to/) intentional? If it is, your indentation is now
off.  If not, you've got a couple of fixes to make to restore the _.

> @@ -380,7 +380,7 @@ static void tcp_chr_disconnect(Chardev *chr)
>          s->listen_tag =3D qio_channel_add_watch(
>              QIO_CHANNEL(s->listen_ioc), G_IO_IN, tcp_chr_accept, chr, =
NULL);
>      }
> -    chr->filename =3D SocketAddress_to_str("disconnected:", s->addr,
> +    chr->filename =3D SocketAddressto_str("disconnected:", s->addr,
>                                           s->is_listen, s->is_telnet);

Again, either restore the _ or fix the indentation.


> @@ -864,18 +864,18 @@ static void qmp_chardev_open_socket(Chardev *chr,=

>          }
>      }
> =20
> -    s->addr =3D QAPI_CLONE(SocketAddressLegacy, sock->addr);
> +    s->addr =3D addr =3D socket_address_flatten(sock->addr);
> =20
>      qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_RECONNECTABLE);
>      /* TODO SOCKET_ADDRESS_FD where fd has AF_UNIX */
> -    if (addr->type =3D=3D SOCKET_ADDRESS_LEGACY_KIND_UNIX) {
> +    if (addr->type =3D=3D SOCKET_ADDRESS_TYPE_UNIX) {
>          qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_FD_PASS);
>      }
> =20
>      /* be isn't opened until we get a connection */
>      *be_opened =3D false;
> =20
> -    chr->filename =3D SocketAddress_to_str("disconnected:",
> +    chr->filename =3D SocketAddressto_str("disconnected:",
>                                           addr, is_listen, is_telnet);

and again


> @@ -131,4 +131,15 @@ char *socket_address_to_string(struct SocketAddres=
sLegacy *addr, Error **errp);
>   */
>  SocketAddressLegacy *socket_address_crumple(SocketAddress *addr);
> =20
> +/**
> + * socket_address_flatten:
> + * @addr: the socket address to flatten
> + *
> + * Convert SocketAddressLegacy to SocketAddress.  Caller is responsibl=
e
> + * for freeing with qapi_free_SocketAddress().
> + *
> + * Returns: the argument converted to SocketAddressLegacy.

s/SocketAddressLegacy/SocketAddress/

> + */
> +SocketAddress *socket_address_flatten(SocketAddressLegacy *addr);
> +
>  #endif /* QEMU_SOCKETS_H */

> +++ b/qapi-schema.json
> @@ -4126,7 +4126,12 @@
>  #
>  # Captures the address of a socket, which could also be a named file d=
escriptor
>  #
> -# Note: This type is deprecated in favor of SocketAddress.
> +# Note: This type is deprecated in favor of SocketAddress.  The
> +# difference to SocketAddress is that SocketAddress is a flat union
> +# rather than a simple union.  Flat is nicer because it avoids nesting=

> +# on the wire, i.e. this form has fewer {}.

This comment doesn't read correctly.  I think you want:

The difference between SocketAddressLegacy and SocketAddress is that the
latter is a flat union rather than a simple union. Flat is nicer because
it avoids nesting on the wire, i.e. that form has fewer {}.

> +++ b/util/qemu-sockets.c

> @@ -1371,3 +1366,34 @@ SocketAddressLegacy *socket_address_crumple(Sock=
etAddress *addr_flat)
> =20
>      return addr;
>  }
> +
> +SocketAddress *socket_address_flatten(SocketAddressLegacy *addr_legacy=
)
> +{
> +    SocketAddress *addr =3D g_new(SocketAddress, 1);
> +
> +    switch (addr_legacy->type) {
> +    case SOCKET_ADDRESS_LEGACY_KIND_INET:
> +        addr->type =3D SOCKET_ADDRESS_TYPE_INET;
> +        QAPI_CLONE_MEMBERS(InetSocketAddress, &addr->u.inet,
> +                           addr_legacy->u.inet.data);
> +        break;

Works nicely.

I've pointed out some minor issues, but if you are comfortable changing
those as maintainer rather than posting a v2, feel free to add:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--IVVf7LeI4qILh9rUEr8glJmX6c4u8WKhv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAPjGAAoJEKeha0olJ0NqswwH/2ZzjTAaORA5LS6UzSglbPqd
H5dxSwJjYb7hTY+3tRAPyIS/nETDmvA6kkdCSIGEdd31mwdZMTHcsV8rnK4RGi6O
Be5DB88YH3NG8XYsH3TcfN3yAqa6i/INriz0MKB/j+ptWbTvmf4DvYwHb8U+X+ex
LF17VGVc3bmYGy0WaKsK6uyjEpoH2UTmgo3BlAmNpPX9ltjv1AkGIJsdJ/DSDDyw
DBvwvfWC+FL2OcKbBycI9UXeOzq09hkUxl9K8/G2soBEQ+MkIl095lEwcLRa0ZHA
UPSOtkgp8/NMiBcNvhIwBNCVV8b1WthevP5Bcb+mH4p/eId4gewOuv3Xqvc7lR8=
=f06y
-----END PGP SIGNATURE-----

--IVVf7LeI4qILh9rUEr8glJmX6c4u8WKhv--
