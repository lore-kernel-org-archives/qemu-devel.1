Received: from eggs.gnu.org ([2001:4830:134:3::10]:42441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cIzuq-0002d1-Mz
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 10:31:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cIzup-0001Sa-PM
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 10:31:52 -0500
References: <1482187106-85065-1-git-send-email-sochin.jiang@huawei.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5c75620e-6c60-5cae-a0d7-9d64c3de6044@redhat.com>
Date: Mon, 19 Dec 2016 16:31:40 +0100
MIME-Version: 1.0
In-Reply-To: <1482187106-85065-1-git-send-email-sochin.jiang@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nPUVpQWG2LcM27WebGCofdaPOpuPfEnlr"
Subject: Re: [Qemu-devel] [PATCH] mirror: prevent 'top' mode mirroring when
 no backing file specified on the destination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sochin jiang <sochin.jiang@huawei.com>, jcody@redhat.com, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, xieyingtai@huawei.com, eric.fangyi@huawei.com, subo7@huawei.com, wangjie88@huawei.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nPUVpQWG2LcM27WebGCofdaPOpuPfEnlr
From: Max Reitz <mreitz@redhat.com>
To: sochin jiang <sochin.jiang@huawei.com>, jcody@redhat.com, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, xieyingtai@huawei.com,
 eric.fangyi@huawei.com, subo7@huawei.com, wangjie88@huawei.com
Message-ID: <5c75620e-6c60-5cae-a0d7-9d64c3de6044@redhat.com>
Subject: Re: [PATCH] mirror: prevent 'top' mode mirroring when no backing file
 specified on the destination
References: <1482187106-85065-1-git-send-email-sochin.jiang@huawei.com>
In-Reply-To: <1482187106-85065-1-git-send-email-sochin.jiang@huawei.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 19.12.2016 23:38, sochin jiang wrote:
>  Mirroring using 'top' mode without backing file specified on the targe=
t can be success,
>  but end with a disaster.
>=20
>  For example:
>    Migration can be success in this situation while the virtual machine=
 on the destination
>  is no longer usable because of backing lost.
>=20
>  Remind the user earlier and return error in case of misoperation.
>=20
> Signed-off-by: sochin jiang <sochin.jiang@huawei.com>
> ---
>  block/mirror.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/block/mirror.c b/block/mirror.c
> index 301ba92..3476696 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1038,6 +1038,12 @@ void mirror_start(const char *job_id, BlockDrive=
rState *bs,
>          error_setg(errp, "Sync mode 'incremental' not supported");
>          return;
>      }
> +    if (mode =3D=3D MIRROR_SYNC_MODE_TOP && !backing_bs(target))
> +    {

Syntactic issue: The opening brace should be on the same line as the "if"=
=2E

> +        error_setg(errp, "Target Backing required using Sync mode 'top=
'");
> +        return;
> +    }
> +
>      is_none_mode =3D mode =3D=3D MIRROR_SYNC_MODE_NONE;
>      base =3D mode =3D=3D MIRROR_SYNC_MODE_TOP ? backing_bs(bs) : NULL;=

>      mirror_start_job(job_id, bs, BLOCK_JOB_DEFAULT, target, replaces,

General issue: For blockdev-mirror, I think this is a legitimate use
case. As far as I'm aware, libvirt uses the mirror block job for all
backups -- they do so by cancelling the block job after the
BLOCK_JOB_READY event instead of letting it complete. So a user might
want to mirror some drive somewhere else (in sync=3Dtop mode, with the ne=
w
location not yet having assigned a backing file to it), then cancel the
block job after BLOCK_JOB_READY and only assign the backing file at some
later point.

An even greater issue is that qmp_drive_mirror() opens the target BDS
with BDRV_O_NO_BACKING. Therefore, this will always error out with
drive-mirror and sync=3Dtop (unless the source image does not have a
backing file, in which case the sync=3Dtop will silently be converted to
sync=3Dfull).

For drive-mirror, the target's backing chain will not be set up until
mirror_complete().

Max


--nPUVpQWG2LcM27WebGCofdaPOpuPfEnlr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhX/VwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AT74IAKOLc52kfqix0veS9o84e92/r6p9HS8v
4AS9mYjnA0tr7V4qdZ6k6iCqyrofatKtx3GylONyWhiWNNMtUWQ73v5DaMzlExRV
1bTZVy2lEHWXCnsd/RBy4CwKceTQiQ8ZTpIPBV6cfShIpjBvBG2W5kI7tJz00ERu
XURhwl1+/rQN45dKNJfpgN+ct8I/ebRxQKIdPlXvce4m7D8xHNaflK4IsjCExwNq
xuyhMohSZKaIyTQKxyGEm9V7ATwDGc25QNLE5mpWnPMQr7WrtWuFxRzzdSBnKw5V
qGFTMHab3aTtjwmE4EPfXL3WtQEIq/Vzl4YgH7SA3lRXbsjOpoyRpUI=
=OnOq
-----END PGP SIGNATURE-----

--nPUVpQWG2LcM27WebGCofdaPOpuPfEnlr--
