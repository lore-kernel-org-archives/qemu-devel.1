Received: from eggs.gnu.org ([2001:4830:134:3::10]:48126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dUwYz-00007x-GV
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:54:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dUwYw-00052R-D4
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:54:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33501
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dUwYw-00051Y-7W
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:54:54 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6BEsT3K133795
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 10:54:51 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bn0mv8kvc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 10:54:51 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 11 Jul 2017 15:54:49 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 11 Jul 2017 16:54:37 +0200
In-Reply-To: <20170711145441.33925-1-pasic@linux.vnet.ibm.com>
References: <20170711145441.33925-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170711145441.33925-3-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 2/6] s390x: add css_migration_enabled to
 machine class
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

Currently the migration of the channel subsystem (css) is only partial
and is done by the virtio ccw proxies -- the only migratable css devices
existing at the moment.

With the current work on emulated and passthrough devices we need to
decouple the migration of the channel subsystem state from virtio ccw,
and have a separate section for it. A new section  however necessarily
breaks the migration compatibility.

So let us introduce a switch at the machine class, and put it in 'off'
state for now. We will turn the switch 'on' for future machines once all
preparations are met. For compatibility  machines the switch will stay
'off'.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c         | 13 +++++++++++++
 include/hw/s390x/s390-virtio-ccw.h |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 1eb17ad184..751febb87a 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -206,6 +206,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
 
     s390mc->ri_allowed = true;
     s390mc->cpu_model_allowed = true;
+    s390mc->css_migration_enabled = false; /* TODO: set to true */
     mc->init = ccw_init;
     mc->reset = s390_machine_reset;
     mc->hot_add_cpu = s390_hot_add_cpu;
@@ -375,6 +376,11 @@ static const TypeInfo ccw_machine_info = {
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
@@ -476,6 +482,10 @@ static const TypeInfo ccw_machine_info = {
 
 static void ccw_machine_2_10_instance_options(MachineState *machine)
 {
+    /*
+     * TODO Once preparations are done register vmstate for the css if
+     * css_migration_enabled().
+     */
 }
 
 static void ccw_machine_2_10_class_options(MachineClass *mc)
@@ -490,8 +500,11 @@ static void ccw_machine_2_9_instance_options(MachineState *machine)
 
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
index 3027555f6d..ab88d49d10 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -39,6 +39,7 @@ typedef struct S390CcwMachineClass {
     /*< public >*/
     bool ri_allowed;
     bool cpu_model_allowed;
+    bool css_migration_enabled;
 } S390CcwMachineClass;
 
 /* runtime-instrumentation allowed by the machine */
@@ -46,4 +47,10 @@ bool ri_allowed(void);
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
2.11.2
