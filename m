Received: from eggs.gnu.org ([209.51.188.92]:38152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOG-0005Qz-UW
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOE-0004b8-OL
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:32 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtLOD-0004Ws-3v
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:30 -0500
Received: by mail-pg1-x544.google.com with SMTP id y4so303154pgc.12
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 15:53:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 15:52:49 -0800
Message-Id: <20190211235258.542-20-richard.henderson@linaro.org>
In-Reply-To: <20190211235258.542-1-richard.henderson@linaro.org>
References: <20190211235258.542-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 19/28] target/arm: Clean address for DC ZVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

This data access was forgotten in the previous patch.

Fixes: 3a471103ac1823ba
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index b97af372f0..9e7afa571d 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1815,7 +1815,7 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
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
