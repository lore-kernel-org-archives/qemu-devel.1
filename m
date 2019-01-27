Received: from eggs.gnu.org ([209.51.188.92]:53756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gngLq-0004RG-U7
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 04:03:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gngLo-0008Fs-Ss
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 04:03:37 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 27 Jan 2019 09:03:04 +0000
Message-Id: <20190127090306.30826-7-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190127090306.30826-1-mark.cave-ayland@ilande.co.uk>
References: <20190127090306.30826-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v3 6/8] target/ppc: simplify VEXT_SIGNED macro
 in int_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org, david@gibson.dropbear.id.au

As pointed out by Richard: it does not need the mask argument, nor does it need
the recast argument. The masking is implied by the cast argument, and the
recast is implied by the assignment.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 4cc7fdfd25..39f6c96543 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2038,19 +2038,19 @@ void helper_xxinsertw(CPUPPCState *env, target_ulong xtn,
     putVSR(xtn, &xt, env);
 }
 
-#define VEXT_SIGNED(name, element, mask, cast, recast)              \
+#define VEXT_SIGNED(name, element, cast)                            \
 void helper_##name(ppc_avr_t *r, ppc_avr_t *b)                      \
 {                                                                   \
     int i;                                                          \
     VECTOR_FOR_INORDER_I(i, element) {                              \
-        r->element[i] = (recast)((cast)(b->element[i] & mask));     \
+        r->element[i] = (cast)b->element[i];                        \
     }                                                               \
 }
-VEXT_SIGNED(vextsb2w, s32, UINT8_MAX, int8_t, int32_t)
-VEXT_SIGNED(vextsb2d, s64, UINT8_MAX, int8_t, int64_t)
-VEXT_SIGNED(vextsh2w, s32, UINT16_MAX, int16_t, int32_t)
-VEXT_SIGNED(vextsh2d, s64, UINT16_MAX, int16_t, int64_t)
-VEXT_SIGNED(vextsw2d, s64, UINT32_MAX, int32_t, int64_t)
+VEXT_SIGNED(vextsb2w, s32, int8_t)
+VEXT_SIGNED(vextsb2d, s64, int8_t)
+VEXT_SIGNED(vextsh2w, s32, int16_t)
+VEXT_SIGNED(vextsh2d, s64, int16_t)
+VEXT_SIGNED(vextsw2d, s64, int32_t)
 #undef VEXT_SIGNED
 
 #define VNEG(name, element)                                         \
-- 
2.11.0
