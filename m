Received: from eggs.gnu.org ([2001:4830:134:3::10]:58096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1etB87-0004d2-LE
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1etB86-0004HM-V1
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:51:39 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:46630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1etB86-0004Gk-OS
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:51:38 -0500
Received: by mail-wr0-x244.google.com with SMTP id m12so20593691wrm.13
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 03:51:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180306083832.8144-3-kraxel@redhat.com>
References: <20180306083832.8144-1-kraxel@redhat.com>
	<20180306083832.8144-3-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 6 Mar 2018 12:51:36 +0100
Message-ID: <CAJ+F1CLYj9h7hR9phL5O4CTLrSkwkRKLz3mQqSv7u8Y7Sqvt4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/3] spice: add scanout_dmabuf support
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

On Tue, Mar 6, 2018 at 9:38 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Add support for scanout dmabufs.  Just
> pass them through to spice-server.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/spice-display.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index f3ae6beb3d..a494db1196 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -936,6 +936,20 @@ static void qemu_spice_gl_scanout_texture(DisplayCha=
ngeListener *dcl,
>      ssd->have_scanout =3D true;
>  }
>
> +static void qemu_spice_gl_scanout_dmabuf(DisplayChangeListener *dcl,
> +                                         QemuDmaBuf *dmabuf)
> +{
> +    SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, dc=
l);
> +
> +    /* note: spice server will close the fd, so hand over a dup */
> +    spice_qxl_gl_scanout(&ssd->qxl, dup(dmabuf->fd),
> +                         dmabuf->width, dmabuf->height,
> +                         dmabuf->stride, dmabuf->fourcc, false);
> +    qemu_spice_gl_monitor_config(ssd, 0, 0, dmabuf->width, dmabuf->heigh=
t);
> +    ssd->have_surface =3D false;
> +    ssd->have_scanout =3D true;
> +}
> +
>  static void qemu_spice_gl_update(DisplayChangeListener *dcl,
>                                   uint32_t x, uint32_t y, uint32_t w, uin=
t32_t h)
>  {
> @@ -969,6 +983,7 @@ static const DisplayChangeListenerOps display_listene=
r_gl_ops =3D {
>
>      .dpy_gl_scanout_disable  =3D qemu_spice_gl_scanout_disable,
>      .dpy_gl_scanout_texture  =3D qemu_spice_gl_scanout_texture,
> +    .dpy_gl_scanout_dmabuf   =3D qemu_spice_gl_scanout_dmabuf,
>      .dpy_gl_update           =3D qemu_spice_gl_update,
>  };
>
> --
> 2.9.3
>
>

Looks good. Btw, how is multi-monitor designed? Is there going to be a
scanout/dmabuf per monitor when using vfio/mdev?

--=20
Marc-Andr=C3=A9 Lureau
