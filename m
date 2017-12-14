Received: from eggs.gnu.org ([2001:4830:134:3::10]:52044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ePQXv-0001DQ-Mz
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 05:15:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ePQXp-0004LY-2d
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 05:15:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:59089)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1ePQXo-0004HE-On
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 05:15:13 -0500
From: Hannes Reinecke <hare@suse.de>
Date: Thu, 14 Dec 2017 11:14:33 +0100
Message-Id: <20171214101435.26265-3-hare@suse.de>
In-Reply-To: <20171214101435.26265-1-hare@suse.de>
References: <20171214101435.26265-1-hare@suse.de>
Subject: [Qemu-devel] [PATCH 2/4] virtio-scsi: implement target rescan
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

Implement a new virtio-scsi command 'rescan' to return a list of
attached targets. The guest is required to set the 'next_id' field
to the next expected target id; the host will return either that
or the next higher target id (if present), or -1 if no additional
targets are found.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 hw/scsi/scsi-bus.c                           | 10 +++++
 hw/scsi/scsi-disk.c                          | 16 +++++++-
 hw/scsi/virtio-scsi.c                        | 55 ++++++++++++++++++++++++++++
 include/hw/scsi/scsi.h                       |  6 ++-
 include/hw/virtio/virtio-scsi.h              |  7 +++-
 include/scsi/constants.h                     | 11 ++++++
 include/standard-headers/linux/virtio_scsi.h | 15 ++++++++
 7 files changed, 115 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index a0e66d0e01..83497ac916 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -21,6 +21,7 @@ static Property scsi_props[] = {
     DEFINE_PROP_UINT32("channel", SCSIDevice, channel, 0),
     DEFINE_PROP_UINT32("scsi-id", SCSIDevice, id, -1),
     DEFINE_PROP_UINT64("lun", SCSIDevice, lun, -1),
+    DEFINE_PROP_UINT8("protocol", SCSIDevice, protocol, SCSI_PROTOCOL_SAS),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -189,6 +190,15 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
         }
     }
 
+    if (dev->protocol != SCSI_PROTOCOL_FCP &&
+        dev->protocol != SCSI_PROTOCOL_SPI &&
+        dev->protocol != SCSI_PROTOCOL_SRP &&
+        dev->protocol != SCSI_PROTOCOL_ISCSI &&
+        dev->protocol != SCSI_PROTOCOL_SAS &&
+        dev->protocol != SCSI_PROTOCOL_UAS) {
+        error_setg(errp, "invalid scsi protocol id: %d", dev->protocol);
+        return;
+    }
     if (dev->id == -1) {
         int id = -1;
         if (dev->lun == -1) {
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index cbee840601..1313aafae3 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -668,7 +668,7 @@ static int scsi_disk_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf)
             }
 
             if (s->qdev.port_wwn) {
-                outbuf[buflen++] = 0x61; // SAS / Binary
+                outbuf[buflen++] = s->qdev.protocol << 8 | 0x1; // Binary
                 outbuf[buflen++] = 0x93; // PIV / Target port / NAA
                 outbuf[buflen++] = 0;    // reserved
                 outbuf[buflen++] = 8;
@@ -677,7 +677,7 @@ static int scsi_disk_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf)
             }
 
             if (s->port_index) {
-                outbuf[buflen++] = 0x61; // SAS / Binary
+                outbuf[buflen++] = s->qdev.protocol << 8 | 0x1; // Binary
                 outbuf[buflen++] = 0x94; // PIV / Target port / relative target port
                 outbuf[buflen++] = 0;    // reserved
                 outbuf[buflen++] = 4;
@@ -2355,6 +2355,18 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
         return;
     }
 
