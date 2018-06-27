Received: from eggs.gnu.org ([2001:4830:134:3::10]:48683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fYFCI-0007Kv-Pz
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 14:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fYFCG-0000od-Qb
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 14:29:42 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:47461 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fYFCG-0000lZ-J5
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 14:29:40 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 27 Jun 2018 20:29:09 +0200
Message-Id: <1530124149-3900-10-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1530124149-3900-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1530124149-3900-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 9/9] target/mips: Fix gdbstub to read/write
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
Cc: peter.maydell@linaro.org

From: Yongbok Kim <yongbok.kim@mips.com>

Fix gdbstub to read/write 64 bit FP registers

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Reviewed-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
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
2.7.4
