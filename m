Received: from eggs.gnu.org ([2001:4830:134:3::10]:40018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dKsP8-00037J-TK
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dKsP7-000442-Q8
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:27:10 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dKsP7-00043p-Kp
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:27:09 -0400
Received: by mail-qt0-x241.google.com with SMTP id s33so37659243qtg.3
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 13:27:09 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 13 Jun 2017 13:26:59 -0700
Message-Id: <20170613202659.1920-4-rth@twiddle.net>
In-Reply-To: <20170613202659.1920-1-rth@twiddle.net>
References: <20170613202659.1920-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 3/3] s390x/cpumodel: wire up cpu type + id for
 TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Let's properly expose the CPU type (machine-type number) via "STORE CPU
ID" and "STORE SUBSYSTEM INFORMATION".

As TCG emulates basic mode, the CPU identification number has the format
"Annnnn", whereby A is the CPU address, and n are parts of the CPU serial
number (0 for us for now).

A specification exception will be injected if the address is not aligned
to a double word. Low address protection will not be checked as
we're missing some more general support for that.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170609133426.11447-3-david@redhat.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/cpu.h         | 2 +-
 target/s390x/cpu_models.c  | 8 ++++++--
 target/s390x/insn-data.def | 2 +-
 target/s390x/misc_helper.c | 9 ++++++---
 target/s390x/translate.c   | 9 ++-------
 5 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 2954974..a4028fb 100644
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
index b34318f..478bcc6 100644
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
+        cpu->env.cpuid = deposit64(cpu->env.cpuid, 54, 4, cpu->env.cpu_num);
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
index 4daa016..b508101 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -378,6 +378,7 @@ uint64_t HELPER(stpt)(CPUS390XState *env)
 uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
                       uint64_t r0, uint64_t r1)
 {
+    S390CPU *cpu = s390_env_get_cpu(env);
     int cc = 0;
     int sel1, sel2;
 
@@ -397,12 +398,14 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
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
index d2917e4..8c055b7 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3876,14 +3876,9 @@ static ExitStatus op_stctl(DisasContext *s, DisasOps *o)
 
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
2.9.4
