Received: from eggs.gnu.org ([2001:4830:134:3::10]:55478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWA-0006mh-K0
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdW9-0005lL-QN
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:10 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:34838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdW9-0005l3-MH
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:09 -0500
Received: by mail-pg0-x243.google.com with SMTP id i5so2480274pgh.2
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:01:09 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 20:00:06 -0800
Message-Id: <20161224040042.12654-30-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 29/65] target-microblaze: Use clz opcode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>

Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/microblaze/helper.h    | 1 -
 target/microblaze/op_helper.c | 5 -----
 target/microblaze/translate.c | 2 +-
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index bd13826..71a6c08 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -3,7 +3,6 @@ DEF_HELPER_1(debug, void, env)
 DEF_HELPER_FLAGS_3(carry, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_2(cmp, i32, i32, i32)
 DEF_HELPER_2(cmpu, i32, i32, i32)
-DEF_HELPER_FLAGS_1(clz, TCG_CALL_NO_RWG_SE, i32, i32)
 
 DEF_HELPER_3(divs, i32, env, i32, i32)
 DEF_HELPER_3(divu, i32, env, i32, i32)
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 4a856e6..1e07e21 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -145,11 +145,6 @@ uint32_t helper_cmpu(uint32_t a, uint32_t b)
     return t;
 }
 
-uint32_t helper_clz(uint32_t t0)
-{
-    return clz32(t0);
-}
-
 uint32_t helper_carry(uint32_t a, uint32_t b, uint32_t cf)
 {
     return compute_carry(a, b, cf);
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index de2090a..0bb6095 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -768,7 +768,7 @@ static void dec_bit(DisasContext *dc)
                 t_gen_raise_exception(dc, EXCP_HW_EXCP);
             }
             if (dc->cpu->env.pvr.regs[2] & PVR2_USE_PCMP_INSTR) {
-                gen_helper_clz(cpu_R[dc->rd], cpu_R[dc->ra]);
+                tcg_gen_clzi_i32(cpu_R[dc->rd], cpu_R[dc->ra], 32);
             }
             break;
         case 0x1e0:
-- 
2.9.3
