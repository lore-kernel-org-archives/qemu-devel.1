Received: from eggs.gnu.org ([2001:4830:134:3::10]:44073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dwcf8-0007ht-Tw
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:19:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dwcf7-0001xw-2Z
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:19:42 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1dwcf6-0001wm-Pg
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:19:40 -0400
Received: by mail-pg0-x243.google.com with SMTP id j16so5683866pga.2
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:19:40 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Date: Mon, 25 Sep 2017 16:19:21 -0700
Message-Id: <20170925231924.31303-4-carenas@gmail.com>
In-Reply-To: <20170925231924.31303-3-carenas@gmail.com>
References: <20170925231924.31303-1-carenas@gmail.com>
	<20170925231924.31303-2-carenas@gmail.com>
	<20170925231924.31303-3-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 3/6] linux-user: refactor socket.h for mips
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

fresh bits from linux 4.14, redefine SO_STYLE and {SO,SCM}_TIMESTAMP to
the right target values and enables SO_REUSEPORT

to easy on maintenance SOCK_NONBLOCK has been updated to use the same
value (in hexadecimal) as defined for O_NONBLOCK from the linux header
arch/mips/linux/uapi/asm/fcntl.h

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/mips/sockbits.h | 107 +++++++++++++++++++++++++++++++++++++++++++++
 linux-user/socket.h        | 103 +------------------------------------------
 2 files changed, 108 insertions(+), 102 deletions(-)
 create mode 100644 linux-user/mips/sockbits.h

