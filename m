Received: from eggs.gnu.org ([2001:4830:134:3::10]:46619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f0O9C-0001cS-Py
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:10:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f0O99-0007Ra-JB
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:10:34 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1f0O99-0007QV-D3
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:10:31 -0400
Received: by mail-io0-f195.google.com with SMTP id 141so22339930iou.12
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 02:10:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180326063901.27425-4-peterx@redhat.com>
References: <20180326063901.27425-1-peterx@redhat.com>
	<20180326063901.27425-4-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 11:10:30 +0200
Message-ID: <CAMxuvawX2yzMpMYNsB6b-8NP6iXm-ugjE5TUgj5KkgiEEUApFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 3/8] monitor: new parameter "x-oob"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Hi

On Mon, Mar 26, 2018 at 8:38 AM, Peter Xu <peterx@redhat.com> wrote:
> Add new parameter to optionally enable Out-Of-Band for a QMP server.
>
> An example command line:
>
>   ./qemu-system-x86_64 -chardev stdio,id=3Dchar0 \
>                        -mon chardev=3Dchar0,mode=3Dcontrol,x-oob=3Don
>
> By default, Out-Of-Band is off.
>
> It is not allowed if either MUX or non-QMP is detected, since
> Out-Of-Band is currently only for QMP, and non-MUX chardev backends.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/monitor/monitor.h |  1 +
>  monitor.c                 | 22 ++++++++++++++++++++--
>  vl.c                      |  5 +++++
>  3 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index 0cb0538a31..d6ab70cae2 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -13,6 +13,7 @@ extern Monitor *cur_mon;
>  #define MONITOR_USE_READLINE  0x02
>  #define MONITOR_USE_CONTROL   0x04
>  #define MONITOR_USE_PRETTY    0x08
> +#define MONITOR_USE_OOB       0x10
>
>  bool monitor_cur_is_qmp(void);
>
> diff --git a/monitor.c b/monitor.c
> index eba98df9da..d77ccc8785 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -36,6 +36,7 @@
>  #include "net/slirp.h"
>  #include "chardev/char-fe.h"
>  #include "chardev/char-io.h"
> +#include "chardev/char-mux.h"
>  #include "ui/qemu-spice.h"
>  #include "sysemu/numa.h"
>  #include "monitor/monitor.h"
> @@ -4568,12 +4569,26 @@ static void monitor_qmp_setup_handlers_bh(void *o=
paque)
>  void monitor_init(Chardev *chr, int flags)
>  {
>      Monitor *mon =3D g_malloc(sizeof(*mon));
> +    bool use_readline =3D flags & MONITOR_USE_READLINE;
> +    bool use_oob =3D flags & MONITOR_USE_OOB;
> +
> +    if (use_oob) {
> +        if (CHARDEV_IS_MUX(chr)) {
> +            error_report("Monitor Out-Of-Band is not supported with "
> +                         "MUX typed chardev backend");
> +            exit(1);
> +        }
> +        if (use_readline) {
> +            error_report("Monitor Out-Of-band is only supported by QMP")=
;
> +            exit(1);
> +        }
> +    }

I would rather see the error reporting / exit in vl.c:mon_init_func()
function, to have a single place for exit()

>
> -    monitor_data_init(mon, false, false);
> +    monitor_data_init(mon, false, use_oob);
>
>      qemu_chr_fe_init(&mon->chr, chr, &error_abort);
>      mon->flags =3D flags;
> -    if (flags & MONITOR_USE_READLINE) {
> +    if (use_readline) {
>          mon->rs =3D readline_init(monitor_readline_printf,
>                                  monitor_readline_flush,
>                                  mon,
> @@ -4669,6 +4684,9 @@ QemuOptsList qemu_mon_opts =3D {
>          },{
>              .name =3D "pretty",
>              .type =3D QEMU_OPT_BOOL,
> +        },{
> +            .name =3D "x-oob",
> +            .type =3D QEMU_OPT_BOOL,
>          },
>          { /* end of list */ }
>      },
> diff --git a/vl.c b/vl.c
> index c81cc86607..5fd01bd5f6 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2404,6 +2404,11 @@ static int mon_init_func(void *opaque, QemuOpts *o=
pts, Error **errp)
>      if (qemu_opt_get_bool(opts, "pretty", 0))
>          flags |=3D MONITOR_USE_PRETTY;
>
> +    /* OOB is off by default */
> +    if (qemu_opt_get_bool(opts, "x-oob", 0)) {
> +        flags |=3D MONITOR_USE_OOB;
> +    }
> +
>      chardev =3D qemu_opt_get(opts, "chardev");
>      chr =3D qemu_chr_find(chardev);
>      if (chr =3D=3D NULL) {
> --
> 2.14.3
>

Other than that, it looks fine.
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
