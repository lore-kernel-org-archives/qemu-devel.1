Received: from eggs.gnu.org ([209.51.188.92]:52966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLZVb-0002L4-Ty
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLZDD-0002N3-Fw
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:18:48 -0400
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<81a342ee886cf0f63cdbfc8573b14dd2d41de42d.1556650594.git.alistair.francis@wdc.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <5f9283d7-aafd-1d6f-307d-c55c755709c1@vivier.eu>
Date: Tue, 30 Apr 2019 22:18:18 +0200
MIME-Version: 1.0
In-Reply-To: <81a342ee886cf0f63cdbfc8573b14dd2d41de42d.1556650594.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 1/5] util/qemu-sockets: Fix GCC 9 build
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "berrange@redhat.com" <berrange@redhat.com>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>, "kraxel@redhat.com" <kraxel@redhat.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>

Le 30/04/2019 à 22:08, Alistair Francis a écrit :
> Fix this warning when building with GCC9 on Fedora 30:
> In function ‘strncpy’,
>     inlined from ‘unix_connect_saddr.isra.0’ at util/qemu-sockets.c:925:5:
> /usr/include/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ specified bound 108 equals destination size [-Werror=stringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In function ‘strncpy’,
>     inlined from ‘unix_listen_saddr.isra.0’ at util/qemu-sockets.c:880:5:
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  util/qemu-sockets.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 9705051690..4322652428 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -877,7 +877,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
>  
>      memset(&un, 0, sizeof(un));
>      un.sun_family = AF_UNIX;
> -    strncpy(un.sun_path, path, sizeof(un.sun_path));
> +    strncpy(un.sun_path, path, sizeof(un.sun_path) - 1);
>  
>      if (bind(sock, (struct sockaddr*) &un, sizeof(un)) < 0) {
>          error_setg_errno(errp, errno, "Failed to bind socket to %s", path);
> @@ -922,7 +922,7 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
>  
>      memset(&un, 0, sizeof(un));
>      un.sun_family = AF_UNIX;
> -    strncpy(un.sun_path, saddr->path, sizeof(un.sun_path));
> +    strncpy(un.sun_path, saddr->path, sizeof(un.sun_path) - 1);
>  
>      /* connect to peer */
>      do {
> 

Your change reverts partially:

commit ad9579aaa16d5b385922d49edac2c96c79bcfb62
Author: Daniel P. Berrange <berrange@redhat.com>
Date:   Thu May 25 16:53:00 2017 +0100

    sockets: improve error reporting if UNIX socket path is too long

    The 'struct sockaddr_un' only allows 108 bytes for the socket
    path.

    If the user supplies a path, QEMU uses snprintf() to silently
    truncate it when too long. This is undesirable because the user
    will then be unable to connect to the path they asked for.

    If the user doesn't supply a path, QEMU builds one based on
    TMPDIR, but if that leads to an overlong path, it mistakenly
    uses error_setg_errno() with a stale errno value, because
    snprintf() does not set errno on truncation.

    In solving this the code needed some refactoring to ensure we
    don't pass 'un.sun_path' directly to any APIs which expect
    NUL-terminated strings, because the path is not required to
    be terminated.

    Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
    Message-Id: <20170525155300.22743-1-berrange@redhat.com>
    Reviewed-by: Eric Blake <eblake@redhat.com>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks,
Laurent
