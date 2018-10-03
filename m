Received: from eggs.gnu.org ([2001:4830:134:3::10]:59475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7n05-0001gD-00
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 15:40:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7n03-00025y-A0
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 15:40:00 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831]:33366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g7n02-00024f-Tk
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 15:39:59 -0400
Received: by mail-qt1-x831.google.com with SMTP id q40-v6so7323292qte.0
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 12:39:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Oct 2018 14:39:30 -0500
Message-Id: <20181003193931.18096-9-richard.henderson@linaro.org>
In-Reply-To: <20181003193931.18096-1-richard.henderson@linaro.org>
References: <20181003193931.18096-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 8/9] target/s390x: Skip wout,
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
Cc: qemu-s390x@nongnu.org

When op raises an exception, it may not have initialized the output
temps that would be written back by wout or cout.

Cc: qemu-s390x@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/translate.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 7363aabf3a..7fad3ad8e9 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -6164,11 +6164,13 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
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
2.17.1
