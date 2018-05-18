Received: from eggs.gnu.org ([2001:4830:134:3::10]:60044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fJh1M-00027C-EF
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fJh1L-0007pu-FZ
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:10:16 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:52469)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fJh1L-0007oO-9T
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:10:15 -0400
Received: by mail-wm0-x242.google.com with SMTP id w194-v6so14619840wmf.2
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 08:10:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180517092513.735-4-kraxel@redhat.com>
References: <20180517092513.735-1-kraxel@redhat.com>
	<20180517092513.735-4-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 18 May 2018 17:10:13 +0200
Message-ID: <CAJ+F1CJVh_n4ryqWEDuj011TSDTxkCurqkxin0LDw0XmNCGFYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] bochs-display: add dirty tracking
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Thu, May 17, 2018 at 11:25 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/display/bochs-display.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
> index beeda58475..9ea6f798f4 100644
> --- a/hw/display/bochs-display.c
> +++ b/hw/display/bochs-display.c
> @@ -192,9 +192,13 @@ nofb:
>  static void bochs_display_update(void *opaque)
>  {
>      BochsDisplayState *s =3D opaque;
> +    DirtyBitmapSnapshot *snap =3D NULL;
> +    bool full_update =3D false;
>      BochsDisplayMode mode;
>      DisplaySurface *ds;
>      uint8_t *ptr;
> +    bool dirty;
> +    int y, ys;
>
>      bochs_display_get_mode(s, &mode);
>      if (!mode.size) {
> @@ -212,9 +216,34 @@ static void bochs_display_update(void *opaque)
>                                               mode.stride,
>                                               ptr + mode.offset);
>          dpy_gfx_replace_surface(s->con, ds);
> +        full_update =3D true;
>      }
>
> -    dpy_gfx_update_full(s->con);
> +    if (full_update) {
> +        dpy_gfx_update_full(s->con);
> +    } else {
> +        snap =3D memory_region_snapshot_and_clear_dirty(&s->vram,
> +                                                      mode.offset, mode.=
size,
> +                                                      DIRTY_MEMORY_VGA);
> +        ys =3D -1;
> +        for (y =3D 0; y < mode.height; y++) {
> +            dirty =3D memory_region_snapshot_get_dirty(&s->vram, snap,
> +                                                     mode.offset + mode.=
stride * y,
> +                                                     mode.stride);
> +            if (dirty && ys < 0) {
> +                ys =3D y;
> +            }
> +            if (!dirty && ys >=3D 0) {
> +                dpy_gfx_update(s->con, 0, ys,
> +                               mode.width, y - ys);
> +                ys =3D -1;
> +            }
> +        }
> +        if (ys >=3D 0) {
> +            dpy_gfx_update(s->con, 0, ys,
> +                           mode.width, y - ys);
> +        }
> +    }
>  }
>
>  static const GraphicHwOps bochs_display_gfx_ops =3D {
> @@ -250,6 +279,8 @@ static void bochs_display_realize(PCIDevice *dev, Err=
or **errp)
>      pci_set_byte(&s->pci.config[PCI_REVISION_ID], 2);
>      pci_register_bar(&s->pci, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &s->vram=
);
>      pci_register_bar(&s->pci, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mmio=
);
> +
> +    memory_region_set_log(&s->vram, true, DIRTY_MEMORY_VGA);
>  }
>
>  static bool bochs_display_get_big_endian_fb(Object *obj, Error **errp)
> --
> 2.9.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
