Received: from eggs.gnu.org ([2001:4830:134:3::10]:44092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dwcf9-0007ih-Vu
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dwcf8-00020D-HZ
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:19:43 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:37624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1dwcf8-0001zG-AH
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:19:42 -0400
Received: by mail-pg0-x241.google.com with SMTP id v5so5671654pgn.4
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:19:42 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Date: Mon, 25 Sep 2017 16:19:22 -0700
Message-Id: <20170925231924.31303-5-carenas@gmail.com>
In-Reply-To: <20170925231924.31303-4-carenas@gmail.com>
References: <20170925231924.31303-1-carenas@gmail.com>
	<20170925231924.31303-2-carenas@gmail.com>
	<20170925231924.31303-3-carenas@gmail.com>
	<20170925231924.31303-4-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 4/6] linux-user: refactor socket.h for sparc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

fixes SOL_SOCKET and SO_LINGER and all other values that didn't match the
default (SO_PASSSEC being the exception as it only changed base)

TARGET_SOCK_{NONBLOCK,CLOEXEC} updated to match the values for the header:
arch/sparc/include/uapi/asm/fcntl.h

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/socket.h         |  46 ++------------------
 linux-user/sparc/sockbits.h | 104 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+), 43 deletions(-)
 create mode 100644 linux-user/sparc/sockbits.h

diff --git a/linux-user/socket.h b/linux-user/socket.h
index 036270a6e4..dfa692286b 100644
--- a/linux-user/socket.h
+++ b/linux-user/socket.h
@@ -4,50 +4,10 @@
 #include "alpha/sockbits.h"
 #elif defined(TARGET_HPPA)
 #include "hppa/sockbits.h"
+#elif defined(TARGET_SPARC)
+#include "sparc/sockbits.h"
 #else
 
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
-#else
-    #define TARGET_SO_PASSSEC        34
-#endif
-
     /* For setsockopt(2) */
     #define TARGET_SOL_SOCKET      1
 
@@ -103,11 +63,11 @@
 
     #define TARGET_SO_PEERSEC              31
 
