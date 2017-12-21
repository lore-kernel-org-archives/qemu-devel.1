Received: from eggs.gnu.org ([2001:4830:134:3::10]:42163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eS1D3-00081A-GV
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 08:48:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eS1D1-0005tS-H6
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 08:48:29 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:38096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eS1D1-0005sW-7D
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 08:48:27 -0500
Received: by mail-wr0-x241.google.com with SMTP id o2so25206862wro.5
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 05:48:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171221132717.30284-3-berrange@redhat.com>
References: <20171221132717.30284-1-berrange@redhat.com>
	<20171221132717.30284-3-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 21 Dec 2017 14:48:24 +0100
Message-ID: <CAJ+F1C+R_q3CzR3yK2112gj9d_nsH2m=ajb3V60fqPPcziJRpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 2/2] char: allow passing pre-opened
 socket file descriptor at startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

H

On Thu, Dec 21, 2017 at 2:27 PM, Daniel P. Berrange <berrange@redhat.com> w=
rote:
> When starting QEMU management apps will usually setup a monitor socket, a=
nd
> then open it immediately after startup. If not using QEMU's own -daemoniz=
e
> arg, this process can be troublesome to handle correctly. The mgmt app wi=
ll
> need to repeatedly call connect() until it succeeds, because it does not
> know when QEMU has created the listener socket. If can't retry connect()

If->It

> forever though, because an error might have caused QEMU to exit before it
> even creates the monitor.
>
> The obvious way to fix this kind of problem is to just pass in a pre-open=
ed
> socket file descriptor for the QEMU monitor to listen on. The management =
app
> can now immediately call connect() just once. If connect() fails it knows
> that QEMU has exited with an error.
>
> The SocketAddress(Legacy) structs allow for FD passing via the monitor, u=
sing
> the 'getfd' command, but only when using QMP JSON syntax. The HMP syntax =
has
> no way to initialize the SocketAddress(Legacy) 'fd' variant. So this patc=
h
> first wires up the 'fd' parameter to refer to a monitor file descriptor,
> allowing HMP to use

Make it a seperate patch? Do we need that feature in HMP?

>
>    getfd myfd
>    chardev-add socket,fd=3Dmyfd
>
> The SocketAddress 'fd' variant is currently tied to the use of the monito=
r
> 'getfd' command, so we have a chicken & egg problem with reusing that at
> startup wher no monitor connection is available. We could define that the
> special fd name prefix '/dev/fdset' refers to a FD passed via the CLI, bu=
t
> magic strings feel unpleasant.

Ok

