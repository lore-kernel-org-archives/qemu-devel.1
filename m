Received: from eggs.gnu.org ([209.51.188.92]:57779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh08k-0005py-CO
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:46:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh08g-0006cR-KI
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:46:28 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Jan 2019 09:45:37 +1100
Message-Id: <20190108224600.23125-7-david@gibson.dropbear.id.au>
In-Reply-To: <20190108224600.23125-1-david@gibson.dropbear.id.au>
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/29] target/ppc: switch EXTRACT_HELPER macros
 over to use sextract32/extract32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

These ensure that we consistently handle signed and unsigned extensions c=
orrectly
when decoding immediates from instruction opcodes.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/internal.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 8b35863549..5d460247e2 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -52,20 +52,20 @@ FUNC_MASK(mask_u64, uint64_t, 64, UINT64_MAX);
 #define EXTRACT_HELPER(name, shift, nb)                                 =
      \
 static inline uint32_t name(uint32_t opcode)                            =
      \
 {                                                                       =
      \
-    return (opcode >> (shift)) & ((1 << (nb)) - 1);                     =
      \
+    return extract32(opcode, shift, nb);                                =
      \
 }
=20
 #define EXTRACT_SHELPER(name, shift, nb)                                =
      \
 static inline int32_t name(uint32_t opcode)                             =
      \
 {                                                                       =
      \
-    return (int16_t)((opcode >> (shift)) & ((1 << (nb)) - 1));          =
      \
+    return sextract32(opcode, shift, nb);                               =
      \
 }
=20
 #define EXTRACT_HELPER_SPLIT(name, shift1, nb1, shift2, nb2)            =
      \
 static inline uint32_t name(uint32_t opcode)                            =
      \
 {                                                                       =
      \
-    return (((opcode >> (shift1)) & ((1 << (nb1)) - 1)) << nb2) |       =
      \
-            ((opcode >> (shift2)) & ((1 << (nb2)) - 1));                =
      \
+    return extract32(opcode, shift1, nb1) << nb2 |                      =
      \
+               extract32(opcode, shift2, nb2);                          =
      \
 }
=20
 #define EXTRACT_HELPER_SPLIT_3(name,                                    =
      \
--=20
2.20.1
