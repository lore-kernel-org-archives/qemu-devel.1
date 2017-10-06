Received: from eggs.gnu.org ([2001:4830:134:3::10]:58691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PQx-0005qu-Og
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PQr-0007Vb-3a
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e0PQq-0007UP-Pb
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:37 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  6 Oct 2017 11:59:31 +0200
Message-Id: <20171006095956.27534-9-cohuck@redhat.com>
In-Reply-To: <20171006095956.27534-1-cohuck@redhat.com>
References: <20171006095956.27534-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 08/33] virtio-ccw: use ccw data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

Replace direct access which implicitly assumes no IDA
or MIDA with the new ccw data stream interface which should
cope with these transparently in the future.

Note that checking the return code for ccw_dstream_* will be
done in a follow-on patch.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170921180841.24490-4-pasic@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/virtio-ccw.c | 155 +++++++++++++++-----------------------------------
 1 file changed, 46 insertions(+), 109 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 62d69aa30b..085f17f871 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -289,49 +289,19 @@ static int virtio_ccw_handle_set_vq(SubchDev *sch, CCW1 ccw, bool check_len,
         return -EFAULT;
     }
     if (is_legacy) {
-        linfo.queue = address_space_ldq_be(&address_space_memory, ccw.cda,
-                                           MEMTXATTRS_UNSPECIFIED, NULL);
-        linfo.align = address_space_ldl_be(&address_space_memory,
-                                           ccw.cda + sizeof(linfo.queue),
-                                           MEMTXATTRS_UNSPECIFIED,
-                                           NULL);
-        linfo.index = address_space_lduw_be(&address_space_memory,
-                                            ccw.cda + sizeof(linfo.queue)
-                                            + sizeof(linfo.align),
-                                            MEMTXATTRS_UNSPECIFIED,
-                                            NULL);
-        linfo.num = address_space_lduw_be(&address_space_memory,
-                                          ccw.cda + sizeof(linfo.queue)
-                                          + sizeof(linfo.align)
-                                          + sizeof(linfo.index),
-                                          MEMTXATTRS_UNSPECIFIED,
-                                          NULL);
+        ccw_dstream_read(&sch->cds, linfo);
+        be64_to_cpus(&linfo.queue);
+        be32_to_cpus(&linfo.align);
+        be16_to_cpus(&linfo.index);
+        be16_to_cpus(&linfo.num);
         ret = virtio_ccw_set_vqs(sch, NULL, &linfo);
     } else {
-        info.desc = address_space_ldq_be(&address_space_memory, ccw.cda,
-                                           MEMTXATTRS_UNSPECIFIED, NULL);
-        info.index = address_space_lduw_be(&address_space_memory,
-                                           ccw.cda + sizeof(info.desc)
-                                           + sizeof(info.res0),
-                                           MEMTXATTRS_UNSPECIFIED, NULL);
-        info.num = address_space_lduw_be(&address_space_memory,
-                                         ccw.cda + sizeof(info.desc)
-                                         + sizeof(info.res0)
-                                         + sizeof(info.index),
-                                         MEMTXATTRS_UNSPECIFIED, NULL);
-        info.avail = address_space_ldq_be(&address_space_memory,
-                                          ccw.cda + sizeof(info.desc)
-                                          + sizeof(info.res0)
-                                          + sizeof(info.index)
-                                          + sizeof(info.num),
-                                          MEMTXATTRS_UNSPECIFIED, NULL);
-        info.used = address_space_ldq_be(&address_space_memory,
-                                         ccw.cda + sizeof(info.desc)
-                                         + sizeof(info.res0)
-                                         + sizeof(info.index)
-                                         + sizeof(info.num)
-                                         + sizeof(info.avail),
-                                         MEMTXATTRS_UNSPECIFIED, NULL);
+        ccw_dstream_read(&sch->cds, info);
+        be64_to_cpus(&info.desc);
+        be16_to_cpus(&info.index);
+        be16_to_cpus(&info.num);
+        be64_to_cpus(&info.avail);
+        be64_to_cpus(&info.used);
         ret = virtio_ccw_set_vqs(sch, &info, NULL);
     }
     sch->curr_status.scsw.count = 0;
@@ -344,15 +314,13 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
     VirtioRevInfo revinfo;
     uint8_t status;
     VirtioFeatDesc features;
-    void *config;
     hwaddr indicators;
     VqConfigBlock vq_config;
     VirtioCcwDevice *dev = sch->driver_data;
     VirtIODevice *vdev = virtio_ccw_get_vdev(sch);
     bool check_len;
     int len;
