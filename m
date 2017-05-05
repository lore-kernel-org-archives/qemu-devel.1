Received: from eggs.gnu.org ([2001:4830:134:3::10]:45499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6h8e-00017x-62
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6h8b-0005M1-2v
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:35:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49357)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1d6h8a-0005Lk-QS
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:35:29 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v45HXl4o023687
	for <qemu-devel@nongnu.org>; Fri, 5 May 2017 13:35:27 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a8v0pw9n5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 13:35:27 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 5 May 2017 18:35:24 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri,  5 May 2017 19:35:06 +0200
In-Reply-To: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
References: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170505173507.74077-10-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 09/10] s390x/css: turn on channel subsystem
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

Turn on migration for the channel subsystem and the new scheme for
migrating virtio-ccw proxy devices (instead of letting the transport
independent child device migrate it's proxy, use the usual
DeviceClass.vmsd mechanism) for future machine versions.

The vmstate based migration of the channel subsystem is not migration
stream compatible with the method for handling migration of legacy
machines.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Guenther Hutzl <hutzl@linux.vnet.ibm.com>
---
 hw/s390x/ccw-device.c      |  1 +
 hw/s390x/css.c             |  5 +++++
 hw/s390x/s390-virtio-ccw.c |  9 ++++-----
 hw/s390x/virtio-ccw.c      | 14 ++++++++++++++
 include/hw/s390x/css.h     |  4 ++++
 5 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index f9bfa15..3b5df03 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -48,6 +48,7 @@ static void ccw_device_class_init(ObjectClass *klass, void *data)
     k->realize = ccw_device_realize;
     k->refill_ids = ccw_device_refill_ids;
     dc->props = ccw_device_properties;
+    dc->vmsd = &vmstate_ccw_dev;
 }
 
 const VMStateDescription vmstate_ccw_dev = {
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index d9a0fb9..b58832a 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -385,6 +385,11 @@ static int subch_dev_post_load(void *opaque, int version_id)
     return 0;
 }
 
+void css_register_vmstate(void)
+{
+    vmstate_register(NULL, 0, &vmstate_css, &channel_subsys);
+}
+
 IndAddr *get_indicator(hwaddr ind_addr, int len)
 {
     IndAddr *indicator;
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 698e8fc..5307f59 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -196,7 +196,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
 
     s390mc->ri_allowed = true;
     s390mc->cpu_model_allowed = true;
-    s390mc->css_migration_enabled = false; /* TODO: set to true */
+    s390mc->css_migration_enabled = true;
     mc->init = ccw_init;
     mc->reset = s390_machine_reset;
     mc->hot_add_cpu = s390_hot_add_cpu;
@@ -414,10 +414,9 @@ bool css_migration_enabled(void)
 
 static void ccw_machine_2_10_instance_options(MachineState *machine)
 {
-    /*
-     * TODO Once preparations are done register vmstate for the css if
-     * css_migration_enabled().
-     */
+    if (css_migration_enabled()) {
+        css_register_vmstate();
+    }
 }
 
 static void ccw_machine_2_10_class_options(MachineClass *mc)
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 8ab655c..c611b6f 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1307,6 +1307,10 @@ static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
 {
     VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
 
+    if (css_migration_enabled()) {
+        /* we migrate via DeviceClass.vmsd */
+        return;
+    }
     /*
      * We save in legacy mode. The components take care of their own
      * compat. representation (based on css_migration_enabled).
@@ -1318,6 +1322,10 @@ static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
 {
     VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
 
+    if (css_migration_enabled()) {
+        /* we migrate via DeviceClass.vmsd */
+        return 0;
+    }
     /*
      * We load in legacy mode. The components take take care to read
      * only stuff which is actually there (based on css_migration_enabled).
@@ -1365,6 +1373,11 @@ static void virtio_ccw_device_plugged(DeviceState *d, Error **errp)
     sch->id.cu_model = virtio_bus_get_vdev_id(&dev->bus);
 
 
+    /* Avoid generating unknown section for legacy migration target. */
+    if (!css_migration_enabled()) {
+        DEVICE_GET_CLASS(ccw_dev)->vmsd = NULL;
+    }
+
     css_generate_sch_crws(sch->cssid, sch->ssid, sch->schid,
                           d->hotplugged, 1);
 }
@@ -1657,6 +1670,7 @@ static void virtio_ccw_device_class_init(ObjectClass *klass, void *data)
     dc->realize = virtio_ccw_busdev_realize;
     dc->exit = virtio_ccw_busdev_exit;
     dc->bus_type = TYPE_VIRTUAL_CSS_BUS;
+    dc->vmsd = &vmstate_virtio_ccw_dev;
 }
 
 static const TypeInfo virtio_ccw_device_info = {
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index dbe093e..be5eb81 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -207,4 +207,8 @@ extern PropertyInfo css_devid_ro_propinfo;
  * is responsible for unregistering and freeing it.
  */
 SubchDev *css_create_virtual_sch(CssDevId bus_id, Error **errp);
+
+/** Turn on css migration */
+void css_register_vmstate(void);
+
 #endif
-- 
2.10.2
