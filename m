Received: from eggs.gnu.org ([2001:4830:134:3::10]:60593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa2yX-00054L-Vz
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa2yX-0003i4-0X
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:50:58 -0400
Received: from mail-vk0-x235.google.com ([2607:f8b0:400c:c05::235]:43439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa2yW-0003hs-RJ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:50:56 -0400
Received: by mail-vk0-x235.google.com with SMTP id d74-v6so9635497vke.10
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 10:50:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  2 Jul 2018 14:50:23 -0300
Message-Id: <20180702175030.18621-7-f4bug@amsat.org>
In-Reply-To: <20180702175030.18621-1-f4bug@amsat.org>
References: <20180702175030.18621-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 06/13] linux-user/strace: Dump AF_NETLINK
 sockaddr content
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-By: Guido Günther <agx@sigxcpu.org>
---
 linux-user/syscall_defs.h |  7 +++++++
 linux-user/strace.c       | 34 ++++++++++++++++++++++++++++++++++
 linux-user/syscall.c      |  6 ++++--
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 40bb60ef4c..5a0b76721f 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -152,6 +152,13 @@ struct target_sockaddr_un {
     uint8_t sun_path[108];
 };
 
+struct target_sockaddr_nl {
+    uint16_t nl_family;     /* AF_NETLINK */
+    uint16_t __pad;
+    uint32_t nl_pid;
+    uint32_t nl_groups;
+};
+
 struct target_in_addr {
     uint32_t s_addr; /* big endian */
 };
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 8a21d3bcfc..77e36467cd 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -8,6 +8,7 @@
 #include <arpa/inet.h>
 #include <netinet/tcp.h>
 #include <linux/if_packet.h>
+#include <linux/netlink.h>
 #include <sched.h>
 #include "qemu.h"
 
@@ -398,6 +399,12 @@ print_sockaddr(abi_ulong addr, abi_long addrlen)
             gemu_log("}");
             break;
         }
+        case AF_NETLINK: {
+            struct target_sockaddr_nl *nl = (struct target_sockaddr_nl *)sa;
+            gemu_log("{nl_family=AF_NETLINK,nl_pid=%u,nl_groups=%u}",
+                     nl->nl_pid, nl->nl_groups);
+            break;
+        }
         default:
             gemu_log("{sa_family=%d, sa_data={", sa->sa_family);
             for (i = 0; i < 13; i++) {
@@ -424,6 +431,9 @@ print_socket_domain(int domain)
     case PF_INET:
         gemu_log("PF_INET");
         break;
+    case PF_NETLINK:
+        gemu_log("PF_NETLINK");
+        break;
     case PF_PACKET:
         gemu_log("PF_PACKET");
         break;
@@ -473,6 +483,30 @@ print_socket_protocol(int domain, int type, int protocol)
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
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ad40682cee..9a11f8c4a6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1696,8 +1696,10 @@ static inline abi_long host_to_target_sockaddr(abi_ulong target_addr,
         sizeof(target_saddr->sa_family)) {
         target_saddr->sa_family = tswap16(addr->sa_family);
     }
-    if (addr->sa_family == AF_NETLINK && len >= sizeof(struct sockaddr_nl)) {
-        struct sockaddr_nl *target_nl = (struct sockaddr_nl *)target_saddr;
+    if (addr->sa_family == AF_NETLINK &&
+        len >= sizeof(struct target_sockaddr_nl)) {
+        struct target_sockaddr_nl *target_nl =
+               (struct target_sockaddr_nl *)target_saddr;
         target_nl->nl_pid = tswap32(target_nl->nl_pid);
         target_nl->nl_groups = tswap32(target_nl->nl_groups);
     } else if (addr->sa_family == AF_PACKET) {
-- 
2.18.0
