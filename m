Received: from eggs.gnu.org ([2001:4830:134:3::10]:41376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cP0QE-0000dM-LG
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 00:17:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cP0QB-0002Ve-Hf
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 00:17:06 -0500
Received: from [114.242.206.163] (port=60312 helo=mail.loongson.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cP0QA-0002RZ-NO
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 00:17:03 -0500
From: Jin Guojie <jinguojie@loongson.cn>
Date: Thu,  5 Jan 2017 12:57:53 +0800
Message-Id: <1483592275-4496-9-git-send-email-jinguojie@loongson.cn>
In-Reply-To: <1483592275-4496-1-git-send-email-jinguojie@loongson.cn>
References: <1483592275-4496-1-git-send-email-jinguojie@loongson.cn>
Subject: [Qemu-devel] [PATCH v6 RESEND 08/10] tcg-mips: Add tcg unwind info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, James Hogan <james.hogan@imgtec.com>, YunQiang Su <wzssyqa@gmail.com>, Richard Henderson <rth@twiddle.net>, Jin Guojie <jinguojie@loongson.cn>

Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Tested-by: James Hogan <james.hogan@imgtec.com>
Tested-by: YunQiang Su <wzssyqa@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Jin Guojie <jinguojie@loongson.cn>
---
 tcg/mips/tcg-target.inc.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 9e24662..b7e2586 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -2465,3 +2465,47 @@ void tb_set_jmp_target1(uintptr_t jmp_addr, uintptr_t addr)
     atomic_set((uint32_t *)jmp_addr, deposit32(OPC_J, 0, 26, addr >> 2));
     flush_icache_range(jmp_addr, jmp_addr + 4);
 }
+
+typedef struct {
+    DebugFrameHeader h;
+    uint8_t fde_def_cfa[4];
+    uint8_t fde_reg_ofs[ARRAY_SIZE(tcg_target_callee_save_regs) * 2];
+} DebugFrame;
+
+#define ELF_HOST_MACHINE EM_MIPS
+/* GDB doesn't appear to require proper setting of ELF_HOST_FLAGS,
+   which is good because they're really quite complicated for MIPS.  */
+
+static const DebugFrame debug_frame = {
+    .h.cie.len = sizeof(DebugFrameCIE) - 4, /* length after .len member */
+    .h.cie.id = -1,
+    .h.cie.version = 1,
+    .h.cie.code_align = 1,
+    .h.cie.data_align = -(TCG_TARGET_REG_BITS / 8) & 0x7f, /* sleb128 */
+    .h.cie.return_column = TCG_REG_RA,
+
+    /* Total FDE size does not include the "len" member.  */
+    .h.fde.len = sizeof(DebugFrame) - offsetof(DebugFrame, h.fde.cie_offset),
+
+    .fde_def_cfa = {
+        12, TCG_REG_SP,                 /* DW_CFA_def_cfa sp, ... */
+        (FRAME_SIZE & 0x7f) | 0x80,     /* ... uleb128 FRAME_SIZE */
+        (FRAME_SIZE >> 7)
+    },
+    .fde_reg_ofs = {
+        0x80 + 16, 9,                   /* DW_CFA_offset, s0, -72 */
+        0x80 + 17, 8,                   /* DW_CFA_offset, s2, -64 */
+        0x80 + 18, 7,                   /* DW_CFA_offset, s3, -56 */
+        0x80 + 19, 6,                   /* DW_CFA_offset, s4, -48 */
+        0x80 + 20, 5,                   /* DW_CFA_offset, s5, -40 */
+        0x80 + 21, 4,                   /* DW_CFA_offset, s6, -32 */
+        0x80 + 22, 3,                   /* DW_CFA_offset, s7, -24 */
+        0x80 + 30, 2,                   /* DW_CFA_offset, s8, -16 */
+        0x80 + 31, 1,                   /* DW_CFA_offset, ra,  -8 */
+    }
+};
+
+void tcg_register_jit(void *buf, size_t buf_size)
+{
+    tcg_register_jit_int(buf, buf_size, &debug_frame, sizeof(debug_frame));
+}
-- 
2.1.0