+    #define TARGET_SO_PASSSEC              34
 #endif
 
 #ifndef ARCH_HAS_SOCKET_TYPES
     /** sock_type - Socket types - default values
-     *
      *
      * @SOCK_STREAM - stream (connection) socket
      * @SOCK_DGRAM - datagram (conn.less) socket
diff --git a/linux-user/sparc/sockbits.h b/linux-user/sparc/sockbits.h
new file mode 100644
index 0000000000..d51ae5f84f
--- /dev/null
+++ b/linux-user/sparc/sockbits.h
@@ -0,0 +1,104 @@
+#define TARGET_SOL_SOCKET                        0xffff
+
+#define TARGET_SO_DEBUG                          0x0001
+#define TARGET_SO_PASSCRED                       0x0002
+#define TARGET_SO_REUSEADDR                      0x0004
+#define TARGET_SO_KEEPALIVE                      0x0008
+#define TARGET_SO_DONTROUTE                      0x0010
+#define TARGET_SO_BROADCAST                      0x0020
+#define TARGET_SO_PEERCRED                       0x0040
+#define TARGET_SO_LINGER                         0x0080
+#define TARGET_SO_OOBINLINE                      0x0100
+#define TARGET_SO_REUSEPORT                      0x0200
+#define TARGET_SO_BSDCOMPAT                      0x0400
+#define TARGET_SO_RCVLOWAT                       0x0800
+#define TARGET_SO_SNDLOWAT                       0x1000
+#define TARGET_SO_RCVTIMEO                       0x2000
+#define TARGET_SO_SNDTIMEO                       0x4000
+#define TARGET_SO_ACCEPTCONN                     0x8000
+#define TARGET_SO_SNDBUF                         0x1001
+#define TARGET_SO_RCVBUF                         0x1002
+#define TARGET_SO_SNDBUFFORCE                    0x100a
+#define TARGET_SO_RCVBUFFORCE                    0x100b
+#define TARGET_SO_ERROR                          0x1007
+#define TARGET_SO_TYPE                           0x1008
+#define TARGET_SO_PROTOCOL                       0x1028
+#define TARGET_SO_DOMAIN                         0x1029
+#define TARGET_SO_NO_CHECK                       0x000b
+#define TARGET_SO_PRIORITY                       0x000c
+#define TARGET_SO_BINDTODEVICE                   0x000d
+#define TARGET_SO_ATTACH_FILTER                  0x001a
+#define TARGET_SO_DETACH_FILTER                  0x001b
+#define TARGET_SO_GET_FILTER                     TARGET_SO_ATTACH_FILTER
+#define TARGET_SO_PEERNAME                       0x001c
+#define TARGET_SO_TIMESTAMP                      0x001d
+#define TARGET_SCM_TIMESTAMP                     TARGET_SO_TIMESTAMP
+#define TARGET_SO_PEERSEC                        0x001e
+#define TARGET_SO_PASSSEC                        0x001f
+#define TARGET_SO_TIMESTAMPNS                    0x0021
+#define TARGET_SCM_TIMESTAMPNS                   TARGET_SO_TIMESTAMPNS
+#define TARGET_SO_MARK                           0x0022
+#define TARGET_SO_TIMESTAMPING                   0x0023
+#define TARGET_SCM_TIMESTAMPING                  TARGET_SO_TIMESTAMPING
+#define TARGET_SO_RXQ_OVFL                       0x0024
+#define TARGET_SO_WIFI_STATUS                    0x0025
+#define TARGET_SCM_WIFI_STATUS                   TARGET_SO_WIFI_STATUS
+#define TARGET_SO_PEEK_OFF                       0x0026
+#define TARGET_SO_NOFCS                          0x0027
+#define TARGET_SO_LOCK_FILTER                    0x0028
+#define TARGET_SO_SELECT_ERR_QUEUE               0x0029
+#define TARGET_SO_BUSY_POLL                      0x0030
+#define TARGET_SO_MAX_PACING_RATE                0x0031
+#define TARGET_SO_BPF_EXTENSIONS                 0x0032
+#define TARGET_SO_INCOMING_CPU                   0x0033
+#define TARGET_SO_ATTACH_BPF                     0x0034
+#define TARGET_SO_DETACH_BPF                     TARGET_SO_DETACH_FILTER
+#define TARGET_SO_ATTACH_REUSEPORT_CBPF          0x0035
+#define TARGET_SO_ATTACH_REUSEPORT_EBPF          0x0036
+#define TARGET_SO_CNX_ADVICE                     0x0037
+#define TARGET_SCM_TIMESTAMPING_OPT_STATS        0x0038
+#define TARGET_SO_MEMINFO                        0x0039
+#define TARGET_SO_INCOMING_NAPI_ID               0x003a
+#define TARGET_SO_COOKIE                         0x003b
+#define TARGET_SCM_TIMESTAMPING_PKTINFO          0x003c
+#define TARGET_SO_PEERGROUPS                     0x003d
+#define TARGET_SO_ZEROCOPY                       0x003e
+#define TARGET_SO_SECURITY_AUTHENTICATION        0x5001
+#define TARGET_SO_SECURITY_ENCRYPTION_TRANSPORT  0x5002
+#define TARGET_SO_SECURITY_ENCRYPTION_NETWORK    0x5004
+
+/** sock_type - Socket types
+ *
+ * Please notice that for binary compat reasons SPARC has to
+ * override the enum sock_type in include/linux/net.h, so
+ * we define ARCH_HAS_SOCKET_TYPES here.
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
+
+enum sock_type {
+    TARGET_SOCK_STREAM      = 1,
+    TARGET_SOCK_DGRAM       = 2,
+    TARGET_SOCK_RAW         = 3,
+    TARGET_SOCK_RDM         = 4,
+    TARGET_SOCK_SEQPACKET   = 5,
+    TARGET_SOCK_DCCP        = 6,
+    TARGET_SOCK_PACKET      = 10,
+    TARGET_SOCK_CLOEXEC     = 0x400000,
+    TARGET_SOCK_NONBLOCK    = 0x4000,
+};
+
+#define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
+#define TARGET_SOCK_TYPE_MASK 0xf  /* Covers up to TARGET_SOCK_MAX - 1. */
+
+#define ARCH_HAS_SOCKET_TYPES 1
-- 
2.14.1
