Received: from eggs.gnu.org ([2001:4830:134:3::10]:60858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfX-0001fZ-Ki
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfV-0006Fr-UA
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:39 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfV-0006Aw-Kn
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:37 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfU-0003i3-BO
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:36 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:24:57 +0100
Message-Id: <20180615142521.19143-20-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 19/43] target/arm: Extend vec_reg_offset to
 larger sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Rearrange the arithmetic so that we are agnostic about the total size
of the vector and the size of the element.  This will allow us to index
up to the 32nd byte and with 16-byte elements.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180613015641.5667-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.h | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index dd9c09f89b9..63d958cf504 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -67,18 +67,26 @@ static inline void assert_fp_access_checked(DisasContext *s)
 static inline int vec_reg_offset(DisasContext *s, int regno,
                                  int element, TCGMemOp size)
 {
-    int offs = 0;
+    int element_size = 1 << size;
+    int offs = element * element_size;
 #ifdef HOST_WORDS_BIGENDIAN
     /* This is complicated slightly because vfp.zregs[n].d[0] is
-     * still the low half and vfp.zregs[n].d[1] the high half
-     * of the 128 bit vector, even on big endian systems.
-     * Calculate the offset assuming a fully bigendian 128 bits,
-     * then XOR to account for the order of the two 64 bit halves.
+     * still the lowest and vfp.zregs[n].d[15] the highest of the
+     * 256 byte vector, even on big endian systems.
+     *
+     * Calculate the offset assuming fully little-endian,
+     * then XOR to account for the order of the 8-byte units.
+     *
+     * For 16 byte elements, the two 8 byte halves will not form a
+     * host int128 if the host is bigendian, since they're in the
+     * wrong order.  However the only 16 byte operation we have is
+     * a move, so we can ignore this for the moment.  More complicated
+     * operations will have to special case loading and storing from
+     * the zregs array.
      */
-    offs += (16 - ((element + 1) * (1 << size)));
-    offs ^= 8;
-#else
-    offs += element * (1 << size);
+    if (element_size < 8) {
+        offs ^= 8 - element_size;
+    }
 #endif
     offs += offsetof(CPUARMState, vfp.zregs[regno]);
     assert_fp_access_checked(s);
-- 
2.17.1
