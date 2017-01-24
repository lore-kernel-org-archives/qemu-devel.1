Received: from eggs.gnu.org ([2001:4830:134:3::10]:55373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cW68F-0001Ir-HX
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cW68A-0006nX-RE
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cW68A-0006n8-Dz
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:46 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 805FF341ACA
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 18:47:46 +0000 (UTC)
Received: from dgilbert-t530.redhat.com (ovpn-116-204.ams2.redhat.com
	[10.36.116.204])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0OIlhUo020536
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 13:47:45 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 24 Jan 2017 18:47:29 +0000
Message-Id: <20170124184742.1639-3-dgilbert@redhat.com>
In-Reply-To: <20170124184742.1639-1-dgilbert@redhat.com>
References: <20170124184742.1639-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 02/15] migration: extend VMStateInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Jianjun Duan <duanj@linux.vnet.ibm.com>

Current migration code cannot handle some data structures such as
QTAILQ in qemu/queue.h. Here we extend the signatures of put/get
in VMStateInfo so that customized handling is supported. put now
will return int type.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Signed-off-by: Jianjun Duan <duanj@linux.vnet.ibm.com>
Message-Id: <1484852453-12728-2-git-send-email-duanj@linux.vnet.ibm.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/display/virtio-gpu.c     |   8 +++-
 hw/intc/s390_flic_kvm.c     |   8 +++-
 hw/net/vmxnet3.c            |  24 +++++++---
 hw/nvram/eeprom93xx.c       |   8 +++-
 hw/nvram/fw_cfg.c           |   8 +++-
 hw/pci/msix.c               |   8 +++-
 hw/pci/pci.c                |  16 +++++--
 hw/pci/shpc.c               |   7 ++-
 hw/scsi/scsi-bus.c          |   8 +++-
 hw/timer/twl92230.c         |   8 +++-
 hw/usb/redirect.c           |  26 +++++++---
 hw/virtio/virtio-pci.c      |   8 +++-
 hw/virtio/virtio.c          |  15 ++++--
 include/migration/vmstate.h |  19 ++++++--
 migration/savevm.c          |   7 ++-
 migration/vmstate.c         | 113 +++++++++++++++++++++++++++++---------------
 target/alpha/machine.c      |   6 ++-
 target/arm/machine.c        |  14 ++++--
 target/i386/machine.c       |  26 +++++++---
 target/mips/machine.c       |  14 ++++--
 target/ppc/machine.c        |  12 +++--
 target/sparc/machine.c      |   6 ++-
 22 files changed, 263 insertions(+), 106 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 7a15c61..6e09474 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1003,7 +1003,8 @@ static const VMStateDescription vmstate_virtio_gpu_scanouts = {
     },
 };
 
-static void virtio_gpu_save(QEMUFile *f, void *opaque, size_t size)
+static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
+                           VMStateField *field, QJSON *vmdesc)
 {
     VirtIOGPU *g = opaque;
     struct virtio_gpu_simple_resource *res;
@@ -1028,9 +1029,12 @@ static void virtio_gpu_save(QEMUFile *f, void *opaque, size_t size)
     qemu_put_be32(f, 0); /* end of list */
 
     vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL);
+
+    return 0;
 }
 
-static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size)
+static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
+                           VMStateField *field)
 {
     VirtIOGPU *g = opaque;
     struct virtio_gpu_simple_resource *res;
diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index c313166..da8e4df 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -286,7 +286,8 @@ static void kvm_s390_release_adapter_routes(S390FLICState *fs,
  * increase until buffer is sufficient or maxium size is
  * reached
  */
-static void kvm_flic_save(QEMUFile *f, void *opaque, size_t size)
+static int kvm_flic_save(QEMUFile *f, void *opaque, size_t size,
+                         VMStateField *field, QJSON *vmdesc)
 {
     KVMS390FLICState *flic = opaque;
     int len = FLIC_SAVE_INITIAL_SIZE;
@@ -319,6 +320,8 @@ static void kvm_flic_save(QEMUFile *f, void *opaque, size_t size)
                         count * sizeof(struct kvm_s390_irq));
     }
     g_free(buf);
+
+    return 0;
 }
 
 /**
@@ -331,7 +334,8 @@ static void kvm_flic_save(QEMUFile *f, void *opaque, size_t size)
  * Note: Do nothing when no interrupts where stored
  * in QEMUFile
  */