-    hwaddr hw_len;
-    VirtioThinintInfo *thinint;
+    VirtioThinintInfo thinint;
 
     if (!dev) {
         return -EINVAL;
@@ -396,11 +364,8 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
         } else {
             VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
 
-            features.index = address_space_ldub(&address_space_memory,
-                                                ccw.cda
-                                                + sizeof(features.features),
-                                                MEMTXATTRS_UNSPECIFIED,
-                                                NULL);
+            ccw_dstream_advance(&sch->cds, sizeof(features.features));
+            ccw_dstream_read(&sch->cds, features.index);
             if (features.index == 0) {
                 if (dev->revision >= 1) {
                     /* Don't offer legacy features for modern devices. */
@@ -419,9 +384,9 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
                 /* Return zeroes if the guest supports more feature bits. */
                 features.features = 0;
             }
-            address_space_stl_le(&address_space_memory, ccw.cda,
-                                 features.features, MEMTXATTRS_UNSPECIFIED,
-                                 NULL);
+            ccw_dstream_rewind(&sch->cds);
+            cpu_to_le32s(&features.features);
+            ccw_dstream_write(&sch->cds, features.features);
             sch->curr_status.scsw.count = ccw.count - sizeof(features);
             ret = 0;
         }
@@ -440,15 +405,8 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
         if (!ccw.cda) {
             ret = -EFAULT;
         } else {
-            features.index = address_space_ldub(&address_space_memory,
-                                                ccw.cda
-                                                + sizeof(features.features),
-                                                MEMTXATTRS_UNSPECIFIED,
-                                                NULL);
-            features.features = address_space_ldl_le(&address_space_memory,
-                                                     ccw.cda,
-                                                     MEMTXATTRS_UNSPECIFIED,
-                                                     NULL);
+            ccw_dstream_read(&sch->cds, features);
+            le32_to_cpus(&features.features);
             if (features.index == 0) {
                 virtio_set_features(vdev,
                                     (vdev->guest_features & 0xffffffff00000000ULL) |
@@ -489,7 +447,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             ret = -EFAULT;
         } else {
             virtio_bus_get_vdev_config(&dev->bus, vdev->config);
-            cpu_physical_memory_write(ccw.cda, vdev->config, len);
+            ccw_dstream_write_buf(&sch->cds, vdev->config, len);
             sch->curr_status.scsw.count = ccw.count - len;
             ret = 0;
         }
@@ -502,20 +460,13 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             }
         }
         len = MIN(ccw.count, vdev->config_len);
-        hw_len = len;
         if (!ccw.cda) {
             ret = -EFAULT;
         } else {
-            config = cpu_physical_memory_map(ccw.cda, &hw_len, 0);
-            if (!config) {
-                ret = -EFAULT;
-            } else {
-                len = hw_len;
-                memcpy(vdev->config, config, len);
-                cpu_physical_memory_unmap(config, hw_len, 0, hw_len);
+            ret = ccw_dstream_read_buf(&sch->cds, vdev->config, len);
+            if (!ret) {
                 virtio_bus_set_vdev_config(&dev->bus, vdev->config);
                 sch->curr_status.scsw.count = ccw.count - len;
-                ret = 0;
             }
         }
         break;
@@ -553,8 +504,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
         if (!ccw.cda) {
             ret = -EFAULT;
         } else {
-            status = address_space_ldub(&address_space_memory, ccw.cda,
-                                        MEMTXATTRS_UNSPECIFIED, NULL);
+            ccw_dstream_read(&sch->cds, status);
             if (!(status & VIRTIO_CONFIG_S_DRIVER_OK)) {
                 virtio_ccw_stop_ioeventfd(dev);
             }
@@ -597,8 +547,8 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
         if (!ccw.cda) {
             ret = -EFAULT;
         } else {
-            indicators = address_space_ldq_be(&address_space_memory, ccw.cda,
-                                              MEMTXATTRS_UNSPECIFIED, NULL);
+            ccw_dstream_read(&sch->cds, indicators);
+            be64_to_cpus(&indicators);
             dev->indicators = get_indicator(indicators, sizeof(uint64_t));
             sch->curr_status.scsw.count = ccw.count - sizeof(indicators);
             ret = 0;
@@ -618,8 +568,8 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
         if (!ccw.cda) {
             ret = -EFAULT;
         } else {
-            indicators = address_space_ldq_be(&address_space_memory, ccw.cda,
-                                              MEMTXATTRS_UNSPECIFIED, NULL);
+            ccw_dstream_read(&sch->cds, indicators);
+            be64_to_cpus(&indicators);
             dev->indicators2 = get_indicator(indicators, sizeof(uint64_t));
             sch->curr_status.scsw.count = ccw.count - sizeof(indicators);
             ret = 0;
@@ -639,67 +589,58 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
         if (!ccw.cda) {
             ret = -EFAULT;
         } else {
-            vq_config.index = address_space_lduw_be(&address_space_memory,
-                                                    ccw.cda,
-                                                    MEMTXATTRS_UNSPECIFIED,
-                                                    NULL);
+            ccw_dstream_read(&sch->cds, vq_config.index);
+            be16_to_cpus(&vq_config.index);
             if (vq_config.index >= VIRTIO_QUEUE_MAX) {
                 ret = -EINVAL;
                 break;
             }
             vq_config.num_max = virtio_queue_get_num(vdev,
                                                      vq_config.index);
-            address_space_stw_be(&address_space_memory,
-                                 ccw.cda + sizeof(vq_config.index),
-                                 vq_config.num_max,
-                                 MEMTXATTRS_UNSPECIFIED,
-                                 NULL);
+            cpu_to_be16s(&vq_config.num_max);
+            ccw_dstream_write(&sch->cds, vq_config.num_max);
             sch->curr_status.scsw.count = ccw.count - sizeof(vq_config);
             ret = 0;
         }
         break;
     case CCW_CMD_SET_IND_ADAPTER:
         if (check_len) {
-            if (ccw.count != sizeof(*thinint)) {
+            if (ccw.count != sizeof(thinint)) {
                 ret = -EINVAL;
                 break;
             }
-        } else if (ccw.count < sizeof(*thinint)) {
+        } else if (ccw.count < sizeof(thinint)) {
             /* Can't execute command. */
             ret = -EINVAL;
             break;
         }
-        len = sizeof(*thinint);
-        hw_len = len;
         if (!ccw.cda) {
             ret = -EFAULT;
         } else if (dev->indicators && !sch->thinint_active) {
             /* Trigger a command reject. */
             ret = -ENOSYS;
         } else {
-            thinint = cpu_physical_memory_map(ccw.cda, &hw_len, 0);
-            if (!thinint) {
+            if (ccw_dstream_read(&sch->cds, thinint)) {
                 ret = -EFAULT;
             } else {
-                uint64_t ind_bit = ldq_be_p(&thinint->ind_bit);
+                be64_to_cpus(&thinint.ind_bit);
+                be64_to_cpus(&thinint.summary_indicator);
+                be64_to_cpus(&thinint.device_indicator);
 
-                len = hw_len;
                 dev->summary_indicator =
-                    get_indicator(ldq_be_p(&thinint->summary_indicator),
-                                  sizeof(uint8_t));
+                    get_indicator(thinint.summary_indicator, sizeof(uint8_t));
                 dev->indicators =
-                    get_indicator(ldq_be_p(&thinint->device_indicator),
-                                  ind_bit / 8 + 1);
-                dev->thinint_isc = thinint->isc;
-                dev->routes.adapter.ind_offset = ind_bit;
+                    get_indicator(thinint.device_indicator,
+                                  thinint.ind_bit / 8 + 1);
+                dev->thinint_isc = thinint.isc;
+                dev->routes.adapter.ind_offset = thinint.ind_bit;
                 dev->routes.adapter.summary_offset = 7;
-                cpu_physical_memory_unmap(thinint, hw_len, 0, hw_len);
                 dev->routes.adapter.adapter_id = css_get_adapter_id(
                                                  CSS_IO_ADAPTER_VIRTIO,
                                                  dev->thinint_isc);
                 sch->thinint_active = ((dev->indicators != NULL) &&
                                        (dev->summary_indicator != NULL));
-                sch->curr_status.scsw.count = ccw.count - len;
+                sch->curr_status.scsw.count = ccw.count - sizeof(thinint);
                 ret = 0;
             }
         }
@@ -714,13 +655,9 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             ret = -EFAULT;
             break;
         }
-        revinfo.revision =
-            address_space_lduw_be(&address_space_memory, ccw.cda,
-                                  MEMTXATTRS_UNSPECIFIED, NULL);
-        revinfo.length =
-            address_space_lduw_be(&address_space_memory,
-                                  ccw.cda + sizeof(revinfo.revision),
-                                  MEMTXATTRS_UNSPECIFIED, NULL);
+        ccw_dstream_read_buf(&sch->cds, &revinfo, 4);
+        be16_to_cpus(&revinfo.revision);
+        be16_to_cpus(&revinfo.length);
         if (ccw.count < len + revinfo.length ||
             (check_len && ccw.count > len + revinfo.length)) {
             ret = -EINVAL;
-- 
2.13.6
