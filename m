Received: from eggs.gnu.org ([2001:4830:134:3::10]:56671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1flEXT-0005s9-Lf
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:25:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1flEXS-0008Cl-8E
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:25:15 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:48224 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1flEXS-0008CW-0M
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:25:14 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu,  2 Aug 2018 16:16:05 +0200
Message-Id: <1533219424-7627-19-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v6 18/77] target/mips: Add nanoMIPS decoding
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
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add some basic utility functions and macros for nanoMIPS decoding
engine.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
1.9.1
