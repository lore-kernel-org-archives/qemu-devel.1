Received: from eggs.gnu.org ([209.51.188.92]:58918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMB-0008EP-F6
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbM9-0003h4-Mw
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:55 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:40197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbM9-0003TW-DW
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:53 -0500
Received: by mail-wm1-x335.google.com with SMTP id f188so6726860wmf.5
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:07:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n6sm2847250wmk.9.2019.02.01.08.07.29
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Feb 2019 08:07:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 16:06:33 +0000
Message-Id: <20190201160653.13829-28-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-1-peter.maydell@linaro.org>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 27/47] target/arm/translate-a64: Don't
 underdecode SIMD ld/st multiple
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In the AdvSIMD load/store multiple structures encodings,
the non-post-indexed case should have zeroes in [20:16]
(which is the Rm field for the post-indexed case).
Correctly UNDEF the currently unallocated encodings which
have non-zeroes in those bits.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20190125182626.9221-4-peter.maydell@linaro.org
---
 target/arm/translate-a64.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 8e081758e03..c1f0cad7691 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3249,6 +3249,7 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
 {
     int rt = extract32(insn, 0, 5);
     int rn = extract32(insn, 5, 5);
+    int rm = extract32(insn, 16, 5);
     int size = extract32(insn, 10, 2);
     int opcode = extract32(insn, 12, 4);
     bool is_store = !extract32(insn, 22, 1);
@@ -3268,6 +3269,11 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
         return;
     }
 
+    if (!is_postidx && rm != 0) {
+        unallocated_encoding(s);
+        return;
+    }
+
     /* From the shared decode logic */
     switch (opcode) {
     case 0x0:
@@ -3367,7 +3373,6 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
     }
 
     if (is_postidx) {
-        int rm = extract32(insn, 16, 5);
         if (rm == 31) {
             tcg_gen_mov_i64(tcg_rn, tcg_addr);
         } else {
-- 
2.20.1
