Received: from eggs.gnu.org ([209.51.188.92]:60063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hJvmS-0007ne-UH
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 04:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hJvZM-0007gQ-83
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 03:46:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hJvZM-0007fC-1r
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 03:46:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7DA1CC7A16
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 07:46:50 +0000 (UTC)
Date: Fri, 26 Apr 2019 09:46:45 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190426074645.zgm2lxfpfwdo2nni@sirius.home.kraxel.org>
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
	<20190423132004.13725-9-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423132004.13725-9-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 08/11] contrib: add vhost-user-gpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

  Hi,

> +#ifdef CONFIG_LIBDRM_INTEL
> +static bool
> +intel_alloc_bo(struct drm_buffer *buf)
> +{
> +    uint32_t tiling = I915_TILING_NONE;
> +
> +    buf->intel_bo = drm_intel_bo_alloc_tiled(buf->dev->bufmgr, "vhost-user-gpu",
> +                                             buf->width, buf->height,
> +                                             (buf->bpp / 8), &tiling,
> +                                             &buf->stride, 0);

Why do you go for intel specific code here?

Can't you do the same with gbm_bo_create() or
gbm_bo_create_with_modifiers() ?

> +static bool
> +intel_map_bo(struct drm_buffer *buf)
> +{
> +    if (drm_intel_gem_bo_map_gtt(buf->intel_bo) != 0) {
> +        return false;
> +    }

gbm_bo_map()

> +static bool
> +intel_export_bo_to_prime(struct drm_buffer *buffer, int *fd)
> +{
> +    if (drm_intel_bo_gem_export_to_prime(buffer->intel_bo, fd) < 0) {
> +        return false;
> +    }

gbm_bo_get_fd()

> +get_pixman_format(uint32_t virtio_gpu_format)
> +{
> +    switch (virtio_gpu_format) {
> +#ifdef HOST_WORDS_BIGENDIAN
> +    case VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM:
> +        return PIXMAN_b8g8r8x8;

Move that to a header for sharing?  Simliar to the bswap helpers?

> +static void
> +virgl_cmd_create_resource_3d(VuGpu *g,
> +                             struct virtio_gpu_ctrl_command *cmd)
> +{
> +    struct virtio_gpu_resource_create_3d c3d;
> +    struct virgl_renderer_resource_create_args args;
> +
> +    VUGPU_FILL_CMD(c3d);
> +
> +    args.handle = c3d.resource_id;
> +    args.target = c3d.target;
> +    args.format = c3d.format;
> +    args.bind = c3d.bind;
> +    args.width = c3d.width;
> +    args.height = c3d.height;
> +    args.depth = c3d.depth;
> +    args.array_size = c3d.array_size;
> +    args.last_level = c3d.last_level;
> +    args.nr_samples = c3d.nr_samples;
> +    args.flags = c3d.flags;
> +    virgl_renderer_resource_create(&args, NULL, 0);
> +}

The virtio_gpu_resource_create_3d -> virgl_renderer_resource_create_args
mapping looks like an opportunity for code sharing too.

Hmm, but virgl_renderer_resource_create seems to be the only call with
an args struct, so maybe not worth the effort for this single case.

cheers,
  Gerd
