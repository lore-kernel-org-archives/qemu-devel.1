Received: from eggs.gnu.org ([2001:4830:134:3::10]:41340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eMy9f-0000F6-Ho
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:32:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eMy9Z-0002LV-RG
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:32:07 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Dec 2017 16:31:41 +0100
Message-Id: <20171207153141.15523-6-david@redhat.com>
In-Reply-To: <20171207153141.15523-1-david@redhat.com>
References: <20171207153141.15523-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.12 5/5] s390x/tcg: wire up STORE
 CHANNEL REPORT WORD
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

CRW machine check handling requires STCRW. So let's wire it up.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h      | 1 +
 target/s390x/insn-data.def | 1 +
 target/s390x/misc_helper.c | 9 +++++++++
 target/s390x/translate.c   | 8 ++++++++
 4 files changed, 19 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 0281c286b8..2ce57edc14 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -166,6 +166,7 @@ DEF_HELPER_3(msch, void, env, i64, i64)
 DEF_HELPER_2(rchp, void, env, i64)
 DEF_HELPER_2(rsch, void, env, i64)
 DEF_HELPER_3(ssch, void, env, i64, i64)
+DEF_HELPER_2(stcrw, void, env, i64)
 DEF_HELPER_3(stsch, void, env, i64, i64)
 DEF_HELPER_3(tsch, void, env, i64, i64)
 DEF_HELPER_2(chsc, void, env, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 8c2541f545..43ab1963c8 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1055,6 +1055,7 @@
     C(0xb23b, RCHP,    S,     Z,   0, 0, 0, 0, rchp, 0)
     C(0xb238, RSCH,    S,     Z,   0, 0, 0, 0, rsch, 0)
     C(0xb233, SSCH,    S,     Z,   0, insn, 0, 0, ssch, 0)
+    C(0xb239, STCRW,   S,     Z,   0, insn, 0, 0, stcrw, 0)
     C(0xb234, STSCH,   S,     Z,   0, insn, 0, 0, stsch, 0)
     C(0xb235, TSCH,    S,     Z,   0, insn, 0, 0, tsch, 0)
     /* ??? Not listed in PoO ninth edition, but there's a linux driver that
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 25b71f08ee..3541e47114 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -385,6 +385,15 @@ void HELPER(ssch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
     qemu_mutex_unlock_iothread();
 }
 
+void HELPER(stcrw)(CPUS390XState *env, uint64_t inst)
+{
+    S390CPU *cpu = s390_env_get_cpu(env);
+
+    qemu_mutex_lock_iothread();
+    ioinst_handle_stcrw(cpu, inst >> 16, GETPC());
+    qemu_mutex_unlock_iothread();
+}
+
 void HELPER(stsch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 8da8610839..5e051fdd03 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4071,6 +4071,14 @@ static ExitStatus op_stsch(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_stcrw(DisasContext *s, DisasOps *o)
+{
+    check_privileged(s);
+    gen_helper_stcrw(cpu_env, o->in2);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
 static ExitStatus op_tsch(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-- 
2.14.3
