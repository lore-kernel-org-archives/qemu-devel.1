Received: from eggs.gnu.org ([2001:4830:134:3::10]:53548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cvktj-0003MM-3i
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cvkth-00084D-Ue
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:22:55 -0400
References: <1491320156-4629-1-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d74fad45-9f89-6f34-020f-87e6b20ea59b@redhat.com>
Date: Wed, 5 Apr 2017 15:22:40 +0200
MIME-Version: 1.0
In-Reply-To: <1491320156-4629-1-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RDaplxxgiSheQMkDWjjhCbv9HuMXCMLb4"
Subject: Re: [Qemu-devel] [RFC PATCH for-2.9] block: Ignore guest dev
 permissions during incoming migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, jcody@redhat.com, Ciprian.Barbu@enea.com, Alexandru.Avadanii@enea.com, armband@enea.com, eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RDaplxxgiSheQMkDWjjhCbv9HuMXCMLb4
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, jcody@redhat.com, Ciprian.Barbu@enea.com,
 Alexandru.Avadanii@enea.com, armband@enea.com, eblake@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <d74fad45-9f89-6f34-020f-87e6b20ea59b@redhat.com>
Subject: Re: [RFC PATCH for-2.9] block: Ignore guest dev permissions during
 incoming migration
References: <1491320156-4629-1-git-send-email-kwolf@redhat.com>
In-Reply-To: <1491320156-4629-1-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 04.04.2017 17:35, Kevin Wolf wrote:
> Usually guest devices don't like other writers to the same image, so
> they use blk_set_perm() to prevent this from happening. In the migratio=
n
> phase before the VM is actually running, though, they don't have a
> problem with writes to the image. On the other hand, storage migration
> needs to be able to write to the image in this phase, so the restrictiv=
e
> blk_set_perm() call of qdev devices breaks it.
>=20
> This patch flags all BlockBackends with a qdev device as
> blk->disable_perm during incoming migration, which means that the
> requested permissions are stored in the BlockBackend, but not actually
> applied to its root node yet.
>=20
> Once migration has finished and the VM should be resumed, the
> permissions are applied. If they cannot be applied (e.g. because the NB=
D
> server used for block migration hasn't been shut down), resuming the VM=

> fails.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/block-backend.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  include/block/block.h |  2 ++
>  migration/migration.c |  8 ++++++++
>  qmp.c                 |  6 ++++++
>  4 files changed, 55 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 0b63773..f817040 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c

[...]

> @@ -597,15 +598,52 @@ void blk_get_perm(BlockBackend *blk, uint64_t *pe=
rm, uint64_t *shared_perm)
>      *shared_perm =3D blk->shared_perm;
>  }
> =20
> +/*
> + * Notifies the user of all BlockBackends that migration has completed=
=2E qdev
> + * devices can tighten their permissions in response (specifically rev=
oke
> + * shared write permissions that we needed for storage migration).
> + *
> + * If an error is returned, the VM cannot be allowed to be resumed.
> + */
> +void blk_resume_after_migration(Error **errp)
> +{
> +    BlockBackend *blk;
> +    Error *local_err =3D NULL;
> +
> +    for (blk =3D blk_next(NULL); blk; blk =3D blk_next(blk)) {

Shouldn't we use blk_all_next()?

Trusting you that silently disabling autostart is something the upper
layers can deal with, the rest looks good to me.

(The only other runtime changes of autostart apart from stop/cont appear
to be in blockdev_init() (if (bdrv_key_required()), but I don't think
that can happen anymore) and in migration/colo.c (which enables it and
emits an error message).)

Max

> +        if (!blk->disable_perm) {
> +            continue;
> +        }
> +
> +        blk->disable_perm =3D false;
> +
> +        blk_set_perm(blk, blk->perm, blk->shared_perm, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            blk->disable_perm =3D true;
> +            return;
> +        }
> +    }
> +}
> +


--RDaplxxgiSheQMkDWjjhCbv9HuMXCMLb4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljk76ASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AXqcH93T/LFhJXRRn7sR2U70JkxHalqsYkHGB
N7xzNL9xeeeDWkUNuBbQaNSPXRi3OGk1N1QNZJANeNC7f7sjb83C7n8ArucAmWvt
6sxAXyki0LOGBLL05mMEwNOcEANIagac4rnRPXxnjQppzXwqpVHSq9AdcKT+AP9L
ElltVofkSJONlK+WvNXebc/hNJ5k5aEH4MoHA/sII8zaFXoPCjmbCdlvc4fSCHAX
ocDFR0tGm1nO2CZkBl01ggKi+R0ZK8CP7nQcRbL5g2izxhiDFeOEsh2E0Y5xOgdQ
l8M5yRnL5bDty2bRn4+ZC1OA+7+EudBramwqjwgMH8d+UMSVE0xnww==
=YrZt
-----END PGP SIGNATURE-----

--RDaplxxgiSheQMkDWjjhCbv9HuMXCMLb4--
