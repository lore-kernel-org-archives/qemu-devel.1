Received: from eggs.gnu.org ([2001:4830:134:3::10]:49552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fmin2-0007R4-Fb
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 12:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fmin1-0000uO-Au
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 12:55:28 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:43954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fmin1-0000uI-4H
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 12:55:27 -0400
Received: by mail-oi0-x242.google.com with SMTP id b15-v6so23396188oib.10
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 09:55:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180803153235.4134-1-marcandre.lureau@redhat.com>
References: <20180803153235.4134-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Aug 2018 17:55:05 +0100
Message-ID: <CAFEAcA-aiGDS22d5shhqRuAAK36nVzgFtpcHt_X-S4Bazse9Zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu: fix crashes upon warm reboot
 with vga mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

I think this is now our last bug fix needed for rc4, which ideally
I'd like to tag tomorrow (Tuesday). Is there anybody familiar with
virtio-gpu who could review it?

thanks
-- PMM

On 3 August 2018 at 16:32, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> With vga=3D775 on the Linux command line a first boot of the VM running
> Linux works fine. After a warm reboot it crashes during Linux boot.
>
> Before that, valgrind points out bad memory write to console
> surface. The VGA code is not aware that virtio-gpu got a message
> surface scanout when the display is disabled. Let's reset VGA graphic
> mode when it is the case, so that a new display surface is created
> when doing further VGA operations.
>
> https://bugs.launchpad.net/qemu/+bug/1784900/
>
> Reported-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/virtio/virtio-gpu.h |  1 +
>  hw/display/virtio-gpu.c        |  5 +++++
>  hw/display/virtio-vga.c        | 11 +++++++++++
>  3 files changed, 17 insertions(+)
>
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index 9780f755ef..d0321672f4 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -125,6 +125,7 @@ typedef struct VirtIOGPU {
>          uint32_t bytes_3d;
>      } stats;
>
> +    void (*disable_scanout)(struct VirtIOGPU *g, int scanout_id);
>      Error *migration_blocker;
>  } VirtIOGPU;
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index ec366f4c35..3ddd29c0de 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -421,6 +421,11 @@ static void virtio_gpu_disable_scanout(VirtIOGPU *g,=
 int scanout_id)
>                                           scanout->height ?: 480,
>                                           "Guest disabled display.");
>      }
> +
> +    if (g->disable_scanout) {
> +        g->disable_scanout(g, scanout_id);
> +    }
> +
>      dpy_gfx_replace_surface(scanout->con, ds);
>      scanout->resource_id =3D 0;
>      scanout->ds =3D NULL;
> diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
> index 2b36f2899a..672b7f9ce2 100644
> --- a/hw/display/virtio-vga.c
> +++ b/hw/display/virtio-vga.c
> @@ -75,6 +75,16 @@ static void virtio_vga_gl_block(void *opaque, bool blo=
ck)
>      }
>  }
>
> +static void virtio_vga_disable_scanout(VirtIOGPU *g, int scanout_id)
> +{
> +    VirtIOVGA *vvga =3D container_of(g, VirtIOVGA, vdev);
> +
> +    if (scanout_id =3D=3D 0) {
> +        /* reset surface if needed */
> +        vvga->vga.graphic_mode =3D -1;
> +    }
> +}
> +
>  static const GraphicHwOps virtio_vga_ops =3D {
>      .invalidate =3D virtio_vga_invalidate_display,
>      .gfx_update =3D virtio_vga_update_display,
> @@ -156,6 +166,7 @@ static void virtio_vga_realize(VirtIOPCIProxy *vpci_d=
ev, Error **errp)
>                                   vvga->vga_mrs, true);
>
>      vga->con =3D g->scanout[0].con;
> +    g->disable_scanout =3D virtio_vga_disable_scanout;
>      graphic_console_set_hwops(vga->con, &virtio_vga_ops, vvga);
>
>      for (i =3D 0; i < g->conf.max_outputs; i++) {
> --
> 2.18.0.547.g1d89318c48
>
>
