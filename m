Received: from eggs.gnu.org ([209.51.188.92]:39036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa9l-0001TG-Qj
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:03:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa9g-0000cK-81
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:03:08 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Feb 2019 20:01:18 +1100
Message-Id: <20190204090124.26191-32-david@gibson.dropbear.id.au>
In-Reply-To: <20190204090124.26191-1-david@gibson.dropbear.id.au>
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 31/37] target/ppc: simplify VEXT_SIGNED macro in
 int_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

As pointed out by Richard: it does not need the mask argument, nor does i=
t need
the recast argument. The masking is implied by the cast argument, and the
recast is implied by the assignment.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/int_helper.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 355b6630a2..ffc9cbc4ed 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2024,19 +2024,19 @@ void helper_xxinsertw(CPUPPCState *env, target_ul=
ong xtn,
     putVSR(xtn, &xt, env);
 }
=20
-#define VEXT_SIGNED(name, element, mask, cast, recast)              \
+#define VEXT_SIGNED(name, element, cast)                            \
 void helper_##name(ppc_avr_t *r, ppc_avr_t *b)                      \
 {                                                                   \
     int i;                                                          \
     VECTOR_FOR_INORDER_I(i, element) {                              \
-        r->element[i] =3D (recast)((cast)(b->element[i] & mask));     \
+        r->element[i] =3D (cast)b->element[i];                        \
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
=20
 #define VNEG(name, element)                                         \
--=20
2.20.1
