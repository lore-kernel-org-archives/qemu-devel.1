Received: from eggs.gnu.org ([2001:4830:134:3::10]:38498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fM7vf-0001mi-3u
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fM7vY-0008Fm-KW
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:18:27 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:50317)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fM7vY-0008Ew-BZ
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:18:20 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 25 May 2018 10:17:48 +0200
Message-Id: <20180525081754.29506-8-laurent@vivier.eu>
In-Reply-To: <20180525081754.29506-1-laurent@vivier.eu>
References: <20180525081754.29506-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/13] linux-user: move sparc/sparc64 socket.h
 definitions to sparc/sockbits.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

No code change.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180519092956.15134-4-laurent@vivier.eu>
---
 linux-user/socket.h           | 44 +-------------------
 linux-user/sparc/sockbits.h   | 94 +++++++++++++++++++++++++++++++++++++++++++
 linux-user/sparc64/sockbits.h |  1 +
 3 files changed, 97 insertions(+), 42 deletions(-)
 create mode 100644 linux-user/sparc/sockbits.h
 create mode 100644 linux-user/sparc64/sockbits.h

diff --git a/linux-user/socket.h b/linux-user/socket.h
index 1328906205..8eb62ea3f2 100644
--- a/linux-user/socket.h
+++ b/linux-user/socket.h
@@ -1,49 +1,9 @@
 
-#if defined(TARGET_MIPS) || defined(TARGET_HPPA) || defined(TARGET_ALPHA)
+#if defined(TARGET_MIPS) || defined(TARGET_HPPA) || defined(TARGET_ALPHA) || \
+    defined(TARGET_SPARC)
 #include "sockbits.h"
-#else
-
-#if defined(TARGET_SPARC)
-    /** sock_type - Socket types
-     *
-     * Please notice that for binary compat reasons SPARC has to
-     * override the enum sock_type in include/linux/net.h, so
-     * we define ARCH_HAS_SOCKET_TYPES here.
-     *
-     * @SOCK_DGRAM - datagram (conn.less) socket
-     * @SOCK_STREAM - stream (connection) socket
-     * @SOCK_RAW - raw socket
-     * @SOCK_RDM - reliably-delivered message
-     * @SOCK_SEQPACKET - sequential packet socket
-     * @SOCK_DCCP - Datagram Congestion Control Protocol socket
-     * @SOCK_PACKET - linux specific way of getting packets at the dev level.
-     *                For writing rarp and other similar things on the user
-     *                level.
-     * @SOCK_CLOEXEC - sets the close-on-exec (FD_CLOEXEC) flag.
-     * @SOCK_NONBLOCK - sets the O_NONBLOCK file status flag.
-     */
-
-    #define ARCH_HAS_SOCKET_TYPES          1
-
-    enum sock_type {
-           TARGET_SOCK_STREAM      = 1,
-           TARGET_SOCK_DGRAM       = 2,
-           TARGET_SOCK_RAW         = 3,
-           TARGET_SOCK_RDM         = 4,
-           TARGET_SOCK_SEQPACKET   = 5,
-           TARGET_SOCK_DCCP        = 6,
-           TARGET_SOCK_PACKET      = 10,
-           TARGET_SOCK_CLOEXEC     = 020000000,
-           TARGET_SOCK_NONBLOCK    = 040000,
-    };
-
-    #define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
-    #define TARGET_SOCK_TYPE_MASK    0xf  /* Covers up to TARGET_SOCK_MAX-1. */
-
-    #define TARGET_SO_PASSSEC        31
 #else
     #define TARGET_SO_PASSSEC        34
-#endif
 
     /* For setsockopt(2) */
     #define TARGET_SOL_SOCKET      1
