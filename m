Received: from eggs.gnu.org ([2001:4830:134:3::10]:33258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eCkAW-0003Eq-7u
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 05:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eCkAS-0008Q4-7L
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 05:34:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eCkAS-0008PY-1x
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 05:34:40 -0500
Date: Thu, 9 Nov 2017 05:34:37 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <152319465.38481678.1510223677165.JavaMail.zimbra@redhat.com>
In-Reply-To: <20171108180536.38781-1-lepton@google.com>
References: <20171108180536.38781-1-lepton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu: fix bug in host memory
 calculation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tao Wu <lepton@google.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, airlied@redhat.com, liqiang6-s@360.cn

Hi

----- Original Message -----
> The old code treats bits as bytes when calculating host memory usage.
> Change it to be consistent with allocation logic in pixman library.
>=20

Good catch

> Signed-off-by: Tao Wu <lepton@google.com>
> ---
>  hw/display/virtio-gpu.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 43bbe09ea0..428786f291 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -322,6 +322,15 @@ static pixman_format_code_t get_pixman_format(uint32=
_t
> virtio_gpu_format)
>      }
>  }
> =20
> +static uint32_t calc_image_hostmem(pixman_format_code_t pformat,
> +                                   uint32_t width, uint32_t height)
> +{
> +    /* copied from pixman/pixman-bits-image.c, skip integer overflow che=
ck.
> */

So we rely on pixman create_bits() to fail if overflow happened? perhaps it=
's worth a comment.
=20
> +    int bpp =3D PIXMAN_FORMAT_BPP(pformat);
> +    int stride =3D ((width * bpp + 0x1f) >> 5) * sizeof(uint32_t);
> +    return height * stride;
> +}
> +
>  static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
>                                            struct virtio_gpu_ctrl_command
>                                            *cmd)
>  {
> @@ -366,7 +375,7 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *=
g,
>          return;
>      }
> =20
> -    res->hostmem =3D PIXMAN_FORMAT_BPP(pformat) * c2d.width * c2d.height=
;
> +    res->hostmem =3D calc_image_hostmem(pformat, c2d.width, c2d.height);
>      if (res->hostmem + g->hostmem < g->conf.max_hostmem) {
>          res->image =3D pixman_image_create_bits(pformat,
>                                                c2d.width,
> @@ -1087,7 +1096,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaqu=
e,
> size_t size,
>              return -EINVAL;
>          }
> =20
> -        res->hostmem =3D PIXMAN_FORMAT_BPP(pformat) * res->width *
> res->height;
> +        res->hostmem =3D calc_image_hostmem(pformat, res->width, res->he=
ight);
> =20
>          res->addrs =3D g_new(uint64_t, res->iov_cnt);
>          res->iov =3D g_new(struct iovec, res->iov_cnt);
> --
> 2.15.0.403.gc27cc4dac6-goog
>=20

looks good otherwise,

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>=20
