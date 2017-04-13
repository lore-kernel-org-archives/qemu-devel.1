Received: from eggs.gnu.org ([2001:4830:134:3::10]:37730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cyeni-0007fg-Cw
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 09:28:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cyenh-0000sa-Dr
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 09:28:42 -0400
Date: Thu, 13 Apr 2017 14:28:25 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170413132825.GB13387@stefanha-x1.localdomain>
References: <20170411155226.6395-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <20170411155226.6395-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] Revert "block/io: Comment out
 permission assertions"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2017 at 05:52:26PM +0200, Max Reitz wrote:
> This reverts commit e3e0003a8f6570aba1421ef99a0b383a43371a74.
>=20
> This commit was necessary for the 2.9 release because we were unable to
> fix the underlying issue(s) in time. However, we will be for 2.10.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c    |  6 +-----
>  block/io.c | 12 ++----------
>  2 files changed, 3 insertions(+), 15 deletions(-)

Should we merge a fix before enabling the assertion again?  It's a known
issue.  Let people using qemu.git live a little and have fun without the
inevitable SIGABRT coredumps.  We don't benefit if more people encounter
this crash and duplicate work debugging it.

> diff --git a/block.c b/block.c
> index 1fbbb8d606..086a12df97 100644
> --- a/block.c
> +++ b/block.c
> @@ -3274,11 +3274,7 @@ int bdrv_truncate(BdrvChild *child, int64_t offset)
>      BlockDriver *drv =3D bs->drv;
>      int ret;
> =20
> -    /* FIXME: Some format block drivers use this function instead of imp=
licitly
> -     *        growing their file by writing beyond its end.
> -     *        See bdrv_aligned_pwritev() for an explanation why we curre=
ntly
> -     *        cannot assert this permission in that case. */
> -    // assert(child->perm & BLK_PERM_RESIZE);
> +    assert(child->perm & BLK_PERM_RESIZE);
> =20
>      if (!drv)
>          return -ENOMEDIUM;
> diff --git a/block/io.c b/block/io.c
> index 8706bfa578..bae6947032 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1345,16 +1345,8 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvC=
hild *child,
>      assert(!waited || !req->serialising);
>      assert(req->overlap_offset <=3D offset);
>      assert(offset + bytes <=3D req->overlap_offset + req->overlap_bytes);
> -    /* FIXME: Block migration uses the BlockBackend of the guest device =
at a
> -     *        point when it has not yet taken write permissions. This wi=
ll be
> -     *        fixed by a future patch, but for now we have to bypass this
> -     *        assertion for block migration to work. */
> -    // assert(child->perm & BLK_PERM_WRITE);
> -    /* FIXME: Because of the above, we also cannot guarantee that all fo=
rmat
> -     *        BDS take the BLK_PERM_RESIZE permission on their file BDS,=
 since
> -     *        they are not obligated to do so if they do not have any pa=
rent
> -     *        that has taken the permission to write to them. */
> -    // assert(end_sector <=3D bs->total_sectors || child->perm & BLK_PER=
M_RESIZE);
> +    assert(child->perm & BLK_PERM_WRITE);
> +    assert(end_sector <=3D bs->total_sectors || child->perm & BLK_PERM_R=
ESIZE);
> =20
>      ret =3D notifier_with_return_list_notify(&bs->before_write_notifiers=
, req);
> =20
> --=20
> 2.12.2
>=20

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY73z5AAoJEJykq7OBq3PIud8IAJ//twwehbVtifjN9/cl9QoQ
h56fieMJRbO4Fm1Qy4yAH5POMG3BOsWtMMMqf9jsfCxmlDM3MV3/LeVJM5tirHFI
DDiN/rUlBCVThO9pglRQyl6leIIfZnXNec2Rhw3XNckAdYjmGXs9rmK9EkDsHhJo
OJC7vJvQT49zoVoCrcbwD7U93Qg8yWQjkPN8TQoMMiXtuUeeoXzU0XpxlYryfF9f
CKhhXghsLnqBxLYM/zWU4cQoUuHiiG87dR80zUuosITZbO1twxiGHzwFJQQJ8RNO
nObtKUVHpQ1WbmtBDY/oL46Wj/618dDAzCb6RdewbqNurTWodGNaOAlG/CXQVNI=
=Wdpe
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
