Received: from eggs.gnu.org ([2001:4830:134:3::10]:41287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mbenes@suse.cz>) id 1ciH4D-000834-Ng
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 03:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mbenes@suse.cz>) id 1ciH4A-0001Xd-Mf
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 03:54:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:57338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mbenes@suse.cz>) id 1ciH4A-0001XP-Gm
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 03:53:58 -0500
From: Miroslav Benes <mbenes@suse.cz>
Date: Mon, 27 Feb 2017 09:53:53 +0100
Message-Id: <20170227085353.20787-1-mbenes@suse.cz>
Subject: [Qemu-devel] [PATCH v2] target-s390x: Implement lpp instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, mmarek@suse.com, ebischoff@suse.com, thuth@redhat.com, Miroslav Benes <mbenes@suse.cz>

Linux arch/s390/kernel/head(64).S uses lpp instruction if it is
available in facilities list provided by stfl/stfle instruction. This is
the case of newer z/System generations and their qemu definition.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
v2
- remove potential_page_fault()

 target/s390x/insn-data.def | 2 ++
 target/s390x/translate.c   | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 075ff597c3de..880b0403cb5e 100644
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
index 01c62176bf70..3032d495dcf8 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1194,6 +1194,7 @@ typedef enum DisasFacility {
     FAC_SCF,                /* store clock fast */
     FAC_SFLE,               /* store facility list extended */
     FAC_ILA,                /* interlocked access facility 1 */
+    FAC_LPP,                /* load-program-parameter */
 } DisasFacility;
 
 struct DisasInsn {
@@ -2567,6 +2568,14 @@ static ExitStatus op_lra(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_lpp(DisasContext *s, DisasOps *o)
+{
+    check_privileged(s);
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
