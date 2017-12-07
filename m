Received: from eggs.gnu.org ([2001:4830:134:3::10]:44171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN3i8-0004jk-Gu
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:28:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN3i7-0008NT-Fp
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:28:04 -0500
References: <20171206144550.22295-1-stefanha@redhat.com>
	<20171206144550.22295-4-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7277043f-1b5f-4576-a2e5-c4e3d6950a62@redhat.com>
Date: Thu, 7 Dec 2017 15:27:50 -0600
MIME-Version: 1.0
In-Reply-To: <20171206144550.22295-4-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uKRxpd1qSFwtiiBtKHO82ufVm9W3EgCnV"
Subject: Re: [Qemu-devel] [PATCH v2 3/9] block: don't keep AioContext
 acquired after drive_backup_prepare()
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
--uKRxpd1qSFwtiiBtKHO82ufVm9W3EgCnV
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <7277043f-1b5f-4576-a2e5-c4e3d6950a62@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/9] block: don't keep AioContext acquired
 after drive_backup_prepare()
References: <20171206144550.22295-1-stefanha@redhat.com>
 <20171206144550.22295-4-stefanha@redhat.com>
In-Reply-To: <20171206144550.22295-4-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2017 08:45 AM, Stefan Hajnoczi wrote:
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  blockdev.c | 42 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 8 deletions(-)
>=20

> @@ -1867,24 +1867,36 @@ static void drive_backup_prepare(BlkActionState=
 *common, Error **errp)
>          return;
>      }
> =20
> -    /* AioContext is released in .clean() */
> -    state->aio_context =3D bdrv_get_aio_context(bs);
> -    aio_context_acquire(state->aio_context);
> +    aio_context =3D bdrv_get_aio_context(bs);
> +    aio_context_acquire(aio_context);
> +
> +    /* Paired with .clean() */
>      bdrv_drained_begin(bs);
> +
>      state->bs =3D bs;
> =20
>      state->job =3D do_drive_backup(backup, common->block_job_txn, &loc=
al_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> -        return;
> +        goto out;
>      }
> +
> +out:
> +    aio_context_release(aio_context);

Looks a bit funny to have a label with a single use that would fall
through to the same location anyways.  But it's fine from the future
maintenance point of view, so no need to change it.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--uKRxpd1qSFwtiiBtKHO82ufVm9W3EgCnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlopslYACgkQp6FrSiUn
Q2qK5Qf+J1zn1qtMs08x8kU+FHospPft94twLzeTpmB0cJ+H+rxk1uO8XWCaAqw5
mQmf936GkAZIdjMgpwokCs8NumnDUUlHTqM60QXlDfHXwsPagH3KokxQugzpgWdF
DJ48S/iNsL3uymbIhvXsXjf8KmCcAnepqpVAkAPyTmxjzJOOg9x3EnwzE3pSEFnl
aU6pzZ69CH5bScYu4BKoD6GihswUBVdLJRHtgNyjooPTLt9E5HHkziB4xPNJVZVl
T7qJjhguE/WihK+H8uRvr8XV0jZf/ErI7AvG3a0cSST0F4AdT6MyCtOWH2/F6dxg
K2PTNUHtYn2QViRuECoWwsXu0X7iMQ==
=jYge
-----END PGP SIGNATURE-----

--uKRxpd1qSFwtiiBtKHO82ufVm9W3EgCnV--
