Received: from eggs.gnu.org ([2001:4830:134:3::10]:45089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f8mFg-0000jW-Oh
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f8mFe-0003H1-0B
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:31:56 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 18 Apr 2018 14:31:45 +0200
Message-Id: <1524054707-20663-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1524054707-20663-1-git-send-email-thuth@redhat.com>
References: <1524054707-20663-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2.13 2/4] pc-bios/s390-ccw/net: Stop
 virtio-net device before jumping into the OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>

The virtio-net receive buffers are filled asynchronously, so we should
make sure to properly shut down the virtio-net device before we jump into
the loaded kernel. Otherwise an incoming packet could destroy memory of
the OS kernel if it did not re-initialize the virtio-net device fast
enough yet.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/netmain.c    |  1 +
 pc-bios/s390-ccw/virtio-net.c |  8 ++++++++
 pc-bios/s390-ccw/virtio.c     | 19 ++++++++++++++-----
 pc-bios/s390-ccw/virtio.h     |  3 +++
 4 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index ebdc440..e11ed4e 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -273,6 +273,7 @@ static void net_uninit(filename_ip_t *fn_ip)
     if (ip_version == 4) {
         dhcp_send_release(fn_ip->fd);
     }
+    virtio_net_uninit();
 }
 
 void panic(const char *string)
diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
index ff7f4da..339fe53 100644
--- a/pc-bios/s390-ccw/virtio-net.c
+++ b/pc-bios/s390-ccw/virtio-net.c
@@ -67,6 +67,14 @@ int virtio_net_init(void *mac_addr)
     return 0;
 }
 
+void virtio_net_uninit(void)
+{
+    VDev *vdev = virtio_get_device();
+
+    virtio_status_set(vdev, VIRTIO_CONFIG_S_FAILED);
+    virtio_reset_dev(vdev);
+}
+
 int send(int fd, const void *buf, int len, int flags)
 {
     VirtioNetHdr tx_hdr;
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index cdb66f4..1d15b03 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -248,10 +248,21 @@ int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd)
     return 0;
 }
 
+void virtio_status_set(VDev *vdev, uint8_t status)
+{
+    IPL_assert(
+        run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status)) == 0,
+        "Could not write status to host");
+}
+
+void virtio_reset_dev(VDev *vdev)
+{
+    run_ccw(vdev, CCW_CMD_VDEV_RESET, NULL, 0);
+}
+
 void virtio_setup_ccw(VDev *vdev)
 {
     int i, rc, cfg_size = 0;
-    unsigned char status = VIRTIO_CONFIG_S_DRIVER_OK;
     struct VirtioFeatureDesc {
         uint32_t features;
         uint8_t index;
@@ -263,7 +274,7 @@ void virtio_setup_ccw(VDev *vdev)
     vdev->config.blk.blk_size = 0; /* mark "illegal" - setup started... */
     vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
 
-    run_ccw(vdev, CCW_CMD_VDEV_RESET, NULL, 0);
+    virtio_reset_dev(vdev);
 
     switch (vdev->senseid.cu_model) {
     case VIRTIO_ID_NET:
@@ -320,9 +331,7 @@ void virtio_setup_ccw(VDev *vdev)
         IPL_assert(run_ccw(vdev, CCW_CMD_SET_VQ, &info, sizeof(info)) == 0,
                    "Cannot set VQ info");
     }
-    IPL_assert(
-        run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status)) == 0,
-        "Could not write status to host");
+    virtio_status_set(vdev, VIRTIO_CONFIG_S_DRIVER_OK);
 }
 
 bool virtio_is_supported(SubChannelId schid)
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 19fceb6..c2479be 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -277,8 +277,11 @@ void vring_send_buf(VRing *vr, void *p, int len, int flags);
 int vr_poll(VRing *vr);
 int vring_wait_reply(void);
 int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd);
+void virtio_status_set(VDev *vdev, uint8_t status);
+void virtio_reset_dev(VDev *vdev);
 void virtio_setup_ccw(VDev *vdev);
 
 int virtio_net_init(void *mac_addr);
+void virtio_net_uninit(void);
 
 #endif /* VIRTIO_H */
-- 
1.8.3.1
