Received: from eggs.gnu.org ([2001:4830:134:3::10]:55560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWG-0006rM-4C
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWF-0005qW-E3
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:16 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:34843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdWF-0005pH-9c
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:15 -0500
Received: by mail-pg0-x243.google.com with SMTP id i5so2480450pgh.2
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:01:15 -0800 (PST)
Received: from bigtime.domain ([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	n25sm65339316pfi.33.2016.12.23.20.01.13 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Dec 2016 20:01:13 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 20:00:13 -0800
Message-Id: <20161224040042.12654-37-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 36/65] target-unicore32: Use clz opcode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/unicore32/helper.c    | 10 ----------
 target/unicore32/helper.h    |  3 ---
 target/unicore32/translate.c |  6 +++---
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/target/unicore32/helper.c b/target/unicore32/helper.c
index d603bde..7a5613e 100644
--- a/target/unicore32/helper.c
+++ b/target/unicore32/helper.c
@@ -32,16 +32,6 @@ UniCore32CPU *uc32_cpu_init(const char *cpu_model)
     return UNICORE32_CPU(cpu_generic_init(TYPE_UNICORE32_CPU, cpu_model));
 }
 
-uint32_t HELPER(clo)(uint32_t x)
-{
-    return clo32(x);
-}
-
-uint32_t HELPER(clz)(uint32_t x)
-{
-    return clz32(x);
-}
-
 #ifndef CONFIG_USER_ONLY
 void helper_cp0_set(CPUUniCore32State *env, uint32_t val, uint32_t creg,
         uint32_t cop)
diff --git a/target/unicore32/helper.h b/target/unicore32/helper.h
index 9418137..a4a5d45 100644
--- a/target/unicore32/helper.h
+++ b/target/unicore32/helper.h
@@ -13,9 +13,6 @@ DEF_HELPER_3(cp0_get, i32, env, i32, i32)
 DEF_HELPER_1(cp1_putc, void, i32)
 #endif
 
-DEF_HELPER_1(clz, i32, i32)
-DEF_HELPER_1(clo, i32, i32)
-
 DEF_HELPER_2(exception, void, env, i32)
 
 DEF_HELPER_3(asr_write, void, env, i32, i32)
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 514d460..666a201 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -1479,10 +1479,10 @@ static void do_misc(CPUUniCore32State *env, DisasContext *s, uint32_t insn)
         /* clz */
         tmp = load_reg(s, UCOP_REG_M);
         if (UCOP_SET(26)) {
-            gen_helper_clo(tmp, tmp);
-        } else {
-            gen_helper_clz(tmp, tmp);
+            /* clo */
+            tcg_gen_not_i32(tmp, tmp);
         }
+        tcg_gen_clzi_i32(tmp, tmp, 32);
         store_reg(s, UCOP_REG_D, tmp);
         return;
     }
-- 
2.9.3
