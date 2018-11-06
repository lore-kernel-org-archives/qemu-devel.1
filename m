Received: from eggs.gnu.org ([2001:4830:134:3::10]:39732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gK3HV-0002AT-Cw
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:28:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gK3HL-0006xy-EZ
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:28:35 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gK3HL-0006vv-4e
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:28:31 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  6 Nov 2018 15:13:22 +0000
Message-Id: <20181106151323.16154-4-peter.maydell@linaro.org>
In-Reply-To: <20181106151323.16154-1-peter.maydell@linaro.org>
References: <20181106151323.16154-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.1 3/4] slirp: Remove code that handles
 socreate() failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>

Now that socreate() can never fail, we can remove the code
that was trying to handle that situation.

In particular this removes code in tcp_connect() that
provoked Coverity to complain (CID 1005724): in
 closesocket(accept(inso->s, (struct sockaddr *)&addr, &addrlen));
if the accept() call fails then we pass closesocket() -1
instead of a valid file descriptor.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 slirp/ip_icmp.c   | 2 +-
 slirp/slirp.c     | 3 ---
 slirp/socket.c    | 3 ---
 slirp/tcp_input.c | 3 +--
 slirp/tcp_subr.c  | 5 -----
 slirp/udp.c       | 6 ------
 slirp/udp6.c      | 3 ---
 7 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/slirp/ip_icmp.c b/slirp/ip_icmp.c
index da100d1f55f..9210eef3f35 100644
--- a/slirp/ip_icmp.c
+++ b/slirp/ip_icmp.c
@@ -160,7 +160,7 @@ icmp_input(struct mbuf *m, int hlen)
     } else {
       struct socket *so;
       struct sockaddr_storage addr;
-      if ((so = socreate(slirp)) == NULL) goto freeit;
+      so = socreate(slirp);
       if (icmp_send(so, m, hlen) == 0) {
         return;
       }
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 3c3c03b22f7..322edf51eb8 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -1477,9 +1477,6 @@ static int slirp_state_load(QEMUFile *f, void *opaque, int version_id)
         int ret;
         struct socket *so = socreate(slirp);
 
-        if (!so)
-            return -ENOMEM;
-
         ret = vmstate_load_state(f, &vmstate_slirp_socket, so, version_id);
 
         if (ret < 0)
diff --git a/slirp/socket.c b/slirp/socket.c
index 35a9a145659..c01d8696afb 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -713,9 +713,6 @@ tcp_listen(Slirp *slirp, uint32_t haddr, u_int hport, uint32_t laddr,
 	DEBUG_ARG("flags = %x", flags);
 
 	so = socreate(slirp);
-	if (!so) {
-	  return NULL;
-	}
 
 	/* Don't tcp_attach... we don't need so_snd nor so_rcv */
 	if ((so->so_tcpcb = tcp_newtcpcb(so)) == NULL) {
diff --git a/slirp/tcp_input.c b/slirp/tcp_input.c
index 4f79c95fdb4..d073ef95256 100644
--- a/slirp/tcp_input.c
+++ b/slirp/tcp_input.c
@@ -429,8 +429,7 @@ findso:
 	  if ((tiflags & (TH_SYN|TH_FIN|TH_RST|TH_URG|TH_ACK)) != TH_SYN)
 	    goto dropwithreset;
 
-	  if ((so = socreate(slirp)) == NULL)
-	    goto dropwithreset;
+          so = socreate(slirp);
 	  if (tcp_attach(so) < 0) {
             g_free(so); /* Not sofree (if it failed, it's not insqued) */
             goto dropwithreset;
diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index 0270c89ae3a..fa61349cbb0 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -469,11 +469,6 @@ void tcp_connect(struct socket *inso)
         so = inso;
     } else {
         so = socreate(slirp);
-        if (so == NULL) {
-            /* If it failed, get rid of the pending connection */
-            closesocket(accept(inso->s, (struct sockaddr *)&addr, &addrlen));
-            return;
-        }
         if (tcp_attach(so) < 0) {
             g_free(so); /* NOT sofree */
             return;
diff --git a/slirp/udp.c b/slirp/udp.c
index e5bf065bf23..c47870a61b4 100644
--- a/slirp/udp.c
+++ b/slirp/udp.c
@@ -171,9 +171,6 @@ udp_input(register struct mbuf *m, int iphlen)
 	   * create one
 	   */
 	  so = socreate(slirp);
-	  if (!so) {
-	      goto bad;
-	  }
 	  if (udp_attach(so, AF_INET) == -1) {
 	    DEBUG_MISC((dfd," udp_attach errno = %d-%s\n",
 			errno,strerror(errno)));
@@ -331,9 +328,6 @@ udp_listen(Slirp *slirp, uint32_t haddr, u_int hport, uint32_t laddr,
 	socklen_t addrlen = sizeof(struct sockaddr_in);
 
 	so = socreate(slirp);
-	if (!so) {
-	    return NULL;
-	}
 	so->s = qemu_socket(AF_INET,SOCK_DGRAM,0);
         if (so->s < 0) {
             sofree(so);
diff --git a/slirp/udp6.c b/slirp/udp6.c
index 7c4a6b003a8..986010f0d3a 100644
--- a/slirp/udp6.c
+++ b/slirp/udp6.c
@@ -91,9 +91,6 @@ void udp6_input(struct mbuf *m)
     if (so == NULL) {
         /* If there's no socket for this packet, create one. */
         so = socreate(slirp);
-        if (!so) {
-            goto bad;
-        }
         if (udp_attach(so, AF_INET6) == -1) {
             DEBUG_MISC((dfd, " udp6_attach errno = %d-%s\n",
                         errno, strerror(errno)));
-- 
2.19.1
