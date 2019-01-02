Received: from eggs.gnu.org ([208.118.235.92]:41462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gecbq-0005rB-Tc
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 04:14:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gecbo-0007pV-Ny
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 04:14:42 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed,  2 Jan 2019 09:14:16 +0000
Message-Id: <20190102091423.21155-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190102091423.21155-1-mark.cave-ayland@ilande.co.uk>
References: <20190102091423.21155-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v5 2/9] target/ppc: switch EXTRACT_HELPER
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
