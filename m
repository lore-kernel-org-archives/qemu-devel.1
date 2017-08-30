Received: from eggs.gnu.org ([2001:4830:134:3::10]:33354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dn6Rd-0005dC-Pr
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dn6RZ-0002Jm-PZ
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:06:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dn6RZ-0002JT-Gx
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:06:21 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 30 Aug 2017 19:05:53 +0200
Message-Id: <20170830170601.15855-4-david@redhat.com>
In-Reply-To: <20170830170601.15855-1-david@redhat.com>
References: <20170830170601.15855-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 03/11] s390x: store cpu states inside
 machine state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>

Let's avoid global variables. While at it, move both functions using it,
so we won't have to temporarily add includes (we'll be getting rid of
s390-virtio.c soon).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c         | 39 ++++++++++++++++++++++++++++++++++++++
 hw/s390x/s390-virtio.c             | 38 -------------------------------------
 hw/s390x/s390-virtio.h             |  1 -
 include/hw/s390x/s390-virtio-ccw.h |  3 +++
 4 files changed, 42 insertions(+), 39 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index dd504dd5ae..ffd56af834 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -32,6 +32,45 @@
 #include "migration/register.h"
 #include "cpu_models.h"
 
+S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
+{
+    S390CcwMachineState *ms = S390_CCW_MACHINE(qdev_get_machine());
+
+    if (cpu_addr >= max_cpus) {
+        return NULL;
+    }
+
+    /* Fast lookup via CPU ID */
+    return ms->cpus[cpu_addr];
+}
+
+static void s390_init_cpus(MachineState *machine)
+{
+    S390CcwMachineState *ms = S390_CCW_MACHINE(machine);
+    int i;
+    gchar *name;
+
+    if (machine->cpu_model == NULL) {
+        machine->cpu_model = s390_default_cpu_model_name();
+    }
+
+    ms->cpus = g_new0(S390CPU *, max_cpus);
+
+    for (i = 0; i < max_cpus; i++) {
+        name = g_strdup_printf("cpu[%i]", i);
+        object_property_add_link(OBJECT(machine), name, TYPE_S390_CPU,
+                                 (Object **) &ms->cpus[i],
+                                 object_property_allow_set_link,
+                                 OBJ_PROP_LINK_UNREF_ON_RELEASE,
+                                 &error_abort);
+        g_free(name);
+    }
+
+    for (i = 0; i < smp_cpus; i++) {
+        s390x_new_cpu(machine->cpu_model, i, &error_fatal);
+    }
+}
+
 static const char *const reset_dev_types[] = {
     TYPE_VIRTUAL_CSS_BRIDGE,
     "s390-sclp-event-facility",
diff --git a/hw/s390x/s390-virtio.c b/hw/s390x/s390-virtio.c
index da3f49e80e..464b5c71f8 100644
--- a/hw/s390x/s390-virtio.c
+++ b/hw/s390x/s390-virtio.c
@@ -48,18 +48,6 @@
 #define S390_TOD_CLOCK_VALUE_MISSING    0x00
 #define S390_TOD_CLOCK_VALUE_PRESENT    0x01
 
-static S390CPU **cpu_states;
-
-S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
-{
-    if (cpu_addr >= max_cpus) {
-        return NULL;
-    }
-
-    /* Fast lookup via CPU ID */
-    return cpu_states[cpu_addr];
-}
-
 void s390_init_ipl_dev(const char *kernel_filename,
                        const char *kernel_cmdline,
                        const char *initrd_filename,
@@ -86,32 +74,6 @@ void s390_init_ipl_dev(const char *kernel_filename,
     qdev_init_nofail(dev);
 }
 
-void s390_init_cpus(MachineState *machine)
-{
-    int i;
-    gchar *name;
-
-    if (machine->cpu_model == NULL) {
-        machine->cpu_model = s390_default_cpu_model_name();
-    }
-
-    cpu_states = g_new0(S390CPU *, max_cpus);
-
-    for (i = 0; i < max_cpus; i++) {
-        name = g_strdup_printf("cpu[%i]", i);
-        object_property_add_link(OBJECT(machine), name, TYPE_S390_CPU,
-                                 (Object **) &cpu_states[i],
-                                 object_property_allow_set_link,
-                                 OBJ_PROP_LINK_UNREF_ON_RELEASE,
-                                 &error_abort);
-        g_free(name);
-    }
-
-    for (i = 0; i < smp_cpus; i++) {
-        s390x_new_cpu(machine->cpu_model, i, &error_fatal);
-    }
-}
-
 
 void s390_create_virtio_net(BusState *bus, const char *name)
 {
diff --git a/hw/s390x/s390-virtio.h b/hw/s390x/s390-virtio.h
index ca97fd6814..b6660e3ae9 100644
--- a/hw/s390x/s390-virtio.h
+++ b/hw/s390x/s390-virtio.h
@@ -19,7 +19,6 @@
 typedef int (*s390_virtio_fn)(const uint64_t *args);
 void s390_register_virtio_hypercall(uint64_t code, s390_virtio_fn fn);
 
-void s390_init_cpus(MachineState *machine);
 void s390_init_ipl_dev(const char *kernel_filename,
                        const char *kernel_cmdline,
                        const char *initrd_filename,
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 41a9d2862b..4bef28ec39 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -21,11 +21,14 @@
 #define S390_MACHINE_CLASS(klass) \
     OBJECT_CLASS_CHECK(S390CcwMachineClass, (klass), TYPE_S390_CCW_MACHINE)
 
+struct S390CPU;
+
 typedef struct S390CcwMachineState {
     /*< private >*/
     MachineState parent_obj;
 
     /*< public >*/
+    S390CPU **cpus;
     bool aes_key_wrap;
     bool dea_key_wrap;
     uint8_t loadparm[8];
-- 
2.13.5
