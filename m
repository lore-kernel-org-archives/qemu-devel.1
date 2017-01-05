Received: from eggs.gnu.org ([2001:4830:134:3::10]:48201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOxpZ-0003pA-0s
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 21:31:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOxpU-0005ur-1m
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 21:31:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cOxpT-0005tv-Nu
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 21:30:59 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A60FC81229
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 02:30:59 +0000 (UTC)
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
	<20161212224325.20790-16-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <76a23e82-c8be-c8a4-08ad-953b7d185ccc@redhat.com>
Date: Wed, 4 Jan 2017 20:30:56 -0600
MIME-Version: 1.0
In-Reply-To: <20161212224325.20790-16-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vwwRA5J8sSnmEsbregiOf83wXbAHJmqoa"
Subject: Re: [Qemu-devel] [PATCH 15/54] chardev: qom-ify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vwwRA5J8sSnmEsbregiOf83wXbAHJmqoa
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <76a23e82-c8be-c8a4-08ad-953b7d185ccc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 15/54] chardev: qom-ify
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
 <20161212224325.20790-16-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-16-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/12/2016 04:42 PM, Marc-Andr=C3=A9 Lureau wrote:
> Turn Chardev into Object.
>=20
> qemu_chr_alloc() is replaced by the qemu_chardev_new() constructor. It
> will call qemu_char_open() to open/intialize the chardev with the
> ChardevCommon *backend settings.
>=20
> The CharDriver::create() callback is turned into a ChardevClass::open()=

> which is called from the newly introduced qemu_chardev_open().
>=20
> "chardev-gdb" and "chardev-hci" are internal chardev and aren't
> creatable directly with -chardev. Use a new internal flag to disable
> them. We may want to use TYPE_USER_CREATABLE interface instead, or
> perhaps allow -chardev usage.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  backends/baum.c       |   70 +--
>  backends/msmouse.c    |   57 ++-
>  backends/testdev.c    |   34 +-
>  gdbstub.c             |   33 +-
>  hw/bt/hci-csr.c       |   54 +-
>  monitor.c             |    2 +-
>  qemu-char.c           | 1334 ++++++++++++++++++++++++++---------------=
--------
>  spice-qemu-char.c     |  144 +++---
>  ui/console.c          |   73 +--
>  ui/gtk.c              |   51 +-
>  vl.c                  |    2 +
>  include/sysemu/char.h |  107 ++--
>  include/ui/console.h  |    2 +
>  13 files changed, 1084 insertions(+), 879 deletions(-)

Big, but probably not possible to break it into many more chunks.

Rearranging the reply, to put the .h first:

> diff --git a/include/sysemu/char.h b/include/sysemu/char.h
> index 384f3ce9b7..1ee8aa4325 100644
> --- a/include/sysemu/char.h
> +++ b/include/sysemu/char.h
> @@ -10,6 +10,7 @@
>  #include "qapi/qmp/qstring.h"
>  #include "qemu/main-loop.h"
>  #include "qemu/bitmap.h"
> +#include "qom/object.h"
>
>  /* character device */
>
> @@ -90,7 +91,8 @@ typedef struct CharBackend {
>  typedef struct CharDriver CharDriver;
>
>  struct Chardev {
> -    const CharDriver *driver;
> +    Object parent_obj;
> +
>      QemuMutex chr_write_lock;
>      CharBackend *be;
>      char *label;
> @@ -102,18 +104,6 @@ struct Chardev {
>      QTAILQ_ENTRY(Chardev) next;
>  };
>

>
> +#define TYPE_CHARDEV "chardev"
> +#define CHARDEV(obj) OBJECT_CHECK(Chardev, (obj), TYPE_CHARDEV)
> +#define CHARDEV_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(ChardevClass, (klass), TYPE_CHARDEV)
> +#define CHARDEV_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(ChardevClass, (obj), TYPE_CHARDEV)
> +
> +#define TYPE_CHARDEV_NULL "chardev-null"
> +#define TYPE_CHARDEV_MUX "chardev-mux"
> +#define TYPE_CHARDEV_RINGBUF "chardev-ringbuf"
> +#define TYPE_CHARDEV_PTY "chardev-pty"
> +#define TYPE_CHARDEV_CONSOLE "chardev-console"
> +#define TYPE_CHARDEV_STDIO "chardev-stdio"
> +#define TYPE_CHARDEV_PIPE "chardev-pipe"
> +#define TYPE_CHARDEV_MEMORY "chardev-memory"
> +#define TYPE_CHARDEV_PARALLEL "chardev-parallel"
> +#define TYPE_CHARDEV_FILE "chardev-file"
> +#define TYPE_CHARDEV_SERIAL "chardev-serial"
> +#define TYPE_CHARDEV_SOCKET "chardev-socket"
> +#define TYPE_CHARDEV_UDP "chardev-udp"
> +
> +#define CHARDEV_IS_MUX(chr) \
> +    object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX)
> +#define CHARDEV_IS_RINGBUF(chr) \
> +    object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_RINGBUF)
> +#define CHARDEV_IS_PTY(chr) \
> +    object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_PTY)
> +
> +typedef struct ChardevClass {
> +    ObjectClass parent_class;
> +
> +    bool internal; /* TODO: eventually use TYPE_USER_CREATABLE */
> +
> +    void (*open)(Chardev *chr, ChardevBackend *backend,
> +                 bool *be_opened, Error **errp);
> +
> +    int (*chr_write)(Chardev *s, const uint8_t *buf, int len);
> +    int (*chr_sync_read)(Chardev *s, const uint8_t *buf, int len);
> +    GSource *(*chr_add_watch)(Chardev *s, GIOCondition cond);
> +    void (*chr_update_read_handler)(Chardev *s, GMainContext *context)=
;
> +    int (*chr_ioctl)(Chardev *s, int cmd, void *arg);
> +    int (*get_msgfds)(Chardev *s, int* fds, int num);
> +    int (*set_msgfds)(Chardev *s, int *fds, int num);
> +    int (*chr_add_client)(Chardev *chr, int fd);
> +    int (*chr_wait_connected)(Chardev *chr, Error **errp);
> +    void (*chr_free)(Chardev *chr);
> +    void (*chr_disconnect)(Chardev *chr);
> +    void (*chr_accept_input)(Chardev *chr);
> +    void (*chr_set_echo)(Chardev *chr, bool echo);
> +    void (*chr_set_fe_open)(Chardev *chr, int fe_open);
> +} ChardevClass;

