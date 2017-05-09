Received: from eggs.gnu.org ([2001:4830:134:3::10]:44224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d8ART-0001gk-HM
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:05:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d8ARR-0001EG-Io
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:05:03 -0400
Received: from mail.kernel.org ([198.145.29.136]:43480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1d8ARR-0001Dk-Db
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:05:01 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Tue,  9 May 2017 12:04:53 -0700
Message-Id: <1494356693-13190-3-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1494356693-13190-1-git-send-email-sstabellini@kernel.org>
References: <1494356693-13190-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PATCH v2 3/3] xen: call qemu_set_cloexec instead of
 fcntl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xen.org, sstabellini@kernel.org, anthony.perard@citrix.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>

Use the common utility function, which contains checks on return values,
instead of manually calling fcntl.

CID: 1374831

Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
CC: anthony.perard@citrix.com
CC: groug@kaod.org
CC: aneesh.kumar@linux.vnet.ibm.com
CC: Eric Blake <eblake@redhat.com>
---
 hw/9pfs/xen-9p-backend.c | 2 +-
 hw/xen/xen_backend.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index a1fdede..5df97c9 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -380,7 +380,7 @@ static int xen_9pfs_connect(struct XenDevice *xendev)
         if (xen_9pdev->rings[i].evtchndev == NULL) {
             goto out;
         }
-        fcntl(xenevtchn_fd(xen_9pdev->rings[i].evtchndev), F_SETFD, FD_CLOEXEC);
+        qemu_set_cloexec(xenevtchn_fd(xen_9pdev->rings[i].evtchndev));
         xen_9pdev->rings[i].local_port = xenevtchn_bind_interdomain
                                             (xen_9pdev->rings[i].evtchndev,
                                              xendev->dom,
diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
index c85f163..2cac47d 100644
--- a/hw/xen/xen_backend.c
+++ b/hw/xen/xen_backend.c
@@ -147,7 +147,7 @@ static struct XenDevice *xen_be_get_xendev(const char *type, int dom, int dev,
         qdev_unplug(DEVICE(xendev), NULL);
         return NULL;
     }
-    fcntl(xenevtchn_fd(xendev->evtchndev), F_SETFD, FD_CLOEXEC);
+    qemu_set_cloexec(xenevtchn_fd(xendev->evtchndev));
 
     if (ops->flags & DEVOPS_FLAG_NEED_GNTDEV) {
         xendev->gnttabdev = xengnttab_open(NULL, 0);
-- 
1.9.1
