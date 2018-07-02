Received: from eggs.gnu.org ([2001:4830:134:3::10]:38431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fa1Kv-0004gH-Pw
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:06:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fa1Ku-0005RG-RM
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:05:57 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:44420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fa1Ku-0005Qk-LF
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:05:56 -0400
Received: by mail-pf0-x244.google.com with SMTP id j3-v6so7715719pfh.11
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 09:05:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  2 Jul 2018 09:05:44 -0700
Message-Id: <20180702160546.31969-5-richard.henderson@linaro.org>
In-Reply-To: <20180702160546.31969-1-richard.henderson@linaro.org>
References: <20180702160546.31969-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 4/6] accel/tcg: Don't treat invalid TLB entries
 as needing recheck
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

From: Peter Maydell <peter.maydell@linaro.org>

In get_page_addr_code() when we check whether the TLB entry
is marked as TLB_RECHECK, we should not go down that code
path if the TLB entry is not valid at all (ie the TLB_INVALID
bit is set).

Tested-by: Laurent Vivier <laurent@vivier.eu>
Reported-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180629161731.16239-1-peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 3ae1198c24..cc90a5fe92 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -963,7 +963,8 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
         }
     }
 
-    if (unlikely(env->tlb_table[mmu_idx][index].addr_code & TLB_RECHECK)) {
+    if (unlikely((env->tlb_table[mmu_idx][index].addr_code &
+                  (TLB_RECHECK | TLB_INVALID_MASK)) == TLB_RECHECK)) {
         /*
          * This is a TLB_RECHECK access, where the MMU protection
          * covers a smaller range than a target page, and we must
-- 
2.17.1
