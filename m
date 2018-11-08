Received: from eggs.gnu.org ([2001:4830:134:3::10]:33383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1gKfF2-0001TZ-RM
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 03:00:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1gKfEv-00028L-E3
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 03:00:37 -0500
Received: from mail.weilnetz.de ([37.120.169.71]:33978
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1gKfEu-0001lc-OA
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 03:00:33 -0500
References: <1540498768-8736-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540498768-8736-4-git-send-email-aleksandar.markovic@rt-rk.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <03cea7f3-cbb7-6e4d-3104-01aba47cde09@weilnetz.de>
Date: Thu, 8 Nov 2018 09:00:02 +0100
MIME-Version: 1.0
In-Reply-To: <1540498768-8736-4-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 3/3] target/mips: Add disassembler support
 for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

On 25.10.18 22:19, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>=20
> Add disassembler support for nanoMIPS.
>=20
> Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
> Signed-off-by: Matthew Fortune <matthew.fortune@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  MAINTAINERS           |     2 +
>  configure             |     3 +
>  disas/Makefile.objs   |     1 +
>  disas/nanomips.cpp    | 22242 ++++++++++++++++++++++++++++++++++++++++=
++++++++
>  disas/nanomips.h      |  1099 +++
>  include/disas/bfd.h   |     1 +
>  include/exec/poison.h |     1 +
>  target/mips/cpu.c     |    13 +-
>  8 files changed, 23360 insertions(+), 2 deletions(-)
>  create mode 100644 disas/nanomips.cpp
>  create mode 100644 disas/nanomips.h


Hi,

the disassembler needs more work for the next QEMU release: it uses lots
of wrong format strings which will result in wrong output at least on
big endian hosts.

This patch enables the compiler errors to see those bugs:

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 1238c2ff33..62be5b6d00 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -138,7 +138,7 @@ namespace img
         return a;
     }

-    std::string format(const char *format, ...)
+    std::string GCC_FMT_ATTR(1, 2) format(const char *format, ...)
     {
         char buffer[256];
         va_list args;

I also noticed that the code does not use POSIX data types but
introduces its own integer types in disas/nanomips.h. This should be
fixed, too, because it prevents the use of PRIu64 etc. in the format
strings.

Regards
Stefan Weil
