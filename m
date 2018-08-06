Received: from eggs.gnu.org ([2001:4830:134:3::10]:44312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fmmrj-0001w1-Io
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 17:16:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fmmre-0006yJ-LZ
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 17:16:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58762 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fmmre-0006xp-Ee
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 17:16:30 -0400
Date: Tue, 7 Aug 2018 00:16:23 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180807001146-mutt-send-email-mst@kernel.org>
References: <20180803153235.4134-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180803153235.4134-1-marcandre.lureau@redhat.com>
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
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, kraxel@redhat.com, stefanb@linux.vnet.ibm.com

On Fri, Aug 03, 2018 at 05:32:35PM +0200, Marc-Andr=E9 Lureau wrote:
> With vga=3D775 on the Linux command line a first boot of the VM running
> Linux works fine. After a warm reboot it crashes during Linux boot.
>=20
> Before that, valgrind points out bad memory write to console
> surface. The VGA code is not aware that virtio-gpu got a message
> surface scanout when the display is disabled. Let's reset VGA graphic
> mode when it is the case, so that a new display surface is created
> when doing further VGA operations.
>=20
> https://bugs.launchpad.net/qemu/+bug/1784900/
>=20
> Reported-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/virtio/virtio-gpu.h |  1 +
>  hw/display/virtio-gpu.c        |  5 +++++
>  hw/display/virtio-vga.c        | 11 +++++++++++
>  3 files changed, 17 insertions(+)
>=20
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-=
gpu.h
> index 9780f755ef..d0321672f4 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -125,6 +125,7 @@ typedef struct VirtIOGPU {
>          uint32_t bytes_3d;
>      } stats;
> =20
> +    void (*disable_scanout)(struct VirtIOGPU *g, int scanout_id);
>      Error *migration_blocker;
>  } VirtIOGPU;
> =20
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index ec366f4c35..3ddd29c0de 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -421,6 +421,11 @@ static void virtio_gpu_disable_scanout(VirtIOGPU *=
g, int scanout_id)
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
> @@ -75,6 +75,16 @@ static void virtio_vga_gl_block(void *opaque, bool b=
lock)
>      }
>  }
> =20
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

Would it make sense to add
vga_disable_scanout() to hw/display/vga_int.h and
poke at graphic_mode there?

I'll leave the decision to you.

> @@ -156,6 +166,7 @@ static void virtio_vga_realize(VirtIOPCIProxy *vpci=
_dev, Error **errp)
>                                   vvga->vga_mrs, true);
> =20
>      vga->con =3D g->scanout[0].con;
> +    g->disable_scanout =3D virtio_vga_disable_scanout;
>      graphic_console_set_hwops(vga->con, &virtio_vga_ops, vvga);
> =20
>      for (i =3D 0; i < g->conf.max_outputs; i++) {

While I really know very little about vga, it seems
like that's the standard way to force full update so


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

--=20
MST
