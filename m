Received: from eggs.gnu.org ([2001:4830:134:3::10]:58491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cklAM-00088G-On
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cklAJ-0001FZ-L9
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cklAJ-0001FK-CD
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:35 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon,  6 Mar 2017 13:25:48 +0800
Message-Id: <1488777954-4578-14-git-send-email-jasowang@redhat.com>
In-Reply-To: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
References: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL RESEND 13/19] vmxnet3: VMStatify rx/tx q_descr
 and int_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Fairly simple mechanical conversion of all fields.

TODO!!!!
The problem is vmxnet3-ring size/cell_size/next are declared as size_t
but written as 32bit.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Acked-by: Dmitry Fleytman <dmitry@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/vmxnet3.c | 272 ++++++++++++++++++-------------------------------------
 1 file changed, 90 insertions(+), 182 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 224c109..8b1fab2 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2403,155 +2403,87 @@ static const VMStateDescription vmxstate_vmxnet3_mcast_list = {
     }
 };
 
-static void vmxnet3_get_ring_from_file(QEMUFile *f, Vmxnet3Ring *r)
-{
-    r->pa = qemu_get_be64(f);
-    r->size = qemu_get_be32(f);
-    r->cell_size = qemu_get_be32(f);
-    r->next = qemu_get_be32(f);
-    r->gen = qemu_get_byte(f);
-}
-
-static void vmxnet3_put_ring_to_file(QEMUFile *f, Vmxnet3Ring *r)
-{
-    qemu_put_be64(f, r->pa);
-    qemu_put_be32(f, r->size);
-    qemu_put_be32(f, r->cell_size);
-    qemu_put_be32(f, r->next);
-    qemu_put_byte(f, r->gen);
-}
-
-static void vmxnet3_get_tx_stats_from_file(QEMUFile *f,
-    struct UPT1_TxStats *tx_stat)
-{
-    tx_stat->TSOPktsTxOK = qemu_get_be64(f);
-    tx_stat->TSOBytesTxOK = qemu_get_be64(f);
-    tx_stat->ucastPktsTxOK = qemu_get_be64(f);
-    tx_stat->ucastBytesTxOK = qemu_get_be64(f);
-    tx_stat->mcastPktsTxOK = qemu_get_be64(f);
-    tx_stat->mcastBytesTxOK = qemu_get_be64(f);
-    tx_stat->bcastPktsTxOK = qemu_get_be64(f);
-    tx_stat->bcastBytesTxOK = qemu_get_be64(f);
-    tx_stat->pktsTxError = qemu_get_be64(f);
-    tx_stat->pktsTxDiscard = qemu_get_be64(f);
-}
-
-static void vmxnet3_put_tx_stats_to_file(QEMUFile *f,
-    struct UPT1_TxStats *tx_stat)
-{
-    qemu_put_be64(f, tx_stat->TSOPktsTxOK);
-    qemu_put_be64(f, tx_stat->TSOBytesTxOK);
-    qemu_put_be64(f, tx_stat->ucastPktsTxOK);
-    qemu_put_be64(f, tx_stat->ucastBytesTxOK);
-    qemu_put_be64(f, tx_stat->mcastPktsTxOK);
-    qemu_put_be64(f, tx_stat->mcastBytesTxOK);
-    qemu_put_be64(f, tx_stat->bcastPktsTxOK);
-    qemu_put_be64(f, tx_stat->bcastBytesTxOK);
-    qemu_put_be64(f, tx_stat->pktsTxError);
-    qemu_put_be64(f, tx_stat->pktsTxDiscard);
-}
-
-static int vmxnet3_get_txq_descr(QEMUFile *f, void *pv, size_t size,
-    VMStateField *field)
-{
-    Vmxnet3TxqDescr *r = pv;
-
-    vmxnet3_get_ring_from_file(f, &r->tx_ring);
-    vmxnet3_get_ring_from_file(f, &r->comp_ring);
-    r->intr_idx = qemu_get_byte(f);
-    r->tx_stats_pa = qemu_get_be64(f);
-
-    vmxnet3_get_tx_stats_from_file(f, &r->txq_stats);
-
-    return 0;
-}
-
-static int vmxnet3_put_txq_descr(QEMUFile *f, void *pv, size_t size,
-                                 VMStateField *field, QJSON *vmdesc)
-{
-    Vmxnet3TxqDescr *r = pv;
-
-    vmxnet3_put_ring_to_file(f, &r->tx_ring);
-    vmxnet3_put_ring_to_file(f, &r->comp_ring);
-    qemu_put_byte(f, r->intr_idx);
-    qemu_put_be64(f, r->tx_stats_pa);
-    vmxnet3_put_tx_stats_to_file(f, &r->txq_stats);
-
-    return 0;
-}
-
-static const VMStateInfo txq_descr_info = {
-    .name = "txq_descr",
-    .get = vmxnet3_get_txq_descr,
-    .put = vmxnet3_put_txq_descr
+static const VMStateDescription vmstate_vmxnet3_ring = {
+    .name = "vmxnet3-ring",
+    .version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(pa, Vmxnet3Ring),
+        VMSTATE_UINT32(size, Vmxnet3Ring),
+        VMSTATE_UINT32(cell_size, Vmxnet3Ring),
+        VMSTATE_UINT32(next, Vmxnet3Ring),
+        VMSTATE_UINT8(gen, Vmxnet3Ring),
+        VMSTATE_END_OF_LIST()
+    }
 };
 
