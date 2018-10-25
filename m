Received: from eggs.gnu.org ([2001:4830:134:3::10]:43623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1gFgHe-0007qf-KK
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1gFgHa-0007dX-Fb
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:06:46 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1gFgHa-0007co-5E
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:06:42 -0400
Received: by mail-wr1-x442.google.com with SMTP id y15-v6so5091823wru.9
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 07:06:42 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Thu, 25 Oct 2018 17:06:30 +0300
Message-Id: <20181025140631.634922-2-sameeh@daynix.com>
In-Reply-To: <20181025140631.634922-1-sameeh@daynix.com>
References: <20181025140631.634922-1-sameeh@daynix.com>
Subject: [Qemu-devel] [RFC 1/2] qdev/qbus: Add hidden device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yan Vugenfirer <yan@daynix.com>, Eduardo Habkost <ehabkost@redhat.com>

From: Sameeh Jubran <sjubran@redhat.com>

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
---
 hw/core/qdev.c         | 48 +++++++++++++++++++++++++++++++---
 hw/pci/pci.c           |  1 +
 include/hw/pci/pci.h   |  2 ++
 include/hw/qdev-core.h | 11 +++++++-
 qdev-monitor.c         | 58 +++++++++++++++++++++++++++++++++++++++---
 5 files changed, 112 insertions(+), 8 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 529b82de18..a7c063f6ae 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -77,16 +77,23 @@ static void bus_add_child(BusState *bus, DeviceState *child)
     kid->child = child;
     object_ref(OBJECT(kid->child));
 
-    QTAILQ_INSERT_HEAD(&bus->children, kid, sibling);
+    if(child->hidden)
+    {
+        QTAILQ_INSERT_HEAD(&bus->hidden_children, kid, sibling);
+    }
+    else
+    {
+        QTAILQ_INSERT_HEAD(&bus->children, kid, sibling);
 
-    /* This transfers ownership of kid->child to the property.  */
-    snprintf(name, sizeof(name), "child[%d]", kid->index);
-    object_property_add_link(OBJECT(bus), name,
+        /* This transfers ownership of kid->child to the property.  */
+        snprintf(name, sizeof(name), "child[%d]", kid->index);
+        object_property_add_link(OBJECT(bus), name,
                              object_get_typename(OBJECT(child)),
                              (Object **)&kid->child,
                              NULL, /* read-only property */
                              0, /* return ownership on prop deletion */
                              NULL);
+    }
 }
 
 void qdev_set_parent_bus(DeviceState *dev, BusState *bus)
@@ -104,12 +111,38 @@ void qdev_set_parent_bus(DeviceState *dev, BusState *bus)
     }
     dev->parent_bus = bus;
     object_ref(OBJECT(bus));
+
     bus_add_child(bus, dev);
+
     if (replugging) {
         object_unref(OBJECT(dev));
     }
 }
 
+void qdev_unhide(const char *dev_id, BusState *bus, Error **errp)
+{
+    BusChild *kid;
+    DeviceState *dev = NULL;
+
+    QTAILQ_FOREACH(kid, &bus->hidden_children, sibling) {
+        if (!strcmp(kid->child->id,dev_id)) {
+            dev = kid->child;
+            break;
+        }
+    }
+
+    if (dev && dev->hidden)
+    {
+        dev->hidden = false;
+        QTAILQ_REMOVE(&bus->hidden_children, kid, sibling);
+        qdev_set_parent_bus(dev, dev->parent_bus);
+        object_property_set_bool(OBJECT(dev), true, "realized", errp);
+        if (!errp)
+        hotplug_handler_plug(bus->hotplug_handler, dev,
+                    errp);
+    }
+}
+
 /* Create a new device.  This only initializes the device state
    structure and allows properties to be set.  The device still needs
    to be realized.  See qdev-core.h.  */
@@ -208,6 +241,13 @@ void device_listener_unregister(DeviceListener *listener)
     QTAILQ_REMOVE(&device_listeners, listener, link);
 }
 
