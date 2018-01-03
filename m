Received: from eggs.gnu.org ([2001:4830:134:3::10]:60895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eWnpx-0001ZV-HW
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:32:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eWnpv-0005iP-Vg
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:32:25 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:40796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eWnpv-0005hY-LK
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:32:23 -0500
Received: by mail-wr0-x243.google.com with SMTP id p17so2500162wre.7
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 10:32:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171222134527.14467-6-berrange@redhat.com>
References: <20171222134527.14467-1-berrange@redhat.com>
	<20171222134527.14467-6-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 3 Jan 2018 19:32:21 +0100
Message-ID: <CAJ+F1CJ_8TBrxCLKLG8V2YDM_-vBz2g=Cw5Np-QT+haPuxdS0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 5/8] sockets: check that the named file
 descriptor is a socket
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

On Fri, Dec 22, 2017 at 2:45 PM, Daniel P. Berrange <berrange@redhat.com> w=
rote:
> The SocketAddress struct has an "fd" type, which references the name of a
> file descriptor passed over the monitor using the "getfd" command. We
> currently blindly assume the FD is a socket, which can lead to hard to
> diagnose errors later. This adds an explicit check that the FD is actuall=
y
> a socket to improve the error diagnosis.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/.gitignore       |   1 +
>  tests/Makefile.include |   3 ++
>  tests/test-sockets.c   | 139 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  util/qemu-sockets.c    |  18 ++++++-
>  4 files changed, 159 insertions(+), 2 deletions(-)
>  create mode 100644 tests/test-sockets.c
>
> diff --git a/tests/.gitignore b/tests/.gitignore
> index 74e55d7264..44be8c2c79 100644
> --- a/tests/.gitignore
> +++ b/tests/.gitignore
> @@ -80,6 +80,7 @@ test-qobject-output-visitor
>  test-rcu-list
>  test-replication
>  test-shift128
> +test-sockets
>  test-string-input-visitor
>  test-string-output-visitor
>  test-thread-pool
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index bede832dc1..2730f7562b 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -135,6 +135,7 @@ ifneq (,$(findstring qemu-ga,$(TOOLS)))
>  check-unit-$(CONFIG_LINUX) +=3D tests/test-qga$(EXESUF)
>  endif
>  check-unit-y +=3D tests/test-timed-average$(EXESUF)
> +check-unit-y +=3D tests/test-sockets$(EXESUF)
>  check-unit-y +=3D tests/test-io-task$(EXESUF)
>  check-unit-y +=3D tests/test-io-channel-socket$(EXESUF)
>  check-unit-y +=3D tests/test-io-channel-file$(EXESUF)
> @@ -694,6 +695,8 @@ tests/test-crypto-tlscredsx509$(EXESUF): tests/test-c=
rypto-tlscredsx509.o \
>  tests/test-crypto-tlssession.o-cflags :=3D $(TASN1_CFLAGS)
>  tests/test-crypto-tlssession$(EXESUF): tests/test-crypto-tlssession.o \
>         tests/crypto-tls-x509-helpers.o tests/pkix_asn1_tab.o $(test-cryp=
to-obj-y)
> +tests/test-sockets$(EXESUF): tests/test-sockets.o tests/socket-helpers.o=
 \
> +       $(test-util-obj-y)
>  tests/test-io-task$(EXESUF): tests/test-io-task.o $(test-io-obj-y)
>  tests/test-io-channel-socket$(EXESUF): tests/test-io-channel-socket.o \
>          tests/io-channel-helpers.o tests/socket-helpers.o $(test-io-obj-=
y)
> diff --git a/tests/test-sockets.c b/tests/test-sockets.c
> new file mode 100644
> index 0000000000..8a2962fe7b
> --- /dev/null
> +++ b/tests/test-sockets.c
> @@ -0,0 +1,139 @@
> +/*
> + * Test core sockets APIs
> + *
> + * Copyright 2015-2018 Red Hat, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 or
> + * (at your option) version 3 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + *
> + */
> +
> +
> +#include "qemu/osdep.h"
> +#include "qemu/sockets.h"
> +#include "socket-helpers.h"
> +#include "qapi/error.h"
> +#include "monitor/monitor.h"
> +
> +
> +static int mon_fd =3D -1;
> +static const char *mon_fdname;
> +
> +int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
> +{
> +    g_assert(cur_mon);
> +    g_assert(mon =3D=3D cur_mon);
> +    if (mon_fd =3D=3D -1 || !g_str_equal(mon_fdname, fdname)) {
> +        error_setg(errp, "No fd named %s", fdname);
> +        return -1;
> +    }
> +    return dup(mon_fd);
> +}
> +
> +/* Syms in libqemustub.a are discarded at .o file granularity.
> + * To replace monitor_get_fd() we must ensure everything in
> + * stubs/monitor.c is defined, to make sure monitor.o is discarded
> + * otherwise we get duplicate syms at link time.
> + */
> +Monitor *cur_mon;
> +void monitor_init(Chardev *chr, int flags) {}

