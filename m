Received: from eggs.gnu.org ([2001:4830:134:3::10]:37104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVc1H-0001Lw-98
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:15:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVc1G-0000RY-Da
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:15:27 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:36213)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1fVc1G-0000OL-3F
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:15:26 -0400
From: Yongbok Kim <yongbok.kim@mips.com>
Date: Wed, 20 Jun 2018 13:06:18 +0100
Message-ID: <20180620120620.12806-34-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-1-yongbok.kim@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 33/35] target/mips: Fix gdbstub to read/write
 64 bit FP registers
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

From: Yongbok Kim <yongbok.kim@imgtec.com>

Fix gdbstub to read/write 64 bit FP registers

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
---
 target/mips/gdbstub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
index 6d1fb70..18e0e6d 100644
--- a/target/mips/gdbstub.c
+++ b/target/mips/gdbstub.c
@@ -39,7 +39,7 @@ int mips_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
             return gdb_get_regl(mem_buf, (int32_t)env->active_fpu.fcr0);
         default:
             if (env->CP0_Status & (1 << CP0St_FR)) {
-                return gdb_get_regl(mem_buf,
+                return gdb_get_reg64(mem_buf,
                     env->active_fpu.fpr[n - 38].d);
             } else {
                 return gdb_get_regl(mem_buf,
@@ -100,6 +100,7 @@ int mips_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
             break;
         default:
             if (env->CP0_Status & (1 << CP0St_FR)) {
+                uint64_t tmp = ldq_p(mem_buf);
                 env->active_fpu.fpr[n - 38].d = tmp;
             } else {
                 env->active_fpu.fpr[n - 38].w[FP_ENDIAN_IDX] = tmp;
-- 
1.9.1
