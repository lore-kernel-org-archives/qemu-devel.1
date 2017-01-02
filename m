Received: from eggs.gnu.org ([2001:4830:134:3::10]:38962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cO4cJ-0003fV-0z
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 10:33:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cO4cF-0004Uq-R6
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 10:33:43 -0500
Received: from mx3-phx2.redhat.com ([209.132.183.24]:44576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cO4cF-0004UR-Ge
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 10:33:39 -0500
Date: Mon, 2 Jan 2017 10:33:39 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <305153287.20363.1483371219240.JavaMail.zimbra@redhat.com>
In-Reply-To: <aeb7472e-69f4-b73e-7db2-bf88559b3116@redhat.com>
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
	<20161212224325.20790-5-marcandre.lureau@redhat.com>
	<aeb7472e-69f4-b73e-7db2-bf88559b3116@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/54] char: move callbacks in CharDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com

hi

----- Original Message -----
> On 12/12/2016 04:42 PM, Marc-Andr=C3=A9 Lureau wrote:
> > This makes the code more declarative, and avoids to duplicate the
>=20
> s/to duplicate/duplicating/

ok

>=20
> > information on all instances.
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  backends/baum.c       |  13 +-
> >  backends/msmouse.c    |  13 +-
> >  backends/testdev.c    |  10 +-
> >  gdbstub.c             |   7 +-
> >  hw/bt/hci-csr.c       |   8 +-
> >  qemu-char.c           | 427
> >  +++++++++++++++++++++++++++++++-------------------
> >  spice-qemu-char.c     |  36 +++--
> >  ui/console.c          |  26 +--
> >  ui/gtk.c              |  11 +-
> >  include/sysemu/char.h |  46 +++---
>=20
> Again, seeing the .h changes first makes a huge difference on code
> review.  I'm manually reformatting:
>=20
> >  10 files changed, 370 insertions(+), 227 deletions(-)
>=20
> > diff --git a/include/sysemu/char.h b/include/sysemu/char.h
> > index c8750ede21..09e40ef9b8 100644
> > --- a/include/sysemu/char.h
> > +++ b/include/sysemu/char.h
> > @@ -85,24 +85,11 @@ typedef struct CharBackend {
> >      int fe_open;
> >  } CharBackend;
> >
> > +typedef struct CharDriver CharDriver;
> > +
> >  struct CharDriverState {
> > +    const CharDriver *driver;
> >      QemuMutex chr_write_lock;
> > -    int (*chr_write)(struct CharDriverState *s, const uint8_t *buf,
> int len);
>=20
> So all the callbacks are moved into the CharDriver struct...
>=20
> > @@ -125,7 +112,8 @@ struct CharDriverState {
> >   *
> >   * Returns: a newly allocated CharDriverState, or NULL on error.
> >   */
> > -CharDriverState *qemu_chr_alloc(ChardevCommon *backend, Error **errp);
> > +CharDriverState *qemu_chr_alloc(const CharDriver *driver,
> > +                                ChardevCommon *backend, Error **errp);
>=20
> ...and all the entry points are now passed that struct as a new parameter=
.
>=20
> >
> >  /**
> >   * @qemu_chr_new_from_opts:
> > @@ -473,15 +461,33 @@ void qemu_chr_set_feature(CharDriverState *chr,
> >                            CharDriverFeature feature);
> >  QemuOpts *qemu_chr_parse_compat(const char *label, const char *filenam=
e);
> >
> > -typedef struct CharDriver {
> > +struct CharDriver {
>=20
> ...the struct already existed, but is now more useful.
>=20
> Looks worthwhile. I suspect the rest of the patch is mechanical.
>=20
> > @@ -688,7 +686,10 @@ static void register_types(void)
> >  {
> >      static const CharDriver driver =3D {
> >          .kind =3D CHARDEV_BACKEND_KIND_BRAILLE,
> > -        .parse =3D NULL, .create =3D chr_baum_init
> > +        .parse =3D NULL, .create =3D chr_baum_init,
>=20
> And now you see why I asked for trailing commas in 2/54 :)
>=20
> > +        .chr_write =3D baum_write,
> > +        .chr_accept_input =3D baum_accept_input,
> > +        .chr_free =3D baum_free,
> >      };
> > =20
>=20
> > +++ b/gdbstub.c
> > @@ -1730,6 +1730,10 @@ int gdbserver_start(const char *device)
> >      CharDriverState *chr =3D NULL;
> >      CharDriverState *mon_chr;
> >      ChardevCommon common =3D { 0 };
> > +    static const CharDriver driver =3D {
> > +        .kind =3D -1,
> > +        .chr_write =3D gdb_monitor_write
>=20
> Trailing comma.
>=20
> Interesting that this is a new use of CharDriver with an out-of-range
> .kind. But I think your code in 3/54 was careful to explicitly handle a
> .kind that does not map to one of the public types, so that you are able
> to use this as an internal-only driver.

and kind is removed is later patches "char: remove class kind field"

>=20
>=20
> > =20
> > +static const CharDriver null_driver =3D {
> > +    .kind =3D CHARDEV_BACKEND_KIND_NULL, .create =3D qemu_chr_open_nul=
l,
>=20
> One initializer per line is fine.
>=20
> > +    .chr_write =3D null_chr_write
> > +};
> > +
>=20
> >=20
> > @@ -864,14 +880,6 @@ static CharDriverState *qemu_chr_open_mux(const ch=
ar
> > *id,
> > =20
> >      chr->opaque =3D d;
> >      d->focus =3D -1;
> > -    chr->chr_free =3D mux_chr_free;
> > -    chr->chr_write =3D mux_chr_write;
> > -    chr->chr_accept_input =3D mux_chr_accept_input;
> > -    /* Frontend guest-open / -close notification is not support with m=
uxes
> > */
> > -    chr->chr_set_fe_open =3D NULL;
> > -    if (drv->chr_add_watch) {
> > -        chr->chr_add_watch =3D mux_chr_add_watch;
> > -    }
>=20
> Here, the callback was only conditionally registered...
>=20
> > +static const CharDriver mux_driver =3D {
> > +    .kind =3D CHARDEV_BACKEND_KIND_MUX,
> > +    .parse =3D qemu_chr_parse_mux, .create =3D qemu_chr_open_mux,
> > +    .chr_free =3D mux_chr_free,
> > +    .chr_write =3D mux_chr_write,
> > +    .chr_accept_input =3D mux_chr_accept_input,
> > +    .chr_add_watch =3D mux_chr_add_watch,
> > +};
>=20
> ...but here, it is always registered.  Is that an unintentional semantic
> change?
>=20

mux_chr_add_watch() also checks if the underlying driver has chr_add_watch(=
). qemu_chr_fe_add_watch() returns 0 in both cases then.


>=20
> > +#ifdef HAVE_CHARDEV_SERIAL
> > +static const CharDriver serial_driver =3D {
> > +    .alias =3D "tty", .kind =3D CHARDEV_BACKEND_KIND_SERIAL,
> > +    .parse =3D qemu_chr_parse_serial, .create =3D qmp_chardev_open_ser=
ial,
> > +#ifdef _WIN32
> > +    .chr_write =3D win_chr_write,
> > +    .chr_free =3D win_chr_free,
> > +#else
> > +    .chr_add_watch =3D fd_chr_add_watch,
> > +    .chr_write =3D fd_chr_write,
> > +    .chr_update_read_handler =3D fd_chr_update_read_handler,
> > +    .chr_ioctl =3D tty_serial_ioctl,
> > +    .chr_free =3D qemu_chr_free_tty,
> > +#endif
> > +};
> > +#endif
>=20
>=20
> > @@ -4910,49 +5037,33 @@ void qemu_chr_cleanup(void)
> > =20
> >  static void register_types(void)
> >  {
> > -    int i;
> > -    static const CharDriver drivers[] =3D {
> > -        { .kind =3D CHARDEV_BACKEND_KIND_NULL, .parse =3D NULL,
> > -          .create =3D qemu_chr_open_null },
> > -        { .kind =3D CHARDEV_BACKEND_KIND_SOCKET,
> > -          .parse =3D qemu_chr_parse_socket, .create =3D
> > qmp_chardev_open_socket },
> > -        { .kind =3D CHARDEV_BACKEND_KIND_UDP, .parse =3D qemu_chr_pars=
e_udp,
> > -          .create =3D qmp_chardev_open_udp },
> > -        { .kind =3D CHARDEV_BACKEND_KIND_RINGBUF,
> > -          .parse =3D qemu_chr_parse_ringbuf, .create =3D qemu_chr_open=
_ringbuf
> > },
> > -        { .kind =3D CHARDEV_BACKEND_KIND_FILE,
> > -          .parse =3D qemu_chr_parse_file_out, .create =3D
> > qmp_chardev_open_file },
> > -        { .kind =3D CHARDEV_BACKEND_KIND_STDIO,
> > -          .parse =3D qemu_chr_parse_stdio, .create =3D qemu_chr_open_s=
tdio },
> > -#if defined HAVE_CHARDEV_SERIAL
> > -        { .kind =3D CHARDEV_BACKEND_KIND_SERIAL, .alias =3D "tty",
> > -          .parse =3D qemu_chr_parse_serial, .create =3D
> > qmp_chardev_open_serial },
>=20
> It feels like some code motion between 3/54 and 4/54 (you are moving
> where the CharDriver is declared); is it worth tweaking the series to
> avoid the code motion by declaring the structs in the right place to
> begin with?  Not necessarily a show-stopper to the series, though.

I did place it where it felt right at the time I did the change. I don't th=
ink we need to care much because all this is going away in the series. No s=
trong feeling though

>=20
> > +    static const CharDriver *drivers[] =3D {
> > +        &null_driver,
> > +        &socket_driver,
> > +        &udp_driver,
> > +        &ringbuf_driver,
> > +        &file_driver,
> > +        &stdio_driver,
> > +#ifdef HAVE_CHARDEV_SERIAL
> > +        &serial_driver,
> >  #endif
>=20
> Overall impression is that I still like where this is headed.

thanks
