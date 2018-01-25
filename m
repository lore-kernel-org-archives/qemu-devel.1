Received: from eggs.gnu.org ([2001:4830:134:3::10]:48526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eejFi-0006Eo-Ac
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:15:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eejFc-0000j3-BS
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:15:46 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:60965)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eejFc-0000i4-2F
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:15:40 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 25 Jan 2018 16:15:28 +0100
Message-Id: <20180125151535.25256-2-laurent@vivier.eu>
In-Reply-To: <20180125151535.25256-1-laurent@vivier.eu>
References: <20180125151535.25256-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 1/8] target/m68k: fix TCG variable double free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

t64 is also unconditionally freed after the switch () { ... }

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180119114444.7590-1-laurent@vivier.eu>
---
 target/m68k/translate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index f0e86a73d4..ea18df940a 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -969,7 +969,6 @@ static void gen_load_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp)
     case OS_DOUBLE:
         tcg_gen_qemu_ld64(t64, addr, index);
         gen_helper_extf64(cpu_env, fp, t64);
-        tcg_temp_free_i64(t64);
         break;
     case OS_EXTENDED:
         if (m68k_feature(s->env, M68K_FEATURE_CF_FPU)) {
-- 
2.14.3
