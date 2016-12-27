Received: from eggs.gnu.org ([2001:4830:134:3::10]:35254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZP-0001gp-Te
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:21:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZP-0001B8-3I
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:21:43 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cLtZO-0001Av-Su
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:21:43 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZO-0003r8-1H
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:21:42 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 15:20:56 +0000
Message-Id: <1482852077-19397-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
References: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 04/25] target-arm: Fix aarch64 vec_reg_offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <rth@twiddle.net>

Since CPUARMState.vfp.regs is not 16 byte aligned, the ^ 8 fixup used
for a big-endian host doesn't do what's intended.  Fix this by adding
in the vfp.regs offset after computing the inter-register offset.

Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-id: 1481085020-2614-2-git-send-email-rth@twiddle.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 6dc27a6..ef7601b 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -527,7 +527,7 @@ static inline void assert_fp_access_checked(DisasContext *s)
 static inline int vec_reg_offset(DisasContext *s, int regno,
                                  int element, TCGMemOp size)
 {
-    int offs = offsetof(CPUARMState, vfp.regs[regno * 2]);
+    int offs = 0;
 #ifdef HOST_WORDS_BIGENDIAN
     /* This is complicated slightly because vfp.regs[2n] is
      * still the low half and  vfp.regs[2n+1] the high half
@@ -540,6 +540,7 @@ static inline int vec_reg_offset(DisasContext *s, int regno,
 #else
     offs += element * (1 << size);
 #endif
+    offs += offsetof(CPUARMState, vfp.regs[regno * 2]);
     assert_fp_access_checked(s);
     return offs;
 }
-- 
2.7.4
