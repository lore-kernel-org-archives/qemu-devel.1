Received: from eggs.gnu.org ([2001:4830:134:3::10]:39238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4VXJ-0006tD-Rp
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 12:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4VXH-0001LP-EG
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 12:47:57 -0400
Received: from hera.aquilenet.fr ([141.255.128.1]:54648)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4VXH-0001L8-7a
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 12:47:55 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sat, 29 Apr 2017 18:47:45 +0200
Message-Id: <20170429164750.17414-5-samuel.thibault@ens-lyon.org>
In-Reply-To: <20170429164750.17414-1-samuel.thibault@ens-lyon.org>
References: <20170429164750.17414-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PULL 4/9] slirp: fix pinging the virtual ipv4 DNS
 server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com

so that people do not think it is not working at least basically.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/ip_icmp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/slirp/ip_icmp.c b/slirp/ip_icmp.c
index 5ffc7a683d..0b667a429a 100644
--- a/slirp/ip_icmp.c
+++ b/slirp/ip_icmp.c
@@ -152,8 +152,9 @@ icmp_input(struct mbuf *m, int hlen)
   switch (icp->icmp_type) {
   case ICMP_ECHO:
     ip->ip_len += hlen;	             /* since ip_input subtracts this */
-    if (ip->ip_dst.s_addr == slirp->vhost_addr.s_addr) {
-      icmp_reflect(m);
+    if (ip->ip_dst.s_addr == slirp->vhost_addr.s_addr ||
+        ip->ip_dst.s_addr == slirp->vnameserver_addr.s_addr) {
+        icmp_reflect(m);
     } else if (slirp->restricted) {
         goto freeit;
     } else {
-- 
2.11.0