>
> Instead we define a SocketAddress 'fdset' variant that takes an fd set nu=
mber
> that works in combination with the 'add-fd' command line argument. e.g.
>
>   -add-fd fd=3D3,set=3D1
>   -chardev socket,fdset=3D1,id=3Dmon
>   -mon chardev=3Dmon,mode=3Dcontrol
>
> Note that we do not wire this up in the legacy chardev syntax, so you can=
not
> use FD passing with '-qmp', you must use the modern '-mon' + '-chardev' p=
air
>
> An illustrative example of usage is:
>
>   #!/usr/bin/perl
>
>   use IO::Socket::UNIX;
>   use Fcntl;
>
>   unlink "/tmp/qmp";
>   my $srv =3D IO::Socket::UNIX->new(
>     Type =3D> SOCK_STREAM(),
>     Local =3D> "/tmp/qmp",
>     Listen =3D> 1,
>   );
>
>   my $flags =3D fcntl $srv, F_GETFD, 0;
>   fcntl $srv, F_SETFD, $flags & ~FD_CLOEXEC;
>
>   my $fd =3D $srv->fileno();
>
>   exec "qemu-system-x86_64", \
>       "-add-fd", "fd=3D$fd,set=3D1", \
>       "-chardev", "socket,fdset=3D1,server,nowait,id=3Dmon", \
>       "-mon", "chardev=3Dmon,mode=3Dcontrol";
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  chardev/char-socket.c | 66 +++++++++++++++++++++++++++++++++++++++++++++=
------
>  chardev/char.c        |  6 +++++
>  monitor.c             |  5 ++++
>  qapi/common.json      | 11 +++++++++
>  qapi/sockets.json     | 14 ++++++++---
>  util/qemu-sockets.c   | 36 ++++++++++++++++++++++++++++
>  6 files changed, 128 insertions(+), 10 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 6013972f72..c85298589f 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -28,6 +28,7 @@
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "qapi/clone-visitor.h"
> +#include "qemu/cutils.h"
>
>  #include "chardev/char-io.h"
>
> @@ -372,6 +373,10 @@ static char *SocketAddress_to_str(const char *prefix=
, SocketAddress *addr,
>          return g_strdup_printf("%sfd:%s%s", prefix, addr->u.fd.str,
>                                 is_listen ? ",server" : "");
>          break;
> +    case SOCKET_ADDRESS_TYPE_FDSET:
> +        return g_strdup_printf("%sfdset:%" PRId64 "%s", prefix, addr->u.=
fdset.i,
> +                               is_listen ? ",server" : "");
> +        break;
>      case SOCKET_ADDRESS_TYPE_VSOCK:
>          return g_strdup_printf("%svsock:%s:%s", prefix,
>                                 addr->u.vsock.cid,
> @@ -983,25 +988,62 @@ static void qemu_chr_parse_socket(QemuOpts *opts, C=
hardevBackend *backend,
>      const char *path =3D qemu_opt_get(opts, "path");
>      const char *host =3D qemu_opt_get(opts, "host");
>      const char *port =3D qemu_opt_get(opts, "port");
> +    const char *fd =3D qemu_opt_get(opts, "fd");
> +    const char *fdset =3D qemu_opt_get(opts, "fdset");
> +    int64_t fdseti;
>      const char *tls_creds =3D qemu_opt_get(opts, "tls-creds");
>      SocketAddressLegacy *addr;
>      ChardevSocket *sock;
> +    int num =3D 0;
> +
> +    if (path) {
> +        num++;
> +    }
> +    if (fd) {
> +        num++;
> +    }
> +    if (fdset) {
> +        num++;
> +    }
> +    if (host) {
> +        num++;
> +    }
> +    if (num !=3D 1) {
> +        error_setg(errp,
> +                   "Exactly one of 'path', 'fd', 'fdset' or 'host' requi=
red");
> +        return;
> +    }
>

That could be shorter ;)

>      backend->type =3D CHARDEV_BACKEND_KIND_SOCKET;
> -    if (!path) {
> -        if (!host) {
> -            error_setg(errp, "chardev: socket: no host given");
> +    if (path) {
> +        if (tls_creds) {
> +            error_setg(errp, "TLS can only be used over TCP socket");
>              return;
>          }
> +    } else if (host) {
>          if (!port) {
>              error_setg(errp, "chardev: socket: no port given");
>              return;
>          }
> -    } else {
> -        if (tls_creds) {
> -            error_setg(errp, "TLS can only be used over TCP socket");
> +    } else if (fd) {
> +        /* We don't know what host to validate against when in client mo=
de */
> +        if (tls_creds && !is_listen) {
> +            error_setg(errp, "TLS can not be used with pre-opened client=
 FD");
> +            return;
> +        }
> +    } else if (fdset) {
> +        /* We don't know what host to validate against when in client mo=
de */
> +        if (tls_creds && !is_listen) {
> +            error_setg(errp, "TLS can not be used with pre-opened client=
 FD");
>              return;
>          }
> +        if (qemu_strtoi64(fdset, NULL, 10, &fdseti) < 0) {
> +            error_setg_errno(errp, errno,
> +                             "Cannot parse fd set number %s", fdset);
> +            return;
> +        }
> +    } else {
> +        g_assert_not_reached();
>      }
>
>      sock =3D backend->u.socket.data =3D g_new0(ChardevSocket, 1);
> @@ -1027,7 +1069,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, C=
hardevBackend *backend,
>          addr->type =3D SOCKET_ADDRESS_LEGACY_KIND_UNIX;
>          q_unix =3D addr->u.q_unix.data =3D g_new0(UnixSocketAddress, 1);
>          q_unix->path =3D g_strdup(path);
> -    } else {
> +    } else if (host) {
>          addr->type =3D SOCKET_ADDRESS_LEGACY_KIND_INET;
>          addr->u.inet.data =3D g_new(InetSocketAddress, 1);
>          *addr->u.inet.data =3D (InetSocketAddress) {
> @@ -1040,6 +1082,16 @@ static void qemu_chr_parse_socket(QemuOpts *opts, =
ChardevBackend *backend,
>              .has_ipv6 =3D qemu_opt_get(opts, "ipv6"),
>              .ipv6 =3D qemu_opt_get_bool(opts, "ipv6", 0),
>          };
> +    } else if (fd) {
> +        addr->type =3D SOCKET_ADDRESS_LEGACY_KIND_FD;
> +        addr->u.fd.data =3D g_new(String, 1);
> +        addr->u.fd.data->str =3D g_strdup(fd);
> +    } else if (fdset) {
> +        addr->type =3D SOCKET_ADDRESS_LEGACY_KIND_FDSET;
> +        addr->u.fdset.data =3D g_new(Int, 1);
> +        addr->u.fdset.data->i =3D fdseti;
> +    } else {
> +        g_assert_not_reached();
>      }
>      sock->addr =3D addr;
>  }
> diff --git a/chardev/char.c b/chardev/char.c
> index 2ae4f465ec..db940fc40f 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -798,6 +798,12 @@ QemuOptsList qemu_chardev_opts =3D {
>          },{
>              .name =3D "port",
>              .type =3D QEMU_OPT_STRING,
> +        },{
> +            .name =3D "fd",
> +            .type =3D QEMU_OPT_STRING,
> +        },{
> +            .name =3D "fdset",
> +            .type =3D QEMU_OPT_STRING,
>          },{
>              .name =3D "localaddr",
>              .type =3D QEMU_OPT_STRING,
> diff --git a/monitor.c b/monitor.c
> index d682eee2d8..c7df558535 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1962,6 +1962,11 @@ int monitor_get_fd(Monitor *mon, const char *fdnam=
e, Error **errp)
>  {
>      mon_fd_t *monfd;
>
> +    if (mon =3D=3D NULL) {
> +        error_setg(errp, "No monitor is available to acquire FD");
> +        return -1;
> +    }
> +
>      QLIST_FOREACH(monfd, &mon->fds, next) {
>          int fd;
>
> diff --git a/qapi/common.json b/qapi/common.json
> index 6eb01821ef..a15cdc36e9 100644
> --- a/qapi/common.json
> +++ b/qapi/common.json
> @@ -74,6 +74,17 @@
>  { 'enum': 'OnOffSplit',
>    'data': [ 'on', 'off', 'split' ] }
>
> +##
> +# @Int:
> +#
> +# A fat type wrapping 'int', to be embedded in lists.
> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'Int',
> +  'data': {
> +    'i': 'int' } }
> +
>  ##
>  # @String:
>  #
> diff --git a/qapi/sockets.json b/qapi/sockets.json
> index ac022c6ad0..f3cac02166 100644
> --- a/qapi/sockets.json
> +++ b/qapi/sockets.json
> @@ -112,7 +112,8 @@
>      'inet': 'InetSocketAddress',
>      'unix': 'UnixSocketAddress',
>      'vsock': 'VsockSocketAddress',
> -    'fd': 'String' } }
> +    'fd': 'String',
> +    'fdset': 'Int' } }
>
>  ##
>  # @SocketAddressType:
> @@ -123,10 +124,16 @@
>  #
>  # @unix:  Unix domain socket
>  #
> +# @vsock: VSOCK socket
> +#
> +# @fd: socket file descriptor passed over monitor
> +#
> +# @fdset: socket file descriptor passed via CLI (since 2.12)
> +#
>  # Since: 2.9
>  ##
>  { 'enum': 'SocketAddressType',
> -  'data': [ 'inet', 'unix', 'vsock', 'fd' ] }
> +  'data': [ 'inet', 'unix', 'vsock', 'fd', 'fdset' ] }
>
>  ##
>  # @SocketAddress:
> @@ -144,4 +151,5 @@
>    'data': { 'inet': 'InetSocketAddress',
>              'unix': 'UnixSocketAddress',
>              'vsock': 'VsockSocketAddress',
> -            'fd': 'String' } }
> +            'fd': 'String',
> +            'fdset': 'Int' } }
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 1d23f0b742..d623a9840c 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -1049,6 +1049,22 @@ int socket_connect(SocketAddress *addr, Error **er=
rp)
>          fd =3D monitor_get_fd(cur_mon, addr->u.fd.str, errp);
>          break;
>
> +    case SOCKET_ADDRESS_TYPE_FDSET:
> +        fd =3D monitor_fdset_get_fd(addr->u.fdset.i, O_RDWR);
> +        if (fd < 0) {
> +            error_setg_errno(errp, errno,
> +                             "Unable to get FD from fdset %" PRId64,
> +                             addr->u.fdset.i);
> +            return -1;
> +        }
> +        if (!fd_is_socket(fd)) {
> +            error_setg(errp, "Expected a socket FD from fdset %" PRId64,
> +                       addr->u.fdset.i);
> +            close(fd);
> +            return -1;
> +        }
> +        break;
> +
>      case SOCKET_ADDRESS_TYPE_VSOCK:
>          fd =3D vsock_connect_saddr(&addr->u.vsock, errp);
>          break;
> @@ -1076,6 +1092,22 @@ int socket_listen(SocketAddress *addr, Error **err=
p)
>          fd =3D monitor_get_fd(cur_mon, addr->u.fd.str, errp);
>          break;
>
> +    case SOCKET_ADDRESS_TYPE_FDSET:
> +        fd =3D monitor_fdset_get_fd(addr->u.fdset.i, O_RDWR);
> +        if (fd < 0) {
> +            error_setg_errno(errp, errno,
> +                             "Unable to get FD from fdset %" PRId64,
> +                             addr->u.fdset.i);
> +            return -1;
> +        }
> +        if (!fd_is_socket(fd)) {
> +            error_setg(errp, "Expected a socket FD from fdset %" PRId64,
> +                       addr->u.fdset.i);
> +            close(fd);
> +            return -1;
> +        }
> +        break;
> +
>      case SOCKET_ADDRESS_TYPE_VSOCK:
>          fd =3D vsock_listen_saddr(&addr->u.vsock, errp);
>          break;
> @@ -1293,6 +1325,10 @@ SocketAddress *socket_address_flatten(SocketAddres=
sLegacy *addr_legacy)
>          addr->type =3D SOCKET_ADDRESS_TYPE_FD;
>          QAPI_CLONE_MEMBERS(String, &addr->u.fd, addr_legacy->u.fd.data);
>          break;
> +    case SOCKET_ADDRESS_LEGACY_KIND_FDSET:
> +        addr->type =3D SOCKET_ADDRESS_TYPE_FDSET;
> +        QAPI_CLONE_MEMBERS(Int, &addr->u.fdset, addr_legacy->u.fdset.dat=
a);
> +        break;
>      default:
>          abort();
>      }
> --
> 2.14.3
>
>

Looks fine, I would prefer the patch to be split, and some tests
added, please :)

thanks

--=20
Marc-Andr=C3=A9 Lureau
