Received: from eggs.gnu.org ([2001:4830:134:3::10]:50246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9Kvd-0000bl-MF
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 22:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9Kvc-0002O1-NK
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 22:05:49 -0400
References: <cover.1537367701.git.berto@igalia.com>
	<298f85a0b53dc90b1d6bea272c26983ab684619e.1537367701.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5aaf3b44-96a8-0bb4-5455-879c3a8452c2@redhat.com>
Date: Mon, 8 Oct 2018 04:05:38 +0200
MIME-Version: 1.0
In-Reply-To: <298f85a0b53dc90b1d6bea272c26983ab684619e.1537367701.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="u6qO8kCczAZyaEucLtFo6Zkq4VtLu78LC"
Subject: Re: [Qemu-devel] [PATCH 11/14] qemu-io: Put flag changes in the
 options QDict in reopen_f()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u6qO8kCczAZyaEucLtFo6Zkq4VtLu78LC
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <5aaf3b44-96a8-0bb4-5455-879c3a8452c2@redhat.com>
Subject: Re: [PATCH 11/14] qemu-io: Put flag changes in the options QDict in
 reopen_f()
References: <cover.1537367701.git.berto@igalia.com>
 <298f85a0b53dc90b1d6bea272c26983ab684619e.1537367701.git.berto@igalia.com>
In-Reply-To: <298f85a0b53dc90b1d6bea272c26983ab684619e.1537367701.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.09.18 16:47, Alberto Garcia wrote:
> When reopen_f() puts a block device in the reopen queue, some of the
> new options are passed using a QDict, but others ("read-only" and the
> cache options) are passed as flags.
>=20
> This patch puts those flags in the QDict. This way the flags parameter
> becomes redundant and we'll be able to get rid of it in a subsequent
> patch.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  qemu-io-cmds.c             | 27 ++++++++++++++++++++++++++-
>  tests/qemu-iotests/133     |  9 +++++++++
>  tests/qemu-iotests/133.out |  8 ++++++++
>  3 files changed, 43 insertions(+), 1 deletion(-)
>=20
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index db0b3ee5ef..4ad5269abc 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -10,6 +10,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "qapi/qmp/qdict.h"
>  #include "qemu-io.h"
>  #include "sysemu/block-backend.h"
>  #include "block/block.h"
> @@ -1978,6 +1979,7 @@ static int reopen_f(BlockBackend *blk, int argc, =
char **argv)
>      int flags =3D bs->open_flags;
>      bool writethrough =3D !blk_enable_write_cache(blk);
>      bool has_rw_option =3D false;
> +    bool has_cache_option =3D false;
> =20
>      BlockReopenQueue *brq;
>      Error *local_err =3D NULL;
> @@ -1989,6 +1991,7 @@ static int reopen_f(BlockBackend *blk, int argc, =
char **argv)
>                  error_report("Invalid cache option: %s", optarg);
>                  return -EINVAL;
>              }
> +            has_cache_option =3D true;
>              break;
>          case 'o':
>              if (!qemu_opts_parse_noisily(&reopen_opts, optarg, 0)) {
> @@ -2046,9 +2049,31 @@ static int reopen_f(BlockBackend *blk, int argc,=
 char **argv)
>      }
> =20
>      qopts =3D qemu_opts_find(&reopen_opts, NULL);
> -    opts =3D qopts ? qemu_opts_to_qdict(qopts, NULL) : NULL;
> +    opts =3D qopts ? qemu_opts_to_qdict(qopts, NULL) : qdict_new();
>      qemu_opts_reset(&reopen_opts);
> =20
> +    if (qdict_haskey(opts, BDRV_OPT_READ_ONLY)) {
> +        if (has_rw_option) {
> +            error_report("Can't set both -r/-w and '" BDRV_OPT_READ_ON=
LY "'");

I'm not a fan of elision ("can't") in user interfaces.  (In fact, I'm
not a fan of elision anywhere in the code base or commit logs, but I
don't put up a struggle there.)

> +            qobject_unref(opts);
> +            return -EINVAL;
> +        }
> +    } else {
> +        qdict_put_bool(opts, BDRV_OPT_READ_ONLY, !(flags & BDRV_O_RDWR=
));
> +    }
> +
> +    if (qdict_haskey(opts, BDRV_OPT_CACHE_DIRECT) ||
> +        qdict_haskey(opts, BDRV_OPT_CACHE_NO_FLUSH)) {
> +        if (has_cache_option) {
> +            error_report("Can't set both -c and the cache options");
> +            qobject_unref(opts);
> +            return -EINVAL;
> +        }
> +    } else {
> +        qdict_put_bool(opts, BDRV_OPT_CACHE_DIRECT, flags & BDRV_O_NOC=
ACHE);
> +        qdict_put_bool(opts, BDRV_OPT_CACHE_NO_FLUSH, flags & BDRV_O_N=
O_FLUSH);
> +    }
> +
>      bdrv_subtree_drained_begin(bs);
>      brq =3D bdrv_reopen_queue(NULL, bs, opts, flags);
>      bdrv_reopen_multiple(bdrv_get_aio_context(bs), brq, &local_err);
> diff --git a/tests/qemu-iotests/133 b/tests/qemu-iotests/133
> index b9f17c996f..a58130c5b4 100755
> --- a/tests/qemu-iotests/133
> +++ b/tests/qemu-iotests/133
> @@ -98,6 +98,15 @@ echo
> =20
>  $QEMU_IO -c 'reopen -o read-only=3Dfoo' $TEST_IMG
> =20
> +echo
> +echo "=3D=3D=3D Check that mixing -c/-r/-w and their equivalent option=
s is forbidden =3D=3D=3D"
> +echo
> +
> +$QEMU_IO -c 'reopen -r -o read-only=3Don' $TEST_IMG
> +$QEMU_IO -c 'reopen -w -o read-only=3Don' $TEST_IMG

