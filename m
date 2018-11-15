Received: from eggs.gnu.org ([2001:4830:134:3::10]:47593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8503fdbbc=Alistair.Francis@wdc.com>)
	id 1gNQE3-0005sN-D7
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:35:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8503fdbbc=Alistair.Francis@wdc.com>)
	id 1gNQDz-0003oF-QL
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:35:03 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Thu, 15 Nov 2018 22:34:56 +0000
Message-ID: <bc29bf08db9e3801a3e833f579d93ee2c86cc49d.1542321076.git.alistair.francis@wdc.com>
References: <cover.1542321076.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1542321076.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC v1 07/23] riscv: tcg-target: Regiser the JIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 tcg/riscv/tcg-target.inc.c | 45 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index e5eca4bbbe..a9c57493a0 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -118,3 +118,48 @@ static const int tcg_target_call_oarg_regs[] =3D {
 #define TCG_CT_CONST_ZERO  0x100
 #define TCG_CT_CONST_S12   0x200
 #define TCG_CT_CONST_N12   0x400
+
+typedef struct {
+    DebugFrameHeader h;
+    uint8_t fde_def_cfa[4];
+    uint8_t fde_reg_ofs[ARRAY_SIZE(tcg_target_callee_save_regs) * 2];
+} DebugFrame;
+
+#define ELF_HOST_MACHINE EM_RISCV
+
+static const DebugFrame debug_frame =3D {
+    .h.cie.len =3D sizeof(DebugFrameCIE) - 4, /* length after .len member =
*/
+    .h.cie.id =3D -1,
+    .h.cie.version =3D 1,
+    .h.cie.code_align =3D 1,
+    .h.cie.data_align =3D -(TCG_TARGET_REG_BITS / 8) & 0x7f, /* sleb128 */
+    .h.cie.return_column =3D TCG_REG_RA,
+
+    /* Total FDE size does not include the "len" member.  */
+    .h.fde.len =3D sizeof(DebugFrame) - offsetof(DebugFrame, h.fde.cie_off=
set),
+
+    .fde_def_cfa =3D {
+        12, TCG_REG_SP,                 /* DW_CFA_def_cfa sp, ... */
+        (FRAME_SIZE & 0x7f) | 0x80,     /* ... uleb128 FRAME_SIZE */
+        (FRAME_SIZE >> 7)
+    },
+    .fde_reg_ofs =3D {
+        0x80 + 9,  12,                  /* DW_CFA_offset, s1,  -96 */
+        0x80 + 18, 11,                  /* DW_CFA_offset, s2,  -88 */
+        0x80 + 19, 10,                  /* DW_CFA_offset, s3,  -80 */
+        0x80 + 20, 9,                   /* DW_CFA_offset, s4,  -72 */
+        0x80 + 21, 8,                   /* DW_CFA_offset, s5,  -64 */
+        0x80 + 22, 7,                   /* DW_CFA_offset, s6,  -56 */
+        0x80 + 23, 6,                   /* DW_CFA_offset, s7,  -48 */
+        0x80 + 24, 5,                   /* DW_CFA_offset, s8,  -40 */
+        0x80 + 25, 4,                   /* DW_CFA_offset, s9,  -32 */
+        0x80 + 26, 3,                   /* DW_CFA_offset, s10, -24 */
+        0x80 + 27, 2,                   /* DW_CFA_offset, s11, -16 */
+        0x80 + 1 , 1,                   /* DW_CFA_offset, ra,  -8 */
+    }
+};
+
+void tcg_register_jit(void *buf, size_t buf_size)
+{
+    tcg_register_jit_int(buf, buf_size, &debug_frame, sizeof(debug_frame))=
;
+}
--=20
2.19.1
