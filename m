Received: from eggs.gnu.org ([2001:4830:134:3::10]:53001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g85ZN-00086Y-1B
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:29:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g85ZK-0004zJ-Cm
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:29:40 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  4 Oct 2018 17:28:46 +0200
Message-Id: <20181004152857.14525-5-cohuck@redhat.com>
In-Reply-To: <20181004152857.14525-1-cohuck@redhat.com>
References: <20181004152857.14525-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 04/15] s390x: Fence huge pages prior to 3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Janosch Frank <frankja@linux.ibm.com>

As the kernel has no way of disallowing the start of a huge page
backed VM, we can migrate a running huge backed VM to a host that has
no huge page KVM support.

Let's glue huge page support support to the 3.1 machine, so we do not
migrate to a destination host that doesn't have QEMU huge page support
and can stop migration if KVM doesn't indicate support.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Message-Id: <20180928093435.198573-1-frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c         | 10 ++++++++++
 include/hw/s390x/s390-virtio-ccw.h |  3 +++
 target/s390x/kvm.c                 |  6 ++++++
 3 files changed, 19 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index f0f7fdcadd..53fd7c975f 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -456,6 +456,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     s390mc->ri_allowed = true;
     s390mc->cpu_model_allowed = true;
     s390mc->css_migration_enabled = true;
+    s390mc->hpage_1m_allowed = true;
     mc->init = ccw_init;
     mc->reset = s390_machine_reset;
     mc->hot_add_cpu = s390_hot_add_cpu;
@@ -535,6 +536,12 @@ bool cpu_model_allowed(void)
     return get_machine_class()->cpu_model_allowed;
 }
 
+bool hpage_1m_allowed(void)
+{
+    /* for "none" machine this results in true */
+    return get_machine_class()->hpage_1m_allowed;
+}
+
 static char *machine_get_loadparm(Object *obj, Error **errp)
 {
     S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
@@ -747,6 +754,9 @@ static void ccw_machine_3_0_instance_options(MachineState *machine)
 
 static void ccw_machine_3_0_class_options(MachineClass *mc)
 {
+    S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
+
+    s390mc->hpage_1m_allowed = false;
     ccw_machine_3_1_class_options(mc);
     SET_MACHINE_COMPAT(mc, CCW_COMPAT_3_0);
 }
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index e9c4f4182b..8aa27199c9 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -39,12 +39,15 @@ typedef struct S390CcwMachineClass {
     bool ri_allowed;
     bool cpu_model_allowed;
     bool css_migration_enabled;
+    bool hpage_1m_allowed;
 } S390CcwMachineClass;
 
 /* runtime-instrumentation allowed by the machine */
 bool ri_allowed(void);
 /* cpu model allowed by the machine */
 bool cpu_model_allowed(void);
+/* 1M huge page mappings allowed by the machine */
+bool hpage_1m_allowed(void);
 
 /**
  * Returns true if (vmstate based) migration of the channel subsystem
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 348e8cc546..323cb00e6a 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -292,6 +292,12 @@ static int kvm_s390_configure_mempath_backing(KVMState *s)
         return 0;
     }
 
+    if (!hpage_1m_allowed()) {
+        error_report("This QEMU machine does not support huge page "
+                     "mappings");
+        return -EINVAL;
+    }
+
     if (path_psize != 1 * MiB) {
         error_report("Memory backing with 2G pages was specified, "
                      "but KVM does not support this memory backing");
-- 
2.14.4