+bool qdev_should_hide_device(const char *dev_id, BusState *bus)
+{
+    bool res;
+    DEVICE_LISTENER_CALL(should_be_hidden, Forward, dev_id, bus, &res);
+    return res;
+}
+
 void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
                                  int required_for_version)
 {
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 80bc45930d..054c22be1e 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -70,6 +70,7 @@ static Property pci_props[] = {
                     QEMU_PCIE_LNKSTA_DLLLA_BITNR, true),
     DEFINE_PROP_BIT("x-pcie-extcap-init", PCIDevice, cap_present,
                     QEMU_PCIE_EXTCAP_INIT_BITNR, true),
+    DEFINE_PROP_STRING("standby", PCIDevice, standby_id_str),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 990d6fcbde..8c0c3e9ef7 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -351,6 +351,8 @@ struct PCIDevice {
     MSIVectorUseNotifier msix_vector_use_notifier;
     MSIVectorReleaseNotifier msix_vector_release_notifier;
     MSIVectorPollNotifier msix_vector_poll_notifier;
+
+    char *standby_id_str;
 };
 
 void pci_register_bar(PCIDevice *pci_dev, int region_num,
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index f1fd0f8736..dedb84e539 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -143,6 +143,7 @@ struct DeviceState {
     char *canonical_path;
     bool realized;
     bool pending_deleted_event;
+    bool hidden;
     QemuOpts *opts;
     int hotplugged;
     BusState *parent_bus;
@@ -156,6 +157,11 @@ struct DeviceState {
 struct DeviceListener {
     void (*realize)(DeviceListener *listener, DeviceState *dev);
     void (*unrealize)(DeviceListener *listener, DeviceState *dev);
+    /* This callback is called just upon init of the DeviceState
+     * and can be used by a standby device for informing qdev if this
+     * device should be hidden by cross checking the ids
+     */
+    void (*should_be_hidden)(DeviceListener *listener, const char *dev_id, BusState *bus, bool *res);
     QTAILQ_ENTRY(DeviceListener) link;
 };
 
@@ -206,6 +212,7 @@ struct BusState {
     int max_index;
     bool realized;
     QTAILQ_HEAD(ChildrenHead, BusChild) children;
+    QTAILQ_HEAD(HiddenChildrenHead, BusChild) hidden_children;
     QLIST_ENTRY(BusState) sibling;
 };
 
@@ -360,7 +367,7 @@ int qdev_walk_children(DeviceState *dev,
 
 void qdev_reset_all(DeviceState *dev);
 void qdev_reset_all_fn(void *opaque);
-
+void qdev_unhide(const char *dev_id, BusState *bus, Error **errp);
 /**
  * @qbus_reset_all:
  * @bus: Bus to be reset.
@@ -434,4 +441,6 @@ static inline bool qbus_is_hotpluggable(BusState *bus)
 void device_listener_register(DeviceListener *listener);
 void device_listener_unregister(DeviceListener *listener);
 
+bool qdev_should_hide_device(const char *dev_id, BusState *bus);
+
 #endif
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 61e0300991..e211b7b223 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -554,6 +554,49 @@ void qdev_set_id(DeviceState *dev, const char *id)
     }
 }
 
+struct DeviceBusTuple
+{
+    DeviceState *dev;
+    BusState *bus;
+} DeviceBusTuple;
+
+static int has_standby_device(void *opaque, const char *name, const char *value,
+                        Error **errp)
+{
+    if (strcmp(name, "standby") == 0)
+    {
+        struct DeviceBusTuple *tuple = (struct DeviceBusTuple *)opaque;
+        const char *dev_id = (tuple->dev)->id;
+        BusState *bus = tuple->bus;
+
+        if (qdev_should_hide_device(dev_id, bus))
+        {
+            return 1;
+        }
+        else
+        {
+            error_setg(errp, "An error occurred: Please note that the primary device should be"
+            " must be placed after the standby device in the command line");
+            return -1;
+        }
+    }
+    return 0;
+}
+
+static bool should_hide_device(DeviceState *dev, QemuOpts *opts,BusState *bus, Error **err)
+{
+    struct DeviceBusTuple tuple;
+    tuple.dev = dev;
+    tuple.bus = bus;
+
+    if (//!qemu_opt_get(opts, "vfio-pci") ||
+        qemu_opt_foreach(opts, has_standby_device, &tuple, err) == 0)
+    {
+        return false;
+    }
+    return true;
+}
+
 DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
 {
     DeviceClass *dc;
@@ -607,6 +650,13 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
     /* create device */
     dev = DEVICE(object_new(driver));
 
+    qdev_set_id(dev, qemu_opts_id(opts));
+
+    dev->hidden = should_hide_device(dev, opts, bus, &err);
+    if (err)
+    {
+        goto err_del_dev;
+    }
     if (bus) {
         qdev_set_parent_bus(dev, bus);
     } else if (qdev_hotplug && !qdev_get_machine_hotplug_handler(dev)) {
@@ -616,15 +666,17 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
         goto err_del_dev;
     }
 
-    qdev_set_id(dev, qemu_opts_id(opts));
-
     /* set properties */
     if (qemu_opt_foreach(opts, set_property, dev, &err)) {
         goto err_del_dev;
     }
 
     dev->opts = opts;
-    object_property_set_bool(OBJECT(dev), true, "realized", &err);
+    if (!dev->hidden)
+    {
+        object_property_set_bool(OBJECT(dev), true, "realized", &err);
+    }
+
     if (err != NULL) {
         dev->opts = NULL;
         goto err_del_dev;
-- 
2.17.0
