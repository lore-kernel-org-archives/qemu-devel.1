Received: from eggs.gnu.org ([2001:4830:134:3::10]:52679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fJ3TZ-0000Jv-E6
	for qemu-devel@nongnu.org; Wed, 16 May 2018 16:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fJ3TW-00047w-AD
	for qemu-devel@nongnu.org; Wed, 16 May 2018 16:56:45 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:48089)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fJ3TV-00047Z-W0
	for qemu-devel@nongnu.org; Wed, 16 May 2018 16:56:42 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 16 May 2018 22:55:41 +0200
Message-Id: <20180516205543.29305-7-laurent@vivier.eu>
In-Reply-To: <20180516205543.29305-1-laurent@vivier.eu>
References: <20180516205543.29305-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 6/8] linux-user: update
 ARCH_HAS_SOCKET_TYPES use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Yongbok Kim <yongbok.kim@mips.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

to be like in the kernel and rename it TARGET_ARCH_HAS_SOCKET_TYPES

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/alpha/sockbits.h | 36 +++-----------------------
 linux-user/hppa/sockbits.h  | 33 +++---------------------
 linux-user/mips/sockbits.h  |  9 ++++---
 linux-user/socket.h         | 62 +++++++++++++++++++++++----------------------
 linux-user/sparc/sockbits.h | 36 --------------------------
 5 files changed, 44 insertions(+), 132 deletions(-)

diff --git a/linux-user/alpha/sockbits.h b/linux-user/alpha/sockbits.h
index 4db3e52b67..f5397dd875 100644
--- a/linux-user/alpha/sockbits.h
+++ b/linux-user/alpha/sockbits.h
@@ -75,39 +75,9 @@
 /* Instruct lower device to use last 4-bytes of skb data as FCS */
 #define TARGET_SO_NOFCS     43
 
-/** sock_type - Socket types
- *
- * Please notice that for binary compat reasons ALPHA has to
- * override the enum sock_type in include/linux/net.h, so
- * we define ARCH_HAS_SOCKET_TYPES here.
- *
- * @SOCK_DGRAM - datagram (conn.less) socket
- * @SOCK_STREAM - stream (connection) socket
- * @SOCK_RAW - raw socket
- * @SOCK_RDM - reliably-delivered message
- * @SOCK_SEQPACKET - sequential packet socket
- * @SOCK_DCCP - Datagram Congestion Control Protocol socket
- * @SOCK_PACKET - linux specific way of getting packets at the dev level.
- *                For writing rarp and other similar things on the user
- *                level.
- * @SOCK_CLOEXEC - sets the close-on-exec (FD_CLOEXEC) flag.
- * @SOCK_NONBLOCK - sets the O_NONBLOCK file status flag.
+/* TARGET_O_NONBLOCK clashes with the bits used for socket types.  Therefore we
+ * have to define SOCK_NONBLOCK to a different value here.
  */
+#define TARGET_SOCK_NONBLOCK   0x40000000
 
-#define ARCH_HAS_SOCKET_TYPES          1
-
-enum sock_type {
-       TARGET_SOCK_STREAM      = 1,
-       TARGET_SOCK_DGRAM       = 2,
-       TARGET_SOCK_RAW         = 3,
-       TARGET_SOCK_RDM         = 4,
-       TARGET_SOCK_SEQPACKET   = 5,
-       TARGET_SOCK_DCCP        = 6,
-       TARGET_SOCK_PACKET      = 10,
-       TARGET_SOCK_CLOEXEC     = 010000000,
-       TARGET_SOCK_NONBLOCK    = 010000000000,
-};
-
-#define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
-#define TARGET_SOCK_TYPE_MASK    0xf  /* Covers up to TARGET_SOCK_MAX-1. */
 #endif
diff --git a/linux-user/hppa/sockbits.h b/linux-user/hppa/sockbits.h
index 5044619e16..2641aea859 100644
--- a/linux-user/hppa/sockbits.h
+++ b/linux-user/hppa/sockbits.h
@@ -64,34 +64,7 @@
 
 #define TARGET_SO_CNX_ADVICE           0x402E
 