The equivalent option however would be read-only=3Doff.

> +$QEMU_IO -c 'reopen -c none -o cache.direct=3Don' $TEST_IMG
> +$QEMU_IO -c 'reopen -c writeback -o cache.direct=3Don' $TEST_IMG

But the equivalent option would be cache.direct=3Doff.

> +$QEMU_IO -c 'reopen -c directsync -o cache.no-flush=3Don' $TEST_IMG

And cache.direct=3Don here.  Or rather, the equivalent -c value for
cache.no-flush=3Don would be "unsafe".

It doesn't really matter, but if you don't care, it shouldn't say
"equivalent options" but maybe "corresponding options".

Overall, the patch looks good.

Max

>  # success, all done
>  echo "*** done"
>  rm -f $seq.full
> diff --git a/tests/qemu-iotests/133.out b/tests/qemu-iotests/133.out
> index 570f623b6b..4d84401688 100644
> --- a/tests/qemu-iotests/133.out
> +++ b/tests/qemu-iotests/133.out
> @@ -28,4 +28,12 @@ format name: null-co
>  =3D=3D=3D Check that invalid options are handled correctly =3D=3D=3D
> =20
>  Parameter 'read-only' expects 'on' or 'off'
> +
> +=3D=3D=3D Check that mixing -c/-r/-w and their equivalent options is f=
orbidden =3D=3D=3D
> +
> +Can't set both -r/-w and 'read-only'
> +Can't set both -r/-w and 'read-only'
> +Can't set both -c and the cache options
> +Can't set both -c and the cache options
> +Can't set both -c and the cache options
>  *** done
>=20



--u6qO8kCczAZyaEucLtFo6Zkq4VtLu78LC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu6u3IACgkQ9AfbAGHV
z0Do3Af6A8+Ym9CCuxcV5JoFS1eZp8Hqny29z2Ie69FC3Vm+sPJvDR8UFQuzlUdx
G7tkNl3b0xhQ8hNCzMuqArGP+p/KGSPSYfyqbhs/0IGgR6l4ID9CcVnmvmgOBOmE
o3iQv/DU7dAr8zpKrZ8tAc7QvmAWrYLJRLcR4t+bz+AFKTtgdPh48czx3+Q1zQ+n
BrEduG+PUS25zAFXEsg7vBm6LBiZdBUZ40cr/5oIcLRUiXTbyiOf/uq5cA4/QJl/
86YIW7gvyE8aZ7J+GI9SRvjwJpHs2vmDq1j4phpz5XKwuCTdXRoQ5ad3k3IFH+1J
L9OGOVc4sXs7ZD2kEYV7OZB9rWJdlg==
=0rzh
-----END PGP SIGNATURE-----

--u6qO8kCczAZyaEucLtFo6Zkq4VtLu78LC--
