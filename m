Received: from eggs.gnu.org ([2001:4830:134:3::10]:37548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d6biF-0000xH-DX
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d6biC-00074A-8i
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:47:55 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d6biC-000731-2u
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:47:52 -0400
Received: by mail-qt0-x241.google.com with SMTP id j13so413449qta.3
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 04:47:50 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170505104101.30589-1-kraxel@redhat.com>
	<20170505104101.30589-2-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5f4bacb7-af8d-90f4-679b-5846173fc4e6@amsat.org>
Date: Fri, 5 May 2017 08:47:46 -0300
MIME-Version: 1.0
In-Reply-To: <20170505104101.30589-2-kraxel@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
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

On 05/05/2017 07:40 AM, Gerd Hoffmann wrote:
> Move to virtio-gpu-3d.c where all the other virgl code lives too.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/hw/virtio/virtio-gpu.h |  1 +
>  hw/display/virtio-gpu-3d.c     | 16 ++++++++++++++++
>  hw/display/virtio-gpu.c        | 18 ++----------------
>  3 files changed, 19 insertions(+), 16 deletions(-)
>
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
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
> +    VirtIOGPU *g = opaque;
> +
> +    if (block) {
> +        g->renderer_blocked++;
> +    } else {
> +        g->renderer_blocked--;
> +    }
> +    assert(g->renderer_blocked >= 0);
> +
> +    if (g->renderer_blocked == 0) {
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
> @@ -929,28 +929,14 @@ static int virtio_gpu_ui_info(void *opaque, uint32_t idx, QemuUIInfo *info)
>      return 0;
>  }
>
> -static void virtio_gpu_gl_block(void *opaque, bool block)
> -{
> -    VirtIOGPU *g = opaque;
> -
> -    if (block) {
> -        g->renderer_blocked++;
> -    } else {
> -        g->renderer_blocked--;
> -    }
> -    assert(g->renderer_blocked >= 0);
> -
> -    if (g->renderer_blocked == 0) {
> -        virtio_gpu_process_cmdq(g);
> -    }
> -}
> -
>  const GraphicHwOps virtio_gpu_ops = {
>      .invalidate = virtio_gpu_invalidate_display,
>      .gfx_update = virtio_gpu_update_display,
>      .text_update = virtio_gpu_text_update,
>      .ui_info = virtio_gpu_ui_info,
> +#ifdef CONFIG_VIRGL
>      .gl_block = virtio_gpu_gl_block,
> +#endif
>  };
>
>  static const VMStateDescription vmstate_virtio_gpu_scanout = {
>