-/** sock_type - Socket types - default values
- *
- *
- * @SOCK_STREAM - stream (connection) socket
- * @SOCK_DGRAM - datagram (conn.less) socket
- * @SOCK_RAW - raw socket
- * @SOCK_RDM - reliably-delivered message
- * @SOCK_SEQPACKET - sequential packet socket
- * @SOCK_DCCP - Datagram Congestion Control Protocol socket
- * @SOCK_PACKET - linux specific way of getting packets at the dev level.
- *                For writing rarp and other similar things on the user
- *                level.
- * @SOCK_CLOEXEC - sets the close-on-exec (FD_CLOEXEC) flag.
- * @SOCK_NONBLOCK - sets the O_NONBLOCK file status flag.
+/* TARGET_O_NONBLOCK clashes with the bits used for socket types.  Therefore we
+ * have to define SOCK_NONBLOCK to a different value here.
  */
-enum sock_type {
-   TARGET_SOCK_STREAM      = 1,
-   TARGET_SOCK_DGRAM       = 2,
-   TARGET_SOCK_RAW         = 3,
-   TARGET_SOCK_RDM         = 4,
-   TARGET_SOCK_SEQPACKET   = 5,
-   TARGET_SOCK_DCCP        = 6,
-   TARGET_SOCK_PACKET      = 10,
-   TARGET_SOCK_CLOEXEC     = 010000000,
-   TARGET_SOCK_NONBLOCK    = 0x40000000,
-};
-
-#define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
-#define TARGET_SOCK_TYPE_MASK    0xf  /* Covers up to TARGET_SOCK_MAX-1. */
-
-#define ARCH_HAS_SOCKET_TYPES 1
+#define TARGET_SOCK_NONBLOCK   0x40000000
diff --git a/linux-user/mips/sockbits.h b/linux-user/mips/sockbits.h
index 3fe5ac88e7..370d13ed86 100644
--- a/linux-user/mips/sockbits.h
+++ b/linux-user/mips/sockbits.h
@@ -91,7 +91,7 @@
  * @SOCK_NONBLOCK - sets the O_NONBLOCK file status flag.
  */
 
