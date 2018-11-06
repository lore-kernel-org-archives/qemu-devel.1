Received: from eggs.gnu.org ([2001:4830:134:3::10]:39769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gK3HZ-0002CL-6C
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:28:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gK3HV-00073n-FB
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:28:43 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gK3HM-0006vv-7C
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:28:35 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  6 Nov 2018 15:13:21 +0000
Message-Id: <20181106151323.16154-3-peter.maydell@linaro.org>
In-Reply-To: <20181106151323.16154-1-peter.maydell@linaro.org>
References: <20181106151323.16154-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.1 2/4] slirp: Use g_new() to allocate
 sockets in socreate()
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

The slirp socreate() function can only fail if the attempt
to malloc() the struct socket fails. Switch to using
g_new() instead, which will allow us to remove the
error-handling code from its callers.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
We already use g_new/g_malloc in slirp, including for
mbuf buffers which are larger than these socket structs.
The motivation here is that we can render moot a Coverity
complaint about an issue in an error-handling path.

As usual, indenting in slirp code is a bit of a mess;
I've opted for "keep checkpatch happy".
---
 slirp/socket.c    | 14 ++++++--------
 slirp/tcp_input.c |  4 ++--
 slirp/tcp_subr.c  |  2 +-
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/slirp/socket.c b/slirp/socket.c
index 322383a1f9f..35a9a145659 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -46,17 +46,15 @@ struct socket *solookup(struct socket **last, struct socket *head,
 struct socket *
 socreate(Slirp *slirp)
 {
-  struct socket *so;
+    struct socket *so = g_new(struct socket, 1);
 
-  so = (struct socket *)malloc(sizeof(struct socket));
-  if(so) {
     memset(so, 0, sizeof(struct socket));
     so->so_state = SS_NOFDREF;
     so->s = -1;
     so->slirp = slirp;
     so->pollfds_idx = -1;
-  }
-  return(so);
+
+    return so;
 }
 
 /*
@@ -110,7 +108,7 @@ sofree(struct socket *so)
   if (so->so_tcpcb) {
       free(so->so_tcpcb);
   }
-  free(so);
+  g_free(so);
 }
 
 size_t sopreprbuf(struct socket *so, struct iovec *iov, int *np)
@@ -721,8 +719,8 @@ tcp_listen(Slirp *slirp, uint32_t haddr, u_int hport, uint32_t laddr,
 
 	/* Don't tcp_attach... we don't need so_snd nor so_rcv */
 	if ((so->so_tcpcb = tcp_newtcpcb(so)) == NULL) {
-		free(so);
-		return NULL;
+            g_free(so);
+            return NULL;
 	}
 	insque(so, &slirp->tcb);
 
diff --git a/slirp/tcp_input.c b/slirp/tcp_input.c
index 07bcbdb2ddd..4f79c95fdb4 100644
--- a/slirp/tcp_input.c
+++ b/slirp/tcp_input.c
@@ -432,8 +432,8 @@ findso:
 	  if ((so = socreate(slirp)) == NULL)
 	    goto dropwithreset;
 	  if (tcp_attach(so) < 0) {
-	    free(so); /* Not sofree (if it failed, it's not insqued) */
-	    goto dropwithreset;
+            g_free(so); /* Not sofree (if it failed, it's not insqued) */
+            goto dropwithreset;
 	  }
 
 	  sbreserve(&so->so_snd, TCP_SNDSPACE);
diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index 8d0f94b75fc..0270c89ae3a 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -475,7 +475,7 @@ void tcp_connect(struct socket *inso)
             return;
         }
         if (tcp_attach(so) < 0) {
-            free(so); /* NOT sofree */
+            g_free(so); /* NOT sofree */
             return;
         }
         so->lhost = inso->lhost;
-- 
2.19.1
