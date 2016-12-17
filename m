Received: from eggs.gnu.org ([2001:4830:134:3::10]:53632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICVA-0000OD-Pk
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:46:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICVA-00006V-0E
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:46:04 -0500
Received: from mga05.intel.com ([192.55.52.43]:21540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cICV9-0007ss-Nz
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:46:03 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Sat, 17 Dec 2016 18:43:47 +0800
Message-Id: <1481971427-11094-38-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
References: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v1 37/37] vl: enable vhost-pci-slave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@gmail.com, mst@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: Wei Wang <wei.w.wang@intel.com>

Enable vhost-pci-slave in vl.c

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 vl.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/vl.c b/vl.c
index 10d7f89..6959dba 100644
--- a/vl.c
+++ b/vl.c
@@ -123,6 +123,7 @@ int main(int argc, char **argv)
 #include "sysemu/replay.h"
 #include "qapi/qmp/qerror.h"
 #include "sysemu/iothread.h"
+#include "hw/virtio/vhost-pci-slave.h"
 
 #define MAX_VIRTIO_CONSOLES 1
 #define MAX_SCLP_CONSOLES 1
@@ -180,6 +181,7 @@ bool boot_strict;
 uint8_t *boot_splash_filedata;
 size_t boot_splash_filedata_size;
 uint8_t qemu_extra_params_fw[2];
+bool vhost_pci_slave_enabled;
 
 int icount_align_option;
 
@@ -4064,6 +4066,7 @@ int main(int argc, char **argv, char **envp)
                 if (!opts) {
                     exit(1);
                 }
+                vhost_pci_slave_enabled = true;
                 break;
             default:
                 os_parse_cmd_args(popt->index, optarg);
@@ -4581,6 +4584,16 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     }
 
+    /* check if the vhost-pci-server is enabled */
+    if (vhost_pci_slave_enabled) {
+        int ret;
+        ret = vhost_pci_slave_init(qemu_opts_find(
+                                    qemu_find_opts("vhost-pci-slave"),
+                                    NULL));
+        if (ret < 0)
+            exit(1);
+    }
+
     /* init USB devices */
     if (machine_usb(current_machine)) {
         if (foreach_device_config(DEV_USB, usb_parse) < 0)
@@ -4710,6 +4723,13 @@ int main(int argc, char **argv, char **envp)
     pause_all_vcpus();
     res_free();
 
+    if (vhost_pci_slave_enabled) {
+        int ret;
+        ret = vhost_pci_slave_cleanup();
+        if (ret < 0)
+            exit(1);
+    }
+
     /* vhost-user must be cleaned up before chardevs.  */
     net_cleanup();
     audio_cleanup();
-- 
2.7.4
