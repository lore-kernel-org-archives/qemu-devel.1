Received: from eggs.gnu.org ([209.51.188.92]:49652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtQ8y-0002fL-91
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:58:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtQ8n-0001sw-FI
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:57:56 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:33116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtQ8l-0001kS-UT
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:57:52 -0500
Received: by mail-pl1-x630.google.com with SMTP id y10so705862plp.0
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 20:57:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 20:57:17 -0800
Message-Id: <20190212045721.28041-21-richard.henderson@linaro.org>
In-Reply-To: <20190212045721.28041-1-richard.henderson@linaro.org>
References: <20190212045721.28041-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 20/24] target/hppa: move GETPC to HELPER()
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Sven Schnelle <svens@stackframe.org>

From: Sven Schnelle <svens@stackframe.org>

When QEMU is compiled with -O0, these functions are inlined
which will cause a wrong restart address generated for the TB.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Message-Id: <20190211181907.2219-2-svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/op_helper.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 6bf478e7b0..268caaaa20 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -81,10 +81,8 @@ static void atomic_store_3(CPUHPPAState *env, target_ulong addr, uint32_t val,
 }
 
 static void do_stby_b(CPUHPPAState *env, target_ulong addr, target_ureg val,
-                      bool parallel)
+                      bool parallel, uintptr_t ra)
 {
-    uintptr_t ra = GETPC();
-
     switch (addr & 3) {
     case 3:
         cpu_stb_data_ra(env, addr, val, ra);
@@ -109,20 +107,18 @@ static void do_stby_b(CPUHPPAState *env, target_ulong addr, target_ureg val,
 
 void HELPER(stby_b)(CPUHPPAState *env, target_ulong addr, target_ureg val)
 {
-    do_stby_b(env, addr, val, false);
+    do_stby_b(env, addr, val, false, GETPC());
 }
 
 void HELPER(stby_b_parallel)(CPUHPPAState *env, target_ulong addr,
                              target_ureg val)
 {
-    do_stby_b(env, addr, val, true);
+    do_stby_b(env, addr, val, true, GETPC());
 }
 
 static void do_stby_e(CPUHPPAState *env, target_ulong addr, target_ureg val,
-                      bool parallel)
+                      bool parallel, uintptr_t ra)
 {
-    uintptr_t ra = GETPC();
-
     switch (addr & 3) {
     case 3:
         /* The 3 byte store must appear atomic.  */
@@ -151,13 +147,13 @@ static void do_stby_e(CPUHPPAState *env, target_ulong addr, target_ureg val,
 
 void HELPER(stby_e)(CPUHPPAState *env, target_ulong addr, target_ureg val)
 {
-    do_stby_e(env, addr, val, false);
+    do_stby_e(env, addr, val, false, GETPC());
 }
 
 void HELPER(stby_e_parallel)(CPUHPPAState *env, target_ulong addr,
                              target_ureg val)
 {
-    do_stby_e(env, addr, val, true);
+    do_stby_e(env, addr, val, true, GETPC());
 }
 
 target_ureg HELPER(probe)(CPUHPPAState *env, target_ulong addr,
-- 
2.17.2
