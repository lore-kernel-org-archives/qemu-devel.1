Received: from eggs.gnu.org ([2001:4830:134:3::10]:48118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dUwYy-000069-6k
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dUwYv-00051s-3a
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:54:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59129
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dUwYu-00051X-Tq
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:54:53 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6BEs2Hf055220
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 10:54:51 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bn0mv0m0k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 10:54:51 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 11 Jul 2017 15:54:48 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 11 Jul 2017 16:54:36 +0200
In-Reply-To: <20170711145441.33925-1-pasic@linux.vnet.ibm.com>
References: <20170711145441.33925-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170711145441.33925-2-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 1/6] s390x: add helper get_machine_class
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

We will need the machine class at machine initialization time, so the
usual way via qdev won't do. Let's cache the machine class and also use
the default values of the base machine for capability discovery.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 41ca6668e2..1eb17ad184 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -252,36 +252,35 @@ static inline void machine_set_dea_key_wrap(Object *obj, bool value,
     ms->dea_key_wrap = value;
 }
 
-bool ri_allowed(void)
-{
-    if (kvm_enabled()) {
-        MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
-        if (object_class_dynamic_cast(OBJECT_CLASS(mc),
-                                      TYPE_S390_CCW_MACHINE)) {
-            S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
+static S390CcwMachineClass *current_mc;
 
-            return s390mc->ri_allowed;
-        }
+static S390CcwMachineClass *get_machine_class(void)
+{
+    if (unlikely(!current_mc)) {
         /*
-         * Make sure the "none" machine can have ri, otherwise it won't * be
-         * unlocked in KVM and therefore the host CPU model might be wrong.
-         */
-        return true;
+        * No s390 ccw machine was instantiated, we are likely to
+        * be called for the 'none' machine. The properties will
+        * have their after-initialization values.
+        */
+        current_mc = S390_MACHINE_CLASS(
+                     object_class_by_name(TYPE_S390_CCW_MACHINE));
     }
-    return 0;
+    return current_mc;
 }
 
-bool cpu_model_allowed(void)
+bool ri_allowed(void)
 {
-    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
-    if (object_class_dynamic_cast(OBJECT_CLASS(mc),
-                                  TYPE_S390_CCW_MACHINE)) {
-        S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
-
-        return s390mc->cpu_model_allowed;
+    if (!kvm_enabled()) {
+        return false;
     }
-    /* allow CPU model qmp queries with the "none" machine */
-    return true;
+    /* for "none" machine this results in true */
+    return get_machine_class()->ri_allowed;
+}
+
+bool cpu_model_allowed(void)
+{
+    /* for "none" machine this results in true */
+    return get_machine_class()->cpu_model_allowed;
 }
 
 static char *machine_get_loadparm(Object *obj, Error **errp)
@@ -391,6 +390,7 @@ static const TypeInfo ccw_machine_info = {
     static void ccw_machine_##suffix##_instance_init(Object *obj)             \
     {                                                                         \
         MachineState *machine = MACHINE(obj);                                 \
+        current_mc = S390_MACHINE_CLASS(MACHINE_GET_CLASS(machine));          \
         ccw_machine_##suffix##_instance_options(machine);                     \
     }                                                                         \
     static const TypeInfo ccw_machine_##suffix##_info = {                     \
-- 
2.11.2