diff --git a/linux-user/mips/sockbits.h b/linux-user/mips/sockbits.h
new file mode 100644
index 0000000000..6d8ea8aba2
--- /dev/null
+++ b/linux-user/mips/sockbits.h
@@ -0,0 +1,107 @@
+#define TARGET_SOL_SOCKET     0xffff
+
+#define TARGET_SO_DEBUG       0x0001 /* Record debugging information.  */
+#define TARGET_SO_REUSEADDR   0x0004 /* Allow reuse of local addresses.  */
+#define TARGET_SO_KEEPALIVE   0x0008 /* Keep connections alive and send
+                                        SIGPIPE when they die. */
+#define TARGET_SO_DONTROUTE   0x0010 /* Don't do local routing. */
+#define TARGET_SO_BROADCAST   0x0020 /* Allow transmission of
+                                        broadcast messages. */
+#define TARGET_SO_LINGER      0x0080 /* Block on close of a reliable
+                                        socket to transmit pending data. */
+#define TARGET_SO_OOBINLINE   0x0100 /* Receive out-of-band data in-band. */
+#define TARGET_SO_REUSEPORT   0x0200 /* Allow local address and port reuse. */
+#define TARGET_SO_TYPE        0x1008 /* Compatible name for TARGET_SO_STYLE. */
+#define TARGET_SO_STYLE       TARGET_SO_TYPE /* Synonym */
+#define TARGET_SO_ERROR       0x1007         /* get error status and clear */
+#define TARGET_SO_SNDBUF      0x1001         /* Send buffer size. */
+#define TARGET_SO_RCVBUF      0x1002         /* Receive buffer. */
+#define TARGET_SO_SNDLOWAT    0x1003         /* send low-water mark */
+#define TARGET_SO_RCVLOWAT    0x1004         /* receive low-water mark */
+#define TARGET_SO_SNDTIMEO    0x1005         /* send timeout */
+#define TARGET_SO_RCVTIMEO    0x1006         /* receive timeout */
+#define TARGET_SO_ACCEPTCONN  0x1009
+#define TARGET_SO_PROTOCOL    0x1028         /* protocol type */
+#define TARGET_SO_DOMAIN      0x1029         /* domain/socket family */
+#define TARGET_SO_NO_CHECK                      11
+#define TARGET_SO_PRIORITY                      12
+#define TARGET_SO_BSDCOMPAT                     14
+#define TARGET_SO_PASSCRED                      17
+#define TARGET_SO_PEERCRED                      18
+#define TARGET_SO_SECURITY_AUTHENTICATION       22
+#define TARGET_SO_SECURITY_ENCRYPTION_TRANSPORT 23
+#define TARGET_SO_SECURITY_ENCRYPTION_NETWORK   24
+#define TARGET_SO_BINDTODEVICE                  25
+#define TARGET_SO_ATTACH_FILTER                 26
+#define TARGET_SO_DETACH_FILTER                 27
+#define TARGET_SO_GET_FILTER                    TARGET_SO_ATTACH_FILTER
+#define TARGET_SO_PEERNAME                      28
+#define TARGET_SO_TIMESTAMP                     29
+#define TARGET_SCM_TIMESTAMP                    TARGET_SO_TIMESTAMP
+#define TARGET_SO_PEERSEC                       30
+#define TARGET_SO_SNDBUFFORCE                   31
+#define TARGET_SO_RCVBUFFORCE                   33
+#define TARGET_SO_PASSSEC                       34
+#define TARGET_SO_TIMESTAMPNS                   35
+#define TARGET_SCM_TIMESTAMPNS                  TARGET_SO_TIMESTAMPNS
+#define TARGET_SO_MARK                          36
+#define TARGET_SO_TIMESTAMPING                  37
+#define TARGET_SCM_TIMESTAMPING                 TARGET_SO_TIMESTAMPING
+#define TARGET_SO_RXQ_OVFL                      40
+#define TARGET_SO_WIFI_STATUS                   41
+#define TARGET_SCM_WIFI_STATUS                  TARGET_SO_WIFI_STATUS
+#define TARGET_SO_PEEK_OFF                      42
+#define TARGET_SO_NOFCS                         43
+#define TARGET_SO_LOCK_FILTER                   44
+#define TARGET_SO_SELECT_ERR_QUEUE              45
+#define TARGET_SO_BUSY_POLL                     46
+#define TARGET_SO_MAX_PACING_RATE               47
+#define TARGET_SO_BPF_EXTENSIONS                48
+#define TARGET_SO_INCOMING_CPU                  49
+#define TARGET_SO_ATTACH_BPF                    50
+#define TARGET_SO_DETACH_BPF                    TARGET_SO_DETACH_FILTER
+#define TARGET_SO_ATTACH_REUSEPORT_CBPF         51
+#define TARGET_SO_ATTACH_REUSEPORT_EBPF         52
+#define TARGET_SO_CNX_ADVICE                    53
+#define TARGET_SCM_TIMESTAMPING_OPT_STATS       54
+#define TARGET_SO_MEMINFO                       55
+#define TARGET_SO_INCOMING_NAPI_ID              56
+#define TARGET_SO_COOKIE                        57
+#define TARGET_SCM_TIMESTAMPING_PKTINFO         58
+#define TARGET_SO_PEERGROUPS                    59
+#define TARGET_SO_ZEROCOPY                      60
+
+/** sock_type - Socket types
+ *
+ * Please notice that for binary compat reasons MIPS has to
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
+enum sock_type {
+    TARGET_SOCK_DGRAM       = 1,
+    TARGET_SOCK_STREAM      = 2,
+    TARGET_SOCK_RAW         = 3,
+    TARGET_SOCK_RDM         = 4,
+    TARGET_SOCK_SEQPACKET   = 5,
+    TARGET_SOCK_DCCP        = 6,
+    TARGET_SOCK_PACKET      = 10,
+    TARGET_SOCK_CLOEXEC     = 02000000,
+    TARGET_SOCK_NONBLOCK    = 0x0080,
+};
+
+#define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
+#define TARGET_SOCK_TYPE_MASK 0xf  /* Covers up to TARGET_SOCK_MAX - 1. */
+
+#define ARCH_HAS_SOCKET_TYPES 1
diff --git a/linux-user/socket.h b/linux-user/socket.h
index 115bdf2ddb..036270a6e4 100644
--- a/linux-user/socket.h
+++ b/linux-user/socket.h
@@ -1,106 +1,5 @@
-
 #if defined(TARGET_MIPS)
