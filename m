Received: from eggs.gnu.org ([2001:4830:134:3::10]:44083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dqL9W-0000bx-Uc
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:25:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dqL9P-0004pQ-QQ
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:25:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41020
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dqL9P-0004pA-IG
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:24:59 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v88FOYHt022546
	for <qemu-devel@nongnu.org>; Fri, 8 Sep 2017 11:24:59 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2curs77yvm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 11:24:58 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 8 Sep 2017 16:24:56 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri,  8 Sep 2017 17:24:46 +0200
In-Reply-To: <20170908152446.14606-1-pasic@linux.vnet.ibm.com>
References: <20170908152446.14606-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170908152446.14606-5-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 4/4] s390x/css: fix incorrect length indication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

We report incorrect length via SCSW program check instead of incorrect
length check (SCWS word 2 bit 10 instead of bit 9). Since we have there
is no fitting errno for incorrect length, and since I don't like what we
do with the errno's, as part of the fix, errnos used for control flow in
ccw interpretation are replaced with an enum using more speaking names.

For virtio, if incorrect length checking is suppressed we keep the
current behavior (channel-program check).

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 hw/s390x/3270-ccw.c    |  24 +++++-----
 hw/s390x/css.c         |  67 +++++++++++++++-----------
 hw/s390x/virtio-ccw.c  | 128 ++++++++++++++++++++++++-------------------------
 include/hw/s390x/css.h |  13 ++++-
 4 files changed, 127 insertions(+), 105 deletions(-)

diff --git a/hw/s390x/3270-ccw.c b/hw/s390x/3270-ccw.c
index 1554aa2484..5f9efe7ac6 100644
--- a/hw/s390x/3270-ccw.c
+++ b/hw/s390x/3270-ccw.c
@@ -18,46 +18,48 @@
 #include "hw/s390x/3270-ccw.h"
 
 /* Handle READ ccw commands from guest */
-static int handle_payload_3270_read(EmulatedCcw3270Device *dev, CCW1 *ccw)
+static CcwProcStatus handle_payload_3270_read(EmulatedCcw3270Device *dev,
+                                              CCW1 *ccw)
 {
     EmulatedCcw3270Class *ck = EMULATED_CCW_3270_GET_CLASS(dev);
     CcwDevice *ccw_dev = CCW_DEVICE(dev);
     int len;
 
     if (!ccw->cda) {
-        return -EFAULT;
+        return CSS_DO_PGM_CHK;
     }
 
     len = ck->read_payload_3270(dev, ccw->cda, ccw->count);
     ccw_dev->sch->curr_status.scsw.count = ccw->count - len;
 
-    return 0;
+    return CSS_DO_SUCCESS;
 }
 
 /* Handle WRITE ccw commands to write data to client */
-static int handle_payload_3270_write(EmulatedCcw3270Device *dev, CCW1 *ccw)
+static CcwProcStatus handle_payload_3270_write(EmulatedCcw3270Device *dev,
+                                               CCW1 *ccw)
 {
     EmulatedCcw3270Class *ck = EMULATED_CCW_3270_GET_CLASS(dev);
     CcwDevice *ccw_dev = CCW_DEVICE(dev);
     int len;
 
     if (!ccw->cda) {
-        return -EFAULT;
+        return CSS_DO_PGM_CHK;
     }
 
     len = ck->write_payload_3270(dev, ccw->cmd_code, ccw->cda, ccw->count);
 
     if (len <= 0) {
-        return -EIO;
+        return CSS_E_CUSTOM;
     }
 
     ccw_dev->sch->curr_status.scsw.count = ccw->count - len;
-    return 0;
+    return CSS_DO_SUCCESS;
 }
 
