Received: from eggs.gnu.org ([2001:4830:134:3::10]:59535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fOT9r-00041z-Ou
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fOT9q-0008R6-Ot
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:22:47 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:55070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fOT9q-0008QM-IN
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:22:46 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu, 31 May 2018 21:22:34 +0200
Message-Id: <20180531192237.3994-7-samuel.thibault@ens-lyon.org>
In-Reply-To: <20180531192237.3994-1-samuel.thibault@ens-lyon.org>
References: <20180531192237.3994-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PULL 6/9] slirp: Send window updates to guest after
 window was closed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: James Clarke <jrtc27@jrtc27.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: James Clarke <jrtc27@jrtc27.com>

If the receive window presented to the guest closes, slirp should send a
window update once the window reopens sufficiently, rather than forcing
the guest to send a window probe, which can take several seconds.

Signed-off-by: James Clarke <jrtc27@jrtc27.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/slirp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/slirp/slirp.c b/slirp/slirp.c
index 4f29753444..5c3bd6163f 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -678,13 +678,13 @@ void slirp_pollfds_poll(GArray *pollfds, int select_error)
                         /* continue; */
                     } else {
                         ret = sowrite(so);
+                        if (ret > 0) {
+                            /* Call tcp_output in case we need to send a window
+                             * update to the guest, otherwise it will be stuck
+                             * until it sends a window probe. */
+                            tcp_output(sototcpcb(so));
+                        }
                     }
-                    /*
-                     * XXXXX If we wrote something (a lot), there
-                     * could be a need for a window update.
-                     * In the worst case, the remote will send
-                     * a window probe to get things going again
-                     */
                 }
 
                 /*
-- 
2.17.0
