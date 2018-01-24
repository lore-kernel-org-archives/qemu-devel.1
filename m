Received: from eggs.gnu.org ([2001:4830:134:3::10]:50836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeKgO-00034k-2r
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:01:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeKgI-0005Ko-Gt
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:01:40 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:41612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeKgI-0005Kf-Dg
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:01:34 -0500
Received: by mail-qt0-x242.google.com with SMTP id i1so9995517qtj.8
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 05:01:34 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 24 Jan 2018 10:01:16 -0300
Message-Id: <20180124130126.20871-2-f4bug@amsat.org>
In-Reply-To: <20180124130126.20871-1-f4bug@amsat.org>
References: <20180124130126.20871-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 01/11] linux-user/strace: dump AF_NETLINK
 sockaddr content
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
please double check __pad and ntohl()

 linux-user/syscall_defs.h |  7 +++++++
 linux-user/strace.c       | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index bec3680b94..550e7d2939 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -151,6 +151,13 @@ struct target_sockaddr_un {
     uint8_t sun_path[108];
 };
 
+struct target_sockaddr_nl {
+    uint16_t nl_family;     /* AF_NETLINK */
+    int16_t __pad;
+    uint32_t nl_pid;
+    uint32_t nl_groups;
+};
+
 struct target_in_addr {
     uint32_t s_addr; /* big endian */
 };
diff --git a/linux-user/strace.c b/linux-user/strace.c
index bd897a3f20..7eb5e2ab48 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -8,6 +8,7 @@
 #include <arpa/inet.h>
 #include <netinet/tcp.h>
 #include <linux/if_packet.h>
+#include <linux/netlink.h>
 #include <sched.h>
 #include "qemu.h"
 
@@ -397,6 +398,12 @@ print_sockaddr(abi_ulong addr, abi_long addrlen)
             gemu_log("}");
             break;
         }
+        case AF_NETLINK: {
+            struct target_sockaddr_nl *nl = (struct target_sockaddr_nl *)sa;
+            gemu_log("{nl_family=AF_NETLINK,nl_pid=%u,nl_groups=%u}",
+                     ntohl(nl->nl_pid), ntohl(nl->nl_groups));
+            break;
+        }
         default:
             gemu_log("{sa_family=%d, sa_data={", sa->sa_family);
             for (i = 0; i < 13; i++) {
@@ -423,6 +430,9 @@ print_socket_domain(int domain)
     case PF_INET:
         gemu_log("PF_INET");
         break;
+    case PF_NETLINK:
+        gemu_log("PF_NETLINK");
+        break;
     case PF_PACKET:
         gemu_log("PF_PACKET");
         break;
@@ -472,6 +482,30 @@ print_socket_protocol(int domain, int type, int protocol)
         return;
     }
 
+    if (domain == AF_NETLINK) {
+        switch (protocol) {
+        case NETLINK_ROUTE:
+            gemu_log("NETLINK_ROUTE");
+            break;
+        case NETLINK_AUDIT:
+            gemu_log("NETLINK_AUDIT");
+            break;
+        case NETLINK_NETFILTER:
+            gemu_log("NETLINK_NETFILTER");
+            break;
+        case NETLINK_RDMA:
+            gemu_log("NETLINK_RDMA");
+            break;
+        case NETLINK_CRYPTO:
+            gemu_log("NETLINK_CRYPTO");
+            break;
+        default:
+            gemu_log("%d", protocol);
+            break;
+        }
+        return;
+    }
+
     switch (protocol) {
     case IPPROTO_IP:
         gemu_log("IPPROTO_IP");
-- 
2.15.1
