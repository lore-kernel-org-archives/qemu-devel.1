Received: from eggs.gnu.org ([2001:4830:134:3::10]:39175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNL6l-000302-Pr
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:02:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNL6k-0005SI-Tu
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:02:39 -0500
From: David Hildenbrand <david@redhat.com>
Date: Fri,  8 Dec 2017 17:02:01 +0100
Message-Id: <20171208160207.26494-9-david@redhat.com>
In-Reply-To: <20171208160207.26494-1-david@redhat.com>
References: <20171208160207.26494-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-2.12 08/14] s390x/tcg: wire up SET
 ADDRESS LIMIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

Let's handle it just like KVM:
    Depending on the model, this instruction may not be
    provided. When this instruction is not provided, it is
    checked for operand exception and privileged-opera-
    tion exception, and then is suppressed.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h      | 1 +
 target/s390x/insn-data.def | 1 +
 target/s390x/misc_helper.c | 9 +++++++++
 target/s390x/translate.c   | 7 +++++++
 4 files changed, 18 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index ba11cfdc30..f1acc34f36 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -165,6 +165,7 @@ DEF_HELPER_2(hsch, void, env, i64)
 DEF_HELPER_3(msch, void, env, i64, i64)
 DEF_HELPER_2(rchp, void, env, i64)
 DEF_HELPER_2(rsch, void, env, i64)
+DEF_HELPER_2(sal, void, env, i64)
 DEF_HELPER_3(ssch, void, env, i64, i64)
 DEF_HELPER_2(stcrw, void, env, i64)
 DEF_HELPER_3(stsch, void, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 6cbd604814..11746f5298 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1054,6 +1054,7 @@
     C(0xb232, MSCH,    S,     Z,   0, insn, 0, 0, msch, 0)
     C(0xb23b, RCHP,    S,     Z,   0, 0, 0, 0, rchp, 0)
     C(0xb238, RSCH,    S,     Z,   0, 0, 0, 0, rsch, 0)
+    C(0xb237, SAL,     S,     Z,   0, 0, 0, 0, sal, 0)
     C(0xb233, SSCH,    S,     Z,   0, insn, 0, 0, ssch, 0)
     C(0xb239, STCRW,   S,     Z,   0, insn, 0, 0, stcrw, 0)
     C(0xb234, STSCH,   S,     Z,   0, insn, 0, 0, stsch, 0)
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 04fb53d8a3..1941c9c3de 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -377,6 +377,15 @@ void HELPER(rsch)(CPUS390XState *env, uint64_t r1)
     qemu_mutex_unlock_iothread();
 }
 
+void HELPER(sal)(CPUS390XState *env, uint64_t r1)
+{
+    S390CPU *cpu = s390_env_get_cpu(env);
+
+    qemu_mutex_lock_iothread();
+    ioinst_handle_sal(cpu, r1, GETPC());
+    qemu_mutex_unlock_iothread();
+}
+
 void HELPER(ssch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index de00b9471a..30d3d767ea 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4118,6 +4118,13 @@ static ExitStatus op_rsch(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_sal(DisasContext *s, DisasOps *o)
+{
+    check_privileged(s);
+    gen_helper_sal(cpu_env, regs[1]);
+    return NO_EXIT;
+}
+
 static ExitStatus op_ssch(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-- 
2.14.3
