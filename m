Received: from eggs.gnu.org ([2001:4830:134:3::10]:39492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYik0-0007y2-OA
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 19:25:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYijz-0007hM-Fc
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 19:25:40 -0500
References: <20170120162527.66075-1-farman@linux.vnet.ibm.com>
	<20170120162527.66075-3-farman@linux.vnet.ibm.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <758554c2-62d9-dc1d-088e-cb68933e9d0b@redhat.com>
Date: Wed, 1 Feb 2017 01:25:29 +0100
MIME-Version: 1.0
In-Reply-To: <20170120162527.66075-3-farman@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XjkrajD9fE0Die3OaX7Gw7oRhldLADqoi"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 2/3] block: Fix target
 variable of BLKSECTGET ioctl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XjkrajD9fE0Die3OaX7Gw7oRhldLADqoi
From: Max Reitz <mreitz@redhat.com>
To: Eric Farman <farman@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: kwolf@redhat.com
Message-ID: <758554c2-62d9-dc1d-088e-cb68933e9d0b@redhat.com>
Subject: Re: [Qemu-block] [PATCH v3 2/3] block: Fix target variable of
 BLKSECTGET ioctl
References: <20170120162527.66075-1-farman@linux.vnet.ibm.com>
 <20170120162527.66075-3-farman@linux.vnet.ibm.com>
In-Reply-To: <20170120162527.66075-3-farman@linux.vnet.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 20.01.2017 17:25, Eric Farman wrote:
> Commit 6f6071745bd0 ("raw-posix: Fetch max sectors for host block devic=
e")
> introduced a routine to call the kernel BLKSECTGET ioctl, which stores =
the
> result back to user space.  However, the size of the data returned depe=
nds
> on the routine handling the ioctl.  The (compat_)blkdev_ioctl returns a=

> short, while sg_ioctl returns an int.  Thus, on big-endian systems, we =
can
> find ourselves accidentally shifting the result to a much larger value.=

> (On s390x, a short is 16 bits while an int is 32 bits.)
>=20
> Also, the two ioctl handlers return values in different scales (block
> returns sectors, while sg returns bytes), so some tweaking of the outpu=
ts
> is required such that hdev_get_max_transfer_length returns a value in a=

> consistent set of units.
>=20
> Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
> ---
>  block/file-posix.c    | 17 ++++++++++-------
>  include/block/block.h |  1 +
>  2 files changed, 11 insertions(+), 7 deletions(-)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 28b47d9..9f83725 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -651,12 +651,15 @@ static void raw_reopen_abort(BDRVReopenState *sta=
te)
>      state->opaque =3D NULL;
>  }
> =20
> -static int hdev_get_max_transfer_length(int fd)
> +static int hdev_get_max_transfer_length(BlockDriverState *bs, int fd)
>  {
>  #ifdef BLKSECTGET
> -    int max_sectors =3D 0;
> -    if (ioctl(fd, BLKSECTGET, &max_sectors) =3D=3D 0) {
> -        return max_sectors;
> +    int max_bytes =3D 0;
> +    short max_sectors =3D 0;
> +    if (bs->sg && ioctl(fd, BLKSECTGET, &max_bytes) =3D=3D 0) {
> +        return max_bytes;
> +    } else if (!bs->sg && ioctl(fd, BLKSECTGET, &max_sectors) =3D=3D 0=
) {
> +        return max_sectors << BDRV_SECTOR_BITS;
>      } else {
>          return -errno;
>      }
> @@ -672,9 +675,9 @@ static void raw_refresh_limits(BlockDriverState *bs=
, Error **errp)
> =20
>      if (!fstat(s->fd, &st)) {
>          if (S_ISBLK(st.st_mode)) {
> -            int ret =3D hdev_get_max_transfer_length(s->fd);
> -            if (ret > 0 && ret <=3D BDRV_REQUEST_MAX_SECTORS) {
> -                bs->bl.max_transfer =3D pow2floor(ret << BDRV_SECTOR_B=
ITS);
> +            int ret =3D hdev_get_max_transfer_length(bs, s->fd);
> +            if (ret > 0 && ret <=3D BDRV_REQUEST_MAX_BYTES) {
> +                bs->bl.max_transfer =3D pow2floor(ret);
>              }
>          }
>      }
> diff --git a/include/block/block.h b/include/block/block.h
> index 8b0dcda..4e81f20 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -116,6 +116,7 @@ typedef struct HDGeometry {
> =20
>  #define BDRV_REQUEST_MAX_SECTORS MIN(SIZE_MAX >> BDRV_SECTOR_BITS, \
>                                       INT_MAX >> BDRV_SECTOR_BITS)
> +#define BDRV_REQUEST_MAX_BYTES (BDRV_REQUEST_MAX_SECTORS << BDRV_SECTO=
R_BITS)

I'd rather like it the other way round (i.e.

#define BDRV_REQUEST_MAX_BYTES MIN(SIZE_MAX, INT_MAX)
#define BDRV_REQUEST_MAX_SECTORS (BDRV_REQUEST_MAX_BYTES >>
BDRV_SECTOR_BITS)

), but I don't suppose I can interest you in a respin, can I? Would it
be OK with you if I changed you commit when I apply it?

Max

> =20
>  /*
>   * Allocation status flags
>=20



--XjkrajD9fE0Die3OaX7Gw7oRhldLADqoi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliRKvoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AgR4H/3Z5X9Rjwbl4tdlsPczRUAqacbTaIMWQ
hpUjomyRJCq/A57ewuNFGoxeZdWoSqN1DgRkoLaJD9BHkZ4zfVjmZd9WreeRi353
PrSTCIpNsqfV/RyMablngXZa00oGb2ZyPgpeTnDIUE158OkASVeFfZY4xw7bMwcn
YklzgtpSFXTPdo+hwa43W1Mzz16QLBQXO217D9uL+UnFh1PARV5H/F9IKS1c3/FB
YtGG/jTU0+60UUD3V1KJ2/IdE7vyQhRIVMYUJSficUpBjh6zQEkQmHT+HygWZZBc
HB0Gdq9y/gEUAjatyJqmy11OvA859QZgwLlXgpEe9GAcimCESN+EHS8=
=lvYB
-----END PGP SIGNATURE-----

--XjkrajD9fE0Die3OaX7Gw7oRhldLADqoi--
