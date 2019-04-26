Received: from eggs.gnu.org ([209.51.188.92]:58185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hK1BP-00055N-34
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 09:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hK1BO-0000Xw-1P
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 09:46:31 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hK1BN-0000Xj-RR
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 09:46:29 -0400
Received: by mail-wr1-x442.google.com with SMTP id b1so4575153wru.3
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 06:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
	<20190423132004.13725-9-marcandre.lureau@redhat.com>
	<20190426074645.zgm2lxfpfwdo2nni@sirius.home.kraxel.org>
In-Reply-To: <20190426074645.zgm2lxfpfwdo2nni@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 26 Apr 2019 15:46:16 +0200
Message-ID: <CAJ+F1CKR1z4eB+Pwm5jZ3GSCpqG0N3X-gRqCP_TpqXxfUymPgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 08/11] contrib: add vhost-user-gpu
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

On Fri, Apr 26, 2019 at 10:03 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > +#ifdef CONFIG_LIBDRM_INTEL
> > +static bool
> > +intel_alloc_bo(struct drm_buffer *buf)
> > +{
> > +    uint32_t tiling =3D I915_TILING_NONE;
> > +
> > +    buf->intel_bo =3D drm_intel_bo_alloc_tiled(buf->dev->bufmgr, "vhos=
t-user-gpu",
> > +                                             buf->width, buf->height,
> > +                                             (buf->bpp / 8), &tiling,
> > +                                             &buf->stride, 0);
>
> Why do you go for intel specific code here?
>

No idea, most likely some functions were lacking when I looked at it.
GBM is fine now.

> Can't you do the same with gbm_bo_create() or
> gbm_bo_create_with_modifiers() ?

It's not clear to me how to properly use
gbm_bo_create_with_modifiers(). I went with gbm_bo_create() for now,
it "works for me".

>
> > +static bool
> > +intel_map_bo(struct drm_buffer *buf)
> > +{
> > +    if (drm_intel_gem_bo_map_gtt(buf->intel_bo) !=3D 0) {
> > +        return false;
> > +    }
>
> gbm_bo_map()
>
> > +static bool
> > +intel_export_bo_to_prime(struct drm_buffer *buffer, int *fd)
> > +{
> > +    if (drm_intel_bo_gem_export_to_prime(buffer->intel_bo, fd) < 0) {
> > +        return false;
> > +    }
>
> gbm_bo_get_fd()
>
> > +get_pixman_format(uint32_t virtio_gpu_format)
> > +{
> > +    switch (virtio_gpu_format) {
> > +#ifdef HOST_WORDS_BIGENDIAN
> > +    case VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM:
> > +        return PIXMAN_b8g8r8x8;
>
> Move that to a header for sharing?  Simliar to the bswap helpers?

ack

>
> > +static void
> > +virgl_cmd_create_resource_3d(VuGpu *g,
> > +                             struct virtio_gpu_ctrl_command *cmd)
> > +{
> > +    struct virtio_gpu_resource_create_3d c3d;
> > +    struct virgl_renderer_resource_create_args args;
> > +
> > +    VUGPU_FILL_CMD(c3d);
> > +
> > +    args.handle =3D c3d.resource_id;
> > +    args.target =3D c3d.target;
> > +    args.format =3D c3d.format;
> > +    args.bind =3D c3d.bind;
> > +    args.width =3D c3d.width;
> > +    args.height =3D c3d.height;
> > +    args.depth =3D c3d.depth;
> > +    args.array_size =3D c3d.array_size;
> > +    args.last_level =3D c3d.last_level;
> > +    args.nr_samples =3D c3d.nr_samples;
> > +    args.flags =3D c3d.flags;
> > +    virgl_renderer_resource_create(&args, NULL, 0);
> > +}
>
> The virtio_gpu_resource_create_3d -> virgl_renderer_resource_create_args
> mapping looks like an opportunity for code sharing too.
>
> Hmm, but virgl_renderer_resource_create seems to be the only call with
> an args struct, so maybe not worth the effort for this single case.

yeah, I will not bother for now

thanks!

--=20
Marc-Andr=C3=A9 Lureau
