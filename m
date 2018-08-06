Received: from eggs.gnu.org ([2001:4830:134:3::10]:41591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fmjGa-0007id-Ax
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fmjGY-0002Cz-BG
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:26:00 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45778 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fmjGY-0002Be-3e
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:25:58 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon,  6 Aug 2018 19:00:26 +0200
Message-Id: <1533574847-19294-60-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v7 59/80] gdbstub: Disable handling of nanoMIPS
 ISA bit in the MIPS gdbstub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com, thuth@redhat.com, armbru@redhat.com

From: James Hogan <james.hogan@mips.com>

nanoMIPS has no ISA bit in the PC, so remove the handling of the low bit
of the PC in the MIPS gdbstub for nanoMIPS. This prevents the PC being
read as e.g. 0xbfc00001, and prevents writing to the PC clearing
MIPS_HFLAG_M16.

Signed-off-by: James Hogan <james.hogan@mips.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/gdbstub.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
index 18e0e6d..559b69f 100644
--- a/target/mips/gdbstub.c
+++ b/target/mips/gdbstub.c
@@ -60,7 +60,8 @@ int mips_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
         return gdb_get_regl(mem_buf, (int32_t)env->CP0_Cause);
     case 37:
         return gdb_get_regl(mem_buf, env->active_tc.PC |
-                                     !!(env->hflags & MIPS_HFLAG_M16));
+                                     (!(env->insn_flags & ISA_NANOMIPS32) &&
+                                      env->hflags & MIPS_HFLAG_M16));
     case 72:
         return gdb_get_regl(mem_buf, 0); /* fp */
     case 89:
@@ -131,10 +132,12 @@ int mips_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         break;
     case 37:
         env->active_tc.PC = tmp & ~(target_ulong)1;
-        if (tmp & 1) {
-            env->hflags |= MIPS_HFLAG_M16;
-        } else {
-            env->hflags &= ~(MIPS_HFLAG_M16);
+        if (!(env->insn_flags & ISA_NANOMIPS32)) {
+            if (tmp & 1) {
+                env->hflags |= MIPS_HFLAG_M16;
+            } else {
+                env->hflags &= ~(MIPS_HFLAG_M16);
+            }
         }
         break;
     case 72: /* fp, ignored */
-- 
2.7.4
