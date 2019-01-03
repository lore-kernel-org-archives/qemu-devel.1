Received: from eggs.gnu.org ([208.118.235.92]:51206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ptsneves@gmail.com>) id 1gfAK2-0007St-G6
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 16:14:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ptsneves@gmail.com>) id 1gfAK1-0004g1-DD
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 16:14:34 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ptsneves@gmail.com>) id 1gfAK1-0004fm-4c
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 16:14:33 -0500
Received: by mail-wr1-x444.google.com with SMTP id c14so34923945wrr.0
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 13:14:33 -0800 (PST)
MIME-Version: 1.0
References: <1546078551-6109-1-git-send-email-ptsneves@gmail.com>
	<1546078551-6109-2-git-send-email-ptsneves@gmail.com>
	<CAJ+F1C+k6k2KLZWKFQ_4RPxWWeDWhEbLaq6g2iESyhk2kjVLEQ@mail.gmail.com>
In-Reply-To: <CAJ+F1C+k6k2KLZWKFQ_4RPxWWeDWhEbLaq6g2iESyhk2kjVLEQ@mail.gmail.com>
From: Paulo Neves <ptsneves@gmail.com>
Date: Thu, 3 Jan 2019 22:14:20 +0100
Message-ID: <CAJO0J4gH_NsNaCTnotVrXhB5tXvKE=VG_qjwJmXxStW7mJcwGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] chardev: Allow for pty path passing.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>

On Wed, Jan 2, 2019 at 9:24 AM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Sat, Dec 29, 2018 at 2:34 PM Paulo Neves <ptsneves@gmail.com> wrote:
> >
> > If a user requires a virtual serial device like provided
> > by the pty char device, the user needs to accept the
> > returned device name. This makes the program need to
> > have smarts to parse or communicate with qemu to get the
> > pty device.
> > With this patch the program can pass the path where
> > a symlink to the pty device will be, removing the
> > need for 2 way communication or smarts.
>
> This seems reasonable. Your patch doesn't apply on master, can you rebase=
 it?
