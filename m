Received: from eggs.gnu.org ([2001:4830:134:3::10]:45566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9KAV-0001BR-7k
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:40:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9KAT-0003yE-Sd
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:40:19 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d9KAT-0003xO-OS
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:40:17 -0400
Received: by mail-qk0-x243.google.com with SMTP id u75so9817189qka.1
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 16:40:17 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 12 May 2017 16:40:02 -0700
Message-Id: <20170512234009.32557-3-rth@twiddle.net>
In-Reply-To: <20170512234009.32557-1-rth@twiddle.net>
References: <20170512234009.32557-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 2/9] target/s390x: Implement LOAD PROGRAM
 PARAMETER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Miroslav Benes <mbenes@suse.cz>

From: Miroslav Benes <mbenes@suse.cz>

Linux arch/s390/kernel/head(64).S uses LPP instruction if it is
available in facilities list provided by stfl/stfle instruction.
This is the case of newer z/System generations and their qemu
definition.

The description of LPP is at
http://www-01.ibm.com/support/docview.wss?uid=isg26fcd1cc32246f4c8852574ce0044734a

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Miroslav Benes <mbenes@suse.cz>
Message-Id: <20170227085353.20787-1-mbenes@suse.cz>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/insn-data.def | 2 ++
 target/s390x/translate.c   | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index b6702da..43c5707 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -845,6 +845,8 @@
 /* LOAD CONTROL */
     C(0xb700, LCTL,    RS_a,  Z,   0, a2, 0, 0, lctl, 0)
     C(0xeb2f, LCTLG,   RSY_a, Z,   0, a2, 0, 0, lctlg, 0)
+/* LOAD PROGRAM PARAMETER */
+    C(0xb280, LPP,     S,   LPP,   0, m2_64, 0, 0, lpp, 0)
 /* LOAD PSW */
     C(0x8200, LPSW,    S,     Z,   0, a2, 0, 0, lpsw, 0)
 /* LOAD PSW EXTENDED */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 69940e3..2b66a4e 100644
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
2.9.3
