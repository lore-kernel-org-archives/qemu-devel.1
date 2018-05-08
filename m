Received: from eggs.gnu.org ([2001:4830:134:3::10]:60837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fG7ln-0001LY-Uh
	for qemu-devel@nongnu.org; Tue, 08 May 2018 14:55:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fG7lk-0002nF-Kf
	for qemu-devel@nongnu.org; Tue, 08 May 2018 14:55:27 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:38806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fG7lk-0002mg-F1
	for qemu-devel@nongnu.org; Tue, 08 May 2018 14:55:24 -0400
Received: by mail-pf0-x241.google.com with SMTP id o76so24392319pfi.5
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 11:55:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue,  8 May 2018 11:55:20 -0700
Message-Id: <20180508185520.23757-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] target/m68k: Fix build Werror with gcc 8.0.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Laurent Vivier <laurent@vivier.eu>

Fedora 28 ships with the released gcc 8.

The Werror stems from the compiler finding a path through the second
switch via a missing default case in which src1 is uninitialized, and
not being able to prove that the missing default case is unreachable
due to the first switch.

Simplify the second switch to merge default with OS_LONG,
which returns directly.  This removes the unreachable path.

Cc: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index e407ba2db3..44a0ac4e2e 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -2297,7 +2297,7 @@ DISAS_INSN(arith_im)
         im = tcg_const_i32(read_im32(env, s));
         break;
     default:
-       abort();
+        g_assert_not_reached();
     }
 
     if (with_SR) {
@@ -2317,7 +2317,8 @@ DISAS_INSN(arith_im)
             }
             src1 = gen_get_sr(s);
             break;
-        case OS_LONG:
+        default:
+            /* OS_LONG; others already g_assert_not_reached.  */
             disas_undef(env, s, insn);
             return;
         }
-- 
2.17.0