-static void vmxnet3_get_rx_stats_from_file(QEMUFile *f,
-    struct UPT1_RxStats *rx_stat)
-{
-    rx_stat->LROPktsRxOK = qemu_get_be64(f);
-    rx_stat->LROBytesRxOK = qemu_get_be64(f);
-    rx_stat->ucastPktsRxOK = qemu_get_be64(f);
-    rx_stat->ucastBytesRxOK = qemu_get_be64(f);
-    rx_stat->mcastPktsRxOK = qemu_get_be64(f);
-    rx_stat->mcastBytesRxOK = qemu_get_be64(f);
-    rx_stat->bcastPktsRxOK = qemu_get_be64(f);
-    rx_stat->bcastBytesRxOK = qemu_get_be64(f);
-    rx_stat->pktsRxOutOfBuf = qemu_get_be64(f);
-    rx_stat->pktsRxError = qemu_get_be64(f);
-}
-
-static void vmxnet3_put_rx_stats_to_file(QEMUFile *f,
-    struct UPT1_RxStats *rx_stat)
-{
-    qemu_put_be64(f, rx_stat->LROPktsRxOK);
-    qemu_put_be64(f, rx_stat->LROBytesRxOK);
-    qemu_put_be64(f, rx_stat->ucastPktsRxOK);
-    qemu_put_be64(f, rx_stat->ucastBytesRxOK);
-    qemu_put_be64(f, rx_stat->mcastPktsRxOK);
-    qemu_put_be64(f, rx_stat->mcastBytesRxOK);
-    qemu_put_be64(f, rx_stat->bcastPktsRxOK);
-    qemu_put_be64(f, rx_stat->bcastBytesRxOK);
-    qemu_put_be64(f, rx_stat->pktsRxOutOfBuf);
-    qemu_put_be64(f, rx_stat->pktsRxError);
-}
-
-static int vmxnet3_get_rxq_descr(QEMUFile *f, void *pv, size_t size,
-    VMStateField *field)
-{
-    Vmxnet3RxqDescr *r = pv;
-    int i;
-
-    for (i = 0; i < VMXNET3_RX_RINGS_PER_QUEUE; i++) {
-        vmxnet3_get_ring_from_file(f, &r->rx_ring[i]);
+static const VMStateDescription vmstate_vmxnet3_tx_stats = {
+    .name = "vmxnet3-tx-stats",
+    .version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(TSOPktsTxOK, struct UPT1_TxStats),
+        VMSTATE_UINT64(TSOBytesTxOK, struct UPT1_TxStats),
+        VMSTATE_UINT64(ucastPktsTxOK, struct UPT1_TxStats),
+        VMSTATE_UINT64(ucastBytesTxOK, struct UPT1_TxStats),
+        VMSTATE_UINT64(mcastPktsTxOK, struct UPT1_TxStats),
+        VMSTATE_UINT64(mcastBytesTxOK, struct UPT1_TxStats),
+        VMSTATE_UINT64(bcastPktsTxOK, struct UPT1_TxStats),
+        VMSTATE_UINT64(bcastBytesTxOK, struct UPT1_TxStats),
+        VMSTATE_UINT64(pktsTxError, struct UPT1_TxStats),
+        VMSTATE_UINT64(pktsTxDiscard, struct UPT1_TxStats),
+        VMSTATE_END_OF_LIST()
     }
+};
 
-    vmxnet3_get_ring_from_file(f, &r->comp_ring);
-    r->intr_idx = qemu_get_byte(f);
-    r->rx_stats_pa = qemu_get_be64(f);
-
-    vmxnet3_get_rx_stats_from_file(f, &r->rxq_stats);
-
-    return 0;
-}
-
-static int vmxnet3_put_rxq_descr(QEMUFile *f, void *pv, size_t size,
-                                 VMStateField *field, QJSON *vmdesc)
-{
-    Vmxnet3RxqDescr *r = pv;
-    int i;
-
-    for (i = 0; i < VMXNET3_RX_RINGS_PER_QUEUE; i++) {
-        vmxnet3_put_ring_to_file(f, &r->rx_ring[i]);
+static const VMStateDescription vmstate_vmxnet3_txq_descr = {
+    .name = "vmxnet3-txq-descr",
+    .version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT(tx_ring, Vmxnet3TxqDescr, 0, vmstate_vmxnet3_ring,
+                       Vmxnet3Ring),
+        VMSTATE_STRUCT(comp_ring, Vmxnet3TxqDescr, 0, vmstate_vmxnet3_ring,
+                       Vmxnet3Ring),
+        VMSTATE_UINT8(intr_idx, Vmxnet3TxqDescr),
+        VMSTATE_UINT64(tx_stats_pa, Vmxnet3TxqDescr),
+        VMSTATE_STRUCT(txq_stats, Vmxnet3TxqDescr, 0, vmstate_vmxnet3_tx_stats,
+                       struct UPT1_TxStats),
+        VMSTATE_END_OF_LIST()
     }
+};
 
-    vmxnet3_put_ring_to_file(f, &r->comp_ring);
-    qemu_put_byte(f, r->intr_idx);
-    qemu_put_be64(f, r->rx_stats_pa);
-    vmxnet3_put_rx_stats_to_file(f, &r->rxq_stats);
+static const VMStateDescription vmstate_vmxnet3_rx_stats = {
+    .name = "vmxnet3-rx-stats",
+    .version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(LROPktsRxOK, struct UPT1_RxStats),
+        VMSTATE_UINT64(LROBytesRxOK, struct UPT1_RxStats),
+        VMSTATE_UINT64(ucastPktsRxOK, struct UPT1_RxStats),
+        VMSTATE_UINT64(ucastBytesRxOK, struct UPT1_RxStats),
+        VMSTATE_UINT64(mcastPktsRxOK, struct UPT1_RxStats),
+        VMSTATE_UINT64(mcastBytesRxOK, struct UPT1_RxStats),
+        VMSTATE_UINT64(bcastPktsRxOK, struct UPT1_RxStats),
+        VMSTATE_UINT64(bcastBytesRxOK, struct UPT1_RxStats),
+        VMSTATE_UINT64(pktsRxOutOfBuf, struct UPT1_RxStats),
+        VMSTATE_UINT64(pktsRxError, struct UPT1_RxStats),
+        VMSTATE_END_OF_LIST()
+    }
+};
 
