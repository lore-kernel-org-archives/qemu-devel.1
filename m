Received: from eggs.gnu.org ([209.51.188.92]:60173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMc-0002nM-Rm
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nMa-0005ke-Hm
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:45 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nMY-0005hc-I8
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:43 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:22:31 -0800
Message-Id: <20190307072231.9457-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 27/37] multi-process: remote:
 add setup_devices and setup_drive msg processing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Receive by remote side the configuration messages and build the device
object from JSON device descriptions.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 remote/remote-main.c | 126 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/remote/remote-main.c b/remote/remote-main.c
index a9c12a9..52da3c8 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -54,6 +54,15 @@
 #include "qemu/config-file.h"
 #include "monitor/qdev.h"
 #include "qapi/qmp/qdict.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/blockdev.h"
+#include "block/block.h"
+#include "qapi/qmp/qstring.h"
+#include "hw/qdev-properties.h"
+#include "hw/scsi/scsi.h"
+#include "block/qdict.h"
+#include "qapi/qmp/qlist.h"
+#include "qemu/log.h"
 
 static ProxyLinkState *proxy_link;
 PCIDevice *remote_pci_dev;
@@ -223,6 +232,107 @@ fail:
     PUT_REMOTE_WAIT(wait);
 }
 
+static int init_drive(QDict *rqdict, Error **errp)
+{
+    QemuOpts *opts;
+    Error *local_error = NULL;
+
+    if (rqdict != NULL && qdict_size(rqdict) > 0) {
+        opts = qemu_opts_from_qdict(&qemu_drive_opts,
+                                    rqdict, &local_error);
+        if (!opts) {
+            error_propagate(errp, local_error);
+            return -EINVAL;
+        }
+    } else {
+        return -EINVAL;
+    }
+    if (drive_new(opts, IF_IDE, &local_error) == NULL) {
+        error_propagate(errp, local_error);
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int setup_drive(ProcMsg *msg, Error **errp)
+{
+    QObject *obj;
+    QDict *qdict;
+    QString *qstr;
+    Error *local_error = NULL;
+    int rc = -EINVAL;
+
+    if (!msg->data2) {
+        return rc;
+    }
+
+    qstr = qstring_from_str((char *)msg->data2);
+    obj = qobject_from_json(qstring_get_str(qstr), errp);
+    if (!obj) {
+        return rc;
+    }
+
+    qdict = qobject_to(QDict, obj);
+    if (!qdict) {
+        return rc;
+    }
+
+    qdict_del(qdict, "rid");
+    if (init_drive(qdict, &local_error)) {
+        error_propagate(errp, local_error);
+        return rc;
+    }
+
+    return 0;
+}
+
+static int setup_device(ProcMsg *msg, Error **errp)
+{
+    QObject *obj;
+    QDict *qdict;
+    QString *qstr;
+    QemuOpts *opts;
+    DeviceState *dev = NULL;
+    int rc = -EINVAL;
+
+    if (!msg->data2) {
+        return rc;
+    }
+
+    qstr = qstring_from_str((char *)msg->data2);
+
+    obj = qobject_from_json(qstring_get_str(qstr), errp);
+    if (!obj) {
+        error_setg(errp, "Could not convert to json object.");
+        return rc;
+    }
+
+    qdict = qobject_to(QDict, obj);
+    if (!qdict) {
+        return rc;
+    }
+
+    g_assert(qdict_size(qdict) > 1);
+
+    qdict_del(qdict, "command");
+    qdict_del(qdict, "rid");
+
+    opts = qemu_opts_from_qdict(&qemu_device_opts, qdict, errp);
+
+    dev = qdev_device_add(opts, errp);
+    if (!dev) {
+        error_setg(errp, "Could not add device %s.", qstring_get_str(qstr));
+        return rc;
+    }
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        remote_pci_dev = PCI_DEVICE(dev);
+    }
+    qemu_opts_del(opts);
+
+    return 0;
+}
+
 static void process_msg(GIOCondition cond)
 {
     ProcMsg *msg = NULL;
@@ -268,11 +378,27 @@ static void process_msg(GIOCondition cond)
          */
         remote_sysmem_reconfig(msg, &err);
         if (err) {
+            error_report_err(err);
             goto finalize_loop;
         }
         break;
     case SET_IRQFD:
         process_set_irqfd_msg(remote_pci_dev, msg);
+        qdev_machine_creation_done();
+        qemu_mutex_lock_iothread();
+        qemu_run_machine_init_done_notifiers();
+        qemu_mutex_unlock_iothread();
+
+        break;
+    case DRIVE_OPTS:
+        if (setup_drive(msg, &err)) {
+            error_report_err(err);
+        }
+        break;
+    case DEV_OPTS:
+        if (setup_device(msg, &err)) {
+            error_report_err(err);
+        }
         break;
     case DEVICE_ADD:
         process_device_add_msg(msg);
-- 
1.8.3.1
