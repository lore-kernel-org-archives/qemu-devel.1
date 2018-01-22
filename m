Received: from eggs.gnu.org ([2001:4830:134:3::10]:34006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1edken-0004KG-Cy
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 17:33:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1edkem-0002LD-Ch
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 17:33:37 -0500
References: <20180119135719.24745-1-vsementsov@virtuozzo.com>
	<20180119135719.24745-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <736cc213-5f7a-f2b0-6b9e-37b26bd824fc@redhat.com>
Date: Mon, 22 Jan 2018 16:33:26 -0600
MIME-Version: 1.0
In-Reply-To: <20180119135719.24745-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1GBP65SD4IPsPU2g9CeM9xJYXL9wILfH9"
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qapi: add nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1GBP65SD4IPsPU2g9CeM9xJYXL9wILfH9
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <736cc213-5f7a-f2b0-6b9e-37b26bd824fc@redhat.com>
Subject: Re: [PATCH v3 2/5] qapi: add nbd-server-remove
References: <20180119135719.24745-1-vsementsov@virtuozzo.com>
 <20180119135719.24745-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180119135719.24745-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2018 07:57 AM, Vladimir Sementsov-Ogievskiy wrote:
> Add command for removing an export. It is needed for cases when we
> don't want to keep export after the operation on it was completed.
> The other example is temporary node, created with blockdev-add.
> If we want to delete it we should firstly remove corresponding
> NBD export.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

> +++ b/nbd/server.c
> @@ -1177,6 +1177,26 @@ void nbd_export_close(NBDExport *exp)
>      nbd_export_put(exp);
>  }
> =20
> +void nbd_export_remove(NBDExport *exp, NbdServerRemoveMode mode, Error=
 **errp)
> +{
> +    NBDClient *client;
> +    int nb_clients =3D 0;
> +
> +    if (mode =3D=3D NBD_SERVER_REMOVE_MODE_HARD || QTAILQ_EMPTY(&exp->=
clients)) {
> +        nbd_export_close(exp);
> +        return;
> +    }
> +
> +    assert(mode =3D=3D NBD_SERVER_REMOVE_MODE_SAFE);
> +
> +    QTAILQ_FOREACH(client, &exp->clients, next) {
> +        nb_clients++;
> +    }
> +

Now that the error message is not using nb_clients, we can simplify the
code to quit computing it.

> +    error_setg(errp, "export '%s' still in use", exp->name);
> +    error_append_hint(errp, "Use mode=3D'hard' to force client disconn=
ect\n");
> +}
> +
>  void nbd_export_get(NBDExport *exp)
>  {
>      assert(exp->refcount > 0);
>=20

I'll make that change as part of adding it to my NBD queue.
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1GBP65SD4IPsPU2g9CeM9xJYXL9wILfH9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpmZrYACgkQp6FrSiUn
Q2pLYgf/cMD7T7dMuD8PPr8gAEp0m9fdOhXpv7WIAUt69FCQTk+d0tmipv/9UNXC
Z6yVNbpD96EmT3ripJmam9mblMmBaTTDV680BfQwPJZONuXEkiYkEF01v2uyeMef
XURsOW3IIVsAz1jh27sujzhSr3ho2jgUsRafWbwxaXDgIRSgqgu8XkgqXjmOtVBs
EA3Z4ncCNbQl2qSaZj4/vylz5zOHdYWoZ8jLvjkdwN5lVHlLIh3Z6b0L+n02YO0M
aDpTnGUS/SwaHUdzvXW+5ZCR8Idux1LeWuTqvqiTVv4hDadQecLJanmUksp7EKal
zr7vjmHsdUnFyCQe2KqFJ4Taar7dEQ==
=/G4p
-----END PGP SIGNATURE-----

--1GBP65SD4IPsPU2g9CeM9xJYXL9wILfH9--
