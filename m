Received: from eggs.gnu.org ([209.51.188.92]:54263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gwrbP-0002ZF-9d
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:53:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gwrbO-0003U8-AK
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:53:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cfergeau@redhat.com>) id 1gwrbO-0003T9-0b
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:53:38 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E8C07309D284
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 16:53:34 +0000 (UTC)
Date: Thu, 21 Feb 2019 17:53:26 +0100
From: Christophe Fergeau <cfergeau@redhat.com>
Message-ID: <20190221165326.GH31918@natto.ory.fergeau.eu>
References: <20190221114330.17968-1-marcandre.lureau@redhat.com>
	<20190221114330.17968-4-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TKYYegg/GYAC5JIZ"
Content-Disposition: inline
In-Reply-To: <20190221114330.17968-4-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] virtio-gpu: block both 2d and 3d
 rendering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com


--TKYYegg/GYAC5JIZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I came up with the same fix while looking at that bug before seeing
Marc-Andr=E9's patch.
Then I tested Marc-Andr=E9's patch.
So for this patch,

Reviewed-by: Christophe Fergeau <cfergeau@redhat.com>
Tested-by: Christophe Fergeau <cfergeau@redhat.com>

On Thu, Feb 21, 2019 at 12:43:29PM +0100, Marc-Andr=E9 Lureau wrote:
> Now that 2d commands are translated to 3d rendering, qemu must stop
> sending 3d updates (from 2d) to Spice as well.
>=20
> Fixes:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1674324
>=20
> Cc: cfergeau@redhat.com
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/virtio/virtio-gpu.h |  1 -
>  hw/display/virtio-gpu-3d.c     | 21 ---------------------
>  hw/display/virtio-gpu.c        | 27 ++++++++++++++++++++++-----
>  3 files changed, 22 insertions(+), 27 deletions(-)
>=20
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index a1cecd1df8..f8cd8ee96f 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -169,7 +169,6 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>                                    struct virtio_gpu_ctrl_command *cmd);
>  void virtio_gpu_virgl_fence_poll(VirtIOGPU *g);
>  void virtio_gpu_virgl_reset(VirtIOGPU *g);
> -void virtio_gpu_gl_block(void *opaque, bool block);
>  int virtio_gpu_virgl_init(VirtIOGPU *g);
>  int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g);
>  #endif
> diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
> index bc6e99c943..cb83479ed2 100644
> --- a/hw/display/virtio-gpu-3d.c
> +++ b/hw/display/virtio-gpu-3d.c
> @@ -404,11 +404,6 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>  {
>      VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
> =20
> -    cmd->waiting =3D g->renderer_blocked;
> -    if (cmd->waiting) {
> -        return;
> -    }
> -
>      virgl_renderer_force_ctx_0();
>      switch (cmd->cmd_hdr.type) {
>      case VIRTIO_GPU_CMD_CTX_CREATE:
> @@ -604,22 +599,6 @@ void virtio_gpu_virgl_reset(VirtIOGPU *g)
>      }
>  }
> =20
> -void virtio_gpu_gl_block(void *opaque, bool block)
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
>  int virtio_gpu_virgl_init(VirtIOGPU *g)
>  {
>      int ret;
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 8f4351420b..7ada4b83ac 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -889,12 +889,15 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
>      while (!QTAILQ_EMPTY(&g->cmdq)) {
>          cmd =3D QTAILQ_FIRST(&g->cmdq);
> =20
> -        /* process command */
> -        VIRGL(g, virtio_gpu_virgl_process_cmd, virtio_gpu_simple_process=
_cmd,
> -              g, cmd);
> +        cmd->waiting =3D g->renderer_blocked;
>          if (cmd->waiting) {
>              break;
>          }
> +
> +        /* process command */
> +        VIRGL(g, virtio_gpu_virgl_process_cmd, virtio_gpu_simple_process=
_cmd,
> +              g, cmd);
> +
>          QTAILQ_REMOVE(&g->cmdq, cmd, next);
>          if (virtio_gpu_stats_enabled(g->conf)) {
>              g->stats.requests++;
> @@ -1030,14 +1033,28 @@ static int virtio_gpu_ui_info(void *opaque, uint3=
2_t idx, QemuUIInfo *info)
>      return 0;
>  }
> =20
> +static void virtio_gpu_gl_block(void *opaque, bool block)
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
>  const GraphicHwOps virtio_gpu_ops =3D {
>      .invalidate =3D virtio_gpu_invalidate_display,
>      .gfx_update =3D virtio_gpu_update_display,
>      .text_update =3D virtio_gpu_text_update,
>      .ui_info =3D virtio_gpu_ui_info,
> -#ifdef CONFIG_VIRGL
>      .gl_block =3D virtio_gpu_gl_block,
> -#endif
>  };
> =20
>  static const VMStateDescription vmstate_virtio_gpu_scanout =3D {
> --=20
> 2.21.0.rc1
>=20
>=20

--TKYYegg/GYAC5JIZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElKn3VmH3emFoZJsjqdjCFCmsbIIFAlxu14YACgkQqdjCFCms
bIJ1+w/9GvdbV6x6vLxUegnyB10LHTrDckeodZ9zO2uU+DP5YF1/2/EG5Qt/cL3O
NsZ5gviiuWe+WoPFhnCgYQVzCZ3xPi45xOI6+Z/qmY296sDEoZhFKuLaPDlzDgwL
Sv6yt3yDCKZW3rBRy01QZhnksZVwV3VHpy8T1D5THrEVngmAlksqw4jrfGwVG9YB
GdlX2RYoJHgYD14WtqzcEg6/aJiO5NgcNoehK/t3DaVtY3xFBhewu3ofKjZ3lY3V
pld7mBbiNDEN26jkDL6TJqHpgzNnfdXcoOtv3J/Ybym4FQtr4MmuOlWb5t0GrMI0
P+kL3nFkTtYW/0WLp+tR8PscgTRLBrPrRrerzeM3zQNl0PQJ1i200EcRwPfGYc/b
G3FBHzL47z2cbFF6auf+INiJAUfAL/aLOxmqUuQiAyRKd3CjOzkfeS1HjpU/4K/J
adtwijJiHcbYSobbk9r2aAKQa0mXv5NHtiEazp8VX+xF4WrFWG3EcCmfjPPprECM
Xbu5gPNTkeiwUbEsln7EOpO2B0SqQ/POvS4xetzVW6knUHdGlIOp16R39BEl0Jsc
sqSgG0nOJdaXZwz23GCSG8+gXHH2YhaCY4BSF1g1oFdD/+nHuydHmJMVx1IWRi8e
Q9wWOBgVYBOlOO3FUZudP0OnZcXLm3P8+1fxDy6eWD5rHZ5wgvo=
=Zo8j
-----END PGP SIGNATURE-----

--TKYYegg/GYAC5JIZ--
