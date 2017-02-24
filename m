Received: from eggs.gnu.org ([2001:4830:134:3::10]:33919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mbenes@suse.cz>) id 1chGGs-0002rj-Pc
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:50:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mbenes@suse.cz>) id 1chGGn-00045H-Lv
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:50:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:45024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mbenes@suse.cz>) id 1chGGn-00044l-Ff
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:50:49 -0500
From: Miroslav Benes <mbenes@suse.cz>
Date: Fri, 24 Feb 2017 14:50:45 +0100
Message-Id: <20170224135045.10613-1-mbenes@suse.cz>
Subject: [Qemu-devel] [PATCH] target-s390x: Implement lpp instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, mmarek@suse.com, ebischoff@suse.com, Miroslav Benes <mbenes@suse.cz>

Linux arch/s390/kernel/head(64).S uses lpp instruction if it is
available in facilities list provided by stfl/stfle instruction. This is
the case of newer z/System generations and their qemu definition.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
 target/s390x/insn-data.def |  2 ++
 target/s390x/translate.c   | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index be830a42ed8d..d6dd391fabeb 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -843,6 +843,8 @@
 /* LOAD CONTROL */
     C(0xb700, LCTL,    RS_a,  Z,   0, a2, 0, 0, lctl, 0)
     C(0xeb2f, LCTLG,   RSY_a, Z,   0, a2, 0, 0, lctlg, 0)
+/* LOAD PROGRAM PARAMETER */
+    C(0xb280, LPP,     S,   LPP,   0, m2_64, 0, 0, lpp, 0)
 /* LOAD PSW */
     C(0x8200, LPSW,    S,     Z,   0, a2, 0, 0, lpsw, 0)
 /* LOAD PSW EXTENDED */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 141167948ee8..eb9e13e59b7d 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1194,6 +1194,7 @@ typedef enum DisasFacility {
     FAC_SCF,                /* store clock fast */
     FAC_SFLE,               /* store facility list extended */
     FAC_ILA,                /* interlocked access facility 1 */
+    FAC_LPP,                /* load-program-parameter */
 } DisasFacility;
 
 struct DisasInsn {
@@ -2567,6 +2568,15 @@ static ExitStatus op_lra(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_lpp(DisasContext *s, DisasOps *o)
+{
+    check_privileged(s);
+    potential_page_fault(s);
+
+    tcg_gen_st_i64(o->in2, cpu_env, offsetof(CPUS390XState, pp));
+    return NO_EXIT;
+}
+
 static ExitStatus op_lpsw(DisasContext *s, DisasOps *o)
 {
     TCGv_i64 t1, t2;
-- 
2.11.0
