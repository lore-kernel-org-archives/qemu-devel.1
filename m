Received: from eggs.gnu.org ([2001:4830:134:3::10]:43980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gXMuh-0005FN-Ll
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 04:04:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gXMub-0001HQ-PY
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 04:04:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60000
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gXMub-0001GE-Cu
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 04:04:05 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBD8xFVv053206
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 04:04:04 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2pbhp4sq0p-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 04:04:04 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 13 Dec 2018 09:04:02 -0000
From: Greg Kurz <groug@kaod.org>
Date: Thu, 13 Dec 2018 10:03:42 +0100
In-Reply-To: <20181213090343.1137475-1-groug@kaod.org>
References: <20181213090343.1137475-1-groug@kaod.org>
Message-Id: <20181213090343.1137475-3-groug@kaod.org>
Subject: [Qemu-devel] [PULL 2/3] xen/9pfs: use g_new(T,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

Because it is a recommended coding practice (see HACKING).

Signed-off-by: Greg Kurz <groug@kaod.org>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/9pfs/xen-9p-backend.c | 6 +++---
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
-- 
2.17.2
