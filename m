Received: from eggs.gnu.org ([209.51.188.92]:59033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1wSm-0006x5-Sf
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:05:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1wSj-0005Zd-3j
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:05:43 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1wSh-0004aT-4Z
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:05:39 -0500
Received: by mail-pg1-x542.google.com with SMTP id l11so11733817pgq.10
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:05:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 09:04:33 -0800
Message-Id: <20190307170440.3113-16-richard.henderson@linaro.org>
In-Reply-To: <20190307170440.3113-1-richard.henderson@linaro.org>
References: <20190307170440.3113-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 15/22] target/arm: Clean address for DC ZVA
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

This data access was forgotten in the previous patch.

Fixes: 3a471103ac1823ba
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e02d85f317..a02c829db2 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1894,7 +1894,7 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
         return;
     case ARM_CP_DC_ZVA:
         /* Writes clear the aligned block of memory which rt points into. */
-        tcg_rt = cpu_reg(s, rt);
+        tcg_rt = clean_data_tbi(s, cpu_reg(s, rt), false);
         gen_helper_dc_zva(cpu_env, tcg_rt);
         return;
     default:
-- 
2.17.2
