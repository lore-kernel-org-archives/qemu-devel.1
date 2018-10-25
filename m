Received: from eggs.gnu.org ([2001:4830:134:3::10]:40307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKm-0006hj-D5
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKJ-00007y-24
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:44 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKH-0008QE-5R
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:41 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:22 -0400
Message-Id: <20181025172057.20414-14-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 13/48] xxhash: add qemu_xxhash8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

It will be used for TB hashing soon.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/xxhash.h | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/include/qemu/xxhash.h b/include/qemu/xxhash.h
index fe35dde328..450427eeaa 100644
--- a/include/qemu/xxhash.h
+++ b/include/qemu/xxhash.h
@@ -49,7 +49,8 @@
  * contiguous in memory.
  */
 static inline uint32_t
-qemu_xxhash7(uint64_t ab, uint64_t cd, uint32_t e, uint32_t f, uint32_t g)
+qemu_xxhash8(uint64_t ab, uint64_t cd, uint32_t e, uint32_t f, uint32_t g,
+             uint32_t h)
 {
     uint32_t v1 = QEMU_XXHASH_SEED + PRIME32_1 + PRIME32_2;
     uint32_t v2 = QEMU_XXHASH_SEED + PRIME32_2;
@@ -77,17 +78,24 @@ qemu_xxhash7(uint64_t ab, uint64_t cd, uint32_t e, uint32_t f, uint32_t g)
     v4 = rol32(v4, 13);
     v4 *= PRIME32_1;
 
-    h32 = rol32(v1, 1) + rol32(v2, 7) + rol32(v3, 12) + rol32(v4, 18);
-    h32 += 28;
+    v1 += e * PRIME32_2;
+    v1 = rol32(v1, 13);
+    v1 *= PRIME32_1;
 
-    h32 += e * PRIME32_3;
-    h32  = rol32(h32, 17) * PRIME32_4;
+    v2 += f * PRIME32_2;
+    v2 = rol32(v2, 13);
+    v2 *= PRIME32_1;
+
+    v3 += g * PRIME32_2;
+    v3 = rol32(v3, 13);
+    v3 *= PRIME32_1;
 
-    h32 += f * PRIME32_3;
-    h32  = rol32(h32, 17) * PRIME32_4;
+    v4 += h * PRIME32_2;
+    v4 = rol32(v4, 13);
+    v4 *= PRIME32_1;
 
-    h32 += g * PRIME32_3;
-    h32  = rol32(h32, 17) * PRIME32_4;
+    h32 = rol32(v1, 1) + rol32(v2, 7) + rol32(v3, 12) + rol32(v4, 18);
+    h32 += 32;
 
     h32 ^= h32 >> 15;
     h32 *= PRIME32_2;
@@ -100,23 +108,29 @@ qemu_xxhash7(uint64_t ab, uint64_t cd, uint32_t e, uint32_t f, uint32_t g)
 
 static inline uint32_t qemu_xxhash2(uint64_t ab)
 {
-    return qemu_xxhash7(ab, 0, 0, 0, 0);
+    return qemu_xxhash8(ab, 0, 0, 0, 0, 0);
 }
 
 static inline uint32_t qemu_xxhash4(uint64_t ab, uint64_t cd)
 {
-    return qemu_xxhash7(ab, cd, 0, 0, 0);
+    return qemu_xxhash8(ab, cd, 0, 0, 0, 0);
 }
 
 static inline uint32_t qemu_xxhash5(uint64_t ab, uint64_t cd, uint32_t e)
 {
-    return qemu_xxhash7(ab, cd, e, 0, 0);
+    return qemu_xxhash8(ab, cd, e, 0, 0, 0);
 }
 
 static inline uint32_t qemu_xxhash6(uint64_t ab, uint64_t cd, uint32_t e,
                                     uint32_t f)
 {
-    return qemu_xxhash7(ab, cd, e, f, 0);
+    return qemu_xxhash8(ab, cd, e, f, 0, 0);
+}
+
+static inline uint32_t qemu_xxhash7(uint64_t ab, uint64_t cd, uint32_t e,
+                                    uint32_t f, uint32_t g)
+{
+    return qemu_xxhash8(ab, cd, e, f, g, 0);
 }
 
 #endif /* QEMU_XXHASH_H */
-- 
2.17.1
