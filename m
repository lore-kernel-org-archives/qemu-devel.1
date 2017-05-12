Received: from eggs.gnu.org ([2001:4830:134:3::10]:44820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d968f-0005Yp-NG
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d968e-0001ks-Qj
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:62480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d968e-0001je-Hr
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:28 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 12 May 2017 16:35:34 +0800
Message-Id: <1494578148-102868-3-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v2 02/16] vl: add the vhost-pci-slave command
 line option
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

An example of the QEMU command to create a vhost-pci-slave is:
-chardev socket,id=slave1,server,wait=off,path=${PATH_SLAVE1}
-vhost-pci-slave socket,chardev=slave1

The master can connect to the slave as usual:
-chardev socket,id=sock2,path=${PATH_SLAVE1}
-netdev type=vhost-user,id=net2,chardev=sock2,vhostforce
-device virtio-net-pci,mac=52:54:00:00:00:02,netdev=net2

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 qemu-options.hx |  4 ++++
 vl.c            | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 99af8ed..a795850 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4152,6 +4152,10 @@ contents of @code{iv.b64} to the second secret
 
 ETEXI
 
+DEF("vhost-pci-slave", HAS_ARG, QEMU_OPTION_vhost_pci_slave,
+    "-vhost-pci-slave socket,chrdev={id}\n"
+    "                  creates a vhost-pci-slave",
+    QEMU_ARCH_I386)
 
 HXCOMM This is the last statement. Insert new options before this line!
 STEXI
diff --git a/vl.c b/vl.c
index 0b4ed52..2ee4713 100644
--- a/vl.c
+++ b/vl.c
@@ -540,6 +540,20 @@ static QemuOptsList qemu_fw_cfg_opts = {
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
 /**
  * Get machine options
  *
@@ -3027,6 +3041,7 @@ int main(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_icount_opts);
     qemu_add_opts(&qemu_semihosting_config_opts);
     qemu_add_opts(&qemu_fw_cfg_opts);
+    qemu_add_opts(&qemu_vhost_pci_slave_opts);
     module_call_init(MODULE_INIT_OPTS);
 
     runstate_init();
@@ -4039,6 +4054,13 @@ int main(int argc, char **argv, char **envp)
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
