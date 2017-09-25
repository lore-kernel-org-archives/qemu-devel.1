Received: from eggs.gnu.org ([2001:4830:134:3::10]:44056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dwcf7-0007gs-5p
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dwcf5-0001vN-FZ
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:19:41 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:34198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1dwcf5-0001uh-7v
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:19:39 -0400
Received: by mail-pg0-x242.google.com with SMTP id u18so5688030pgo.1
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:19:39 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Date: Mon, 25 Sep 2017 16:19:20 -0700
Message-Id: <20170925231924.31303-3-carenas@gmail.com>
In-Reply-To: <20170925231924.31303-2-carenas@gmail.com>
References: <20170925231924.31303-1-carenas@gmail.com>
	<20170925231924.31303-2-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/6] linux-user: refactor socket.h for alpha
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

based on fresh bits from linux 4.14 and therefore enabling SO_REUSEPORT
as a side effect

to easy on maintenance SO_NONBLOCK updated to match the value from linux
headers (in hexadecimal) as seen in arch/alpha/include/asm/socket.h

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 linux-user/alpha/sockbits.h | 104 ++++++++++++++++++++++++++++++++++++++++++++
 linux-user/socket.h         | 104 +-------------------------------------------
 2 files changed, 105 insertions(+), 103 deletions(-)
 create mode 100644 linux-user/alpha/sockbits.h

diff --git a/linux-user/alpha/sockbits.h b/linux-user/alpha/sockbits.h
new file mode 100644
index 0000000000..768579a1f7
--- /dev/null
+++ b/linux-user/alpha/sockbits.h
@@ -0,0 +1,104 @@
+#define TARGET_SOL_SOCKET                       0xffff
+
+#define TARGET_SO_DEBUG                         0x0001
+#define TARGET_SO_REUSEADDR                     0x0004
+#define TARGET_SO_KEEPALIVE                     0x0008
+#define TARGET_SO_DONTROUTE                     0x0010
+#define TARGET_SO_BROADCAST                     0x0020
+#define TARGET_SO_LINGER                        0x0080
+#define TARGET_SO_OOBINLINE                     0x0100
+#define TARGET_SO_REUSEPORT                     0x0200
+#define TARGET_SO_TYPE                          0x1008
+#define TARGET_SO_ERROR                         0x1007
+#define TARGET_SO_SNDBUF                        0x1001
+#define TARGET_SO_RCVBUF                        0x1002
+#define TARGET_SO_SNDBUFFORCE                   0x100a
+#define TARGET_SO_RCVBUFFORCE                   0x100b
+#define TARGET_SO_RCVLOWAT                      0x1010
+#define TARGET_SO_SNDLOWAT                      0x1011
+#define TARGET_SO_RCVTIMEO                      0x1012
+#define TARGET_SO_SNDTIMEO                      0x1013
+#define TARGET_SO_ACCEPTCONN                    0x1014
+#define TARGET_SO_PROTOCOL                      0x1028
+#define TARGET_SO_DOMAIN                        0x1029
+#define TARGET_SO_NO_CHECK                      11
+#define TARGET_SO_PRIORITY                      12
+#define TARGET_SO_BSDCOMPAT                     14
+#define TARGET_SO_PASSCRED                      17
+#define TARGET_SO_PEERCRED                      18
+#define TARGET_SO_BINDTODEVICE                  25
+#define TARGET_SO_ATTACH_FILTER                 26
+#define TARGET_SO_DETACH_FILTER                 27
+#define TARGET_SO_GET_FILTER                    TARGET_SO_ATTACH_FILTER
+#define TARGET_SO_PEERNAME                      28
+#define TARGET_SO_TIMESTAMP                     29
+#define TARGET_SCM_TIMESTAMP                    TARGET_SO_TIMESTAMP
+#define TARGET_SO_PEERSEC                       30
+#define TARGET_SO_PASSSEC                       34
+#define TARGET_SO_TIMESTAMPNS                   35
+#define TARGET_SCM_TIMESTAMPNS                  TARGET_SO_TIMESTAMPNS
+#define TARGET_SO_SECURITY_AUTHENTICATION       19
+#define TARGET_SO_SECURITY_ENCRYPTION_TRANSPORT 20
+#define TARGET_SO_SECURITY_ENCRYPTION_NETWORK   21
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
+ * Please notice that for binary compat reasons ALPHA has to
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
+    TARGET_SOCK_CLOEXEC     = 010000000,
+    TARGET_SOCK_NONBLOCK    = 0x40000000,
+};
+
+#define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
+#define TARGET_SOCK_TYPE_MASK 0xf  /* Covers up to TARGET_SOCK_MAX - 1. */
+
+#define ARCH_HAS_SOCKET_TYPES 1
diff --git a/linux-user/socket.h b/linux-user/socket.h
index c7e6cb8ea1..115bdf2ddb 100644
--- a/linux-user/socket.h
+++ b/linux-user/socket.h
@@ -102,109 +102,7 @@
     #define TARGET_SOCK_TYPE_MASK    0xf  /* Covers up to TARGET_SOCK_MAX-1. */
 
 #elif defined(TARGET_ALPHA)
