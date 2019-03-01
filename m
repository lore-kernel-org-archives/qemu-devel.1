Received: from eggs.gnu.org ([209.51.188.92]:46767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <will@wbowling.info>) id 1gzpzL-0001fB-FJ
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 16:46:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <will@wbowling.info>) id 1gzpzK-0005By-9J
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 16:46:39 -0500
Received: from wbowling.info ([2400:8901::f03c:91ff:fe59:6f11]:51508)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <will@wbowling.info>) id 1gzpzG-0004wT-TF
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 16:46:38 -0500
From: William Bowling <will@wbowling.info>
Date: Fri,  1 Mar 2019 21:45:56 +0000
Message-Id: <1551476756-25749-1-git-send-email-will@wbowling.info>
Subject: [Qemu-devel] [PATCH] slirp: check sscanf result when emulating ident
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: secalert@redhat.com, William Bowling <will@wbowling.info>

When emulating ident in tcp_emu, if the strchr checks passed but the
sscanf check failed, two uninitialized variables would be copied and
sent in the reply.

Signed-off-by: William Bowling <will@wbowling.info>
---
 slirp/tcp_subr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index 262a42d6c8..73a160ba16 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -664,12 +664,12 @@ tcp_emu(struct socket *so, struct mbuf *m)
 							break;
 						}
 					}
-				}
-                                so_rcv->sb_cc = snprintf(so_rcv->sb_data,
-                                                         so_rcv->sb_datalen,
-                                                         "%d,%d\r\n", n1, n2);
-				so_rcv->sb_rptr = so_rcv->sb_data;
-				so_rcv->sb_wptr = so_rcv->sb_data + so_rcv->sb_cc;
+                    so_rcv->sb_cc = snprintf(so_rcv->sb_data,
+                                             so_rcv->sb_datalen,
+                                             "%d,%d\r\n", n1, n2);
+                    so_rcv->sb_rptr = so_rcv->sb_data;
+                    so_rcv->sb_wptr = so_rcv->sb_data + so_rcv->sb_cc;
+                }
 			}
 			m_free(m);
 			return 0;
-- 
2.15.1
