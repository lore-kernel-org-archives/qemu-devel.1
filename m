Received: from eggs.gnu.org ([2001:4830:134:3::10]:42364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <GM.Ijewski@web.de>) id 1d2cwU-0007DP-5b
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:18:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <GM.Ijewski@web.de>) id 1d2cwP-0007hX-8b
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:18:10 -0400
Received: from mout.web.de ([212.227.15.4]:50978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <GM.Ijewski@web.de>) id 1d2cwO-0007hA-Tt
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:18:05 -0400
Message-ID: <trinity-b0e235ed-b74e-40f5-b249-c73867fd5ee9-1493036276162@3capp-webde-bs07>
From: GM.Ijewski@web.de
Date: Mon, 24 Apr 2017 14:17:56 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] error: qcrypto_random_bytes() tried to read from
 /dev/[u]random, even on windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com, qemu-devel@nongnu.org

   Now it calls CryptGenRandom() if is it compiled for windows.

   It might be possible to save the cryptographic provider in between
   invocations, e.g. by making it static -- I have no idea how
   computationally
   intensive that operation actually is.

   Signed-off-by: Geert Martin Ijewski <gm.ijewski@web.de>

   diff --git a/crypto/random-platform.c b/crypto/random-platform.c
   index 82b755a..7aa0476 100644
   --- a/crypto/random-platform.c
   +++ b/crypto/random-platform.c
   @@ -26,6 +26,7 @@ int qcrypto_random_bytes(uint8_t *buf G_GNUC_UNUSED,
                             size_t buflen G_GNUC_UNUSED,
                             Error **errp)
    {
   +#ifndef _WIN32
        int fd;
        int ret = -1;
        int got;
   @@ -61,4 +62,26 @@ int qcrypto_random_bytes(uint8_t *buf G_GNUC_UNUSED,
     cleanup:
        close(fd);
        return ret;
   +#else
   +    HCRYPTPROV   hCryptProv;
   +
   +    if (!CryptAcquireContext(&hCryptProv, NULL, NULL, PROV_RSA_FULL,
   0)) {
   +        if (NTE_BAD_KEYSET == GetLastError()) {
   +            if (!CryptAcquireContext(&hCryptProv, NULL, NULL,
   +                                     PROV_RSA_FULL, CRYPT_NEWKEYSET))
   {
   +                error_setg_errno(errp, GetLastError(),
   +                         "Unable to create cryptographic provider");
   +            }
   +        }
   +    }
   +
   +    if (!CryptGenRandom(hCryptProv, buflen, buf)) {
   +        error_setg_errno(errp, GetLastError(),
   +                         "Unable to read random bytes");
   +        return -1;
   +    }
   +
   +    CryptReleaseContext(hCryptProv, 0);
   +    return 0;
   +#endif
    }
   diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
   index ff18b23..4a5d908 100644
   --- a/include/sysemu/os-win32.h
   +++ b/include/sysemu/os-win32.h
   @@ -29,6 +29,7 @@
    #include <winsock2.h>
    #include <windows.h>
    #include <ws2tcpip.h>
   +#include <Wincrypt.h>

    #if defined(_WIN64)
    /* On w64, setjmp is implemented by _setjmp which needs a second
   parameter.
