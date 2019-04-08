Received: from eggs.gnu.org ([209.51.188.92]:58377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hDZ0N-0007ae-Go
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hDZ0M-0007DX-KK
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:27 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:32918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hDZ0M-0007D7-Cg
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:26 -0400
Received: by mail-ot1-x341.google.com with SMTP id j10so13142277otq.0
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 11:28:26 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
Date: Mon,  8 Apr 2019 14:27:47 -0400
Message-Id: <20190408182748.1238-5-jan.bobek@gmail.com>
In-Reply-To: <20190408182748.1238-1-jan.bobek@gmail.com>
References: <20190408182748.1238-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 4/5] risu_i386: implement missing
 CPU-specific functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Bobek <jan.bobek@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

risu_i386.c is expected to implement the following functions:

- advance_pc
- get_reginfo_paramreg, set_ucontext_paramreg
- get_risuop
- get_pc

This patch adds the necessary code. (We use EAX as the parameter
register.)

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risu_i386.c         | 31 ++++++++++++++++++++++++++++++-
 risu_reginfo_i386.h |  1 +
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/risu_i386.c b/risu_i386.c
index 2d2f325..eb4dff4 100644
--- a/risu_i386.c
+++ b/risu_i386.c
@@ -25,14 +25,43 @@ static int insn_is_ud2(uint32_t insn)
 
 void advance_pc(void *vuc)
 {
+    ucontext_t *uc = (ucontext_t *) vuc;
+
     /* We assume that this is either UD1 or UD2.
      * This would need tweaking if we want to test
      * expected undefs on x86.
      */
-    ucontext_t *uc = vuc;
     uc->uc_mcontext.gregs[REG_EIP] += 2;
 }
 
+void set_ucontext_paramreg(void *vuc, uint64_t value)
+{
+    ucontext_t *uc = (ucontext_t *) vuc;
+    uc->uc_mcontext.gregs[REG_EAX] = (uint32_t) value;
+}
+
+uint64_t get_reginfo_paramreg(struct reginfo *ri)
+{
+    return ri->gregs[REG_EAX];
+}
+
+int get_risuop(struct reginfo *ri)
+{
+    switch (ri->faulting_insn & 0xffff) {
+    case 0xb90f:                /* UD1 */
+        return OP_COMPARE;
+    case 0x0b0f:                /* UD2 */
+        return OP_TESTEND;
+    default:                    /* unexpected */
+        return -1;
+    }
+}
+
+uintptr_t get_pc(struct reginfo *ri)
+{
+    return ri->gregs[REG_EIP];
+}
+
 int send_register_info(int sock, void *uc)
 {
     struct reginfo ri;
diff --git a/risu_reginfo_i386.h b/risu_reginfo_i386.h
index 5bba439..4ad90e1 100644
--- a/risu_reginfo_i386.h
+++ b/risu_reginfo_i386.h
@@ -28,6 +28,7 @@ struct reginfo {
 #   define REG_ES      2
 #   define REG_DS      3
 #   define REG_ESP     7
+#   define REG_EAX    11
 #   define REG_TRAPNO 12
 #   define REG_EIP    14
 #   define REG_EFL    16
-- 
2.20.1
