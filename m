Received: from eggs.gnu.org ([2001:4830:134:3::10]:48387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cRgbn-0002Zi-OY
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:44:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cRgbj-0006Zu-1l
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:44:07 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:34382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cRgbi-0006Z5-LW
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:44:02 -0500
Received: by mail-lf0-x241.google.com with SMTP id q89so2130396lfi.1
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 06:44:02 -0800 (PST)
Date: Thu, 12 Jan 2017 14:43:56 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170112144356.GF14042@stefanha-x1.localdomain>
References: <20170106152930.6779-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="juZjCTNxrMaZdGZC"
Content-Disposition: inline
In-Reply-To: <20170106152930.6779-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] qga: add systemd socket activation
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>


--juZjCTNxrMaZdGZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 06, 2017 at 03:29:30PM +0000, Stefan Hajnoczi wrote:
> AF_UNIX and AF_VSOCK listen sockets can be passed in by systemd on
> startup.  This allows systemd to manage the listen socket until the
> first client connects and between restarts.  Advantages of socket
> activation are that parallel startup of network services becomes
> possible and that unused daemons do not consume memory.
>=20
> The key to achieving this is the LISTEN_FDS environment variable, which
> is a stable ABI as shown here:
> https://www.freedesktop.org/wiki/Software/systemd/InterfacePortabilityAnd=
StabilityChart/
>=20
> We could link against libsystemd and use sd_listen_fds(3) but it's easy
> to implement the tiny LISTEN_FDS ABI so that qemu-ga does not depend on
> libsystemd.  Some systems may not have systemd installed and wish to
> avoid the dependency.  Other init systems or socket activation servers
> may implement the same ABI without systemd involvement.
>=20
> Test as follows:
>=20
>   $ cat ~/.config/systemd/user/qga.service
>   [Unit]
>   Description=3Dqga
>=20
>   [Service]
>   WorkingDirectory=3D/tmp
>   ExecStart=3D/path/to/qemu-ga --logfile=3D/tmp/qga.log --pidfile=3D/tmp/=
qga.pid --statedir=3D/tmp
>=20
>   $ cat ~/.config/systemd/user/qga.socket
>   [Socket]
>   ListenStream=3D/tmp/qga.sock
>=20
>   [Install]
>   WantedBy=3Ddefault.target
>=20
>   $ systemctl --user daemon-reload
>   $ systemctl --user start qga.socket
>   $ nc -U /tmp/qga.sock
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>  * Drop libsystemd dependency [danpb]
>=20
>  qga/channel.h       |  3 ++-
>  qga/channel-posix.c | 66 ++++++++++++++++++++++++++---------------------
>  qga/channel-win32.c |  2 +-
>  qga/main.c          | 74 +++++++++++++++++++++++++++++++++++++++++++++++=
++----
>  4 files changed, 109 insertions(+), 36 deletions(-)

Ping: Mike

BTW systemd have merged AF_VSOCK socket activation support:
https://github.com/systemd/systemd/commit/84e6712f946dd0d08102bf75eebd28528=
29408ae

