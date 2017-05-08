Received: from eggs.gnu.org ([2001:4830:134:3::10]:43618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d7pXR-0001iH-FH
	for qemu-devel@nongnu.org; Mon, 08 May 2017 16:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d7pXO-0004J4-Av
	for qemu-devel@nongnu.org; Mon, 08 May 2017 16:45:49 -0400
Received: from mail.kernel.org ([198.145.29.136]:40866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1d7pXO-0004Is-57
	for qemu-devel@nongnu.org; Mon, 08 May 2017 16:45:46 -0400
Date: Mon, 8 May 2017 13:45:41 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <alpine.DEB.2.10.1705081334150.24729@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Qemu-devel] [PATCH] Fix issues affecting Xen 9pfs discovered by
 Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: anthony.perard@citrix.com
Cc: sstabellini@kernel.org, qemu-devel@nongnu.org, xen-devel@lists.xensource.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com

Fix two resource leaks on error paths, discovered by Coverity.
Check for errors returned by fcntl, also found by Coverity.

CID:1374836
CID:1374831

Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 9c7f41a..f75e728 100644
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
@@ -378,7 +380,10 @@ static int xen_9pfs_connect(struct XenDevice *xendev)
         if (xen_9pdev->rings[i].evtchndev == NULL) {
             goto out;
         }
-        fcntl(xenevtchn_fd(xen_9pdev->rings[i].evtchndev), F_SETFD, FD_CLOEXEC);
+        if (fcntl(xenevtchn_fd(xen_9pdev->rings[i].evtchndev),
+                  F_SETFD, FD_CLOEXEC) == -1) {
+            goto out;
+        }
         xen_9pdev->rings[i].local_port = xenevtchn_bind_interdomain
                                             (xen_9pdev->rings[i].evtchndev,
                                              xendev->dom,
