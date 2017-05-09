Received: from eggs.gnu.org ([2001:4830:134:3::10]:44226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d8ART-0001gl-HZ
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d8ARP-0001DD-Is
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:05:03 -0400
Received: from mail.kernel.org ([198.145.29.136]:43438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1d8ARP-0001Ct-Cy
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:04:59 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Tue,  9 May 2017 12:04:51 -0700
Message-Id: <1494356693-13190-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PATCH v2 1/3] xen/9pfs: fix two resource leaks on
 error paths, discovered by Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xen.org, sstabellini@kernel.org, anthony.perard@citrix.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com

CID: 1374836

Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
CC: anthony.perard@citrix.com
CC: groug@kaod.org
CC: aneesh.kumar@linux.vnet.ibm.com
---
 hw/9pfs/xen-9p-backend.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 9c7f41a..a1fdede 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -332,12 +332,14 @@ static int xen_9pfs_connect(struct XenDevice *xendev)
         str = g_strdup_printf("ring-ref%u", i);
         if (xenstore_read_fe_int(&xen_9pdev->xendev, str,
                                  &xen_9pdev->rings[i].ref) == -1) {
+            g_free(str);
             goto out;
         }
         g_free(str);
         str = g_strdup_printf("event-channel-%u", i);
         if (xenstore_read_fe_int(&xen_9pdev->xendev, str,
                                  &xen_9pdev->rings[i].evtchn) == -1) {
+            g_free(str);
             goto out;
         }
         g_free(str);
-- 
1.9.1
