Received: from eggs.gnu.org ([2001:4830:134:3::10]:47173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e4S7i-0004wO-1B
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:41:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e4S7c-00080G-45
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:41:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e4S7b-0007zf-SK
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:41:28 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 17 Oct 2017 15:41:20 +0200
Message-Id: <1508247680-98800-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1508247680-98800-1-git-send-email-imammedo@redhat.com>
References: <1508247680-98800-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] s390x: move s390x_new_cpu() into board code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

s390-virtio-ccw.c is the sole user of s390x_new_cpu(),
so move this helper there.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 target/s390x/cpu.h         |  1 -
 hw/s390x/s390-virtio-ccw.c | 21 +++++++++++++++++++++
 target/s390x/helper.c      | 20 --------------------
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 7e864c8..b177be9 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -695,7 +695,6 @@ void s390_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 
 /* helper.c */
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_S390_CPU, cpu_model)
-S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id, Error **errp);
 
 #define S390_CPU_TYPE_SUFFIX "-" TYPE_S390_CPU
 #define S390_CPU_TYPE_NAME(name) (name S390_CPU_TYPE_SUFFIX)
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 32d3f11..f64db51 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -52,6 +52,27 @@ S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
     return S390_CPU(ms->possible_cpus->cpus[cpu_addr].cpu);
 }
 
+static
+S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id, Error **errp)
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
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 64d4c48..52aa64b 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -68,26 +68,6 @@ void s390x_cpu_timer(void *opaque)
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
2.7.4
