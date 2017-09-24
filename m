Received: from eggs.gnu.org ([2001:4830:134:3::10]:33922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dwBKp-0004Z3-7q
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 14:08:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dwBKn-00058e-Ep
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 14:08:55 -0400
Received: from hera.aquilenet.fr ([141.255.128.1]:49421)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1dwBKn-00058A-7y
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 14:08:53 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 24 Sep 2017 20:08:48 +0200
Message-Id: <20170924180848.19168-4-samuel.thibault@ens-lyon.org>
In-Reply-To: <20170924180848.19168-1-samuel.thibault@ens-lyon.org>
References: <20170924180848.19168-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PULL 3/3] slirp: Add a special case for the NULL
 socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Cernekee <cernekee@chromium.org>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Kevin Cernekee <cernekee@chromium.org>

NULL sockets are used for NDP, BOOTP, and other critical operations.
If the topmost mbuf in a NULL session is blocked pending resolution,
it may cause problems if it blocks other packets with a NULL socket.
So do not add mbufs with a NULL socket field to the same session.

Signed-off-by: Kevin Cernekee <cernekee@chromium.org>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/if.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/slirp/if.c b/slirp/if.c
index 6262d77495..590753c658 100644
--- a/slirp/if.c
+++ b/slirp/if.c
@@ -73,14 +73,16 @@ if_output(struct socket *so, struct mbuf *ifm)
 	 * We mustn't put this packet back on the fastq (or we'll send it out of order)
 	 * XXX add cache here?
 	 */
-	for (ifq = (struct mbuf *) slirp->if_batchq.qh_rlink;
-	     (struct quehead *) ifq != &slirp->if_batchq;
-	     ifq = ifq->ifq_prev) {
-		if (so == ifq->ifq_so) {
-			/* A match! */
-			ifm->ifq_so = so;
-			ifs_insque(ifm, ifq->ifs_prev);
-			goto diddit;
+	if (so) {
+		for (ifq = (struct mbuf *) slirp->if_batchq.qh_rlink;
+		     (struct quehead *) ifq != &slirp->if_batchq;
+		     ifq = ifq->ifq_prev) {
+			if (so == ifq->ifq_so) {
+				/* A match! */
+				ifm->ifq_so = so;
+				ifs_insque(ifm, ifq->ifs_prev);
+				goto diddit;
+			}
 		}
 	}
 
-- 
2.14.1
