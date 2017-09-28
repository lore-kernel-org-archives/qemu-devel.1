Received: from eggs.gnu.org ([2001:4830:134:3::10]:40844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxZ9V-0006zI-5D
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxZ9R-0002XV-5t
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:46:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52141)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxZ9Q-0002XF-Mr
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:46:53 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 15:46:08 +0200
Message-Id: <20170928134609.16985-5-david@redhat.com>
In-Reply-To: <20170928134609.16985-1-david@redhat.com>
References: <20170928134609.16985-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 4/5] target/s390x: get rid of next_core_id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>

core_id is not needed by linux-user, as the core_id a.k.a. CPU address
is only accessible from kernel space.

Therefore, drop next_core_id and make cpu_index get autoassigned again
for linux-user.

While at it, shield core_id and cpuid completely from linux-user. cpuid
can also only be queried from kernel space.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu-qom.h    |  2 --
 target/s390x/cpu.c        | 14 +++++++-------
 target/s390x/cpu.h        |  2 ++
 target/s390x/cpu_models.c |  2 ++
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
index 2e446fab51..0510c49e07 100644
--- a/target/s390x/cpu-qom.h
+++ b/target/s390x/cpu-qom.h
@@ -54,8 +54,6 @@ typedef struct S390CPUClass {
     bool is_migration_safe;
     const char *desc;
 
-    uint32_t next_core_id;
-
     DeviceRealize parent_realize;
     void (*parent_reset)(CPUState *cpu);
     void (*load_normal)(CPUState *cpu);
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 4920da3625..f42e28ea25 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -178,8 +178,9 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
     S390CPUClass *scc = S390_CPU_GET_CLASS(dev);
+#if !defined(CONFIG_USER_ONLY)
     S390CPU *cpu = S390_CPU(dev);
-    CPUS390XState *env = &cpu->env;
+#endif
     Error *err = NULL;
 
     /* the model has to be realized before qemu_init_vcpu() due to kvm */
@@ -195,11 +196,6 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
                    max_cpus - 1);
         goto out;
     }
-#else
-    /* implicitly set for linux-user only */
-    cpu->env.core_id = scc->next_core_id;
-    scc->next_core_id++;
-#endif
 
     if (cpu_exists(cpu->env.core_id)) {
         error_setg(&err, "Unable to add CPU with core-id: %" PRIu32
@@ -208,7 +204,9 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     /* sync cs->cpu_index and env->core_id. The latter is needed for TCG. */
-    cs->cpu_index = env->core_id;
+    cs->cpu_index = cpu->env.core_id;
+#endif
+
     cpu_exec_realizefn(cs, &err);
     if (err != NULL) {
         goto out;
@@ -440,7 +438,9 @@ static gchar *s390_gdb_arch_name(CPUState *cs)
 }
 
 static Property s390x_cpu_properties[] = {
+#if !defined(CONFIG_USER_ONLY)
     DEFINE_PROP_UINT32("core-id", S390CPU, env.core_id, 0),
+#endif
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index c57ef71f6d..ff3cc59c02 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -151,8 +151,10 @@ struct CPUS390XState {
 
     CPU_COMMON
 
+#if !defined(CONFIG_USER_ONLY)
     uint32_t core_id; /* PoP "CPU address", same as cpu_index */
     uint64_t cpuid;
+#endif
 
     uint64_t tod_offset;
     uint64_t tod_basetime;
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 48dd7beddd..07ef8a3b6e 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -945,11 +945,13 @@ void s390_realize_cpu_model(CPUState *cs, Error **errp)
 
     apply_cpu_model(cpu->model, errp);
 
+#if !defined(CONFIG_USER_ONLY)
     cpu->env.cpuid = s390_cpuid_from_cpu_model(cpu->model);
     if (tcg_enabled()) {
         /* basic mode, write the cpu address into the first 4 bit of the ID */
         cpu->env.cpuid = deposit64(cpu->env.cpuid, 54, 4, cpu->env.core_id);
     }
+#endif
 }
 
 static void get_feature(Object *obj, Visitor *v, const char *name,
-- 
2.13.5
