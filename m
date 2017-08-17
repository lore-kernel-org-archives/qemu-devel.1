Received: from eggs.gnu.org ([2001:4830:134:3::10]:37540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1diP9V-00046O-81
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1diP9U-0005NN-9v
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:04:17 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:38353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1diP9U-0005Mt-3O
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:04:16 -0400
Received: by mail-wr0-x229.google.com with SMTP id 5so25944188wrz.5
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 11:04:15 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 17 Aug 2017 19:04:02 +0100
Message-Id: <20170817180404.29334-8-alex.bennee@linaro.org>
In-Reply-To: <20170817180404.29334-1-alex.bennee@linaro.org>
References: <20170817180404.29334-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 7/9] target/arm/translate-a64: register
 global vectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net, cota@braap.org, batuzovk@ispras.ru
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

Register the vector registers with TCG.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/translate-a64.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 805af51900..b5f48605a7 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -36,8 +36,10 @@
 
 #include "trace-tcg.h"
 
+/* Global registers */
 static TCGv_i64 cpu_X[32];
 static TCGv_i64 cpu_pc;
+static TCGv_vec cpu_V[32];
 
 /* Load/store exclusive handling */
 static TCGv_i64 cpu_exclusive_high;
@@ -50,6 +52,13 @@ static const char *x_regnames[] = {
     "x24", "x25", "x26", "x27", "x28", "x29", "lr", "sp"
 };
 
+static const char *v_regnames[] = {
+    "v0", "v1", "v2", "v3", "v4", "v5", "v6", "v7",
+    "v8", "v9", "v10", "v11", "v12", "v13", "v14", "v15",
+    "v16", "v17", "v18", "v19", "v20", "v21", "v22", "v23",
+    "v24", "v25", "v26", "v27", "v28", "v29", "v30", "v31"
+};
+
 enum a64_shift_type {
     A64_SHIFT_TYPE_LSL = 0,
     A64_SHIFT_TYPE_LSR = 1,
@@ -91,10 +100,18 @@ void a64_translate_init(void)
     cpu_pc = tcg_global_mem_new_i64(cpu_env,
                                     offsetof(CPUARMState, pc),
                                     "pc");
-    for (i = 0; i < 32; i++) {
+
+    for (i = 0; i < ARRAY_SIZE(cpu_X); i++) {
         cpu_X[i] = tcg_global_mem_new_i64(cpu_env,
                                           offsetof(CPUARMState, xregs[i]),
-                                          regnames[i]);
+                                          x_regnames[i]);
+    }
+
+    for (i = 0; i < ARRAY_SIZE(cpu_V); i++) {
+        cpu_V[i] = tcg_global_mem_new_vec(cpu_env,
+                                          offsetof(CPUARMState,
+                                                   vfp.regs[i * 2]),
+                                          v_regnames[i]);
     }
 
     cpu_exclusive_high = tcg_global_mem_new_i64(cpu_env,
-- 
2.13.0
