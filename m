Received: from eggs.gnu.org ([2001:4830:134:3::10]:48235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e4TYh-0002wL-3Y
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e4TYc-0008Lg-TI
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:13:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e4TYc-0008Kx-KM
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:13:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B9B5B806A2
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 15:13:25 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 17 Oct 2017 17:13:23 +0200
Message-Id: <1508253203-119237-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <20171017162927.5ee8b9cd.cohuck@redhat.com>
References: <20171017162927.5ee8b9cd.cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] s390x: move s390x_new_cpu() into board
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>

s390-virtio-ccw.c is the sole user of s390x_new_cpu(),
so move this helper there.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Cornelia Huck <cohuck@redhat.com>

v2:
 - style fix: wrap the argument list

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
index 32d3f11..e593c71 100644
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
