Received: from eggs.gnu.org ([2001:4830:134:3::10]:54338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gBVyK-0004UB-Ig
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 22:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gBVyF-0006Bw-KU
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 22:17:36 -0400
Received: from m12-11.163.com ([220.181.12.11]:40507)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gBVyB-00068H-QN
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 22:17:31 -0400
From: Li Qiang <liq3ea@163.com>
Date: Sat, 13 Oct 2018 19:17:18 -0700
Message-Id: <20181014021718.60974-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH v2] hw: scsi-disk: make it more QOMconventional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, famz@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

Signed-off-by: Li Qiang <liq3ea@163.com>
---

Change since v1:
-fix a typo in scsi_cd_info's name

 hw/scsi/scsi-disk.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index c43163cef4..8e9fa5ca6b 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -55,6 +55,10 @@ do { printf("scsi-disk: " fmt , ## __VA_ARGS__); } while (0)
 #define DEFAULT_MAX_IO_SIZE         INT_MAX     /* 2 GB - 1 block */
 
 #define TYPE_SCSI_DISK_BASE         "scsi-disk-base"
+#define TYPE_SCSI_DISK              "scsi-disk"
+#define TYPE_SCSI_HD                "scsi-hd"
+#define TYPE_SCSI_BLOCK             "scsi-block"
+#define TYPE_SCSI_CD                "scsi-cd"
 
 #define SCSI_DISK_BASE(obj) \
      OBJECT_CHECK(SCSIDiskState, (obj), TYPE_SCSI_DISK_BASE)
@@ -2357,7 +2361,7 @@ static const BlockDevOps scsi_disk_block_ops = {
 
 static void scsi_disk_unit_attention_reported(SCSIDevice *dev)
 {
-    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
+    SCSIDiskState *s = SCSI_DISK_BASE(dev);
     if (s->media_changed) {
         s->media_changed = false;
         scsi_device_set_ua(&s->qdev, SENSE_CODE(MEDIUM_CHANGED));
@@ -2366,7 +2370,7 @@ static void scsi_disk_unit_attention_reported(SCSIDevice *dev)
 
 static void scsi_realize(SCSIDevice *dev, Error **errp)
 {
-    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
+    SCSIDiskState *s = SCSI_DISK_BASE(dev);
 
     if (!s->qdev.conf.blk) {
         error_setg(errp, "drive property not set");
@@ -2429,7 +2433,7 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
 
 static void scsi_hd_realize(SCSIDevice *dev, Error **errp)
 {
-    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
+    SCSIDiskState *s = SCSI_DISK_BASE(dev);
     /* can happen for devices without drive. The error message for missing
      * backend will be issued in scsi_realize
      */
@@ -2446,7 +2450,7 @@ static void scsi_hd_realize(SCSIDevice *dev, Error **errp)
 
 static void scsi_cd_realize(SCSIDevice *dev, Error **errp)
 {
-    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
+    SCSIDiskState *s = SCSI_DISK_BASE(dev);
     int ret;
 
     if (!dev->conf.blk) {
@@ -2549,7 +2553,7 @@ static const SCSIReqOps *const scsi_disk_reqops_dispatch[256] = {
 static SCSIRequest *scsi_new_request(SCSIDevice *d, uint32_t tag, uint32_t lun,
                                      uint8_t *buf, void *hba_private)
 {
-    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, d);
+    SCSIDiskState *s = SCSI_DISK_BASE(d);
     SCSIRequest *req;
     const SCSIReqOps *ops;
     uint8_t command;
@@ -2601,7 +2605,7 @@ static int get_device_type(SCSIDiskState *s)
 
 static void scsi_block_realize(SCSIDevice *dev, Error **errp)
 {
-    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
+    SCSIDiskState *s = SCSI_DISK_BASE(dev);
     int sg_version;
     int rc;
 
@@ -2879,7 +2883,7 @@ static SCSIRequest *scsi_block_new_request(SCSIDevice *d, uint32_t tag,
                                            uint32_t lun, uint8_t *buf,
                                            void *hba_private)
 {
-    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, d);
+    SCSIDiskState *s = SCSI_DISK_BASE(d);
 
     if (scsi_block_is_passthrough(s, buf)) {
         return scsi_req_alloc(&scsi_generic_req_ops, &s->qdev, tag, lun,
@@ -2893,7 +2897,7 @@ static SCSIRequest *scsi_block_new_request(SCSIDevice *d, uint32_t tag,
 static int scsi_block_parse_cdb(SCSIDevice *d, SCSICommand *cmd,
                                   uint8_t *buf, void *hba_private)
 {
-    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, d);
+    SCSIDiskState *s = SCSI_DISK_BASE(d);
 
     if (scsi_block_is_passthrough(s, buf)) {
         return scsi_bus_parse_cdb(&s->qdev, cmd, buf, hba_private);
@@ -3002,7 +3006,7 @@ static void scsi_hd_class_initfn(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo scsi_hd_info = {
-    .name          = "scsi-hd",
+    .name          = TYPE_SCSI_HD,
     .parent        = TYPE_SCSI_DISK_BASE,
     .class_init    = scsi_hd_class_initfn,
 };
@@ -3033,7 +3037,7 @@ static void scsi_cd_class_initfn(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo scsi_cd_info = {
-    .name          = "scsi-cd",
+    .name          = TYPE_SCSI_CD,
     .parent        = TYPE_SCSI_DISK_BASE,
     .class_init    = scsi_cd_class_initfn,
 };
@@ -3071,7 +3075,7 @@ static void scsi_block_class_initfn(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo scsi_block_info = {
-    .name          = "scsi-block",
+    .name          = TYPE_SCSI_BLOCK,
     .parent        = TYPE_SCSI_DISK_BASE,
     .class_init    = scsi_block_class_initfn,
 };
@@ -3111,7 +3115,7 @@ static void scsi_disk_class_initfn(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo scsi_disk_info = {
-    .name          = "scsi-disk",
+    .name          = TYPE_SCSI_DISK,
     .parent        = TYPE_SCSI_DISK_BASE,
     .class_init    = scsi_disk_class_initfn,
 };
-- 
2.17.1
