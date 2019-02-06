Received: from eggs.gnu.org ([209.51.188.92]:55321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1grP5H-0007cI-AO
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:25:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1grP5E-0003TY-Sh
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:25:55 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53095)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1grP5A-0003GY-S1
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:25:50 -0500
Received: by mail-wm1-x344.google.com with SMTP id m1so2900349wml.2
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 07:25:23 -0800 (PST)
MIME-Version: 1.0
References: <1548509635-15776-1-git-send-email-ptsneves@gmail.com>
In-Reply-To: <1548509635-15776-1-git-send-email-ptsneves@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 6 Feb 2019 16:25:10 +0100
Message-ID: <CAJ+F1CK8zw1J9gZQzJ1n7hc6L94BWc8Cz_oTp1jtUsHhQVpNcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] chardev: Allow for pty path passing.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paulo Neves <ptsneves@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Sat, Jan 26, 2019 at 2:34 PM Paulo Neves <ptsneves@gmail.com> wrote:
>
> If a user requires a virtual serial device like provided
> by the pty char device, the user needs to accept the
> returned device name. This makes the program need to
> have smarts to parse or communicate with qemu to get the
> pty device.
> With this patch the program can pass the path where
> a symlink to the pty device will be, removing the
> need for 2 way communication or smarts.
>
> Signed-off-by: Paulo Neves <ptsneves@gmail.com>
> ---
>  chardev/char-pty.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  chardev/char.c     |  6 +++++-
>  qapi/char.json     |  4 ++--
>  3 files changed, 47 insertions(+), 4 deletions(-)
>
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index f681d63..5c312ce 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -28,12 +28,14 @@
>  #include "io/channel-file.h"
>  #include "qemu/sockets.h"
>  #include "qemu/error-report.h"
> +#include "qemu/option.h"
>
>  #include "chardev/char-io.h"
>
>  typedef struct {
>      Chardev parent;
>      QIOChannel *ioc;
> +    char *link_name;
>      int read_bytes;
>
>      /* Protected by the Chardev chr_write_lock.  */
> @@ -234,6 +236,12 @@ static void char_pty_finalize(Object *obj)
>      qemu_mutex_lock(&chr->chr_write_lock);
>      pty_chr_state(chr, 0);
>      object_unref(OBJECT(s->ioc));
> +
> +    if (s->link_name) {
> +        unlink(s->link_name);
> +        g_free(s->link_name);
> +    }
> +
>      pty_chr_timer_cancel(s);
>      qemu_mutex_unlock(&chr->chr_write_lock);
>      qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
> @@ -244,8 +252,9 @@ static void char_pty_open(Chardev *chr,
>                            bool *be_opened,
>                            Error **errp)
>  {
> +    ChardevHostdev *opts =3D backend->u.pty.data;
>      PtyChardev *s;
> -    int master_fd, slave_fd;
> +    int master_fd, slave_fd, symlink_ret;
>      char pty_name[PATH_MAX];
>      char *name;
>
> @@ -256,6 +265,17 @@ static void char_pty_open(Chardev *chr,
>      }
>
>      close(slave_fd);
> +
> +    s =3D PTY_CHARDEV(chr);
> +    s->link_name =3D g_strdup(opts->device);
> +    symlink_ret =3D symlink(pty_name, s->link_name);
> +
> +    if (symlink_ret < 0) {
> +        close(master_fd);
> +        error_setg_errno(errp, errno, "Failed to create symlink to PTY")=
;

Leaving s->link_name will lead finalize() to unlink() a file that it
hasn't created.

suggest to symlink() with opts->device.

Please also drop the extra symlink_ret variable.

> +        return;
> +    }
> +
>      qemu_set_nonblock(master_fd);
>
>      chr->filename =3D g_strdup_printf("pty:%s", pty_name);
> @@ -271,6 +291,24 @@ static void char_pty_open(Chardev *chr,
>      *be_opened =3D false;
>  }
>
> +static void char_pty_parse(QemuOpts *opts, ChardevBackend *backend,
> +                                Error **errp)
> +{
> +    const char *symlink_path =3D qemu_opt_get(opts, "path");
> +    if (symlink_path =3D=3D NULL) {
> +        error_setg(errp, "chardev: pty symlink: no device path given");
> +        return;
> +
> +    }
> +
> +    ChardevHostdev *dev;
> +

Please keep declarations groupped, and add an empty line after
declarations. This generally looks more consistent and easier to read.

> +    backend->type =3D CHARDEV_BACKEND_KIND_PTY;
> +    dev =3D backend->u.pipe.data =3D g_new0(ChardevHostdev, 1);
> +    qemu_chr_parse_common(opts, qapi_ChardevHostdev_base(dev));
> +    dev->device =3D g_strdup(symlink_path);
> +}
> +
>  static void char_pty_class_init(ObjectClass *oc, void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
> @@ -279,6 +317,7 @@ static void char_pty_class_init(ObjectClass *oc, void=
 *data)
>      cc->chr_write =3D char_pty_chr_write;
>      cc->chr_update_read_handler =3D pty_chr_update_read_handler;
>      cc->chr_add_watch =3D pty_chr_add_watch;
> +    cc->parse =3D char_pty_parse;
>  }
>
>  static const TypeInfo char_pty_type_info =3D {
> diff --git a/chardev/char.c b/chardev/char.c
> index ccba36b..43fce4a 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -373,7 +373,6 @@ QemuOpts *qemu_chr_parse_compat(const char *label, co=
nst char *filename,
>      }
>
>      if (strcmp(filename, "null")    =3D=3D 0 ||
> -        strcmp(filename, "pty")     =3D=3D 0 ||

This breaks existing "pty" filename. Please fix.

>          strcmp(filename, "msmouse") =3D=3D 0 ||
>          strcmp(filename, "wctablet") =3D=3D 0 ||
>          strcmp(filename, "braille") =3D=3D 0 ||
> @@ -418,6 +417,11 @@ QemuOpts *qemu_chr_parse_compat(const char *label, c=
onst char *filename,
>          qemu_opt_set(opts, "path", p, &error_abort);
>          return opts;
>      }
> +    if (strstart(filename, "pty:", &p)) {
> +        qemu_opt_set(opts, "backend", "pty", &error_abort);
> +        qemu_opt_set(opts, "path", p, &error_abort);
> +        return opts;
> +    }
>      if (strstart(filename, "tcp:", &p) ||
>          strstart(filename, "telnet:", &p) ||
>          strstart(filename, "tn3270:", &p) ||
> diff --git a/qapi/char.json b/qapi/char.json
> index 77ed847..88c62bd 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -229,7 +229,7 @@
>  ##
>  # @ChardevHostdev:
>  #
> -# Configuration info for device and pipe chardevs.
> +# Configuration info for device, pty and pipe chardevs.
>  #
>  # @device: The name of the special file for the device,
>  #          i.e. /dev/ttyS0 on Unix or COM1: on Windows
> @@ -395,7 +395,7 @@
>              'pipe': 'ChardevHostdev',
>              'socket': 'ChardevSocket',
>              'udp': 'ChardevUdp',
> -            'pty': 'ChardevCommon',
> +            'pty': 'ChardevHostdev',
>              'null': 'ChardevCommon',
>              'mux': 'ChardevMux',
>              'msmouse': 'ChardevCommon',
> --
> 2.7.4
>
>

thanks

--=20
Marc-Andr=C3=A9 Lureau
