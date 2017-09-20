Received: from eggs.gnu.org ([2001:4830:134:3::10]:37650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cernekee@google.com>) id 1dulp8-00023p-2A
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 16:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cernekee@google.com>) id 1dulp3-0002Ve-VS
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 16:42:22 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:53075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cernekee@google.com>) id 1dulp3-0002UY-PP
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 16:42:17 -0400
Received: by mail-pf0-f181.google.com with SMTP id p87so2098921pfj.9
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 13:42:16 -0700 (PDT)
From: Kevin Cernekee <cernekee@chromium.org>
Date: Wed, 20 Sep 2017 13:42:05 -0700
Message-Id: <20170920204205.40191-2-cernekee@chromium.org>
In-Reply-To: <20170920204205.40191-1-cernekee@chromium.org>
References: <20170920204205.40191-1-cernekee@chromium.org>
Subject: [Qemu-devel] [PATCH 2/2] slirp: Add a special case for the NULL
 socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, samuel.thibault@ens-lyon.org
Cc: qemu-devel@nongnu.org

NULL sockets are used for NDP, BOOTP, and other critical operations.
If the topmost mbuf in a NULL session is blocked pending resolution,
it may cause problems if it blocks other packets with a NULL socket.
So do not add mbufs with a NULL socket field to the same session.

Signed-off-by: Kevin Cernekee <cernekee@chromium.org>
---
 slirp/if.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/slirp/if.c b/slirp/if.c
index 6262d7749563..590753c6582f 100644
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
2.14.1.821.g8fa685d3b7-goog
