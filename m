Received: from eggs.gnu.org ([2001:4830:134:3::10]:52806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d2dRh-0007gy-VT
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:50:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d2dRe-0001To-RV
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:50:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d2dRe-0001Th-I6
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:50:22 -0400
Date: Mon, 24 Apr 2017 13:50:16 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170424125016.GM20809@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <trinity-b0e235ed-b74e-40f5-b249-c73867fd5ee9-1493036276162@3capp-webde-bs07>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <trinity-b0e235ed-b74e-40f5-b249-c73867fd5ee9-1493036276162@3capp-webde-bs07>
Subject: Re: [Qemu-devel] error: qcrypto_random_bytes() tried to read from
 /dev/[u]random, even on windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: GM.Ijewski@web.de
Cc: qemu-devel@nongnu.org

For subject line, better to describe the change made, rather than
the problem.

On Mon, Apr 24, 2017 at 02:17:56PM +0200, GM.Ijewski@web.de wrote:
> Now it calls CryptGenRandom() if is it compiled for windows.
>  
> It might be possible to save the cryptographic provider in between
> invocations, e.g. by making it static -- I have no idea how computationally
> intensive that operation actually is.

I'd think most people should really just enable gnutls during build. This just
has to provide a fallback that's good enough to be functional. If someone really
cares about performance of this fallback, they can send patches later....

>
> Signed-off-by: Geert Martin Ijewski <gm.ijewski@web.de>
>  
> diff --git a/crypto/random-platform.c b/crypto/random-platform.c
> index 82b755a..7aa0476 100644
> --- a/crypto/random-platform.c
> +++ b/crypto/random-platform.c
> @@ -26,6 +26,7 @@ int qcrypto_random_bytes(uint8_t *buf G_GNUC_UNUSED,
>                           size_t buflen G_GNUC_UNUSED,
>                           Error **errp)
>  {
> +#ifndef _WIN32
>      int fd;
>      int ret = -1;
>      int got;
> @@ -61,4 +62,26 @@ int qcrypto_random_bytes(uint8_t *buf G_GNUC_UNUSED,
>   cleanup:
>      close(fd);
>      return ret;
> +#else
> +    HCRYPTPROV   hCryptProv;
> +
> +    if (!CryptAcquireContext(&hCryptProv, NULL, NULL, PROV_RSA_FULL, 0)) {
> +        if (NTE_BAD_KEYSET == GetLastError()) {
> +            if (!CryptAcquireContext(&hCryptProv, NULL, NULL,
> +                                     PROV_RSA_FULL, CRYPT_NEWKEYSET)) {
> +                error_setg_errno(errp, GetLastError(),
> +                         "Unable to create cryptographic provider");

You forgot to "return -1' here

> +            }
> +        }

You need to have an 'else' branch here that reports an error too,
in cae the first CryptAcquireContext returns err != NTE_BSD_KEYSET.

> +    }
> +
> +    if (!CryptGenRandom(hCryptProv, buflen, buf)) {
> +        error_setg_errno(errp, GetLastError(),
> +                         "Unable to read random bytes");
> +        return -1;
> +    }
> +
> +    CryptReleaseContext(hCryptProv, 0);
> +    return 0;
> +#endif
>  }
> diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
> index ff18b23..4a5d908 100644
> --- a/include/sysemu/os-win32.h
> +++ b/include/sysemu/os-win32.h
> @@ -29,6 +29,7 @@
>  #include <winsock2.h>
>  #include <windows.h>
>  #include <ws2tcpip.h>
> +#include <Wincrypt.h>

It would be preferrable to put this in random-platform.c to avoid
polluting the global namespace

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
