Received: from eggs.gnu.org ([2001:4830:134:3::10]:55300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdVz-0006aE-Fp
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdVy-0005a5-TI
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:00:59 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdVy-0005Zi-O5
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:00:58 -0500
Received: by mail-pg0-x244.google.com with SMTP id b1so2475170pgc.1
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:00:58 -0800 (PST)
Received: from bigtime.domain ([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	n25sm65339316pfi.33.2016.12.23.20.00.57 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Dec 2016 20:00:57 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 19:59:53 -0800
Message-Id: <20161224040042.12654-17-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 16/65] target-mips: Use the new extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
