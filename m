Received: from eggs.gnu.org ([2001:4830:134:3::10]:52070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ePQXy-0001HQ-JB
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 05:15:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ePQXp-0004M1-9o
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 05:15:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:59090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1ePQXo-0004HH-Os
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 05:15:13 -0500
From: Hannes Reinecke <hare@suse.de>
Date: Thu, 14 Dec 2017 11:14:32 +0100
Message-Id: <20171214101435.26265-2-hare@suse.de>
In-Reply-To: <20171214101435.26265-1-hare@suse.de>
References: <20171214101435.26265-1-hare@suse.de>
Subject: [Qemu-devel] [PATCH 1/4] scsi: use 64-bit LUN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>

The LUN value really is a 64-bit number, so we should as well treat
it as such. And we should be using accessor functions to provide
backwards compability.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 hw/scsi/esp.c          |   6 ++-
 hw/scsi/lsi53c895a.c   |   7 +--
 hw/scsi/megasas.c      |  24 +++++----
 hw/scsi/mptsas.c       |  10 ++--
 hw/scsi/scsi-bus.c     | 137 ++++++++++++++++++++++++++++++++-----------------
 hw/scsi/scsi-disk.c    |   6 +--
 hw/scsi/scsi-generic.c |   2 +-
 hw/scsi/spapr_vscsi.c  |  17 +++---
 hw/scsi/virtio-scsi.c  |  10 ++--
 hw/scsi/vmw_pvscsi.c   |  22 ++++----
 hw/usb/dev-storage.c   |  11 ++--
 hw/usb/dev-uas.c       |  27 +++-------
 include/hw/scsi/scsi.h |  56 +++++++++++++++++---
 13 files changed, 207 insertions(+), 128 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index ee586e7d6c..12b76bc5c4 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -136,8 +136,10 @@ static void do_busid_cmd(ESPState *s, uint8_t *buf, uint8_t busid)
 
     trace_esp_do_busid_cmd(busid);
     lun = busid & 7;
-    current_lun = scsi_device_find(&s->bus, 0, s->current_dev->id, lun);
-    s->current_req = scsi_req_new(current_lun, 0, lun, buf, s);
+    current_lun = scsi_device_find(&s->bus, 0, s->current_dev->id,
+                                   scsi_lun_from_int(lun));
+    s->current_req = scsi_req_new(current_lun, 0, scsi_lun_from_int(lun),
+                                  buf, s);
     datalen = scsi_req_enqueue(s->current_req);
     s->ti_size = datalen;
     if (datalen != 0) {
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 191505df5b..907ba880bf 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -811,7 +811,7 @@ static void lsi_do_command(LSIState *s)
     s->command_complete = 0;
 
     id = (s->select_tag >> 8) & 0xf;
-    dev = scsi_device_find(&s->bus, 0, id, s->current_lun);
+    dev = scsi_device_find(&s->bus, 0, id, scsi_lun_from_int(s->current_lun));
     if (!dev) {
         lsi_bad_selection(s, id);
         return;
@@ -820,8 +820,9 @@ static void lsi_do_command(LSIState *s)
     assert(s->current == NULL);
     s->current = g_new0(lsi_request, 1);
     s->current->tag = s->select_tag;
-    s->current->req = scsi_req_new(dev, s->current->tag, s->current_lun, buf,
-                                   s->current);
+    s->current->req = scsi_req_new(dev, s->current->tag,
+                                   scsi_lun_from_int(s->current_lun),
+                                   buf, s->current);
 
     n = scsi_req_enqueue(s->current->req);
     if (n) {
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index d5eae6239a..2b9fb71b12 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -756,7 +756,7 @@ static int megasas_ctrl_get_info(MegasasState *s, MegasasCmd *cmd)
         uint16_t pd_id;
 
         if (num_pd_disks < 8) {
-            pd_id = ((sdev->id & 0xFF) << 8) | (sdev->lun & 0xFF);
+            pd_id = ((sdev->id & 0xFF) << 8) | scsi_lun_to_int(sdev->lun);
             info.device.port_addr[num_pd_disks] =
                 cpu_to_le64(megasas_get_sata_addr(pd_id));
         }
@@ -975,7 +975,7 @@ static int megasas_dcmd_pd_get_list(MegasasState *s, MegasasCmd *cmd)
         if (num_pd_disks >= max_pd_disks)
             break;
 
-        pd_id = ((sdev->id & 0xFF) << 8) | (sdev->lun & 0xFF);
+        pd_id = ((sdev->id & 0xFF) << 8) | scsi_lun_to_int(sdev->lun);
         info.addr[num_pd_disks].device_id = cpu_to_le16(pd_id);
         info.addr[num_pd_disks].encl_device_id = 0xFFFF;
         info.addr[num_pd_disks].encl_index = 0;
@@ -1028,7 +1028,8 @@ static int megasas_pd_get_info_submit(SCSIDevice *sdev, int lun,
         info->inquiry_data[0] = 0x7f; /* Force PQual 0x3, PType 0x1f */
         info->vpd_page83[0] = 0x7f;
         megasas_setup_inquiry(cmdbuf, 0, sizeof(info->inquiry_data));
-        cmd->req = scsi_req_new(sdev, cmd->index, lun, cmdbuf, cmd);
+        cmd->req = scsi_req_new(sdev, cmd->index, scsi_lun_from_int(lun),
+                                cmdbuf, cmd);
         if (!cmd->req) {
             trace_megasas_dcmd_req_alloc_failed(cmd->index,
                                                 "PD get info std inquiry");
@@ -1110,7 +1111,7 @@ static int megasas_dcmd_pd_get_info(MegasasState *s, MegasasCmd *cmd)
     pd_id = le16_to_cpu(cmd->frame->dcmd.mbox[0]);
     target_id = (pd_id >> 8) & 0xFF;
     lun_id = pd_id & 0xFF;
-    sdev = scsi_device_find(&s->bus, 0, target_id, lun_id);
+    sdev = scsi_device_find(&s->bus, 0, target_id, scsi_lun_from_int(lun_id));
     trace_megasas_dcmd_pd_get_info(cmd->index, pd_id);
 
     if (sdev) {
@@ -1200,7 +1201,7 @@ static int megasas_dcmd_ld_list_query(MegasasState *s, MegasasCmd *cmd)
         if (num_ld_disks >= max_ld_disks) {
             break;
         }
-        info.targetid[num_ld_disks] = sdev->lun;
+        info.targetid[num_ld_disks] = scsi_lun_to_int(sdev->lun);
         num_ld_disks++;
         dcmd_size++;
     }
@@ -1335,7 +1336,7 @@ static int megasas_dcmd_cfg_read(MegasasState *s, MegasasCmd *cmd)
 
     QTAILQ_FOREACH(kid, &s->bus.qbus.children, sibling) {
         SCSIDevice *sdev = SCSI_DEVICE(kid->child);
-        uint16_t sdev_id = ((sdev->id & 0xFF) << 8) | (sdev->lun & 0xFF);
+        uint16_t sdev_id = ((sdev->id & 0xFF) << 8) | scsi_lun_to_int(sdev->lun);
         struct mfi_array *array;
         struct mfi_ld_config *ld;
         uint64_t pd_size;
@@ -1595,7 +1596,7 @@ static int megasas_finish_internal_dcmd(MegasasCmd *cmd,
                                         SCSIRequest *req, size_t resid)
 {
     int retval = MFI_STAT_OK;
-    int lun = req->lun;
+    int lun = scsi_lun_to_int(req->lun);
 
     trace_megasas_dcmd_internal_finish(cmd->index, cmd->dcmd_opcode, lun);
     cmd->iov_size -= resid;
@@ -1671,7 +1672,7 @@ static int megasas_handle_scsi(MegasasState *s, MegasasCmd *cmd,
             return MFI_STAT_DEVICE_NOT_FOUND;
         }
     }
-    sdev = scsi_device_find(&s->bus, 0, target_id, lun_id);
+    sdev = scsi_device_find(&s->bus, 0, target_id, scsi_lun_from_int(lun_id));
 
     cmd->iov_size = le32_to_cpu(cmd->frame->header.data_len);
     trace_megasas_handle_scsi(mfi_frame_desc[frame_cmd], is_logical,
@@ -1700,7 +1701,8 @@ static int megasas_handle_scsi(MegasasState *s, MegasasCmd *cmd,
         return MFI_STAT_SCSI_DONE_WITH_ERROR;
     }
 
-    cmd->req = scsi_req_new(sdev, cmd->index, lun_id, cdb, cmd);
+    cmd->req = scsi_req_new(sdev, cmd->index, scsi_lun_from_int(lun_id),
+                            cdb, cmd);
     if (!cmd->req) {
         trace_megasas_scsi_req_alloc_failed(
                 mfi_frame_desc[frame_cmd], target_id, lun_id);
@@ -1744,7 +1746,7 @@ static int megasas_handle_io(MegasasState *s, MegasasCmd *cmd, int frame_cmd)
     cdb_len = cmd->frame->header.cdb_len;
 
     if (target_id < MFI_MAX_LD && lun_id == 0) {
-        sdev = scsi_device_find(&s->bus, 0, target_id, lun_id);
+        sdev = scsi_device_find(&s->bus, 0, target_id, 0);
     }
 
     trace_megasas_handle_io(cmd->index,
@@ -1775,7 +1777,7 @@ static int megasas_handle_io(MegasasState *s, MegasasCmd *cmd, int frame_cmd)
 
     megasas_encode_lba(cdb, lba_start, lba_count, is_write);
     cmd->req = scsi_req_new(sdev, cmd->index,
-                            lun_id, cdb, cmd);
+                            scsi_lun_from_int(lun_id), cdb, cmd);
     if (!cmd->req) {
         trace_megasas_scsi_req_alloc_failed(
             mfi_frame_desc[frame_cmd], target_id, lun_id);
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index f6db1b0103..f103984152 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -276,7 +276,7 @@ static int mptsas_scsi_device_find(MPTSASState *s, int bus, int target,
         return MPI_IOCSTATUS_SCSI_INVALID_TARGETID;
     }
 
-    *sdev = scsi_device_find(&s->bus, bus, target, lun[1]);
+    *sdev = scsi_device_find(&s->bus, bus, target, scsi_lun_from_str(lun));
     if (!*sdev) {
         return MPI_IOCSTATUS_SCSI_DEVICE_NOT_THERE;
     }
@@ -322,7 +322,7 @@ static int mptsas_process_scsi_io_request(MPTSASState *s,
     }
 
     req->sreq = scsi_req_new(sdev, scsi_io->MsgContext,
-                            scsi_io->LUN[1], scsi_io->CDB, req);
+                             sdev->lun, scsi_io->CDB, req);
 
     if (req->sreq->cmd.xfer > scsi_io->DataLength) {
         goto overrun;
@@ -430,7 +430,7 @@ static void mptsas_process_scsi_task_mgmt(MPTSASState *s, MPIMsgSCSITaskMgmt *re
             reply.IOCStatus = status;
             goto out;
         }
-        if (sdev->lun != req->LUN[1]) {
+        if (sdev->lun != scsi_lun_from_str(req->LUN)) {
             reply.ResponseCode = MPI_SCSITASKMGMT_RSP_TM_INVALID_LUN;
             goto out;
         }
@@ -477,7 +477,7 @@ static void mptsas_process_scsi_task_mgmt(MPTSASState *s, MPIMsgSCSITaskMgmt *re
             reply.IOCStatus = status;
             goto out;
         }
-        if (sdev->lun != req->LUN[1]) {
+        if (sdev->lun != scsi_lun_from_str(req->LUN)) {
             reply.ResponseCode = MPI_SCSITASKMGMT_RSP_TM_INVALID_LUN;
             goto out;
         }
@@ -515,7 +515,7 @@ reply_maybe_async:
             reply.IOCStatus = status;
             goto out;
         }
-        if (sdev->lun != req->LUN[1]) {
+        if (sdev->lun != scsi_lun_from_str(req->LUN)) {
             reply.ResponseCode = MPI_SCSITASKMGMT_RSP_TM_INVALID_LUN;
             goto out;
         }
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 977f7bce1f..a0e66d0e01 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -20,7 +20,7 @@ static void scsi_target_free_buf(SCSIRequest *req);
 static Property scsi_props[] = {
     DEFINE_PROP_UINT32("channel", SCSIDevice, channel, 0),
     DEFINE_PROP_UINT32("scsi-id", SCSIDevice, id, -1),
-    DEFINE_PROP_UINT32("lun", SCSIDevice, lun, -1),
+    DEFINE_PROP_UINT64("lun", SCSIDevice, lun, -1),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -68,7 +68,7 @@ int scsi_bus_parse_cdb(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf,
     return rc;
 }
 
-static SCSIRequest *scsi_device_alloc_req(SCSIDevice *s, uint32_t tag, uint32_t lun,
+static SCSIRequest *scsi_device_alloc_req(SCSIDevice *s, uint32_t tag, uint64_t lun,
                                           uint8_t *buf, void *hba_private)
 {
     SCSIDeviceClass *sc = SCSI_DEVICE_GET_CLASS(s);
@@ -147,6 +147,22 @@ static void scsi_dma_restart_cb(void *opaque, int running, RunState state)
     }
 }
 
+static int scsi_device_count(SCSIBus *bus, int channel, int id)
+{
+    BusChild *kid;
+    int luns = 0;
+
+    QTAILQ_FOREACH_REVERSE(kid, &bus->qbus.children, ChildrenHead, sibling) {
+        DeviceState *qdev = kid->child;
+        SCSIDevice *dev = SCSI_DEVICE(qdev);
+
+        if (dev->channel == channel && dev->id == id) {
+            luns++;
+        }
+    }
+    return luns;
+}
+
 static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
 {
     SCSIDevice *dev = SCSI_DEVICE(qdev);
@@ -162,9 +178,15 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
         error_setg(errp, "bad scsi device id: %d", dev->id);
         return;
     }
-    if (dev->lun != -1 && dev->lun > bus->info->max_lun) {
-        error_setg(errp, "bad scsi device lun: %d", dev->lun);
-        return;
+    if (dev->lun != -1) {
+        /* Compat: commandline might have passed old-style linear LUN */
+        if (dev->lun < 0xffff) {
+            if (dev->lun > bus->info->max_lun) {
+                error_setg(errp, "bad scsi device lun: %"PRIu64"", dev->lun);
+                return;
+            }
+            dev->lun = scsi_lun_from_int(dev->lun);
+        }
     }
 
     if (dev->id == -1) {
@@ -181,15 +203,18 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
         }
         dev->id = id;
     } else if (dev->lun == -1) {
-        int lun = -1;
+        int lun = 0;
         do {
-            d = scsi_device_find(bus, dev->channel, dev->id, ++lun);
-        } while (d && d->lun == lun && lun < bus->info->max_lun);
-        if (d && d->lun == lun) {
+            d = scsi_device_find(bus, dev->channel, dev->id,
+                                 scsi_lun_from_int(lun));
+            lun++;
+        } while (d && scsi_lun_to_int(d->lun) == lun &&
+                 lun < bus->info->max_lun);
+        if (d && scsi_lun_to_int(d->lun) == lun) {
             error_setg(errp, "no free lun");
             return;
         }
-        dev->lun = lun;
+        dev->lun = scsi_lun_from_int(lun);
     } else {
         d = scsi_device_find(bus, dev->channel, dev->id, dev->lun);
         assert(d);
@@ -197,6 +222,10 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
             error_setg(errp, "lun already used by '%s'", d->qdev.id);
             return;
         }
+        if (scsi_device_count(bus, dev->channel, dev->id) >= bus->info->max_lun) {
+            error_setg(errp, "bad scsi device lun: %"PRIu64"", dev->lun);
+            return;
+        }
     }
 
     QTAILQ_INIT(&dev->requests);
@@ -385,16 +414,6 @@ struct SCSITargetReq {
     int buf_len;
 };
 
-static void store_lun(uint8_t *outbuf, int lun)
-{
-    if (lun < 256) {
-        outbuf[1] = lun;
-        return;
-    }
-    outbuf[1] = (lun & 255);
-    outbuf[0] = (lun >> 8) | 0x40;
-}
-
 static bool scsi_target_emulate_report_luns(SCSITargetReq *r)
 {
     BusChild *kid;
@@ -438,7 +457,7 @@ static bool scsi_target_emulate_report_luns(SCSITargetReq *r)
         SCSIDevice *dev = SCSI_DEVICE(qdev);
 
         if (dev->channel == channel && dev->id == id) {
-            store_lun(&r->buf[i], dev->lun);
+            scsi_lun_to_str(dev->lun, &r->buf[i]);
             i += 8;
         }
     }
@@ -631,7 +650,7 @@ static const struct SCSIReqOps reqops_target_command = {
 
 
 SCSIRequest *scsi_req_alloc(const SCSIReqOps *reqops, SCSIDevice *d,
-                            uint32_t tag, uint32_t lun, void *hba_private)
+                            uint32_t tag, uint64_t lun, void *hba_private)
 {
     SCSIRequest *req;
     SCSIBus *bus = scsi_bus_from_device(d);
@@ -652,11 +671,11 @@ SCSIRequest *scsi_req_alloc(const SCSIReqOps *reqops, SCSIDevice *d,
     object_ref(OBJECT(d));
     object_ref(OBJECT(qbus->parent));
     notifier_list_init(&req->cancel_notifiers);
-    trace_scsi_req_alloc(req->dev->id, req->lun, req->tag);
+    trace_scsi_req_alloc(req->dev->id, scsi_lun_to_int(req->lun), req->tag);
     return req;
 }
 
-SCSIRequest *scsi_req_new(SCSIDevice *d, uint32_t tag, uint32_t lun,
+SCSIRequest *scsi_req_new(SCSIDevice *d, uint32_t tag, uint64_t lun,
                           uint8_t *buf, void *hba_private)
 {
     SCSIBus *bus = DO_UPCAST(SCSIBus, qbus, d->qdev.parent_bus);
@@ -694,14 +713,14 @@ SCSIRequest *scsi_req_new(SCSIDevice *d, uint32_t tag, uint32_t lun,
     }
 
     if (ret != 0) {
-        trace_scsi_req_parse_bad(d->id, lun, tag, buf[0]);
+        trace_scsi_req_parse_bad(d->id, scsi_lun_to_int(lun), tag, buf[0]);
         req = scsi_req_alloc(&reqops_invalid_opcode, d, tag, lun, hba_private);
     } else {
         assert(cmd.len != 0);
-        trace_scsi_req_parsed(d->id, lun, tag, buf[0],
+        trace_scsi_req_parsed(d->id, scsi_lun_to_int(lun), tag, buf[0],
                               cmd.mode, cmd.xfer);
         if (cmd.lba != -1) {
-            trace_scsi_req_parsed_lba(d->id, lun, tag, buf[0],
+            trace_scsi_req_parsed_lba(d->id, scsi_lun_to_int(lun), tag, buf[0],
                                       cmd.lba);
         }
 
@@ -719,16 +738,17 @@ SCSIRequest *scsi_req_new(SCSIDevice *d, uint32_t tag, uint32_t lun,
 
     switch (buf[0]) {
     case INQUIRY:
-        trace_scsi_inquiry(d->id, lun, tag, cmd.buf[1], cmd.buf[2]);
+        trace_scsi_inquiry(d->id, scsi_lun_to_int(lun), tag,
+                           cmd.buf[1], cmd.buf[2]);
         break;
     case TEST_UNIT_READY:
-        trace_scsi_test_unit_ready(d->id, lun, tag);
+        trace_scsi_test_unit_ready(d->id, scsi_lun_to_int(lun), tag);
         break;
     case REPORT_LUNS:
-        trace_scsi_report_luns(d->id, lun, tag);
+        trace_scsi_report_luns(d->id, scsi_lun_to_int(lun), tag);
         break;
     case REQUEST_SENSE:
-        trace_scsi_request_sense(d->id, lun, tag);
+        trace_scsi_request_sense(d->id, scsi_lun_to_int(lun), tag);
         break;
     default:
         break;
@@ -816,8 +836,8 @@ int scsi_device_get_sense(SCSIDevice *dev, uint8_t *buf, int len, bool fixed)
 
 void scsi_req_build_sense(SCSIRequest *req, SCSISense sense)
 {
-    trace_scsi_req_build_sense(req->dev->id, req->lun, req->tag,
-                               sense.key, sense.asc, sense.ascq);
+    trace_scsi_req_build_sense(req->dev->id, scsi_lun_to_int(req->lun),
+                               req->tag, sense.key, sense.asc, sense.ascq);
     req->sense_len = scsi_build_sense(req->sense, sense);
 }
 
@@ -848,7 +868,7 @@ int32_t scsi_req_enqueue(SCSIRequest *req)
 
 static void scsi_req_dequeue(SCSIRequest *req)
 {
-    trace_scsi_req_dequeue(req->dev->id, req->lun, req->tag);
+    trace_scsi_req_dequeue(req->dev->id, scsi_lun_to_int(req->lun), req->tag);
     req->retry = false;
     if (req->enqueued) {
         QTAILQ_REMOVE(&req->dev->requests, req, next);
@@ -1339,10 +1359,11 @@ void scsi_req_unref(SCSIRequest *req)
 void scsi_req_continue(SCSIRequest *req)
 {
     if (req->io_canceled) {
-        trace_scsi_req_continue_canceled(req->dev->id, req->lun, req->tag);
+        trace_scsi_req_continue_canceled(req->dev->id,
+                                         scsi_lun_to_int(req->lun), req->tag);
         return;
     }
-    trace_scsi_req_continue(req->dev->id, req->lun, req->tag);
+    trace_scsi_req_continue(req->dev->id, scsi_lun_to_int(req->lun), req->tag);
     if (req->cmd.mode == SCSI_XFER_TO_DEV) {
         req->ops->write_data(req);
     } else {
@@ -1357,10 +1378,11 @@ void scsi_req_data(SCSIRequest *req, int len)
 {
     uint8_t *buf;
     if (req->io_canceled) {
-        trace_scsi_req_data_canceled(req->dev->id, req->lun, req->tag, len);
+        trace_scsi_req_data_canceled(req->dev->id, scsi_lun_to_int(req->lun),
+                                     req->tag, len);
         return;
     }
-    trace_scsi_req_data(req->dev->id, req->lun, req->tag, len);
+    trace_scsi_req_data(req->dev->id, scsi_lun_to_int(req->lun), req->tag, len);
     assert(req->cmd.mode != SCSI_XFER_NONE);
     if (!req->sg) {
         req->resid -= len;
@@ -1463,7 +1485,7 @@ void scsi_req_cancel_complete(SCSIRequest *req)
  * */
 void scsi_req_cancel_async(SCSIRequest *req, Notifier *notifier)
 {
-    trace_scsi_req_cancel(req->dev->id, req->lun, req->tag);
+    trace_scsi_req_cancel(req->dev->id, scsi_lun_to_int(req->lun), req->tag);
     if (notifier) {
         notifier_list_add(&req->cancel_notifiers, notifier);
     }
@@ -1488,7 +1510,7 @@ void scsi_req_cancel_async(SCSIRequest *req, Notifier *notifier)
 
 void scsi_req_cancel(SCSIRequest *req)
 {
-    trace_scsi_req_cancel(req->dev->id, req->lun, req->tag);
+    trace_scsi_req_cancel(req->dev->id, scsi_lun_to_int(req->lun), req->tag);
     if (!req->enqueued) {
         return;
     }
@@ -1539,7 +1561,7 @@ void scsi_device_set_ua(SCSIDevice *sdev, SCSISense sense)
     if (sense.key != UNIT_ATTENTION) {
         return;
     }
-    trace_scsi_device_set_ua(sdev->id, sdev->lun, sense.key,
+    trace_scsi_device_set_ua(sdev->id, scsi_lun_to_int(sdev->lun), sense.key,
                              sense.asc, sense.ascq);
 
     /*
@@ -1576,9 +1598,21 @@ static char *scsibus_get_dev_path(DeviceState *dev)
 
     id = qdev_get_dev_path(hba);
     if (id) {
-        path = g_strdup_printf("%s/%d:%d:%d", id, d->channel, d->id, d->lun);
+        if (scsi_lun_to_int(d->lun) < 0x3fff) {
+            path = g_strdup_printf("%s/%d:%d:%d", id, d->channel, d->id,
+                                   scsi_lun_to_int(d->lun));
+        } else {
+            path = g_strdup_printf("%s/%d:%d:%"PRIx64"", id, d->channel, d->id,
+                                   d->lun);
+        }
     } else {
-        path = g_strdup_printf("%d:%d:%d", d->channel, d->id, d->lun);
+        if (scsi_lun_to_int(d->lun) < 0x3fff) {
+            path = g_strdup_printf("%d:%d:%d", d->channel, d->id,
+                                   scsi_lun_to_int(d->lun));
+        } else {
+            path = g_strdup_printf("%d:%d:%"PRIu64"", d->channel, d->id,
+                                   d->lun);
+        }
     }
     g_free(id);
     return path;
@@ -1587,11 +1621,16 @@ static char *scsibus_get_dev_path(DeviceState *dev)
 static char *scsibus_get_fw_dev_path(DeviceState *dev)
 {
     SCSIDevice *d = SCSI_DEVICE(dev);
-    return g_strdup_printf("channel@%x/%s@%x,%x", d->channel,
-                           qdev_fw_name(dev), d->id, d->lun);
+    if (scsi_lun_to_int(d->lun) > 0x3fff) {
+        return g_strdup_printf("channel@%x/%s@%x,%d", d->channel,
+                               qdev_fw_name(dev), d->id, scsi_lun_to_int(d->lun));
+    } else {
+        return g_strdup_printf("channel@%x/%s@%x,%"PRIx64"", d->channel,
+                               qdev_fw_name(dev), d->id, d->lun);
+    }
 }
 
-SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int id, int lun)
+SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int id, uint64_t lun)
 {
     BusChild *kid;
     SCSIDevice *target_dev = NULL;
@@ -1618,6 +1657,7 @@ static int put_scsi_requests(QEMUFile *f, void *pv, size_t size,
     SCSIDevice *s = pv;
     SCSIBus *bus = DO_UPCAST(SCSIBus, qbus, s->qdev.parent_bus);
     SCSIRequest *req;
+    uint32_t lun;
 
     QTAILQ_FOREACH(req, &s->requests, next) {
         assert(!req->io_canceled);
@@ -1626,8 +1666,9 @@ static int put_scsi_requests(QEMUFile *f, void *pv, size_t size,
 
         qemu_put_sbyte(f, req->retry ? 1 : 2);
         qemu_put_buffer(f, req->cmd.buf, sizeof(req->cmd.buf));
+        lun = (uint32_t)((req->lun >> 32) & 0xFFFFFFFF);
         qemu_put_be32s(f, &req->tag);
-        qemu_put_be32s(f, &req->lun);
+        qemu_put_be32s(f, &lun);
         if (bus->info->save_request) {
             bus->info->save_request(f, req);
         }
@@ -1656,7 +1697,7 @@ static int get_scsi_requests(QEMUFile *f, void *pv, size_t size,
         qemu_get_buffer(f, buf, sizeof(buf));
         qemu_get_be32s(f, &tag);
         qemu_get_be32s(f, &lun);
-        req = scsi_req_new(s, tag, lun, buf, NULL);
+        req = scsi_req_new(s, tag, (uint64_t)lun << 32, buf, NULL);
         req->retry = (sbyte == 1);
         if (bus->info->load_request) {
             req->hba_private = bus->info->load_request(f, req);
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 12431177a7..cbee840601 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2517,7 +2517,7 @@ static const SCSIReqOps *const scsi_disk_reqops_dispatch[256] = {
     [WRITE_VERIFY_16]                 = &scsi_disk_dma_reqops,
 };
 
-static SCSIRequest *scsi_new_request(SCSIDevice *d, uint32_t tag, uint32_t lun,
+static SCSIRequest *scsi_new_request(SCSIDevice *d, uint32_t tag, uint64_t lun,
                                      uint8_t *buf, void *hba_private)
 {
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, d);
@@ -2533,7 +2533,7 @@ static SCSIRequest *scsi_new_request(SCSIDevice *d, uint32_t tag, uint32_t lun,
     req = scsi_req_alloc(ops, &s->qdev, tag, lun, hba_private);
 
 #ifdef DEBUG_SCSI
-    DPRINTF("Command: lun=%d tag=0x%x data=0x%02x", lun, tag, buf[0]);
+    DPRINTF("Command: lun=%"PRIu64" tag=0x%x data=0x%02x", lun, tag, buf[0]);
     {
         int i;
         for (i = 1; i < scsi_cdb_length(buf); i++) {
@@ -2847,7 +2847,7 @@ static const SCSIReqOps scsi_block_dma_reqops = {
 };
 
 static SCSIRequest *scsi_block_new_request(SCSIDevice *d, uint32_t tag,
-                                           uint32_t lun, uint8_t *buf,
+                                           uint64_t lun, uint8_t *buf,
                                            void *hba_private)
 {
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, d);
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index bd0d9ff355..4a161a69b1 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -557,7 +557,7 @@ const SCSIReqOps scsi_generic_req_ops = {
     .save_request = scsi_generic_save_request,
 };
 
-static SCSIRequest *scsi_new_request(SCSIDevice *d, uint32_t tag, uint32_t lun,
+static SCSIRequest *scsi_new_request(SCSIDevice *d, uint32_t tag, uint64_t lun,
                                      uint8_t *buf, void *hba_private)
 {
     return scsi_req_alloc(&scsi_generic_req_ops, d, tag, lun, hba_private);
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 360db53ac8..160c1de6b3 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -136,9 +136,9 @@ static void vscsi_put_req(vscsi_req *req)
     req->active = 0;
 }
 
-static SCSIDevice *vscsi_device_find(SCSIBus *bus, uint64_t srp_lun, int *lun)
+static SCSIDevice *vscsi_device_find(SCSIBus *bus, uint64_t srp_lun, uint64_t *lun)
 {
-    int channel = 0, id = 0;
+    int channel = 0, id = 0, l;
 
 retry:
     switch (srp_lun >> 62) {
@@ -149,16 +149,16 @@ retry:
             srp_lun <<= 16;
             goto retry;
         }
-        *lun = (srp_lun >> 48) & 0xff;
+        l = (srp_lun >> 48) & 0xff;
         break;
 
     case 1:
-        *lun = (srp_lun >> 48) & 0x3fff;
+        l = (srp_lun >> 48) & 0x3fff;
         break;
     case 2:
         channel = (srp_lun >> 53) & 0x7;
         id = (srp_lun >> 56) & 0x3f;
-        *lun = (srp_lun >> 48) & 0x1f;
+        l = (srp_lun >> 48) & 0x1f;
         break;
     case 3:
         *lun = -1;
@@ -166,7 +166,7 @@ retry:
     default:
         abort();
     }
-
+    *lun = scsi_lun_from_int(l);
     return scsi_device_find(bus, channel, id, *lun);
 }
 
@@ -752,7 +752,7 @@ static void vscsi_report_luns(VSCSIState *s, vscsi_req *req)
         }
         resp_data[i] |= dev->id;
         resp_data[i+1] = (dev->channel << 5);
-        resp_data[i+1] |= dev->lun;
+        resp_data[i+1] |= scsi_lun_to_int(dev->lun);
         i += 8;
     }
 
@@ -822,8 +822,9 @@ static int vscsi_process_tsk_mgmt(VSCSIState *s, vscsi_req *req)
 {
     union viosrp_iu *iu = &req->iu;
     vscsi_req *tmpreq;
-    int i, lun = 0, resp = SRP_TSK_MGMT_COMPLETE;
+    int i, resp = SRP_TSK_MGMT_COMPLETE;
     SCSIDevice *d;
+    uint64_t lun = 0;
     uint64_t tag = iu->srp.rsp.tag;
     uint8_t sol_not = iu->srp.cmd.sol_not;
 
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 3aa99717e2..f98bfb3db5 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -25,9 +25,9 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
 
-static inline int virtio_scsi_get_lun(uint8_t *lun)
+static inline uint64_t virtio_scsi_get_lun(uint8_t *lun)
 {
-    return ((lun[2] << 8) | lun[3]) & 0x3FFF;
+    return (((uint64_t)(lun[2] << 8) | lun[3]) & 0x3FFF) << 48;
 }
 
 static inline SCSIDevice *virtio_scsi_device_find(VirtIOSCSI *s, uint8_t *lun)
@@ -737,10 +737,10 @@ void virtio_scsi_push_event(VirtIOSCSI *s, SCSIDevice *dev,
         evt->lun[1] = dev->id;
 
         /* Linux wants us to keep the same encoding we use for REPORT LUNS.  */
-        if (dev->lun >= 256) {
-            evt->lun[2] = (dev->lun >> 8) | 0x40;
+        if (scsi_lun_to_int(dev->lun) >= 256) {
+            evt->lun[2] = (scsi_lun_to_int(dev->lun) >> 8) | 0x40;
         }
-        evt->lun[3] = dev->lun & 0xFF;
+        evt->lun[3] = scsi_lun_to_int(dev->lun) & 0xFF;
     }
     virtio_scsi_complete_req(req);
 }
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index d564e5caff..e2d36f8709 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -135,7 +135,7 @@ typedef struct PVSCSIRequest {
     PVSCSIState *dev;
     uint8_t sense_key;
     uint8_t completed;
-    int lun;
+    uint64_t lun;
     QEMUSGList sgl;
     PVSCSISGState sg;
     struct PVSCSIRingReqDesc req;
@@ -551,7 +551,7 @@ pvscsi_send_msg(PVSCSIState *s, SCSIDevice *dev, uint32_t msg_type)
         msg.type = msg_type;
         msg.bus = dev->channel;
         msg.target = dev->id;
-        msg.lun[1] = dev->lun;
+        scsi_lun_to_str(dev->lun, msg.lun);
 
         pvscsi_msg_ring_put(s, (PVSCSIRingMsgDesc *)&msg);
         pvscsi_ring_flush_msg(&s->rings);
@@ -597,15 +597,15 @@ pvscsi_request_cancelled(SCSIRequest *req)
 
 static SCSIDevice*
 pvscsi_device_find(PVSCSIState *s, int channel, int target,
-                   uint8_t *requested_lun, uint8_t *target_lun)
+                   uint8_t *requested_lun, uint64_t *target_lun)
 {
-    if (requested_lun[0] || requested_lun[2] || requested_lun[3] ||
-        requested_lun[4] || requested_lun[5] || requested_lun[6] ||
-        requested_lun[7] || (target > PVSCSI_MAX_DEVS)) {
+    uint64_t lun64 = scsi_lun_from_str(requested_lun);
+
+    if (scsi_lun_to_int(lun64) > 255 || (target > PVSCSI_MAX_DEVS)) {
         return NULL;
     } else {
-        *target_lun = requested_lun[1];
-        return scsi_device_find(&s->bus, channel, target, *target_lun);
+        *target_lun = lun64;
+        return scsi_device_find(&s->bus, channel, target, lun64);
     }
 }
 
@@ -614,7 +614,7 @@ pvscsi_queue_pending_descriptor(PVSCSIState *s, SCSIDevice **d,
                                 struct PVSCSIRingReqDesc *descr)
 {
     PVSCSIRequest *pvscsi_req;
-    uint8_t lun;
+    uint64_t lun;
 
     pvscsi_req = g_malloc0(sizeof(*pvscsi_req));
     pvscsi_req->dev = s;
@@ -823,14 +823,14 @@ pvscsi_on_cmd_unknown(PVSCSIState *s)
 static uint64_t
 pvscsi_on_cmd_reset_device(PVSCSIState *s)
 {
-    uint8_t target_lun = 0;
+    uint64_t target_lun = 0;
     struct PVSCSICmdDescResetDevice *cmd =
         (struct PVSCSICmdDescResetDevice *) s->curr_cmd_data;
     SCSIDevice *sdev;
 
     sdev = pvscsi_device_find(s, 0, cmd->target, cmd->lun, &target_lun);
 
-    trace_pvscsi_on_cmd_reset_dev(cmd->target, (int) target_lun, sdev);
+    trace_pvscsi_on_cmd_reset_dev(cmd->target, scsi_lun_to_int(target_lun), sdev);
 
     if (sdev != NULL) {
         s->resetting++;
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 8a61ec94c8..14a62ed829 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -371,11 +371,12 @@ static void usb_msd_handle_control(USBDevice *dev, USBPacket *p,
     case ClassInterfaceRequest | GetMaxLun:
         maxlun = 0;
         for (;;) {
-            scsi_dev = scsi_device_find(&s->bus, 0, 0, maxlun+1);
+            scsi_dev = scsi_device_find(&s->bus, 0, 0,
+                                        scsi_lun_from_int(maxlun+1));
             if (scsi_dev == NULL) {
                 break;
             }
-            if (scsi_dev->lun != maxlun+1) {
+            if (scsi_lun_to_int(scsi_dev->lun) != maxlun+1) {
                 break;
             }
             maxlun++;
@@ -429,7 +430,8 @@ static void usb_msd_handle_data(USBDevice *dev, USBPacket *p)
                 goto fail;
             }
             DPRINTF("Command on LUN %d\n", cbw.lun);
-            scsi_dev = scsi_device_find(&s->bus, 0, 0, cbw.lun);
+            scsi_dev = scsi_device_find(&s->bus, 0, 0,
+                                        scsi_lun_from_int(cbw.lun));
             if (scsi_dev == NULL) {
                 error_report("usb-msd: Bad LUN %d", cbw.lun);
                 goto fail;
@@ -447,7 +449,8 @@ static void usb_msd_handle_data(USBDevice *dev, USBPacket *p)
                     tag, cbw.flags, cbw.cmd_len, s->data_len);
             assert(le32_to_cpu(s->csw.residue) == 0);
             s->scsi_len = 0;
-            s->req = scsi_req_new(scsi_dev, tag, cbw.lun, cbw.cmd, NULL);
+            s->req = scsi_req_new(scsi_dev, tag, scsi_lun_from_int(cbw.lun),
+                                  cbw.cmd, NULL);
 #ifdef DEBUG_MSD
             scsi_req_print(s->req);
 #endif
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index c218b53f09..6f4207e868 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -461,19 +461,6 @@ static void usb_uas_queue_write_ready(UASRequest *req)
 
 /* --------------------------------------------------------------------- */
 
-static int usb_uas_get_lun(uint64_t lun64)
-{
-    return (lun64 >> 48) & 0xff;
-}
-
-static SCSIDevice *usb_uas_get_dev(UASDevice *uas, uint64_t lun64)
-{
-    if ((lun64 >> 56) != 0x00) {
-        return NULL;
-    }
-    return scsi_device_find(&uas->bus, 0, 0, usb_uas_get_lun(lun64));
-}
-
 static void usb_uas_complete_data_packet(UASRequest *req)
 {
     USBPacket *p;
@@ -547,7 +534,7 @@ static UASRequest *usb_uas_alloc_request(UASDevice *uas, uas_iu *iu)
     req->uas = uas;
     req->tag = be16_to_cpu(iu->hdr.tag);
     req->lun = be64_to_cpu(iu->command.lun);
-    req->dev = usb_uas_get_dev(req->uas, req->lun);
+    req->dev = scsi_device_find(&uas->bus, 0, 0, req->lun);
     return req;
 }
 
@@ -709,7 +696,7 @@ static void usb_uas_command(UASDevice *uas, uas_iu *iu)
     }
 
     trace_usb_uas_command(uas->dev.addr, req->tag,
-                          usb_uas_get_lun(req->lun),
+                          scsi_lun_to_int(req->lun),
                           req->lun >> 32, req->lun & 0xffffffff);
     QTAILQ_INSERT_TAIL(&uas->requests, req, next);
     if (uas_using_streams(uas) && uas->data3[req->tag] != NULL) {
@@ -719,7 +706,7 @@ static void usb_uas_command(UASDevice *uas, uas_iu *iu)
     }
 
     req->req = scsi_req_new(req->dev, req->tag,
-                            usb_uas_get_lun(req->lun),
+                            scsi_lun_to_int(req->lun),
                             iu->command.cdb, req);
     if (uas->requestlog) {
         scsi_req_print(req->req);
@@ -747,9 +734,8 @@ bad_target:
 static void usb_uas_task(UASDevice *uas, uas_iu *iu)
 {
     uint16_t tag = be16_to_cpu(iu->hdr.tag);
-    uint64_t lun64 = be64_to_cpu(iu->task.lun);
-    SCSIDevice *dev = usb_uas_get_dev(uas, lun64);
-    int lun = usb_uas_get_lun(lun64);
+    uint64_t lun = be64_to_cpu(iu->task.lun);
+    SCSIDevice *dev = scsi_device_find(&uas->bus, 0, 0, lun);
     UASRequest *req;
     uint16_t task_tag;
 
@@ -776,7 +762,8 @@ static void usb_uas_task(UASDevice *uas, uas_iu *iu)
         break;
 
     case UAS_TMF_LOGICAL_UNIT_RESET:
-        trace_usb_uas_tmf_logical_unit_reset(uas->dev.addr, tag, lun);
+        trace_usb_uas_tmf_logical_unit_reset(uas->dev.addr, tag,
+                                             scsi_lun_to_int(lun));
         qdev_reset_all(&dev->qdev);
         usb_uas_queue_response(uas, tag, UAS_RC_TMF_COMPLETE);
         break;
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 23a8ee6a7d..f1b4a759de 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -23,9 +23,9 @@ struct SCSIRequest {
     SCSIDevice        *dev;
     const SCSIReqOps  *ops;
     uint32_t          refcount;
-    uint32_t          tag;
-    uint32_t          lun;
     uint32_t          status;
+    uint32_t          tag;
+    uint64_t          lun;
     void              *hba_private;
     size_t            resid;
     SCSICommand       cmd;
@@ -61,7 +61,7 @@ typedef struct SCSIDeviceClass {
     void (*realize)(SCSIDevice *dev, Error **errp);
     int (*parse_cdb)(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf,
                      void *hba_private);
-    SCSIRequest *(*alloc_req)(SCSIDevice *s, uint32_t tag, uint32_t lun,
+    SCSIRequest *(*alloc_req)(SCSIDevice *s, uint32_t tag, uint64_t lun,
                               uint8_t *buf, void *hba_private);
     void (*unit_attention_reported)(SCSIDevice *s);
 } SCSIDeviceClass;
@@ -79,7 +79,7 @@ struct SCSIDevice
     uint32_t sense_len;
     QTAILQ_HEAD(, SCSIRequest) requests;
     uint32_t channel;
-    uint32_t lun;
+    uint64_t lun;
     int blocksize;
     int type;
     uint64_t max_lba;
@@ -149,6 +149,48 @@ static inline SCSIBus *scsi_bus_from_device(SCSIDevice *d)
     return DO_UPCAST(SCSIBus, qbus, d->qdev.parent_bus);
 }
 
+static inline uint64_t scsi_lun_from_int(unsigned int lun)
+{
+    if (lun < 256) {
+        /* Use peripheral addressing */
+        return (uint64_t)lun << 48;
+    } else if (lun < 0x3fff) {
+        /* Use flat space addressing */
+        return ((uint64_t)lun | 0x4000) << 48;
+    }
+    /* Return Logical unit not specified addressing */
+    return (uint64_t)-1;
+}
+
+static inline int scsi_lun_to_int(uint64_t lun64)
+{
+    return (lun64 >> 48) & 0x3fff;
+}
+
+static inline uint64_t scsi_lun_from_str(uint8_t *lun)
+{
+    int i;
+    uint64_t lun64 = 0;
+
+    for (i = 0; i < 8; i += 2) {
+        lun64 |= (uint64_t)lun[i] << ((i + 1) * 8) |
+            (uint64_t)lun[i + 1] << (i * 8);
+    }
+    return lun64;
+}
+
+static inline void scsi_lun_to_str(uint64_t lun64, uint8_t *lun)
+{
+    int i;
+
+    memset(lun, 0, 8);
+    for (i = 6; i >= 0; i -= 2) {
+        lun[i] = (lun64 >> 8) & 0xFF;
+        lun[i + 1] = lun64 & 0xFF;
+        lun64 = lun64 >> 16;
+    }
+}
+
 SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
                                       int unit, bool removable, int bootindex,
                                       const char *serial, Error **errp);
@@ -156,8 +198,8 @@ void scsi_bus_legacy_handle_cmdline(SCSIBus *bus, bool deprecated);
 void scsi_legacy_handle_cmdline(void);
 
 SCSIRequest *scsi_req_alloc(const SCSIReqOps *reqops, SCSIDevice *d,
-                            uint32_t tag, uint32_t lun, void *hba_private);
-SCSIRequest *scsi_req_new(SCSIDevice *d, uint32_t tag, uint32_t lun,
+                            uint32_t tag, uint64_t lun, void *hba_private);
+SCSIRequest *scsi_req_new(SCSIDevice *d, uint32_t tag, uint64_t lun,
                           uint8_t *buf, void *hba_private);
 int32_t scsi_req_enqueue(SCSIRequest *req);
 SCSIRequest *scsi_req_ref(SCSIRequest *req);
@@ -183,7 +225,7 @@ void scsi_device_report_change(SCSIDevice *dev, SCSISense sense);
 void scsi_device_unit_attention_reported(SCSIDevice *dev);
 void scsi_generic_read_device_identification(SCSIDevice *dev);
 int scsi_device_get_sense(SCSIDevice *dev, uint8_t *buf, int len, bool fixed);
-SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int target, int lun);
+SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int target, uint64_t lun);
 
 /* scsi-generic.c. */
 extern const SCSIReqOps scsi_generic_req_ops;
-- 
2.12.3
