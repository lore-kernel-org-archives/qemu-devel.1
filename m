Received: from eggs.gnu.org ([2001:4830:134:3::10]:37159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVc1P-0001Qt-SO
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVc1O-0000Vg-PP
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:15:35 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:53349)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1fVc1O-0000Sw-IQ
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:15:34 -0400
From: Yongbok Kim <yongbok.kim@mips.com>
Date: Wed, 20 Jun 2018 13:06:19 +0100
Message-ID: <20180620120620.12806-35-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-1-yongbok.kim@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 34/35] target/mips: Disable gdbstub nanoMIPS
 ISA bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, Aleksandar.Markovic@mips.com, James.Hogan@mips.com, Paul.Burton@mips.com, Matthew.Fortune@mips.com, Stefan.Markovic@mips.com

From: James Hogan <james.hogan@imgtec.com>

nanoMIPS has no ISA bit in the PC, so remove the handling of the low bit
of the PC in the MIPS gdbstub for nanoMIPS. This prevents the PC being
read as e.g. 0xbfc00001, and prevents writing to the PC clearing
MIPS_HFLAG_M16.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
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
1.9.1
