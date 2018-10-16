Received: from eggs.gnu.org ([2001:4830:134:3::10]:59956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCTTZ-0004EU-3d
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCTTT-0001EW-W8
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:48 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:41141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCTTT-0001Ds-OS
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:43 -0400
Received: by mail-pf1-x42d.google.com with SMTP id m77-v6so11819454pfi.8
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 10:49:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 16 Oct 2018 10:49:09 -0700
Message-Id: <20181016174911.9052-20-richard.henderson@linaro.org>
In-Reply-To: <20181016174911.9052-1-richard.henderson@linaro.org>
References: <20181016174911.9052-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 19/21] target/s390x: Skip wout,
 cout helpers if op helper does not return
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

When op raises an exception, it may not have initialized the output
temps that would be written back by wout or cout.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/translate.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 18861cd186..a7bd689337 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1128,11 +1128,19 @@ struct DisasInsn {
 
     const char *name;
 
+    /* Pre-process arguments before HELP_OP.  */
     void (*help_in1)(DisasContext *, DisasFields *, DisasOps *);
     void (*help_in2)(DisasContext *, DisasFields *, DisasOps *);
     void (*help_prep)(DisasContext *, DisasFields *, DisasOps *);
+
+    /*
+     * Post-process output after HELP_OP.
+     * Note that these are not called if HELP_OP returns DISAS_NORETURN.
+     */
     void (*help_wout)(DisasContext *, DisasFields *, DisasOps *);
     void (*help_cout)(DisasContext *, DisasOps *);
+
+    /* Implement the operation itself.  */
     DisasJumpType (*help_op)(DisasContext *, DisasOps *);
 
     uint64_t data;
@@ -6125,11 +6133,13 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
     if (insn->help_op) {
         ret = insn->help_op(s, &o);
     }
-    if (insn->help_wout) {
-        insn->help_wout(s, &f, &o);
-    }
-    if (insn->help_cout) {
-        insn->help_cout(s, &o);
+    if (ret != DISAS_NORETURN) {
+        if (insn->help_wout) {
+            insn->help_wout(s, &f, &o);
+        }
+        if (insn->help_cout) {
+            insn->help_cout(s, &o);
+        }
     }
 
     /* Free any temporaries created by the helpers.  */
-- 
2.17.2
