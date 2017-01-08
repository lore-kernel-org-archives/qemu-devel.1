Received: from eggs.gnu.org ([2001:4830:134:3::10]:38425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cQHhm-00034Y-6n
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 12:56:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cQHhk-0003v5-TG
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 12:56:30 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:33375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cQHhk-0003ud-Nl
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 12:56:28 -0500
Received: by mail-pf0-x242.google.com with SMTP id 127so23021174pfg.0
	for <qemu-devel@nongnu.org>; Sun, 08 Jan 2017 09:56:28 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  8 Jan 2017 09:56:17 -0800
Message-Id: <20170108175620.6605-9-rth@twiddle.net>
In-Reply-To: <20170108175620.6605-1-rth@twiddle.net>
References: <20170108175620.6605-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 08/11] tcg-mips: Add tcg unwind info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jin Guojie <jinguojie@loongson.cn>

From: Jin Guojie <jinguojie@loongson.cn>

Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Tested-by: James Hogan <james.hogan@imgtec.com>
Tested-by: YunQiang Su <wzssyqa@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Jin Guojie <jinguojie@loongson.cn>
Message-Id: <1483592275-4496-9-git-send-email-jinguojie@loongson.cn>
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
2.9.3
