Received: from eggs.gnu.org ([2001:4830:134:3::10]:54815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9LSH-00061f-P4
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 22:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9LNS-00018W-VA
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 22:34:35 -0400
References: <cover.1537367701.git.berto@igalia.com>
	<95addb261af316f49517069e1cce4d9c601d274b.1537367701.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1fee9736-1e83-39bb-d0d6-7af09c6f73df@redhat.com>
Date: Mon, 8 Oct 2018 04:34:24 +0200
MIME-Version: 1.0
In-Reply-To: <95addb261af316f49517069e1cce4d9c601d274b.1537367701.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="msX3ckcgqvadGy2rCMzpYrfCkeNXQBirf"
Subject: Re: [Qemu-devel] [PATCH 12/14] block: Clean up
 reopen_backing_file() in block/replication.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--msX3ckcgqvadGy2rCMzpYrfCkeNXQBirf
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <1fee9736-1e83-39bb-d0d6-7af09c6f73df@redhat.com>
Subject: Re: [PATCH 12/14] block: Clean up reopen_backing_file() in
 block/replication.c
References: <cover.1537367701.git.berto@igalia.com>
 <95addb261af316f49517069e1cce4d9c601d274b.1537367701.git.berto@igalia.com>
In-Reply-To: <95addb261af316f49517069e1cce4d9c601d274b.1537367701.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.09.18 16:47, Alberto Garcia wrote:
> This function is used to put the hidden and secondary disks in
> read-write mode before launching the backup job, and back in read-only
> mode afterwards.
>=20
> This patch does the following changes:
>=20
>   - Use an options QDict with the "read-only" option instead of
>     passing the changes as flags only.
>=20
>   - Simplify the code (it was unnecessarily complicated and verbose).
>=20
>   - Fix a bug due to which the secondary disk was not being put back
>     in read-only mode when writable=3Dfalse (because in this case
>     orig_secondary_flags always had the BDRV_O_RDWR flag set).
>=20
>   - Stop clearing the BDRV_O_INACTIVE flag.

Why?  Sorry, but I don't know much about replication.  Do you know this
change is OK?  (Since the code deliberately clears it right now.)

(Well, it makes sense not to re-set it afterwards...)

> The flags parameter to bdrv_reopen_queue() becomes redundant and we'll
> be able to get rid of it in a subsequent patch.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/replication.c | 42 ++++++++++++++++++------------------------
>  1 file changed, 18 insertions(+), 24 deletions(-)
>=20
> diff --git a/block/replication.c b/block/replication.c
> index 6349d6958e..1ad0ef2ef8 100644
> --- a/block/replication.c
> +++ b/block/replication.c
> @@ -20,6 +20,7 @@
>  #include "block/block_backup.h"
>  #include "sysemu/block-backend.h"
>  #include "qapi/error.h"
> +#include "qapi/qmp/qdict.h"
>  #include "replication.h"
> =20
>  typedef enum {
> @@ -39,8 +40,8 @@ typedef struct BDRVReplicationState {
>      char *top_id;
>      ReplicationState *rs;
>      Error *blocker;
> -    int orig_hidden_flags;
> -    int orig_secondary_flags;
> +    bool orig_hidden_read_only;
> +    bool orig_secondary_read_only;
>      int error;
>  } BDRVReplicationState;
> =20
> @@ -376,39 +377,32 @@ static void reopen_backing_file(BlockDriverState =
*bs, bool writable,
>  {
>      BDRVReplicationState *s =3D bs->opaque;
>      BlockReopenQueue *reopen_queue =3D NULL;
> -    int orig_hidden_flags, orig_secondary_flags;
> -    int new_hidden_flags, new_secondary_flags;
>      Error *local_err =3D NULL;
> =20
>      if (writable) {

I'd like to request a comment that "writable" is true the first time
this function is called, and false the second time.  That'd make it
clear why this rewrite makes sense.

(And that writable=3Dfalse means reverting to the original state.)

((And no, it doesn't make more sense before this patch.))

> -        orig_hidden_flags =3D s->orig_hidden_flags =3D
> -                                bdrv_get_flags(s->hidden_disk->bs);
> -        new_hidden_flags =3D (orig_hidden_flags | BDRV_O_RDWR) &
> -                                                    ~BDRV_O_INACTIVE;
> -        orig_secondary_flags =3D s->orig_secondary_flags =3D
> -                                bdrv_get_flags(s->secondary_disk->bs);=

> -        new_secondary_flags =3D (orig_secondary_flags | BDRV_O_RDWR) &=

> -                                                     ~BDRV_O_INACTIVE;=

> -    } else {
> -        orig_hidden_flags =3D (s->orig_hidden_flags | BDRV_O_RDWR) &
> -                                                    ~BDRV_O_INACTIVE;
> -        new_hidden_flags =3D s->orig_hidden_flags;
> -        orig_secondary_flags =3D (s->orig_secondary_flags | BDRV_O_RDW=
R) &
> -                                                    ~BDRV_O_INACTIVE;
> -        new_secondary_flags =3D s->orig_secondary_flags;
> +        s->orig_hidden_read_only =3D
> +            !(bdrv_get_flags(s->hidden_disk->bs) & BDRV_O_RDWR);
> +        s->orig_secondary_read_only =3D
> +            !(bdrv_get_flags(s->secondary_disk->bs) & BDRV_O_RDWR);

Why not use bdrv_is_read_only()?

Max

>      }
> =20
>      bdrv_subtree_drained_begin(s->hidden_disk->bs);
>      bdrv_subtree_drained_begin(s->secondary_disk->bs);
> =20
> -    if (orig_hidden_flags !=3D new_hidden_flags) {
> -        reopen_queue =3D bdrv_reopen_queue(reopen_queue, s->hidden_dis=
k->bs, NULL,
> -                                         new_hidden_flags);
> +    if (s->orig_hidden_read_only) {
> +        int flags =3D bdrv_get_flags(s->hidden_disk->bs);
> +        QDict *opts =3D qdict_new();
> +        qdict_put_bool(opts, BDRV_OPT_READ_ONLY, !writable);
> +        reopen_queue =3D bdrv_reopen_queue(reopen_queue, s->hidden_dis=
k->bs,
> +                                         opts, flags);
>      }
> =20
> -    if (!(orig_secondary_flags & BDRV_O_RDWR)) {
> +    if (s->orig_secondary_read_only) {
> +        int flags =3D bdrv_get_flags(s->secondary_disk->bs);
> +        QDict *opts =3D qdict_new();
> +        qdict_put_bool(opts, BDRV_OPT_READ_ONLY, !writable);
>          reopen_queue =3D bdrv_reopen_queue(reopen_queue, s->secondary_=
disk->bs,
> -                                         NULL, new_secondary_flags);
> +                                         opts, flags);
>      }
> =20
>      if (reopen_queue) {
>=20



--msX3ckcgqvadGy2rCMzpYrfCkeNXQBirf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu6wjAACgkQ9AfbAGHV
z0AL2gf/fs6n9gbZZ3tYJSOkobklNTBJHvP8ByC/ewHa1QEtHVwAIgKWuiPyD+3V
i/6x4k3eQR7wv7iWA6sZWLYQeFGiR6s1X5cMGqWkOdGqQmhZCq7Q9orJ/zz03mWL
QQt3nn/g1nAWji6l/pMrNjx0IMllPPYqINzzD+Z6jany4NjciIgIqZJkHp6CJwhw
tl5ppai243Cu0MzJXjrmi6dR5huRZg8ULf7ivXa+3u17oWMj4tay1zL1TtMBeRAk
mSuvgjV4+Doy/4nGkFgKunCnjmJmxErcvQDIldgCUFwWBCCfnMtIZ+ogGZV8ALeZ
owyVmo8cqn+2c3fdsC/DjLAjGScOvw==
=pkNj
-----END PGP SIGNATURE-----

--msX3ckcgqvadGy2rCMzpYrfCkeNXQBirf--
