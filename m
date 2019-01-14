Received: from eggs.gnu.org ([209.51.188.92]:54131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gizgn-0004eM-4y
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:41:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gizgk-0005RR-L9
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:41:53 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gizgk-0005OC-9c
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:41:50 -0500
Received: by mail-wm1-x344.google.com with SMTP id f188so8279880wmf.5
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 02:41:50 -0800 (PST)
Date: Mon, 14 Jan 2019 10:41:47 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190114104147.GC7038@stefanha-x1.localdomain>
References: <1547451317-21375-1-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Content-Disposition: inline
In-Reply-To: <1547451317-21375-1-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH] vhost-user-blk: enable discard/write
 zeroes features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com, sgazare@redhat.com


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2019 at 03:35:17PM +0800, Changpeng Liu wrote:
> Linux commit 1f23816b8 "virtio_blk: add discard and write zeroes support"
> added the support in the Guest kernel, while here enable the feature bits
> support with vhost-user-blk driver.  Also enable the test example utility
> with DISCARD command support.

The commit message mentions write zeroes but this patch only covers
discard.  Will you send a separate patch for write zeros?

> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>

CCed Stefano, who is working on hw/block/virtio-blk.c emulation support.

> @@ -157,6 +161,29 @@ vub_writev(VubReq *req, struct iovec *iov, uint32_t =
iovcnt)
>      return rc;
>  }
> =20
> +static int
> +vub_discard(VubReq *req, struct iovec *iov, uint32_t iovcnt)
> +{
> +    if (iovcnt !=3D 1) {

This is a virtio specification violation.  The iovec layout is
intentionally not part of the specification, leaving the guest driver
free to choose its preferred layout.

The device backend must accept any layout, including splitting a struct
across iovecs or even many small iovecs of just 1 byte!

> +        fprintf(stderr, "Invalid Discard IOV count\n");
> +        return -1;
> +    }
> +
> +    #if defined(__linux__) && defined(BLKDISCARD)
> +    VubDev *vdev_blk =3D req->vdev_blk;
> +    struct virtio_blk_discard_write_zeroes *desc =3D
> +                       (struct virtio_blk_discard_write_zeroes *)iov->io=
v_base;

Missing input size check.  Even if this example isn't used in
production, it's important to validate inputs since other people will
implement their vhost-user backend based on this example.

Please check that sizeof(*desc) bytes are really available before
accessing it.

> +    case VIRTIO_BLK_T_DISCARD: {
> +        int rc;
> +        rc =3D vub_discard(req, &elem->out_sg[1], out_num);
> +        if (rc =3D=3D 0) {
>              req->in->status =3D VIRTIO_BLK_S_OK;
> -            req->size =3D elem->in_sg[0].iov_len;
> -            vub_req_complete(req);
> -            break;
> -        }
> -        default: {
> +        } else {
>              req->in->status =3D VIRTIO_BLK_S_UNSUPP;

Is there no IOERR case?  BLKDISCARD can probably fail due to an I/O
error and that shouldn't be reported as UNSUPP.

> @@ -454,7 +492,7 @@ vub_get_blocksize(int fd)
> =20
>  #if defined(__linux__) && defined(BLKSSZGET)
>      if (ioctl(fd, BLKSSZGET, &blocksize) =3D=3D 0) {
> -        return blocklen;
> +        return blocksize;
>      }
>  #endif

Unrelated bug fix?  Please submit a separate patch.

Do you know why the patchew, Travis, etc continuous integration systems
didn't detect the compile error?  Please ensure that
contrib/vhost-user-blk/ is covered by CI.

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcPGdrAAoJEJykq7OBq3PIdUwH/j5vpXy0urmhtUGyFZkUcKgX
TeXVj6ycvxuAhrEYPW9x5daodh/CkatvgjeVJaxde28M7eVAZU+3lvaUQl3jsIP3
GpaLfVxBtzF01ZXBQ3BFNuQcMd3ZUHbHff9rwqOEqhWBbUtcMMJWb18lRkLmcEOf
S/2HaT8X2QUjnEXDHYI9FCgJs+8Xh6pmsT2t6uiyTQgbqu3k+77IR8+Efjm5jBId
p0KtFz0fsOJ3NukdBQX/lcqz5IE+/5a5WXt1Zgn5TtCZxm5NfcUTydclexh3VE34
4BR94gpg9A0GXA+OeeQf3wEddr10OJr8B9qPKGwxcqyrOgv7S1++rxW2AjDCeUg=
=f9Z5
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
