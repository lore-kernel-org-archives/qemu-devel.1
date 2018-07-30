Received: from eggs.gnu.org ([2001:4830:134:3::10]:35839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkAsr-00049S-Lt
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:18:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkAsq-0006D7-OR
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:18:57 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:54917 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fkAsq-0006C2-Hp
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:18:56 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 30 Jul 2018 18:11:51 +0200
Message-Id: <1532967169-22265-19-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 18/76] target/mips: Add nanoMIPS decoding
 and extraction utilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add some basic utility functions and macros for nanoMIPS decoding
engine.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index c59ef5c..aba42be 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16475,6 +16475,51 @@ enum {
  *
  */
 
+/* Implement nanoMIPS pseudocode decode_gpr(encoded_gpr, 'gpr3'). */
+static inline int decode_gpr_gpr3(int r)
+{
+    static const int map[] = { 16, 17, 18, 19,  4,  5,  6,  7 };
+
+    return map[r & 0x7];
+}
+
+/* Implement nanoMIPS pseudocode decode_gpr(encoded_gpr, 'gpr3.src.store'). */
+static inline int decode_gpr_gpr3_src_store(int r)
+{
+    static const int map[] = {  0, 17, 18, 19,  4,  5,  6,  7 };
+
+    return map[r & 0x7];
+}
+
+/* Implement nanoMIPS pseudocode decode_gpr(encoded_gpr, 'gpr4'). */
+static inline int decode_gpr_gpr4(int r)
+{
+    static const int map[] = {  8,  9, 10, 11,  4,  5,  6,  7,
+                               16, 17, 18, 19, 20, 21, 22, 23 };
+
+    return map[r & 0xf];
+}
+
+/* Implement nanoMIPS pseudocode decode_gpr(encoded_gpr, 'gpr4.zero'). */
+static inline int decode_gpr_gpr4_zero(int r)
+{
+    static const int map[] = {  8,  9, 10,  0,  4,  5,  6,  7,
+                               16, 17, 18, 19, 20, 21, 22, 23 };
+
+    return map[r & 0xf];
+}
+
+
+/* extraction utilities */
+
+#define NANOMIPS_EXTRACT_RD(op) ((op >> 7) & 0x7)
+#define NANOMIPS_EXTRACT_RS(op) ((op >> 4) & 0x7)
+#define NANOMIPS_EXTRACT_RS2(op) uMIPS_RS(op)
+#define NANOMIPS_EXTRACT_RS1(op) ((op >> 1) & 0x7)
+#define NANOMIPS_EXTRACT_RD5(op) ((op >> 5) & 0x1f)
+#define NANOMIPS_EXTRACT_RS5(op) (op & 0x1f)
+
+
 static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
 {
     return 2;
-- 
2.7.4
