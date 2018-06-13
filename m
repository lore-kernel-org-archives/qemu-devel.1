Received: from eggs.gnu.org ([2001:4830:134:3::10]:43978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSv1s-0002A7-OZ
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:56:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSv1q-0006Cb-Lg
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:56:56 -0400
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229]:41549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fSv1q-0006CR-FD
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:56:54 -0400
Received: by mail-pg0-x229.google.com with SMTP id l65-v6so455733pgl.8
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 18:56:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 12 Jun 2018 15:56:24 -1000
Message-Id: <20180613015641.5667-2-richard.henderson@linaro.org>
In-Reply-To: <20180613015641.5667-1-richard.henderson@linaro.org>
References: <20180613015641.5667-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4b 01/18] target/arm: Extend vec_reg_offset to
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
Cc: peter.maydell@linaro.org

Rearrange the arithmetic so that we are agnostic about the total size
of the vector and the size of the element.  This will allow us to index
up to the 32nd byte and with 16-byte elements.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.h | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index dd9c09f89b..63d958cf50 100644
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
