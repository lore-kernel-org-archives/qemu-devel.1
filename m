Received: from eggs.gnu.org ([2001:4830:134:3::10]:41543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJ4wc-00082n-FJ
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJ4wa-0007nw-DB
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:50 -0400
Received: from mail-pl0-x22b.google.com ([2607:f8b0:400e:c01::22b]:36191)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJ4wa-0007na-7G
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:48 -0400
Received: by mail-pl0-x22b.google.com with SMTP id v24-v6so1253312plo.3
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 15:30:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 16 May 2018 15:30:06 -0700
Message-Id: <20180516223007.10256-27-richard.henderson@linaro.org>
In-Reply-To: <20180516223007.10256-1-richard.henderson@linaro.org>
References: <20180516223007.10256-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3-a 26/27] target/arm: Extend vec_reg_offset
 to larger sizes
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

Rearrange the arithmetic so that we are agnostic about the total size
of the vector and the size of the element.  This will allow us to index
up to the 32nd byte and with 16-byte elements.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index dd9c09f89b..5a97ae2b59 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -67,18 +67,18 @@ static inline void assert_fp_access_checked(DisasContext *s)
 static inline int vec_reg_offset(DisasContext *s, int regno,
                                  int element, TCGMemOp size)
 {
-    int offs = 0;
+    int element_size = 1 << size;
+    int offs = element * element_size;
 #ifdef HOST_WORDS_BIGENDIAN
     /* This is complicated slightly because vfp.zregs[n].d[0] is
      * still the low half and vfp.zregs[n].d[1] the high half
      * of the 128 bit vector, even on big endian systems.
-     * Calculate the offset assuming a fully bigendian 128 bits,
-     * then XOR to account for the order of the two 64 bit halves.
+     * Calculate the offset assuming a fully little-endian 128 bits,
+     * then XOR to account for the order of the 64 bit units.
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
2.17.0
