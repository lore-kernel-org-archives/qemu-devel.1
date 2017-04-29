Received: from eggs.gnu.org ([2001:4830:134:3::10]:39497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4RmT-00015p-Lx
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 08:47:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4RmQ-00056h-KG
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 08:47:21 -0400
Received: from hera.aquilenet.fr ([141.255.128.1]:54071)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4RmQ-00056Y-DZ
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 08:47:18 -0400
Date: Sat, 29 Apr 2017 14:47:15 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Message-ID: <20170429124715.5xrpapuedv6nnpnd@var.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] slirp: fix pinging the virtual ipv4 DNS server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>

so that people do not think it is not working at least basically.
    
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

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
