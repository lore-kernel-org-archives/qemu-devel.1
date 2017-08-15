Received: from eggs.gnu.org ([2001:4830:134:3::10]:34185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dhdHX-0005Iq-Tb
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:57:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dhdHV-0004J6-8V
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:57:23 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:35005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dhdHV-0004IS-3i
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:57:21 -0400
Received: by mail-pg0-x235.google.com with SMTP id v189so7046835pgd.2
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 07:57:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 15 Aug 2017 07:57:12 -0700
Message-Id: <20170815145714.17635-2-richard.henderson@linaro.org>
In-Reply-To: <20170815145714.17635-1-richard.henderson@linaro.org>
References: <20170815145714.17635-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 for-2.10 1/3] target/arm: Correct exclusive
 store cmpxchg memop mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alistair.francis@xilinx.com, edgar.iglesias@xilinx.com

From: Alistair Francis <alistair.francis@xilinx.com>

When we perform the atomic_cmpxchg operation we want to perform the
operation on a pair of 32-bit registers. Previously we were just passing
the register size in which was set to MO_32. This would result in the
high register to be ignored. To fix this issue we hardcode the size to
be 64-bits long when operating on 32-bit pairs.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Message-Id: <bc18dddca56e8c2ea4a3def48d33ceb5d21d1fff.1502488636.git.alistair.francis@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 58ed4c6d05..113e2e172b 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1913,7 +1913,7 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
             tcg_gen_concat32_i64(val, cpu_exclusive_val, cpu_exclusive_high);
             tcg_gen_atomic_cmpxchg_i64(tmp, addr, val, tmp,
                                        get_mem_index(s),
-                                       size | MO_ALIGN | s->be_data);
+                                       MO_64 | MO_ALIGN | s->be_data);
             tcg_gen_setcond_i64(TCG_COND_NE, tmp, tmp, val);
             tcg_temp_free_i64(val);
         } else if (s->be_data == MO_LE) {
-- 
2.13.4
