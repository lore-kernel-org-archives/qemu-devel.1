Received: from eggs.gnu.org ([2001:4830:134:3::10]:33302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cxVY3-0005lW-3R
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:23:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cxVY1-0004fQ-Fm
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:23:47 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:35835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cxVY1-0004df-3C
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:23:45 -0400
Received: by mail-lf0-x241.google.com with SMTP id i3so4236129lfh.2
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 02:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20170410065837.31847-1-kraxel@redhat.com>
In-Reply-To: <20170410065837.31847-1-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 10 Apr 2017 09:23:31 +0000
Message-ID: <CAJ+F1C+G6VWxpPOHrus6jogHqWAE1rQ=6YDkZkoyQhD7KVyxiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qxl: add migration blocker to avoid
 pre-save assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: 1635339@bugs.launchpad.net

Hi

On Mon, Apr 10, 2017 at 8:58 AM Gerd Hoffmann <kraxel@redhat.com> wrote:

> Cc: 1635339@bugs.launchpad.net
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/qxl.h |  1 +
>  hw/display/qxl.c | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/hw/display/qxl.h b/hw/display/qxl.h
> index d2d49dd..77e5a36 100644
> --- a/hw/display/qxl.h
> +++ b/hw/display/qxl.h
> @@ -40,6 +40,7 @@ typedef struct PCIQXLDevice {
>      uint32_t           cmdlog;
>
>      uint32_t           guest_bug;
> +    Error              *migration_blocker;
>
>      enum qxl_mode      mode;
>      uint32_t           cmdflags;
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index c31b293..74ebeb9 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -26,6 +26,7 @@
>  #include "qemu/queue.h"
>  #include "qemu/atomic.h"
>  #include "sysemu/sysemu.h"
> +#include "migration/migration.h"
>  #include "trace.h"
>
>  #include "qxl.h"
> @@ -639,6 +640,27 @@ static int interface_get_command(QXLInstance *sin,
> struct QXLCommandExt *ext)
>          qxl->guest_primary.commands++;
>          qxl_track_command(qxl, ext);
>          qxl_log_command(qxl, "cmd", ext);
> +        {
> +            /*
> +             * Windows 8 drivers place qxl commands in the vram
>
+             * (instead of the ram) bar.  We can't live migrate such a
> +             * guest, so add a migration blocker in case we detect
> +             * this, to avoid triggering the assert in pre_save().
> +             *
> +             *
> https://cgit.freedesktop.org/spice/win32/qxl-wddm-dod/commit/?id=3Df6e099=
db39e7d0787f294d5fd0dce328b5210faa
> +             */
> +            void *msg =3D qxl_phys2virt(qxl, ext->cmd.data, ext->group_i=
d);
> +            if (msg !=3D NULL && (
> +                    msg < (void *)qxl->vga.vram_ptr ||
> +                    msg > ((void *)qxl->vga.vram_ptr +
> qxl->vga.vram_size))) {
> +                if (!qxl->migration_blocker) {
> +                    Error *local_err =3D NULL;
> +                    error_setg(&qxl->migration_blocker,
> +                               "qxl: guest bug: command not in ram bar")=
;
> +                    migrate_add_blocker(qxl->migration_blocker,
> &local_err);
> +                }
>

Should the blocker be removed on reset?

Looks and works ok otherwise


> +            }
> +        }
>          trace_qxl_ring_command_get(qxl->id,
> qxl_mode_to_string(qxl->mode));
>          return true;
>      default:
> --
> 2.9.3
>
> --
Marc-Andr=C3=A9 Lureau
