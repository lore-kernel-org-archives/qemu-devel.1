Received: from eggs.gnu.org ([209.51.188.92]:40421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dino.papararo@gmail.com>) id 1gqJFJ-0003Id-Fn
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 09:59:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dino.papararo@gmail.com>) id 1gqJEQ-0001yd-Gu
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 09:58:52 -0500
From: "Dino Papararo" <dino.papararo@gmail.com>
References: <20190130203638.21179-1-mark.cave-ayland@ilande.co.uk>
	<20190130203638.21179-9-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190130203638.21179-9-mark.cave-ayland@ilande.co.uk>
Date: Sun, 3 Feb 2019 15:58:42 +0100
Message-ID: <000301d4bbd0$f50d7ac0$df287040$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: it
Subject: [Qemu-devel] R: [PATCH v5 8/8] target/ppc: remove various
 HOST_WORDS_BIGENDIAN hacks in int_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Mark Cave-Ayland' <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org, david@gibson.dropbear.id.au

Hello Mark,
I have a question about improving speed manually unrolling loops like =
this

Assuming ARRAY_SIZE(r->u8) is always multiple of 4 you can manually =
improve loop in this way, on modern CPU non sequential instructions can =
be computed nearly for free:

> {
>     int i, j =3D (sh & 0xf);
>
> -    VECTOR_FOR_INORDER_I(i, u8) {
> -        r->u8[i] =3D j++;
> +    for (i =3D 0; i < ARRAY_SIZE(r->u8); i+=3D4,j+=3D4) {
> +        r->VsrB(i) =3D j;
> +        r->VsrB(i+1) =3D j+1;
> +        r->VsrB(i+2) =3D j+2;
> +        r->VsrB(i+3) =3D j+3; }
> }

In this patch there are a lot of functions can benefit by unrolling =
loops, with a huge speed improvement.
Maybe compiler could do it itself but aren't humans still better? =
=F0=9F=98=8A

Best Regards,
Dino Papararo

-----Messaggio originale-----
Da: Qemu-devel <qemu-devel-bounces+skizzato73=3Dmsn.com@nongnu.org> Per =
conto di Mark Cave-Ayland
Inviato: mercoled=C3=AC 30 gennaio 2019 21:37
A: qemu-devel@nongnu.org; qemu-ppc@nongnu.org; =
richard.henderson@linaro.org; david@gibson.dropbear.id.au
Oggetto: [Qemu-devel] [PATCH v5 8/8] target/ppc: remove various =
HOST_WORDS_BIGENDIAN hacks in int_helper.c

Following on from the previous work, there are numerous endian-related =
hacks in int_helper.c that can now be replaced with Vsr* macros.

There are also a few places where the VECTOR_FOR_INORDER_I macro can be =
replaced with a normal iterator since the processing order is =
irrelevant.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 155 =
++++++++++++++----------------------------------
 1 file changed, 45 insertions(+), 110 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c index =
916d10c25b..8efc283388 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -443,8 +443,8 @@ void helper_lvsl(ppc_avr_t *r, target_ulong sh)  {
     int i, j =3D (sh & 0xf);
=20
-    VECTOR_FOR_INORDER_I(i, u8) {
-        r->u8[i] =3D j++;
+    for (i =3D 0; i < ARRAY_SIZE(r->u8); i++) {
+        r->VsrB(i) =3D j++;
     }
 }
=20
@@ -452,18 +452,14 @@ void helper_lvsr(ppc_avr_t *r, target_ulong sh)  {
     int i, j =3D 0x10 - (sh & 0xf);
=20
-    VECTOR_FOR_INORDER_I(i, u8) {
-        r->u8[i] =3D j++;
+    for (i =3D 0; i < ARRAY_SIZE(r->u8); i++) {
+        r->VsrB(i) =3D j++;
     }
 }
=20
 void helper_mtvscr(CPUPPCState *env, ppc_avr_t *r)  { -#if =
defined(HOST_WORDS_BIGENDIAN)
-    env->vscr =3D r->u32[3];
-#else
-    env->vscr =3D r->u32[0];
-#endif
+    env->vscr =3D r->VsrW(3);
     set_flush_to_zero(vscr_nj, &env->vec_status);  }
=20
@@ -870,8 +866,8 @@ target_ulong helper_vclzlsbb(ppc_avr_t *r)  {
     target_ulong count =3D 0;
     int i;
-    VECTOR_FOR_INORDER_I(i, u8) {
-        if (r->u8[i] & 0x01) {
+    for (i =3D 0; i < ARRAY_SIZE(r->u8); i++) {
+        if (r->VsrB(i) & 0x01) {
             break;
         }
         count++;
@@ -883,12 +879,8 @@ target_ulong helper_vctzlsbb(ppc_avr_t *r)  {
     target_ulong count =3D 0;
     int i;
-#if defined(HOST_WORDS_BIGENDIAN)
     for (i =3D ARRAY_SIZE(r->u8) - 1; i >=3D 0; i--) { -#else
-    for (i =3D 0; i < ARRAY_SIZE(r->u8); i++) {
-#endif
-        if (r->u8[i] & 0x01) {
+        if (r->VsrB(i) & 0x01) {
             break;
         }
         count++;
@@ -1137,18 +1129,14 @@ void helper_vperm(CPUPPCState *env, ppc_avr_t =
*r, ppc_avr_t *a, ppc_avr_t *b,
     ppc_avr_t result;
     int i;
=20
-    VECTOR_FOR_INORDER_I(i, u8) {
-        int s =3D c->u8[i] & 0x1f;
-#if defined(HOST_WORDS_BIGENDIAN)
+    for (i =3D 0; i < ARRAY_SIZE(r->u8); i++) {
+        int s =3D c->VsrB(i) & 0x1f;
         int index =3D s & 0xf;
-#else
-        int index =3D 15 - (s & 0xf);
-#endif
=20
         if (s & 0x10) {
-            result.u8[i] =3D b->u8[index];
+            result.VsrB(i) =3D b->VsrB(index);
         } else {
-            result.u8[i] =3D a->u8[index];
+            result.VsrB(i) =3D a->VsrB(index);
         }
     }
     *r =3D result;
@@ -1160,18 +1148,14 @@ void helper_vpermr(CPUPPCState *env, ppc_avr_t =
*r, ppc_avr_t *a, ppc_avr_t *b,
     ppc_avr_t result;
     int i;
=20
-    VECTOR_FOR_INORDER_I(i, u8) {
-        int s =3D c->u8[i] & 0x1f;
-#if defined(HOST_WORDS_BIGENDIAN)
+    for (i =3D 0; i < ARRAY_SIZE(r->u8); i++) {
+        int s =3D c->VsrB(i) & 0x1f;
         int index =3D 15 - (s & 0xf);
-#else
-        int index =3D s & 0xf;
-#endif
=20
         if (s & 0x10) {
-            result.u8[i] =3D a->u8[index];
+            result.VsrB(i) =3D a->VsrB(index);
         } else {
-            result.u8[i] =3D b->u8[index];
+            result.VsrB(i) =3D b->VsrB(index);
         }
     }
     *r =3D result;
@@ -1868,25 +1852,14 @@ void helper_vsldoi(ppc_avr_t *r, ppc_avr_t *a, =
ppc_avr_t *b, uint32_t shift)
     int i;
     ppc_avr_t result;
=20
-#if defined(HOST_WORDS_BIGENDIAN)
     for (i =3D 0; i < ARRAY_SIZE(r->u8); i++) {
         int index =3D sh + i;
         if (index > 0xf) {
-            result.u8[i] =3D b->u8[index - 0x10];
-        } else {
-            result.u8[i] =3D a->u8[index];
-        }
-    }
-#else
-    for (i =3D 0; i < ARRAY_SIZE(r->u8); i++) {
-        int index =3D (16 - sh) + i;
-        if (index > 0xf) {
-            result.u8[i] =3D a->u8[index - 0x10];
+            result.VsrB(i) =3D b->VsrB(index - 0x10);
         } else {
-            result.u8[i] =3D b->u8[index];
+            result.VsrB(i) =3D a->VsrB(index);
         }
     }
-#endif
     *r =3D result;
 }
=20
@@ -1905,25 +1878,20 @@ void helper_vslo(ppc_avr_t *r, ppc_avr_t *a, =
ppc_avr_t *b)
=20
 /* Experimental testing shows that hardware masks the immediate.  */  =
#define _SPLAT_MASKED(element) (splat & (ARRAY_SIZE(r->element) - 1)) =
-#if defined(HOST_WORDS_BIGENDIAN)  #define SPLAT_ELEMENT(element) =
_SPLAT_MASKED(element) -#else
-#define SPLAT_ELEMENT(element)                                  \
-    (ARRAY_SIZE(r->element) - 1 - _SPLAT_MASKED(element))
-#endif
-#define VSPLT(suffix, element)                                          =
\
+#define VSPLT(suffix, element, access)                                  =
\
     void helper_vsplt##suffix(ppc_avr_t *r, ppc_avr_t *b, uint32_t =
splat) \
     {                                                                   =
\
-        uint32_t s =3D b->element[SPLAT_ELEMENT(element)];              =
  \
+        uint32_t s =3D b->access(SPLAT_ELEMENT(element));               =
  \
         int i;                                                          =
\
                                                                         =
\
         for (i =3D 0; i < ARRAY_SIZE(r->element); i++) {                =
  \
-            r->element[i] =3D s;                                        =
  \
+            r->access(i) =3D s;                                         =
  \
         }                                                               =
\
     }
-VSPLT(b, u8)
-VSPLT(h, u16)
-VSPLT(w, u32)
+VSPLT(b, u8, VsrB)
+VSPLT(h, u16, VsrH)
+VSPLT(w, u32, VsrW)
 #undef VSPLT
 #undef SPLAT_ELEMENT
 #undef _SPLAT_MASKED
@@ -1984,17 +1952,10 @@ void helper_xxextractuw(CPUPPCState *env, =
target_ulong xtn,
     getVSR(xbn, &xb, env);
     memset(&xt, 0, sizeof(xt));
=20
-#if defined(HOST_WORDS_BIGENDIAN)
     ext_index =3D index;
     for (i =3D 0; i < es; i++, ext_index++) {
-        xt.u8[8 - es + i] =3D xb.u8[ext_index % 16];
-    }
-#else
-    ext_index =3D 15 - index;
-    for (i =3D es - 1; i >=3D 0; i--, ext_index--) {
-        xt.u8[8 + i] =3D xb.u8[ext_index % 16];
+        xt.VsrB(8 - es + i) =3D xb.VsrB(ext_index % 16);
     }
-#endif
=20
     putVSR(xtn, &xt, env);
 }
@@ -2009,17 +1970,10 @@ void helper_xxinsertw(CPUPPCState *env, =
target_ulong xtn,
     getVSR(xbn, &xb, env);
     getVSR(xtn, &xt, env);
=20
-#if defined(HOST_WORDS_BIGENDIAN)
     ins_index =3D index;
     for (i =3D 0; i < es && ins_index < 16; i++, ins_index++) {
-        xt.u8[ins_index] =3D xb.u8[8 - es + i];
-    }
-#else
-    ins_index =3D 15 - index;
-    for (i =3D es - 1; i >=3D 0 && ins_index >=3D 0; i--, ins_index--) =
{
-        xt.u8[ins_index] =3D xb.u8[8 + i];
+        xt.VsrB(ins_index) =3D xb.VsrB(8 - es + i);
     }
-#endif
=20
     putVSR(xtn, &xt, env);
 }
@@ -2028,7 +1982,7 @@ void helper_xxinsertw(CPUPPCState *env, =
target_ulong xtn,
 void helper_##name(ppc_avr_t *r, ppc_avr_t *b)                      \
 {                                                                   \
     int i;                                                          \
-    VECTOR_FOR_INORDER_I(i, element) {                              \
+    for (i =3D 0; i < ARRAY_SIZE(r->element); i++) {                  \
         r->element[i] =3D (cast)b->element[i];                        \
     }                                                               \
 }
@@ -2043,7 +1997,7 @@ VEXT_SIGNED(vextsw2d, s64, int32_t)
 void helper_##name(ppc_avr_t *r, ppc_avr_t *b)                      \
 {                                                                   \
     int i;                                                          \
-    VECTOR_FOR_INORDER_I(i, element) {                              \
+    for (i =3D 0; i < ARRAY_SIZE(r->element); i++) {                  \
         r->element[i] =3D -b->element[i];                             \
     }                                                               \
 }
@@ -2115,17 +2069,13 @@ void helper_vsumsws(CPUPPCState *env, ppc_avr_t =
*r, ppc_avr_t *a, ppc_avr_t *b)
     ppc_avr_t result;
     int sat =3D 0;
=20
-#if defined(HOST_WORDS_BIGENDIAN)
-    upper =3D ARRAY_SIZE(r->s32)-1;
-#else
-    upper =3D 0;
-#endif
-    t =3D (int64_t)b->s32[upper];
+    upper =3D ARRAY_SIZE(r->s32) - 1;
+    t =3D (int64_t)b->VsrSW(upper);
     for (i =3D 0; i < ARRAY_SIZE(r->s32); i++) {
-        t +=3D a->s32[i];
-        result.s32[i] =3D 0;
+        t +=3D a->VsrSW(i);
+        result.VsrSW(i) =3D 0;
     }
-    result.s32[upper] =3D cvtsdsw(t, &sat);
+    result.VsrSW(upper) =3D cvtsdsw(t, &sat);
     *r =3D result;
=20
     if (sat) {
@@ -2139,19 +2089,15 @@ void helper_vsum2sws(CPUPPCState *env, ppc_avr_t =
*r, ppc_avr_t *a, ppc_avr_t *b)
     ppc_avr_t result;
     int sat =3D 0;
=20
-#if defined(HOST_WORDS_BIGENDIAN)
     upper =3D 1;
-#else
-    upper =3D 0;
-#endif
     for (i =3D 0; i < ARRAY_SIZE(r->u64); i++) {
-        int64_t t =3D (int64_t)b->s32[upper + i * 2];
+        int64_t t =3D (int64_t)b->VsrSW(upper + i * 2);
=20
-        result.u64[i] =3D 0;
+        result.VsrW(i) =3D 0;
         for (j =3D 0; j < ARRAY_SIZE(r->u64); j++) {
-            t +=3D a->s32[2 * i + j];
+            t +=3D a->VsrSW(2 * i + j);
         }
-        result.s32[upper + i * 2] =3D cvtsdsw(t, &sat);
+        result.VsrSW(upper + i * 2) =3D cvtsdsw(t, &sat);
     }
=20
     *r =3D result;
@@ -2276,7 +2222,7 @@ VUPK(lsw, s64, s32, UPKLO)
     {                                                                   =
\
         int i;                                                          =
\
                                                                         =
\
-        VECTOR_FOR_INORDER_I(i, element) {                              =
\
+        for (i =3D 0; i < ARRAY_SIZE(r->element); i++) {                =
  \
             r->element[i] =3D name(b->element[i]);                      =
  \
         }                                                               =
\
     }
@@ -2616,20 +2562,12 @@ static int bcd_cmp_zero(ppc_avr_t *bcd)
=20
 static uint16_t get_national_digit(ppc_avr_t *reg, int n)  { -#if =
defined(HOST_WORDS_BIGENDIAN)
-    return reg->u16[7 - n];
-#else
-    return reg->u16[n];
-#endif
+    return reg->VsrH(7 - n);
 }
=20
 static void set_national_digit(ppc_avr_t *reg, uint8_t val, int n)  { =
-#if defined(HOST_WORDS_BIGENDIAN)
-    reg->u16[7 - n] =3D val;
-#else
-    reg->u16[n] =3D val;
-#endif
+    reg->VsrH(7 - n) =3D val;
 }
=20
 static int bcd_cmp_mag(ppc_avr_t *a, ppc_avr_t *b) @@ -3373,14 +3311,11 =
@@ void helper_vpermxor(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, =
ppc_avr_t *c)
     ppc_avr_t result;
     int i;
=20
-    VECTOR_FOR_INORDER_I(i, u8) {
-        int indexA =3D c->u8[i] >> 4;
-        int indexB =3D c->u8[i] & 0xF;
-#if defined(HOST_WORDS_BIGENDIAN)
-        result.u8[i] =3D a->u8[indexA] ^ b->u8[indexB];
-#else
-        result.u8[i] =3D a->u8[15-indexA] ^ b->u8[15-indexB];
-#endif
+    for (i =3D 0; i < ARRAY_SIZE(r->u8); i++) {
+        int indexA =3D c->VsrB(i) >> 4;
+        int indexB =3D c->VsrB(i) & 0xF;
+
+        result.VsrB(i) =3D a->VsrB(indexA) ^ b->VsrB(indexB);
     }
     *r =3D result;
 }
--
2.11.0
