Received: from eggs.gnu.org ([2001:4830:134:3::10]:59673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cRvxK-00007V-2f
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 02:07:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cRvxF-0001t6-Kq
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 02:07:22 -0500
Received: from [59.151.112.132] (port=3578 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cRvxD-0001o3-Nn
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 02:07:17 -0500
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Fri, 13 Jan 2017 15:12:02 +0800
Message-ID: <1484291524-1261-9-git-send-email-caoj.fnst@cn.fujitsu.com>
In-Reply-To: <1484291524-1261-1-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1484291524-1261-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v8 08/10] vmxnet3: remove unnecessary internal
 msix flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Internal flag msix_used is unnecessary, it has the same effect as
msix_enabled().

The corresponding msi flag is already dropped in commit 1070048e.

CC: Dmitry Fleytman <dmitry@daynix.com>
CC: Jason Wang <jasowang@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Dmitry Fleytman <dmitry@daynix.com>
Acked-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 hw/net/vmxnet3.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 45e125e92c8a..af39965c8cc2 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -281,8 +281,6 @@ typedef struct {
         Vmxnet3RxqDescr rxq_descr[VMXNET3_DEVICE_MAX_RX_QUEUES];
         Vmxnet3TxqDescr txq_descr[VMXNET3_DEVICE_MAX_TX_QUEUES];
 
-        /* Whether MSI-X support was installed successfully */
-        bool msix_used;
         hwaddr drv_shmem;
         hwaddr temp_shared_guest_driver_memory;
 
@@ -359,7 +357,7 @@ static bool _vmxnet3_assert_interrupt_line(VMXNET3State *s, uint32_t int_idx)
 {
     PCIDevice *d = PCI_DEVICE(s);
 
-    if (s->msix_used && msix_enabled(d)) {
+    if (msix_enabled(d)) {
         VMW_IRPRN("Sending MSI-X notification for vector %u", int_idx);
         msix_notify(d, int_idx);
         return false;
@@ -383,7 +381,7 @@ static void _vmxnet3_deassert_interrupt_line(VMXNET3State *s, int lidx)
      * This function should never be called for MSI(X) interrupts
      * because deassertion never required for message interrupts
      */
-    assert(!s->msix_used || !msix_enabled(d));
+    assert(!msix_enabled(d));
     /*
      * This function should never be called for MSI(X) interrupts
      * because deassertion never required for message interrupts
@@ -421,7 +419,7 @@ static void vmxnet3_trigger_interrupt(VMXNET3State *s, int lidx)
     s->interrupt_states[lidx].is_pending = true;
     vmxnet3_update_interrupt_line_state(s, lidx);
 
-    if (s->msix_used && msix_enabled(d) && s->auto_int_masking) {
+    if (msix_enabled(d) && s->auto_int_masking) {
         goto do_automask;
     }
 
@@ -1428,7 +1426,7 @@ static void vmxnet3_update_features(VMXNET3State *s)
 
 static bool vmxnet3_verify_intx(VMXNET3State *s, int intx)
 {
-    return s->msix_used || msi_enabled(PCI_DEVICE(s))
+    return msix_enabled(PCI_DEVICE(s)) || msi_enabled(PCI_DEVICE(s))
         || intx == pci_get_byte(s->parent_obj.config + PCI_INTERRUPT_PIN) - 1;
 }
 
@@ -1445,18 +1443,18 @@ static void vmxnet3_validate_interrupts(VMXNET3State *s)
     int i;
 
     VMW_CFPRN("Verifying event interrupt index (%d)", s->event_int_idx);
-    vmxnet3_validate_interrupt_idx(s->msix_used, s->event_int_idx);
+    vmxnet3_validate_interrupt_idx(msix_enabled(PCI_DEVICE(s)), s->event_int_idx);
 
     for (i = 0; i < s->txq_num; i++) {
         int idx = s->txq_descr[i].intr_idx;
         VMW_CFPRN("Verifying TX queue %d interrupt index (%d)", i, idx);
-        vmxnet3_validate_interrupt_idx(s->msix_used, idx);
+        vmxnet3_validate_interrupt_idx(msix_enabled(PCI_DEVICE(s)), idx);
     }
 
     for (i = 0; i < s->rxq_num; i++) {
         int idx = s->rxq_descr[i].intr_idx;
         VMW_CFPRN("Verifying RX queue %d interrupt index (%d)", i, idx);
-        vmxnet3_validate_interrupt_idx(s->msix_used, idx);
+        vmxnet3_validate_interrupt_idx(msix_enabled(PCI_DEVICE(s)), idx);
     }
 }
 
@@ -2185,6 +2183,7 @@ vmxnet3_use_msix_vectors(VMXNET3State *s, int num_vectors)
 static bool
 vmxnet3_init_msix(VMXNET3State *s)
 {
+    bool msix;
     PCIDevice *d = PCI_DEVICE(s);
     int res = msix_init(d, VMXNET3_MAX_INTRS,
                         &s->msix_bar,
@@ -2199,17 +2198,18 @@ vmxnet3_init_msix(VMXNET3State *s)
 
     if (0 > res) {
         VMW_WRPRN("Failed to initialize MSI-X, board's MSI support is broken");
-        s->msix_used = false;
+        msix = false;
     } else {
         if (!vmxnet3_use_msix_vectors(s, VMXNET3_MAX_INTRS)) {
             VMW_WRPRN("Failed to use MSI-X vectors, error %d", res);
             msix_uninit(d, &s->msix_bar, &s->msix_bar);
-            s->msix_used = false;
+            msix = false;
         } else {
-            s->msix_used = true;
+            msix = true;
         }
     }
-    return s->msix_used;
+
+    return msix;
 }
 
 static void
@@ -2217,7 +2217,7 @@ vmxnet3_cleanup_msix(VMXNET3State *s)
 {
     PCIDevice *d = PCI_DEVICE(s);
 
-    if (s->msix_used) {
+    if (msix_enabled(d)) {
         vmxnet3_unuse_msix_vectors(s, VMXNET3_MAX_INTRS);
         msix_uninit(d, &s->msix_bar, &s->msix_bar);
     }
-- 
2.1.0
