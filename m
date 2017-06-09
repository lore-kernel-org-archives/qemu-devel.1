Received: from eggs.gnu.org ([2001:4830:134:3::10]:33716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dJK3l-0000fg-6K
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dJK3g-0006na-1S
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:34:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dJK3f-0006nS-PI
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:34:35 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri,  9 Jun 2017 15:34:26 +0200
Message-Id: <20170609133426.11447-3-david@redhat.com>
In-Reply-To: <20170609133426.11447-1-david@redhat.com>
References: <20170609133426.11447-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] s390x/cpumodel: wire up cpu type + id
 for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, david@redhat.com

Let's properly expose the CPU type (machine-type number) via "STORE CPU
ID" and "STORE SUBSYSTEM INFORMATION".

As TCG emulates basic mode, the CPU identification number has the format
"Annnnn", whereby A is the CPU address, and n are parts of the CPU serial
number (0 for us for now).

A specification exception will be injected if the address is not aligned
to a double word. Low address protection will not be checked as
we're missing some more general support for that.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h         | 2 +-
 target/s390x/cpu_models.c  | 8 ++++++--
 target/s390x/insn-data.def | 2 +-
 target/s390x/misc_helper.c | 9 ++++++---
 target/s390x/translate.c   | 9 ++-------
 5 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index a4d31df..502d3d7 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -149,7 +149,7 @@ typedef struct CPUS390XState {
     CPU_COMMON
 
     uint32_t cpu_num;
-    uint32_t machine_type;
+    uint64_t cpuid;
 
     uint64_t tod_offset;
     uint64_t tod_basetime;
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index b34318f..c508ae1 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -737,8 +737,6 @@ static inline void apply_cpu_model(const S390CPUModel *model, Error **errp)
 
     if (kvm_enabled()) {
         kvm_s390_apply_cpu_model(model, errp);
-    } else if (model) {
-        /* FIXME TCG - use data for stdip/stfl */
     }
 
     if (!*errp) {
@@ -786,6 +784,12 @@ void s390_realize_cpu_model(CPUState *cs, Error **errp)
     }
 
     apply_cpu_model(cpu->model, errp);
+
+    cpu->env.cpuid = s390_cpuid_from_cpu_model(cpu->model);
+    if (tcg_enabled()) {
+        /* basic mode, write the cpu address into the first 4 bit of the ID */
+        cpu->env.cpuid |= ((uint64_t)cpu->env.cpu_num & 0xf) << 54;
+    }
 }
 
 static void get_feature(Object *obj, Visitor *v, const char *name,
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 73dd05d..d089707 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -960,7 +960,7 @@
 /* STORE CPU ADDRESS */
     C(0xb212, STAP,    S,     Z,   la2, 0, new, m1_16, stap, 0)
 /* STORE CPU ID */
-    C(0xb202, STIDP,   S,     Z,   la2, 0, new, m1_64, stidp, 0)
+    C(0xb202, STIDP,   S,     Z,   la2, 0, new, 0, stidp, 0)
 /* STORE CPU TIMER */
     C(0xb209, STPT,    S,     Z,   la2, 0, new, m1_64, stpt, 0)
 /* STORE FACILITY LIST */
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index edcdf17..75fd13e 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -383,6 +383,7 @@ uint64_t HELPER(stpt)(CPUS390XState *env)
 uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
                       uint64_t r0, uint64_t r1)
 {
+    S390CPU *cpu = s390_env_get_cpu(env);
     int cc = 0;
     int sel1, sel2;
 
@@ -402,12 +403,14 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
         if ((sel1 == 1) && (sel2 == 1)) {
             /* Basic Machine Configuration */
             struct sysib_111 sysib;
+            char type[5] = {};
 
             memset(&sysib, 0, sizeof(sysib));
             ebcdic_put(sysib.manuf, "QEMU            ", 16);
-            /* same as machine type number in STORE CPU ID */
-            ebcdic_put(sysib.type, "QEMU", 4);
-            /* same as model number in STORE CPU ID */
+            /* same as machine type number in STORE CPU ID, but in EBCDIC */
+            snprintf(type, ARRAY_SIZE(type), "%X", cpu->model->def->type);
+            ebcdic_put(sysib.type, type, 4);
+            /* model number (not stored in STORE CPU ID for z/Architecure) */
             ebcdic_put(sysib.model, "QEMU            ", 16);
             ebcdic_put(sysib.sequence, "QEMU            ", 16);
             ebcdic_put(sysib.plant, "QEMU", 4);
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 95f91d4..2f182cc 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3877,14 +3877,9 @@ static ExitStatus op_stctl(DisasContext *s, DisasOps *o)
 
 static ExitStatus op_stidp(DisasContext *s, DisasOps *o)
 {
-    TCGv_i64 t1 = tcg_temp_new_i64();
-
     check_privileged(s);
-    tcg_gen_ld32u_i64(o->out, cpu_env, offsetof(CPUS390XState, cpu_num));
-    tcg_gen_ld32u_i64(t1, cpu_env, offsetof(CPUS390XState, machine_type));
-    tcg_gen_deposit_i64(o->out, o->out, t1, 32, 32);
-    tcg_temp_free_i64(t1);
-
+    tcg_gen_ld_i64(o->out, cpu_env, offsetof(CPUS390XState, cpuid));
+    tcg_gen_qemu_st_i64(o->out, o->addr1, get_mem_index(s), MO_TEQ | MO_ALIGN);
     return NO_EXIT;
 }
 
-- 
2.9.3
