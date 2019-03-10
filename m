Received: from eggs.gnu.org ([209.51.188.92]:42538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1h2wNV-0003AI-Ap
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 07:12:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1h2wNT-0003Jh-OP
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 07:12:25 -0400
Received: from mout.gmx.net ([212.227.17.22]:60527)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1h2wNT-0003HG-El
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 07:12:23 -0400
Date: Sun, 10 Mar 2019 12:12:16 +0100
From: Helge Deller <deller@gmx.de>
Message-ID: <20190310111216.GA5578@ls3530.dellerweb.de>
References: <20190227191556.GA20198@ls3530.dellerweb.de>
	<e6a8123c-20f9-8cc4-594f-8db02c3607cc@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6a8123c-20f9-8cc4-594f-8db02c3607cc@vivier.eu>
Subject: [Qemu-devel] [PATCH v2] linux-user: Add missing IPV6 sockopts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>

When running ssh over IPv6 with linux-user I faced this warning:
 Unsupported setsockopt level=41 optname=67
 setsockopt IPV6_TCLASS 32: Protocol not available:

This patch adds code to the linux-user emulatation for setting and
retrieving of a few missing IPV6 options, including IPV6_TCLASS.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 208fd1813d..0da51b1208 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1871,6 +1874,20 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
         case IPV6_RECVHOPLIMIT:
         case IPV6_2292HOPLIMIT:
         case IPV6_CHECKSUM:
+        case IPV6_ADDRFORM:
+        case IPV6_2292PKTINFO:
+        case IPV6_RECVTCLASS:
+        case IPV6_RECVRTHDR:
+        case IPV6_2292RTHDR:
+        case IPV6_RECVHOPOPTS:
+        case IPV6_2292HOPOPTS:
+        case IPV6_RECVDSTOPTS:
+        case IPV6_2292DSTOPTS:
+        case IPV6_TCLASS:
+        case IPV6_RECVPATHMTU:
+        case IPV6_TRANSPARENT:
+        case IPV6_FREEBIND:
+        case IPV6_RECVORIGDSTADDR:
             val = 0;
             if (optlen < sizeof(uint32_t)) {
                 return -TARGET_EINVAL;
@@ -2365,6 +2382,20 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
         case IPV6_RECVHOPLIMIT:
         case IPV6_2292HOPLIMIT:
         case IPV6_CHECKSUM:
+        case IPV6_ADDRFORM:
+        case IPV6_2292PKTINFO:
+        case IPV6_RECVTCLASS:
+        case IPV6_RECVRTHDR:
+        case IPV6_2292RTHDR:
+        case IPV6_RECVHOPOPTS:
+        case IPV6_2292HOPOPTS:
+        case IPV6_RECVDSTOPTS:
+        case IPV6_2292DSTOPTS:
+        case IPV6_TCLASS:
+        case IPV6_RECVPATHMTU:
+        case IPV6_TRANSPARENT:
+        case IPV6_FREEBIND:
+        case IPV6_RECVORIGDSTADDR:
             if (get_user_u32(len, optlen))
                 return -TARGET_EFAULT;
             if (len < 0)