+    if (dev->protocol == SCSI_PROTOCOL_FCP) {
+        if (!s->qdev.port_wwn) {
+            error_setg(errp,
+                       "Missing port_wwn for FCP protocol");
+            return;
+        }
+        if (!s->qdev.node_wwn && (s->qdev.port_wwn >> 60) != 0x02) {
+            error_setg(errp,
+                       "port_wwn is not a IEEE Extended identifier");
+            return;
+        }
+    }
     if (dev->type == TYPE_DISK) {
         blkconf_geometry(&dev->conf, NULL, 65535, 255, 255, &err);
         if (err) {
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index f98bfb3db5..fa2031f636 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -19,6 +19,7 @@
 #include "hw/virtio/virtio-scsi.h"
 #include "qemu/error-report.h"
 #include "qemu/iov.h"
+#include "qemu/cutils.h"
 #include "sysemu/block-backend.h"
 #include "hw/scsi/scsi.h"
 #include "scsi/constants.h"
@@ -386,6 +387,7 @@ fail:
 static void virtio_scsi_handle_ctrl_req(VirtIOSCSI *s, VirtIOSCSIReq *req)
 {
     VirtIODevice *vdev = (VirtIODevice *)s;
+    VirtIOSCSICommon *c = VIRTIO_SCSI_COMMON(vdev);
     uint32_t type;
     int r = 0;
 
@@ -415,6 +417,55 @@ static void virtio_scsi_handle_ctrl_req(VirtIOSCSI *s, VirtIOSCSIReq *req)
             req->resp.an.event_actual = 0;
             req->resp.an.response = VIRTIO_SCSI_S_OK;
         }
+    } else if (type == VIRTIO_SCSI_T_RESCAN) {
+        if (virtio_scsi_parse_req(req, sizeof(VirtIOSCSIRescanReq),
+                                  sizeof(VirtIOSCSIRescanResp)) < 0) {
+            virtio_scsi_bad_req(req);
+            return;
+        } else {
+            BusChild *kid;
+            SCSIDevice *dev = NULL;
+
+            if (req->req.rescan.next_id != -1) {
+                QTAILQ_FOREACH(kid, &s->bus.qbus.children, sibling) {
+                    DeviceState *qdev = kid->child;
+                    SCSIDevice *d = SCSI_DEVICE(qdev);
+
+                    if (d->id >= req->req.rescan.next_id) {
+                        dev = d;
+                        break;
+                    }
+                }
+            }
+            if (dev) {
+                req->resp.rescan.id = dev->id;
+                req->resp.rescan.transport = dev->protocol;
+                if (dev->protocol == SCSI_PROTOCOL_FCP &&
+                    dev->port_wwn && !dev->node_wwn) {
+                    dev->node_wwn = ((uint64_t)1 << 56) |
+                        (dev->port_wwn & ~((uint64_t)0xff << 56));
+                }
+                stq_be_p(req->resp.rescan.node_wwn, dev->node_wwn);
+                stq_be_p(req->resp.rescan.port_wwn, dev->port_wwn);
+            } else {
+                req->resp.rescan.id = -1;
+                if (c->conf.wwnn && c->conf.wwpn) {
+                    req->resp.rescan.transport = SCSI_PROTOCOL_FCP;
+                } else {
+                    req->resp.rescan.transport = SCSI_PROTOCOL_SAS;
+                }
+                if (c->conf.wwnn) {
+                    uint64_t wwnn;
+                    qemu_strtou64(c->conf.wwnn, NULL, 16, &wwnn);
+                    stq_be_p(req->resp.rescan.node_wwn, wwnn);
+                }
+                if (c->conf.wwpn) {
+                    uint64_t wwpn;
+                    qemu_strtou64(c->conf.wwpn, NULL, 16, &wwpn);
+                    stq_be_p(req->resp.rescan.port_wwn, wwpn);
+                }
+            }
+        }
     }
     if (r == 0) {
         virtio_scsi_complete_req(req);
@@ -927,8 +978,12 @@ static Property virtio_scsi_properties[] = {
                                            VIRTIO_SCSI_F_HOTPLUG, true),
     DEFINE_PROP_BIT("param_change", VirtIOSCSI, host_features,
                                                 VIRTIO_SCSI_F_CHANGE, true),
+    DEFINE_PROP_BIT("rescan", VirtIOSCSI, host_features,
+                                          VIRTIO_SCSI_F_RESCAN, true),
     DEFINE_PROP_LINK("iothread", VirtIOSCSI, parent_obj.conf.iothread,
                      TYPE_IOTHREAD, IOThread *),
+    DEFINE_PROP_STRING("wwpn", VirtIOSCSI, parent_obj.conf.wwpn),
+    DEFINE_PROP_STRING("wwnn", VirtIOSCSI, parent_obj.conf.wwnn),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index f1b4a759de..cb2b2bddcd 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -71,19 +71,21 @@ struct SCSIDevice
     DeviceState qdev;
     VMChangeStateEntry *vmsentry;
     QEMUBH *bh;
-    uint32_t id;
     BlockConf conf;
     SCSISense unit_attention;
     bool sense_is_ua;
     uint8_t sense[SCSI_SENSE_BUF_SIZE];
     uint32_t sense_len;
     QTAILQ_HEAD(, SCSIRequest) requests;
+    uint32_t id;
     uint32_t channel;
     uint64_t lun;
     int blocksize;
-    int type;
+    uint8_t type;
+    uint8_t protocol;
     uint64_t max_lba;
     uint64_t wwn;
+    uint64_t node_wwn;
     uint64_t port_wwn;
 };
 
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index 4c0bcdb788..2503680d0c 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -42,6 +42,8 @@ typedef struct virtio_scsi_ctrl_tmf_req VirtIOSCSICtrlTMFReq;
 typedef struct virtio_scsi_ctrl_tmf_resp VirtIOSCSICtrlTMFResp;
 typedef struct virtio_scsi_ctrl_an_req VirtIOSCSICtrlANReq;
 typedef struct virtio_scsi_ctrl_an_resp VirtIOSCSICtrlANResp;
+typedef struct virtio_scsi_rescan_req VirtIOSCSIRescanReq;
+typedef struct virtio_scsi_rescan_resp VirtIOSCSIRescanResp;
 typedef struct virtio_scsi_event VirtIOSCSIEvent;
 typedef struct virtio_scsi_config VirtIOSCSIConfig;
 
@@ -52,8 +54,9 @@ struct VirtIOSCSIConf {
     uint32_t cmd_per_lun;
 #ifdef CONFIG_VHOST_SCSI
     char *vhostfd;
-    char *wwpn;
 #endif
+    char *wwpn;
+    char *wwnn;
     CharBackend chardev;
     uint32_t boot_tpgt;
     IOThread *iothread;
@@ -116,12 +119,14 @@ typedef struct VirtIOSCSIReq {
         VirtIOSCSICmdResp     cmd;
         VirtIOSCSICtrlTMFResp tmf;
         VirtIOSCSICtrlANResp  an;
+        VirtIOSCSIRescanResp  rescan;
         VirtIOSCSIEvent       event;
     } resp;
     union {
         VirtIOSCSICmdReq      cmd;
         VirtIOSCSICtrlTMFReq  tmf;
         VirtIOSCSICtrlANReq   an;
+        VirtIOSCSIRescanReq   rescan;
     } req;
 } VirtIOSCSIReq;
 
diff --git a/include/scsi/constants.h b/include/scsi/constants.h
index a141dd71f8..ee93727052 100644
--- a/include/scsi/constants.h
+++ b/include/scsi/constants.h
@@ -223,6 +223,17 @@
 #define TYPE_INACTIVE       0x20
 #define TYPE_NO_LUN         0x7f
 
+/*
+ * Protocol identifiers
+ */
+
+#define SCSI_PROTOCOL_FCP    0x00
+#define SCSI_PROTOCOL_SPI    0x01
+#define SCSI_PROTOCOL_SRP    0x04
+#define SCSI_PROTOCOL_ISCSI  0x05
+#define SCSI_PROTOCOL_SAS    0x06
+#define SCSI_PROTOCOL_UAS    0x09
+#define SCSI_PROTOCOL_UNSPEC 0x0f
 /* Mode page codes for mode sense/set */
 #define MODE_PAGE_R_W_ERROR                   0x01
 #define MODE_PAGE_HD_GEOMETRY                 0x04
diff --git a/include/standard-headers/linux/virtio_scsi.h b/include/standard-headers/linux/virtio_scsi.h
index ab66166b6a..5b3a930569 100644
--- a/include/standard-headers/linux/virtio_scsi.h
+++ b/include/standard-headers/linux/virtio_scsi.h
@@ -96,6 +96,19 @@ struct virtio_scsi_ctrl_an_resp {
 	uint8_t response;
 } QEMU_PACKED;
 
+/* Target rescan */
+struct virtio_scsi_rescan_req {
+	__virtio32 type;
+	__virtio32 next_id;
+} QEMU_PACKED;
+
+struct virtio_scsi_rescan_resp {
+	__virtio32 id;
+	__virtio32 transport;
+	uint8_t node_wwn[8];
+	uint8_t port_wwn[8];
+} QEMU_PACKED;
+
 struct virtio_scsi_event {
 	__virtio32 event;
 	uint8_t lun[8];
@@ -120,6 +133,7 @@ struct virtio_scsi_config {
 #define VIRTIO_SCSI_F_HOTPLUG                  1
 #define VIRTIO_SCSI_F_CHANGE                   2
 #define VIRTIO_SCSI_F_T10_PI                   3
+#define VIRTIO_SCSI_F_RESCAN                   4
 
 /* Response codes */
 #define VIRTIO_SCSI_S_OK                       0
@@ -140,6 +154,7 @@ struct virtio_scsi_config {
 #define VIRTIO_SCSI_T_TMF                      0
 #define VIRTIO_SCSI_T_AN_QUERY                 1
 #define VIRTIO_SCSI_T_AN_SUBSCRIBE             2
+#define VIRTIO_SCSI_T_RESCAN                   3
 
 /* Valid TMF subtypes.  */
 #define VIRTIO_SCSI_T_TMF_ABORT_TASK           0
-- 
2.12.3