-static int emulated_ccw_3270_cb(SubchDev *sch, CCW1 ccw)
+static CcwProcStatus emulated_ccw_3270_cb(SubchDev *sch, CCW1 ccw)
 {
-    int rc = 0;
+    CcwProcStatus rc = CSS_DO_SUCCESS;
     EmulatedCcw3270Device *dev = sch->driver_data;
 
     switch (ccw.cmd_code) {
@@ -72,11 +74,11 @@ static int emulated_ccw_3270_cb(SubchDev *sch, CCW1 ccw)
         rc = handle_payload_3270_read(dev, &ccw);
         break;
     default:
-        rc = -ENOSYS;
+        rc = CSS_DO_UNIT_CHK_REJ;
         break;
     }
 
-    if (rc == -EIO) {
+    if (rc == CSS_E_CUSTOM) {
         /* I/O error, specific devices generate specific conditions */
         SCSW *s = &sch->curr_status.scsw;
 
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index a9cdd54efc..875e9b00b8 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -784,20 +784,20 @@ static CCW1 copy_ccw_from_guest(hwaddr addr, bool fmt1)
     return ret;
 }
 
-static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
+static CcwProcStatus css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
                              bool suspend_allowed)
 {
-    int ret;
+    CcwProcStatus ret;
     bool check_len;
     int len;
     CCW1 ccw;
 
     if (!ccw_addr) {
-        return -EINVAL; /* channel-program check */
+        return CSS_DO_PGM_CHK;
     }
     /* Check doubleword aligned and 31 or 24 (fmt 0) bit addressable. */
     if (ccw_addr & (sch->ccw_fmt_1 ? 0x80000007 : 0xff000007)) {
-        return -EINVAL;
+        return CSS_DO_PGM_CHK;
     }
 
     /* Translate everything to format-1 ccws - the information is the same. */
@@ -805,31 +805,31 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
 
     /* Check for invalid command codes. */
     if ((ccw.cmd_code & 0x0f) == 0) {
-        return -EINVAL;
+        return CSS_DO_PGM_CHK;
     }
     if (((ccw.cmd_code & 0x0f) == CCW_CMD_TIC) &&
         ((ccw.cmd_code & 0xf0) != 0)) {
-        return -EINVAL;
+        return CSS_DO_PGM_CHK;
     }
     if (!sch->ccw_fmt_1 && (ccw.count == 0) &&
         (ccw.cmd_code != CCW_CMD_TIC)) {
-        return -EINVAL;
+        return CSS_DO_PGM_CHK;
     }
 
     /* We don't support MIDA. */
     if (ccw.flags & CCW_FLAG_MIDA) {
-        return -EINVAL;
+        return CSS_DO_PGM_CHK;
     }
 
     if (ccw.flags & CCW_FLAG_SUSPEND) {
-        return suspend_allowed ? -EINPROGRESS : -EINVAL;
+        return suspend_allowed ? CSS_DO_SUSPEND : CSS_DO_PGM_CHK;
     }
 
     check_len = !((ccw.flags & CCW_FLAG_SLI) && !(ccw.flags & CCW_FLAG_DC));
 
     if (!ccw.cda) {
         if (sch->ccw_no_data_cnt == 255) {
-            return -EINVAL;
+            return CSS_DO_PGM_CHK;
         }
         sch->ccw_no_data_cnt++;
     }
@@ -838,12 +838,12 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
     switch (ccw.cmd_code) {
     case CCW_CMD_NOOP:
         /* Nothing to do. */
-        ret = 0;
+        ret = CSS_DO_SUCCESS;
         break;
     case CCW_CMD_BASIC_SENSE:
         if (check_len) {
             if (ccw.count != sizeof(sch->sense_data)) {
-                ret = -EINVAL;
+                ret = CSS_DO_INCORR_LEN;
                 break;
             }
         }
@@ -851,7 +851,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
         cpu_physical_memory_write(ccw.cda, sch->sense_data, len);
         sch->curr_status.scsw.count = ccw.count - len;
         memset(sch->sense_data, 0, sizeof(sch->sense_data));
-        ret = 0;
+        ret = CSS_DO_SUCCESS;
         break;
     case CCW_CMD_SENSE_ID:
     {
@@ -861,7 +861,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
         /* Sense ID information is device specific. */
         if (check_len) {
             if (ccw.count != sizeof(sense_id)) {
-                ret = -EINVAL;
+                ret = CSS_DO_PGM_CHK;
                 break;
             }
         }
@@ -877,37 +877,37 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
         }
         cpu_physical_memory_write(ccw.cda, &sense_id, len);
         sch->curr_status.scsw.count = ccw.count - len;
-        ret = 0;
+        ret = CSS_DO_SUCCESS;
         break;
     }
     case CCW_CMD_TIC:
         if (sch->last_cmd_valid && (sch->last_cmd.cmd_code == CCW_CMD_TIC)) {
-            ret = -EINVAL;
+            ret = CSS_DO_PGM_CHK;
             break;
         }
         if (ccw.flags || ccw.count) {
             /* We have already sanitized these if converted from fmt 0. */
-            ret = -EINVAL;
+            ret = CSS_DO_PGM_CHK;
             break;
         }
         sch->channel_prog = ccw.cda;
-        ret = -EAGAIN;
+        ret = CSS_DO_CONT_CHAIN;
         break;
     default:
         if (sch->ccw_cb) {
             /* Handle device specific commands. */
             ret = sch->ccw_cb(sch, ccw);
         } else {
-            ret = -ENOSYS;
+            ret = CSS_DO_UNIT_CHK_REJ;
         }
         break;
     }
     sch->last_cmd = ccw;
     sch->last_cmd_valid = true;
-    if (ret == 0) {
+    if (ret == CSS_DO_SUCCESS) {
         if (ccw.flags & CCW_FLAG_CC) {
             sch->channel_prog += 8;
-            ret = -EAGAIN;
+            ret = CSS_DO_CONT_CHAIN;
         }
     }
 
@@ -920,7 +920,7 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
     PMCW *p = &sch->curr_status.pmcw;
     SCSW *s = &sch->curr_status.scsw;
     int path;
-    int ret;
+    CcwProcStatus ret;
     bool suspend_allowed;
 
     /* Path management: In our simple css, we always choose the only path. */
@@ -954,10 +954,10 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
     do {
         ret = css_interpret_ccw(sch, sch->channel_prog, suspend_allowed);
         switch (ret) {
-        case -EAGAIN:
+        case CSS_DO_CONT_CHAIN:
             /* ccw chain, continue processing */
             break;
-        case 0:
+        case CSS_DO_SUCCESS:
             /* success */
             s->ctrl &= ~SCSW_ACTL_START_PEND;
             s->ctrl &= ~SCSW_CTRL_MASK_STCTL;
@@ -966,10 +966,10 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
             s->dstat = SCSW_DSTAT_CHANNEL_END | SCSW_DSTAT_DEVICE_END;
             s->cpa = sch->channel_prog + 8;
             break;
-        case -EIO:
+        case CSS_E_CUSTOM:
             /* I/O errors, status depends on specific devices */
             break;
-        case -ENOSYS:
+        case CSS_DO_UNIT_CHK_REJ:
             /* unsupported command, generate unit check (command reject) */
             s->ctrl &= ~SCSW_ACTL_START_PEND;
             s->dstat = SCSW_DSTAT_UNIT_CHECK;
@@ -980,12 +980,21 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
                     SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
             s->cpa = sch->channel_prog + 8;
             break;
-        case -EINPROGRESS:
+        case CSS_DO_SUSPEND:
             /* channel program has been suspended */
             s->ctrl &= ~SCSW_ACTL_START_PEND;
             s->ctrl |= SCSW_ACTL_SUSP;
             break;
-        default:
+        case CSS_DO_INCORR_LEN:
+            s->ctrl &= ~SCSW_ACTL_START_PEND;
+            s->cstat = SCSW_CSTAT_INCORR_LEN;
+            s->ctrl &= ~SCSW_CTRL_MASK_STCTL;
+            s->ctrl |= SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
+                    SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
+            s->cpa = sch->channel_prog + 8;
+            break;
+
+        case CSS_DO_PGM_CHK:
             /* error, generate channel program check */
             s->ctrl &= ~SCSW_ACTL_START_PEND;
             s->cstat = SCSW_CSTAT_PROG_CHECK;
@@ -995,7 +1004,7 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
             s->cpa = sch->channel_prog + 8;
             break;
         }
-    } while (ret == -EAGAIN);
+    } while (ret == CSS_DO_CONT_CHAIN);
 
 }
 
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index b1976fdd19..3d288b5343 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -207,16 +207,16 @@ static int virtio_ccw_set_vqs(SubchDev *sch, VqInfoBlock *info,
     uint64_t desc = info ? info->desc : linfo->queue;
 
     if (index >= VIRTIO_QUEUE_MAX) {
-        return -EINVAL;
+        return CSS_DO_PGM_CHK;
     }
 
     /* Current code in virtio.c relies on 4K alignment. */
     if (linfo && desc && (linfo->align != 4096)) {
-        return -EINVAL;
+        return CSS_DO_PGM_CHK;
     }
 
     if (!vdev) {
-        return -EINVAL;
+        return CSS_DO_PGM_CHK;
     }
 
     if (info) {
@@ -231,19 +231,19 @@ static int virtio_ccw_set_vqs(SubchDev *sch, VqInfoBlock *info,
             /* virtio-1 allows changing the ring size. */
             if (virtio_queue_get_max_num(vdev, index) < num) {
                 /* Fail if we exceed the maximum number. */
-                return -EINVAL;
+                return CSS_DO_PGM_CHK;
             }
             virtio_queue_set_num(vdev, index, num);
         } else if (virtio_queue_get_num(vdev, index) > num) {
             /* Fail if we don't have a big enough queue. */
-            return -EINVAL;
+            return CSS_DO_PGM_CHK;
         }
         /* We ignore possible increased num for legacy for compatibility. */
         virtio_queue_set_vector(vdev, index, index);
     }
     /* tell notify handler in case of config change */
     vdev->config_vector = VIRTIO_QUEUE_MAX;
-    return 0;
+    return CSS_DO_SUCCESS;
 }
 
 static void virtio_ccw_reset_virtio(VirtioCcwDevice *dev, VirtIODevice *vdev)
