Received: from eggs.gnu.org ([2001:4830:134:3::10]:53559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIqzu-0002ox-3M
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIqzt-0004WA-2F
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:30 -0500
Received: from mga06.intel.com ([134.134.136.31]:33815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cIqzs-0004Vl-Q2
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:29 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 19 Dec 2016 13:58:39 +0800
Message-Id: <1482127152-84732-5-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
References: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [RESEND Patch v1 04/37] vl: add the vhost-pci-slave
 command line option
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

An example of the command line option to create a vhost-pci-slave is:

-chardev socket,id=slave1,server,wait=off,path=/opt/vhost-pci-slave
-vhost-pci-slave socket,chardev=slave1

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 qemu-options.hx |  4 ++++
 vl.c            | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index c534a2f..5d60a1d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4068,6 +4068,10 @@ contents of @code{iv.b64} to the second secret
 
 ETEXI
 
+DEF("vhost-pci-slave", HAS_ARG, QEMU_OPTION_vhost_pci_slave,
+    "-vhost-pci-slave socket,chrdev={id}\n"
+    "                  creates a vhost-pci-slave",
+    QEMU_ARCH_I386)
 
 HXCOMM This is the last statement. Insert new options before this line!
 STEXI
diff --git a/vl.c b/vl.c
index d77dd86..deb116e 100644
--- a/vl.c
+++ b/vl.c
@@ -509,6 +509,20 @@ static QemuOptsList qemu_fw_cfg_opts = {
     },
 };
 
+static QemuOptsList qemu_vhost_pci_slave_opts = {
+    .name = "vhost-pci-slave",
+    .implied_opt_name = "chardev",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_vhost_pci_slave_opts.head),
+    .desc = {
+        /*
+         * no elements => accept any
+         * sanity checking will happen later
+         * when setting device properties
+         */
+        { /* end of list */ }
+    },
+};
+
 #ifdef CONFIG_LIBISCSI
 static QemuOptsList qemu_iscsi_opts = {
     .name = "iscsi",
@@ -3073,6 +3087,7 @@ int main(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_icount_opts);
     qemu_add_opts(&qemu_semihosting_config_opts);
     qemu_add_opts(&qemu_fw_cfg_opts);
+    qemu_add_opts(&qemu_vhost_pci_slave_opts);
 #ifdef CONFIG_LIBISCSI
     qemu_add_opts(&qemu_iscsi_opts);
 #endif
@@ -4044,6 +4059,13 @@ int main(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 break;
+            case QEMU_OPTION_vhost_pci_slave:
+                opts = qemu_opts_parse_noisily(
+                           qemu_find_opts("vhost-pci-slave"), optarg, false);
+                if (!opts) {
+                    exit(1);
+                }
+                break;
             default:
                 os_parse_cmd_args(popt->index, optarg);
             }
-- 
2.7.4