Looks nice.

On to the .c:


>=20
> diff --git a/backends/baum.c b/backends/baum.c
> index 7fd1ebc557..80103b6098 100644
> --- a/backends/baum.c
> +++ b/backends/baum.c
> @@ -102,6 +102,9 @@ typedef struct {
>      QEMUTimer *cellCount_timer;
>  } BaumChardev;
> =20
> +#define TYPE_CHARDEV_BRAILLE "chardev-braille"
> +#define BAUM_CHARDEV(obj) OBJECT_CHECK(BaumChardev, (obj), TYPE_CHARDE=
V_BRAILLE)

As mentioned earlier, OBJECT_CHECK() is a nice wrapper around
container_of(), so this indeed resolves my earlier concerns on casts.

> +
>  /* Let's assume NABCC by default */
>  enum way {
>      DOTS2ASCII,
> @@ -268,9 +271,9 @@ static int baum_deferred_init(BaumChardev *baum)
>  }
> =20
>  /* The serial port can receive more of our data */
> -static void baum_accept_input(struct Chardev *chr)
> +static void baum_chr_accept_input(struct Chardev *chr)

Why the rename?

> @@ -485,9 +488,9 @@ static int baum_eat_packet(BaumChardev *baum, const=
 uint8_t *buf, int len)
>  }
> =20
>  /* The other end is writing some data.  Store it and try to interpret =
*/
> -static int baum_write(Chardev *chr, const uint8_t *buf, int len)
> +static int baum_chr_write(Chardev *chr, const uint8_t *buf, int len)

and again

