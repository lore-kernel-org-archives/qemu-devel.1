Received: from eggs.gnu.org ([2001:4830:134:3::10]:34393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eCrQj-0004pG-Vs
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 13:19:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eCrQi-0006c7-Ux
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 13:19:57 -0500
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:54498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eCrQi-0006bu-QB
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 13:19:56 -0500
Received: by mail-vk0-x244.google.com with SMTP id b18so2260483vkd.11
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 10:19:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171109181741.31318-1-lepton@google.com>
References: <152319465.38481678.1510223677165.JavaMail.zimbra@redhat.com>
	<20171109181741.31318-1-lepton@google.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 9 Nov 2017 19:19:55 +0100
Message-ID: <CAJ+F1CLa=0tfp8BPFnA6tOyLOndTVFN3A07o1x_rejz_ZHo6jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@redhat.com>

On Thu, Nov 9, 2017 at 7:17 PM, Tao Wu via Qemu-devel
<qemu-devel@nongnu.org> wrote:
> The old code treats bits as bytes when calculating host memory usage.
> Change it to be consistent with allocation logic in pixman library.
>
> Signed-off-by: Tao Wu <lepton@google.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/display/virtio-gpu.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 43bbe09ea0..274e365713 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -322,6 +322,18 @@ static pixman_format_code_t get_pixman_format(uint32=
_t virtio_gpu_format)
>      }
>  }
>
> +static uint32_t calc_image_hostmem(pixman_format_code_t pformat,
> +                                   uint32_t width, uint32_t height)
> +{
> +    /* Copied from pixman/pixman-bits-image.c, skip integer overflow che=
ck.
> +     * pixman_image_create_bits will fail in case it overflow.
> +     */
> +
> +    int bpp =3D PIXMAN_FORMAT_BPP(pformat);
> +    int stride =3D ((width * bpp + 0x1f) >> 5) * sizeof(uint32_t);
> +    return height * stride;
> +}
> +
>  static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
>                                            struct virtio_gpu_ctrl_command=
 *cmd)
>  {
> @@ -366,7 +378,7 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *=
g,
>          return;
>      }
>
> -    res->hostmem =3D PIXMAN_FORMAT_BPP(pformat) * c2d.width * c2d.height=
;
> +    res->hostmem =3D calc_image_hostmem(pformat, c2d.width, c2d.height);
>      if (res->hostmem + g->hostmem < g->conf.max_hostmem) {
>          res->image =3D pixman_image_create_bits(pformat,
>                                                c2d.width,
> @@ -1087,7 +1099,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaqu=
e, size_t size,
>              return -EINVAL;
>          }
>
> -        res->hostmem =3D PIXMAN_FORMAT_BPP(pformat) * res->width * res->=
height;
> +        res->hostmem =3D calc_image_hostmem(pformat, res->width, res->he=
ight);
>
>          res->addrs =3D g_new(uint64_t, res->iov_cnt);
>          res->iov =3D g_new(struct iovec, res->iov_cnt);
> --
> 2.15.0.448.gf294e3d99a-goog
>
>



--=20
Marc-Andr=C3=A9 Lureau
