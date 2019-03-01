Received: from eggs.gnu.org ([209.51.188.92]:60985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzomi-0002x5-NV
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 15:29:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzomh-0001w5-2C
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 15:29:32 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:44970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzomg-0001iX-HY
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 15:29:30 -0500
Received: by mail-pl1-x634.google.com with SMTP id c4so11982489pls.11
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 12:29:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Mar 2019 12:29:21 -0800
Message-Id: <20190301202921.21209-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] target/arm: Fix PC test for LDM (exception
 return)
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

Found by inspection: Rn is the base register against which the
load began; I is the register within the mask being processed.
The exception return should of course be procesed from the loaded PC.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 8f7f5b95aa..ad879e3480 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10612,7 +10612,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                             } else if (i == rn) {
                                 loaded_var = tmp;
                                 loaded_base = 1;
-                            } else if (rn == 15 && exc_return) {
+                            } else if (i == 15 && exc_return) {
                                 store_pc_exc_ret(s, tmp);
                             } else {
                                 store_reg_from_load(s, i, tmp);
-- 
2.17.2
