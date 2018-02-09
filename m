Received: from eggs.gnu.org ([2001:4830:134:3::10]:43430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wM-00020t-1x
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:25:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wK-00062w-Jl
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:25:53 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  9 Feb 2018 10:25:05 +0100
Message-Id: <20180209092524.31348-11-cohuck@redhat.com>
In-Reply-To: <20180209092524.31348-1-cohuck@redhat.com>
References: <20180209092524.31348-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 10/29] s390x/tcg: implement TEST PENDING
 INTERRUPTION
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Use s390_cpu_virt_mem_write() so we can actually revert what we did
(re-inject the dequeued IO interrupt).

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180129125623.21729-10-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  1 +
 target/s390x/misc_helper.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/translate.c   |  8 +++++++
 4 files changed, 64 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 59a1d9869b..05d52ff309 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -170,6 +170,7 @@ DEF_HELPER_4(schm, void, env, i64, i64, i64)
 DEF_HELPER_3(ssch, void, env, i64, i64)
 DEF_HELPER_2(stcrw, void, env, i64)
 DEF_HELPER_3(stsch, void, env, i64, i64)
+DEF_HELPER_2(tpi, i32, env, i64)
 DEF_HELPER_3(tsch, void, env, i64, i64)
 DEF_HELPER_2(chsc, void, env, i64)
 #endif
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 11ee43dcbc..c06c3884c0 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1063,6 +1063,7 @@
     C(0xb233, SSCH,    S,     Z,   0, insn, 0, 0, ssch, 0)
     C(0xb239, STCRW,   S,     Z,   0, insn, 0, 0, stcrw, 0)
     C(0xb234, STSCH,   S,     Z,   0, insn, 0, 0, stsch, 0)
+    C(0xb236, TPI ,    S,     Z,   la2, 0, 0, 0, tpi, 0)
     C(0xb235, TSCH,    S,     Z,   0, insn, 0, 0, tsch, 0)
     /* ??? Not listed in PoO ninth edition, but there's a linux driver that
        uses it: "A CHSC subchannel is usually present on LPAR only."  */
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 86da6aab7e..6ee7e8a64a 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -36,6 +36,7 @@
 #include "hw/s390x/ebcdic.h"
 #include "hw/s390x/s390-virtio-hcall.h"
 #include "hw/s390x/sclp.h"
+#include "hw/s390x/s390_flic.h"
 #endif
 
 /* #define DEBUG_HELPER */
@@ -429,6 +430,59 @@ void HELPER(stsch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
     qemu_mutex_unlock_iothread();
 }
 
+uint32_t HELPER(tpi)(CPUS390XState *env, uint64_t addr)
+{
+    const uintptr_t ra = GETPC();
+    S390CPU *cpu = s390_env_get_cpu(env);
+    QEMUS390FLICState *flic = QEMU_S390_FLIC(s390_get_flic());
+    QEMUS390FlicIO *io = NULL;
+    LowCore *lowcore;
+
+    if (addr & 0x3) {
+        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
+    }
+
+    qemu_mutex_lock_iothread();
+    io = qemu_s390_flic_dequeue_io(flic, env->cregs[6]);
+    if (!io) {
+        qemu_mutex_unlock_iothread();
+        return 0;
+    }
+
+    if (addr) {
+        struct {
+            uint16_t id;
+            uint16_t nr;
+            uint32_t parm;
+        } intc = {
+            .id = cpu_to_be16(io->id),
+            .nr = cpu_to_be16(io->nr),
+            .parm = cpu_to_be32(io->parm),
+        };
+
+        if (s390_cpu_virt_mem_write(cpu, addr, 0, &intc, sizeof(intc))) {
+            /* writing failed, reinject and properly clean up */
+            s390_io_interrupt(io->id, io->nr, io->parm, io->word);
+            qemu_mutex_unlock_iothread();
+            g_free(io);
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
+            return 0;
+        }
+    } else {
+        /* no protection applies */
+        lowcore = cpu_map_lowcore(env);
+        lowcore->subchannel_id = cpu_to_be16(io->id);
+        lowcore->subchannel_nr = cpu_to_be16(io->nr);
+        lowcore->io_int_parm = cpu_to_be32(io->parm);
+        lowcore->io_int_word = cpu_to_be32(io->word);
+        cpu_unmap_lowcore(lowcore);
+    }
+
+    g_free(io);
+    qemu_mutex_unlock_iothread();
+    return 1;
+}
+
 void HELPER(tsch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index df0b41606d..81abe40673 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4199,6 +4199,14 @@ static ExitStatus op_stcrw(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_tpi(DisasContext *s, DisasOps *o)
+{
+    check_privileged(s);
+    gen_helper_tpi(cc_op, cpu_env, o->addr1);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
 static ExitStatus op_tsch(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-- 
2.13.6
