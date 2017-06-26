Received: from eggs.gnu.org ([2001:4830:134:3::10]:38327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPR7X-0007JF-3k
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPR7T-0004ti-VR
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:19:51 -0400
References: <20170626101159.19676-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c4381bd8-a417-0c3b-f3c2-1292ca9f6dfc@redhat.com>
Date: Mon, 26 Jun 2017 12:19:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170626101159.19676-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] sockets: avoid formatting buffer that may
 not be NULL terminated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 26.06.2017 12:11, Daniel P. Berrange wrote:
> The 'sun_path' field in the sockaddr_un struct is not required
> to be NULL termianted, so when reporting an error, we must use

s/NULL/NUL/

NULL is a pointer, NUL is the '\0' character.

> the separate 'path' variable which is guaranteed terminated.
> 
> Fixes a bug spotted by coverity that was introduced in
> 
>   commit ad9579aaa16d5b385922d49edac2c96c79bcfb62
>   Author: Daniel P. Berrange <berrange@redhat.com>
>   Date:   Thu May 25 16:53:00 2017 +0100
> 
>     sockets: improve error reporting if UNIX socket path is too long
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  util/qemu-sockets.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 51bf279..37d386f 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -930,7 +930,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
>      strncpy(un.sun_path, path, sizeof(un.sun_path));
>  
>      if (bind(sock, (struct sockaddr*) &un, sizeof(un)) < 0) {
> -        error_setg_errno(errp, errno, "Failed to bind socket to %s", un.sun_path);
> +        error_setg_errno(errp, errno, "Failed to bind socket to %s", path);
>          goto err;
>      }
>      if (listen(sock, 1) < 0) {

Apart from the nit in the comment, the patch looks right to me:

Reviewed-by: Thomas Huth <thuth@redhat.com>
