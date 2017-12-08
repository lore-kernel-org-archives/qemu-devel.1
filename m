Received: from eggs.gnu.org ([2001:4830:134:3::10]:39011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNL6Y-0002Ut-24
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:02:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNL6U-0005MF-Uh
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:02:26 -0500
From: David Hildenbrand <david@redhat.com>
Date: Fri,  8 Dec 2017 17:01:56 +0100
Message-Id: <20171208160207.26494-4-david@redhat.com>
In-Reply-To: <20171208160207.26494-1-david@redhat.com>
References: <20171208160207.26494-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-2.12 03/14] s390x/tcg: implement SET
 CLOCK PROGRAMMABLE FIELD
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

Needed for machine check handling inside Linux (when restoring registers).

Except for SIGP and machine checks, we don't make use of the register
yet. Sufficient for now.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  2 ++
 target/s390x/misc_helper.c | 11 +++++++++++
 target/s390x/translate.c   |  7 +++++++
 4 files changed, 21 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 9459b73c73..3eb7715e5b 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -127,6 +127,7 @@ DEF_HELPER_3(load_psw, noreturn, env, i64, i64)
 DEF_HELPER_FLAGS_2(spx, TCG_CALL_NO_RWG, void, env, i64)
 DEF_HELPER_FLAGS_1(stck, TCG_CALL_NO_RWG_SE, i64, env)
 DEF_HELPER_FLAGS_2(sckc, TCG_CALL_NO_RWG, void, env, i64)
+DEF_HELPER_FLAGS_2(sckpf, TCG_CALL_NO_RWG, void, env, i64)
 DEF_HELPER_FLAGS_1(stckc, TCG_CALL_NO_RWG, i64, env)
 DEF_HELPER_FLAGS_2(spt, TCG_CALL_NO_RWG, void, env, i64)
 DEF_HELPER_FLAGS_1(stpt, TCG_CALL_NO_RWG, i64, env)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 16e27c8a35..8c2541f545 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -999,6 +999,8 @@
     C(0xb204, SCK,     S,     Z,   0, 0, 0, 0, 0, 0)
 /* SET CLOCK COMPARATOR */
     C(0xb206, SCKC,    S,     Z,   0, m2_64, 0, 0, sckc, 0)
+/* SET CLOCK PROGRAMMABLE FIELD */
+    C(0x0107, SCKPF,   E,     Z,   0, 0, 0, 0, sckpf, 0)
 /* SET CPU TIMER */
     C(0xb208, SPT,     S,     Z,   0, m2_64, 0, 0, spt, 0)
 /* SET PREFIX */
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 6d766ce1e7..769ec52e1d 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -146,6 +146,17 @@ void HELPER(sckc)(CPUS390XState *env, uint64_t time)
     timer_mod(env->tod_timer, env->tod_basetime + time);
 }
 
+/* Set Tod Programmable Field */
+void HELPER(sckpf)(CPUS390XState *env, uint64_t r0)
+{
+    uint32_t val = r0;
+
+    if (val & 0xffff0000) {
+        s390_program_interrupt(env, PGM_SPECIFICATION, 2, GETPC());
+    }
+    env->todpr = val;
+}
+
 /* Store Clock Comparator */
 uint64_t HELPER(stckc)(CPUS390XState *env)
 {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 26cf993405..d13f531c5b 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3922,6 +3922,13 @@ static ExitStatus op_sckc(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_sckpf(DisasContext *s, DisasOps *o)
+{
+    check_privileged(s);
+    gen_helper_sckpf(cpu_env, regs[0]);
+    return NO_EXIT;
+}
+
 static ExitStatus op_stckc(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-- 
2.14.3
