Received: from eggs.gnu.org ([2001:4830:134:3::10]:39775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d6brr-0006OY-6b
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d6brq-0005Be-6z
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:57:51 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:36375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1d6brp-00058k-S8
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:57:50 -0400
Received: by mail-lf0-x244.google.com with SMTP id h4so360658lfj.3
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 04:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20170505104101.30589-1-kraxel@redhat.com>
	<20170505104101.30589-2-kraxel@redhat.com>
In-Reply-To: <20170505104101.30589-2-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 05 May 2017 11:57:35 +0000
Message-ID: <CAJ+F1CJBrpj=+8xH1WjHQzRrGr+b_jXYjk2X7EZTZPk5Bet1uA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/6] virtio-gpu: move virtio_gpu_gl_block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>

On Fri, May 5, 2017 at 2:49 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

> Move to virtio-gpu-3d.c where all the other virgl code lives too.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>

 Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  include/hw/virtio/virtio-gpu.h |  1 +
>  hw/display/virtio-gpu-3d.c     | 16 ++++++++++++++++
>  hw/display/virtio-gpu.c        | 18 ++----------------
>  3 files changed, 19 insertions(+), 16 deletions(-)
>
> diff --git a/include/hw/virtio/virtio-gpu.h
> b/include/hw/virtio/virtio-gpu.h
> index f3ffdceca4..83f474ffc3 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -169,6 +169,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>                                    struct virtio_gpu_ctrl_command *cmd);
>  void virtio_gpu_virgl_fence_poll(VirtIOGPU *g);
>  void virtio_gpu_virgl_reset(VirtIOGPU *g);
> +void virtio_gpu_gl_block(void *opaque, bool block);
>  int virtio_gpu_virgl_init(VirtIOGPU *g);
>
>  #endif
> diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
> index f49b7fe8cd..8c106a662d 100644
> --- a/hw/display/virtio-gpu-3d.c
> +++ b/hw/display/virtio-gpu-3d.c
> @@ -600,6 +600,22 @@ void virtio_gpu_virgl_reset(VirtIOGPU *g)
>      }
>  }
>
> +void virtio_gpu_gl_block(void *opaque, bool block)
> +{
> +    VirtIOGPU *g =3D opaque;
> +
> +    if (block) {
> +        g->renderer_blocked++;
> +    } else {
> +        g->renderer_blocked--;
> +    }
> +    assert(g->renderer_blocked >=3D 0);
> +
> +    if (g->renderer_blocked =3D=3D 0) {
> +        virtio_gpu_process_cmdq(g);
> +    }
> +}
> +
>  int virtio_gpu_virgl_init(VirtIOGPU *g)
>  {
>      int ret;
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index e1056f34df..cfb5dfa336 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -929,28 +929,14 @@ static int virtio_gpu_ui_info(void *opaque, uint32_=
t
> idx, QemuUIInfo *info)
>      return 0;
>  }
>
> -static void virtio_gpu_gl_block(void *opaque, bool block)
> -{
> -    VirtIOGPU *g =3D opaque;
> -
> -    if (block) {
> -        g->renderer_blocked++;
> -    } else {
> -        g->renderer_blocked--;
> -    }
> -    assert(g->renderer_blocked >=3D 0);
> -
> -    if (g->renderer_blocked =3D=3D 0) {
> -        virtio_gpu_process_cmdq(g);
> -    }
> -}
> -
>  const GraphicHwOps virtio_gpu_ops =3D {
>      .invalidate =3D virtio_gpu_invalidate_display,
>      .gfx_update =3D virtio_gpu_update_display,
>      .text_update =3D virtio_gpu_text_update,
>      .ui_info =3D virtio_gpu_ui_info,
> +#ifdef CONFIG_VIRGL
>      .gl_block =3D virtio_gpu_gl_block,
> +#endif
>  };
>
>  static const VMStateDescription vmstate_virtio_gpu_scanout =3D {
> --
> 2.9.3
>
>
> --
Marc-Andr=C3=A9 Lureau
