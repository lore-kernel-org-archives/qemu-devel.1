Received: from eggs.gnu.org ([2001:4830:134:3::10]:37602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <max7255@yandex-team.ru>) id 1gFpbm-0002v5-A8
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 20:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <max7255@yandex-team.ru>) id 1gFpbk-0007eJ-Hx
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 20:04:10 -0400
Received: from forwardcorp1j.cmail.yandex.net ([2a02:6b8:0:1630::190]:34832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <max7255@yandex-team.ru>)
	id 1gFpbk-0007dL-0D
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 20:04:08 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
	[IPv6:2a02:6b8:0:1a2d::301])
	by forwardcorp1j.cmail.yandex.net (Yandex) with ESMTP id 637D920F69
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 03:04:04 +0300 (MSK)
From: Maxim Samoylov <max7255@yandex-team.ru>
Date: Fri, 26 Oct 2018 03:03:41 +0300
Message-Id: <1540512223-21199-3-git-send-email-max7255@yandex-team.ru>
In-Reply-To: <1540512223-21199-1-git-send-email-max7255@yandex-team.ru>
References: <1540512223-21199-1-git-send-email-max7255@yandex-team.ru>
Subject: [Qemu-devel] [PATCH RFC 2/4] slirp: add helper for udp6 socket
 creation
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
 slirp/udp.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 slirp/udp.h |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/slirp/udp.c b/slirp/udp.c
index e5bf065..ab24935 100644
--- a/slirp/udp.c
+++ b/slirp/udp.c
@@ -366,3 +366,51 @@ udp_listen(Slirp *slirp, uint32_t haddr, u_int hport, uint32_t laddr,
 
 	return so;
 }
+
+struct socket *
+udp6_listen(Slirp *slirp, struct in6_addr haddr, u_int hport,
+            struct in6_addr laddr, u_int lport, int flags)
+{
+    struct sockaddr_in6 addr;
+    struct socket *so;
+    socklen_t addrlen = sizeof(addr);
+
+    memset(&addr, 0, sizeof(addr));
+
+    so = socreate(slirp);
+    if (!so) {
+        return NULL;
+    }
+    so->s = qemu_socket(AF_INET6, SOCK_DGRAM, 0);
+        if (so->s < 0) {
+            sofree(so);
+            return NULL;
+        }
+    so->so_expire = curtime + SO_EXPIRE;
+    insque(so, &slirp->udb);
+
+    addr.sin6_family = AF_INET6;
+    addr.sin6_addr = haddr;
+    addr.sin6_port = hport;
+
+    if (bind(so->s, (struct sockaddr *)&addr, addrlen) < 0) {
+        udp_detach(so);
+        return NULL;
+    }
+    socket_set_fast_reuse(so->s);
+
+    getsockname(so->s, (struct sockaddr *)&addr, &addrlen);
+    so->fhost.sin6 = addr;
+    sotranslate_accept(so);
+    so->so_lfamily = AF_INET6;
+    so->so_lport = lport;
+    so->so_laddr6 = laddr;
+    if (flags != SS_FACCEPTONCE) {
+        so->so_expire = 0;
+    }
+
+    so->so_state &= SS_PERSISTENT_MASK;
+    so->so_state |= SS_ISFCONNECTED | flags;
+
+    return so;
+}
diff --git a/slirp/udp.h b/slirp/udp.h
index be657cf..862c6e8 100644
--- a/slirp/udp.h
+++ b/slirp/udp.h
@@ -80,6 +80,8 @@ int udp_attach(struct socket *, unsigned short af);
 void udp_detach(struct socket *);
 struct socket * udp_listen(Slirp *, uint32_t, u_int, uint32_t, u_int,
                            int);
+struct socket *udp6_listen(Slirp *slirp, struct in6_addr, u_int,
+                            struct in6_addr, u_int, int);
 int udp_output(struct socket *so, struct mbuf *m,
                 struct sockaddr_in *saddr, struct sockaddr_in *daddr,
                 int iptos);
-- 
2.7.4
