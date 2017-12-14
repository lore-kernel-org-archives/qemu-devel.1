Received: from eggs.gnu.org ([2001:4830:134:3::10]:56472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX4D-0001c2-P6
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:13:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX4C-0000B4-GY
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:13:05 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 14 Dec 2017 18:09:58 +0100
Message-Id: <20171214171004.25058-41-cohuck@redhat.com>
In-Reply-To: <20171214171004.25058-1-cohuck@redhat.com>
References: <20171214171004.25058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 40/46] s390x/tcg: wire up SET CHANNEL MONITOR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Let's just wire it up like KVM.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20171208160207.26494-10-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/helper.h      | 1 +
 target/s390x/insn-data.def | 1 +
 target/s390x/misc_helper.c | 9 +++++++++
 target/s390x/translate.c   | 7 +++++++
 4 files changed, 18 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index f1acc34f36..102fbdd7b9 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -166,6 +166,7 @@ DEF_HELPER_3(msch, void, env, i64, i64)
 DEF_HELPER_2(rchp, void, env, i64)
 DEF_HELPER_2(rsch, void, env, i64)
 DEF_HELPER_2(sal, void, env, i64)
+DEF_HELPER_4(schm, void, env, i64, i64, i64)
 DEF_HELPER_3(ssch, void, env, i64, i64)
 DEF_HELPER_2(stcrw, void, env, i64)
 DEF_HELPER_3(stsch, void, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 11746f5298..0c225d5e78 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1055,6 +1055,7 @@
     C(0xb23b, RCHP,    S,     Z,   0, 0, 0, 0, rchp, 0)
     C(0xb238, RSCH,    S,     Z,   0, 0, 0, 0, rsch, 0)
     C(0xb237, SAL,     S,     Z,   0, 0, 0, 0, sal, 0)
+    C(0xb23c, SCHM,    S,     Z,   0, insn, 0, 0, schm, 0)
     C(0xb233, SSCH,    S,     Z,   0, insn, 0, 0, ssch, 0)
     C(0xb239, STCRW,   S,     Z,   0, insn, 0, 0, stcrw, 0)
     C(0xb234, STSCH,   S,     Z,   0, insn, 0, 0, stsch, 0)
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 1941c9c3de..7ddade2f0e 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -386,6 +386,15 @@ void HELPER(sal)(CPUS390XState *env, uint64_t r1)
     qemu_mutex_unlock_iothread();
 }
 
+void HELPER(schm)(CPUS390XState *env, uint64_t r1, uint64_t r2, uint64_t inst)
+{
+    S390CPU *cpu = s390_env_get_cpu(env);
+
+    qemu_mutex_lock_iothread();
+    ioinst_handle_schm(cpu, r1, r2, inst >> 16, GETPC());
+    qemu_mutex_unlock_iothread();
+}
+
 void HELPER(ssch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 30d3d767ea..8cf35a7b49 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4125,6 +4125,13 @@ static ExitStatus op_sal(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_schm(DisasContext *s, DisasOps *o)
+{
+    check_privileged(s);
+    gen_helper_schm(cpu_env, regs[1], regs[2], o->in2);
+    return NO_EXIT;
+}
+
 static ExitStatus op_ssch(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-- 
2.13.6
