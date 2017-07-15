Received: from eggs.gnu.org ([2001:4830:134:3::10]:35850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dWMDv-00059u-Vs
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 08:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dWMDv-00064g-3y
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 08:31:03 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:52266)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dWMDu-00064D-TJ
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 08:31:03 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sat, 15 Jul 2017 14:30:57 +0200
Message-Id: <20170715123057.8529-5-samuel.thibault@ens-lyon.org>
In-Reply-To: <20170715123057.8529-1-samuel.thibault@ens-lyon.org>
References: <20170715123057.8529-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PULL 4/4] slirp: Handle error returns from sosendoob()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Peter Maydell <peter.maydell@linaro.org>

sosendoob() can return a failure code, but all its callers ignore it.
This is OK in sbappend(), as the comment there states -- we will try
again later in sowrite(). Add a (void) cast to tell Coverity so.
In sowrite() we do need to check the return value -- we should handle
a write failure in sosendoob() the same way we handle a write failure
for the normal data.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/sbuf.c   |  2 +-
 slirp/socket.c | 23 +++++++++++++++++------
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/slirp/sbuf.c b/slirp/sbuf.c
index 10119d3ad5..912f235f65 100644
--- a/slirp/sbuf.c
+++ b/slirp/sbuf.c
@@ -91,7 +91,7 @@ sbappend(struct socket *so, struct mbuf *m)
 	if (so->so_urgc) {
 		sbappendsb(&so->so_rcv, m);
 		m_free(m);
-		sosendoob(so);
+		(void)sosendoob(so);
 		return;
 	}
 
diff --git a/slirp/socket.c b/slirp/socket.c
index a17caa9fa7..ecec0295a9 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -404,7 +404,15 @@ sowrite(struct socket *so)
 	DEBUG_ARG("so = %p", so);
 
 	if (so->so_urgc) {
-		sosendoob(so);
+		uint32_t expected = so->so_urgc;
+		if (sosendoob(so) < expected) {
+			/* Treat a short write as a fatal error too,
+			 * rather than continuing on and sending the urgent
+			 * data as if it were non-urgent and leaving the
+			 * so_urgc count wrong.
+			 */
+			goto err_disconnected;
+		}
 		if (sb->sb_cc == 0)
 			return 0;
 	}
@@ -448,11 +456,7 @@ sowrite(struct socket *so)
 		return 0;
 
 	if (nn <= 0) {
-		DEBUG_MISC((dfd, " --- sowrite disconnected, so->so_state = %x, errno = %d\n",
-			so->so_state, errno));
-		sofcantsendmore(so);
-		tcp_sockclosed(sototcpcb(so));
-		return -1;
+		goto err_disconnected;
 	}
 
 #ifndef HAVE_READV
@@ -479,6 +483,13 @@ sowrite(struct socket *so)
 		sofcantsendmore(so);
 
 	return nn;
+
+err_disconnected:
+	DEBUG_MISC((dfd, " --- sowrite disconnected, so->so_state = %x, errno = %d\n",
+		    so->so_state, errno));
+	sofcantsendmore(so);
+	tcp_sockclosed(sototcpcb(so));
+	return -1;
 }
 
 /*
-- 
2.13.2
