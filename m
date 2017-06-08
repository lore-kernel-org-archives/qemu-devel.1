Received: from eggs.gnu.org ([2001:4830:134:3::10]:48505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIzC7-0008Nx-8E
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 11:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIzC2-0002gQ-Ju
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 11:17:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dIzC2-0002fj-Aq
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 11:17:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 284F440F29
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 15:17:49 +0000 (UTC)
References: <20170608133906.12737-1-ehabkost@redhat.com>
	<20170608133906.12737-6-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b27cc65d-1a07-c320-0bbc-8bb11dc22e63@redhat.com>
Date: Thu, 8 Jun 2017 10:17:45 -0500
MIME-Version: 1.0
In-Reply-To: <20170608133906.12737-6-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OUP1RnJg92Cu4ljTeTXX37logfjJDpr7R"
Subject: Re: [Qemu-devel] [PATCH 5/5] vnc: No need for Error** parameter at
 vnc_client_io_error()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OUP1RnJg92Cu4ljTeTXX37logfjJDpr7R
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <b27cc65d-1a07-c320-0bbc-8bb11dc22e63@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] vnc: No need for Error** parameter at
 vnc_client_io_error()
References: <20170608133906.12737-1-ehabkost@redhat.com>
 <20170608133906.12737-6-ehabkost@redhat.com>
In-Reply-To: <20170608133906.12737-6-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/08/2017 08:39 AM, Eduardo Habkost wrote:
> The only callers of vnc_client_io_error() with non-NULL errp don't use
> *errp after the function gets called, so there's no need to use an
> Error** argument.  Change parameter to Error* and simplify the code.
>=20
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  ui/vnc.h |  2 +-
>  ui/vnc.c | 13 +++++--------
>  2 files changed, 6 insertions(+), 9 deletions(-)

> =20
> -ssize_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp)
> +ssize_t vnc_client_io_error(VncState *vs, ssize_t ret, Error *err)
>  {

This is unusual.

>      if (ret <=3D 0) {
>          if (ret =3D=3D 0) {
> @@ -1188,14 +1188,11 @@ ssize_t vnc_client_io_error(VncState *vs, ssize=
_t ret, Error **errp)
>              vnc_disconnect_start(vs);
>          } else if (ret !=3D QIO_CHANNEL_ERR_BLOCK) {
>              VNC_DEBUG("Closing down client sock: ret %zd (%s)\n",
> -                      ret, errp ? error_get_pretty(*errp) : "Unknown")=
;
> +                      ret, err ? error_get_pretty(err) : "Unknown");
>              vnc_disconnect_start(vs);
>          }
> =20
> -        if (errp) {
> -            error_free(*errp);
> -            *errp =3D NULL;
> -        }
> +        error_free(err);

Worse, it's action at a distance. You are freeing memory here that was
allocated in the callers.

>          return 0;
>      }
>      return ret;
> @@ -1231,7 +1228,7 @@ ssize_t vnc_client_write_buf(VncState *vs, const =
uint8_t *data, size_t datalen)
>      ret =3D qio_channel_write(
>          vs->ioc, (const char *)data, datalen, &err);
>      VNC_DEBUG("Wrote wire %p %zd -> %ld\n", data, datalen, ret);
> -    return vnc_client_io_error(vs, ret, &err);
> +    return vnc_client_io_error(vs, ret, err);
>  }

It looks like the only reason that err gets passed is for the sake of
VNC_DEBUG messages, but I'm not sure I like this patch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OUP1RnJg92Cu4ljTeTXX37logfjJDpr7R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOWqZAAoJEKeha0olJ0Nq1eUH/1NXe4XXTTM20yIZx9x03Jz8
uNw3ADsnNrRUMV6RB51JiMO+gxdtw4OYN1/kqYc0aiLmUntf7qyWmc7EizhG6e53
jianlTrFQpKNJCEaN5EXiX+THdyVL7ORRjti+sHsj+mkg1Ujop1KyvAKMBzH6P8i
O8bZ0GKpIuAJdswdOH6lVEVDEsZ5E5mmn7oHWxna71Ip9cUcJcQtfIg2GWemex7Y
f9n1c0a/EeenPEi32TVZ5KhZgrQT3W38W3itlaAJJx9izuk5CJSVtSoFTAYMHl1J
ZQRCrAIc43IhvC+feXshuu3J7THHlbPMWsBG1B8nMFTSumAssyNf5iZZw8g72l8=
=w895
-----END PGP SIGNATURE-----

--OUP1RnJg92Cu4ljTeTXX37logfjJDpr7R--
