Received: from eggs.gnu.org ([2001:4830:134:3::10]:59488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VuS-0003X1-Hk
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:56:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VuR-0003x6-KT
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:56:16 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:54:08 +0200
Message-Id: <20171020115418.2050-37-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 36/46] s390x: move s390x_new_cpu() into board
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Igor Mammedov <imammedo@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

s390-virtio-ccw.c is the sole user of s390x_new_cpu(),
so move this helper there.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1508253203-119237-1-git-send-email-imammedo@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 21 +++++++++++++++++++++
 target/s390x/cpu.h         |  1 -
 target/s390x/helper.c      | 20 --------------------
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index e4474587aa..baeafdcb1c 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -52,6 +52,27 @@ S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
     return S390_CPU(ms->possible_cpus->cpus[cpu_addr].cpu);
 }
 
+static S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id,
+                              Error **errp)
+{
+    S390CPU *cpu = S390_CPU(object_new(typename));
+    Error *err = NULL;
+
+    object_property_set_int(OBJECT(cpu), core_id, "core-id", &err);
+    if (err != NULL) {
+        goto out;
+    }
+    object_property_set_bool(OBJECT(cpu), true, "realized", &err);
+
+out:
+    object_unref(OBJECT(cpu));
+    if (err) {
+        error_propagate(errp, err);
+        cpu = NULL;
+    }
+    return cpu;
+}
+
 static void s390_init_cpus(MachineState *machine)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index b684502900..4db8b5409e 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -702,7 +702,6 @@ void s390_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 
 /* helper.c */
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_S390_CPU, cpu_model)
-S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id, Error **errp);
 
 #define S390_CPU_TYPE_SUFFIX "-" TYPE_S390_CPU
 #define S390_CPU_TYPE_NAME(name) (name S390_CPU_TYPE_SUFFIX)
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 9ff7ff4acc..f78983dd6a 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -61,26 +61,6 @@ void s390x_cpu_timer(void *opaque)
 }
 #endif
 
-S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id, Error **errp)
-{
-    S390CPU *cpu = S390_CPU(object_new(typename));
-    Error *err = NULL;
-
-    object_property_set_int(OBJECT(cpu), core_id, "core-id", &err);
-    if (err != NULL) {
-        goto out;
-    }
-    object_property_set_bool(OBJECT(cpu), true, "realized", &err);
-
-out:
-    object_unref(OBJECT(cpu));
-    if (err) {
-        error_propagate(errp, err);
-        cpu = NULL;
-    }
-    return cpu;
-}
-
 #ifndef CONFIG_USER_ONLY
 
 hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr vaddr)
-- 
2.13.6
