Received: from eggs.gnu.org ([2001:4830:134:3::10]:50694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gSOXL-0007Ux-7a
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:47:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gSOXI-0006X1-3V
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:47:31 -0500
Received: from 3.mo7.mail-out.ovh.net ([46.105.34.113]:49924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gSOXH-0006WB-Se
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:47:28 -0500
Received: from player772.ha.ovh.net (unknown [10.109.146.50])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 691D3ED20B
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 16:47:26 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 29 Nov 2018 16:47:22 +0100
Message-ID: <154350644254.788685.1054122983905807739.stgit@bahia.lan>
In-Reply-To: <154350643288.788685.710801848628732800.stgit@bahia.lan>
References: <154350643288.788685.710801848628732800.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH for 4.0 2/2] xen/9pfs: use g_new(T,
 n) instead of g_malloc(sizeof(T) * n)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

Because it is a recommended coding practice (see HACKING).

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/xen-9p-backend.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 3f54a21c7623..9015fe7773d0 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -178,7 +178,7 @@ static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *pdu,
 
     g_free(ring->sg);
 
-    ring->sg = g_malloc0(sizeof(*ring->sg) * 2);
+    ring->sg = g_new0(struct iovec, 2);
     xen_9pfs_out_sg(ring, ring->sg, &num, pdu->idx);
     *piov = ring->sg;
     *pniov = num;
@@ -196,7 +196,7 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
 
     g_free(ring->sg);
 
-    ring->sg = g_malloc0(sizeof(*ring->sg) * 2);
+    ring->sg = g_new0(struct iovec, 2);
     xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, size);
 
     buf_size = iov_size(ring->sg, num);
@@ -368,7 +368,7 @@ static int xen_9pfs_connect(struct XenDevice *xendev)
         return -1;
     }
 
-    xen_9pdev->rings = g_malloc0(xen_9pdev->num_rings * sizeof(Xen9pfsRing));
+    xen_9pdev->rings = g_new0(Xen9pfsRing, xen_9pdev->num_rings);
     for (i = 0; i < xen_9pdev->num_rings; i++) {
         char *str;
         int ring_order;
