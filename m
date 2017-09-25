Received: from eggs.gnu.org ([2001:4830:134:3::10]:44124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dwcfF-0007od-PZ
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:19:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dwcfB-00025J-PT
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:19:49 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1dwcfB-00024Q-HO
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:19:45 -0400
Received: by mail-pg0-x243.google.com with SMTP id j16so5683950pga.2
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:19:45 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Date: Mon, 25 Sep 2017 16:19:24 -0700
Message-Id: <20170925231924.31303-7-carenas@gmail.com>
In-Reply-To: <20170925231924.31303-6-carenas@gmail.com>
References: <20170925231924.31303-1-carenas@gmail.com>
	<20170925231924.31303-2-carenas@gmail.com>
	<20170925231924.31303-3-carenas@gmail.com>
	<20170925231924.31303-4-carenas@gmail.com>
	<20170925231924.31303-5-carenas@gmail.com>
	<20170925231924.31303-6-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 6/6] linux_user: consolidate sock_type
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

remove unnecessary sock_type enum and other unused surrounding code to
allow for per arch sockbits to mirror better linux headers for maintenance

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 linux-user/alpha/sockbits.h | 36 ----------------------------
 linux-user/hppa/sockbits.h  | 30 -----------------------
 linux-user/mips/sockbits.h  | 35 ---------------------------
 linux-user/socket.h         | 58 ++++++++++++++++++++++-----------------------
 linux-user/sparc/sockbits.h | 35 ---------------------------
 5 files changed, 29 insertions(+), 165 deletions(-)

diff --git a/linux-user/alpha/sockbits.h b/linux-user/alpha/sockbits.h
index 768579a1f7..defdb806ea 100644
--- a/linux-user/alpha/sockbits.h
+++ b/linux-user/alpha/sockbits.h
@@ -66,39 +66,3 @@
 #define TARGET_SCM_TIMESTAMPING_PKTINFO         58
 #define TARGET_SO_PEERGROUPS                    59
 #define TARGET_SO_ZEROCOPY                      60
-
-/** sock_type - Socket types
- *
- * Please notice that for binary compat reasons ALPHA has to
- * override the enum sock_type in include/linux/net.h, so
- * we define ARCH_HAS_SOCKET_TYPES here.
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
- */
-
-enum sock_type {
-    TARGET_SOCK_STREAM      = 1,
-    TARGET_SOCK_DGRAM       = 2,
-    TARGET_SOCK_RAW         = 3,
-    TARGET_SOCK_RDM         = 4,
-    TARGET_SOCK_SEQPACKET   = 5,
-    TARGET_SOCK_DCCP        = 6,
-    TARGET_SOCK_PACKET      = 10,
-    TARGET_SOCK_CLOEXEC     = 010000000,
-    TARGET_SOCK_NONBLOCK    = 0x40000000,
-};
-
-#define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
-#define TARGET_SOCK_TYPE_MASK 0xf  /* Covers up to TARGET_SOCK_MAX - 1. */
-
-#define ARCH_HAS_SOCKET_TYPES 1
diff --git a/linux-user/hppa/sockbits.h b/linux-user/hppa/sockbits.h
index 3dab31a76a..32f81357d6 100644
--- a/linux-user/hppa/sockbits.h
+++ b/linux-user/hppa/sockbits.h
@@ -71,33 +71,3 @@
 #define TARGET_SO_PEERGROUPS                    0x4034
 #define TARGET_SO_ZEROCOPY                      0x4035
 
-/** sock_type - Socket types - default values
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
- */
-enum sock_type {
-    TARGET_SOCK_STREAM    = 1,
-    TARGET_SOCK_DGRAM     = 2,
-    TARGET_SOCK_RAW       = 3,
-    TARGET_SOCK_RDM       = 4,
-    TARGET_SOCK_SEQPACKET = 5,
-    TARGET_SOCK_DCCP      = 6,
-    TARGET_SOCK_PACKET    = 10,
-    TARGET_SOCK_CLOEXEC   = 010000000,
-    TARGET_SOCK_NONBLOCK  = 0x40000000,
-};
-
-#define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
-#define TARGET_SOCK_TYPE_MASK 0xf  /* Covers up to TARGET_SOCK_MAX - 1. */
-
-#define ARCH_HAS_SOCKET_TYPES 1
diff --git a/linux-user/mips/sockbits.h b/linux-user/mips/sockbits.h
index 6d8ea8aba2..fa8062391d 100644
--- a/linux-user/mips/sockbits.h
+++ b/linux-user/mips/sockbits.h
@@ -70,38 +70,3 @@
 #define TARGET_SCM_TIMESTAMPING_PKTINFO         58
 #define TARGET_SO_PEERGROUPS                    59
 #define TARGET_SO_ZEROCOPY                      60
