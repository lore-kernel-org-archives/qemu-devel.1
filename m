Received: from eggs.gnu.org ([2001:4830:134:3::10]:59937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evRWz-00067n-Ex
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evRWx-0006Fs-VI
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:46:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58442 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evRWx-0006Fi-P5
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:46:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F18A4023155
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 17:46:28 +0000 (UTC)
Date: Mon, 12 Mar 2018 17:46:21 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180312174621.GA14096@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180312124939.20562-1-berrange@redhat.com>
	<20180312124939.20562-4-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180312124939.20562-4-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 3/9] sockets: pull code for testing IP
 availability out of specific test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Mon, Mar 12, 2018 at 12:49:33PM +0000, Daniel P. Berrang=C3=A9 wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>
>=20
> The test-io-channel-socket.c file has some useful helper functions for
> checking if a specific IP protocol is available. Other tests need to
> perform similar kinds of checks to avoid running tests that will fail
> due to missing IP protocols.
>=20
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/Makefile.include         |   2 +-
>  tests/socket-helpers.c         | 104 +++++++++++++++++++++++++++++++++=
++++++++
>  tests/socket-helpers.h         |  42 +++++++++++++++++
>  tests/test-io-channel-socket.c |  72 +---------------------------
>  4 files changed, 149 insertions(+), 71 deletions(-)
>  create mode 100644 tests/socket-helpers.c
>  create mode 100644 tests/socket-helpers.h
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index ef9b88c369..3d5b6174a8 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -715,7 +715,7 @@ tests/test-crypto-tlssession$(EXESUF): tests/test-c=
rypto-tlssession.o \
>  	tests/crypto-tls-x509-helpers.o tests/pkix_asn1_tab.o $(test-crypto-o=
bj-y)
>  tests/test-io-task$(EXESUF): tests/test-io-task.o $(test-io-obj-y)
>  tests/test-io-channel-socket$(EXESUF): tests/test-io-channel-socket.o =
\
> -        tests/io-channel-helpers.o $(test-io-obj-y)
> +        tests/io-channel-helpers.o tests/socket-helpers.o $(test-io-ob=
j-y)
>  tests/tpm-crb-test$(EXESUF): tests/tpm-crb-test.o tests/tpm-emu.o $(te=
st-io-obj-y)
>  tests/tpm-tis-test$(EXESUF): tests/tpm-tis-test.o tests/tpm-emu.o $(te=
st-io-obj-y)
>  tests/test-io-channel-file$(EXESUF): tests/test-io-channel-file.o \
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
> + * along with this program; if not, see <http://www.gnu.org/licenses/>=
.
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
> +    fd =3D qemu_socket(res->ai_family, res->ai_socktype, res->ai_proto=
col);
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

Sigh, I should have kept the new code identical to the old code,
rather than trying to improve it, as this is in fact broken. The
socket_can_bind() is mistakenly returning '0' when EADDRNOTAVAIL
is set, so we always set the has_ipv4|6 vars to true.

It needs this squashed in:

@@ -48,9 +48,9 @@ int socket_can_bind(const char *hostname)
         if (rc =3D=3D EAI_ADDRFAMILY ||
             rc =3D=3D EAI_FAMILY) {
             errno =3D EADDRNOTAVAIL;
-            goto done;
+        } else {
+            errno =3D EINVAL;
         }
-        errno =3D EINVAL;
         goto cleanup;
     }
=20
@@ -60,13 +60,9 @@ int socket_can_bind(const char *hostname)
     }
=20
     if (bind(fd, res->ai_addr, res->ai_addrlen) < 0) {
-        if (errno =3D=3D EADDRNOTAVAIL) {
-            goto done;
-        }
         goto cleanup;
     }
=20
- done:
     ret =3D 0;
=20
  cleanup:



Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
