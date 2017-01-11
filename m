Received: from eggs.gnu.org ([2001:4830:134:3::10]:35117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Un-00068B-Rr
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Um-0003A6-Sv
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:37 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8Um-00039X-Nl
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:36 -0500
Received: by mail-pf0-x241.google.com with SMTP id b22so15071560pfd.3
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:18:36 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:17:31 -0800
Message-Id: <20170111021820.24416-17-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 16/65] target-mips: Use the new extract op
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

Use extract for EXT and DEXT.

Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/mips/translate.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 57b824f..8deffa1 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4488,11 +4488,12 @@ static void gen_bitops (DisasContext *ctx, uint32_t opc, int rt,
         if (lsb + msb > 31) {
             goto fail;
         }
-        tcg_gen_shri_tl(t0, t1, lsb);
         if (msb != 31) {
-            tcg_gen_andi_tl(t0, t0, (1U << (msb + 1)) - 1);
+            tcg_gen_extract_tl(t0, t1, lsb, msb + 1);
         } else {
-            tcg_gen_ext32s_tl(t0, t0);
+            /* The two checks together imply that lsb == 0,
+               so this is a simple sign-extension.  */
+            tcg_gen_ext32s_tl(t0, t1);
         }
         break;
 #if defined(TARGET_MIPS64)
@@ -4507,10 +4508,7 @@ static void gen_bitops (DisasContext *ctx, uint32_t opc, int rt,
         if (lsb + msb > 63) {
             goto fail;
         }
-        tcg_gen_shri_tl(t0, t1, lsb);
-        if (msb != 63) {
-            tcg_gen_andi_tl(t0, t0, (1ULL << (msb + 1)) - 1);
-        }
+        tcg_gen_extract_tl(t0, t1, lsb, msb + 1);
         break;
 #endif
     case OPC_INS:
-- 
2.9.3
