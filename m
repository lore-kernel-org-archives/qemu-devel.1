Received: from eggs.gnu.org ([209.51.188.92]:50596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1gz4gd-0007q5-NK
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 14:16:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1gz4gb-0003bc-R1
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 14:16:11 -0500
Received: from mout.gmx.net ([212.227.15.15]:39775)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1gz4gZ-0003UP-PA
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 14:16:09 -0500
Date: Wed, 27 Feb 2019 20:15:56 +0100
From: Helge Deller <deller@gmx.de>
Message-ID: <20190227191556.GA20198@ls3530.dellerweb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] linux-user: Add missing IPV6 sockopts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>

When running ssh over IPv6 with linux-user I faced this warning:
 Unsupported setsockopt level=41 optname=67
 setsockopt IPV6_TCLASS 32: Protocol not available:

This patch adds a few missing IPV6 options, including IPV6_TCLASS.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5bbb72f3d5..08efbf14b6 100644
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
