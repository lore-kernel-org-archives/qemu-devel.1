Received: from eggs.gnu.org ([2001:4830:134:3::10]:38227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dro0M-0001y5-7t
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dro0I-0007Bl-5E
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:42 -0400
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:36711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dro0H-0007Az-Fp
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:37 -0400
Received: by mail-pf0-x236.google.com with SMTP id e199so19406059pfh.3
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 09:25:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 12 Sep 2017 09:25:12 -0700
Message-Id: <20170912162513.21694-16-richard.henderson@linaro.org>
In-Reply-To: <20170912162513.21694-1-richard.henderson@linaro.org>
References: <20170912162513.21694-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 15/16] tcg: Fix types in tcg_regset_{set,
 reset}_reg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, f4bug@amsat.org

There was a problem here with an ILP32 host with 64 host registers.
E.g. aarch64 running in ILP32 mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index d4412102ba..c5ada53358 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -210,9 +210,9 @@ typedef enum TCGOpcode {
     NB_OPS,
 } TCGOpcode;
 
-#define tcg_regset_set_reg(d, r) (d) |= 1L << (r)
-#define tcg_regset_reset_reg(d, r) (d) &= ~(1L << (r))
-#define tcg_regset_test_reg(d, r) (((d) >> (r)) & 1)
+#define tcg_regset_set_reg(d, r)   ((d) |= (TCGRegSet)1 << (r))
+#define tcg_regset_reset_reg(d, r) ((d) &= ~((TCGRegSet)1 << (r)))
+#define tcg_regset_test_reg(d, r)  (((d) >> (r)) & 1)
 
 #ifndef TCG_TARGET_INSN_UNIT_SIZE
 # error "Missing TCG_TARGET_INSN_UNIT_SIZE"
-- 
2.13.5
