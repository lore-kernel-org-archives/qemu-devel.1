Received: from eggs.gnu.org ([2001:4830:134:3::10]:43878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1frjYY-0008Qq-Jo
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1frjYX-0000bx-Sl
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:14 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:46408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1frjYX-0000bN-Lr
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:13 -0400
Received: by mail-wr1-x429.google.com with SMTP id a108-v6so10218754wrc.13
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 05:45:13 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sun, 19 Aug 2018 23:22:48 +0300
Message-Id: <20180819202300.10590-4-marcel.apfelbaum@gmail.com>
In-Reply-To: <20180819202300.10590-1-marcel.apfelbaum@gmail.com>
References: <20180819202300.10590-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel]  [PATCH PULL 03/15] hw/rdma: Modify debug macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, thuth@redhat.com, marcel.apfelbaum@gmail.com

From: Yuval Shaia <yuval.shaia@oracle.com>

- Add line counter to ease navigation in log
- Print rdma instead of pvrdma

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-Id: <20180805153518.2983-4-yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_utils.c      |  4 ++++
 hw/rdma/rdma_utils.h      | 16 ++++++++++++----
 hw/rdma/vmw/pvrdma_main.c |  2 ++
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/hw/rdma/rdma_utils.c b/hw/rdma/rdma_utils.c
index d713f635f1..dc23f158f3 100644
--- a/hw/rdma/rdma_utils.c
+++ b/hw/rdma/rdma_utils.c
@@ -15,6 +15,10 @@
 
 #include "rdma_utils.h"
 
+#ifdef PVRDMA_DEBUG
+unsigned long pr_dbg_cnt;
+#endif
+
 void *rdma_pci_dma_map(PCIDevice *dev, dma_addr_t addr, dma_addr_t plen)
 {
     void *p;
diff --git a/hw/rdma/rdma_utils.h b/hw/rdma/rdma_utils.h
index 3dc07891bc..04c7c2ef5b 100644
--- a/hw/rdma/rdma_utils.h
+++ b/hw/rdma/rdma_utils.h
@@ -22,18 +22,26 @@
 #include "sysemu/dma.h"
 
 #define pr_info(fmt, ...) \
-    fprintf(stdout, "%s: %-20s (%3d): " fmt, "pvrdma",  __func__, __LINE__,\
+    fprintf(stdout, "%s: %-20s (%3d): " fmt, "rdma",  __func__, __LINE__,\
            ## __VA_ARGS__)
 
 #define pr_err(fmt, ...) \
-    fprintf(stderr, "%s: Error at %-20s (%3d): " fmt, "pvrdma", __func__, \
+    fprintf(stderr, "%s: Error at %-20s (%3d): " fmt, "rdma", __func__, \
         __LINE__, ## __VA_ARGS__)
 
 #ifdef PVRDMA_DEBUG
+extern unsigned long pr_dbg_cnt;
+
+#define init_pr_dbg(void) \
+{ \
+    pr_dbg_cnt = 0; \
+}
+
 #define pr_dbg(fmt, ...) \
-    fprintf(stdout, "%s: %-20s (%3d): " fmt, "pvrdma", __func__, __LINE__,\
-           ## __VA_ARGS__)
+    fprintf(stdout, "%lx %ld: %-20s (%3d): " fmt, pthread_self(), pr_dbg_cnt++, \
+            __func__, __LINE__, ## __VA_ARGS__)
 #else
+#define init_pr_dbg(void)
 #define pr_dbg(fmt, ...)
 #endif
 
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 6a5073974d..1b1330e113 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -577,6 +577,8 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
     Object *memdev_root;
     bool ram_shared = false;
 
+    init_pr_dbg();
+
     pr_dbg("Initializing device %s %x.%x\n", pdev->name,
            PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
 
-- 
2.17.1