@@ -277,14 +277,14 @@ static int virtio_ccw_handle_set_vq(SubchDev *sch, CCW1 ccw, bool check_len,
 
     if (check_len) {
         if (ccw.count != info_len) {
-            return -EINVAL;
+            return CSS_DO_INCORR_LEN;
         }
     } else if (ccw.count < info_len) {
         /* Can't execute command. */
-        return -EINVAL;
+        return CSS_DO_PGM_CHK;
     }
     if (!ccw.cda) {
-        return -EFAULT;
+        return CSS_DO_PGM_CHK;
     }
     if (is_legacy) {
         linfo.queue = address_space_ldq_be(&address_space_memory, ccw.cda,
@@ -336,7 +336,7 @@ static int virtio_ccw_handle_set_vq(SubchDev *sch, CCW1 ccw, bool check_len,
     return ret;
 }
 
-static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
+static CcwProcStatus virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
 {
     int ret;
     VirtioRevInfo revinfo;
@@ -353,7 +353,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
     VirtioThinintInfo *thinint;
 
     if (!dev) {
-        return -EINVAL;
+        return CSS_DO_PGM_CHK;
     }
 
     trace_virtio_ccw_interpret_ccw(sch->cssid, sch->ssid, sch->schid,
@@ -366,7 +366,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
          * virtio-1 drivers must start with negotiating to a revision >= 1,
          * so post a command reject for all other commands
          */
-        return -ENOSYS;
+        return CSS_DO_UNIT_CHK_REJ;
     }
 
     /* Look at the command. */
@@ -376,21 +376,21 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
         break;
     case CCW_CMD_VDEV_RESET:
         virtio_ccw_reset_virtio(dev, vdev);
-        ret = 0;
+        ret = CSS_DO_SUCCESS;
         break;
     case CCW_CMD_READ_FEAT:
         if (check_len) {
             if (ccw.count != sizeof(features)) {
-                ret = -EINVAL;
+                ret = CSS_DO_INCORR_LEN;
                 break;
             }
         } else if (ccw.count < sizeof(features)) {
             /* Can't execute command. */
-            ret = -EINVAL;
+            ret = CSS_DO_PGM_CHK;
             break;
         }
         if (!ccw.cda) {
-            ret = -EFAULT;
+            ret = CSS_DO_PGM_CHK;
         } else {
             VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
 
@@ -421,22 +421,22 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
                                  features.features, MEMTXATTRS_UNSPECIFIED,
                                  NULL);
             sch->curr_status.scsw.count = ccw.count - sizeof(features);
-            ret = 0;
+            ret = CSS_DO_SUCCESS;
         }
         break;
     case CCW_CMD_WRITE_FEAT:
         if (check_len) {
             if (ccw.count != sizeof(features)) {
-                ret = -EINVAL;
+                ret = CSS_DO_INCORR_LEN;
                 break;
             }
         } else if (ccw.count < sizeof(features)) {
             /* Can't execute command. */
-            ret = -EINVAL;
+            ret = CSS_DO_PGM_CHK;
             break;
         }
         if (!ccw.cda) {
-            ret = -EFAULT;
+            ret = CSS_DO_PGM_CHK;
         } else {
             features.index = address_space_ldub(&address_space_memory,
                                                 ccw.cda
@@ -472,42 +472,42 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
                 }
             }
             sch->curr_status.scsw.count = ccw.count - sizeof(features);
-            ret = 0;
+            ret = CSS_DO_SUCCESS;
         }
         break;
     case CCW_CMD_READ_CONF:
         if (check_len) {
             if (ccw.count > vdev->config_len) {
-                ret = -EINVAL;
+                ret = CSS_DO_INCORR_LEN;
                 break;
             }
         }
         len = MIN(ccw.count, vdev->config_len);
         if (!ccw.cda) {
-            ret = -EFAULT;
+            ret = CSS_DO_PGM_CHK;
         } else {
             virtio_bus_get_vdev_config(&dev->bus, vdev->config);
             /* XXX config space endianness */
             cpu_physical_memory_write(ccw.cda, vdev->config, len);
             sch->curr_status.scsw.count = ccw.count - len;
-            ret = 0;
+            ret = CSS_DO_SUCCESS;
         }
         break;
     case CCW_CMD_WRITE_CONF:
         if (check_len) {
             if (ccw.count > vdev->config_len) {
-                ret = -EINVAL;
+                ret = CSS_DO_INCORR_LEN;
                 break;
             }
         }
         len = MIN(ccw.count, vdev->config_len);
         hw_len = len;
         if (!ccw.cda) {
-            ret = -EFAULT;
+            ret = CSS_DO_PGM_CHK;
         } else {
             config = cpu_physical_memory_map(ccw.cda, &hw_len, 0);
             if (!config) {
-                ret = -EFAULT;
+                ret = CSS_DO_PGM_CHK;
             } else {
                 len = hw_len;
                 /* XXX config space endianness */
@@ -515,43 +515,43 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
                 cpu_physical_memory_unmap(config, hw_len, 0, hw_len);
                 virtio_bus_set_vdev_config(&dev->bus, vdev->config);
                 sch->curr_status.scsw.count = ccw.count - len;
-                ret = 0;
+                ret = CSS_DO_SUCCESS;
             }
         }
         break;
     case CCW_CMD_READ_STATUS:
         if (check_len) {
             if (ccw.count != sizeof(status)) {
-                ret = -EINVAL;
+                ret = CSS_DO_INCORR_LEN;
                 break;
             }
         } else if (ccw.count < sizeof(status)) {
             /* Can't execute command. */
-            ret = -EINVAL;
+            ret = CSS_DO_PGM_CHK;
             break;
         }
         if (!ccw.cda) {
-            ret = -EFAULT;
+            ret = CSS_DO_PGM_CHK;
         } else {
             address_space_stb(&address_space_memory, ccw.cda, vdev->status,
                                         MEMTXATTRS_UNSPECIFIED, NULL);
             sch->curr_status.scsw.count = ccw.count - sizeof(vdev->status);;
-            ret = 0;
+            ret = CSS_DO_SUCCESS;
         }
         break;
     case CCW_CMD_WRITE_STATUS:
         if (check_len) {
             if (ccw.count != sizeof(status)) {
-                ret = -EINVAL;
+                ret = CSS_DO_INCORR_LEN;
                 break;
             }
         } else if (ccw.count < sizeof(status)) {
             /* Can't execute command. */
-            ret = -EINVAL;
+            ret = CSS_DO_PGM_CHK;
             break;
         }
         if (!ccw.cda) {
-            ret = -EFAULT;
+            ret = CSS_DO_PGM_CHK;
         } else {
             status = address_space_ldub(&address_space_memory, ccw.cda,
                                         MEMTXATTRS_UNSPECIFIED, NULL);
@@ -566,85 +566,85 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
                     virtio_ccw_start_ioeventfd(dev);
                 }
                 sch->curr_status.scsw.count = ccw.count - sizeof(status);
-                ret = 0;
+                ret = CSS_DO_SUCCESS;
             } else {
                 /* Trigger a command reject. */
-                ret = -ENOSYS;
+                ret = CSS_DO_UNIT_CHK_REJ;
             }
         }
         break;
     case CCW_CMD_SET_IND:
         if (check_len) {
             if (ccw.count != sizeof(indicators)) {
-                ret = -EINVAL;
+                ret = CSS_DO_INCORR_LEN;
                 break;
             }
         } else if (ccw.count < sizeof(indicators)) {
             /* Can't execute command. */
-            ret = -EINVAL;
+            ret = CSS_DO_PGM_CHK;
             break;
         }
         if (sch->thinint_active) {
             /* Trigger a command reject. */
-            ret = -ENOSYS;
+            ret = CSS_DO_UNIT_CHK_REJ;
             break;
         }
         if (virtio_get_num_queues(vdev) > NR_CLASSIC_INDICATOR_BITS) {
             /* More queues than indicator bits --> trigger a reject */
-            ret = -ENOSYS;
+            ret = CSS_DO_UNIT_CHK_REJ;
             break;
         }
         if (!ccw.cda) {
-            ret = -EFAULT;
+            ret = CSS_DO_PGM_CHK;
         } else {
             indicators = address_space_ldq_be(&address_space_memory, ccw.cda,
                                               MEMTXATTRS_UNSPECIFIED, NULL);
             dev->indicators = get_indicator(indicators, sizeof(uint64_t));
             sch->curr_status.scsw.count = ccw.count - sizeof(indicators);
-            ret = 0;
+            ret = CSS_DO_SUCCESS;
         }
         break;
     case CCW_CMD_SET_CONF_IND:
         if (check_len) {
             if (ccw.count != sizeof(indicators)) {
-                ret = -EINVAL;
+                ret = CSS_DO_INCORR_LEN;
                 break;
             }
         } else if (ccw.count < sizeof(indicators)) {
             /* Can't execute command. */
-            ret = -EINVAL;
+            ret = CSS_DO_PGM_CHK;
             break;
         }
         if (!ccw.cda) {
-            ret = -EFAULT;
+            ret = CSS_DO_PGM_CHK;
         } else {
             indicators = address_space_ldq_be(&address_space_memory, ccw.cda,
                                               MEMTXATTRS_UNSPECIFIED, NULL);
             dev->indicators2 = get_indicator(indicators, sizeof(uint64_t));
             sch->curr_status.scsw.count = ccw.count - sizeof(indicators);
-            ret = 0;
+            ret = CSS_DO_SUCCESS;
         }
         break;
     case CCW_CMD_READ_VQ_CONF:
         if (check_len) {
             if (ccw.count != sizeof(vq_config)) {
-                ret = -EINVAL;
+                ret = CSS_DO_INCORR_LEN;
                 break;
             }
         } else if (ccw.count < sizeof(vq_config)) {
             /* Can't execute command. */
-            ret = -EINVAL;
+            ret = CSS_DO_PGM_CHK;
             break;
         }
         if (!ccw.cda) {
-            ret = -EFAULT;
+            ret = CSS_DO_PGM_CHK;
         } else {
             vq_config.index = address_space_lduw_be(&address_space_memory,
                                                     ccw.cda,
                                                     MEMTXATTRS_UNSPECIFIED,
                                                     NULL);
             if (vq_config.index >= VIRTIO_QUEUE_MAX) {
-                ret = -EINVAL;
+                ret = CSS_DO_PGM_CHK;
                 break;
             }
             vq_config.num_max = virtio_queue_get_num(vdev,
@@ -655,31 +655,31 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
                                  MEMTXATTRS_UNSPECIFIED,
                                  NULL);
             sch->curr_status.scsw.count = ccw.count - sizeof(vq_config);
-            ret = 0;
+            ret = CSS_DO_SUCCESS;
         }
         break;
     case CCW_CMD_SET_IND_ADAPTER:
         if (check_len) {
             if (ccw.count != sizeof(*thinint)) {
-                ret = -EINVAL;
+                ret = CSS_DO_INCORR_LEN;
                 break;
             }
         } else if (ccw.count < sizeof(*thinint)) {
             /* Can't execute command. */
-            ret = -EINVAL;
+            ret = CSS_DO_PGM_CHK;
             break;
         }
         len = sizeof(*thinint);
         hw_len = len;
         if (!ccw.cda) {
-            ret = -EFAULT;
+            ret = CSS_DO_PGM_CHK;
         } else if (dev->indicators && !sch->thinint_active) {
             /* Trigger a command reject. */
-            ret = -ENOSYS;
+            ret = CSS_DO_UNIT_CHK_REJ;
         } else {
             thinint = cpu_physical_memory_map(ccw.cda, &hw_len, 0);
             if (!thinint) {
-                ret = -EFAULT;
+                ret = CSS_DO_PGM_CHK;
             } else {
                 uint64_t ind_bit = ldq_be_p(&thinint->ind_bit);
 
@@ -700,18 +700,18 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
                 sch->thinint_active = ((dev->indicators != NULL) &&
                                        (dev->summary_indicator != NULL));
                 sch->curr_status.scsw.count = ccw.count - len;
-                ret = 0;
+                ret = CSS_DO_SUCCESS;
             }
         }
         break;
     case CCW_CMD_SET_VIRTIO_REV:
         len = sizeof(revinfo);
         if (ccw.count < len) {
-            ret = -EINVAL;
+            ret = CSS_DO_PGM_CHK;
             break;
         }
         if (!ccw.cda) {
-            ret = -EFAULT;
+            ret = CSS_DO_PGM_CHK;
             break;
         }
         revinfo.revision =