-
-    /* For setsockopt(2) */
-    #define TARGET_SOL_SOCKET   0xffff
-
-    #define TARGET_SO_DEBUG 0x0001
-    #define TARGET_SO_REUSEADDR 0x0004
-    #define TARGET_SO_KEEPALIVE 0x0008
-    #define TARGET_SO_DONTROUTE 0x0010
-    #define TARGET_SO_BROADCAST 0x0020
-    #define TARGET_SO_LINGER    0x0080
-    #define TARGET_SO_OOBINLINE 0x0100
-    /* To add :#define TARGET_SO_REUSEPORT 0x0200 */
-
-    #define TARGET_SO_TYPE      0x1008
-    #define TARGET_SO_ERROR 0x1007
-    #define TARGET_SO_SNDBUF    0x1001
-    #define TARGET_SO_RCVBUF    0x1002
-    #define TARGET_SO_SNDBUFFORCE   0x100a
-    #define TARGET_SO_RCVBUFFORCE   0x100b
-    #define TARGET_SO_RCVLOWAT  0x1010
-    #define TARGET_SO_SNDLOWAT  0x1011
-    #define TARGET_SO_RCVTIMEO  0x1012
-    #define TARGET_SO_SNDTIMEO  0x1013
-    #define TARGET_SO_ACCEPTCONN    0x1014
-    #define TARGET_SO_PROTOCOL  0x1028
-    #define TARGET_SO_DOMAIN    0x1029
-
-    /* linux-specific, might as well be the same as on i386 */
-    #define TARGET_SO_NO_CHECK  11
-    #define TARGET_SO_PRIORITY  12
-    #define TARGET_SO_BSDCOMPAT 14
-
-    #define TARGET_SO_PASSCRED  17
-    #define TARGET_SO_PEERCRED  18
-    #define TARGET_SO_BINDTODEVICE 25
-
-    /* Socket filtering */
-    #define TARGET_SO_ATTACH_FILTER        26
-    #define TARGET_SO_DETACH_FILTER        27
-
-    #define TARGET_SO_PEERNAME      28
-    #define TARGET_SO_TIMESTAMP     29
-    #define TARGET_SCM_TIMESTAMP        TARGET_SO_TIMESTAMP
-
-    #define TARGET_SO_PEERSEC       30
-    #define TARGET_SO_PASSSEC       34
-    #define TARGET_SO_TIMESTAMPNS       35
-    #define TARGET_SCM_TIMESTAMPNS      TARGET_SO_TIMESTAMPNS
-
-    /* Security levels - as per NRL IPv6 - don't actually do anything */
-    #define TARGET_SO_SECURITY_AUTHENTICATION       19
-    #define TARGET_SO_SECURITY_ENCRYPTION_TRANSPORT 20
-    #define TARGET_SO_SECURITY_ENCRYPTION_NETWORK       21
-
-    #define TARGET_SO_MARK          36
-
-    #define TARGET_SO_TIMESTAMPING      37
-    #define TARGET_SCM_TIMESTAMPING TARGET_SO_TIMESTAMPING
-
-    #define TARGET_SO_RXQ_OVFL             40
-
-    #define TARGET_SO_WIFI_STATUS       41
-    #define TARGET_SCM_WIFI_STATUS      TARGET_SO_WIFI_STATUS
-    #define TARGET_SO_PEEK_OFF      42
-
-    /* Instruct lower device to use last 4-bytes of skb data as FCS */
-    #define TARGET_SO_NOFCS     43
-
-    /** sock_type - Socket types
-     *
-     * Please notice that for binary compat reasons ALPHA has to
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
-           TARGET_SOCK_CLOEXEC     = 010000000,
-           TARGET_SOCK_NONBLOCK    = 010000000000,
-    };
-
-    #define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
-    #define TARGET_SOCK_TYPE_MASK    0xf  /* Covers up to TARGET_SOCK_MAX-1. */
+#include "alpha/sockbits.h"
 #elif defined(TARGET_HPPA)
 #include "hppa/sockbits.h"
 #else
-- 
2.14.1
