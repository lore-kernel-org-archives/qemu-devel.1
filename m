Received: from eggs.gnu.org ([209.51.188.92]:42990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbU-0002lR-1Q
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbS-0007Ml-KH
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:39 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:39355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbS-0007AC-B8
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:38 -0500
Received: by mail-wr1-x432.google.com with SMTP id t27so15421308wra.6
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.18 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:27 +0000
Message-Id: <20190118145805.6852-12-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/49] target/arm: Rearrange decode in
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

From: Richard Henderson <richard.henderson@linaro.org>

Now properly signals unallocated for REV64 with SF=0.
Allows for the opcode2 field to be decoded shortly.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190108223129.5570-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index b72aea3e974..dac61a3c3a5 100644
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
2.20.1
