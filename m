Received: from eggs.gnu.org ([2001:4830:134:3::10]:45399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6h8W-00011p-Cv
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6h8T-0005Hh-AH
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:35:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1d6h8T-0005HP-1M
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:35:21 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v45HXqKa038250
	for <qemu-devel@nongnu.org>; Fri, 5 May 2017 13:35:19 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a8u4g8afy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 13:35:19 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 5 May 2017 18:35:17 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri,  5 May 2017 19:34:59 +0200
In-Reply-To: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
References: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170505173507.74077-3-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 02/10] s390x: add css_migration_enabled to
 machine class
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

Currently the migration of the channel subsystem (css) is only partial
and is done by the virtio ccw proxies -- the only css devices existing
at the moment. With the current efforts towards emulated and passthrough
devices we need to improve on the migration of the css. This however
will necessarily break the migration compatibility. So let us introduce
a switch (at the machine class) and put it in off state for now. We will
turn the switch on for future machines once all preparations are met.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c         | 13 +++++++++++++
 include/hw/s390x/s390-virtio-ccw.h |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 7a053a4..698e8fc 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -196,6 +196,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
 
     s390mc->ri_allowed = true;
     s390mc->cpu_model_allowed = true;
+    s390mc->css_migration_enabled = false; /* TODO: set to true */
     mc->init = ccw_init;
     mc->reset = s390_machine_reset;
     mc->hot_add_cpu = s390_hot_add_cpu;
@@ -307,6 +308,11 @@ static const TypeInfo ccw_machine_info = {
     },
 };
 
+bool css_migration_enabled(void)
+{
+    return get_machine_class()->css_migration_enabled;
+}
+
 #define DEFINE_CCW_MACHINE(suffix, verstr, latest)                            \
     static void ccw_machine_##suffix##_class_init(ObjectClass *oc,            \
                                                   void *data)                 \
@@ -408,6 +414,10 @@ static const TypeInfo ccw_machine_info = {
 
 static void ccw_machine_2_10_instance_options(MachineState *machine)
 {
+    /*
+     * TODO Once preparations are done register vmstate for the css if
+     * css_migration_enabled().
+     */
 }
 
 static void ccw_machine_2_10_class_options(MachineClass *mc)
@@ -422,8 +432,11 @@ static void ccw_machine_2_9_instance_options(MachineState *machine)
 
 static void ccw_machine_2_9_class_options(MachineClass *mc)
 {
+    S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
+
     ccw_machine_2_10_class_options(mc);
     SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_9);
+    s390mc->css_migration_enabled = false;
 }
 DEFINE_CCW_MACHINE(2_9, "2.9", false);
 
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 6ecae00..b043550 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -37,6 +37,7 @@ typedef struct S390CcwMachineClass {
     /*< public >*/
     bool ri_allowed;
     bool cpu_model_allowed;
+    bool css_migration_enabled;
 } S390CcwMachineClass;
 
 /* runtime-instrumentation allowed by the machine */
@@ -44,4 +45,10 @@ bool ri_allowed(void);
 /* cpu model allowed by the machine */
 bool cpu_model_allowed(void);
 
+/**
+ * Returns true if (vmstate based) migration of the channel subsystem
+ * is enabled, false if it is disabled.
+ */
+bool css_migration_enabled(void);
+
 #endif
-- 
2.10.2