-    return 0;
-}
+static const VMStateDescription vmstate_vmxnet3_rxq_descr = {
+    .name = "vmxnet3-rxq-descr",
+    .version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT_ARRAY(rx_ring, Vmxnet3RxqDescr,
+                             VMXNET3_RX_RINGS_PER_QUEUE, 0,
+                             vmstate_vmxnet3_ring, Vmxnet3Ring),
+        VMSTATE_STRUCT(comp_ring, Vmxnet3RxqDescr, 0, vmstate_vmxnet3_ring,
+                       Vmxnet3Ring),
+        VMSTATE_UINT8(intr_idx, Vmxnet3RxqDescr),
+        VMSTATE_UINT64(rx_stats_pa, Vmxnet3RxqDescr),
+        VMSTATE_STRUCT(rxq_stats, Vmxnet3RxqDescr, 0, vmstate_vmxnet3_rx_stats,
+                       struct UPT1_RxStats),
+        VMSTATE_END_OF_LIST()
+    }
+};
 
 static int vmxnet3_post_load(void *opaque, int version_id)
 {
@@ -2577,40 +2509,15 @@ static int vmxnet3_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static const VMStateInfo rxq_descr_info = {
-    .name = "rxq_descr",
-    .get = vmxnet3_get_rxq_descr,
-    .put = vmxnet3_put_rxq_descr
-};
-
-static int vmxnet3_get_int_state(QEMUFile *f, void *pv, size_t size,
-    VMStateField *field)
-{
-    Vmxnet3IntState *r = pv;
-
-    r->is_masked = qemu_get_byte(f);
-    r->is_pending = qemu_get_byte(f);
-    r->is_asserted = qemu_get_byte(f);
-
-    return 0;
-}
-
-static int vmxnet3_put_int_state(QEMUFile *f, void *pv, size_t size,
-                                 VMStateField *field, QJSON *vmdesc)
-{
-    Vmxnet3IntState *r = pv;
-
-    qemu_put_byte(f, r->is_masked);
-    qemu_put_byte(f, r->is_pending);
-    qemu_put_byte(f, r->is_asserted);
-
-    return 0;
-}
-
-static const VMStateInfo int_state_info = {
-    .name = "int_state",
-    .get = vmxnet3_get_int_state,
-    .put = vmxnet3_put_int_state
+static const VMStateDescription vmstate_vmxnet3_int_state = {
+    .name = "vmxnet3-int-state",
+    .version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(is_masked, Vmxnet3IntState),
+        VMSTATE_BOOL(is_pending, Vmxnet3IntState),
+        VMSTATE_BOOL(is_asserted, Vmxnet3IntState),
+        VMSTATE_END_OF_LIST()
+    }
 };
 
 static bool vmxnet3_vmstate_need_pcie_device(void *opaque)
@@ -2667,14 +2574,15 @@ static const VMStateDescription vmstate_vmxnet3 = {
             VMSTATE_UINT64(drv_shmem, VMXNET3State),
             VMSTATE_UINT64(temp_shared_guest_driver_memory, VMXNET3State),
 
-            VMSTATE_ARRAY(txq_descr, VMXNET3State,
-                VMXNET3_DEVICE_MAX_TX_QUEUES, 0, txq_descr_info,
+            VMSTATE_STRUCT_ARRAY(txq_descr, VMXNET3State,
+                VMXNET3_DEVICE_MAX_TX_QUEUES, 0, vmstate_vmxnet3_txq_descr,
                 Vmxnet3TxqDescr),
-            VMSTATE_ARRAY(rxq_descr, VMXNET3State,
-                VMXNET3_DEVICE_MAX_RX_QUEUES, 0, rxq_descr_info,
+            VMSTATE_STRUCT_ARRAY(rxq_descr, VMXNET3State,
+                VMXNET3_DEVICE_MAX_RX_QUEUES, 0, vmstate_vmxnet3_rxq_descr,
                 Vmxnet3RxqDescr),
-            VMSTATE_ARRAY(interrupt_states, VMXNET3State, VMXNET3_MAX_INTRS,
-                0, int_state_info, Vmxnet3IntState),
+            VMSTATE_STRUCT_ARRAY(interrupt_states, VMXNET3State,
+                VMXNET3_MAX_INTRS, 0, vmstate_vmxnet3_int_state,
+                Vmxnet3IntState),
 
             VMSTATE_END_OF_LIST()
     },
-- 
2.7.4
