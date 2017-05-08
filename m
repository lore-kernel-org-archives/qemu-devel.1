Received: from eggs.gnu.org ([2001:4830:134:3::10]:53871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7q10-00069R-Oc
	for qemu-devel@nongnu.org; Mon, 08 May 2017 17:16:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7q0w-0002Ez-Nq
	for qemu-devel@nongnu.org; Mon, 08 May 2017 17:16:22 -0400
Date: Mon, 8 May 2017 17:16:15 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170508211615.GB23989@stefanha-x1.localdomain>
References: <1493042140-25551-1-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
In-Reply-To: <1493042140-25551-1-git-send-email-lidongchen@tencent.com>
Subject: Re: [Qemu-devel] [PATCH] migration/block: optimize the performance
 by coalescing the same write type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jemmy858585@gmail.com
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, Lidong Chen <lidongchen@tencent.com>


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 24, 2017 at 09:55:40PM +0800, jemmy858585@gmail.com wrote:
> From: Lidong Chen <lidongchen@tencent.com>
>=20
> This patch optimizes the performance by coalescing the same write type.
> When the zero/non-zero state changes, perform the write for the accumulat=
ed
> cluster count.
>=20
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> ---
>     Thanks Fam Zheng and Stefan's advice.
> ---
>  migration/block.c | 66 +++++++++++++++++++++++++++++++++++++++++--------=
------
>  1 file changed, 49 insertions(+), 17 deletions(-)
>=20
> diff --git a/migration/block.c b/migration/block.c
> index 060087f..e9c5e21 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -40,6 +40,8 @@
> =20
>  #define MAX_INFLIGHT_IO 512
> =20
> +#define MIN_CLUSTER_SIZE 8192

The loop accumulates adjacent zero/non-zero regions.  What is the point
of this constant?

I guess you are trying to reduce the number of loop iterations when
cluster size is small (e.g. 512).  Do you have performance results
showing that this really makes a difference?

It would be simpler to remove MIN_CLUSTER_SIZE.  Unless there is
evidence showing it's necessary simpler code is better.

> @@ -943,29 +946,58 @@ static int block_load(QEMUFile *f, void *opaque, in=
t version_id)
>                                          nr_sectors * BDRV_SECTOR_SIZE,
>                                          BDRV_REQ_MAY_UNMAP);
>              } else {
> -                int i;
> -                int64_t cur_addr;
> -                uint8_t *cur_buf;
> +                int64_t cur_addr =3D addr * BDRV_SECTOR_SIZE;
> +                uint8_t *cur_buf =3D NULL;
> +                int64_t last_addr =3D addr * BDRV_SECTOR_SIZE;
> +                uint8_t *last_buf =3D NULL;
> +                int64_t end_addr =3D addr * BDRV_SECTOR_SIZE + BLOCK_SIZ=
E;
> =20
>                  buf =3D g_malloc(BLOCK_SIZE);
>                  qemu_get_buffer(f, buf, BLOCK_SIZE);
> -                for (i =3D 0; i < BLOCK_SIZE / cluster_size; i++) {
> -                    cur_addr =3D addr * BDRV_SECTOR_SIZE + i * cluster_s=
ize;
> -                    cur_buf =3D buf + i * cluster_size;
> -
> -                    if ((!block_mig_state.zero_blocks ||
> -                        cluster_size < BLOCK_SIZE) &&
> -                        buffer_is_zero(cur_buf, cluster_size)) {
> -                        ret =3D blk_pwrite_zeroes(blk, cur_addr,
> -                                                cluster_size,
> +                cur_buf =3D buf;
> +                last_buf =3D buf;
> +
> +                while (last_addr < end_addr) {
> +                    int is_zero =3D 0;

Please use bool for boolean values.

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZEOAfAAoJEJykq7OBq3PIfY4H/0O4dnIfTv/bSkoAyVqz4UC5
AwfiJfUqQhg73CtnaybwDnfc6td06MF0V8xsyDR+pad0QM/P/4WfHdkZb7yd/LFC
tWTdoe/+0bfHmDqMqxcszHPC1c/KUEbl0iTqpBn0pnaqaC9be7MeU3p967I90SU2
RY8tNcdOHSGUqhy1Zv+2ipBg1p6shySQySte9kXAtGMtrzYNftviG2naNCfnmJ/m
tr1CeqlS2xu1F8k1jq2TUK+9NZheDqyZQJkoqO5Ctd881bsh6wunMkjxbMFiXGke
aO/RjqrnRfrWW9jGOr010tot0Rkw6zY/8GT7cdrsGOtMWaiIcNXA79BTcivVXQA=
=by4a
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
