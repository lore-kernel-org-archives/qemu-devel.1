Received: from eggs.gnu.org ([2001:4830:134:3::10]:50125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e350D-000135-6q
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 14:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e350C-0006i0-7P
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 14:48:09 -0400
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
	<20171012095319.136610-12-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a60a6827-406f-de08-41c5-ba1dac4e4c4e@redhat.com>
Date: Fri, 13 Oct 2017 13:47:58 -0500
MIME-Version: 1.0
In-Reply-To: <20171012095319.136610-12-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4vua5inV7UE8n6b9X1pXwDGsS7MBMPwlp"
Subject: Re: [Qemu-devel] [PATCH v3 11/13] nbd: share some nbd entities to
 be reused in block/nbd-client.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4vua5inV7UE8n6b9X1pXwDGsS7MBMPwlp
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <a60a6827-406f-de08-41c5-ba1dac4e4c4e@redhat.com>
Subject: Re: [PATCH v3 11/13] nbd: share some nbd entities to be reused in
 block/nbd-client.c
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
 <20171012095319.136610-12-vsementsov@virtuozzo.com>
In-Reply-To: <20171012095319.136610-12-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/2017 04:53 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/nbd.h | 48 +++++++++++++++++++++++++++++++++++++++++++++=
+++
>  nbd/nbd-internal.h  | 25 -------------------------
>  nbd/client.c        | 32 --------------------------------
>  3 files changed, 48 insertions(+), 57 deletions(-)
>=20

> +static inline int nbd_errno_to_system_errno(int err)
> +{
> +    switch (err) {
> +    case NBD_SUCCESS:
> +        return 0;
> +    case NBD_EPERM:
> +        return EPERM;
> +    case NBD_EIO:
> +        return EIO;
> +    case NBD_ENOMEM:
> +        return ENOMEM;
> +    case NBD_ENOSPC:
> +        return ENOSPC;
> +    case NBD_ESHUTDOWN:
> +        return ESHUTDOWN;
> +    case NBD_EINVAL:
> +        return EINVAL;
> +    }
> +
> +    return EINVAL;
> +}

This lacks a trace...

> +++ b/nbd/client.c
> @@ -22,38 +22,6 @@
>  #include "trace.h"
>  #include "nbd-internal.h"
> =20
> -static int nbd_errno_to_system_errno(int err)
> -{
> -    int ret;
> -    switch (err) {
> -    case NBD_SUCCESS:
> -        ret =3D 0;
> -        break;
> -    case NBD_EPERM:
> -        ret =3D EPERM;
> -        break;
> -    case NBD_EIO:
> -        ret =3D EIO;
> -        break;
> -    case NBD_ENOMEM:
> -        ret =3D ENOMEM;
> -        break;
> -    case NBD_ENOSPC:
> -        ret =3D ENOSPC;
> -        break;
> -    case NBD_ESHUTDOWN:
> -        ret =3D ESHUTDOWN;
> -        break;
> -    default:
> -        trace_nbd_unknown_error(err);
> -        /* fallthrough */
> -    case NBD_EINVAL:

=2E..that was present here.  And you didn't do straight code motion, but
modified things on the way (hence why checkpatch complained that your
more concise version is suspicious with regards to returning positive
errno).  Does the function still need to be static inline, or should we
just declare a prototype in the header and put the function itself in
nbd/common.c?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--4vua5inV7UE8n6b9X1pXwDGsS7MBMPwlp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnhCl4ACgkQp6FrSiUn
Q2rLfggAm10Q3VpUt8BXNdS45yLv+t7qypKRuoRUhC0iJK3PdEzTWcZL9tOEC8Jq
CQuYGQ0f5oyrWiAw2SojtLZ+aT6x8pxj42+ZHxbjgUm8iI9sksItlzHwytz16Z17
CnOAzs5pMrMMCC8+7gZkRo3kNP5OLX1nzAMJ98p1gB/hX6y8t40WanQtLLt7pfHm
9KSbrVjauJDYxv0Ke1kV08RTrAIwYRRoCJrypei9mnyQQzZ7AalW4U+Sf8I1I9iD
PkbViwCps1s/wmWs7M7Y+t2mMDNR6ZZLkQzKlLcoGOLdcUtrL9lEf0RDQYh/O5/8
ziti1VZfTFZgnb0b8R0/oibgJXqY4g==
=7TrM
-----END PGP SIGNATURE-----

--4vua5inV7UE8n6b9X1pXwDGsS7MBMPwlp--
