Received: from eggs.gnu.org ([2001:4830:134:3::10]:33351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIwpi-000674-SL
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 08:46:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIwpd-0005nR-Tw
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 08:46:38 -0400
Date: Thu, 8 Jun 2017 13:46:29 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170608124629.GI4145@stefanha-x1.localdomain>
References: <20170531094330.1808-1-pbonzini@redhat.com>
	<20170531094330.1808-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PWfwoUCx3AFJRUBq"
Content-Disposition: inline
In-Reply-To: <20170531094330.1808-9-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/11] block: invoke .bdrv_drain callback
 in coroutine context and from AioContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com


--PWfwoUCx3AFJRUBq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2017 at 11:43:27AM +0200, Paolo Bonzini wrote:
> diff --git a/block/qed.c b/block/qed.c
> index 83a0973cfb..990210cd9c 100644
> --- a/block/qed.c
> +++ b/block/qed.c

Does this belong in the next patch?

> @@ -351,7 +351,7 @@ static void bdrv_qed_attach_aio_context(BlockDriverSt=
ate *bs,
>      }
>  }
> =20
> -static void bdrv_qed_drain(BlockDriverState *bs)
> +static void coroutine_fn bdrv_qed_co_drain(BlockDriverState *bs)
>  {
>      BDRVQEDState *s =3D bs->opaque;
> =20
> @@ -360,7 +360,7 @@ static void bdrv_qed_drain(BlockDriverState *bs)
>       */
>      if (s->need_check_timer && timer_pending(s->need_check_timer)) {
>          qed_cancel_need_check_timer(s);
> -        qed_need_check_timer_cb(s);
> +        qed_need_check_timer_entry(s);
>      }
>  }
> =20
> @@ -1544,7 +1544,7 @@ static BlockDriver bdrv_qed =3D {
>      .bdrv_check               =3D bdrv_qed_check,
>      .bdrv_detach_aio_context  =3D bdrv_qed_detach_aio_context,
>      .bdrv_attach_aio_context  =3D bdrv_qed_attach_aio_context,
> -    .bdrv_drain               =3D bdrv_qed_drain,
> +    .bdrv_co_drain            =3D bdrv_qed_co_drain,
>  };
> =20
>  static void bdrv_qed_init(void)

--PWfwoUCx3AFJRUBq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZOUclAAoJEJykq7OBq3PI+TYIAIZyffDP6A6Bf7sEhvVmOMqJ
4Kq2n69EfZxKOWIYYQP4iMOtJ5AnHGTkUW7D3YrHbEvuf6mccUlwY6qmxiDmTsgP
GotfVHiFGTjqaXkjjbwxNFMTCvuqrG6wRC3i6P8EA3VZGKlQa40vDTgFL2M5MYIK
V12IW8SldxVwVl1ebKLxB3xcMt8zOwQMQAaUTkVb/b53bXMCGosV+rMceNLouSLj
CkoC924NmmW35Lpu7DdlpnF4r3pmCc1MhuqKnpSSMWvFo9KU6WABYIzSjdbT7jGu
PhuUMNHAzV9VBrcT2i22y2A7eLL6LK0HWB7T2G+u9WdWTIIq4UOJjskygIIg4mE=
=hAjD
-----END PGP SIGNATURE-----

--PWfwoUCx3AFJRUBq--