> diff --git a/qga/channel.h b/qga/channel.h
> index 8fd0c8f..1778416 100644
> --- a/qga/channel.h
> +++ b/qga/channel.h
> @@ -25,7 +25,8 @@ typedef enum {
>  typedef gboolean (*GAChannelCallback)(GIOCondition condition, gpointer o=
paque);
> =20
>  GAChannel *ga_channel_new(GAChannelMethod method, const gchar *path,
> -                          GAChannelCallback cb, gpointer opaque);
> +                          int listen_fd, GAChannelCallback cb,
> +                          gpointer opaque);
>  void ga_channel_free(GAChannel *c);
>  GIOStatus ga_channel_read(GAChannel *c, gchar *buf, gsize size, gsize *c=
ount);
>  GIOStatus ga_channel_write_all(GAChannel *c, const gchar *buf, gsize siz=
e);
> diff --git a/qga/channel-posix.c b/qga/channel-posix.c
> index 71582e0..3f34465 100644
> --- a/qga/channel-posix.c
> +++ b/qga/channel-posix.c
> @@ -118,14 +118,16 @@ static int ga_channel_client_add(GAChannel *c, int =
fd)
>      return 0;
>  }
> =20
> -static gboolean ga_channel_open(GAChannel *c, const gchar *path, GAChann=
elMethod method)
> +static gboolean ga_channel_open(GAChannel *c, const gchar *path,
> +                                GAChannelMethod method, int fd)
>  {
>      int ret;
>      c->method =3D method;
> =20
>      switch (c->method) {
>      case GA_CHANNEL_VIRTIO_SERIAL: {
> -        int fd =3D qemu_open(path, O_RDWR | O_NONBLOCK
> +        assert(fd < 0);
> +        fd =3D qemu_open(path, O_RDWR | O_NONBLOCK
>  #ifndef CONFIG_SOLARIS
>                             | O_ASYNC
>  #endif
> @@ -153,7 +155,9 @@ static gboolean ga_channel_open(GAChannel *c, const g=
char *path, GAChannelMethod
>      }
>      case GA_CHANNEL_ISA_SERIAL: {
>          struct termios tio;
> -        int fd =3D qemu_open(path, O_RDWR | O_NOCTTY | O_NONBLOCK);
> +
> +        assert(fd < 0);
> +        fd =3D qemu_open(path, O_RDWR | O_NOCTTY | O_NONBLOCK);
>          if (fd =3D=3D -1) {
>              g_critical("error opening channel: %s", strerror(errno));
>              return false;
> @@ -183,37 +187,41 @@ static gboolean ga_channel_open(GAChannel *c, const=
 gchar *path, GAChannelMethod
>          break;
>      }
>      case GA_CHANNEL_UNIX_LISTEN: {
> -        Error *local_err =3D NULL;
> -        int fd =3D unix_listen(path, NULL, strlen(path), &local_err);
> -        if (local_err !=3D NULL) {
> -            g_critical("%s", error_get_pretty(local_err));
> -            error_free(local_err);
> -            return false;
> +        if (fd < 0) {
> +            Error *local_err =3D NULL;
> +
> +            fd =3D unix_listen(path, NULL, strlen(path), &local_err);
> +            if (local_err !=3D NULL) {
> +                g_critical("%s", error_get_pretty(local_err));
> +                error_free(local_err);
> +                return false;
> +            }
>          }
>          ga_channel_listen_add(c, fd, true);
>          break;
>      }
>      case GA_CHANNEL_VSOCK_LISTEN: {
> -        Error *local_err =3D NULL;
> -        SocketAddress *addr;
> -        char *addr_str;
> -        int fd;
> +        if (fd < 0) {
> +            Error *local_err =3D NULL;
> +            SocketAddress *addr;
> +            char *addr_str;
> =20
> -        addr_str =3D g_strdup_printf("vsock:%s", path);
> -        addr =3D socket_parse(addr_str, &local_err);
> -        g_free(addr_str);
> -        if (local_err !=3D NULL) {
> -            g_critical("%s", error_get_pretty(local_err));
> -            error_free(local_err);
> -            return false;
> -        }
> +            addr_str =3D g_strdup_printf("vsock:%s", path);
> +            addr =3D socket_parse(addr_str, &local_err);
> +            g_free(addr_str);
> +            if (local_err !=3D NULL) {
> +                g_critical("%s", error_get_pretty(local_err));
> +                error_free(local_err);
> +                return false;
> +            }
> =20
> -        fd =3D socket_listen(addr, &local_err);
> -        qapi_free_SocketAddress(addr);
> -        if (local_err !=3D NULL) {
> -            g_critical("%s", error_get_pretty(local_err));
> -            error_free(local_err);
> -            return false;
> +            fd =3D socket_listen(addr, &local_err);
> +            qapi_free_SocketAddress(addr);
> +            if (local_err !=3D NULL) {
> +                g_critical("%s", error_get_pretty(local_err));
> +                error_free(local_err);
> +                return false;
> +            }
>          }
>          ga_channel_listen_add(c, fd, true);
>          break;
> @@ -262,13 +270,13 @@ GIOStatus ga_channel_read(GAChannel *c, gchar *buf,=
 gsize size, gsize *count)
>  }
> =20
>  GAChannel *ga_channel_new(GAChannelMethod method, const gchar *path,
> -                          GAChannelCallback cb, gpointer opaque)
> +                          int listen_fd, GAChannelCallback cb, gpointer =
opaque)
>  {
>      GAChannel *c =3D g_new0(GAChannel, 1);
>      c->event_cb =3D cb;
>      c->user_data =3D opaque;
> =20
> -    if (!ga_channel_open(c, path, method)) {
> +    if (!ga_channel_open(c, path, method, listen_fd)) {
>          g_critical("error opening channel");
>          ga_channel_free(c);
>          return NULL;
> diff --git a/qga/channel-win32.c b/qga/channel-win32.c
> index 21f9dee..7e6dc4d 100644
> --- a/qga/channel-win32.c
> +++ b/qga/channel-win32.c
> @@ -316,7 +316,7 @@ static gboolean ga_channel_open(GAChannel *c, GAChann=
elMethod method,
>  }
> =20
>  GAChannel *ga_channel_new(GAChannelMethod method, const gchar *path,
> -                          GAChannelCallback cb, gpointer opaque)
> +                          int listen_fd, GAChannelCallback cb, gpointer =
opaque)
>  {
>      GAChannel *c =3D g_new0(GAChannel, 1);
>      SECURITY_ATTRIBUTES sec_attrs;
> diff --git a/qga/main.c b/qga/main.c
> index 6caf215..4da8246 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -28,6 +28,7 @@
>  #include "qga/channel.h"
>  #include "qemu/bswap.h"
>  #include "qemu/help_option.h"
> +#include "qemu/sockets.h"
>  #ifdef _WIN32
>  #include "qga/service-win32.h"
>  #include "qga/vss-win32.h"
> @@ -184,6 +185,37 @@ void reopen_fd_to_null(int fd)
>  }
>  #endif
> =20
> +/**
> + * get_listen_fd:
> + * @consume: true to prevent future calls from succeeding
> + *
> + * Fetch a listen file descriptor that was passed via systemd socket
> + * activation.  Use @consume to prevent child processes from thinking a =
file
> + * descriptor was passed.
> + *
> + * Returns: file descriptor or -1 if no fd was passed
> + */
> +static int get_listen_fd(bool consume)
> +{
> +#ifdef _WIN32
> +    return -1; /* no fd passing expected, unsetenv(3) not available */
> +#else
> +    const char *listen_fds =3D getenv("LISTEN_FDS");
> +    int fd =3D STDERR_FILENO + 1;
> +
> +    if (!listen_fds || strcmp(listen_fds, "1") !=3D 0) {
> +        return -1;
> +    }
> +
> +    if (consume) {
> +        unsetenv("LISTEN_FDS");
> +    }
> +
> +    qemu_set_cloexec(fd);
> +    return fd;
> +#endif /* !_WIN32 */
> +}
> +
>  static void usage(const char *cmd)
>  {
>      printf(
> @@ -648,7 +680,8 @@ static gboolean channel_event_cb(GIOCondition conditi=
on, gpointer data)
>      return true;
>  }
> =20
> -static gboolean channel_init(GAState *s, const gchar *method, const gcha=
r *path)
> +static gboolean channel_init(GAState *s, const gchar *method, const gcha=
r *path,
> +                             int listen_fd)
>  {
>      GAChannelMethod channel_method;
> =20
> @@ -666,7 +699,8 @@ static gboolean channel_init(GAState *s, const gchar =
*method, const gchar *path)
>          return false;
>      }
> =20
> -    s->channel =3D ga_channel_new(channel_method, path, channel_event_cb=
, s);
> +    s->channel =3D ga_channel_new(channel_method, path, listen_fd,
> +                                channel_event_cb, s);
>      if (!s->channel) {
>          g_critical("failed to create guest agent channel");
>          return false;
> @@ -1025,7 +1059,9 @@ static void config_dump(GAConfig *config)
> =20
>      g_key_file_set_boolean(keyfile, "general", "daemon", config->daemoni=
ze);
>      g_key_file_set_string(keyfile, "general", "method", config->method);
> -    g_key_file_set_string(keyfile, "general", "path", config->channel_pa=
th);
> +    if (config->channel_path) {
> +        g_key_file_set_string(keyfile, "general", "path", config->channe=
l_path);
> +    }
>      if (config->log_filepath) {
>          g_key_file_set_string(keyfile, "general", "logfile",
>                                config->log_filepath);
> @@ -1294,7 +1330,9 @@ static int run_agent(GAState *s, GAConfig *config)
>  #endif
> =20
>      s->main_loop =3D g_main_loop_new(NULL, false);
> -    if (!channel_init(ga_state, config->method, config->channel_path)) {
> +
> +    if (!channel_init(ga_state, config->method, config->channel_path,
> +                      get_listen_fd(true))) {
>          g_critical("failed to initialize guest agent channel");
>          return EXIT_FAILURE;
>      }
> @@ -1318,6 +1356,7 @@ int main(int argc, char **argv)
>      int ret =3D EXIT_SUCCESS;
>      GAState *s =3D g_new0(GAState, 1);
>      GAConfig *config =3D g_new0(GAConfig, 1);
> +    int listen_fd;
> =20
>      config->log_level =3D G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL;
> =20
> @@ -1339,7 +1378,32 @@ int main(int argc, char **argv)
>          config->method =3D g_strdup("virtio-serial");
>      }
> =20
> -    if (config->channel_path =3D=3D NULL) {
> +    listen_fd =3D get_listen_fd(false);
> +    if (listen_fd >=3D 0) {
> +        SocketAddress *addr;
> +
> +        g_free(config->method);
> +        g_free(config->channel_path);
> +        config->method =3D NULL;
> +        config->channel_path =3D NULL;
> +
> +        addr =3D socket_local_address(listen_fd, NULL);
> +        if (addr) {
> +            if (addr->type =3D=3D SOCKET_ADDRESS_KIND_UNIX) {
> +                config->method =3D g_strdup("unix-listen");
> +            } else if (addr->type =3D=3D SOCKET_ADDRESS_KIND_VSOCK) {
> +                config->method =3D g_strdup("vsock-listen");
> +            }
> +
> +            qapi_free_SocketAddress(addr);
> +        }
> +
> +        if (!config->method) {
> +            g_critical("unsupported listen fd type");
> +            ret =3D EXIT_FAILURE;
> +            goto end;
> +        }
> +    } else if (config->channel_path =3D=3D NULL) {
>          if (strcmp(config->method, "virtio-serial") =3D=3D 0) {
>              /* try the default path for the virtio-serial port */
>              config->channel_path =3D g_strdup(QGA_VIRTIO_PATH_DEFAULT);
> --=20
> 2.9.3
>=20
>=20

--juZjCTNxrMaZdGZC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYd5YsAAoJEJykq7OBq3PITHEH/Aw2HK7wKCjcCuC4mHcKIVoh
pTh7/Pou4O7RA94+ICRoDMqZ3Pfktq1isJpV1Kz8XJITYg8WUoodtMIfd+3QpNoP
OtPIvbA6h8FDzT4VtZlB8ep/ByjHFH991Nf/BL0B26EocY3Hp+ZvxjhqJmdb5mrj
0kkG5sjBSV6NfwC631fjCsTZ9UbgrozxbdIsu6hOAVSkSV9tugG2c0hxH7E1hE6W
BmgBe8ZgQm58wq9K5VNKnqPd7ya6z4NvCSLAjtJ+ZEATyuiYTk0nkmdWsedJQaC/
H6qg8DfxHU6+5yxMMU5rp6tt0g6tmJIzYiS/BpehY5r8ETzuE40Syjg+ZkFKKGI=
=JGa0
-----END PGP SIGNATURE-----

--juZjCTNxrMaZdGZC--
