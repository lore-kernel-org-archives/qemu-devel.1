Received: from eggs.gnu.org ([2001:4830:134:3::10]:42222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dpbjI-0001PM-Vj
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dpbjH-00017r-W7
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:55:00 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:35607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dpbjH-000167-Qv
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:54:59 -0400
Received: by mail-oi0-x242.google.com with SMTP id n18so4845179oig.2
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 07:54:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170906142058.2460-1-kraxel@redhat.com>
References: <20170906142058.2460-1-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 6 Sep 2017 16:54:58 +0200
Message-ID: <CAJ+F1C+1GCBAvsEenHThCamGO7TKhjOdxd3PTPzAb-tNyTVmpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu: don't clear QemuUIInfo
 information on reset
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

On Wed, Sep 6, 2017 at 4:20 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Don't reset window layout information (passed via virtio_gpu_ui_info) on
> device reset, so the user interface window layout will be kept intact
> over reboots.  The head size and position was commented out already, so
> this patch just drops the dead code.  Additionally the enabled head mask
> must be kept so multihead setups work properly too.
>
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1460595
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/display/virtio-gpu.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index f0761cf18b..622ee300f9 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1195,17 +1195,6 @@ static void virtio_gpu_reset(VirtIODevice *vdev)
>          virtio_gpu_resource_destroy(g, res);
>      }
>      for (i =3D 0; i < g->conf.max_outputs; i++) {
> -#if 0
> -        g->req_state[i].x =3D 0;
> -        g->req_state[i].y =3D 0;
> -        if (i =3D=3D 0) {
> -            g->req_state[0].width =3D 1024;
> -            g->req_state[0].height =3D 768;
> -        } else {
> -            g->req_state[i].width =3D 0;
> -            g->req_state[i].height =3D 0;
> -        }
> -#endif
>          g->scanout[i].resource_id =3D 0;
>          g->scanout[i].width =3D 0;
>          g->scanout[i].height =3D 0;
> @@ -1213,7 +1202,6 @@ static void virtio_gpu_reset(VirtIODevice *vdev)
>          g->scanout[i].y =3D 0;
>          g->scanout[i].ds =3D NULL;
>      }
> -    g->enabled_output_bitmask =3D 1;
>
>  #ifdef CONFIG_VIRGL
>      if (g->use_virgl_renderer) {
> --
> 2.9.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
