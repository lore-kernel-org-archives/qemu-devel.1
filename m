Received: from eggs.gnu.org ([2001:4830:134:3::10]:56920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyPJ-00008x-B5
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyPG-0004Bv-Kd
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:05:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVyPG-0004AS-AC
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:05:10 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6EB54Sv037562
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:05:09 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bpsv8em2p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:05:08 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 14 Jul 2017 12:04:49 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Jul 2017 12:40:39 +0200
In-Reply-To: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1500028867-134709-13-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 12/40] s390x: add helper get_machine_class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

We will need the machine class at machine initialization time, so the
usual way via qdev won't do. Let's cache the machine class and also use
the default values of the base machine for capability discovery.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Message-Id: <20170711145441.33925-2-pasic@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 0c8f758..df2b055 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -255,36 +255,35 @@ static inline void machine_set_dea_key_wrap(Object *obj, bool value,
     ms->dea_key_wrap = value;
 }
 
+static S390CcwMachineClass *current_mc;
+
+static S390CcwMachineClass *get_machine_class(void)
+{
+    if (unlikely(!current_mc)) {
+        /*
+        * No s390 ccw machine was instantiated, we are likely to
+        * be called for the 'none' machine. The properties will
+        * have their after-initialization values.
+        */
+        current_mc = S390_MACHINE_CLASS(
+                     object_class_by_name(TYPE_S390_CCW_MACHINE));
+    }
+    return current_mc;
+}
+
 bool ri_allowed(void)
 {
-    if (kvm_enabled()) {
-        MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
-        if (object_class_dynamic_cast(OBJECT_CLASS(mc),
-                                      TYPE_S390_CCW_MACHINE)) {
-            S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
-
-            return s390mc->ri_allowed;
-        }
-        /*
-         * Make sure the "none" machine can have ri, otherwise it won't * be
-         * unlocked in KVM and therefore the host CPU model might be wrong.
-         */
-        return true;
+    if (!kvm_enabled()) {
+        return false;
     }
-    return 0;
+    /* for "none" machine this results in true */
+    return get_machine_class()->ri_allowed;
 }
 
 bool cpu_model_allowed(void)
 {
-    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
-    if (object_class_dynamic_cast(OBJECT_CLASS(mc),
-                                  TYPE_S390_CCW_MACHINE)) {
-        S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
-
-        return s390mc->cpu_model_allowed;
-    }
-    /* allow CPU model qmp queries with the "none" machine */
-    return true;
+    /* for "none" machine this results in true */
+    return get_machine_class()->cpu_model_allowed;
 }
 
 static char *machine_get_loadparm(Object *obj, Error **errp)
@@ -394,6 +393,7 @@ static const TypeInfo ccw_machine_info = {
     static void ccw_machine_##suffix##_instance_init(Object *obj)             \
     {                                                                         \
         MachineState *machine = MACHINE(obj);                                 \
+        current_mc = S390_MACHINE_CLASS(MACHINE_GET_CLASS(machine));          \
         ccw_machine_##suffix##_instance_options(machine);                     \
     }                                                                         \
     static const TypeInfo ccw_machine_##suffix##_info = {                     \
-- 
2.7.4
