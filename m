Received: from eggs.gnu.org ([2001:4830:134:3::10]:50283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cTN1U-00079P-WF
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 01:13:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cTN1U-0007bQ-0B
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 01:13:36 -0500
Received: from [59.151.112.132] (port=27872 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cTN1T-0007aA-AJ
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 01:13:35 -0500
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
	by cn.fujitsu.com (Postfix) with ESMTP id A777047AD1D4
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 14:13:18 +0800 (CST)
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Tue, 17 Jan 2017 14:18:49 +0800
Message-ID: <1484633936-25344-5-git-send-email-caoj.fnst@cn.fujitsu.com>
In-Reply-To: <1484633936-25344-1-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1484633936-25344-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v9 04/11] msix: check msix_init's return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Doesn't do it for megasas & hcd-xhci, later patches will fix them.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 hw/net/e1000e.c        |  4 ++++
 hw/net/rocker/rocker.c |  5 +++++
 hw/net/vmxnet3.c       |  6 +++++-
 hw/virtio/virtio-pci.c | 13 +++++++------
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index ed04adce061c..74cbbef30366 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -294,6 +294,10 @@ e1000e_init_msix(E1000EState *s)
                         E1000E_MSIX_IDX, E1000E_MSIX_PBA,
                         0xA0, NULL);
 
+    /* Any error other than -ENOTSUP(board's MSI support is broken)
+     * is a programming error. Fall back to INTx silently on -ENOTSUP */
+    assert(!res || res == -ENOTSUP);
+
     if (res < 0) {
         trace_e1000e_msix_init_fail(res);
     } else {
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 6e70fddee36b..e394fd61fe64 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -1264,6 +1264,11 @@ static int rocker_msix_init(Rocker *r)
                     &r->msix_bar,
                     ROCKER_PCI_MSIX_BAR_IDX, ROCKER_PCI_MSIX_PBA_OFFSET,
                     0, &local_err);
+
+    /* Any error other than -ENOTSUP(board's MSI support is broken)
+     * is a programming error. */
+    assert(!err || err == -ENOTSUP);
+
     if (err) {
         error_report_err(local_err);
         return err;
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 7b2971fe5902..a433cc017cb1 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2193,8 +2193,12 @@ vmxnet3_init_msix(VMXNET3State *s)
                         VMXNET3_MSIX_BAR_IDX, VMXNET3_OFF_MSIX_PBA(s),
                         VMXNET3_MSIX_OFFSET(s), NULL);
 
+    /* Any error other than -ENOTSUP(board's MSI support is broken)
+     * is a programming error. Fall back to INTx on -ENOTSUP */
+    assert(!res || res == -ENOTSUP);
+
     if (0 > res) {
-        VMW_WRPRN("Failed to initialize MSI-X, error %d", res);
+        VMW_WRPRN("Failed to initialize MSI-X, board's MSI support is broken");
         s->msix_used = false;
     } else {
         if (!vmxnet3_use_msix_vectors(s, VMXNET3_MAX_INTRS)) {
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 4c2c4941d245..2417c78c477e 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1670,13 +1670,14 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
 
     if (proxy->nvectors) {
         int err = msix_init_exclusive_bar(&proxy->pci_dev, proxy->nvectors,
-                                          proxy->msix_bar_idx, NULL);
+                                          proxy->msix_bar_idx, errp);
+
+        /* Any error other than -ENOTSUP(board's MSI support is broken)
+         * is a programming error. */
+        assert(!err || err == -ENOTSUP);
+
         if (err) {
-            /* Notice when a system that supports MSIx can't initialize it */
-            if (err != -ENOTSUP) {
-                error_report("unable to init msix vectors to %" PRIu32,
-                             proxy->nvectors);
-            }
+            error_report_err(*errp);
             proxy->nvectors = 0;
         }
     }
-- 
2.1.0
