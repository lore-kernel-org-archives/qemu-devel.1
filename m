Received: from eggs.gnu.org ([209.51.188.92]:48313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMER6-0001ss-F8
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:20:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMEQu-0006DG-7u
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:19:51 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:34349)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hMEQt-0005Rt-Pv
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:19:40 -0400
References: <20190412121626.19829-1-berrange@redhat.com>
	<20190412121626.19829-4-berrange@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <819471a3-44de-91d8-d21e-887769d6e3a3@vivier.eu>
Date: Thu, 2 May 2019 18:18:33 +0200
MIME-Version: 1.0
In-Reply-To: <20190412121626.19829-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/5] sockets: avoid string truncation
 warnings when copying UNIX path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Gerd Hoffmann <kraxel@redhat.com>

On 12/04/2019 14:16, Daniel P. Berrangé wrote:
> In file included from /usr/include/string.h:494,
>                  from include/qemu/osdep.h:101,
>                  from util/qemu-sockets.c:18:
> In function ‘strncpy’,
>     inlined from ‘unix_connect_saddr.isra.0’ at util/qemu-sockets.c:925:5:
> /usr/include/bits/string_fortified.h:106:10: warning: ‘__builtin_strncpy’ specified bound 108 equals destination size [-Wstringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In function ‘strncpy’,
>     inlined from ‘unix_listen_saddr.isra.0’ at util/qemu-sockets.c:880:5:
> /usr/include/bits/string_fortified.h:106:10: warning: ‘__builtin_strncpy’ specified bound 108 equals destination size [-Wstringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> We are already validating the UNIX socket path length earlier in
> the functions. If we save this string length when we first check
> it, then we can simply use memcpy instead of strcpy later, avoiding
> the gcc truncation warnings.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  util/qemu-sockets.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 9705051690..ba6335e71a 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -830,6 +830,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
>      int sock, fd;
>      char *pathbuf = NULL;
>      const char *path;
> +    size_t pathlen;
>  
>      sock = qemu_socket(PF_UNIX, SOCK_STREAM, 0);
>      if (sock < 0) {
> @@ -845,7 +846,8 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
>          path = pathbuf = g_strdup_printf("%s/qemu-socket-XXXXXX", tmpdir);
>      }
>  
> -    if (strlen(path) > sizeof(un.sun_path)) {
> +    pathlen = strlen(path);
> +    if (pathlen > sizeof(un.sun_path)) {
>          error_setg(errp, "UNIX socket path '%s' is too long", path);
>          error_append_hint(errp, "Path must be less than %zu bytes\n",
>                            sizeof(un.sun_path));
> @@ -877,7 +879,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
>  
>      memset(&un, 0, sizeof(un));
>      un.sun_family = AF_UNIX;
> -    strncpy(un.sun_path, path, sizeof(un.sun_path));
> +    memcpy(un.sun_path, path, pathlen);
>  
>      if (bind(sock, (struct sockaddr*) &un, sizeof(un)) < 0) {
>          error_setg_errno(errp, errno, "Failed to bind socket to %s", path);
> @@ -901,6 +903,7 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
>  {
>      struct sockaddr_un un;
>      int sock, rc;
> +    size_t pathlen;
>  
>      if (saddr->path == NULL) {
>          error_setg(errp, "unix connect: no path specified");
> @@ -913,7 +916,8 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
>          return -1;
>      }
>  
> -    if (strlen(saddr->path) > sizeof(un.sun_path)) {
> +    pathlen = strlen(saddr->path);
> +    if (pathlen > sizeof(un.sun_path)) {
>          error_setg(errp, "UNIX socket path '%s' is too long", saddr->path);
>          error_append_hint(errp, "Path must be less than %zu bytes\n",
>                            sizeof(un.sun_path));
> @@ -922,7 +926,7 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
>  
>      memset(&un, 0, sizeof(un));
>      un.sun_family = AF_UNIX;
> -    strncpy(un.sun_path, saddr->path, sizeof(un.sun_path));
> +    memcpy(un.sun_path, saddr->path, pathlen);
>  
>      /* connect to peer */
>      do {
> 


Applied to my trivial-patches branch.

Thanks,
Laurent
