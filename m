Received: from eggs.gnu.org ([2001:4830:134:3::10]:33716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dFL95-0008BZ-IR
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:55:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dFL91-0005Dp-HC
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:55:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dFL91-0005DL-8Q
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:55:39 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4TDrTna054014
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 09:55:38 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2argtctatn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 09:55:37 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 29 May 2017 14:55:35 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 29 May 2017 15:55:19 +0200
In-Reply-To: <20170529135520.101429-1-pasic@linux.vnet.ibm.com>
References: <20170529135520.101429-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170529135520.101429-7-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 6/7] s390x/css: activate ChannelSubSys
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

Turn on migration for the channel subsystem for the next machine.  For
legacy machines we still have to do things the old way.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 hw/s390x/css.c             | 5 +++++
 hw/s390x/s390-virtio-ccw.c | 9 ++++-----
 hw/s390x/virtio-ccw.c      | 1 -
 include/hw/s390x/css.h     | 4 ++++
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index e840dfba2a..9857eb3d6f 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -401,6 +401,11 @@ static int subch_dev_post_load(void *opaque, int version_id)
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
index 95256d3982..3ad6323add 100644
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
@@ -451,10 +451,9 @@ bool css_migration_enabled(void)
 
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
index a75eedeffb..4a0271b0be 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1360,7 +1360,6 @@ static void virtio_ccw_device_plugged(DeviceState *d, Error **errp)
 
     sch->id.cu_model = virtio_bus_get_vdev_id(&dev->bus);
 
-
     css_generate_sch_crws(sch->cssid, sch->ssid, sch->schid,
                           d->hotplugged, 1);
 }
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index e9c02af550..812fc05804 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -209,4 +209,8 @@ extern PropertyInfo css_devid_ro_propinfo;
  * is responsible for unregistering and freeing it.
  */
 SubchDev *css_create_virtual_sch(CssDevId bus_id, Error **errp);
+
+/** Turn on css migration */
+void css_register_vmstate(void);
+
 #endif
-- 
2.11.2
