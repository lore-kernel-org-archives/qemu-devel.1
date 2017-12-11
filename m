Received: from eggs.gnu.org ([2001:4830:134:3::10]:43758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOORR-0004ew-SY
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:48:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOORP-0007aY-Cl
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:48:21 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 11 Dec 2017 14:47:34 +0100
Message-Id: <20171211134740.8235-10-david@redhat.com>
In-Reply-To: <20171211134740.8235-1-david@redhat.com>
References: <20171211134740.8235-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2-12 09/15] s390x/tcg: implement TEST
 PENDING INTERRUPTION
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

Use s390_cpu_virt_mem_write() so we can actually revert what we did
(re-inject the dequeued IO interrupt).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  1 +
 target/s390x/misc_helper.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/translate.c   |  8 +++++++
 4 files changed, 63 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 2f17b62d3d..4b0a1d7b1d 100644
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
index 86da6aab7e..8483abeda6 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -429,6 +429,59 @@ void HELPER(stsch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
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
+        } tmp = {
+            .id = cpu_to_be16(io->id),
+            .nr = cpu_to_be16(io->nr),
+            .parm = cpu_to_be32(io->parm),
+        };
+
+        if (s390_cpu_virt_mem_write(cpu, addr, 0, &tmp, sizeof(tmp))) {
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
index eede2ed157..a6d07ae070 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4201,6 +4201,14 @@ static ExitStatus op_stcrw(DisasContext *s, DisasOps *o)
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
2.14.3
