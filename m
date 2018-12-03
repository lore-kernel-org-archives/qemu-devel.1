Received: from eggs.gnu.org ([2001:4830:134:3::10]:42301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTuzT-0005zb-8i
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:38:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTuzS-0005gv-LW
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:38:51 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gTuzS-0005fM-E1
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:38:50 -0500
Received: by mail-ot1-x342.google.com with SMTP id 40so12971746oth.4
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 12:38:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  3 Dec 2018 14:38:33 -0600
Message-Id: <20181203203839.757-5-richard.henderson@linaro.org>
In-Reply-To: <20181203203839.757-1-richard.henderson@linaro.org>
References: <20181203203839.757-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 04/10] target/arm: Fix HCR_EL2.TGE check in
 arm_phys_excp_target_el
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

The enable for TGE has already occurred within arm_hcr_el2_amo
and friends.  Moreover, when E2H is also set, the sense is
supposed to be reversed, which has also already occurred within
the helpers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 04c4a91b04..bf020364e1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6537,9 +6537,6 @@ uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
         break;
     };
 
-    /* If HCR.TGE is set then HCR is treated as being 1 */
-    hcr |= ((env->cp15.hcr_el2 & HCR_TGE) == HCR_TGE);
-
     /* Perform a table-lookup for the target EL given the current state */
     target_el = target_el_table[is64][scr][rw][hcr][secure][cur_el];
 
-- 
2.17.2
