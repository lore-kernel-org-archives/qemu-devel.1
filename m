Received: from eggs.gnu.org ([2001:4830:134:3::10]:38856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8Pa5-0007gL-Hl
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8Pa4-0004cw-OC
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:51:45 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:36895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g8Pa4-0004c8-DE
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:51:44 -0400
Received: by mail-oi1-x22a.google.com with SMTP id e17-v6so10280616oib.4
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 05:51:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180927071247.25725-7-kraxel@redhat.com>
References: <20180927071247.25725-1-kraxel@redhat.com>
	<20180927071247.25725-7-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Oct 2018 13:51:22 +0100
Message-ID: <CAFEAcA8+-JRcj-BDfzuUUUq=igov95j1C8ADitvagBRKi51+KQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 6/7] qxl: use guest_monitor_config for local
 renderer.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On 27 September 2018 at 08:12, Gerd Hoffmann <kraxel@redhat.com> wrote:
> When processing monitor config from guest store head0 width and height
> for single-head configurations.  Use these when creating the
> DisplaySurface in the local renderer.
>
> This fixes a rendering issue with wayland.  Wayland rounds up the
> framebuffer width and height to a multiple of 64, so with odd
> resolutions (800x600 for example) the framebuffer is larger than the
> actual screen.  The monitor config has the actual screen size though.
>
> This fixes guest display for anything using the local renderer
> (non-spice UI, screendump monitor command).
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Message-id: 20180919103057.9666-1-kraxel@redhat.com

> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index 8e9135d9c6..747986478f 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -259,6 +259,8 @@ static void qxl_spice_destroy_surfaces(PCIQXLDevice *=
qxl, qxl_async_io async)
>
>  static void qxl_spice_monitors_config_async(PCIQXLDevice *qxl, int repla=
y)
>  {
> +    QXLMonitorsConfig *cfg;
> +
>      trace_qxl_spice_monitors_config(qxl->id);
>      if (replay) {
>          /*
> @@ -286,6 +288,16 @@ static void qxl_spice_monitors_config_async(PCIQXLDe=
vice *qxl, int replay)
>                  (uintptr_t)qxl_cookie_new(QXL_COOKIE_TYPE_IO,
>                                            QXL_IO_MONITORS_CONFIG_ASYNC))=
;
>      }
> +
> +    cfg =3D qxl_phys2virt(qxl, qxl->guest_monitors_config, MEMSLOT_GROUP=
_GUEST);
> +    if (cfg->count =3D=3D 1) {
> +        qxl->guest_primary.resized =3D 1;
> +        qxl->guest_head0_width  =3D cfg->heads[0].width;
> +        qxl->guest_head0_height =3D cfg->heads[0].height;
> +    } else {
> +        qxl->guest_head0_width  =3D 0;
> +        qxl->guest_head0_height =3D 0;
> +    }

Hi. Coverity points out (CID 1395986) that we fail to check
the return value from qxl_phys2virt() here. It can return NULL,
in which case we'll segfault trying to dereference it.

thanks
-- PMM
