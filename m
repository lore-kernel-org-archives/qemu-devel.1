Received: from eggs.gnu.org ([2001:4830:134:3::10]:44414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fs4fV-0000Ra-KW
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fs4fU-00045J-SZ
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:17:49 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:46298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fs4fU-00044o-Ku
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:17:48 -0400
Received: by mail-wr1-x433.google.com with SMTP id a108-v6so12861717wrc.13
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 04:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180821111313.27792-1-kraxel@redhat.com>
	<20180821111313.27792-2-kraxel@redhat.com>
In-Reply-To: <20180821111313.27792-2-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Aug 2018 13:17:35 +0200
Message-ID: <CAJ+F1CJcBOauL_U1APo+BNVYcBiyAXfQ2TVV7U-VfjU6etq3dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] virtio-vga: fix reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

Hi

On Tue, Aug 21, 2018 at 1:13 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> We must call the reset functions for both virtio-gpu
> and vga to properly reset the combo device.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/hw/virtio/virtio-gpu.h | 1 +
>  hw/display/virtio-gpu.c        | 2 +-
>  hw/display/virtio-vga.c        | 6 +++++-
>  3 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index d0321672f4..a718b7233f 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -150,6 +150,7 @@ extern const GraphicHwOps virtio_gpu_ops;
>      } while (0)
>
>  /* virtio-gpu.c */
> +void virtio_gpu_reset(VirtIODevice *vdev);
>  void virtio_gpu_ctrl_response(VirtIOGPU *g,
>                                struct virtio_gpu_ctrl_command *cmd,
>                                struct virtio_gpu_ctrl_hdr *resp,
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 3ddd29c0de..d6c9b02b86 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1289,7 +1289,7 @@ static void virtio_gpu_instance_init(Object *obj)
>  {
>  }
>
> -static void virtio_gpu_reset(VirtIODevice *vdev)
> +void virtio_gpu_reset(VirtIODevice *vdev)
>  {
>      VirtIOGPU *g =3D VIRTIO_GPU(vdev);
>      struct virtio_gpu_simple_resource *res, *tmp;
> diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
> index 701d980872..50c72f26f4 100644
> --- a/hw/display/virtio-vga.c
> +++ b/hw/display/virtio-vga.c
> @@ -179,8 +179,12 @@ static void virtio_vga_realize(VirtIOPCIProxy *vpci_=
dev, Error **errp)
>  static void virtio_vga_reset(DeviceState *dev)
>  {
>      VirtIOVGA *vvga =3D VIRTIO_VGA(dev);
> -    vvga->vdev.enable =3D 0;
>
> +    /* reset virtio-gpu */
> +    virtio_gpu_reset(VIRTIO_DEVICE(&vvga->vdev));
> +
> +    /* reset vga */
> +    vga_common_reset(&vvga->vga);

Ah, I only tested with vga_common_reset(). I was missing the
virtio_gpu_reset() part.

I assume you tested it?

>      vga_dirty_log_start(&vvga->vga);
>  }
>
> --
> 2.9.3
>


--=20
Marc-Andr=C3=A9 Lureau
