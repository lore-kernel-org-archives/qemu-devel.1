Received: from eggs.gnu.org ([2001:4830:134:3::10]:48180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dUwZ3-0000C9-O6
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dUwZ0-000568-Lt
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:55:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dUwZ0-00055V-CJ
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:54:58 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6BEs3eG075072
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 10:54:56 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bn0n38mrx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 10:54:56 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 11 Jul 2017 15:54:53 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 11 Jul 2017 16:54:40 +0200
In-Reply-To: <20170711145441.33925-1-pasic@linux.vnet.ibm.com>
References: <20170711145441.33925-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170711145441.33925-6-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 5/6] s390x/css: activate ChannelSubSys
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

Turn on migration for the channel subsystem for the next machine.  For
legacy machines we still have to do things the old way.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/css.c             | 5 +++++
 hw/s390x/s390-virtio-ccw.c | 9 ++++-----
 include/hw/s390x/css.h     | 4 ++++
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 20b5fbed68..b89b60751a 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -407,6 +407,11 @@ static int subch_dev_post_load(void *opaque, int version_id)
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
index 751febb87a..20e3f06519 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -206,7 +206,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
 
     s390mc->ri_allowed = true;
     s390mc->cpu_model_allowed = true;
-    s390mc->css_migration_enabled = false; /* TODO: set to true */
+    s390mc->css_migration_enabled = true;
     mc->init = ccw_init;
     mc->reset = s390_machine_reset;
     mc->hot_add_cpu = s390_hot_add_cpu;
@@ -482,10 +482,9 @@ bool css_migration_enabled(void)
 
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
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 5d302223e6..949e0f0a28 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -226,4 +226,8 @@ extern PropertyInfo css_devid_ro_propinfo;
  */
 SubchDev *css_create_sch(CssDevId bus_id, bool is_virtual, bool squash_mcss,
                          Error **errp);
+
+/** Turn on css migration */
+void css_register_vmstate(void);
+
 #endif
-- 
2.11.2
