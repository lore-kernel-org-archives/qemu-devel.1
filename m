Received: from eggs.gnu.org ([2001:4830:134:3::10]:37604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <max7255@yandex-team.ru>) id 1gFpbm-0002v6-Af
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 20:04:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <max7255@yandex-team.ru>) id 1gFpbk-0007eK-Hy
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 20:04:10 -0400
Received: from forwardcorp1j.cmail.yandex.net ([2a02:6b8:0:1630::190]:34835)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <max7255@yandex-team.ru>)
	id 1gFpbk-0007dP-0C
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 20:04:08 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
	[IPv6:2a02:6b8:0:1619::119])
	by forwardcorp1j.cmail.yandex.net (Yandex) with ESMTP id 0F65F20F6F
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 03:04:05 +0300 (MSK)
From: Maxim Samoylov <max7255@yandex-team.ru>
Date: Fri, 26 Oct 2018 03:03:42 +0300
Message-Id: <1540512223-21199-4-git-send-email-max7255@yandex-team.ru>
In-Reply-To: <1540512223-21199-1-git-send-email-max7255@yandex-team.ru>
References: <1540512223-21199-1-git-send-email-max7255@yandex-team.ru>
Subject: [Qemu-devel] [PATCH RFC 3/4] slirp: add helpers for ipv6 hostfwd
 manipulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: max7255@yandex-team.ru

Signed-off-by: Maxim Samoylov <max7255@yandex-team.ru>
---
 slirp/libslirp.h |  6 ++++++
 slirp/slirp.c    | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 42e42e9..3710650 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -34,6 +34,12 @@ int slirp_add_hostfwd(Slirp *slirp, int is_udp,
                       struct in_addr guest_addr, int guest_port);
 int slirp_remove_hostfwd(Slirp *slirp, int is_udp,
                          struct in_addr host_addr, int host_port);
+int slirp_add_ipv6_hostfwd(Slirp *slirp, int is_udp,
+                           struct in6_addr host_addr, int host_port,
+                           struct in6_addr guest_addr, int guest_port);
+int slirp_remove_ipv6_hostfwd(Slirp *slirp, int is_udp,
+                              struct in6_addr host_addr, int host_port);
+
 int slirp_add_exec(Slirp *slirp, int do_pty, const void *args,
                    struct in_addr *guest_addr, int guest_port);
 
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 51de41f..143ddea 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -1065,6 +1065,49 @@ int slirp_add_hostfwd(Slirp *slirp, int is_udp, struct in_addr host_addr,
     return 0;
 }
 
+int slirp_remove_ipv6_hostfwd(Slirp *slirp, int is_udp,
+                              struct in6_addr host_addr, int host_port)
+{
+    struct socket *so;
+    struct socket *head = (is_udp ? &slirp->udb : &slirp->tcb);
+    struct sockaddr_in6 addr;
+    int port = htons(host_port);
+    socklen_t addr_len;
+
+    for (so = head->so_next; so != head; so = so->so_next) {
+        addr_len = sizeof(addr);
+        if ((so->so_state & SS_HOSTFWD) &&
+            getsockname(so->s, (struct sockaddr *)&addr, &addr_len) == 0 &&
+            addr_len == sizeof(host_addr) &&
+            !memcmp(&host_addr, &addr, addr_len) &&
+            addr.sin6_port == port) {
+
+            close(so->s);
+            sofree(so);
+            return 0;
+        }
+    }
+
+    return -1;
+}
+
+int slirp_add_ipv6_hostfwd(Slirp *slirp, int is_udp,
+                          struct in6_addr host_addr, int host_port,
+                          struct in6_addr guest_addr, int guest_port)
+{
+    if (is_udp) {
+        if (!udp6_listen(slirp, host_addr, htons(host_port),
+                         guest_addr, htons(guest_port), SS_HOSTFWD))
+            return -1;
+    } else {
+        if (!tcp6_listen(slirp, host_addr, htons(host_port),
+                         guest_addr, htons(guest_port), SS_HOSTFWD))
+            return -1;
+    }
+
+    return 0;
+}
+
 int slirp_add_exec(Slirp *slirp, int do_pty, const void *args,
                    struct in_addr *guest_addr, int guest_port)
 {
-- 
2.7.4