Will do so. A patch V2 was sent with the rebase and the sign-off which
i had forgotten.
>
> > ---
> >  chardev/char-pty.c | 38 ++++++++++++++++++++++++++++++++++++--
> >  chardev/char.c     |  6 +++++-
> >  qapi/char.json     |  4 ++--
> >  3 files changed, 43 insertions(+), 5 deletions(-)
> >
> > diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> > index 761ae6d..b465263 100644
> > --- a/chardev/char-pty.c
> > +++ b/chardev/char-pty.c
> > @@ -38,6 +38,7 @@
> >  typedef struct {
> >      Chardev parent;
> >      QIOChannel *ioc;
> > +    char *link_name;
> >      int read_bytes;
> >
> >      /* Protected by the Chardev chr_write_lock.  */
> > @@ -231,6 +232,11 @@ static void char_pty_finalize(Object *obj)
> >      qemu_mutex_lock(&chr->chr_write_lock);
> >      pty_chr_state(chr, 0);
> >      object_unref(OBJECT(s->ioc));
> > +
> > +    if (s->link_name) {
> > +        unlink(s->link_name);
> > +    }
> > +
>
> I suspect a g_free(s->link_name) is missing
I am not sure we own the opts-device memory, so in the new patch i
indeed do g_free, but I free what I strdup'ed.
Did i misinterpret your review, or do you mean that I should g_free
opts->device?
>
> >      if (s->timer_tag) {
> >          g_source_remove(s->timer_tag);
> >          s->timer_tag =3D 0;
> > @@ -244,8 +250,9 @@ static void char_pty_open(Chardev *chr,
> >                            bool *be_opened,
> >                            Error **errp)
> >  {
> > +    ChardevHostdev *opts =3D backend->u.pty.data;
> >      PtyChardev *s;
> > -    int master_fd, slave_fd;
> > +    int master_fd, slave_fd, symlink_ret;
> >      char pty_name[PATH_MAX];
> >      char *name;
> >
> > @@ -256,13 +263,23 @@ static void char_pty_open(Chardev *chr,
> >      }
> >
> >      close(slave_fd);
> > +
> > +    s =3D PTY_CHARDEV(chr)
> > +    s->link_name =3D opts->device;
>
> You should g_strdup() it
Done
>
> > +    symlink_ret =3D symlink(pty_name, s->link_name);
> > +
> > +    if (symlink_ret < 0) {
> > +        close(master_fd);
> > +        error_setg_errno(errp, errno, "Failed to create symlink to PTY=
");
> > +        return;
> > +    }
> > +
> >      qemu_set_nonblock(master_fd);
> >
> >      chr->filename =3D g_strdup_printf("pty:%s", pty_name);
> >      error_report("char device redirected to %s (label %s)",
> >                   pty_name, chr->label);
> >
> > -    s =3D PTY_CHARDEV(chr);
> >      s->ioc =3D QIO_CHANNEL(qio_channel_file_new_fd(master_fd));
> >      name =3D g_strdup_printf("chardev-pty-%s", chr->label);
> >      qio_channel_set_name(QIO_CHANNEL(s->ioc), name);
> > @@ -271,6 +288,22 @@ static void char_pty_open(Chardev *chr,
> >      *be_opened =3D false;
> >  }
> >
> > +static void char_pty_parse(QemuOpts *opts, ChardevBackend *backend,
> > +                                Error **errp)
> > +{
> > +    const char *symlink_path =3D qemu_opt_get(opts, "path");
> > +    if(symlink_path =3D=3D NULL) {
> > +        error_setg(errp, "chardev: pty symlink: no device path given")=
;
> > +        return;
> > +
> > +    }
> > +    ChardevHostdev *dev;
> > +
> > +    backend->type =3D CHARDEV_BACKEND_KIND_PTY;
> > +    dev =3D backend->u.pipe.data =3D g_new0(ChardevHostdev, 1);
> > +    qemu_chr_parse_common(opts, qapi_ChardevHostdev_base(dev));
> > +    dev->device =3D g_strdup(symlink_path);
> > +}
> >  static void char_pty_class_init(ObjectClass *oc, void *data)
> >  {
> >      ChardevClass *cc =3D CHARDEV_CLASS(oc);
> > @@ -279,6 +312,7 @@ static void char_pty_class_init(ObjectClass *oc, vo=
id *data)
> >      cc->chr_write =3D char_pty_chr_write;
> >      cc->chr_update_read_handler =3D pty_chr_update_read_handler;
> >      cc->chr_add_watch =3D pty_chr_add_watch;
> > +    cc->parse =3D char_pty_parse;
> >  }
> >
> >  static const TypeInfo char_pty_type_info =3D {
> > diff --git a/chardev/char.c b/chardev/char.c
> > index 5d52cd5..e4c5371 100644
> > --- a/chardev/char.c
> > +++ b/chardev/char.c
> > @@ -357,7 +357,6 @@ QemuOpts *qemu_chr_parse_compat(const char *label, =
const char *filename)
> >      }
> >
> >      if (strcmp(filename, "null")    =3D=3D 0 ||
> > -        strcmp(filename, "pty")     =3D=3D 0 ||
> >          strcmp(filename, "msmouse") =3D=3D 0 ||
> >          strcmp(filename, "wctablet") =3D=3D 0 ||
> >          strcmp(filename, "braille") =3D=3D 0 ||
> > @@ -402,6 +401,11 @@ QemuOpts *qemu_chr_parse_compat(const char *label,=
 const char *filename)
> >          qemu_opt_set(opts, "path", p, &error_abort);
> >          return opts;
> >      }
> > +    if (strstart(filename, "pty:", &p)) {
> > +        qemu_opt_set(opts, "backend", "pty", &error_abort);
> > +        qemu_opt_set(opts, "path", p, &error_abort);
> > +        return opts;
> > +    }
> >      if (strstart(filename, "tcp:", &p) ||
> >          strstart(filename, "telnet:", &p) ||
> >          strstart(filename, "tn3270:", &p)) {
> > diff --git a/qapi/char.json b/qapi/char.json
> > index 6de0f29..dae4231 100644
> > --- a/qapi/char.json
> > +++ b/qapi/char.json
> > @@ -224,7 +224,7 @@
> >  ##
> >  # @ChardevHostdev:
> >  #
> > -# Configuration info for device and pipe chardevs.
> > +# Configuration info for device, pty and pipe chardevs.
> >  #
> >  # @device: The name of the special file for the device,
> >  #          i.e. /dev/ttyS0 on Unix or COM1: on Windows
> > @@ -380,7 +380,7 @@
> >                                         'pipe'   : 'ChardevHostdev',
> >                                         'socket' : 'ChardevSocket',
> >                                         'udp'    : 'ChardevUdp',
> > -                                       'pty'    : 'ChardevCommon',
> > +                                       'pty'    : 'ChardevHostdev',
>
> Better to create a new ChardevPty instead (ChardevHostdev is for host
> device, here it is not)
I did not completely understand what is the advantage here as, like a
pipe the pty is provided by the host machine indeed.
I will modify the patch if this is indeed required. Maybe Eric can
further clarify if indeed due to introspection equivalence the change
is not necessary.
>
> >                                         'null'   : 'ChardevCommon',
> >                                         'mux'    : 'ChardevMux',
> >                                         'msmouse': 'ChardevCommon',
> > --
> > 2.7.4
> >
> >
>
>
> --
> Marc-Andr=C3=A9 Lureau

Paulo Neves