The above is a bit of trick, but it works so:

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> +
> +
> +static void test_socket_fd_pass_good(void)
> +{
> +    SocketAddress addr;
> +    int fd;
> +
> +    cur_mon =3D g_malloc(1); /* Fake a monitor */
> +    mon_fdname =3D "myfd";
> +    mon_fd =3D qemu_socket(AF_INET, SOCK_STREAM, 0);
> +    g_assert_cmpint(mon_fd, >, STDERR_FILENO);
> +
> +    addr.type =3D SOCKET_ADDRESS_TYPE_FD;
> +    addr.u.fd.str =3D g_strdup(mon_fdname);
> +
> +    fd =3D socket_connect(&addr, &error_abort);
> +    g_assert_cmpint(fd, !=3D, -1);
> +    g_assert_cmpint(fd, !=3D, mon_fd);
> +    close(fd);
> +
> +    fd =3D socket_listen(&addr, &error_abort);
> +    g_assert_cmpint(fd, !=3D, -1);
> +    g_assert_cmpint(fd, !=3D, mon_fd);
> +    close(fd);
> +
> +    g_free(addr.u.fd.str);
> +    mon_fdname =3D NULL;
> +    close(mon_fd);
> +    mon_fd =3D -1;
> +    g_free(cur_mon);
> +    cur_mon =3D NULL;
> +}
> +
> +static void test_socket_fd_pass_bad(void)
> +{
> +    SocketAddress addr;
> +    Error *err =3D NULL;
> +    int fd;
> +
> +    cur_mon =3D g_malloc(1); /* Fake a monitor */
> +    mon_fdname =3D "myfd";
> +    mon_fd =3D dup(STDOUT_FILENO);
> +    g_assert_cmpint(mon_fd, >, STDERR_FILENO);
> +
> +    addr.type =3D SOCKET_ADDRESS_TYPE_FD;
> +    addr.u.fd.str =3D g_strdup(mon_fdname);
> +
> +    fd =3D socket_connect(&addr, &err);
> +    g_assert_cmpint(fd, =3D=3D, -1);
> +    error_free_or_abort(&err);
> +
> +    fd =3D socket_listen(&addr, &err);
> +    g_assert_cmpint(fd, =3D=3D, -1);
> +    error_free_or_abort(&err);
> +
> +    g_free(addr.u.fd.str);
> +    mon_fdname =3D NULL;
> +    close(mon_fd);
> +    mon_fd =3D -1;
> +    g_free(cur_mon);
> +    cur_mon =3D NULL;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    bool has_ipv4, has_ipv6;
> +
> +    module_call_init(MODULE_INIT_QOM);
> +    socket_init();
> +
> +    g_test_init(&argc, &argv, NULL);
> +
> +    /* We're creating actual IPv4/6 sockets, so we should
> +     * check if the host running tests actually supports
> +     * each protocol to avoid breaking tests on machines
> +     * with either IPv4 or IPv6 disabled.
> +     */
> +    if (socket_check_protocol_support(&has_ipv4, &has_ipv6) < 0) {
> +        return 1;
> +    }
> +
> +    if (has_ipv4) {
> +        g_test_add_func("/socket/fd-pass/good",
> +                        test_socket_fd_pass_good);
> +        g_test_add_func("/socket/fd-pass/bad",
> +                        test_socket_fd_pass_bad);
> +    }
> +
> +    return g_test_run();
> +}
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 5e42f6d88d..6a7b194428 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -1027,6 +1027,20 @@ fail:
>      return NULL;
>  }
>
> +static int socket_get_fd(const char *fdstr, Error **errp)
> +{
> +    int fd =3D monitor_get_fd(cur_mon, fdstr, errp);
> +    if (fd < 0) {
> +        return -1;
> +    }
> +    if (!fd_is_socket(fd)) {
> +        error_setg(errp, "File descriptor '%s' is not a socket", fdstr);
> +        close(fd);
> +        return -1;
> +    }
> +    return fd;
> +}
> +
>  int socket_connect(SocketAddress *addr, Error **errp)
>  {
>      int fd;
> @@ -1041,7 +1055,7 @@ int socket_connect(SocketAddress *addr, Error **err=
p)
>          break;
>
>      case SOCKET_ADDRESS_TYPE_FD:
> -        fd =3D monitor_get_fd(cur_mon, addr->u.fd.str, errp);
> +        fd =3D socket_get_fd(addr->u.fd.str, errp);
>          break;
>
>      case SOCKET_ADDRESS_TYPE_VSOCK:
> @@ -1068,7 +1082,7 @@ int socket_listen(SocketAddress *addr, Error **errp=
)
>          break;
>
>      case SOCKET_ADDRESS_TYPE_FD:
> -        fd =3D monitor_get_fd(cur_mon, addr->u.fd.str, errp);
> +        fd =3D socket_get_fd(addr->u.fd.str, errp);
>          break;
>
>      case SOCKET_ADDRESS_TYPE_VSOCK:
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
