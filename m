Received: from eggs.gnu.org ([2001:4830:134:3::10]:49411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <airlied@gmail.com>) id 1eq5II-0005Bu-Ib
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 18:01:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <airlied@gmail.com>) id 1eq5IH-0008DC-Mb
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 18:01:22 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:36395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <airlied@gmail.com>) id 1eq5IH-00089K-Fz
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 18:01:21 -0500
Received: by mail-lf0-x244.google.com with SMTP id g72so132577lfg.3
	for <qemu-devel@nongnu.org>; Sun, 25 Feb 2018 15:01:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180223023814.24459-1-airlied@gmail.com>
References: <20180223023814.24459-1-airlied@gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 26 Feb 2018 09:01:19 +1000
Message-ID: <CAPM=9tzH8U2NGaX_LYaVc0uVmb45i=5Vzvs0mtfROub4LVR-sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu-3d: add support for second
 capability set (v4)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

Gerd,

This seems to have passed the bots, but realised I hadn't cc'ed you.

Please pick it up whenever you get a chance.

Dave.

On 23 February 2018 at 12:38, Dave Airlie <airlied@gmail.com> wrote:
> From: Dave Airlie <airlied@redhat.com>
>
> Due to a kernel bug we can never increase the size of capability
> set 1, so introduce a new capability set in parallel, old userspace
> will continue to use the old set, new userspace will start using
> the new one when it detects a fixed kernel.
>
> v2: don't use a define from virglrenderer, just probe it.
> v3: fix compilation when virglrenderer disabled
> v4: fix style warning, just use ?: op instead.
>
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> ---
>  hw/display/virtio-gpu-3d.c                  | 15 +++++++++++++++
>  hw/display/virtio-gpu.c                     |  7 ++++++-
>  include/hw/virtio/virtio-gpu.h              |  2 +-
>  include/standard-headers/linux/virtio_gpu.h |  1 +
>  4 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
> index 7db84efe89..3558f38fe8 100644
> --- a/hw/display/virtio-gpu-3d.c
> +++ b/hw/display/virtio-gpu-3d.c
> @@ -362,6 +362,11 @@ static void virgl_cmd_get_capset_info(VirtIOGPU *g,
>          virgl_renderer_get_cap_set(resp.capset_id,
>                                     &resp.capset_max_version,
>                                     &resp.capset_max_size);
> +    } else if (info.capset_index == 1) {
> +        resp.capset_id = VIRTIO_GPU_CAPSET_VIRGL2;
> +        virgl_renderer_get_cap_set(resp.capset_id,
> +                                   &resp.capset_max_version,
> +                                   &resp.capset_max_size);
>      } else {
>          resp.capset_max_version = 0;
>          resp.capset_max_size = 0;
> @@ -635,4 +640,14 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>      return 0;
>  }
>
> +int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
> +{
> +    uint32_t capset2_max_ver, capset2_max_size;
> +    virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VIRGL2,
> +                              &capset2_max_ver,
> +                              &capset2_max_size);
> +
> +    return capset2_max_ver ? 2 : 1;
> +}
> +
>  #endif /* CONFIG_VIRGL */
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 6658f6c6a6..2dd3c3481a 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1215,7 +1215,12 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>          /* use larger control queue in 3d mode */
>          g->ctrl_vq   = virtio_add_queue(vdev, 256, virtio_gpu_handle_ctrl_cb);
>          g->cursor_vq = virtio_add_queue(vdev, 16, virtio_gpu_handle_cursor_cb);
> -        g->virtio_config.num_capsets = 1;
> +
> +#if defined(CONFIG_VIRGL)
> +        g->virtio_config.num_capsets = virtio_gpu_virgl_get_num_capsets(g);
> +#else
> +        g->virtio_config.num_capsets = 0;
> +#endif
>      } else {
>          g->ctrl_vq   = virtio_add_queue(vdev, 64, virtio_gpu_handle_ctrl_cb);
>          g->cursor_vq = virtio_add_queue(vdev, 16, virtio_gpu_handle_cursor_cb);
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 83f474ffc3..22ac3c2d0e 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -171,5 +171,5 @@ void virtio_gpu_virgl_fence_poll(VirtIOGPU *g);
>  void virtio_gpu_virgl_reset(VirtIOGPU *g);
>  void virtio_gpu_gl_block(void *opaque, bool block);
>  int virtio_gpu_virgl_init(VirtIOGPU *g);
> -
> +int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g);
>  #endif
> diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
> index c1c8f0751d..52a830dcf8 100644
> --- a/include/standard-headers/linux/virtio_gpu.h
> +++ b/include/standard-headers/linux/virtio_gpu.h
> @@ -260,6 +260,7 @@ struct virtio_gpu_cmd_submit {
>  };
>
>  #define VIRTIO_GPU_CAPSET_VIRGL 1
> +#define VIRTIO_GPU_CAPSET_VIRGL2 2
>
>  /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
>  struct virtio_gpu_get_capset_info {
> --
> 2.14.3
>
>
