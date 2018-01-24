Received: from eggs.gnu.org ([2001:4830:134:3::10]:44339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eeJHA-000076-KU
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 06:31:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eeJH9-00022j-O4
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 06:31:32 -0500
Date: Wed, 24 Jan 2018 11:31:23 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180124113123.GB17193@stefanha-x1.localdomain>
References: <1516633309-20803-1-git-send-email-mark.kanda@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
In-Reply-To: <1516633309-20803-1-git-send-email-mark.kanda@oracle.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-blk: check for NULL BlockDriverState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, karl.heubaum@oracle.com, ameya.more@oracle.com, Mark Kanda <mark.kanda@oracle.com>


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2018 at 09:01:49AM -0600, Mark Kanda wrote:
> Add a BlockDriverState NULL check to virtio_blk_handle_request()
> to prevent a segfault if the drive is forcibly removed using HMP
> 'drive_del' (without performing a hotplug 'device_del' first).
>=20
> Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> Reviewed-by: Ameya More <ameya.more@oracle.com>
> ---
>  hw/block/virtio-blk.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index b1532e4..76ddbbf 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -507,6 +507,13 @@ static int virtio_blk_handle_request(VirtIOBlockReq =
*req, MultiReqBuffer *mrb)
>          return -1;
>      }
> =20
> +    /* If the drive was forcibly removed (e.g. HMP 'drive_del'), the blo=
ck
> +     * driver state may be NULL and there is nothing left to do. */
> +    if (!blk_bs(req->dev->blk)) {

Adding Markus Armbruster to check my understanding of drive_del:

1. If id is a node name (e.g. created via blockdev-add) then attempting
   to remove the root node produces the "Node %s is in use" error.  In
   that case this patch isn't needed.

2. If id is a BlockBackend (e.g. created via -drive) then removing the
   root node is allowed.  The BlockBackend stays in place but blk->root
   becomes NULL, hence this patch is needed.

Markus: What are the valid use cases for #2?  If blk->bs becomes NULL I
would think a lot more code beyond virtio-blk can segfault.

> +        virtio_error(vdev, "virtio-blk BlockDriverState is NULL");
> +        return -1;
> +    }
> +
>      /* We always touch the last byte, so just see how big in_iov is.  */
>      req->in_len =3D iov_size(in_iov, in_num);
>      req->in =3D (void *)in_iov[in_num - 1].iov_base
> --=20
> 1.8.3.1
>=20

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaaG6LAAoJEJykq7OBq3PI7mEH/2scS6onYMcL8K8SWg2CggmX
yB8WG6ak12/wOm5DxWWhTKUvX0XxqMO4cY0iOBJzKdPRoffktTcsTaCBZzPh4LkF
MaUoVc48hotNXczSPtsB3WGzM7k2xd6LspsUNVwl6uXuX3xemQJINFZCYDtho1fk
9fXwv1C3AWmOUH2Qw8dGBlXuOOcpk3GUZdxgjSCR14p9J1ODWNrJowDgYnHpnGyr
5+p2n3Ldy8uYSICPNwsDe32khRyiNOWiYVbPxBBa4xBGCgEd4vbWZfJL79UK3Mh5
mSbwdmDAeoaZ/XlgySeLSyemnGFo0ZpZueFNwN11lw0ni6wSne3EoGlx5094J78=
=2DH8
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