-#define ARCH_HAS_SOCKET_TYPES          1
+#define TARGET_ARCH_HAS_SOCKET_TYPES          1
 
 enum sock_type {
        TARGET_SOCK_DGRAM       = 1,
@@ -101,10 +101,13 @@ enum sock_type {
        TARGET_SOCK_SEQPACKET   = 5,
        TARGET_SOCK_DCCP        = 6,
        TARGET_SOCK_PACKET      = 10,
-       TARGET_SOCK_CLOEXEC     = 02000000,
-       TARGET_SOCK_NONBLOCK    = 0200,
 };
 
 #define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
 #define TARGET_SOCK_TYPE_MASK    0xf  /* Covers up to TARGET_SOCK_MAX-1. */
+
+/* Flags for socket, socketpair, paccept */
+#define TARGET_SOCK_CLOEXEC    TARGET_O_CLOEXEC
+#define TARGET_SOCK_NONBLOCK   TARGET_O_NONBLOCK
+
 #endif
diff --git a/linux-user/socket.h b/linux-user/socket.h
index 135f438bdf..8de8681015 100644
--- a/linux-user/socket.h
+++ b/linux-user/socket.h
@@ -1,35 +1,37 @@
-
 #include "sockbits.h"
 
-#ifndef ARCH_HAS_SOCKET_TYPES
-    /** sock_type - Socket types - default values
-     *
-     *
-     * @SOCK_STREAM - stream (connection) socket
-     * @SOCK_DGRAM - datagram (conn.less) socket
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
-    enum sock_type {
-           TARGET_SOCK_STREAM      = 1,
-           TARGET_SOCK_DGRAM       = 2,
-           TARGET_SOCK_RAW         = 3,
-           TARGET_SOCK_RDM         = 4,
-           TARGET_SOCK_SEQPACKET   = 5,
-           TARGET_SOCK_DCCP        = 6,
-           TARGET_SOCK_PACKET      = 10,
-           TARGET_SOCK_CLOEXEC     = 02000000,
-           TARGET_SOCK_NONBLOCK    = 04000,
-    };
+#ifndef TARGET_ARCH_HAS_SOCKET_TYPES
+/** sock_type - Socket types - default values
+ *
+ *
+ * @SOCK_STREAM - stream (connection) socket
+ * @SOCK_DGRAM - datagram (conn.less) socket
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
+enum sock_type {
+       TARGET_SOCK_STREAM      = 1,
+       TARGET_SOCK_DGRAM       = 2,
+       TARGET_SOCK_RAW         = 3,
+       TARGET_SOCK_RDM         = 4,
+       TARGET_SOCK_SEQPACKET   = 5,
+       TARGET_SOCK_DCCP        = 6,
+       TARGET_SOCK_PACKET      = 10,
+};
 
-    #define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
-    #define TARGET_SOCK_TYPE_MASK    0xf  /* Covers up to TARGET_SOCK_MAX-1. */
+#define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
+#define TARGET_SOCK_TYPE_MASK    0xf  /* Covers up to TARGET_SOCK_MAX-1. */
 
+/* Flags for socket, socketpair, accept4 */
+#define TARGET_SOCK_CLOEXEC    TARGET_O_CLOEXEC
+#ifndef TARGET_SOCK_NONBLOCK
+#define TARGET_SOCK_NONBLOCK   O_NONBLOCK
 #endif
+#endif /* TARGET_ARCH_HAS_SOCKET_TYPES */
diff --git a/linux-user/sparc/sockbits.h b/linux-user/sparc/sockbits.h
index 385061c8b0..6434b07033 100644
--- a/linux-user/sparc/sockbits.h
+++ b/linux-user/sparc/sockbits.h
@@ -8,42 +8,6 @@
 #ifndef SPARC_SOCKBITS_H
 #define SPARC_SOCKBITS_H
 
-/** sock_type - Socket types
- *
- * Please notice that for binary compat reasons SPARC has to
- * override the enum sock_type in include/linux/net.h, so
- * we define ARCH_HAS_SOCKET_TYPES here.
- *
- * @SOCK_DGRAM - datagram (conn.less) socket
- * @SOCK_STREAM - stream (connection) socket
- * @SOCK_RAW - raw socket
- * @SOCK_RDM - reliably-delivered message
- * @SOCK_SEQPACKET - sequential packet socket
- * @SOCK_DCCP - Datagram Congestion Control Protocol socket
- * @SOCK_PACKET - linux specific way of getting packets at the dev level.
- *                For writing rarp and other similar things on the user
- *                level.
- * @SOCK_CLOEXEC - sets the close-on-exec (FD_CLOEXEC) flag.
- * @SOCK_NONBLOCK - sets the O_NONBLOCK file status flag.
- */
-
-#define ARCH_HAS_SOCKET_TYPES          1
-
-enum sock_type {
-       TARGET_SOCK_STREAM      = 1,
-       TARGET_SOCK_DGRAM       = 2,
-       TARGET_SOCK_RAW         = 3,
-       TARGET_SOCK_RDM         = 4,
-       TARGET_SOCK_SEQPACKET   = 5,
-       TARGET_SOCK_DCCP        = 6,
-       TARGET_SOCK_PACKET      = 10,
-       TARGET_SOCK_CLOEXEC     = 020000000,
-       TARGET_SOCK_NONBLOCK    = 040000,
-};
-
-#define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
-#define TARGET_SOCK_TYPE_MASK    0xf  /* Covers up to TARGET_SOCK_MAX-1. */
-
 #define TARGET_SO_PASSSEC        31
 
 /* For setsockopt(2) */
-- 
2.14.3
