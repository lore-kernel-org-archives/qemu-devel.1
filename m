Received: from eggs.gnu.org ([209.51.188.92]:52855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpdXX-0004Go-Bm
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 13:27:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpdXV-0003XV-Cs
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 13:27:47 -0500
References: <20190128165830.165170-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eb482fb2-5934-c786-1b23-f46054bbdb39@redhat.com>
Date: Fri, 1 Feb 2019 12:27:09 -0600
MIME-Version: 1.0
In-Reply-To: <20190128165830.165170-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="81UYpWPdR4wiQLYLu9TCqG8Mveg9n3EEC"
Subject: Re: [Qemu-devel] [PATCH] nbd: generalize usage of nbd_read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--81UYpWPdR4wiQLYLu9TCqG8Mveg9n3EEC
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com
Message-ID: <eb482fb2-5934-c786-1b23-f46054bbdb39@redhat.com>
Subject: Re: [PATCH] nbd: generalize usage of nbd_read
References: <20190128165830.165170-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190128165830.165170-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/28/19 10:58 AM, Vladimir Sementsov-Ogievskiy wrote:
> We generally do very similar things around nbd_read: error_prepend,
> specifying, what we have tried to read and be_to_cpu conversion of
> integers.
>=20
> So, it seems reasonable to move common things to helper functions,
> which:
> 1. simplify code a bit
> 2. generalize nbd_read error descriptions, all starting with
>    "Failed to read"
> 3. make it more difficult to forget to convert things from BE
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/nbd.h | 31 ++++++++++++++--
>  block/nbd-client.c  |  5 ++-
>  nbd/client.c        | 88 +++++++++++++++------------------------------=

>  nbd/common.c        |  2 +-
>  nbd/server.c        | 27 +++++---------
>  5 files changed, 70 insertions(+), 83 deletions(-)


> +
> +#define DEF_NBD_READ(bits) \
> +static inline int nbd_read ## bits(QIOChannel *ioc, uint ## bits ## _t=
 * val, \

checkpatch didn't flag it, but I think our style is '*val', not '* val'.

> +                                   const char *desc, Error **errp)    =
        \
> +{                                                                     =
        \
> +    if (nbd_read(ioc, val, sizeof(*val), desc, errp) < 0) {           =
        \
> +        return -1;                                                    =
        \
> +    }                                                                 =
        \
> +    *val =3D be ## bits ## _to_cpu(*val);                             =
          \
> +    return 0;                                                         =
        \
>  }
> =20
> +DEF_NBD_READ(16) /* Defines nbd_read16(). */
> +DEF_NBD_READ(32) /* Defines nbd_read32(). */
> +DEF_NBD_READ(64) /* Defines nbd_read64(). */
> +
> +#undef DEF_NBD_READ

I think the name DEF_NBD_READ_N is slightly nicer; that's minor enough
that I don't mind tweaking it.

Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks; queued for my next NBD pull request.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--81UYpWPdR4wiQLYLu9TCqG8Mveg9n3EEC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxUj30ACgkQp6FrSiUn
Q2pWpAgAnCdNCHF5ltl9KQp3W/hoMCr+mmrxC9Shlr5bJ+5/6FHRFu+Ck8/f8WTH
CSmatRbUQBcahqpHgI61vc7KgRn7lQ+K8SWSAb6J3yRcCZxPWbiiDQIUqu6iocIb
1g6TcO1znnOWzhxvB2/l7YHll0EBkAIy426WDZ0mWOkbQI7xWMdVxrcAcGX1hdIE
EzYaro6BlxRJelXp/aQS0yL2Ydsno4wCCsOpinlsfpm/PPpXSY8LgeM2+OdFIUbb
cfwmKl1fN3pYi8pLvMjn2Vb4s/ZhjR4D+zSFldSPb0swqsktr6YKlncGEi/03ILP
0POv+WLc2AYTXzgeZMjxAtvuhzTD5Q==
=CeDq
-----END PGP SIGNATURE-----

--81UYpWPdR4wiQLYLu9TCqG8Mveg9n3EEC--
