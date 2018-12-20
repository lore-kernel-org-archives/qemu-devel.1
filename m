Received: from eggs.gnu.org ([2001:4830:134:3::10]:47707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ga1Ef-0007pb-I8
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 11:31:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ga1Ec-0000iZ-6Y
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 11:31:45 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 20 Dec 2018 16:31:16 +0000
Message-Id: <20181220163123.9233-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20181220163123.9233-1-mark.cave-ayland@ilande.co.uk>
References: <20181220163123.9233-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v3 2/9] target/ppc: switch EXTRACT_HELPER
 macros over to use sextract32/extract32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org, david@gibson.dropbear.id.au

These ensure that we consistently handle signed and unsigned extensions correctly
when decoding immediates from instruction opcodes.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/internal.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 8b35863549..5d460247e2 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -52,20 +52,20 @@ FUNC_MASK(mask_u64, uint64_t, 64, UINT64_MAX);
 #define EXTRACT_HELPER(name, shift, nb)                                       \
 static inline uint32_t name(uint32_t opcode)                                  \
 {                                                                             \
-    return (opcode >> (shift)) & ((1 << (nb)) - 1);                           \
+    return extract32(opcode, shift, nb);                                      \
 }
 
 #define EXTRACT_SHELPER(name, shift, nb)                                      \
 static inline int32_t name(uint32_t opcode)                                   \
 {                                                                             \
-    return (int16_t)((opcode >> (shift)) & ((1 << (nb)) - 1));                \
+    return sextract32(opcode, shift, nb);                                     \
 }
 
 #define EXTRACT_HELPER_SPLIT(name, shift1, nb1, shift2, nb2)                  \
 static inline uint32_t name(uint32_t opcode)                                  \
 {                                                                             \
-    return (((opcode >> (shift1)) & ((1 << (nb1)) - 1)) << nb2) |             \
-            ((opcode >> (shift2)) & ((1 << (nb2)) - 1));                      \
+    return extract32(opcode, shift1, nb1) << nb2 |                            \
+               extract32(opcode, shift2, nb2);                                \
 }
 
 #define EXTRACT_HELPER_SPLIT_3(name,                                          \
-- 
2.11.0
