Received: from eggs.gnu.org ([2001:4830:134:3::10]:35593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=DTTN=2R=redhat.com=mst@kernel.org>)
	id 1cllUg-0005Mv-9k
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 18:59:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=DTTN=2R=redhat.com=mst@kernel.org>)
	id 1cllUc-0001uq-Ch
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 18:59:46 -0500
Received: from mail.kernel.org ([198.145.29.136]:56776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=DTTN=2R=redhat.com=mst@kernel.org>)
	id 1cllUc-0001uO-3d
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 18:59:42 -0500
Date: Thu, 9 Mar 2017 01:59:35 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1489017212-2990-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH RFC] qdev: add init order filter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.a@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Allow forcing a specific order of initialization on
devices created with -device.
Helpful e.g. for built-in devices such as IOMMUs which must
exist before all other devices.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Looks like we have a ton of problems because devices
are initialized in a random order, while we
really want e.g. iommu to be initialized
earlier than devices.

This will be helpful for other things, e.g.
real hardware often is initialized in a specific order,
creating built-in devices for the board often
has to happen in a specific order, etc.


We could then stop trying to do things at machine
done time and simply set initialization order.

The following patch achieves this for devices
created with -device but unfortunately not others
(e.g. not -net nic, etc).

Thoughts on the best way to complete this would be appreciated.

As you can see this patch is small enough for 2.9 and it might be a good
idea considering the pile of hacks we have pending as a replacement.


 include/hw/qdev-core.h | 10 ++++++++++
 include/monitor/qdev.h |  2 +-
 qdev-monitor.c         |  9 +++++++--
 vl.c                   | 15 ++++++++++-----
 4 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index b44b476..5704b67 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -40,6 +40,13 @@ typedef void (*BusUnrealize)(BusState *bus, Error **errp);
 
 struct VMStateDescription;
 
+typedef enum DeviceInitOrder {
+    DEVICE_INIT_ORDER_MIN = -1,
+    DEVICE_INIT_ORDER_EARLY = -1,
+    DEVICE_INIT_ORDER_DEFAULT = 0,
+    DEVICE_INIT_ORDER_MAX = 0,
+} DeviceInitOrder;
+
 /**
  * DeviceClass:
  * @props: Properties accessing state fields.
@@ -128,6 +135,9 @@ typedef struct DeviceClass {
 
     bool hotpluggable;
 
+    /* init order. Only affects devices created with -device at this point */
+    DeviceInitOrder init_order;
+
     /* callbacks */
     void (*reset)(DeviceState *dev);
     DeviceRealize realize;
diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
index 0ff3331..af2dc67 100644
--- a/include/monitor/qdev.h
+++ b/include/monitor/qdev.h
@@ -11,7 +11,7 @@ void hmp_info_qom_tree(Monitor *mon, const QDict *dict);
 void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp);
 
 int qdev_device_help(QemuOpts *opts);
-DeviceState *qdev_device_add(QemuOpts *opts, Error **errp);
+DeviceState *qdev_device_add(QemuOpts *opts, int init_order, Error **errp);
 void qdev_set_id(DeviceState *dev, const char *id);
 
 #endif
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 549f45f..657f89d 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -559,7 +559,7 @@ void qdev_set_id(DeviceState *dev, const char *id)
     }
 }
 
-DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
+DeviceState *qdev_device_add(QemuOpts *opts, int init_order, Error **errp)
 {
     DeviceClass *dc;
     const char *driver, *path;
@@ -579,6 +579,11 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
         return NULL;
     }
 
+    if (dc->init_order != init_order) {
+        /* Not an error - will be initialized with correct order */
+        return NULL;
+    }
+
     if (only_migratable) {
         if (dc->vmsd->unmigratable) {
             error_setg(errp, "Device %s is not migratable, but "
@@ -807,7 +812,7 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
         qemu_opts_del(opts);
         return;
     }
-    dev = qdev_device_add(opts, &local_err);
+    dev = qdev_device_add(opts, DEVICE_INIT_ORDER_DEFAULT,  &local_err);
     if (!dev) {
         error_propagate(errp, local_err);
         qemu_opts_del(opts);
diff --git a/vl.c b/vl.c
index e10a27b..d77fbc9 100644
--- a/vl.c
+++ b/vl.c
@@ -2300,11 +2300,14 @@ static int device_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
     Error *err = NULL;
     DeviceState *dev;
+    int init_order = (intptr_t)opaque;
 
-    dev = qdev_device_add(opts, &err);
-    if (!dev) {
+    dev = qdev_device_add(opts, init_order, &err);
+    if (!dev && err) {
         error_report_err(err);
         return -1;
+    } else if (!dev) {
+        return 0;
     }
     object_unref(OBJECT(dev));
     return 0;
@@ -4546,9 +4549,11 @@ int main(int argc, char **argv, char **envp)
 
     /* init generic devices */
     rom_set_order_override(FW_CFG_ORDER_OVERRIDE_DEVICE);
-    if (qemu_opts_foreach(qemu_find_opts("device"),
-                          device_init_func, NULL, NULL)) {
-        exit(1);
+    for (i = DEVICE_INIT_ORDER_MIN; i <= DEVICE_INIT_ORDER_MAX; ++i) {
+        if (qemu_opts_foreach(qemu_find_opts("device"),
+                              device_init_func, (void *)(intptr_t)i, NULL)) {
+            exit(1);
+        }
     }
 
     cpu_synchronize_all_post_init();
-- 
MST