@@ -723,7 +723,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
                                   MEMTXATTRS_UNSPECIFIED, NULL);
         if (ccw.count < len + revinfo.length ||
             (check_len && ccw.count > len + revinfo.length)) {
-            ret = -EINVAL;
+            ret = CSS_DO_PGM_CHK;
             break;
         }
         /*
@@ -733,14 +733,14 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
         if (dev->revision >= 0 ||
             revinfo.revision > virtio_ccw_rev_max(dev) ||
             (dev->force_revision_1 && !revinfo.revision)) {
-            ret = -ENOSYS;
+            ret = CSS_DO_UNIT_CHK_REJ;
             break;
         }
-        ret = 0;
+        ret = CSS_DO_SUCCESS;
         dev->revision = revinfo.revision;
         break;
     default:
-        ret = -ENOSYS;
+        ret = CSS_DO_UNIT_CHK_REJ;
         break;
     }
     return ret;
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 0653d3c9be..da518580be 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -75,6 +75,17 @@ typedef struct CMBE {
     uint32_t reserved[7];
 } QEMU_PACKED CMBE;
 
+
+typedef enum CcwProcStatus {
+        CSS_DO_SUCCESS = 0, /* requet successful completin */
+        CSS_DO_CONT_CHAIN,  /* request continue ccw-chaning */
+        CSS_DO_SUSPEND,     /* request subchannel suspended */
+        CSS_DO_PGM_CHK,     /* request channel-program check */
+        CSS_DO_UNIT_CHK_REJ,/* request unit check cmd reject */
+        CSS_DO_INCORR_LEN,  /* request incorrect length */
+        CSS_E_CUSTOM        /* SCSW updated by device */
+} CcwProcStatus;
+
 typedef struct SubchDev SubchDev;
 struct SubchDev {
     /* channel-subsystem related things: */
@@ -93,7 +104,7 @@ struct SubchDev {
     uint16_t migrated_schid; /* used for missmatch detection */
     ORB orb;
     /* transport-provided data: */
-    int (*ccw_cb) (SubchDev *, CCW1);
+    CcwProcStatus (*ccw_cb) (SubchDev *, CCW1);
     void (*disable_cb)(SubchDev *);
     int (*do_subchannel_work) (SubchDev *);
     SenseId id;
-- 
2.13.5
