Received: from eggs.gnu.org ([2001:4830:134:3::10]:47350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMvF8-0000kS-3T
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:30:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMvF3-00076a-IQ
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:30:06 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 17:29:30 +0400
Message-Id: <20181114132931.22624-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] vmstate: constify VMStateField
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, "open list:S390" <qemu-s390x@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>

Because they are supposed to remain const.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/migration/vmstate.h |   6 +-
 hw/display/virtio-gpu.c     |   4 +-
 hw/intc/s390_flic_kvm.c     |   4 +-
 hw/nvram/eeprom93xx.c       |   6 +-
 hw/nvram/fw_cfg.c           |   6 +-
 hw/pci/msix.c               |   4 +-
 hw/pci/pci.c                |   8 +--
 hw/pci/shpc.c               |   7 ++-
 hw/scsi/scsi-bus.c          |   4 +-
 hw/timer/twl92230.c         |   4 +-
 hw/usb/redirect.c           |  12 ++--
 hw/virtio/virtio.c          |   8 +--
 migration/savevm.c          |   7 ++-
 migration/vmstate-types.c   | 119 ++++++++++++++++++++----------------
 migration/vmstate.c         |  31 +++++-----
 target/alpha/machine.c      |   5 +-
 target/arm/machine.c        |  12 ++--
 target/hppa/machine.c       |  10 +--
 target/mips/machine.c       |  14 +++--
 target/openrisc/machine.c   |   5 +-
 target/ppc/machine.c        |  14 +++--
 target/sparc/machine.c      |   7 ++-
 22 files changed, 162 insertions(+), 135 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 2b501d0466..61bef3ef5c 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -40,8 +40,8 @@ typedef struct VMStateField VMStateField;
  */
 struct VMStateInfo {
     const char *name;
-    int (*get)(QEMUFile *f, void *pv, size_t size, VMStateField *field);
-    int (*put)(QEMUFile *f, void *pv, size_t size, VMStateField *field,
+    int (*get)(QEMUFile *f, void *pv, size_t size, const VMStateField *f=
ield);
+    int (*put)(QEMUFile *f, void *pv, size_t size, const VMStateField *f=
ield,
                QJSON *vmdesc);
 };
=20
@@ -186,7 +186,7 @@ struct VMStateDescription {
     int (*post_load)(void *opaque, int version_id);
     int (*pre_save)(void *opaque);
     bool (*needed)(void *opaque);
-    VMStateField *fields;
+    const VMStateField *fields;
     const VMStateDescription **subsections;
 };
=20
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 7be3a9d404..c6fab56f9b 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1073,7 +1073,7 @@ static const VMStateDescription vmstate_virtio_gpu_=
scanouts =3D {
 };
=20
 static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
-                           VMStateField *field, QJSON *vmdesc)
+                           const VMStateField *field, QJSON *vmdesc)
 {
     VirtIOGPU *g =3D opaque;
     struct virtio_gpu_simple_resource *res;
@@ -1101,7 +1101,7 @@ static int virtio_gpu_save(QEMUFile *f, void *opaqu=
e, size_t size,
 }
=20
 static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
-                           VMStateField *field)
+                           const VMStateField *field)
 {
     VirtIOGPU *g =3D opaque;
     struct virtio_gpu_simple_resource *res;
diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 3f804ad52e..a03df37560 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -376,7 +376,7 @@ static void kvm_s390_release_adapter_routes(S390FLICS=
tate *fs,
  * reached
  */
 static int kvm_flic_save(QEMUFile *f, void *opaque, size_t size,
-                         VMStateField *field, QJSON *vmdesc)
+                         const VMStateField *field, QJSON *vmdesc)
 {
     KVMS390FLICState *flic =3D opaque;
     int len =3D FLIC_SAVE_INITIAL_SIZE;
@@ -426,7 +426,7 @@ static int kvm_flic_save(QEMUFile *f, void *opaque, s=
ize_t size,
  * in QEMUFile
  */
 static int kvm_flic_load(QEMUFile *f, void *opaque, size_t size,
-                         VMStateField *field)
+                         const VMStateField *field)
 {
     uint64_t len =3D 0;
     uint64_t count =3D 0;
diff --git a/hw/nvram/eeprom93xx.c b/hw/nvram/eeprom93xx.c
index 2fd0e3c29f..2db3d7cce6 100644
--- a/hw/nvram/eeprom93xx.c
+++ b/hw/nvram/eeprom93xx.c
@@ -95,15 +95,15 @@ struct _eeprom_t {
  */
=20
 static int get_uint16_from_uint8(QEMUFile *f, void *pv, size_t size,
-                                 VMStateField *field)
+                                 const VMStateField *field)
 {
     uint16_t *v =3D pv;
     *v =3D qemu_get_ubyte(f);
     return 0;
 }
=20
-static int put_unused(QEMUFile *f, void *pv, size_t size, VMStateField *=
field,
-                      QJSON *vmdesc)
+static int put_unused(QEMUFile *f, void *pv, size_t size,
+                      const VMStateField *field, QJSON *vmdesc)
 {
     fprintf(stderr, "uint16_from_uint8 is used only for backwards compat=
ibility.\n");
     fprintf(stderr, "Never should be used to write a new state.\n");
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 946f765f7f..3cb726ff68 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -520,15 +520,15 @@ static void fw_cfg_reset(DeviceState *d)
  */
=20
 static int get_uint32_as_uint16(QEMUFile *f, void *pv, size_t size,
-                                VMStateField *field)
+                                const VMStateField *field)
 {
     uint32_t *v =3D pv;
     *v =3D qemu_get_be16(f);
     return 0;
 }
=20
-static int put_unused(QEMUFile *f, void *pv, size_t size, VMStateField *=
field,
-                      QJSON *vmdesc)
+static int put_unused(QEMUFile *f, void *pv, size_t size,
+                      const VMStateField *field, QJSON *vmdesc)
 {
     fprintf(stderr, "uint32_as_uint16 is only used for backward compatib=
ility.\n");
     fprintf(stderr, "This functions shouldn't be called.\n");
diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index c944c02135..702dac4ec7 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -625,7 +625,7 @@ void msix_unset_vector_notifiers(PCIDevice *dev)
 }
=20
 static int put_msix_state(QEMUFile *f, void *pv, size_t size,
-                          VMStateField *field, QJSON *vmdesc)
+                          const VMStateField *field, QJSON *vmdesc)
 {
     msix_save(pv, f);
=20
@@ -633,7 +633,7 @@ static int put_msix_state(QEMUFile *f, void *pv, size=
_t size,
 }
=20
 static int get_msix_state(QEMUFile *f, void *pv, size_t size,
-                          VMStateField *field)
+                          const VMStateField *field)
 {
     msix_load(pv, f);
     return 0;
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index b937f0dc0a..56b13b3320 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -450,7 +450,7 @@ int pci_bus_numa_node(PCIBus *bus)
 }
=20
 static int get_pci_config_device(QEMUFile *f, void *pv, size_t size,
-                                 VMStateField *field)
+                                 const VMStateField *field)
 {
     PCIDevice *s =3D container_of(pv, PCIDevice, config);
     PCIDeviceClass *pc =3D PCI_DEVICE_GET_CLASS(s);
@@ -490,7 +490,7 @@ static int get_pci_config_device(QEMUFile *f, void *p=
v, size_t size,
=20
 /* just put buffer */
 static int put_pci_config_device(QEMUFile *f, void *pv, size_t size,
-                                 VMStateField *field, QJSON *vmdesc)
+                                 const VMStateField *field, QJSON *vmdes=
c)
 {
     const uint8_t **v =3D pv;
     assert(size =3D=3D pci_config_size(container_of(pv, PCIDevice, confi=
g)));
@@ -506,7 +506,7 @@ static VMStateInfo vmstate_info_pci_config =3D {
 };
=20
 static int get_pci_irq_state(QEMUFile *f, void *pv, size_t size,
-                             VMStateField *field)
+                             const VMStateField *field)
 {
     PCIDevice *s =3D container_of(pv, PCIDevice, irq_state);
     uint32_t irq_state[PCI_NUM_PINS];
@@ -528,7 +528,7 @@ static int get_pci_irq_state(QEMUFile *f, void *pv, s=
ize_t size,
 }
=20
 static int put_pci_irq_state(QEMUFile *f, void *pv, size_t size,
-                             VMStateField *field, QJSON *vmdesc)
+                             const VMStateField *field, QJSON *vmdesc)
 {
     int i;
     PCIDevice *s =3D container_of(pv, PCIDevice, irq_state);
diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index a8462d48bb..96a43d2f70 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -688,8 +688,8 @@ void shpc_cap_write_config(PCIDevice *d, uint32_t add=
r, uint32_t val, int l)
     shpc_cap_update_dword(d);
 }
=20
-static int shpc_save(QEMUFile *f, void *pv, size_t size, VMStateField *f=
ield,
-                     QJSON *vmdesc)
+static int shpc_save(QEMUFile *f, void *pv, size_t size,
+                     const VMStateField *field, QJSON *vmdesc)
 {
     PCIDevice *d =3D container_of(pv, PCIDevice, shpc);
     qemu_put_buffer(f, d->shpc->config, SHPC_SIZEOF(d));
@@ -697,7 +697,8 @@ static int shpc_save(QEMUFile *f, void *pv, size_t si=
ze, VMStateField *field,
     return 0;
 }
=20
-static int shpc_load(QEMUFile *f, void *pv, size_t size, VMStateField *f=
ield)
+static int shpc_load(QEMUFile *f, void *pv, size_t size,
+                     const VMStateField *field)
 {
     PCIDevice *d =3D container_of(pv, PCIDevice, shpc);
     int ret =3D qemu_get_buffer(f, d->shpc->config, SHPC_SIZEOF(d));
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 5905f6bf29..97cd167114 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1571,7 +1571,7 @@ SCSIDevice *scsi_device_find(SCSIBus *bus, int chan=
nel, int id, int lun)
 /* SCSI request list.  For simplicity, pv points to the whole device */
=20
 static int put_scsi_requests(QEMUFile *f, void *pv, size_t size,
-                             VMStateField *field, QJSON *vmdesc)
+                             const VMStateField *field, QJSON *vmdesc)
 {
     SCSIDevice *s =3D pv;
     SCSIBus *bus =3D DO_UPCAST(SCSIBus, qbus, s->qdev.parent_bus);
@@ -1599,7 +1599,7 @@ static int put_scsi_requests(QEMUFile *f, void *pv,=
 size_t size,
 }
=20
 static int get_scsi_requests(QEMUFile *f, void *pv, size_t size,
-                             VMStateField *field)
+                             const VMStateField *field)
 {
     SCSIDevice *s =3D pv;
     SCSIBus *bus =3D DO_UPCAST(SCSIBus, qbus, s->qdev.parent_bus);
diff --git a/hw/timer/twl92230.c b/hw/timer/twl92230.c
index 3b43b46199..51ec355f3f 100644
--- a/hw/timer/twl92230.c
+++ b/hw/timer/twl92230.c
@@ -750,7 +750,7 @@ static int menelaus_rx(I2CSlave *i2c)
  */
=20
 static int get_int32_as_uint16(QEMUFile *f, void *pv, size_t size,
-                               VMStateField *field)
+                               const VMStateField *field)
 {
     int *v =3D pv;
     *v =3D qemu_get_be16(f);
@@ -758,7 +758,7 @@ static int get_int32_as_uint16(QEMUFile *f, void *pv,=
 size_t size,
 }
=20
 static int put_int32_as_uint16(QEMUFile *f, void *pv, size_t size,
-                               VMStateField *field, QJSON *vmdesc)
+                               const VMStateField *field, QJSON *vmdesc)
 {
     int *v =3D pv;
     qemu_put_be16(f, *v);
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 99094a721e..18a42d1938 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -2155,7 +2155,7 @@ static int usbredir_post_load(void *priv, int versi=
on_id)
=20
 /* For usbredirparser migration */
 static int usbredir_put_parser(QEMUFile *f, void *priv, size_t unused,
-                               VMStateField *field, QJSON *vmdesc)
+                               const VMStateField *field, QJSON *vmdesc)
 {
     USBRedirDevice *dev =3D priv;
     uint8_t *data;
@@ -2178,7 +2178,7 @@ static int usbredir_put_parser(QEMUFile *f, void *p=
riv, size_t unused,
 }
=20
 static int usbredir_get_parser(QEMUFile *f, void *priv, size_t unused,
-                               VMStateField *field)
+                               const VMStateField *field)
 {
     USBRedirDevice *dev =3D priv;
     uint8_t *data;
@@ -2222,7 +2222,7 @@ static const VMStateInfo usbredir_parser_vmstate_in=
fo =3D {
=20
 /* For buffered packets (iso/irq) queue migration */
 static int usbredir_put_bufpq(QEMUFile *f, void *priv, size_t unused,
-                              VMStateField *field, QJSON *vmdesc)
+                              const VMStateField *field, QJSON *vmdesc)
 {
     struct endp_data *endp =3D priv;
     USBRedirDevice *dev =3D endp->dev;
@@ -2245,7 +2245,7 @@ static int usbredir_put_bufpq(QEMUFile *f, void *pr=
iv, size_t unused,
 }
=20
 static int usbredir_get_bufpq(QEMUFile *f, void *priv, size_t unused,
-                              VMStateField *field)
+                              const VMStateField *field)
 {
     struct endp_data *endp =3D priv;
     USBRedirDevice *dev =3D endp->dev;
@@ -2349,7 +2349,7 @@ static const VMStateDescription usbredir_ep_vmstate=
 =3D {
=20
 /* For PacketIdQueue migration */
 static int usbredir_put_packet_id_q(QEMUFile *f, void *priv, size_t unus=
ed,
-                                    VMStateField *field, QJSON *vmdesc)
+                                    const VMStateField *field, QJSON *vm=
desc)
 {
     struct PacketIdQueue *q =3D priv;
     USBRedirDevice *dev =3D q->dev;
@@ -2368,7 +2368,7 @@ static int usbredir_put_packet_id_q(QEMUFile *f, vo=
id *priv, size_t unused,
 }
=20
 static int usbredir_get_packet_id_q(QEMUFile *f, void *priv, size_t unus=
ed,
-                                    VMStateField *field)
+                                    const VMStateField *field)
 {
     struct PacketIdQueue *q =3D priv;
     USBRedirDevice *dev =3D q->dev;
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 4136d239dd..5828ed14df 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1816,7 +1816,7 @@ static const VMStateDescription vmstate_virtio_ring=
size =3D {
 };
=20
 static int get_extra_state(QEMUFile *f, void *pv, size_t size,
-                           VMStateField *field)
+                           const VMStateField *field)
 {
     VirtIODevice *vdev =3D pv;
     BusState *qbus =3D qdev_get_parent_bus(DEVICE(vdev));
@@ -1830,7 +1830,7 @@ static int get_extra_state(QEMUFile *f, void *pv, s=
ize_t size,
 }
=20
 static int put_extra_state(QEMUFile *f, void *pv, size_t size,
-                           VMStateField *field, QJSON *vmdesc)
+                           const VMStateField *field, QJSON *vmdesc)
 {
     VirtIODevice *vdev =3D pv;
     BusState *qbus =3D qdev_get_parent_bus(DEVICE(vdev));
@@ -1979,14 +1979,14 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
=20
 /* A wrapper for use as a VMState .put function */
 static int virtio_device_put(QEMUFile *f, void *opaque, size_t size,
-                              VMStateField *field, QJSON *vmdesc)
+                              const VMStateField *field, QJSON *vmdesc)
 {
     return virtio_save(VIRTIO_DEVICE(opaque), f);
 }
=20
 /* A wrapper for use as a VMState .get function */
 static int virtio_device_get(QEMUFile *f, void *opaque, size_t size,
-                             VMStateField *field)
+                             const VMStateField *field)
 {
     VirtIODevice *vdev =3D VIRTIO_DEVICE(opaque);
     DeviceClass *dc =3D DEVICE_CLASS(VIRTIO_DEVICE_GET_CLASS(vdev));
diff --git a/migration/savevm.c b/migration/savevm.c
index ef707b8c43..236b242642 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -263,15 +263,16 @@ void timer_get(QEMUFile *f, QEMUTimer *ts)
  * Not in vmstate.c to not add qemu-timer.c as dependency to vmstate.c
  */
=20
-static int get_timer(QEMUFile *f, void *pv, size_t size, VMStateField *f=
ield)
+static int get_timer(QEMUFile *f, void *pv, size_t size,
+                     const VMStateField *field)
 {
     QEMUTimer *v =3D pv;
     timer_get(f, v);
     return 0;
 }
=20
-static int put_timer(QEMUFile *f, void *pv, size_t size, VMStateField *f=
ield,
-                     QJSON *vmdesc)
+static int put_timer(QEMUFile *f, void *pv, size_t size,
+                     const VMStateField *field, QJSON *vmdesc)
 {
     QEMUTimer *v =3D pv;
     timer_put(f, v);
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 48184c380d..6f75f97a07 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -22,15 +22,16 @@
=20
 /* bool */
=20
-static int get_bool(QEMUFile *f, void *pv, size_t size, VMStateField *fi=
eld)
+static int get_bool(QEMUFile *f, void *pv, size_t size,
+                    const VMStateField *field)
 {
     bool *v =3D pv;
     *v =3D qemu_get_byte(f);
     return 0;
 }
=20
-static int put_bool(QEMUFile *f, void *pv, size_t size, VMStateField *fi=
eld,
-                    QJSON *vmdesc)
+static int put_bool(QEMUFile *f, void *pv, size_t size,
+                    const VMStateField *field, QJSON *vmdesc)
 {
     bool *v =3D pv;
     qemu_put_byte(f, *v);
@@ -45,15 +46,16 @@ const VMStateInfo vmstate_info_bool =3D {
=20
 /* 8 bit int */
=20
-static int get_int8(QEMUFile *f, void *pv, size_t size, VMStateField *fi=
eld)
+static int get_int8(QEMUFile *f, void *pv, size_t size,
+                    const VMStateField *field)
 {
     int8_t *v =3D pv;
     qemu_get_s8s(f, v);
     return 0;
 }
=20
-static int put_int8(QEMUFile *f, void *pv, size_t size, VMStateField *fi=
eld,
-                     QJSON *vmdesc)
+static int put_int8(QEMUFile *f, void *pv, size_t size,
+                    const VMStateField *field, QJSON *vmdesc)
 {
     int8_t *v =3D pv;
     qemu_put_s8s(f, v);
@@ -68,15 +70,16 @@ const VMStateInfo vmstate_info_int8 =3D {
=20
 /* 16 bit int */
=20
-static int get_int16(QEMUFile *f, void *pv, size_t size, VMStateField *f=
ield)
+static int get_int16(QEMUFile *f, void *pv, size_t size,
+                     const VMStateField *field)
 {
     int16_t *v =3D pv;
     qemu_get_sbe16s(f, v);
     return 0;
 }
=20
-static int put_int16(QEMUFile *f, void *pv, size_t size, VMStateField *f=
ield,
-                     QJSON *vmdesc)
+static int put_int16(QEMUFile *f, void *pv, size_t size,
+                     const VMStateField *field, QJSON *vmdesc)
 {
     int16_t *v =3D pv;
     qemu_put_sbe16s(f, v);
@@ -91,15 +94,16 @@ const VMStateInfo vmstate_info_int16 =3D {
=20
 /* 32 bit int */
=20
-static int get_int32(QEMUFile *f, void *pv, size_t size, VMStateField *f=
ield)
+static int get_int32(QEMUFile *f, void *pv, size_t size,
+                     const VMStateField *field)
 {
     int32_t *v =3D pv;
     qemu_get_sbe32s(f, v);
     return 0;
 }
=20
-static int put_int32(QEMUFile *f, void *pv, size_t size, VMStateField *f=
ield,
-                     QJSON *vmdesc)
+static int put_int32(QEMUFile *f, void *pv, size_t size,
+                     const VMStateField *field, QJSON *vmdesc)
 {
     int32_t *v =3D pv;
     qemu_put_sbe32s(f, v);
@@ -116,7 +120,7 @@ const VMStateInfo vmstate_info_int32 =3D {
    in the field */
=20
 static int get_int32_equal(QEMUFile *f, void *pv, size_t size,
-                           VMStateField *field)
+                           const VMStateField *field)
 {
     int32_t *v =3D pv;
     int32_t v2;
@@ -142,7 +146,8 @@ const VMStateInfo vmstate_info_int32_equal =3D {
  * and less than or equal to the one in the field.
  */
=20
-static int get_int32_le(QEMUFile *f, void *pv, size_t size, VMStateField=
 *field)
+static int get_int32_le(QEMUFile *f, void *pv, size_t size,
+                        const VMStateField *field)
 {
     int32_t *cur =3D pv;
     int32_t loaded;
@@ -166,15 +171,16 @@ const VMStateInfo vmstate_info_int32_le =3D {
=20
 /* 64 bit int */
=20
-static int get_int64(QEMUFile *f, void *pv, size_t size, VMStateField *f=
ield)
+static int get_int64(QEMUFile *f, void *pv, size_t size,
+                     const VMStateField *field)
 {
     int64_t *v =3D pv;
     qemu_get_sbe64s(f, v);
     return 0;
 }
=20
-static int put_int64(QEMUFile *f, void *pv, size_t size, VMStateField *f=
ield,
-                      QJSON *vmdesc)
+static int put_int64(QEMUFile *f, void *pv, size_t size,
+                     const VMStateField *field, QJSON *vmdesc)
 {
     int64_t *v =3D pv;
     qemu_put_sbe64s(f, v);
@@ -189,15 +195,16 @@ const VMStateInfo vmstate_info_int64 =3D {
=20
 /* 8 bit unsigned int */
=20
-static int get_uint8(QEMUFile *f, void *pv, size_t size, VMStateField *f=
ield)
+static int get_uint8(QEMUFile *f, void *pv, size_t size,
+                     const VMStateField *field)
 {
     uint8_t *v =3D pv;
     qemu_get_8s(f, v);
     return 0;
 }
=20
-static int put_uint8(QEMUFile *f, void *pv, size_t size, VMStateField *f=
ield,
-                     QJSON *vmdesc)
+static int put_uint8(QEMUFile *f, void *pv, size_t size,
+                     const VMStateField *field, QJSON *vmdesc)
 {
     uint8_t *v =3D pv;
     qemu_put_8s(f, v);
@@ -212,15 +219,16 @@ const VMStateInfo vmstate_info_uint8 =3D {
=20
 /* 16 bit unsigned int */
=20
-static int get_uint16(QEMUFile *f, void *pv, size_t size, VMStateField *=
field)
+static int get_uint16(QEMUFile *f, void *pv, size_t size,
+                      const VMStateField *field)
 {
     uint16_t *v =3D pv;
     qemu_get_be16s(f, v);
     return 0;
 }
=20
-static int put_uint16(QEMUFile *f, void *pv, size_t size, VMStateField *=
field,
-                      QJSON *vmdesc)
+static int put_uint16(QEMUFile *f, void *pv, size_t size,
+                      const VMStateField *field, QJSON *vmdesc)
 {
     uint16_t *v =3D pv;
     qemu_put_be16s(f, v);
@@ -235,15 +243,16 @@ const VMStateInfo vmstate_info_uint16 =3D {
=20
 /* 32 bit unsigned int */
=20
-static int get_uint32(QEMUFile *f, void *pv, size_t size, VMStateField *=
field)
+static int get_uint32(QEMUFile *f, void *pv, size_t size,
+                      const VMStateField *field)
 {
     uint32_t *v =3D pv;
     qemu_get_be32s(f, v);
     return 0;
 }
=20
-static int put_uint32(QEMUFile *f, void *pv, size_t size, VMStateField *=
field,
-                      QJSON *vmdesc)
+static int put_uint32(QEMUFile *f, void *pv, size_t size,
+                      const VMStateField *field, QJSON *vmdesc)
 {
     uint32_t *v =3D pv;
     qemu_put_be32s(f, v);
@@ -260,7 +269,7 @@ const VMStateInfo vmstate_info_uint32 =3D {
    in the field */
=20
 static int get_uint32_equal(QEMUFile *f, void *pv, size_t size,
-                            VMStateField *field)
+                            const VMStateField *field)
 {
     uint32_t *v =3D pv;
     uint32_t v2;
@@ -284,15 +293,16 @@ const VMStateInfo vmstate_info_uint32_equal =3D {
=20
 /* 64 bit unsigned int */
=20
-static int get_uint64(QEMUFile *f, void *pv, size_t size, VMStateField *=
field)
+static int get_uint64(QEMUFile *f, void *pv, size_t size,
+                      const VMStateField *field)
 {
     uint64_t *v =3D pv;
     qemu_get_be64s(f, v);
     return 0;
 }
=20
-static int put_uint64(QEMUFile *f, void *pv, size_t size, VMStateField *=
field,
-                      QJSON *vmdesc)
+static int put_uint64(QEMUFile *f, void *pv, size_t size,
+                      const VMStateField *field, QJSON *vmdesc)
 {
     uint64_t *v =3D pv;
     qemu_put_be64s(f, v);
@@ -305,7 +315,8 @@ const VMStateInfo vmstate_info_uint64 =3D {
     .put  =3D put_uint64,
 };
=20
-static int get_nullptr(QEMUFile *f, void *pv, size_t size, VMStateField =
*field)
+static int get_nullptr(QEMUFile *f, void *pv, size_t size,
+                       const VMStateField *field)
=20
 {
     if (qemu_get_byte(f) =3D=3D VMS_NULLPTR_MARKER) {
@@ -316,7 +327,7 @@ static int get_nullptr(QEMUFile *f, void *pv, size_t =
size, VMStateField *field)
 }
=20
 static int put_nullptr(QEMUFile *f, void *pv, size_t size,
-                        VMStateField *field, QJSON *vmdesc)
+                        const VMStateField *field, QJSON *vmdesc)
=20
 {
     if (pv =3D=3D NULL) {
@@ -337,7 +348,7 @@ const VMStateInfo vmstate_info_nullptr =3D {
    in the field */
=20
 static int get_uint64_equal(QEMUFile *f, void *pv, size_t size,
-                            VMStateField *field)
+                            const VMStateField *field)
 {
     uint64_t *v =3D pv;
     uint64_t v2;
@@ -363,7 +374,7 @@ const VMStateInfo vmstate_info_uint64_equal =3D {
    in the field */
=20
 static int get_uint8_equal(QEMUFile *f, void *pv, size_t size,
-                           VMStateField *field)
+                           const VMStateField *field)
 {
     uint8_t *v =3D pv;
     uint8_t v2;
@@ -389,7 +400,7 @@ const VMStateInfo vmstate_info_uint8_equal =3D {
    in the field */
=20
 static int get_uint16_equal(QEMUFile *f, void *pv, size_t size,
-                            VMStateField *field)
+                            const VMStateField *field)
 {
     uint16_t *v =3D pv;
     uint16_t v2;
@@ -414,7 +425,7 @@ const VMStateInfo vmstate_info_uint16_equal =3D {
 /* floating point */
=20
 static int get_float64(QEMUFile *f, void *pv, size_t size,
-                       VMStateField *field)
+                       const VMStateField *field)
 {
     float64 *v =3D pv;
=20
@@ -422,8 +433,8 @@ static int get_float64(QEMUFile *f, void *pv, size_t =
size,
     return 0;
 }
=20
-static int put_float64(QEMUFile *f, void *pv, size_t size, VMStateField =
*field,
-                       QJSON *vmdesc)
+static int put_float64(QEMUFile *f, void *pv, size_t size,
+                       const VMStateField *field, QJSON *vmdesc)
 {
     uint64_t *v =3D pv;
=20
@@ -440,7 +451,7 @@ const VMStateInfo vmstate_info_float64 =3D {
 /* CPU_DoubleU type */
=20
 static int get_cpudouble(QEMUFile *f, void *pv, size_t size,
-                         VMStateField *field)
+                         const VMStateField *field)
 {
     CPU_DoubleU *v =3D pv;
     qemu_get_be32s(f, &v->l.upper);
@@ -449,7 +460,7 @@ static int get_cpudouble(QEMUFile *f, void *pv, size_=
t size,
 }
=20
 static int put_cpudouble(QEMUFile *f, void *pv, size_t size,
-                         VMStateField *field, QJSON *vmdesc)
+                         const VMStateField *field, QJSON *vmdesc)
 {
     CPU_DoubleU *v =3D pv;
     qemu_put_be32s(f, &v->l.upper);
@@ -466,15 +477,15 @@ const VMStateInfo vmstate_info_cpudouble =3D {
 /* uint8_t buffers */
=20
 static int get_buffer(QEMUFile *f, void *pv, size_t size,
-                      VMStateField *field)
+                      const VMStateField *field)
 {
     uint8_t *v =3D pv;
     qemu_get_buffer(f, v, size);
     return 0;
 }
=20
-static int put_buffer(QEMUFile *f, void *pv, size_t size, VMStateField *=
field,
-                      QJSON *vmdesc)
+static int put_buffer(QEMUFile *f, void *pv, size_t size,
+                      const VMStateField *field, QJSON *vmdesc)
 {
     uint8_t *v =3D pv;
     qemu_put_buffer(f, v, size);
@@ -491,7 +502,7 @@ const VMStateInfo vmstate_info_buffer =3D {
    not useful anymore */
=20
 static int get_unused_buffer(QEMUFile *f, void *pv, size_t size,
-                             VMStateField *field)
+                             const VMStateField *field)
 {
     uint8_t buf[1024];
     int block_len;
@@ -505,7 +516,7 @@ static int get_unused_buffer(QEMUFile *f, void *pv, s=
ize_t size,
 }
=20
 static int put_unused_buffer(QEMUFile *f, void *pv, size_t size,
-                             VMStateField *field, QJSON *vmdesc)
+                             const VMStateField *field, QJSON *vmdesc)
 {
     static const uint8_t buf[1024];
     int block_len;
@@ -531,7 +542,8 @@ const VMStateInfo vmstate_info_unused_buffer =3D {
  * in fields that don't really exist in the parent but need to be in the
  * stream.
  */
-static int get_tmp(QEMUFile *f, void *pv, size_t size, VMStateField *fie=
ld)
+static int get_tmp(QEMUFile *f, void *pv, size_t size,
+                   const VMStateField *field)
 {
     int ret;
     const VMStateDescription *vmsd =3D field->vmsd;
@@ -545,8 +557,8 @@ static int get_tmp(QEMUFile *f, void *pv, size_t size=
, VMStateField *field)
     return ret;
 }
=20
-static int put_tmp(QEMUFile *f, void *pv, size_t size, VMStateField *fie=
ld,
-                    QJSON *vmdesc)
+static int put_tmp(QEMUFile *f, void *pv, size_t size,
+                   const VMStateField *field, QJSON *vmdesc)
 {
     const VMStateDescription *vmsd =3D field->vmsd;
     void *tmp =3D g_malloc(size);
@@ -573,7 +585,8 @@ const VMStateInfo vmstate_info_tmp =3D {
  */
 /* This is the number of 64 bit words sent over the wire */
 #define BITS_TO_U64S(nr) DIV_ROUND_UP(nr, 64)
-static int get_bitmap(QEMUFile *f, void *pv, size_t size, VMStateField *=
field)
+static int get_bitmap(QEMUFile *f, void *pv, size_t size,
+                      const VMStateField *field)
 {
     unsigned long *bmp =3D pv;
     int i, idx =3D 0;
@@ -587,8 +600,8 @@ static int get_bitmap(QEMUFile *f, void *pv, size_t s=
ize, VMStateField *field)
     return 0;
 }
=20
-static int put_bitmap(QEMUFile *f, void *pv, size_t size, VMStateField *=
field,
-                      QJSON *vmdesc)
+static int put_bitmap(QEMUFile *f, void *pv, size_t size,
+                      const VMStateField *field, QJSON *vmdesc)
 {
     unsigned long *bmp =3D pv;
     int i, idx =3D 0;
@@ -613,7 +626,7 @@ const VMStateInfo vmstate_info_bitmap =3D {
  * meta data about the QTAILQ is encoded in a VMStateField structure
  */
 static int get_qtailq(QEMUFile *f, void *pv, size_t unused_size,
-                      VMStateField *field)
+                      const VMStateField *field)
 {
     int ret =3D 0;
     const VMStateDescription *vmsd =3D field->vmsd;
@@ -652,7 +665,7 @@ static int get_qtailq(QEMUFile *f, void *pv, size_t u=
nused_size,
=20
 /* put for QTAILQ */
 static int put_qtailq(QEMUFile *f, void *pv, size_t unused_size,
-                      VMStateField *field, QJSON *vmdesc)
+                      const VMStateField *field, QJSON *vmdesc)
 {
     const VMStateDescription *vmsd =3D field->vmsd;
     /* offset of the QTAILQ entry in a QTAILQ element*/
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 0bc240a317..80b59009aa 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -26,7 +26,7 @@ static int vmstate_subsection_save(QEMUFile *f, const V=
MStateDescription *vmsd,
 static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription=
 *vmsd,
                                    void *opaque);
=20
-static int vmstate_n_elems(void *opaque, VMStateField *field)
+static int vmstate_n_elems(void *opaque, const VMStateField *field)
 {
     int n_elems =3D 1;
=20
@@ -50,7 +50,7 @@ static int vmstate_n_elems(void *opaque, VMStateField *=
field)
     return n_elems;
 }
=20
-static int vmstate_size(void *opaque, VMStateField *field)
+static int vmstate_size(void *opaque, const VMStateField *field)
 {
     int size =3D field->size;
=20
@@ -64,7 +64,8 @@ static int vmstate_size(void *opaque, VMStateField *fie=
ld)
     return size;
 }
=20
-static void vmstate_handle_alloc(void *ptr, VMStateField *field, void *o=
paque)
+static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
+                                 void *opaque)
 {
     if (field->flags & VMS_POINTER && field->flags & VMS_ALLOC) {
         gsize size =3D vmstate_size(opaque, field);
@@ -78,7 +79,7 @@ static void vmstate_handle_alloc(void *ptr, VMStateFiel=
d *field, void *opaque)
 int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id)
 {
-    VMStateField *field =3D vmsd->fields;
+    const VMStateField *field =3D vmsd->fields;
     int ret =3D 0;
=20
     trace_vmstate_load_state(vmsd->name, version_id);
@@ -171,9 +172,10 @@ int vmstate_load_state(QEMUFile *f, const VMStateDes=
cription *vmsd,
     return ret;
 }
=20
-static int vmfield_name_num(VMStateField *start, VMStateField *search)
+static int vmfield_name_num(const VMStateField *start,
+                            const VMStateField *search)
 {
-    VMStateField *field;
+    const VMStateField *field;
     int found =3D 0;
=20
     for (field =3D start; field->name; field++) {
@@ -188,9 +190,10 @@ static int vmfield_name_num(VMStateField *start, VMS=
tateField *search)
     return -1;
 }
=20
-static bool vmfield_name_is_unique(VMStateField *start, VMStateField *se=
arch)
+static bool vmfield_name_is_unique(const VMStateField *start,
+                                   const VMStateField *search)
 {
-    VMStateField *field;
+    const VMStateField *field;
     int found =3D 0;
=20
     for (field =3D start; field->name; field++) {
@@ -206,7 +209,7 @@ static bool vmfield_name_is_unique(VMStateField *star=
t, VMStateField *search)
     return true;
 }
=20
-static const char *vmfield_get_type_name(VMStateField *field)
+static const char *vmfield_get_type_name(const VMStateField *field)
 {
     const char *type =3D "unknown";
=20
@@ -221,7 +224,7 @@ static const char *vmfield_get_type_name(VMStateField=
 *field)
     return type;
 }
=20
-static bool vmsd_can_compress(VMStateField *field)
+static bool vmsd_can_compress(const VMStateField *field)
 {
     if (field->field_exists) {
         /* Dynamically existing fields mess up compression */
@@ -229,7 +232,7 @@ static bool vmsd_can_compress(VMStateField *field)
     }
=20
     if (field->flags & VMS_STRUCT) {
-        VMStateField *sfield =3D field->vmsd->fields;
+        const VMStateField *sfield =3D field->vmsd->fields;
         while (sfield->name) {
             if (!vmsd_can_compress(sfield)) {
                 /* Child elements can't compress, so can't we */
@@ -248,7 +251,7 @@ static bool vmsd_can_compress(VMStateField *field)
 }
=20
 static void vmsd_desc_field_start(const VMStateDescription *vmsd, QJSON =
*vmdesc,
-                                  VMStateField *field, int i, int max)
+                                  const VMStateField *field, int i, int =
max)
 {
     char *name, *old_name;
     bool is_array =3D max > 1;
@@ -287,7 +290,7 @@ static void vmsd_desc_field_start(const VMStateDescri=
ption *vmsd, QJSON *vmdesc,
 }
=20
 static void vmsd_desc_field_end(const VMStateDescription *vmsd, QJSON *v=
mdesc,
-                                VMStateField *field, size_t size, int i)
+                                const VMStateField *field, size_t size, =
int i)
 {
     if (!vmdesc) {
         return;
@@ -323,7 +326,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDe=
scription *vmsd,
                          void *opaque, QJSON *vmdesc, int version_id)
 {
     int ret =3D 0;
-    VMStateField *field =3D vmsd->fields;
+    const VMStateField *field =3D vmsd->fields;
=20
     trace_vmstate_save_state_top(vmsd->name);
=20
diff --git a/target/alpha/machine.c b/target/alpha/machine.c
index 0914ba5fc1..abc81cef7b 100644
--- a/target/alpha/machine.c
+++ b/target/alpha/machine.c
@@ -5,7 +5,8 @@
 #include "hw/boards.h"
 #include "migration/cpu.h"
=20
-static int get_fpcr(QEMUFile *f, void *opaque, size_t size, VMStateField=
 *field)
+static int get_fpcr(QEMUFile *f, void *opaque, size_t size,
+                    const VMStateField *field)
 {
     CPUAlphaState *env =3D opaque;
     cpu_alpha_store_fpcr(env, qemu_get_be64(f));
@@ -13,7 +14,7 @@ static int get_fpcr(QEMUFile *f, void *opaque, size_t s=
ize, VMStateField *field)
 }
=20
 static int put_fpcr(QEMUFile *f, void *opaque, size_t size,
-                    VMStateField *field, QJSON *vmdesc)
+                    const VMStateField *field, QJSON *vmdesc)
 {
     CPUAlphaState *env =3D opaque;
     qemu_put_be64(f, cpu_alpha_load_fpcr(env));
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 2033816a64..7a22ebc209 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -18,7 +18,7 @@ static bool vfp_needed(void *opaque)
 }
=20
 static int get_fpscr(QEMUFile *f, void *opaque, size_t size,
-                     VMStateField *field)
+                     const VMStateField *field)
 {
     ARMCPU *cpu =3D opaque;
     CPUARMState *env =3D &cpu->env;
@@ -29,7 +29,7 @@ static int get_fpscr(QEMUFile *f, void *opaque, size_t =
size,
 }
=20
 static int put_fpscr(QEMUFile *f, void *opaque, size_t size,
-                     VMStateField *field, QJSON *vmdesc)
+                     const VMStateField *field, QJSON *vmdesc)
 {
     ARMCPU *cpu =3D opaque;
     CPUARMState *env =3D &cpu->env;
@@ -503,7 +503,7 @@ static const VMStateDescription vmstate_m_security =3D=
 {
 };
=20
 static int get_cpsr(QEMUFile *f, void *opaque, size_t size,
-                    VMStateField *field)
+                    const VMStateField *field)
 {
     ARMCPU *cpu =3D opaque;
     CPUARMState *env =3D &cpu->env;
@@ -559,7 +559,7 @@ static int get_cpsr(QEMUFile *f, void *opaque, size_t=
 size,
 }
=20
 static int put_cpsr(QEMUFile *f, void *opaque, size_t size,
-                    VMStateField *field, QJSON *vmdesc)
+                    const VMStateField *field, QJSON *vmdesc)
 {
     ARMCPU *cpu =3D opaque;
     CPUARMState *env =3D &cpu->env;
@@ -585,7 +585,7 @@ static const VMStateInfo vmstate_cpsr =3D {
 };
=20
 static int get_power(QEMUFile *f, void *opaque, size_t size,
-                    VMStateField *field)
+                    const VMStateField *field)
 {
     ARMCPU *cpu =3D opaque;
     bool powered_off =3D qemu_get_byte(f);
@@ -594,7 +594,7 @@ static int get_power(QEMUFile *f, void *opaque, size_=
t size,
 }
=20
 static int put_power(QEMUFile *f, void *opaque, size_t size,
-                    VMStateField *field, QJSON *vmdesc)
+                    const VMStateField *field, QJSON *vmdesc)
 {
     ARMCPU *cpu =3D opaque;
=20
diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index 8e077788c3..a1bee9796f 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -46,7 +46,8 @@
     VMSTATE_UINTTR_ARRAY_V(_f, _s, _n, 0)
=20
=20
-static int get_psw(QEMUFile *f, void *opaque, size_t size, VMStateField =
*field)
+static int get_psw(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field)
 {
     CPUHPPAState *env =3D opaque;
     cpu_hppa_put_psw(env, qemu_get_betr(f));
@@ -54,7 +55,7 @@ static int get_psw(QEMUFile *f, void *opaque, size_t si=
ze, VMStateField *field)
 }
=20
 static int put_psw(QEMUFile *f, void *opaque, size_t size,
-                   VMStateField *field, QJSON *vmdesc)
+                   const VMStateField *field, QJSON *vmdesc)
 {
     CPUHPPAState *env =3D opaque;
     qemu_put_betr(f, cpu_hppa_get_psw(env));
@@ -68,7 +69,8 @@ static const VMStateInfo vmstate_psw =3D {
 };
=20
 /* FIXME: Use the PA2.0 format, which is a superset of the PA1.1 format.=
  */
-static int get_tlb(QEMUFile *f, void *opaque, size_t size, VMStateField =
*field)
+static int get_tlb(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field)
 {
     hppa_tlb_entry *ent =3D opaque;
     uint32_t val;
@@ -94,7 +96,7 @@ static int get_tlb(QEMUFile *f, void *opaque, size_t si=
ze, VMStateField *field)
 }
=20
 static int put_tlb(QEMUFile *f, void *opaque, size_t size,
-                   VMStateField *field, QJSON *vmdesc)
+                   const VMStateField *field, QJSON *vmdesc)
 {
     hppa_tlb_entry *ent =3D opaque;
     uint32_t val =3D 0;
diff --git a/target/mips/machine.c b/target/mips/machine.c
index 70a8909b90..704e9c01bf 100644
--- a/target/mips/machine.c
+++ b/target/mips/machine.c
@@ -20,7 +20,8 @@ static int cpu_post_load(void *opaque, int version_id)
=20
 /* FPU state */
=20
-static int get_fpr(QEMUFile *f, void *pv, size_t size, VMStateField *fie=
ld)
+static int get_fpr(QEMUFile *f, void *pv, size_t size,
+                   const VMStateField *field)
 {
     int i;
     fpr_t *v =3D pv;
@@ -31,8 +32,8 @@ static int get_fpr(QEMUFile *f, void *pv, size_t size, =
VMStateField *field)
     return 0;
 }
=20
-static int put_fpr(QEMUFile *f, void *pv, size_t size, VMStateField *fie=
ld,
-                   QJSON *vmdesc)
+static int put_fpr(QEMUFile *f, void *pv, size_t size,
+                   const VMStateField *field, QJSON *vmdesc)
 {
     int i;
     fpr_t *v =3D pv;
@@ -128,7 +129,8 @@ const VMStateDescription vmstate_mvp =3D {
=20
 /* TLB state */
=20
-static int get_tlb(QEMUFile *f, void *pv, size_t size, VMStateField *fie=
ld)
+static int get_tlb(QEMUFile *f, void *pv, size_t size,
+                   const VMStateField *field)
 {
     r4k_tlb_t *v =3D pv;
     uint16_t flags;
@@ -155,8 +157,8 @@ static int get_tlb(QEMUFile *f, void *pv, size_t size=
, VMStateField *field)
     return 0;
 }
=20
-static int put_tlb(QEMUFile *f, void *pv, size_t size, VMStateField *fie=
ld,
-                   QJSON *vmdesc)
+static int put_tlb(QEMUFile *f, void *pv, size_t size,
+                   const VMStateField *field, QJSON *vmdesc)
 {
     r4k_tlb_t *v =3D pv;
=20
diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index 1eedbf3dbe..5d822f7ab1 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -49,7 +49,8 @@ static const VMStateDescription vmstate_cpu_tlb =3D {
     }
 };
=20
-static int get_sr(QEMUFile *f, void *opaque, size_t size, VMStateField *=
field)
+static int get_sr(QEMUFile *f, void *opaque, size_t size,
+                  const VMStateField *field)
 {
     CPUOpenRISCState *env =3D opaque;
     cpu_set_sr(env, qemu_get_be32(f));
@@ -57,7 +58,7 @@ static int get_sr(QEMUFile *f, void *opaque, size_t siz=
e, VMStateField *field)
 }
=20
 static int put_sr(QEMUFile *f, void *opaque, size_t size,
-                  VMStateField *field, QJSON *vmdesc)
+                  const VMStateField *field, QJSON *vmdesc)
 {
     CPUOpenRISCState *env =3D opaque;
     qemu_put_be32(f, cpu_get_sr(env));
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index b2745ec4e5..e7b3725273 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -110,7 +110,8 @@ static int cpu_load_old(QEMUFile *f, void *opaque, in=
t version_id)
     return 0;
 }
=20
-static int get_avr(QEMUFile *f, void *pv, size_t size, VMStateField *fie=
ld)
+static int get_avr(QEMUFile *f, void *pv, size_t size,
+                   const VMStateField *field)
 {
     ppc_avr_t *v =3D pv;
=20
@@ -120,8 +121,8 @@ static int get_avr(QEMUFile *f, void *pv, size_t size=
, VMStateField *field)
     return 0;
 }
=20
-static int put_avr(QEMUFile *f, void *pv, size_t size, VMStateField *fie=
ld,
-                   QJSON *vmdesc)
+static int put_avr(QEMUFile *f, void *pv, size_t size,
+                   const VMStateField *field, QJSON *vmdesc)
 {
     ppc_avr_t *v =3D pv;
=20
@@ -452,7 +453,8 @@ static const VMStateDescription vmstate_sr =3D {
 };
=20
 #ifdef TARGET_PPC64
-static int get_slbe(QEMUFile *f, void *pv, size_t size, VMStateField *fi=
eld)
+static int get_slbe(QEMUFile *f, void *pv, size_t size,
+                    const VMStateField *field)
 {
     ppc_slb_t *v =3D pv;
=20
@@ -462,8 +464,8 @@ static int get_slbe(QEMUFile *f, void *pv, size_t siz=
e, VMStateField *field)
     return 0;
 }
=20
-static int put_slbe(QEMUFile *f, void *pv, size_t size, VMStateField *fi=
eld,
-                    QJSON *vmdesc)
+static int put_slbe(QEMUFile *f, void *pv, size_t size,
+                    const VMStateField *field, QJSON *vmdesc)
 {
     ppc_slb_t *v =3D pv;
=20
diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index 8ff9dea297..7791c84963 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -56,7 +56,8 @@ static const VMStateDescription vmstate_tlb_entry =3D {
 };
 #endif
=20
-static int get_psr(QEMUFile *f, void *opaque, size_t size, VMStateField =
*field)
+static int get_psr(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field)
 {
     SPARCCPU *cpu =3D opaque;
     CPUSPARCState *env =3D &cpu->env;
@@ -69,8 +70,8 @@ static int get_psr(QEMUFile *f, void *opaque, size_t si=
ze, VMStateField *field)
     return 0;
 }
=20
-static int put_psr(QEMUFile *f, void *opaque, size_t size, VMStateField =
*field,
-                   QJSON *vmdesc)
+static int put_psr(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field, QJSON *vmdesc)
 {
     SPARCCPU *cpu =3D opaque;
     CPUSPARCState *env =3D &cpu->env;
--=20
2.19.1.708.g4ede3d42df
