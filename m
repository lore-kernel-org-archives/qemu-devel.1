Received: from eggs.gnu.org ([209.51.188.92]:47747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gtGBM-0004DF-IB
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 13:19:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gtGBK-0003Te-9A
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 13:19:51 -0500
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:44185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1gtGBE-0003Nc-Hj
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 13:19:46 -0500
From: Sven Schnelle <svens@stackframe.org>
Date: Mon, 11 Feb 2019 19:19:03 +0100
Message-Id: <20190211181907.2219-2-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/5] target/hppa: move GETPC to HELPER()
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
Cc: deller@gmx.de, Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>

When QEMU is compiled with -O0, these functions are inlined
which will cause a wrong restart address generated for the TB.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
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
2.20.1
