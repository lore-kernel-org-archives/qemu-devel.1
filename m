Received: from eggs.gnu.org ([2001:4830:134:3::10]:43951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGy3g-0002Y9-0T
	for qemu-devel@nongnu.org; Thu, 10 May 2018 22:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGy3f-00068O-7W
	for qemu-devel@nongnu.org; Thu, 10 May 2018 22:45:23 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:44342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGy3f-00067p-2Y
	for qemu-devel@nongnu.org; Thu, 10 May 2018 22:45:23 -0400
Received: by mail-pl0-x241.google.com with SMTP id e6-v6so2408664plt.11
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 19:45:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 May 2018 19:44:54 -0700
Message-Id: <20180511024454.31679-12-richard.henderson@linaro.org>
In-Reply-To: <20180511024454.31679-1-richard.henderson@linaro.org>
References: <20180511024454.31679-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 11/11] target/arm: Fix sqrt_f16 exception
 raising
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-stable@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

We are meant to explicitly pass fpst, not cpu_env.

Cc: qemu-stable@nongnu.org
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d77eda7cbc..009a151379 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4976,7 +4976,8 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
         tcg_gen_xori_i32(tcg_res, tcg_op, 0x8000);
         break;
     case 0x3: /* FSQRT */
-        gen_helper_sqrt_f16(tcg_res, tcg_op, cpu_env);
+        fpst = get_fpstatus_ptr(true);
+        gen_helper_sqrt_f16(tcg_res, tcg_op, fpst);
         break;
     case 0x8: /* FRINTN */
     case 0x9: /* FRINTP */
-- 
2.17.0
