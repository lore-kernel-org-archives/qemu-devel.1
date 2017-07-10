Received: from eggs.gnu.org ([2001:4830:134:3::10]:59547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dUUf1-0006PC-W9
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dUUey-000225-0u
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:07:19 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:32962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dUUex-0001wm-OQ
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:07:15 -0400
Received: by mail-lf0-f65.google.com with SMTP id t72so9424877lff.0
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 02:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <20170710070432.856-1-kraxel@redhat.com>
In-Reply-To: <20170710070432.856-1-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 10 Jul 2017 09:05:41 +0000
Message-ID: <CAJ+F1C+LVOXDevrxXLvg0MPeUrZZpS1UF5k0MtF7gvc1gRbPNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu: skip update cursor in
 post_load if we don't have one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: wanghaibin.wang@huawei.com, "Michael S. Tsirkin" <mst@redhat.com>

On Mon, Jul 10, 2017 at 9:06 AM Gerd Hoffmann <kraxel@redhat.com> wrote:

> If the cursor resource id isn't set the guest didn't define a cursor.
> Skip the cursor update in post_load in that that case.
>

update_cursor() deals with resource_id =3D=3D 0 already, but it also update=
 the
cursor position. What's the issue calling update_cursor() here?


> Reported-by: wanghaibin <wanghaibin.wang@huawei.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/virtio-gpu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 58dc0b2737..eef11083d7 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1092,7 +1092,9 @@ static int virtio_gpu_load(QEMUFile *f, void
> *opaque, size_t size,
>
>          dpy_gfx_replace_surface(scanout->con, scanout->ds);
>          dpy_gfx_update(scanout->con, 0, 0, scanout->width,
> scanout->height);
> -        update_cursor(g, &scanout->cursor);
> +        if (scanout->cursor.resource_id) {
> +            update_cursor(g, &scanout->cursor);
> +        }
>          res->scanout_bitmask |=3D (1 << i);
>      }
>
> --
> 2.9.3
>
>
> --
Marc-Andr=C3=A9 Lureau