> @@ -544,7 +547,7 @@ static void baum_send_key2(BaumChardev *baum, uint8=
_t type, uint8_t value,
>  /* We got some data on the BrlAPI socket */
>  static void baum_chr_read(void *opaque)
>  {

If it is for consistency in the baum callback names, maybe a separate
patch is warranted for that part.

> @@ -515,33 +485,98 @@ static void remove_fd_in_watch(Chardev *chr);
>  static void mux_chr_set_handlers(Chardev *chr, GMainContext *context);=

>  static void mux_set_focus(MuxChardev *d, int focus);
> =20
> -static int null_chr_write(Chardev *chr, const uint8_t *buf, int len)
> +static void qemu_char_open(Chardev *chr, ChardevBackend *backend,
> +                           bool *be_opened, Error **errp)
>  {
> -    return len;
> +    ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
> +    /* Any ChardevCommon member would work */
> +    ChardevCommon *common =3D backend ? backend->u.null.data : NULL;
> +
> +    if (common && common->has_logfile) {
> +        int flags =3D O_WRONLY | O_CREAT;
> +        if (common->has_logappend &&
> +            common->logappend) {
> +            flags |=3D O_APPEND;
> +        } else {
> +            flags |=3D O_TRUNC;
> +        }
> +        chr->logfd =3D qemu_open(common->logfile, flags, 0666);
> +        if (chr->logfd < 0) {
> +            error_setg_errno(errp, errno,
> +                             "Unable to open logfile %s",
> +                             common->logfile);
> +            return;
> +        }
> +    }
> +
> +    if (cc->open) {
> +        cc->open(chr, backend, be_opened, errp);
> +    }
>  }

Looking good.

> @@ -1421,19 +1451,15 @@ static Chardev *qemu_chr_open_stdio(const CharD=
river *driver,
>      act.sa_handler =3D term_stdio_handler;
>      sigaction(SIGCONT, &act, NULL);
> =20
> -    chr =3D qemu_chr_open_fd(driver, 0, 1, common, errp);
> -    if (!chr) {
> -        return NULL;
> -    }
> +    qemu_chr_open_fd(chr, 0, 1);
> +
>      if (opts->has_signal) {
>          stdio_allow_signal =3D opts->signal;
>      }
>      qemu_chr_set_echo_stdio(chr, false);
> -
> -    return chr;
>  }
> =20
> -#if defined(__linux__) || defined(__sun__) || defined(__FreeBSD__) \
> +#if defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)    =
 \
>      || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__Dragon=
Fly__) \

The change in this #if looks spurious.

> @@ -3905,18 +3925,24 @@ static void qemu_chr_parse_pipe(QemuOpts *opts,=
 ChardevBackend *backend,
> =20
>  static const CharDriver pipe_driver =3D {
>      .kind =3D CHARDEV_BACKEND_KIND_PIPE,
> -    .parse =3D qemu_chr_parse_pipe, .create =3D qemu_chr_open_pipe,
> +    .parse =3D qemu_chr_parse_pipe
> +};

nit: As pointed out earlier in the series, I like trailing comma in
struct initializations.

> =20
>  static const CharDriver udp_driver =3D {
> -    .instance_size =3D sizeof(UdpChardev),
>      .kind =3D CHARDEV_BACKEND_KIND_UDP,
> -    .parse =3D qemu_chr_parse_udp, .create =3D qmp_chardev_open_udp,
> -    .chr_write =3D udp_chr_write,
> -    .chr_update_read_handler =3D udp_chr_update_read_handler,
> -    .chr_free =3D udp_chr_free,
> +    .parse =3D qemu_chr_parse_udp
> +};

Multiple places

> @@ -5020,33 +5115,44 @@ void qemu_chr_cleanup(void)
> =20
>  static void register_types(void)
>  {
> -    static const CharDriver *drivers[] =3D {
> -        &null_driver,
> -        &socket_driver,
> -        &udp_driver,
> -        &ringbuf_driver,
> -        &file_driver,
> -        &stdio_driver,
> +    static const struct {
> +        const CharDriver *driver;
> +        const TypeInfo *type;
> +    } chardevs[] =3D {
> +        { &null_driver, &char_null_type_info },
> +        { &socket_driver, &char_socket_type_info },
> +        { &udp_driver, &char_udp_type_info },
> +        { &ringbuf_driver, &char_ringbuf_type_info },
> +        { &file_driver, &char_file_type_info },
> +        { &stdio_driver, &char_stdio_type_info },
>  #ifdef HAVE_CHARDEV_SERIAL
> -        &serial_driver,
> +        { &serial_driver, &char_serial_type_info },
>  #endif
>  #ifdef HAVE_CHARDEV_PARPORT
> -        &parallel_driver,
> +        { &parallel_driver, &char_parallel_type_info },
>  #endif
>  #ifdef HAVE_CHARDEV_PTY
> -        &pty_driver,
> +        { &pty_driver, &char_pty_type_info },
>  #endif
>  #ifdef _WIN32
> -        &console_driver,
> +        { &console_driver, &char_console_type_info },
>  #endif
> -        &pipe_driver,
> -        &mux_driver,
> -        &memory_driver
> +        { &pipe_driver, &char_pipe_type_info },
> +        { &mux_driver, &char_mux_type_info },
> +        { &memory_driver, &char_memory_type_info }
>      };
>      int i;
> =20
> -    for (i =3D 0; i < ARRAY_SIZE(drivers); i++) {
> -        register_char_driver(drivers[i]);
> +    type_register_static(&char_type_info);
> +#ifndef _WIN32
> +    type_register_static(&char_fd_type_info);
> +#else
> +    type_register_static(&char_win_type_info);
> +    type_register_static(&char_win_stdio_type_info);
> +#endif
> +    for (i =3D 0; i < ARRAY_SIZE(chardevs); i++) {
> +        type_register_static(chardevs[i].type);
> +        register_char_driver(chardevs[i].driver);
>      }
> =20
>      /* this must be done after machine init, since we register FEs wit=
h muxes
> diff --git a/spice-qemu-char.c b/spice-qemu-char.c

So far, looks like a sane conversion.  I've run out of review time
today; I'll have to pick up from this file tomorrow.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--vwwRA5J8sSnmEsbregiOf83wXbAHJmqoa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYba/gAAoJEKeha0olJ0Nq9V8H/1GLg4SgXy/YVmSfIhWEoBhS
bN1AOTXRrxdc4o4XOiH96mVDA0QQmBHzzv+dFJGwfmAGXVd8s6nGnx+3kzkzjdm0
r+W88abAmz4f8Xnlb/vvwp3YYSyFG6yw2nHxj12H//zbJZAO1TvzxrkA/rM7iy+/
X2WgvGtchOjkjzwH48WX8u1WwDWV1gRjtyh3Ucs7lGYVqCO/yIjHLcC1NUocyuqN
X2ggvhYNYyjjJckC7vy+mCGviVgCuug8F345JiRgu601nVYmIXShBxybVv88nvyh
2Y3Y9MCND5JBr0BrlBUYRwVCS35TxFy9xPz+r1qTpzzziNSXrCoFk2YHwcJkM+o=
=Olo4
-----END PGP SIGNATURE-----

--vwwRA5J8sSnmEsbregiOf83wXbAHJmqoa--
