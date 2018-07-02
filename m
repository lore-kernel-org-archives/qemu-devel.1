Received: from eggs.gnu.org ([2001:4830:134:3::10]:43859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fZwqW-0002Ex-Qi
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fZwqU-0006De-5S
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:18:16 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  2 Jul 2018 13:17:32 +0200
Message-Id: <20180702111737.18970-11-cohuck@redhat.com>
In-Reply-To: <20180702111737.18970-1-cohuck@redhat.com>
References: <20180702111737.18970-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 10/15] s390x/tcg: implement SET CLOCK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

This allows a guest to change its TOD. We already take care of updating
all CKC timers from within S390TODClass.

Use MO_ALIGN to load the operand manually - this will properly trigger a
SPECIFICATION exception.

Acked-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180627134410.4901-8-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  3 +--
 target/s390x/misc_helper.c | 16 ++++++++++++++++
 target/s390x/translate.c   |  9 +++++++++
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 59cba86a27..97c60ca7bc 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -127,6 +127,7 @@ DEF_HELPER_4(diag, void, env, i32, i32, i32)
 DEF_HELPER_3(load_psw, noreturn, env, i64, i64)
 DEF_HELPER_FLAGS_2(spx, TCG_CALL_NO_RWG, void, env, i64)
 DEF_HELPER_FLAGS_1(stck, TCG_CALL_NO_RWG_SE, i64, env)
+DEF_HELPER_FLAGS_2(sck, TCG_CALL_NO_RWG, i32, env, i64)
 DEF_HELPER_FLAGS_2(sckc, TCG_CALL_NO_RWG, void, env, i64)
 DEF_HELPER_FLAGS_2(sckpf, TCG_CALL_NO_RWG, void, env, i64)
 DEF_HELPER_FLAGS_1(stckc, TCG_CALL_NO_RWG, i64, env)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 157619403d..5c6f33ed9c 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -997,8 +997,7 @@
 /* SET ADDRESS SPACE CONTROL FAST */
     C(0xb279, SACF,    S,     Z,   0, a2, 0, 0, sacf, 0)
 /* SET CLOCK */
-    /* ??? Not implemented - is it necessary? */
-    C(0xb204, SCK,     S,     Z,   0, 0, 0, 0, 0, 0)
+    C(0xb204, SCK,     S,     Z,   la2, 0, 0, 0, sck, 0)
 /* SET CLOCK COMPARATOR */
     C(0xb206, SCKC,    S,     Z,   0, m2_64a, 0, 0, sckc, 0)
 /* SET CLOCK PROGRAMMABLE FIELD */
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index e4c1522140..7656a9b90a 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -184,6 +184,22 @@ void tcg_s390_tod_updated(CPUState *cs, run_on_cpu_data opaque)
     helper_sckc(env, env->ckc);
 }
 
+/* Set Clock */
+uint32_t HELPER(sck)(CPUS390XState *env, uint64_t tod_low)
+{
+    S390TODState *td = s390_get_todstate();
+    S390TODClass *tdc = S390_TOD_GET_CLASS(td);
+    S390TOD tod = {
+        .high = 0,
+        .low = tod_low,
+    };
+
+    qemu_mutex_lock_iothread();
+    tdc->set(td, &tod, &error_abort);
+    qemu_mutex_unlock_iothread();
+    return 0;
+}
+
 /* Set Tod Programmable Field */
 void HELPER(sckpf)(CPUS390XState *env, uint64_t r0)
 {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index fdfec7feba..57c03cbf58 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4016,6 +4016,15 @@ static DisasJumpType op_stcke(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
+static DisasJumpType op_sck(DisasContext *s, DisasOps *o)
+{
+    check_privileged(s);
+    tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), MO_TEQ | MO_ALIGN);
+    gen_helper_sck(cc_op, cpu_env, o->in1);
+    set_cc_static(s);
+    return DISAS_NEXT;
+}
+
 static DisasJumpType op_sckc(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-- 
2.14.4
