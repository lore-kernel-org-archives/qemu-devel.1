Received: from eggs.gnu.org ([2001:4830:134:3::10]:37625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <max7255@yandex-team.ru>) id 1gFpbn-0002vH-P8
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 20:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <max7255@yandex-team.ru>) id 1gFpbk-0007eF-Hz
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 20:04:11 -0400
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:60700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <max7255@yandex-team.ru>)
	id 1gFpbk-0007dE-0B
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 20:04:08 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
	[IPv6:2a02:6b8:0:1402::301])
	by forwardcorp1g.cmail.yandex.net (Yandex) with ESMTP id B6B2D21800
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 03:04:03 +0300 (MSK)
From: Maxim Samoylov <max7255@yandex-team.ru>
Date: Fri, 26 Oct 2018 03:03:40 +0300
Message-Id: <1540512223-21199-2-git-send-email-max7255@yandex-team.ru>
In-Reply-To: <1540512223-21199-1-git-send-email-max7255@yandex-team.ru>
References: <1540512223-21199-1-git-send-email-max7255@yandex-team.ru>
Subject: [Qemu-devel] [PATCH RFC 1/4] slirp: add helper for tcp6 socket
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
 slirp/socket.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 slirp/socket.h |  2 ++
 2 files changed, 75 insertions(+)

diff --git a/slirp/socket.c b/slirp/socket.c
index 322383a..e16e6c1 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -776,6 +776,79 @@ tcp_listen(Slirp *slirp, uint32_t haddr, u_int hport, uint32_t laddr,
 	return so;
 }
 
+struct socket *
+tcp6_listen(Slirp *slirp, struct in6_addr haddr, u_int hport,
+            struct in6_addr laddr, u_int lport, int flags)
+{
+    struct sockaddr_in6 addr;
+    struct socket *so;
+    int s, opt = 1;
+    socklen_t addrlen = sizeof(addr);
+    memset(&addr, 0, addrlen);
+
+    /* The same flow as in tcp_listen above */
+
+    so = socreate(slirp);
+    if (!so) {
+        return NULL;
+    }
+
+    so->so_tcpcb = tcp_newtcpcb(so);
+    if (so->so_tcpcb == NULL) {
+        free(so);
+        return NULL;
+    }
+
+    insque(so, &slirp->tcb);
+
+    if (flags & SS_FACCEPTONCE) {
+        so->so_tcpcb->t_timer[TCPT_KEEP] = TCPTV_KEEP_INIT * 2;
+    }
+
+    so->so_state &= SS_PERSISTENT_MASK;
+    so->so_state |= (SS_FACCEPTCONN | flags);
+    so->so_lfamily = AF_INET6;
+    so->so_lport6 = lport; /* Kept in network format */
+    so->so_laddr6 = laddr;
+
+    addr.sin6_family = AF_INET6;
+    addr.sin6_addr = haddr;
+    addr.sin6_port = hport;
+
+    s = qemu_socket(AF_INET6, SOCK_STREAM, 0);
+    if ((s < 0) ||
+        (socket_set_fast_reuse(s) < 0) ||
+        (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) ||
+        (listen(s, 1) < 0)) {
+        int tmperrno = errno; /* Don't clobber the real reason we failed */
+            if (s >= 0) {
+                closesocket(s);
+            }
+        sofree(so);
+        /* Restore the real errno */
+#ifdef _WIN32
+        WSASetLastError(tmperrno);
+#else
+        errno = tmperrno;
+#endif
+        return NULL;
+    }
+    qemu_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int));
+
+    getsockname(s, (struct sockaddr *)&addr, &addrlen);
+    so->fhost.sin6 = addr;
+
+    if (!memcmp(&addr.sin6_addr, &in6addr_any, sizeof(in6addr_any)) ||
+        !memcmp(&addr.sin6_addr, &in6addr_loopback,
+                sizeof(in6addr_loopback))) {
+
+        memcpy(&so->so_faddr6, &slirp->vhost_addr6, sizeof(slirp->vhost_addr6));
+    }
+
+    so->s = s;
+    return so;
+}
+
 /*
  * Various session state calls
  * XXX Should be #define's
diff --git a/slirp/socket.h b/slirp/socket.h
index 2f224bc..b200bb6 100644
--- a/slirp/socket.h
+++ b/slirp/socket.h
@@ -144,6 +144,8 @@ void sorecvfrom(struct socket *);
 int sosendto(struct socket *, struct mbuf *);
 struct socket * tcp_listen(Slirp *, uint32_t, u_int, uint32_t, u_int,
                                int);
+struct socket *tcp6_listen(Slirp *, struct in6_addr, u_int,
+                           struct in6_addr, u_int, int);
 void soisfconnecting(register struct socket *);
 void soisfconnected(register struct socket *);
 void sofwdrain(struct socket *);
-- 
2.7.4
