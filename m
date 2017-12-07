Received: from eggs.gnu.org ([2001:4830:134:3::10]:55457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN2vj-0007ak-43
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 15:38:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN2vi-00017E-0r
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 15:38:03 -0500
References: <20171206144550.22295-1-stefanha@redhat.com>
	<20171206144550.22295-3-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <85cde0a4-e523-be3c-17ca-0bf6010e41aa@redhat.com>
Date: Thu, 7 Dec 2017 14:37:52 -0600
MIME-Version: 1.0
In-Reply-To: <20171206144550.22295-3-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iDrFnfljimCpp3aFO0gJ5S6PGKUBx7ICl"
Subject: Re: [Qemu-devel] [PATCH v2 2/9] block: don't keep AioContext
 acquired after external_snapshot_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iDrFnfljimCpp3aFO0gJ5S6PGKUBx7ICl
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <85cde0a4-e523-be3c-17ca-0bf6010e41aa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/9] block: don't keep AioContext acquired
 after external_snapshot_prepare()
References: <20171206144550.22295-1-stefanha@redhat.com>
 <20171206144550.22295-3-stefanha@redhat.com>
In-Reply-To: <20171206144550.22295-3-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2017 08:45 AM, Stefan Hajnoczi wrote:
> It is not necessary to hold AioContext across transactions anymore sinc=
e
> bdrv_drained_begin/end() is used to keep the nodes quiesced.  In fact,
> using the AioContext lock for this purpose was always buggy.
>=20
> This patch reduces the scope of AioContext locked regions.  This is not=

> just a cleanup but also fixes hangs that occur in BDRV_POLL_WHILE()
> because it is unware of recursive locking and does not release the

s/unware/unaware/

> AioContext the necessary number of times to allow progress to be made.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  blockdev.c | 71 ++++++++++++++++++++++++++++++++++++++++++------------=
--------
>  1 file changed, 48 insertions(+), 23 deletions(-)
>=20

> @@ -1662,31 +1662,32 @@ static void external_snapshot_prepare(BlkAction=
State *common,
>          return;
>      }
> =20
> -    /* Acquire AioContext now so any threads operating on old_bs stop =
*/
> -    state->aio_context =3D bdrv_get_aio_context(state->old_bs);
> -    aio_context_acquire(state->aio_context);
> +    aio_context =3D bdrv_get_aio_context(state->old_bs);
> +    aio_context_acquire(aio_context);
> +
> +    /* Paired with .clean() */
>      bdrv_drained_begin(state->old_bs);
> =20
>      if (!bdrv_is_inserted(state->old_bs)) {
>          error_setg(errp, QERR_DEVICE_HAS_NO_MEDIUM, device);
> -        return;
> +        goto out;
>      }

Using gcc/clang's __attribute__((cleanup)) would make this so much nicer =
;)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--iDrFnfljimCpp3aFO0gJ5S6PGKUBx7ICl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloppqAACgkQp6FrSiUn
Q2qAeggAiro2OoEWielxf4vviXgiWg06jktdIjamtPfu3+FVeLXok2wqKzXN264d
BY+FAGCZILu/JE4+9TisMkJSI7ZUinQTnBZ9fsoES+0dyxvpT1nmtVSbHwRA8yGI
nXdBFn5ZcL7eMbB3W7xfq7oDdvaZx3kHMNPq4ZxgWf3m2ksa4LP2xgX2YfUChYiK
s2r7nIq7Rv4SK8jq6K9YELDE/49s/qqZ+GY/1h1f5RGBplUumjTSQTjZuUQ5qLmQ
oFSP4O6pzUV0Rw/wix2qQXJGPpvTvguo7oj4M9vMXxkWZuExpFdzmTKBaKBdIfro
CDF9pVx3LhlUXT8hGd9hONssVGz0JA==
=PRHa
-----END PGP SIGNATURE-----

--iDrFnfljimCpp3aFO0gJ5S6PGKUBx7ICl--