-
-/** sock_type - Socket types
- *
- * Please notice that for binary compat reasons MIPS has to
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
-enum sock_type {
-    TARGET_SOCK_DGRAM       = 1,
-    TARGET_SOCK_STREAM      = 2,
-    TARGET_SOCK_RAW         = 3,
-    TARGET_SOCK_RDM         = 4,
-    TARGET_SOCK_SEQPACKET   = 5,
-    TARGET_SOCK_DCCP        = 6,
-    TARGET_SOCK_PACKET      = 10,
-    TARGET_SOCK_CLOEXEC     = 02000000,
-    TARGET_SOCK_NONBLOCK    = 0x0080,
-};
-
-#define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
-#define TARGET_SOCK_TYPE_MASK 0xf  /* Covers up to TARGET_SOCK_MAX - 1. */
-
-#define ARCH_HAS_SOCKET_TYPES 1
diff --git a/linux-user/socket.h b/linux-user/socket.h
index 6f49255b5f..8f21843d14 100644
--- a/linux-user/socket.h
+++ b/linux-user/socket.h
@@ -103,34 +103,34 @@
 
 #endif
 
-#ifndef ARCH_HAS_SOCKET_TYPES
-    /** sock_type - Socket types - default values
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
-
-    #define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
-    #define TARGET_SOCK_TYPE_MASK  0xf  /* Covers up to TARGET_SOCK_MAX - 1. */
+#if defined(TARGET_MIPS)
+    #define TARGET_SOCK_DGRAM  1
+    #define TARGET_SOCK_STREAM 2
+#else
+    #define TARGET_SOCK_STREAM 1
+    #define TARGET_SOCK_DGRAM  2
+#endif
 
+#define TARGET_SOCK_RAW        3
+#define TARGET_SOCK_RDM        4
+#define TARGET_SOCK_SEQPACKET  5
+#define TARGET_SOCK_DCCP       6
+#define TARGET_SOCK_PACKET     10
+
+#if defined(TARGET_ALPHA) || defined(TARGET_HPPA)
+    #define TARGET_SOCK_CLOEXEC  010000000
+#else
+    #define TARGET_SOCK_CLOEXEC  02000000 /* 0x400000 */
 #endif
+
+#if defined(TARGET_MIPS)
+    #define TARGET_SOCK_NONBLOCK 0x0080
+#elif defined(TARGET_SPARC)
+    #define TARGET_SOCK_NONBLOCK 0x4000
+#elif defined(TARGET_ALPHA) || defined(TARGET_HPPA)
+    #define TARGET_SOCK_NONBLOCK 0x40000000
+#else
+    #define TARGET_SOCK_NONBLOCK 04000
+#endif
+
+#define TARGET_SOCK_TYPE_MASK  0xf
diff --git a/linux-user/sparc/sockbits.h b/linux-user/sparc/sockbits.h
index d51ae5f84f..70bee083bb 100644
--- a/linux-user/sparc/sockbits.h
+++ b/linux-user/sparc/sockbits.h
@@ -67,38 +67,3 @@
 #define TARGET_SO_SECURITY_ENCRYPTION_TRANSPORT  0x5002
 #define TARGET_SO_SECURITY_ENCRYPTION_NETWORK    0x5004
 
-/** sock_type - Socket types
- *
- * Please notice that for binary compat reasons SPARC has to
- * override the enum sock_type in include/linux/net.h, so
- * we define ARCH_HAS_SOCKET_TYPES here.
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
- */
-
-enum sock_type {
-    TARGET_SOCK_STREAM      = 1,
-    TARGET_SOCK_DGRAM       = 2,
-    TARGET_SOCK_RAW         = 3,
-    TARGET_SOCK_RDM         = 4,
-    TARGET_SOCK_SEQPACKET   = 5,
-    TARGET_SOCK_DCCP        = 6,
-    TARGET_SOCK_PACKET      = 10,
-    TARGET_SOCK_CLOEXEC     = 0x400000,
-    TARGET_SOCK_NONBLOCK    = 0x4000,
-};
-
-#define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
-#define TARGET_SOCK_TYPE_MASK 0xf  /* Covers up to TARGET_SOCK_MAX - 1. */
-
-#define ARCH_HAS_SOCKET_TYPES 1
-- 
2.14.1
