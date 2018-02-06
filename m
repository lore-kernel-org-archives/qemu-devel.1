Received: from eggs.gnu.org ([2001:4830:134:3::10]:44991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9uF-0001GU-PP
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9uD-0003LB-SW
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:55 -0500
Received: from mail-db5eur01on0132.outbound.protection.outlook.com
	([104.47.2.132]:39281
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ej9uD-0003KQ-FI
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:53 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Feb 2018 23:30:39 +0300
Message-Id: <20180206203048.11096-26-rkagan@virtuozzo.com>
In-Reply-To: <20180206203048.11096-1-rkagan@virtuozzo.com>
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 25/34] scsi: add Hyper-V/VMBus SCSI
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>, Ben Warren <ben@skyportsystems.com>, si-wei liu <si-wei.liu@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, Vadim Rozenfeld <vrozenfe@redhat.com>

Add an implementation of Hyper-V/VMBus SCSI controller.

Kudos to Evgeny Yakovlev (formerly eyakovlev@virtuozzo.com) for research
and prototyping.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 hw/scsi/hv-scsi.c     | 398 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/scsi/Makefile.objs |   2 +
 hw/scsi/trace-events  |   6 +
 3 files changed, 406 insertions(+)
 create mode 100644 hw/scsi/hv-scsi.c

diff --git a/hw/scsi/hv-scsi.c b/hw/scsi/hv-scsi.c
new file mode 100644
index 0000000000..bbfc26bf0a
--- /dev/null
+++ b/hw/scsi/hv-scsi.c
@@ -0,0 +1,398 @@
+/*
+ * QEMU Hyper-V storage device support
+ *
+ * Copyright (c) 2017-2018 Virtuozzo International GmbH.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "hw/vmbus/vmbus.h"
+#include "sysemu/block-backend.h"
+#include "sysemu/dma.h"
+#include "qemu/iov.h"
+#include "hw/scsi/scsi.h"
+#include "scsi/constants.h"
+#include "trace.h"
+#include "hvscsi-proto.h"
+
+#define TYPE_HV_SCSI "hv-scsi"
+#define HV_SCSI_GUID "ba6163d9-04a1-4d29-b605-72e2ffb1dc7f"
+#define HV_SCSI_MAX_TRANSFER_BYTES (IOV_MAX * TARGET_PAGE_SIZE)
+
+typedef struct HvScsi {
+    VMBusDevice parent;
+    uint16_t num_queues;
+    SCSIBus bus;
+    enum {
+        HV_SCSI_RESET,
+        HV_SCSI_INITIALIZING,
+        HV_SCSI_INITIALIZED,
+    } state;
+    uint8_t protocol_major;
+    uint8_t protocol_minor;
+} HvScsi;
+
+#define HV_SCSI(obj) OBJECT_CHECK(HvScsi, (obj), TYPE_HV_SCSI)
+
+typedef struct HvScsiReq
+{
+    VMBusChanReq vmreq;
+    HvScsi *s;
+    SCSIRequest *sreq;
+    hv_stor_packet *reply;
+} HvScsiReq;
+
+static void hv_scsi_init_req(HvScsi *s, HvScsiReq *req)
+{
+    VMBusChanReq *vmreq = &req->vmreq;
+
+    req->s = s;
+    if (vmreq->comp) {
+        req->reply = vmreq->comp;
+    }
+}
+
+static void hv_scsi_free_req(HvScsiReq *req)
+{
+    vmbus_release_req(req);
+}
+
+static void hv_scsi_save_request(QEMUFile *f, SCSIRequest *sreq)
+{
+    HvScsiReq *req = sreq->hba_private;
+
+    vmbus_save_req(f, &req->vmreq);
+}
+
+static void *hv_scsi_load_request(QEMUFile *f, SCSIRequest *sreq)
+{
+    HvScsiReq *req;
+    HvScsi *scsi = container_of(sreq->bus, HvScsi, bus);
+
+    req = vmbus_load_req(f, VMBUS_DEVICE(scsi), sizeof(*req));
+    if (!req) {
+        error_report("failed to load VMBus request from saved state");
+        return NULL;
+    }
+
+    hv_scsi_init_req(scsi, req);
+    scsi_req_ref(sreq);
+    req->sreq = sreq;
+    return req;
+}
+
+static int complete_io(HvScsiReq *req, uint32_t status)
+{
+    VMBusChanReq *vmreq = &req->vmreq;
+    int res = 0;
+
+    if (vmreq->comp) {
+        req->reply->operation = HV_STOR_OPERATION_COMPLETE_IO;
+        req->reply->flags = 0;
+        req->reply->status = status;
+        res = vmbus_chan_send_completion(vmreq);
+    }
+
+    if (req->sreq) {
+        scsi_req_unref(req->sreq);
+    }
+    hv_scsi_free_req(req);
+    return res;
+}
+
+static int hv_scsi_complete_req(HvScsiReq *req, uint8_t scsi_status,
+                                uint32_t srb_status, size_t resid)
+{
+    hv_srb_packet *srb = &req->reply->srb;
+
+    srb->scsi_status = scsi_status;
+    srb->srb_status = srb_status;
+
+    assert(resid <= srb->transfer_length);
+    srb->transfer_length -= resid;
+
+    return complete_io(req, 0);
+}
+
+static void hv_scsi_request_cancelled(SCSIRequest *r)
+{
+    HvScsiReq *req = r->hba_private;
+    hv_scsi_complete_req(req, GOOD, HV_SRB_STATUS_ABORTED, 0);
+}
+
+static QEMUSGList *hv_scsi_get_sg_list(SCSIRequest *r)
+{
+    HvScsiReq *req = r->hba_private;
+    return &req->vmreq.sgl;
+}
+
+static void hv_scsi_command_complete(SCSIRequest *r, uint32_t status,
+                                     size_t resid)
+{
+    HvScsiReq *req = r->hba_private;
+    hv_srb_packet *srb = &req->reply->srb;
+
+    trace_hvscsi_command_complete(r, status, resid);
+
+    srb->sense_length = scsi_req_get_sense(r, srb->sense_data,
+                                           sizeof(srb->sense_data));
+    hv_scsi_complete_req(req, status, HV_SRB_STATUS_SUCCESS, resid);
+}
+
+static struct SCSIBusInfo hv_scsi_info = {
+    .tcq = true,
+    .max_channel = HV_SRB_MAX_CHANNELS - 1,
+    .max_target = HV_SRB_MAX_TARGETS - 1,
+    .max_lun = HV_SRB_MAX_LUNS_PER_TARGET - 1,
+    .complete = hv_scsi_command_complete,
+    .cancel = hv_scsi_request_cancelled,
+    .get_sg_list = hv_scsi_get_sg_list,
+    .save_request = hv_scsi_save_request,
+    .load_request = hv_scsi_load_request,
+};
+
+static void handle_missing_target(HvScsiReq *req)
+{
+    /*
+     * SRB_STATUS_INVALID_LUN should be enough and it works for windows guests
+     * However linux stor_vsc driver ignores any scsi and srb status errors
+     * for all INQUIRY and MODE_SENSE commands.
+     * So, specifically for those linux clients we also have to fake
+     * an INVALID_LUN sense response.
+     */
+    size_t len = 0;
+    QEMUSGList *sgl = &req->vmreq.sgl;
+    hv_srb_packet *srb = &req->reply->srb;
+    struct iovec iov[4];
+    int iov_cnt;
+
+    iov_cnt = vmbus_map_sgl(sgl, DMA_DIRECTION_FROM_DEVICE, iov,
+                            ARRAY_SIZE(iov), srb->transfer_length, 0);
+
+    switch (srb->cdb[0]) {
+    case INQUIRY: {
+        /* Report invalid device type */
+        uint8_t data = 0x7F;
+        len = iov_from_buf(iov, iov_cnt, 0, &data, sizeof(data));
+        break;
+    }
+
+    case REPORT_LUNS: {
+        /* Report 0 luns */
+        uint32_t data = 0;
+        len = iov_from_buf(iov, iov_cnt, 0, &data, sizeof(data));
+        break;
+    }
+
+    default:
+        error_report("Don't know how to handle 0x%x for bad target",
+                               srb->cdb[0]);
+        break;
+    }
+
+    srb->sense_data[0] = 0x72;
+    srb->sense_data[1] = sense_code_LUN_NOT_SUPPORTED.key;
+    srb->sense_data[2] = sense_code_LUN_NOT_SUPPORTED.asc;
+    srb->sense_data[3] = sense_code_LUN_NOT_SUPPORTED.ascq;
+    srb->sense_length = 4;
+
+    iov_memset(iov, iov_cnt, len, 0, -1);
+    vmbus_unmap_sgl(sgl, DMA_DIRECTION_FROM_DEVICE, iov, iov_cnt, -1);
+
+    srb->scsi_status = CHECK_CONDITION;
+    srb->srb_status = HV_SRB_STATUS_INVALID_LUN |
+        HV_SRB_STATUS_AUTOSENSE_VALID;
+    complete_io(req, 0);
+}
+
+static void hv_scsi_execute_srb(HvScsiReq *req)
+{
+    SCSIRequest *sreq;
+    SCSIDevice *d;
+    VMBusChanReq *vmreq = &req->vmreq;
+    hv_stor_packet *storpkt = req->reply;
+    hv_srb_packet *srb = &storpkt->srb;
+
+    memcpy(storpkt, vmreq->msg, vmreq->msglen);
+
+    trace_hvscsi_srb_packet(srb->length, srb->target, srb->lun,
+            srb->cdb_length, srb->transfer_length, srb->data_in);
+
+    d = scsi_device_find(&req->s->bus, srb->channel, srb->target, srb->lun);
+    if (!d || (srb->lun && d->lun != srb->lun)) {
+        handle_missing_target(req);
+        return;
+    }
+
+    req->sreq = sreq = scsi_req_new(d, srb->channel, srb->lun, srb->cdb, req);
+    assert(sreq);
+
+    scsi_req_ref(sreq);
+    blk_io_plug(d->conf.blk);
+    if (scsi_req_enqueue(sreq)) {
+        scsi_req_continue(sreq);
+    }
+    blk_io_unplug(d->conf.blk);
+    scsi_req_unref(sreq);
+}
+
+static void hv_scsi_handle_packet(HvScsiReq *req)
+{
+    HvScsi *scsi = req->s;
+    struct hv_stor_packet *msg = req->vmreq.msg;
+    uint32_t status = 0;
+
+    trace_hvscsi_vstor_request(msg->operation, msg->flags);
+
+    switch (msg->operation) {
+    case HV_STOR_OPERATION_EXECUTE_SRB:
+        if (scsi->state != HV_SCSI_INITIALIZED) {
+            error_report("%s: EXECUTE_SRB while not initialized", __func__);
+            status = 1;
+            break;
+        }
+        hv_scsi_execute_srb(req);
+        return; /* SRB packets are completed asynchronously */
+
+    case HV_STOR_OPERATION_BEGIN_INITIALIZATION:
+        scsi->state = HV_SCSI_INITIALIZING;
+        break;
+
+    case HV_STOR_OPERATION_QUERY_PROTOCOL_VERSION:
+        scsi->protocol_major = msg->version.major_minor >> 8;
+        scsi->protocol_minor = msg->version.major_minor & 0xFF;
+        break;
+
+    case HV_STOR_OPERATION_QUERY_PROPERTIES:
+        req->reply->properties.max_channel_count = scsi->num_queues;
+        req->reply->properties.flags = HV_STOR_PROPERTIES_MULTI_CHANNEL_FLAG;
+        req->reply->properties.max_transfer_bytes = HV_SCSI_MAX_TRANSFER_BYTES;
+        break;
+
+    case HV_STOR_OPERATION_END_INITIALIZATION:
+        if (scsi->state != HV_SCSI_INITIALIZING) {
+            error_report("%s: END_INITIALIZATION srb while not initializing",
+                         __func__);
+            status = 1;
+            break;
+        }
+        scsi->state = HV_SCSI_INITIALIZED;
+        break;
+
+    default:
+        error_report("unknown vstor packet operation %d", msg->operation);
+        break;
+    }
+
+    complete_io(req, status);
+}
+
+static void hv_scsi_notify_cb(VMBusChannel *chan)
+{
+    HvScsi *scsi = HV_SCSI(vmbus_channel_device(chan));
+
+    for (;;) {
+        HvScsiReq *req = vmbus_channel_recv(chan, sizeof(*req));
+        if (!req) {
+            break;
+        }
+
+        hv_scsi_init_req(scsi, req);
+        hv_scsi_handle_packet(req);
+    }
+}
+
+static void hv_scsi_reset(HvScsi *scsi)
+{
+    qbus_reset_all(&scsi->bus.qbus);
+    scsi->state = HV_SCSI_RESET;
+    scsi->protocol_major = 0;
+    scsi->protocol_minor = 0;
+}
+
+static uint16_t hv_scsi_num_channels(VMBusDevice *dev)
+{
+    return HV_SCSI(dev)->num_queues;
+}
+
+static void hv_scsi_close_channel(VMBusDevice *dev)
+{
+    HvScsi *scsi = HV_SCSI(dev);
+    hv_scsi_reset(scsi);
+}
+
+static void hv_scsi_dev_realize(VMBusDevice *vdev, Error **errp)
+{
+    HvScsi *scsi = HV_SCSI(vdev);
+
+    scsi_bus_new(&scsi->bus, sizeof(scsi->bus), DEVICE(scsi),
+                 &hv_scsi_info, NULL);
+    return;
+}
+
+static void hv_scsi_dev_reset(VMBusDevice *vdev)
+{
+    HvScsi *scsi = HV_SCSI(vdev);
+    hv_scsi_reset(scsi);
+}
+
+static void hv_scsi_dev_unrealize(VMBusDevice *vdev, Error **errp)
+{
+    HvScsi *scsi = HV_SCSI(vdev);
+    hv_scsi_reset(scsi);
+}
+
+static const VMStateDescription vmstate_hv_scsi = {
+    .name = TYPE_HV_SCSI,
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT(parent, HvScsi, 0, vmstate_vmbus_dev, VMBusDevice),
+        VMSTATE_UINT32(state, HvScsi),
+        VMSTATE_UINT8(protocol_major, HvScsi),
+        VMSTATE_UINT8(protocol_minor, HvScsi),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property hv_scsi_properties[] = {
+    DEFINE_PROP_UUID("instanceid", HvScsi, parent.instanceid),
+    DEFINE_PROP_UINT16("num_queues", HvScsi, num_queues, 1),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void hv_scsi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VMBusDeviceClass *vdc = VMBUS_DEVICE_CLASS(klass);
+
+    qemu_uuid_parse(HV_SCSI_GUID, &vdc->classid);
+    dc->props = hv_scsi_properties;
+    dc->fw_name = "scsi";
+    dc->vmsd = &vmstate_hv_scsi;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    vdc->vmdev_realize = hv_scsi_dev_realize;
+    vdc->vmdev_unrealize = hv_scsi_dev_unrealize;
+    vdc->vmdev_reset = hv_scsi_dev_reset;
+    vdc->num_channels = hv_scsi_num_channels;
+    vdc->close_channel = hv_scsi_close_channel;
+    vdc->chan_notify_cb = hv_scsi_notify_cb;
+}
+
+static const TypeInfo hv_scsi_type_info = {
+    .name = TYPE_HV_SCSI,
+    .parent = TYPE_VMBUS_DEVICE,
+    .instance_size = sizeof(HvScsi),
+    .class_init = hv_scsi_class_init,
+};
+
+static void hv_scsi_register_types(void)
+{
+    type_register_static(&hv_scsi_type_info);
+}
+
+type_init(hv_scsi_register_types)
diff --git a/hw/scsi/Makefile.objs b/hw/scsi/Makefile.objs
index b188f7242b..2630b3a756 100644
--- a/hw/scsi/Makefile.objs
+++ b/hw/scsi/Makefile.objs
@@ -13,3 +13,5 @@ obj-y += virtio-scsi.o virtio-scsi-dataplane.o
 obj-$(CONFIG_VHOST_SCSI) += vhost-scsi-common.o vhost-scsi.o
 obj-$(CONFIG_VHOST_USER_SCSI) += vhost-scsi-common.o vhost-user-scsi.o
 endif
+
+obj-$(CONFIG_VMBUS) += hv-scsi.o
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index 6e299d0338..eec9f2dfb0 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -229,3 +229,9 @@ spapr_vscsi_process_login(void) "Got login, sending response !"
 spapr_vscsi_queue_cmd_no_drive(uint64_t lun) "Command for lun 0x%08" PRIx64 " with no drive"
 spapr_vscsi_queue_cmd(uint32_t qtag, unsigned cdb, const char *cmd, int lun, int ret) "Queued command tag 0x%"PRIx32" CMD 0x%x=%s LUN %d ret: %d"
 spapr_vscsi_do_crq(unsigned c0, unsigned c1) "crq: %02x %02x ..."
+
+# hw/scsi/hv-scsi.c
+hvscsi_vstor_request(int operation, uint32_t flags) "vstor packet: operation %d, flags 0x%x"
+hvscsi_srb_packet(uint16_t length, uint8_t target_id, uint8_t lun, uint8_t cdb_length, uint32_t data_transfer_length, uint8_t data_in) "SRB packet: length %d, target %d, lun %d, cdb length %d, data transfer size %d, direction %d"
+hvscsi_command_complete(void *r, int status, size_t resid) "scsi command complete: request %p, status %d, resid %zu"
+hvscsi_missing_target(uint8_t target_id, uint8_t lun) "missing target %d, lun %d"
-- 
2.14.3