diff --git a/linux-user/sparc/sockbits.h b/linux-user/sparc/sockbits.h
new file mode 100644
index 0000000000..385061c8b0
--- /dev/null
+++ b/linux-user/sparc/sockbits.h
@@ -0,0 +1,94 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef SPARC_SOCKBITS_H
+#define SPARC_SOCKBITS_H
+
+/** sock_type - Socket types
+ *
+ * Please notice that for binary compat reasons SPARC has to
+ * override the enum sock_type in include/linux/net.h, so
+ * we define ARCH_HAS_SOCKET_TYPES here.
+ *
+ * @SOCK_DGRAM - datagram (conn.less) socket
+ * @SOCK_STREAM - stream (connection) socket
+ * @SOCK_RAW - raw socket
+ * @SOCK_RDM - reliably-delivered message
+ * @SOCK_SEQPACKET - sequential packet socket
+ * @SOCK_DCCP - Datagram Congestion Control Protocol socket
+ * @SOCK_PACKET - linux specific way of getting packets at the dev level.
+ *                For writing rarp and other similar things on the user
+ *                level.
+ * @SOCK_CLOEXEC - sets the close-on-exec (FD_CLOEXEC) flag.
+ * @SOCK_NONBLOCK - sets the O_NONBLOCK file status flag.
+ */
+
+#define ARCH_HAS_SOCKET_TYPES          1
+
+enum sock_type {
+       TARGET_SOCK_STREAM      = 1,
+       TARGET_SOCK_DGRAM       = 2,
+       TARGET_SOCK_RAW         = 3,
+       TARGET_SOCK_RDM         = 4,
+       TARGET_SOCK_SEQPACKET   = 5,
+       TARGET_SOCK_DCCP        = 6,
+       TARGET_SOCK_PACKET      = 10,
+       TARGET_SOCK_CLOEXEC     = 020000000,
+       TARGET_SOCK_NONBLOCK    = 040000,
+};
+
+#define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
+#define TARGET_SOCK_TYPE_MASK    0xf  /* Covers up to TARGET_SOCK_MAX-1. */
+
+#define TARGET_SO_PASSSEC        31
+
+/* For setsockopt(2) */
+#define TARGET_SOL_SOCKET      1
+
+#define TARGET_SO_DEBUG        1
+#define TARGET_SO_REUSEADDR    2
+#define TARGET_SO_TYPE         3
+#define TARGET_SO_ERROR        4
+#define TARGET_SO_DONTROUTE    5
+#define TARGET_SO_BROADCAST    6
+#define TARGET_SO_SNDBUF       7
+#define TARGET_SO_RCVBUF       8
+#define TARGET_SO_SNDBUFFORCE  32
+#define TARGET_SO_RCVBUFFORCE  33
+#define TARGET_SO_KEEPALIVE    9
+#define TARGET_SO_OOBINLINE    10
+#define TARGET_SO_NO_CHECK     11
+#define TARGET_SO_PRIORITY     12
+#define TARGET_SO_LINGER       13
+#define TARGET_SO_BSDCOMPAT    14
+/* To add :#define TARGET_SO_REUSEPORT 15 */
+#define TARGET_SO_PASSCRED     16
+#define TARGET_SO_PEERCRED     17
+#define TARGET_SO_RCVLOWAT     18
+#define TARGET_SO_SNDLOWAT     19
+#define TARGET_SO_RCVTIMEO     20
+#define TARGET_SO_SNDTIMEO     21
+
+/* Security levels - as per NRL IPv6 - don't actually do anything */
+#define TARGET_SO_SECURITY_AUTHENTICATION              22
+#define TARGET_SO_SECURITY_ENCRYPTION_TRANSPORT        23
+#define TARGET_SO_SECURITY_ENCRYPTION_NETWORK          24
+
+#define TARGET_SO_BINDTODEVICE 25
+
+/* Socket filtering */
+#define TARGET_SO_ATTACH_FILTER        26
+#define TARGET_SO_DETACH_FILTER        27
+
+#define TARGET_SO_PEERNAME             28
+#define TARGET_SO_TIMESTAMP            29
+#define TARGET_SCM_TIMESTAMP           TARGET_SO_TIMESTAMP
+
+#define TARGET_SO_ACCEPTCONN           30
+
+#define TARGET_SO_PEERSEC              31
+#endif
diff --git a/linux-user/sparc64/sockbits.h b/linux-user/sparc64/sockbits.h
new file mode 100644
index 0000000000..658899e4d3
--- /dev/null
+++ b/linux-user/sparc64/sockbits.h
@@ -0,0 +1 @@
+#include "../sparc/sockbits.h"
-- 
2.14.3