-static int kvm_flic_load(QEMUFile *f, void *opaque, size_t size)
+static int kvm_flic_load(QEMUFile *f, void *opaque, size_t size,
+                         VMStateField *field)
 {
     uint64_t len = 0;
     uint64_t count = 0;
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 92f6af9..4163ca8 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2451,7 +2451,8 @@ static void vmxnet3_put_tx_stats_to_file(QEMUFile *f,
     qemu_put_be64(f, tx_stat->pktsTxDiscard);
 }
 
-static int vmxnet3_get_txq_descr(QEMUFile *f, void *pv, size_t size)
+static int vmxnet3_get_txq_descr(QEMUFile *f, void *pv, size_t size,
+    VMStateField *field)
 {
     Vmxnet3TxqDescr *r = pv;
 
@@ -2465,7 +2466,8 @@ static int vmxnet3_get_txq_descr(QEMUFile *f, void *pv, size_t size)
     return 0;
 }
 
-static void vmxnet3_put_txq_descr(QEMUFile *f, void *pv, size_t size)
+static int vmxnet3_put_txq_descr(QEMUFile *f, void *pv, size_t size,
+                                 VMStateField *field, QJSON *vmdesc)
 {
     Vmxnet3TxqDescr *r = pv;
 
@@ -2474,6 +2476,8 @@ static void vmxnet3_put_txq_descr(QEMUFile *f, void *pv, size_t size)
     qemu_put_byte(f, r->intr_idx);
     qemu_put_be64(f, r->tx_stats_pa);
     vmxnet3_put_tx_stats_to_file(f, &r->txq_stats);
+
+    return 0;
 }
 
 static const VMStateInfo txq_descr_info = {
@@ -2512,7 +2516,8 @@ static void vmxnet3_put_rx_stats_to_file(QEMUFile *f,
     qemu_put_be64(f, rx_stat->pktsRxError);
 }
 
-static int vmxnet3_get_rxq_descr(QEMUFile *f, void *pv, size_t size)
+static int vmxnet3_get_rxq_descr(QEMUFile *f, void *pv, size_t size,
+    VMStateField *field)
 {
     Vmxnet3RxqDescr *r = pv;
     int i;
@@ -2530,7 +2535,8 @@ static int vmxnet3_get_rxq_descr(QEMUFile *f, void *pv, size_t size)
     return 0;
 }
 
-static void vmxnet3_put_rxq_descr(QEMUFile *f, void *pv, size_t size)
+static int vmxnet3_put_rxq_descr(QEMUFile *f, void *pv, size_t size,
+                                 VMStateField *field, QJSON *vmdesc)
 {
     Vmxnet3RxqDescr *r = pv;
     int i;
@@ -2543,6 +2549,8 @@ static void vmxnet3_put_rxq_descr(QEMUFile *f, void *pv, size_t size)
     qemu_put_byte(f, r->intr_idx);
     qemu_put_be64(f, r->rx_stats_pa);
     vmxnet3_put_rx_stats_to_file(f, &r->rxq_stats);
+
+    return 0;
 }
 
 static int vmxnet3_post_load(void *opaque, int version_id)
@@ -2575,7 +2583,8 @@ static const VMStateInfo rxq_descr_info = {
     .put = vmxnet3_put_rxq_descr
 };
 
-static int vmxnet3_get_int_state(QEMUFile *f, void *pv, size_t size)
+static int vmxnet3_get_int_state(QEMUFile *f, void *pv, size_t size,
+    VMStateField *field)
 {
     Vmxnet3IntState *r = pv;
 
@@ -2586,13 +2595,16 @@ static int vmxnet3_get_int_state(QEMUFile *f, void *pv, size_t size)
     return 0;
 }
 
-static void vmxnet3_put_int_state(QEMUFile *f, void *pv, size_t size)
+static int vmxnet3_put_int_state(QEMUFile *f, void *pv, size_t size,
+                                 VMStateField *field, QJSON *vmdesc)
 {
     Vmxnet3IntState *r = pv;
 
     qemu_put_byte(f, r->is_masked);
     qemu_put_byte(f, r->is_pending);
     qemu_put_byte(f, r->is_asserted);
+
+    return 0;
 }
 
 static const VMStateInfo int_state_info = {
diff --git a/hw/nvram/eeprom93xx.c b/hw/nvram/eeprom93xx.c
index 2c16fc2..848692a 100644
--- a/hw/nvram/eeprom93xx.c
+++ b/hw/nvram/eeprom93xx.c
@@ -94,18 +94,22 @@ struct _eeprom_t {
    This is a Big hack, but it is how the old state did it.
  */
 
-static int get_uint16_from_uint8(QEMUFile *f, void *pv, size_t size)
+static int get_uint16_from_uint8(QEMUFile *f, void *pv, size_t size,
+                                 VMStateField *field)
 {
     uint16_t *v = pv;
     *v = qemu_get_ubyte(f);
     return 0;
 }
 
-static void put_unused(QEMUFile *f, void *pv, size_t size)
+static int put_unused(QEMUFile *f, void *pv, size_t size, VMStateField *field,
+                      QJSON *vmdesc)
 {
     fprintf(stderr, "uint16_from_uint8 is used only for backwards compatibility.\n");
     fprintf(stderr, "Never should be used to write a new state.\n");
     exit(0);
+
+    return 0;
 }
 
 static const VMStateInfo vmstate_hack_uint16_from_uint8 = {
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 523d585..316fca9 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -555,17 +555,21 @@ static void fw_cfg_reset(DeviceState *d)
    Or we broke compatibility in the state, or we can't use struct tm
  */
 
-static int get_uint32_as_uint16(QEMUFile *f, void *pv, size_t size)
+static int get_uint32_as_uint16(QEMUFile *f, void *pv, size_t size,
+                                VMStateField *field)
 {
     uint32_t *v = pv;
     *v = qemu_get_be16(f);
     return 0;
 }
 
-static void put_unused(QEMUFile *f, void *pv, size_t size)
+static int put_unused(QEMUFile *f, void *pv, size_t size, VMStateField *field,
+                      QJSON *vmdesc)
 {
     fprintf(stderr, "uint32_as_uint16 is only used for backward compatibility.\n");
     fprintf(stderr, "This functions shouldn't be called.\n");
+
+    return 0;
 }
 
 static const VMStateInfo vmstate_hack_uint32_as_uint16 = {
diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 0ec1cb1..ee1714d 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -587,12 +587,16 @@ void msix_unset_vector_notifiers(PCIDevice *dev)
     dev->msix_vector_poll_notifier = NULL;
 }
 
-static void put_msix_state(QEMUFile *f, void *pv, size_t size)
+static int put_msix_state(QEMUFile *f, void *pv, size_t size,
+                          VMStateField *field, QJSON *vmdesc)
 {
     msix_save(pv, f);
+
+    return 0;
 }
 
-static int get_msix_state(QEMUFile *f, void *pv, size_t size)
+static int get_msix_state(QEMUFile *f, void *pv, size_t size,
+                          VMStateField *field)
 {
     msix_load(pv, f);
     return 0;
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index fe9acec..c35d011 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -445,7 +445,8 @@ int pci_bus_numa_node(PCIBus *bus)
     return PCI_BUS_GET_CLASS(bus)->numa_node(bus);
 }
 
-static int get_pci_config_device(QEMUFile *f, void *pv, size_t size)
+static int get_pci_config_device(QEMUFile *f, void *pv, size_t size,
+                                 VMStateField *field)
 {
     PCIDevice *s = container_of(pv, PCIDevice, config);
     PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(s);
@@ -484,11 +485,14 @@ static int get_pci_config_device(QEMUFile *f, void *pv, size_t size)
 }
 
 /* just put buffer */
-static void put_pci_config_device(QEMUFile *f, void *pv, size_t size)
+static int put_pci_config_device(QEMUFile *f, void *pv, size_t size,
+                                 VMStateField *field, QJSON *vmdesc)
 {
     const uint8_t **v = pv;
     assert(size == pci_config_size(container_of(pv, PCIDevice, config)));
     qemu_put_buffer(f, *v, size);
+
+    return 0;
 }
 
 static VMStateInfo vmstate_info_pci_config = {
@@ -497,7 +501,8 @@ static VMStateInfo vmstate_info_pci_config = {
     .put  = put_pci_config_device,
 };
 
-static int get_pci_irq_state(QEMUFile *f, void *pv, size_t size)
+static int get_pci_irq_state(QEMUFile *f, void *pv, size_t size,
+                             VMStateField *field)
 {
     PCIDevice *s = container_of(pv, PCIDevice, irq_state);
     uint32_t irq_state[PCI_NUM_PINS];
@@ -518,7 +523,8 @@ static int get_pci_irq_state(QEMUFile *f, void *pv, size_t size)
     return 0;
 }
 
-static void put_pci_irq_state(QEMUFile *f, void *pv, size_t size)
+static int put_pci_irq_state(QEMUFile *f, void *pv, size_t size,
+                             VMStateField *field, QJSON *vmdesc)
 {
     int i;
     PCIDevice *s = container_of(pv, PCIDevice, irq_state);
@@ -526,6 +532,8 @@ static void put_pci_irq_state(QEMUFile *f, void *pv, size_t size)
     for (i = 0; i < PCI_NUM_PINS; ++i) {
         qemu_put_be32(f, pci_irq_state(s, i));
     }
+
+    return 0;
 }
 
 static VMStateInfo vmstate_info_pci_irq_state = {
diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index 3dcd472..42fafac 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -695,13 +695,16 @@ void shpc_cap_write_config(PCIDevice *d, uint32_t addr, uint32_t val, int l)
     shpc_cap_update_dword(d);
 }
 
-static void shpc_save(QEMUFile *f, void *pv, size_t size)
+static int shpc_save(QEMUFile *f, void *pv, size_t size, VMStateField *field,
+                     QJSON *vmdesc)
 {
     PCIDevice *d = container_of(pv, PCIDevice, shpc);
     qemu_put_buffer(f, d->shpc->config, SHPC_SIZEOF(d));
+
+    return 0;
 }
 
-static int shpc_load(QEMUFile *f, void *pv, size_t size)
+static int shpc_load(QEMUFile *f, void *pv, size_t size, VMStateField *field)
 {
     PCIDevice *d = container_of(pv, PCIDevice, shpc);
     int ret = qemu_get_buffer(f, d->shpc->config, SHPC_SIZEOF(d));
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 297216d..5940cb1 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1945,7 +1945,8 @@ SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int id, int lun)
 
 /* SCSI request list.  For simplicity, pv points to the whole device */
 
-static void put_scsi_requests(QEMUFile *f, void *pv, size_t size)
+static int put_scsi_requests(QEMUFile *f, void *pv, size_t size,
+                             VMStateField *field, QJSON *vmdesc)
 {
     SCSIDevice *s = pv;
     SCSIBus *bus = DO_UPCAST(SCSIBus, qbus, s->qdev.parent_bus);
@@ -1968,9 +1969,12 @@ static void put_scsi_requests(QEMUFile *f, void *pv, size_t size)
         }
     }
     qemu_put_sbyte(f, 0);
+
+    return 0;
 }
 
-static int get_scsi_requests(QEMUFile *f, void *pv, size_t size)
+static int get_scsi_requests(QEMUFile *f, void *pv, size_t size,
+                             VMStateField *field)
 {
     SCSIDevice *s = pv;
     SCSIBus *bus = DO_UPCAST(SCSIBus, qbus, s->qdev.parent_bus);
diff --git a/hw/timer/twl92230.c b/hw/timer/twl92230.c
index b8d914e..c0aa8ae 100644
--- a/hw/timer/twl92230.c
+++ b/hw/timer/twl92230.c
@@ -749,17 +749,21 @@ static int menelaus_rx(I2CSlave *i2c)
    Or we broke compatibility in the state, or we can't use struct tm
  */
 
-static int get_int32_as_uint16(QEMUFile *f, void *pv, size_t size)
+static int get_int32_as_uint16(QEMUFile *f, void *pv, size_t size,
+                               VMStateField *field)
 {
     int *v = pv;
     *v = qemu_get_be16(f);
     return 0;
 }
 
-static void put_int32_as_uint16(QEMUFile *f, void *pv, size_t size)
+static int put_int32_as_uint16(QEMUFile *f, void *pv, size_t size,
+                               VMStateField *field, QJSON *vmdesc)
 {
     int *v = pv;
     qemu_put_be16(f, *v);
+
+    return 0;
 }
 
 static const VMStateInfo vmstate_hack_int32_as_uint16 = {
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index a657237..4a0ebbf 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -2165,7 +2165,8 @@ static int usbredir_post_load(void *priv, int version_id)
 }
 
 /* For usbredirparser migration */
-static void usbredir_put_parser(QEMUFile *f, void *priv, size_t unused)
+static int usbredir_put_parser(QEMUFile *f, void *priv, size_t unused,
+                               VMStateField *field, QJSON *vmdesc)
 {
     USBRedirDevice *dev = priv;
     uint8_t *data;
@@ -2173,7 +2174,7 @@ static void usbredir_put_parser(QEMUFile *f, void *priv, size_t unused)
 
     if (dev->parser == NULL) {
         qemu_put_be32(f, 0);
-        return;
+        return 0;
     }
 
     usbredirparser_serialize(dev->parser, &data, &len);
@@ -2183,9 +2184,12 @@ static void usbredir_put_parser(QEMUFile *f, void *priv, size_t unused)
     qemu_put_buffer(f, data, len);
 
     free(data);
+
+    return 0;
 }
 
-static int usbredir_get_parser(QEMUFile *f, void *priv, size_t unused)
+static int usbredir_get_parser(QEMUFile *f, void *priv, size_t unused,
+                               VMStateField *field)
 {
     USBRedirDevice *dev = priv;
     uint8_t *data;
@@ -2228,7 +2232,8 @@ static const VMStateInfo usbredir_parser_vmstate_info = {
 
 
 /* For buffered packets (iso/irq) queue migration */
-static void usbredir_put_bufpq(QEMUFile *f, void *priv, size_t unused)
+static int usbredir_put_bufpq(QEMUFile *f, void *priv, size_t unused,
+                              VMStateField *field, QJSON *vmdesc)
 {
     struct endp_data *endp = priv;
     USBRedirDevice *dev = endp->dev;
@@ -2246,9 +2251,12 @@ static void usbredir_put_bufpq(QEMUFile *f, void *priv, size_t unused)
         i++;
     }
     assert(i == endp->bufpq_size);
+
+    return 0;
 }
 
-static int usbredir_get_bufpq(QEMUFile *f, void *priv, size_t unused)
+static int usbredir_get_bufpq(QEMUFile *f, void *priv, size_t unused,
+                              VMStateField *field)
 {
     struct endp_data *endp = priv;
     USBRedirDevice *dev = endp->dev;
@@ -2351,7 +2359,8 @@ static const VMStateDescription usbredir_ep_vmstate = {
 
 
 /* For PacketIdQueue migration */
-static void usbredir_put_packet_id_q(QEMUFile *f, void *priv, size_t unused)
+static int usbredir_put_packet_id_q(QEMUFile *f, void *priv, size_t unused,
+                                    VMStateField *field, QJSON *vmdesc)
 {
     struct PacketIdQueue *q = priv;
     USBRedirDevice *dev = q->dev;
@@ -2365,9 +2374,12 @@ static void usbredir_put_packet_id_q(QEMUFile *f, void *priv, size_t unused)
         remain--;
     }
     assert(remain == 0);
+
+    return 0;
 }
 
-static int usbredir_get_packet_id_q(QEMUFile *f, void *priv, size_t unused)
+static int usbredir_get_packet_id_q(QEMUFile *f, void *priv, size_t unused,
+                                    VMStateField *field)
 {
     struct PacketIdQueue *q = priv;
     USBRedirDevice *dev = q->dev;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 09230c0..b5af2a0 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -108,7 +108,8 @@ static bool virtio_pci_has_extra_state(DeviceState *d)
     return proxy->flags & VIRTIO_PCI_FLAG_MIGRATE_EXTRA;
 }
 
-static int get_virtio_pci_modern_state(QEMUFile *f, void *pv, size_t size)
+static int get_virtio_pci_modern_state(QEMUFile *f, void *pv, size_t size,
+                                       VMStateField *field)
 {
     VirtIOPCIProxy *proxy = pv;
     int i;
@@ -137,7 +138,8 @@ static void virtio_pci_save_modern_queue_state(VirtIOPCIQueue *vq,
     qemu_put_be32(f, vq->used[1]);
 }
 
-static void put_virtio_pci_modern_state(QEMUFile *f, void *pv, size_t size)
+static int put_virtio_pci_modern_state(QEMUFile *f, void *pv, size_t size,
+                                       VMStateField *field, QJSON *vmdesc)
 {
     VirtIOPCIProxy *proxy = pv;
     int i;
@@ -149,6 +151,8 @@ static void put_virtio_pci_modern_state(QEMUFile *f, void *pv, size_t size)
     for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
         virtio_pci_save_modern_queue_state(&proxy->vqs[i], f);
     }
+
+    return 0;
 }
 
 static const VMStateInfo vmstate_info_virtio_pci_modern_state = {
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index cc17b97..f292a53 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1555,7 +1555,8 @@ static const VMStateDescription vmstate_virtio_ringsize = {
     }
 };
 
-static int get_extra_state(QEMUFile *f, void *pv, size_t size)
+static int get_extra_state(QEMUFile *f, void *pv, size_t size,
+                           VMStateField *field)
 {
     VirtIODevice *vdev = pv;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
@@ -1568,13 +1569,15 @@ static int get_extra_state(QEMUFile *f, void *pv, size_t size)
     }
 }
 
-static void put_extra_state(QEMUFile *f, void *pv, size_t size)
+static int put_extra_state(QEMUFile *f, void *pv, size_t size,
+                           VMStateField *field, QJSON *vmdesc)
 {
     VirtIODevice *vdev = pv;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
 
     k->save_extra_state(qbus->parent, f);
+    return 0;
 }
 
 static const VMStateInfo vmstate_info_extra_state = {
@@ -1709,13 +1712,17 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
 }
 
 /* A wrapper for use as a VMState .put function */
-static void virtio_device_put(QEMUFile *f, void *opaque, size_t size)
+static int virtio_device_put(QEMUFile *f, void *opaque, size_t size,
+                              VMStateField *field, QJSON *vmdesc)
 {
     virtio_save(VIRTIO_DEVICE(opaque), f);
+
+    return 0;
 }
 
 /* A wrapper for use as a VMState .get function */
-static int virtio_device_get(QEMUFile *f, void *opaque, size_t size)
+static int virtio_device_get(QEMUFile *f, void *opaque, size_t size,
+                             VMStateField *field)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
     DeviceClass *dc = DEVICE_CLASS(VIRTIO_DEVICE_GET_CLASS(vdev));
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 2125829..7e61b1e 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -81,11 +81,20 @@ void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque);
 
 typedef struct VMStateInfo VMStateInfo;
 typedef struct VMStateDescription VMStateDescription;
-
+typedef struct VMStateField VMStateField;
+
+/* VMStateInfo allows customized migration of objects that don't fit in
+ * any category in VMStateFlags. Additional information is always passed
+ * into get and put in terms of field and vmdesc parameters. However
+ * these two parameters should only be used in cases when customized
+ * handling is needed, such as QTAILQ. For primitive data types such as
+ * integer, field and vmdesc parameters should be ignored inside get/put.
+ */
 struct VMStateInfo {
     const char *name;
-    int (*get)(QEMUFile *f, void *pv, size_t size);
-    void (*put)(QEMUFile *f, void *pv, size_t size);
+    int (*get)(QEMUFile *f, void *pv, size_t size, VMStateField *field);
+    int (*put)(QEMUFile *f, void *pv, size_t size, VMStateField *field,
+               QJSON *vmdesc);
 };
 
 enum VMStateFlags {
@@ -192,7 +201,7 @@ typedef enum {
     MIG_PRI_MAX,
 } MigrationPriority;
 
-typedef struct {
+struct VMStateField {
     const char *name;
     size_t offset;
     size_t size;
@@ -205,7 +214,7 @@ typedef struct {
     const VMStateDescription *vmsd;
     int version_id;
     bool (*field_exists)(void *opaque, int version_id);
-} VMStateField;
+};
 
 struct VMStateDescription {
     const char *name;
diff --git a/migration/savevm.c b/migration/savevm.c
index f9c06e9..455d5ba 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -220,17 +220,20 @@ void timer_get(QEMUFile *f, QEMUTimer *ts)
  * Not in vmstate.c to not add qemu-timer.c as dependency to vmstate.c
  */
 
-static int get_timer(QEMUFile *f, void *pv, size_t size)
+static int get_timer(QEMUFile *f, void *pv, size_t size, VMStateField *field)
 {
     QEMUTimer *v = pv;
     timer_get(f, v);
     return 0;
 }
 
-static void put_timer(QEMUFile *f, void *pv, size_t size)
+static int put_timer(QEMUFile *f, void *pv, size_t size, VMStateField *field,
+                     QJSON *vmdesc)
 {
     QEMUTimer *v = pv;
     timer_put(f, v);
+
+    return 0;
 }
 
 const VMStateInfo vmstate_info_timer = {
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 0bc9f35..7b4bd6e 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -6,6 +6,7 @@
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
 #include "trace.h"
+#include "migration/qjson.h"
 
 static void vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
                                     void *opaque, QJSON *vmdesc);
@@ -122,8 +123,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                     ret = vmstate_load_state(f, field->vmsd, addr,
                                              field->vmsd->version_id);
                 } else {
-                    ret = field->info->get(f, addr, size);
-
+                   ret = field->info->get(f, addr, size, field);
                 }
                 if (ret >= 0) {
                     ret = qemu_file_get_error(f);
@@ -330,7 +330,7 @@ void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
                 if (field->flags & VMS_STRUCT) {
                     vmstate_save_state(f, field->vmsd, addr, vmdesc_loop);
                 } else {
-                    field->info->put(f, addr, size);
+                    field->info->put(f, addr, size, field, vmdesc_loop);
                 }
 
                 written_bytes = qemu_ftell_fast(f) - old_offset;
@@ -463,17 +463,19 @@ static void vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
 
 /* bool */
 
-static int get_bool(QEMUFile *f, void *pv, size_t size)
+static int get_bool(QEMUFile *f, void *pv, size_t size, VMStateField *field)
 {
     bool *v = pv;
     *v = qemu_get_byte(f);
     return 0;
 }
 
-static void put_bool(QEMUFile *f, void *pv, size_t size)
+static int put_bool(QEMUFile *f, void *pv, size_t size, VMStateField *field,
+                    QJSON *vmdesc)
 {
     bool *v = pv;
     qemu_put_byte(f, *v);
+    return 0;
 }
 
 const VMStateInfo vmstate_info_bool = {
@@ -484,17 +486,19 @@ const VMStateInfo vmstate_info_bool = {
 
 /* 8 bit int */
 
-static int get_int8(QEMUFile *f, void *pv, size_t size)
+static int get_int8(QEMUFile *f, void *pv, size_t size, VMStateField *field)
 {
     int8_t *v = pv;
     qemu_get_s8s(f, v);
     return 0;
 }
 
-static void put_int8(QEMUFile *f, void *pv, size_t size)
+static int put_int8(QEMUFile *f, void *pv, size_t size, VMStateField *field,
+                     QJSON *vmdesc)
 {
     int8_t *v = pv;
     qemu_put_s8s(f, v);
+    return 0;
 }
 
 const VMStateInfo vmstate_info_int8 = {
@@ -505,17 +509,19 @@ const VMStateInfo vmstate_info_int8 = {
 
 /* 16 bit int */
 
-static int get_int16(QEMUFile *f, void *pv, size_t size)
+static int get_int16(QEMUFile *f, void *pv, size_t size, VMStateField *field)
 {
     int16_t *v = pv;
     qemu_get_sbe16s(f, v);
     return 0;
 }
 
-static void put_int16(QEMUFile *f, void *pv, size_t size)
+static int put_int16(QEMUFile *f, void *pv, size_t size, VMStateField *field,
+                     QJSON *vmdesc)
 {
     int16_t *v = pv;
     qemu_put_sbe16s(f, v);
+    return 0;
 }
 
 const VMStateInfo vmstate_info_int16 = {
@@ -526,17 +532,19 @@ const VMStateInfo vmstate_info_int16 = {
 
 /* 32 bit int */
 
-static int get_int32(QEMUFile *f, void *pv, size_t size)
+static int get_int32(QEMUFile *f, void *pv, size_t size, VMStateField *field)
 {
     int32_t *v = pv;
     qemu_get_sbe32s(f, v);
     return 0;
 }
 
-static void put_int32(QEMUFile *f, void *pv, size_t size)
+static int put_int32(QEMUFile *f, void *pv, size_t size, VMStateField *field,
+                     QJSON *vmdesc)
 {
     int32_t *v = pv;
     qemu_put_sbe32s(f, v);
+    return 0;
 }
 
 const VMStateInfo vmstate_info_int32 = {
@@ -548,7 +556,8 @@ const VMStateInfo vmstate_info_int32 = {
 /* 32 bit int. See that the received value is the same than the one
    in the field */
 
-static int get_int32_equal(QEMUFile *f, void *pv, size_t size)
+static int get_int32_equal(QEMUFile *f, void *pv, size_t size,
+                           VMStateField *field)
 {
     int32_t *v = pv;
     int32_t v2;
@@ -571,7 +580,7 @@ const VMStateInfo vmstate_info_int32_equal = {
  * and less than or equal to the one in the field.
  */
 
-static int get_int32_le(QEMUFile *f, void *pv, size_t size)
+static int get_int32_le(QEMUFile *f, void *pv, size_t size, VMStateField *field)
 {
     int32_t *cur = pv;
     int32_t loaded;
@@ -595,17 +604,19 @@ const VMStateInfo vmstate_info_int32_le = {
 
 /* 64 bit int */
 
-static int get_int64(QEMUFile *f, void *pv, size_t size)
+static int get_int64(QEMUFile *f, void *pv, size_t size, VMStateField *field)
 {
     int64_t *v = pv;
     qemu_get_sbe64s(f, v);
     return 0;
 }
 
-static void put_int64(QEMUFile *f, void *pv, size_t size)
+static int put_int64(QEMUFile *f, void *pv, size_t size, VMStateField *field,
+                      QJSON *vmdesc)
 {
     int64_t *v = pv;
     qemu_put_sbe64s(f, v);
+    return 0;
 }
 
 const VMStateInfo vmstate_info_int64 = {
@@ -616,17 +627,19 @@ const VMStateInfo vmstate_info_int64 = {
 
 /* 8 bit unsigned int */
 
-static int get_uint8(QEMUFile *f, void *pv, size_t size)
+static int get_uint8(QEMUFile *f, void *pv, size_t size, VMStateField *field)
 {
     uint8_t *v = pv;
     qemu_get_8s(f, v);
     return 0;
 }
 
-static void put_uint8(QEMUFile *f, void *pv, size_t size)
+static int put_uint8(QEMUFile *f, void *pv, size_t size, VMStateField *field,
+                     QJSON *vmdesc)
 {
     uint8_t *v = pv;
     qemu_put_8s(f, v);
+    return 0;
 }
 
 const VMStateInfo vmstate_info_uint8 = {
@@ -637,17 +650,19 @@ const VMStateInfo vmstate_info_uint8 = {
 
 /* 16 bit unsigned int */
 
-static int get_uint16(QEMUFile *f, void *pv, size_t size)
+static int get_uint16(QEMUFile *f, void *pv, size_t size, VMStateField *field)
 {
     uint16_t *v = pv;
     qemu_get_be16s(f, v);
     return 0;
 }
 
-static void put_uint16(QEMUFile *f, void *pv, size_t size)
+static int put_uint16(QEMUFile *f, void *pv, size_t size, VMStateField *field,
+                      QJSON *vmdesc)
 {
     uint16_t *v = pv;
     qemu_put_be16s(f, v);
+    return 0;
 }
 
 const VMStateInfo vmstate_info_uint16 = {
@@ -658,17 +673,19 @@ const VMStateInfo vmstate_info_uint16 = {
 
 /* 32 bit unsigned int */
 
-static int get_uint32(QEMUFile *f, void *pv, size_t size)
+static int get_uint32(QEMUFile *f, void *pv, size_t size, VMStateField *field)
 {
     uint32_t *v = pv;
     qemu_get_be32s(f, v);
     return 0;
 }
 
-static void put_uint32(QEMUFile *f, void *pv, size_t size)
+static int put_uint32(QEMUFile *f, void *pv, size_t size, VMStateField *field,
+                      QJSON *vmdesc)
 {
     uint32_t *v = pv;
     qemu_put_be32s(f, v);
+    return 0;
 }
 
 const VMStateInfo vmstate_info_uint32 = {
@@ -680,7 +697,8 @@ const VMStateInfo vmstate_info_uint32 = {
 /* 32 bit uint. See that the received value is the same than the one
    in the field */
 
-static int get_uint32_equal(QEMUFile *f, void *pv, size_t size)
+static int get_uint32_equal(QEMUFile *f, void *pv, size_t size,
+                            VMStateField *field)
 {
     uint32_t *v = pv;
     uint32_t v2;
@@ -701,17 +719,19 @@ const VMStateInfo vmstate_info_uint32_equal = {
 
 /* 64 bit unsigned int */
 
-static int get_uint64(QEMUFile *f, void *pv, size_t size)
+static int get_uint64(QEMUFile *f, void *pv, size_t size, VMStateField *field)
 {
     uint64_t *v = pv;
     qemu_get_be64s(f, v);
     return 0;
 }
 
-static void put_uint64(QEMUFile *f, void *pv, size_t size)
+static int put_uint64(QEMUFile *f, void *pv, size_t size, VMStateField *field,
+                      QJSON *vmdesc)
 {
     uint64_t *v = pv;
     qemu_put_be64s(f, v);
+    return 0;
 }
 
 const VMStateInfo vmstate_info_uint64 = {
@@ -723,7 +743,8 @@ const VMStateInfo vmstate_info_uint64 = {
 /* 64 bit unsigned int. See that the received value is the same than the one
    in the field */
 
-static int get_uint64_equal(QEMUFile *f, void *pv, size_t size)
+static int get_uint64_equal(QEMUFile *f, void *pv, size_t size,
+                            VMStateField *field)
 {
     uint64_t *v = pv;
     uint64_t v2;
@@ -745,7 +766,8 @@ const VMStateInfo vmstate_info_uint64_equal = {
 /* 8 bit int. See that the received value is the same than the one
    in the field */
 
-static int get_uint8_equal(QEMUFile *f, void *pv, size_t size)
+static int get_uint8_equal(QEMUFile *f, void *pv, size_t size,
+                           VMStateField *field)
 {
     uint8_t *v = pv;
     uint8_t v2;
@@ -767,7 +789,8 @@ const VMStateInfo vmstate_info_uint8_equal = {
 /* 16 bit unsigned int int. See that the received value is the same than the one
    in the field */
 
-static int get_uint16_equal(QEMUFile *f, void *pv, size_t size)
+static int get_uint16_equal(QEMUFile *f, void *pv, size_t size,
+                            VMStateField *field)
 {
     uint16_t *v = pv;
     uint16_t v2;
@@ -788,7 +811,8 @@ const VMStateInfo vmstate_info_uint16_equal = {
 
 /* floating point */
 
-static int get_float64(QEMUFile *f, void *pv, size_t size)
+static int get_float64(QEMUFile *f, void *pv, size_t size,
+                       VMStateField *field)
 {
     float64 *v = pv;
 
@@ -796,11 +820,13 @@ static int get_float64(QEMUFile *f, void *pv, size_t size)
     return 0;
 }
 
-static void put_float64(QEMUFile *f, void *pv, size_t size)
+static int put_float64(QEMUFile *f, void *pv, size_t size, VMStateField *field,
+                       QJSON *vmdesc)
 {
     uint64_t *v = pv;
 
     qemu_put_be64(f, float64_val(*v));
+    return 0;
 }
 
 const VMStateInfo vmstate_info_float64 = {
@@ -811,7 +837,8 @@ const VMStateInfo vmstate_info_float64 = {
 
 /* CPU_DoubleU type */
 
-static int get_cpudouble(QEMUFile *f, void *pv, size_t size)
+static int get_cpudouble(QEMUFile *f, void *pv, size_t size,
+                         VMStateField *field)
 {
     CPU_DoubleU *v = pv;
     qemu_get_be32s(f, &v->l.upper);
@@ -819,11 +846,13 @@ static int get_cpudouble(QEMUFile *f, void *pv, size_t size)
     return 0;
 }
 
-static void put_cpudouble(QEMUFile *f, void *pv, size_t size)
+static int put_cpudouble(QEMUFile *f, void *pv, size_t size,
+                         VMStateField *field, QJSON *vmdesc)
 {
     CPU_DoubleU *v = pv;
     qemu_put_be32s(f, &v->l.upper);
     qemu_put_be32s(f, &v->l.lower);
+    return 0;
 }
 
 const VMStateInfo vmstate_info_cpudouble = {
@@ -834,17 +863,20 @@ const VMStateInfo vmstate_info_cpudouble = {
 
 /* uint8_t buffers */
 
-static int get_buffer(QEMUFile *f, void *pv, size_t size)
+static int get_buffer(QEMUFile *f, void *pv, size_t size,
+                      VMStateField *field)
 {
     uint8_t *v = pv;
     qemu_get_buffer(f, v, size);
     return 0;
 }
 
-static void put_buffer(QEMUFile *f, void *pv, size_t size)
+static int put_buffer(QEMUFile *f, void *pv, size_t size, VMStateField *field,
+                      QJSON *vmdesc)
 {
     uint8_t *v = pv;
     qemu_put_buffer(f, v, size);
+    return 0;
 }
 
 const VMStateInfo vmstate_info_buffer = {
@@ -856,7 +888,8 @@ const VMStateInfo vmstate_info_buffer = {
 /* unused buffers: space that was used for some fields that are
    not useful anymore */
 
-static int get_unused_buffer(QEMUFile *f, void *pv, size_t size)
+static int get_unused_buffer(QEMUFile *f, void *pv, size_t size,
+                             VMStateField *field)
 {
     uint8_t buf[1024];
     int block_len;
@@ -869,7 +902,8 @@ static int get_unused_buffer(QEMUFile *f, void *pv, size_t size)
    return 0;
 }
 
-static void put_unused_buffer(QEMUFile *f, void *pv, size_t size)
+static int put_unused_buffer(QEMUFile *f, void *pv, size_t size,
+                             VMStateField *field, QJSON *vmdesc)
 {
     static const uint8_t buf[1024];
     int block_len;
@@ -879,6 +913,8 @@ static void put_unused_buffer(QEMUFile *f, void *pv, size_t size)
         size -= block_len;
         qemu_put_buffer(f, buf, block_len);
     }
+
+    return 0;
 }
 
 const VMStateInfo vmstate_info_unused_buffer = {
@@ -894,7 +930,7 @@ const VMStateInfo vmstate_info_unused_buffer = {
  */
 /* This is the number of 64 bit words sent over the wire */
 #define BITS_TO_U64S(nr) DIV_ROUND_UP(nr, 64)
-static int get_bitmap(QEMUFile *f, void *pv, size_t size)
+static int get_bitmap(QEMUFile *f, void *pv, size_t size, VMStateField *field)
 {
     unsigned long *bmp = pv;
     int i, idx = 0;
@@ -908,7 +944,8 @@ static int get_bitmap(QEMUFile *f, void *pv, size_t size)
     return 0;
 }
 
-static void put_bitmap(QEMUFile *f, void *pv, size_t size)
+static int put_bitmap(QEMUFile *f, void *pv, size_t size, VMStateField *field,
+                      QJSON *vmdesc)
 {
     unsigned long *bmp = pv;
     int i, idx = 0;
@@ -919,6 +956,8 @@ static void put_bitmap(QEMUFile *f, void *pv, size_t size)
         }
         qemu_put_be64(f, w);
     }
+
+    return 0;
 }
 
 const VMStateInfo vmstate_info_bitmap = {
diff --git a/target/alpha/machine.c b/target/alpha/machine.c
index b99a123..a102645 100644
--- a/target/alpha/machine.c
+++ b/target/alpha/machine.c
@@ -5,17 +5,19 @@
 #include "hw/boards.h"
 #include "migration/cpu.h"
 
-static int get_fpcr(QEMUFile *f, void *opaque, size_t size)
+static int get_fpcr(QEMUFile *f, void *opaque, size_t size, VMStateField *field)
 {
     CPUAlphaState *env = opaque;
     cpu_alpha_store_fpcr(env, qemu_get_be64(f));
     return 0;
 }
 
-static void put_fpcr(QEMUFile *f, void *opaque, size_t size)
+static int put_fpcr(QEMUFile *f, void *opaque, size_t size,
+                    VMStateField *field, QJSON *vmdesc)
 {
     CPUAlphaState *env = opaque;
     qemu_put_be64(f, cpu_alpha_load_fpcr(env));
+    return 0;
 }
 
 static const VMStateInfo vmstate_fpcr = {
diff --git a/target/arm/machine.c b/target/arm/machine.c
index d90943b..487320d 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -17,7 +17,8 @@ static bool vfp_needed(void *opaque)
     return arm_feature(env, ARM_FEATURE_VFP);
 }
 
-static int get_fpscr(QEMUFile *f, void *opaque, size_t size)
+static int get_fpscr(QEMUFile *f, void *opaque, size_t size,
+                     VMStateField *field)
 {
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
@@ -27,12 +28,14 @@ static int get_fpscr(QEMUFile *f, void *opaque, size_t size)
     return 0;
 }
 
-static void put_fpscr(QEMUFile *f, void *opaque, size_t size)
+static int put_fpscr(QEMUFile *f, void *opaque, size_t size,
+                     VMStateField *field, QJSON *vmdesc)
 {
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
 
     qemu_put_be32(f, vfp_get_fpscr(env));
+    return 0;
 }
 
 static const VMStateInfo vmstate_fpscr = {
@@ -163,7 +166,8 @@ static const VMStateDescription vmstate_pmsav7 = {
     }
 };
 
-static int get_cpsr(QEMUFile *f, void *opaque, size_t size)
+static int get_cpsr(QEMUFile *f, void *opaque, size_t size,
+                    VMStateField *field)
 {
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
@@ -180,7 +184,8 @@ static int get_cpsr(QEMUFile *f, void *opaque, size_t size)
     return 0;
 }
 
-static void put_cpsr(QEMUFile *f, void *opaque, size_t size)
+static int put_cpsr(QEMUFile *f, void *opaque, size_t size,
+                    VMStateField *field, QJSON *vmdesc)
 {
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
@@ -193,6 +198,7 @@ static void put_cpsr(QEMUFile *f, void *opaque, size_t size)
     }
 
     qemu_put_be32(f, val);
+    return 0;
 }
 
 static const VMStateInfo vmstate_cpsr = {
diff --git a/target/i386/machine.c b/target/i386/machine.c
index e002b4f..78ae2f9 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -136,10 +136,12 @@ static const VMStateDescription vmstate_mtrr_var = {
 #define VMSTATE_MTRR_VARS(_field, _state, _n, _v)                    \
     VMSTATE_STRUCT_ARRAY(_field, _state, _n, _v, vmstate_mtrr_var, MTRRVar)
 
-static void put_fpreg_error(QEMUFile *f, void *opaque, size_t size)
+static int put_fpreg_error(QEMUFile *f, void *opaque, size_t size,
+                           VMStateField *field, QJSON *vmdesc)
 {
     fprintf(stderr, "call put_fpreg() with invalid arguments\n");
     exit(0);
+    return 0;
 }
 
 /* XXX: add that in a FPU generic layer */
@@ -164,7 +166,8 @@ static void fp64_to_fp80(union x86_longdouble *p, uint64_t temp)
     p->exp = e;
 }
 
-static int get_fpreg(QEMUFile *f, void *opaque, size_t size)
+static int get_fpreg(QEMUFile *f, void *opaque, size_t size,
+                     VMStateField *field)
 {
     FPReg *fp_reg = opaque;
     uint64_t mant;
@@ -176,7 +179,8 @@ static int get_fpreg(QEMUFile *f, void *opaque, size_t size)
     return 0;
 }
 
-static void put_fpreg(QEMUFile *f, void *opaque, size_t size)
+static int put_fpreg(QEMUFile *f, void *opaque, size_t size,
+                     VMStateField *field, QJSON *vmdesc)
 {
     FPReg *fp_reg = opaque;
     uint64_t mant;
@@ -186,6 +190,8 @@ static void put_fpreg(QEMUFile *f, void *opaque, size_t size)
     cpu_get_fp80(&mant, &exp, fp_reg->d);
     qemu_put_be64s(f, &mant);
     qemu_put_be16s(f, &exp);
+
+    return 0;
 }
 
 static const VMStateInfo vmstate_fpreg = {
@@ -194,7 +200,8 @@ static const VMStateInfo vmstate_fpreg = {
     .put  = put_fpreg,
 };
 
-static int get_fpreg_1_mmx(QEMUFile *f, void *opaque, size_t size)
+static int get_fpreg_1_mmx(QEMUFile *f, void *opaque, size_t size,
+                           VMStateField *field)
 {
     union x86_longdouble *p = opaque;
     uint64_t mant;
@@ -211,7 +218,8 @@ static const VMStateInfo vmstate_fpreg_1_mmx = {
     .put  = put_fpreg_error,
 };
 
-static int get_fpreg_1_no_mmx(QEMUFile *f, void *opaque, size_t size)
+static int get_fpreg_1_no_mmx(QEMUFile *f, void *opaque, size_t size,
+                              VMStateField *field)
 {
     union x86_longdouble *p = opaque;
     uint64_t mant;
@@ -273,17 +281,21 @@ static bool less_than_7(void *opaque, int version_id)
     return version_id < 7;
 }
 
-static int get_uint64_as_uint32(QEMUFile *f, void *pv, size_t size)
+static int get_uint64_as_uint32(QEMUFile *f, void *pv, size_t size,
+                                VMStateField *field)
 {
     uint64_t *v = pv;
     *v = qemu_get_be32(f);
     return 0;
 }
 
-static void put_uint64_as_uint32(QEMUFile *f, void *pv, size_t size)
+static int put_uint64_as_uint32(QEMUFile *f, void *pv, size_t size,
+                                VMStateField *field, QJSON *vmdesc)
 {
     uint64_t *v = pv;
     qemu_put_be32(f, *v);
+
+    return 0;
 }
 
 static const VMStateInfo vmstate_hack_uint64_as_uint32 = {
diff --git a/target/mips/machine.c b/target/mips/machine.c
index d20d948..38c8fe9 100644
--- a/target/mips/machine.c
+++ b/target/mips/machine.c
@@ -19,7 +19,7 @@ static int cpu_post_load(void *opaque, int version_id)
 
 /* FPU state */
 
-static int get_fpr(QEMUFile *f, void *pv, size_t size)
+static int get_fpr(QEMUFile *f, void *pv, size_t size, VMStateField *field)
 {
     int i;
     fpr_t *v = pv;
@@ -30,7 +30,8 @@ static int get_fpr(QEMUFile *f, void *pv, size_t size)
     return 0;
 }
 
-static void put_fpr(QEMUFile *f, void *pv, size_t size)
+static int put_fpr(QEMUFile *f, void *pv, size_t size, VMStateField *field,
+                   QJSON *vmdesc)
 {
     int i;
     fpr_t *v = pv;
@@ -38,6 +39,8 @@ static void put_fpr(QEMUFile *f, void *pv, size_t size)
     for (i = 0; i < MSA_WRLEN/64; i++) {
         qemu_put_sbe64s(f, &v->wr.d[i]);
     }
+
+    return 0;
 }
 
 const VMStateInfo vmstate_info_fpr = {
@@ -124,7 +127,7 @@ const VMStateDescription vmstate_mvp = {
 
 /* TLB state */
 
-static int get_tlb(QEMUFile *f, void *pv, size_t size)
+static int get_tlb(QEMUFile *f, void *pv, size_t size, VMStateField *field)
 {
     r4k_tlb_t *v = pv;
     uint16_t flags;
@@ -151,7 +154,8 @@ static int get_tlb(QEMUFile *f, void *pv, size_t size)
     return 0;
 }
 
-static void put_tlb(QEMUFile *f, void *pv, size_t size)
+static int put_tlb(QEMUFile *f, void *pv, size_t size, VMStateField *field,
+                   QJSON *vmdesc)
 {
     r4k_tlb_t *v = pv;
 
@@ -175,6 +179,8 @@ static void put_tlb(QEMUFile *f, void *pv, size_t size)
     qemu_put_be16s(f, &flags);
     qemu_put_be64s(f, &v->PFN[0]);
     qemu_put_be64s(f, &v->PFN[1]);
+
+    return 0;
 }
 
 const VMStateInfo vmstate_info_tlb = {
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 18c16d2..df9f7a4 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -105,7 +105,7 @@ static int cpu_load_old(QEMUFile *f, void *opaque, int version_id)
     return 0;
 }
 
-static int get_avr(QEMUFile *f, void *pv, size_t size)
+static int get_avr(QEMUFile *f, void *pv, size_t size, VMStateField *field)
 {
     ppc_avr_t *v = pv;
 
@@ -115,12 +115,14 @@ static int get_avr(QEMUFile *f, void *pv, size_t size)
     return 0;
 }
 
-static void put_avr(QEMUFile *f, void *pv, size_t size)
+static int put_avr(QEMUFile *f, void *pv, size_t size, VMStateField *field,
+                   QJSON *vmdesc)
 {
     ppc_avr_t *v = pv;
 
     qemu_put_be64(f, v->u64[0]);
     qemu_put_be64(f, v->u64[1]);
+    return 0;
 }
 
 static const VMStateInfo vmstate_info_avr = {
@@ -353,7 +355,7 @@ static const VMStateDescription vmstate_sr = {
 };
 
 #ifdef TARGET_PPC64
-static int get_slbe(QEMUFile *f, void *pv, size_t size)
+static int get_slbe(QEMUFile *f, void *pv, size_t size, VMStateField *field)
 {
     ppc_slb_t *v = pv;
 
@@ -363,12 +365,14 @@ static int get_slbe(QEMUFile *f, void *pv, size_t size)
     return 0;
 }
 
-static void put_slbe(QEMUFile *f, void *pv, size_t size)
+static int put_slbe(QEMUFile *f, void *pv, size_t size, VMStateField *field,
+                    QJSON *vmdesc)
 {
     ppc_slb_t *v = pv;
 
     qemu_put_be64(f, v->esid);
     qemu_put_be64(f, v->vsid);
+    return 0;
 }
 
 static const VMStateInfo vmstate_info_slbe = {
diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index 39e262c..6bd6b8e 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -56,7 +56,7 @@ static const VMStateDescription vmstate_tlb_entry = {
 };
 #endif
 
-static int get_psr(QEMUFile *f, void *opaque, size_t size)
+static int get_psr(QEMUFile *f, void *opaque, size_t size, VMStateField *field)
 {
     SPARCCPU *cpu = opaque;
     CPUSPARCState *env = &cpu->env;
@@ -69,7 +69,8 @@ static int get_psr(QEMUFile *f, void *opaque, size_t size)
     return 0;
 }
 
-static void put_psr(QEMUFile *f, void *opaque, size_t size)
+static int put_psr(QEMUFile *f, void *opaque, size_t size, VMStateField *field,
+                   QJSON *vmdesc)
 {
     SPARCCPU *cpu = opaque;
     CPUSPARCState *env = &cpu->env;
@@ -78,6 +79,7 @@ static void put_psr(QEMUFile *f, void *opaque, size_t size)
     val = cpu_get_psr(env);
 
     qemu_put_be32(f, val);
+    return 0;
 }
 
 static const VMStateInfo vmstate_psr = {
-- 
2.9.3
