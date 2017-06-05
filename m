Received: from eggs.gnu.org ([2001:4830:134:3::10]:43874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dHujJ-0006R7-Bg
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dHujI-0000rZ-C0
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:19:45 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dHujI-0000nn-4Z
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:19:44 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  5 Jun 2017 17:19:36 +0100
Message-Id: <1496679576-14336-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1496679576-14336-1-git-send-email-peter.maydell@linaro.org>
References: <1496679576-14336-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] slirp: Handle error returns from
 sosendoob()
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

sosendoob() can return a failure code, but all its callers ignore it.
This is OK in sbappend(), as the comment there states -- we will try
again later in sowrite(). Add a (void) cast to tell Coverity so.
In sowrite() we do need to check the return value -- we should handle
a write failure in sosendoob() the same way we handle a write failure
for the normal data.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 slirp/sbuf.c   |  2 +-
 slirp/socket.c | 22 ++++++++++++++++------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/slirp/sbuf.c b/slirp/sbuf.c
index 10119d3..912f235 100644
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
index a17caa9..84cf13a 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -404,7 +404,14 @@ sowrite(struct socket *so)
 	DEBUG_ARG("so = %p", so);
 
 	if (so->so_urgc) {
-		sosendoob(so);
+		if (sosendoob(so) < so->so_urgc) {
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
@@ -448,11 +455,7 @@ sowrite(struct socket *so)
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
@@ -479,6 +482,13 @@ sowrite(struct socket *so)
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
2.7.4
