Received: from eggs.gnu.org ([2001:4830:134:3::10]:59066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDV0-00081c-SG
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:36:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDV0-0007OP-3p
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:36:46 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gVDUz-0007NZ-V5
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:36:46 -0500
Received: by mail-oi1-x244.google.com with SMTP id a77so2999998oii.5
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 02:36:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  7 Dec 2018 04:36:11 -0600
Message-Id: <20181207103631.28193-7-richard.henderson@linaro.org>
In-Reply-To: <20181207103631.28193-1-richard.henderson@linaro.org>
References: <20181207103631.28193-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 06/26] target/arm: Rearrange decode in
 disas_data_proc_1src
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ramana.radhakrishnan@arm.com

Now properly signals unallocated for REV64 with SF=0.
Allows for the opcode2 field to be decoded shortly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 0df344f9e8..c5ec430b42 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4563,38 +4563,51 @@ static void handle_rev16(DisasContext *s, unsigned int sf,
  */
 static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
 {
-    unsigned int sf, opcode, rn, rd;
+    unsigned int sf, opcode, opcode2, rn, rd;
 
-    if (extract32(insn, 29, 1) || extract32(insn, 16, 5)) {
+    if (extract32(insn, 29, 1)) {
         unallocated_encoding(s);
         return;
     }
 
     sf = extract32(insn, 31, 1);
     opcode = extract32(insn, 10, 6);
+    opcode2 = extract32(insn, 16, 5);
     rn = extract32(insn, 5, 5);
     rd = extract32(insn, 0, 5);
 
-    switch (opcode) {
-    case 0: /* RBIT */
+#define MAP(SF, O2, O1) ((SF) | (O1 << 1) | (O2 << 7))
+
+    switch (MAP(sf, opcode2, opcode)) {
+    case MAP(0, 0x00, 0x00): /* RBIT */
+    case MAP(1, 0x00, 0x00):
         handle_rbit(s, sf, rn, rd);
         break;
-    case 1: /* REV16 */
+    case MAP(0, 0x00, 0x01): /* REV16 */
+    case MAP(1, 0x00, 0x01):
         handle_rev16(s, sf, rn, rd);
         break;
-    case 2: /* REV32 */
+    case MAP(0, 0x00, 0x02): /* REV/REV32 */
+    case MAP(1, 0x00, 0x02):
         handle_rev32(s, sf, rn, rd);
         break;
-    case 3: /* REV64 */
+    case MAP(1, 0x00, 0x03): /* REV64 */
         handle_rev64(s, sf, rn, rd);
         break;
-    case 4: /* CLZ */
+    case MAP(0, 0x00, 0x04): /* CLZ */
+    case MAP(1, 0x00, 0x04):
         handle_clz(s, sf, rn, rd);
         break;
-    case 5: /* CLS */
+    case MAP(0, 0x00, 0x05): /* CLS */
+    case MAP(1, 0x00, 0x05):
         handle_cls(s, sf, rn, rd);
         break;
+    default:
+        unallocated_encoding(s);
+        break;
     }
+
+#undef MAP
 }
 
 static void handle_div(DisasContext *s, bool is_signed, unsigned int sf,
-- 
2.17.2