-    /* MIPS special values for constants */
-
-    /*
-     * For setsockopt(2)
-     *
-     * This defines are ABI conformant as far as Linux supports these ...
-     */
-    #define TARGET_SOL_SOCKET      0xffff
-
-    #define TARGET_SO_DEBUG        0x0001  /* Record debugging information. */
-    #define TARGET_SO_REUSEADDR    0x0004  /* Allow reuse of local addresses. */
-    #define TARGET_SO_KEEPALIVE    0x0008  /* Keep connections alive and send
-                                              SIGPIPE when they die. */
-    #define TARGET_SO_DONTROUTE    0x0010  /* Don't do local routing. */
-    #define TARGET_SO_BROADCAST    0x0020  /* Allow transmission of
-                                              broadcast messages. */
-    #define TARGET_SO_LINGER       0x0080  /* Block on close of a reliable
-                                            * socket to transmit pending data.
-                                            */
-    #define TARGET_SO_OOBINLINE 0x0100     /* Receive out-of-band data in-band.
-                                            */
-    #if 0
-    /* To add: Allow local address and port reuse. */
-    #define TARGET_SO_REUSEPORT 0x0200
-    #endif
-
-    #define TARGET_SO_TYPE         0x1008  /* Compatible name for SO_STYLE. */
-    #define TARGET_SO_STYLE        SO_TYPE /* Synonym */
-    #define TARGET_SO_ERROR        0x1007  /* get error status and clear */
-    #define TARGET_SO_SNDBUF       0x1001  /* Send buffer size. */
-    #define TARGET_SO_RCVBUF       0x1002  /* Receive buffer. */
-    #define TARGET_SO_SNDLOWAT     0x1003  /* send low-water mark */
-    #define TARGET_SO_RCVLOWAT     0x1004  /* receive low-water mark */
-    #define TARGET_SO_SNDTIMEO     0x1005  /* send timeout */
-    #define TARGET_SO_RCVTIMEO     0x1006  /* receive timeout */
-    #define TARGET_SO_ACCEPTCONN   0x1009
-
-    /* linux-specific, might as well be the same as on i386 */
-    #define TARGET_SO_NO_CHECK     11
-    #define TARGET_SO_PRIORITY     12
-    #define TARGET_SO_BSDCOMPAT    14
-
-    #define TARGET_SO_PASSCRED     17
-    #define TARGET_SO_PEERCRED     18
-
-    /* Security levels - as per NRL IPv6 - don't actually do anything */
-    #define TARGET_SO_SECURITY_AUTHENTICATION              22
-    #define TARGET_SO_SECURITY_ENCRYPTION_TRANSPORT        23
-    #define TARGET_SO_SECURITY_ENCRYPTION_NETWORK          24
-
-    #define TARGET_SO_BINDTODEVICE         25
-
-    /* Socket filtering */
-    #define TARGET_SO_ATTACH_FILTER        26
-    #define TARGET_SO_DETACH_FILTER        27
-
-    #define TARGET_SO_PEERNAME             28
-    #define TARGET_SO_TIMESTAMP            29
-    #define SCM_TIMESTAMP          SO_TIMESTAMP
-
-    #define TARGET_SO_PEERSEC              30
-    #define TARGET_SO_SNDBUFFORCE          31
-    #define TARGET_SO_RCVBUFFORCE          33
-    #define TARGET_SO_PASSSEC              34
-
-    /** sock_type - Socket types
-     *
-     * Please notice that for binary compat reasons MIPS has to
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
-           TARGET_SOCK_DGRAM       = 1,
-           TARGET_SOCK_STREAM      = 2,
-           TARGET_SOCK_RAW         = 3,
-           TARGET_SOCK_RDM         = 4,
-           TARGET_SOCK_SEQPACKET   = 5,
-           TARGET_SOCK_DCCP        = 6,
-           TARGET_SOCK_PACKET      = 10,
-           TARGET_SOCK_CLOEXEC     = 02000000,
-           TARGET_SOCK_NONBLOCK    = 0200,
-    };
-
-    #define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
-    #define TARGET_SOCK_TYPE_MASK    0xf  /* Covers up to TARGET_SOCK_MAX-1. */
-
+#include "mips/sockbits.h"
 #elif defined(TARGET_ALPHA)
 #include "alpha/sockbits.h"
 #elif defined(TARGET_HPPA)
-- 
2.14.1
