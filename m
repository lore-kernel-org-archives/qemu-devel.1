Received: from eggs.gnu.org ([209.51.188.92]:55726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gjm9W-0003Nq-AC
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:26:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gjm9V-0007Di-JB
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:26:46 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gjm9U-00076a-86
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:26:45 -0500
Received: by mail-wr1-x442.google.com with SMTP id z5so7096133wrt.11
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 06:26:43 -0800 (PST)
Date: Wed, 16 Jan 2019 14:26:40 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190116142640.GD16898@stefanha-x1.localdomain>
References: <1547615970-23545-1-git-send-email-changpeng.liu@intel.com>
	<1547615970-23545-3-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a2FkP9tdjPU2nyhF"
Content-Disposition: inline
In-Reply-To: <1547615970-23545-3-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] vhost-user-blk: add discard/write
 zeroes features support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: qemu-devel@nongnu.org, sgazare@redhat.com, stefanha@redhat.com, mst@redhat.com


--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 16, 2019 at 01:19:30PM +0800, Changpeng Liu wrote:
> @@ -161,6 +175,44 @@ vub_writev(VubReq *req, struct iovec *iov, uint32_t =
iovcnt)
>      return rc;
>  }
> =20
> +static int
> +vub_discard_write_zeroes(VubReq *req, struct iovec *iov, uint32_t iovcnt,
> +                         uint32_t type)
> +{
> +    struct virtio_blk_discard_write_zeroes *desc;
> +    ssize_t size;
> +    void *buf;
> +
> +    size =3D vub_iov_size(iov, iovcnt);
> +    if (size !=3D sizeof(*desc)) {
> +        fprintf(stderr, "Invalid size %ld, expect %ld\n", size, sizeof(*=
desc));
> +        return -1;
> +    }
> +    buf =3D g_new0(char, size);
> +    vub_iov_to_buf(iov, iovcnt, buf);

It's simpler without g_new0():

  struct virtio_blk_discard_write_zeroes desc;
  ssize_t size;

  size =3D vub_iov_size(iov, iovcnt);
  if (size !=3D sizeof(desc)) {
      fprintf(stderr, "Invalid size %zd, expected %zu\n", size, sizeof(desc=
));
      return -1;
  }
  vub_iov_to_buf(iov, iovcnt, &desc);

  ...

Other than that:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcPz8gAAoJEJykq7OBq3PI6FEH+gIlRlJOL9roRi61soZ+2g7h
2p1RB+V03PRXmEszBpoH+pqD495mxDOKiiYQv+s/dIB+ITh4iRGvj2eKNmIAXnqo
7exUHME5qb9LgQCEnfLWLbmc0EbN6MJpr9l6ZbSpzENPgIO9epc94dRC5nESutgN
FT9izSXeqqQHMxXWct5UJG7DgQ/mBPxPxoW9AuAAhF94wFRSPPBf860Sa3dv/lAv
TgWYpjgPsBZwYgXqK0YhqnDxQORF2RtiCAVzZf1pYNUcErk3eLeCg0zfwrRfzRwK
6QEJr5bSmcItJT4N2+hEn76Oe+FoOELlT0ATreGPDVHc/CwLBhMIYrYozL6jr74=
=xfQO
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--
