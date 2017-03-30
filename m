Received: from eggs.gnu.org ([2001:4830:134:3::10]:59514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctZyL-0005IN-ST
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:18:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctZyH-0005wx-E0
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:18:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ctZyH-0005wc-4u
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:18:37 -0400
References: <149086238428.3338.4129463785289801461.stgit@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5402615e-7085-4cac-1eb9-15f1f62b8c73@redhat.com>
Date: Thu, 30 Mar 2017 08:18:34 -0500
MIME-Version: 1.0
In-Reply-To: <149086238428.3338.4129463785289801461.stgit@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fL8oJHq5Wo9v2KPgbKqGc0HfJPsKvTBQ4"
Subject: Re: [Qemu-devel] [PATCH for-2.9?] 9pfs: fix multiple flush for same
 request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fL8oJHq5Wo9v2KPgbKqGc0HfJPsKvTBQ4
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>
Message-ID: <5402615e-7085-4cac-1eb9-15f1f62b8c73@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9?] 9pfs: fix multiple flush for same
 request
References: <149086238428.3338.4129463785289801461.stgit@bahia.lan>
In-Reply-To: <149086238428.3338.4129463785289801461.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/30/2017 03:26 AM, Greg Kurz wrote:
> If a client tries to flush the same outstanding request several times, =
only
> the first flush completes. Subsequent ones keep waiting for the request=

> completion in v9fs_flush() and, therefore, leak a PDU. This will cause =
QEMU
> to hang when draining active PDUs the next time the device is reset.

Since this fixes a hang, is it 2.9 material?

>=20
> Let have each flush request wake up the next one if any. The last waite=
r
> frees the cancelled PDU.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 48babce836b6..ef47a0a5ad6f 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -2387,8 +2387,10 @@ static void coroutine_fn v9fs_flush(void *opaque=
)
>           * Wait for pdu to complete.
>           */
>          qemu_co_queue_wait(&cancel_pdu->complete, NULL);
> -        cancel_pdu->cancelled =3D 0;
> -        pdu_free(cancel_pdu);
> +        if (!qemu_co_queue_next(&cancel_pdu->complete)) {
> +            cancel_pdu->cancelled =3D 0;
> +            pdu_free(cancel_pdu);
> +        }
>      }
>      pdu_complete(pdu, 7);
>  }
>=20
>=20
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--fL8oJHq5Wo9v2KPgbKqGc0HfJPsKvTBQ4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3QWqAAoJEKeha0olJ0Nqa3QH/jYvz/JGtinPmnKxW/6heiEe
pUt1GHhymZj4PPeoUhavc0pct2jhR4KtLiqRofD1nUiWre8cR9t1pni3Ja3ylwe5
Bq1WeKAHRvPaqU+2ZjMdlEHAA5yzbv6SCm1XbDi9ns0YsbJZLD7BPIykZysJkoRM
TAymJ0Tey9V3CVe+H1mCdQjDMn2OWUVW2ZWMCthnHCnSgijcsApmb8ELL6uGRof1
7w95gVz17tb87mTFLfkR/oa7KRo+VZ+TpdaHeI2EvLnzYYFnReSpA2tXViP+qKhL
c3PzSJiUEXZqAej+3dBSl1F3eGZ9DzJzwwjlUl6WwvoCnsaObN/kOatzY6ctIpo=
=C5Mv
-----END PGP SIGNATURE-----

--fL8oJHq5Wo9v2KPgbKqGc0HfJPsKvTBQ4--
