Received: from eggs.gnu.org ([2001:4830:134:3::10]:38100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eSO1j-0007lw-1q
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 09:10:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eSO1h-0000M2-4j
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 09:10:18 -0500
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:45862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eSO1g-0000Jw-A9
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 09:10:17 -0500
Received: by mail-wr0-x232.google.com with SMTP id h1so27991754wre.12
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 06:10:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171222134527.14467-4-berrange@redhat.com>
References: <20171222134527.14467-1-berrange@redhat.com>
	<20171222134527.14467-4-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 22 Dec 2017 15:10:14 +0100
Message-ID: <CAJ+F1CLbLpz9HRyvEvXaZ0or0kupZ2Eg71V3spZKnzZmkd0Kmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/8] sockets: pull code for testing IP
 availability out of specific test
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
> The test-io-channel-socket.c file has some useful helper functions for
> checking if a specific IP protocol is available. Other tests need to
> perform similar kinds of checks to avoid running tests that will fail
> due to missing IP protocols.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tests/Makefile.include         |   2 +-
>  tests/socket-helpers.c         | 104 +++++++++++++++++++++++++++++++++++=
++++++
>  tests/socket-helpers.h         |  42 +++++++++++++++++
>  tests/test-io-channel-socket.c |  72 +---------------------------
>  4 files changed, 149 insertions(+), 71 deletions(-)
>  create mode 100644 tests/socket-helpers.c
>  create mode 100644 tests/socket-helpers.h
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index f8e20d9f5d..bede832dc1 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -696,7 +696,7 @@ tests/test-crypto-tlssession$(EXESUF): tests/test-cry=
pto-tlssession.o \
>         tests/crypto-tls-x509-helpers.o tests/pkix_asn1_tab.o $(test-cryp=
to-obj-y)
>  tests/test-io-task$(EXESUF): tests/test-io-task.o $(test-io-obj-y)
>  tests/test-io-channel-socket$(EXESUF): tests/test-io-channel-socket.o \
> -        tests/io-channel-helpers.o $(test-io-obj-y)
> +        tests/io-channel-helpers.o tests/socket-helpers.o $(test-io-obj-=
y)
>  tests/test-io-channel-file$(EXESUF): tests/test-io-channel-file.o \
>          tests/io-channel-helpers.o $(test-io-obj-y)
>  tests/test-io-channel-tls$(EXESUF): tests/test-io-channel-tls.o \
> diff --git a/tests/socket-helpers.c b/tests/socket-helpers.c
> new file mode 100644
> index 0000000000..13b6bb38eb
> --- /dev/null
> +++ b/tests/socket-helpers.c
> @@ -0,0 +1,104 @@
> +/*
> + * Helper functions for tests using sockets
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
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "qemu/sockets.h"
> +#include "socket-helpers.h"
> +
> +#ifndef AI_ADDRCONFIG
> +# define AI_ADDRCONFIG 0
> +#endif
> +#ifndef EAI_ADDRFAMILY
> +# define EAI_ADDRFAMILY 0
> +#endif
> +
> +int socket_can_bind(const char *hostname)
> +{
> +    int fd =3D -1;
> +    struct addrinfo ai, *res =3D NULL;
> +    int rc;
> +    int ret =3D -1;
> +
> +    memset(&ai, 0, sizeof(ai));
> +    ai.ai_flags =3D AI_CANONNAME | AI_ADDRCONFIG;
> +    ai.ai_family =3D AF_UNSPEC;
> +    ai.ai_socktype =3D SOCK_STREAM;
> +
> +    /* lookup */
> +    rc =3D getaddrinfo(hostname, NULL, &ai, &res);
> +    if (rc !=3D 0) {
> +        if (rc =3D=3D EAI_ADDRFAMILY ||
> +            rc =3D=3D EAI_FAMILY) {
> +            errno =3D EADDRNOTAVAIL;
> +            goto done;
> +        }
> +        errno =3D EINVAL;
> +        goto cleanup;
> +    }
> +
> +    fd =3D qemu_socket(res->ai_family, res->ai_socktype, res->ai_protoco=
l);
> +    if (fd < 0) {
> +        goto cleanup;
> +    }
> +
> +    if (bind(fd, res->ai_addr, res->ai_addrlen) < 0) {
> +        if (errno =3D=3D EADDRNOTAVAIL) {
> +            goto done;
> +        }
> +        goto cleanup;
> +    }
> +
> + done:
> +    ret =3D 0;
> +
> + cleanup:
> +    if (fd !=3D -1) {
> +        close(fd);
> +    }
> +    if (res) {
> +        freeaddrinfo(res);
> +    }
> +    return ret;
> +}
> +
> +
> +int socket_check_protocol_support(bool *has_ipv4, bool *has_ipv6)
> +{
> +    *has_ipv4 =3D *has_ipv6 =3D false;
> +
> +    if (socket_can_bind("127.0.0.1") < 0) {
> +        if (errno !=3D EADDRNOTAVAIL) {
> +            return -1;
> +        }
> +    } else {
> +        *has_ipv4 =3D true;
> +    }
> +
> +    if (socket_can_bind("::1") < 0) {
> +        if (errno !=3D EADDRNOTAVAIL) {
> +            return -1;
> +        }
> +    } else {
> +        *has_ipv6 =3D true;
> +    }
> +
> +    return 0;
> +}
> diff --git a/tests/socket-helpers.h b/tests/socket-helpers.h
> new file mode 100644
> index 0000000000..efa96eddc2
> --- /dev/null
> +++ b/tests/socket-helpers.h
> @@ -0,0 +1,42 @@
> +/*
> + * Helper functions for tests using sockets
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
> +/*
> + * @hostname: a DNS name or numeric IP address
> + *
> + * Check whether it is possible to bind to ports
> + * on the DNS name or IP address @hostname. If an IP address
> + * is used, it must not be a wildcard address.
> + *
> + * Returns 0 on success, -1 on error with errno set
> + */
> +int socket_can_bind(const char *hostname);
> +
> +/*
> + * @has_ipv4: set to true on return if IPv4 is available
> + * @has_ipv6: set to true on return if IPv6 is available
> + *
> + * Check whether IPv4 and/or IPv6 are available for use.
> + * On success, @has_ipv4 and @has_ipv6 will be set to
> + * indicate whether the respective protocols are available.
> + *
> + * Returns 0 on success, -1 on fatal error
> + */
> +int socket_check_protocol_support(bool *has_ipv4, bool *has_ipv6);
> diff --git a/tests/test-io-channel-socket.c b/tests/test-io-channel-socke=
t.c
> index d357cd2a8e..b0b69e8ad0 100644
> --- a/tests/test-io-channel-socket.c
> +++ b/tests/test-io-channel-socket.c
> @@ -22,77 +22,9 @@
>  #include "io/channel-socket.h"
>  #include "io/channel-util.h"
>  #include "io-channel-helpers.h"
> +#include "socket-helpers.h"
>  #include "qapi/error.h"
>
> -#ifndef AI_ADDRCONFIG
> -# define AI_ADDRCONFIG 0
> -#endif
> -#ifndef EAI_ADDRFAMILY
> -# define EAI_ADDRFAMILY 0
> -#endif
> -
> -static int check_bind(const char *hostname, bool *has_proto)
> -{
> -    int fd =3D -1;
> -    struct addrinfo ai, *res =3D NULL;
> -    int rc;
> -    int ret =3D -1;
> -
> -    memset(&ai, 0, sizeof(ai));
> -    ai.ai_flags =3D AI_CANONNAME | AI_ADDRCONFIG;
> -    ai.ai_family =3D AF_UNSPEC;
> -    ai.ai_socktype =3D SOCK_STREAM;
> -
> -    /* lookup */
> -    rc =3D getaddrinfo(hostname, NULL, &ai, &res);
> -    if (rc !=3D 0) {
> -        if (rc =3D=3D EAI_ADDRFAMILY ||
> -            rc =3D=3D EAI_FAMILY) {
> -            *has_proto =3D false;
> -            goto done;
> -        }
> -        goto cleanup;
> -    }
> -
> -    fd =3D qemu_socket(res->ai_family, res->ai_socktype, res->ai_protoco=
l);
> -    if (fd < 0) {
> -        goto cleanup;
> -    }
> -
> -    if (bind(fd, res->ai_addr, res->ai_addrlen) < 0) {
> -        if (errno =3D=3D EADDRNOTAVAIL) {
> -            *has_proto =3D false;
> -            goto done;
> -        }
> -        goto cleanup;
> -    }
> -
> -    *has_proto =3D true;
> - done:
> -    ret =3D 0;
> -
> - cleanup:
> -    if (fd !=3D -1) {
> -        close(fd);
> -    }
> -    if (res) {
> -        freeaddrinfo(res);
> -    }
> -    return ret;
> -}
> -
> -static int check_protocol_support(bool *has_ipv4, bool *has_ipv6)
> -{
> -    if (check_bind("127.0.0.1", has_ipv4) < 0) {
> -        return -1;
> -    }
> -    if (check_bind("::1", has_ipv6) < 0) {
> -        return -1;
> -    }
> -
> -    return 0;
> -}
> -
>
>  static void test_io_channel_set_socket_bufs(QIOChannel *src,
>                                              QIOChannel *dst)
> @@ -566,7 +498,7 @@ int main(int argc, char **argv)
>       * each protocol to avoid breaking tests on machines
>       * with either IPv4 or IPv6 disabled.
>       */
> -    if (check_protocol_support(&has_ipv4, &has_ipv6) < 0) {
> +    if (socket_check_protocol_support(&has_ipv4, &has_ipv6) < 0) {
>          return 1;
>      }
>
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
