Received: from eggs.gnu.org ([2001:4830:134:3::10]:54085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr0q-0005FQ-5y
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr0n-0004xf-V1
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:01:28 -0500
Received: from mga06.intel.com ([134.134.136.31]:33815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cIr0n-0004Vl-N6
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:01:25 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 19 Dec 2016 13:59:12 +0800
Message-Id: <1482127152-84732-38-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
References: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [RESEND Patch v1 37/37] vl: enable vhost-pci-slave
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
 vl.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/vl.c b/vl.c
index deb116e..b8649be 100644
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
 
@@ -4065,6 +4067,7 @@ int main(int argc, char **argv, char **envp)
                 if (!opts) {
                     exit(1);
                 }
+                vhost_pci_slave_enabled = true;
                 break;
             default:
                 os_parse_cmd_args(popt->index, optarg);
@@ -4582,6 +4585,16 @@ int main(int argc, char **argv, char **envp)
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
@@ -4711,6 +4724,14 @@ int main(int argc, char **argv, char **envp)
     pause_all_vcpus();
     res_free();
 
+    if (vhost_pci_slave_enabled) {
+        int ret;
+        ret = vhost_pci_slave_cleanup();
+        if (ret < 0) {
+            exit(1);
+        }
+    }
+
     /* vhost-user must be cleaned up before chardevs.  */
     net_cleanup();
     audio_cleanup();
-- 
2.7.4
