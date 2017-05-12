Received: from eggs.gnu.org ([2001:4830:134:3::10]:45094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d9697-0005xh-Aw
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d9693-0002BZ-UX
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:62480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d9693-0001je-KI
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:53 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 12 May 2017 16:35:48 +0800
Message-Id: <1494578148-102868-17-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v2 16/16] vl: enable vhost-pci-slave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com, marcandre.lureau@gmail.com, mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>

Enable the use of vhost-pci. The init and cleanup stub functions are
added for the platforms that do not support the use of virtio.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/virtio/vhost-stub.c | 11 +++++++++++
 vl.c                   | 24 ++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/hw/virtio/vhost-stub.c b/hw/virtio/vhost-stub.c
index e130791..bfb73df 100644
--- a/hw/virtio/vhost-stub.c
+++ b/hw/virtio/vhost-stub.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-user.h"
+#include "hw/virtio/vhost-pci-slave.h"
 
 bool vhost_has_free_slot(void)
 {
@@ -16,3 +17,13 @@ int vhost_user_can_read(void *opaque)
 {
     return 0;
 }
+
+int vhost_pci_slave_init(QemuOpts *opt)
+{
+    return -1;
+}
+
+int vhost_pci_slave_cleanup(void)
+{
+    return -1;
+}
diff --git a/vl.c b/vl.c
index 2ee4713..18102d7 100644
--- a/vl.c
+++ b/vl.c
@@ -129,6 +129,7 @@ int main(int argc, char **argv)
 #include "sysemu/replay.h"
 #include "qapi/qmp/qerror.h"
 #include "sysemu/iothread.h"
+#include "hw/virtio/vhost-pci-slave.h"
 
 #define MAX_VIRTIO_CONSOLES 1
 #define MAX_SCLP_CONSOLES 1
@@ -187,6 +188,7 @@ uint8_t *boot_splash_filedata;
 size_t boot_splash_filedata_size;
 uint8_t qemu_extra_params_fw[2];
 int only_migratable; /* turn it off unless user states otherwise */
+bool vhost_pci_slave_enabled;
 
 int icount_align_option;
 
@@ -4060,6 +4062,7 @@ int main(int argc, char **argv, char **envp)
                 if (!opts) {
                     exit(1);
                 }
+                vhost_pci_slave_enabled = true;
                 break;
             default:
                 os_parse_cmd_args(popt->index, optarg);
@@ -4591,6 +4594,18 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     }
 
+    /* check if the vhost-pci-server is enabled */
+    if (vhost_pci_slave_enabled) {
+        int ret;
+        ret = vhost_pci_slave_init(qemu_opts_find(
+                                    qemu_find_opts("vhost-pci-slave"),
+                                    NULL));
+        if (ret < 0) {
+            error_report("vhost-pci-slave init failed");
+            exit(1);
+        }
+    }
+
     /* init USB devices */
     if (machine_usb(current_machine)) {
         if (foreach_device_config(DEV_USB, usb_parse) < 0)
@@ -4736,6 +4751,15 @@ int main(int argc, char **argv, char **envp)
     pause_all_vcpus();
     res_free();
 
+    if (vhost_pci_slave_enabled) {
+        int ret;
+        ret = vhost_pci_slave_cleanup();
+        if (ret < 0) {
+            error_report("vhost-pci-slave init failed");
+            exit(1);
+        }
+    }
+
     /* vhost-user must be cleaned up before chardevs.  */
     net_cleanup();
     audio_cleanup();
-- 
2.7.4
