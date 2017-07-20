Received: from eggs.gnu.org ([2001:4830:134:3::10]:38982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dYCCl-0004hO-Gq
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 10:13:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dYCCj-0003Ju-UG
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 10:13:27 -0400
References: <1500556314-32102-1-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b94821ce-476f-42b7-7fc5-fcff1b83fe7d@redhat.com>
Date: Thu, 20 Jul 2017 16:06:01 +0200
MIME-Version: 1.0
In-Reply-To: <1500556314-32102-1-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dr4Jb4XAxIROR15XQgmguQ7H97vPvtC9Q"
Subject: Re: [Qemu-devel] [PATCH for-2.10 v3] block: Skip implicit nodes in
 query-block/blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, pkrempa@redhat.com, nsoffer@redhat.com, el13635@mail.ntua.gr, qemu-devel@nongnu.org, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dr4Jb4XAxIROR15XQgmguQ7H97vPvtC9Q
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, pkrempa@redhat.com,
 nsoffer@redhat.com, el13635@mail.ntua.gr, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Message-ID: <b94821ce-476f-42b7-7fc5-fcff1b83fe7d@redhat.com>
Subject: Re: [PATCH for-2.10 v3] block: Skip implicit nodes in
 query-block/blockstats
References: <1500556314-32102-1-git-send-email-kwolf@redhat.com>
In-Reply-To: <1500556314-32102-1-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-20 15:11, Kevin Wolf wrote:
> Commits 0db832f and 6cdbceb introduced the automatic insertion of filte=
r
> nodes above the top layer of mirror and commit block jobs. The
> assumption made there was that since libvirt doesn't do node-level
> management of the block layer yet, it shouldn't be affected by added
> nodes.
>=20
> This is true as far as commands issued by libvirt are concerned. It onl=
y
> uses BlockBackend names to address nodes, so any operations it performs=

> still operate on the root of the tree as intended.
>=20
> However, the assumption breaks down when you consider query commands,
> which return data for the wrong node now. These commands also return
> information on some child nodes (bs->file and/or bs->backing), which
> libvirt does make use of, and which refer to the wrong nodes, too.
>=20
> One of the consequences is that oVirt gets wrong information about the
> image size and stops the VM in response as long as a mirror or commit
> job is running:
>=20
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1470634
>=20
> This patch fixes the problem by hiding the implicit nodes created
> automatically by the mirror and commit block jobs in the output of
> query-block and BlockBackend-based query-blockstats as long as the user=

> doesn't indicate that they are aware of those nodes by providing a node=

> name for them in the QMP command to start the block job.
>=20
> The node-based commands query-named-block-nodes and query-blockstats
> with query-nodes=3Dtrue still show all nodes, including implicit ones.
> This ensures that users that are capable of node-level management can
> still access the full information; users that only know BlockBackends
> won't use these commands.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>=20
> v3:
> - Fixed skipping during the recursion for query-block [Peter]
> - Fixed backing_file_depth
> - More thorough test case for mirror, added one for commit
>=20
> v2:
> - Skip implicit nodes not only on the top level, but also during the re=
cursive
>   calls [Peter]
> - Spelling fix in the commit message [Manos]
>=20
>  block.c                    | 13 -------------
>  block/commit.c             |  3 +++
>  block/mirror.c             |  3 +++
>  block/qapi.c               | 33 +++++++++++++++++++++++++++------
>  include/block/block.h      |  1 -
>  include/block/block_int.h  |  1 +
>  qapi/block-core.json       |  6 ++++--
>  tests/qemu-iotests/040     | 30 +++++++++++++++++++++++++++++-
>  tests/qemu-iotests/040.out |  4 ++--
>  tests/qemu-iotests/041     | 38 +++++++++++++++++++++++++++++++++++++-=

>  tests/qemu-iotests/041.out |  4 ++--
>  11 files changed, 108 insertions(+), 28 deletions(-)

[...]

> diff --git a/block/qapi.c b/block/qapi.c
> index 95b2e2d..d2b18ee 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c

[...]

> @@ -133,13 +133,21 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBack=
end *blk,
>              qapi_free_BlockDeviceInfo(info);
>              return NULL;
>          }
> +
>          if (bs0->drv && bs0->backing) {
> +            info->backing_file_depth++;
>              bs0 =3D bs0->backing->bs;
>              (*p_image_info)->has_backing_image =3D true;
>              p_image_info =3D &((*p_image_info)->backing_image);
>          } else {
>              break;
>          }
> +
> +        /* Skip automatically inserted nodes that the user isn't aware=
 of for
> +         * query-block (blk !=3D NULL), but not for query-named-block-=
nodes */
> +        while (blk && bs0 && bs0->drv && bs0->implicit) {
> +            bs0 =3D backing_bs(bs0);
> +        }

If the bottom-most backing file is implicit, this will leave bs0 to be
NULL. The surrounding loop does not look like it could cope well with
that. (And even if it could, we would have to reset has_backing_image to
false, wouldn't we?)

Not necessarily an issue here because all of our implicit nodes are
somewhere in between, but still...

(And I just saw you're even asserting this in another place...)

>      }
> =20
>      return info;

[...]

> @@ -446,6 +459,14 @@ static BlockStats *bdrv_query_bds_stats(const Bloc=
kDriverState *bs,
>          return s;
>      }
> =20
> +    /* Skip automatically inserted nodes that the user isn't aware of =
in
> +     * a BlockBackend-level command. Stay at the exact node for a node=
-level
> +     * command. */
> +    while (blk_level && bs->drv && bs->implicit) {
> +        bs =3D backing_bs(bs);
> +        assert(bs);

(...namely here.)

I extremely doubt this assertion will hold in the future, but well, it's
good enough for now.

So, I've always wanted "file" to be the default child for block filters.
This patch very much establishes that "backing" is the default child, rig=
ht?

So, all in all, I'd rather like to still discuss some things, but (1)
the patch will do what it's supposed to do as-is, and (2) all of what
I'd like to discuss would be about 2.11 anyway. So:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--dr4Jb4XAxIROR15XQgmguQ7H97vPvtC9Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZcLjKEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQK1B
B/48EbcmRsxzZgmHYZtuHKn3bDgI+CKw58QhPVQEHSUvUiilqZ3nVwHmrD1ZRgtH
P1sWrYCL+X2UYMzCzHUjK2BuVdLk6Gl0UbZdAugJwBiiJ/ZgaVAB0yk0DQHtahzd
FZ/CZcrkDY9ZBxvjRF5Y2UsqG/M1E0kRvhjggO9sp1ljsJvNPpyEQ/dcGri40SV8
IerMbvyh3JENvxwDs5JePw6HXH5n727+u8bkJnfelVwSPz83ez5O9xSqhJ4zy8Jk
lIPG5jJ3pl2Wb6KPPDKXL1/57AwlVJi5FyegYkf7oyMqQt5ZBG9/LfaddgtbMepB
AMEHN7ZAxnhEG2HRrn7WPBZ4
=F3/2
-----END PGP SIGNATURE-----

--dr4Jb4XAxIROR15XQgmguQ7H97vPvtC9Q--
