Received: from eggs.gnu.org ([2001:4830:134:3::10]:52328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erQGw-0002dd-0M
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:37:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erQGu-0008LT-Q5
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:37:30 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:42166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erQGu-0008L4-IP
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:37:28 -0500
Received: by mail-oi0-x243.google.com with SMTP id c18so4759208oiy.9
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 07:37:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-FOV6JSaZrhD+FZ-T46n_e--suEDbha5EXAEPyW5YAEw@mail.gmail.com>
References: <20180228193125.20577-1-richard.henderson@linaro.org>
	<20180228193125.20577-13-richard.henderson@linaro.org>
	<CAFEAcA-pUMgUnR0cWd9j7n0EyTeXkMTzhPQU_fqhyaXy1hMfxw@mail.gmail.com>
	<CAFEAcA-FOV6JSaZrhD+FZ-T46n_e--suEDbha5EXAEPyW5YAEw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 15:37:07 +0000
Message-ID: <CAFEAcA-Po-HvC9Td64hydu3-ro-ji=DKgtdTmYWreZkoFzuDRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 12/16] target/arm: Decode aa64 armv8.3
 fcmla
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 1 March 2018 at 15:28, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 1 March 2018 at 13:33, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 28 February 2018 at 19:31, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

>> These don't match up with the element1 ... element4 in the
>> Arm ARM pseudocode. It's e2 and e4 that are always the same,
>> not e1 and e3. Ditto in the other functions.
>
> Specifically I think:
>  this code    pseudocode
>    e1          element2
>    e2          element1
>    e3          element4
>    e4          element2
>
> So if we renumber these to match the pseudocode
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Since this is the only issue in this patchset I propose to squash
in this:

diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index d81eb7730d..ec705cfca5 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -297,13 +297,13 @@ void HELPER(gvec_fcmlah)(void *vd, void *vn, void *vm,
     neg_imag <<= 15;

     for (i = 0; i < opr_sz / 2; i += 2) {
-        float16 e1 = n[H2(i + flip)];
-        float16 e2 = m[H2(i + flip)] ^ neg_real;
-        float16 e3 = e1;
-        float16 e4 = m[H2(i + 1 - flip)] ^ neg_imag;
+        float16 e2 = n[H2(i + flip)];
+        float16 e1 = m[H2(i + flip)] ^ neg_real;
+        float16 e4 = e2;
+        float16 e3 = m[H2(i + 1 - flip)] ^ neg_imag;

-        d[H2(i)] = float16_muladd(e1, e2, d[H2(i)], 0, fpst);
-        d[H2(i + 1)] = float16_muladd(e3, e4, d[H2(i + 1)], 0, fpst);
+        d[H2(i)] = float16_muladd(e2, e1, d[H2(i)], 0, fpst);
+        d[H2(i + 1)] = float16_muladd(e4, e3, d[H2(i + 1)], 0, fpst);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
@@ -320,21 +320,21 @@ void HELPER(gvec_fcmlah_idx)(void *vd, void *vn, void *vm,
     uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
     uint32_t neg_real = flip ^ neg_imag;
     uintptr_t i;
-    float16 e2 = m[H2(flip)];
-    float16 e4 = m[H2(1 - flip)];
+    float16 e1 = m[H2(flip)];
+    float16 e3 = m[H2(1 - flip)];

     /* Shift boolean to the sign bit so we can xor to negate.  */
     neg_real <<= 15;
     neg_imag <<= 15;
-    e2 ^= neg_real;
-    e4 ^= neg_imag;
+    e1 ^= neg_real;
+    e3 ^= neg_imag;

     for (i = 0; i < opr_sz / 2; i += 2) {
-        float16 e1 = n[H2(i + flip)];
-        float16 e3 = e1;
+        float16 e2 = n[H2(i + flip)];
+        float16 e4 = e2;

-        d[H2(i)] = float16_muladd(e1, e2, d[H2(i)], 0, fpst);
-        d[H2(i + 1)] = float16_muladd(e3, e4, d[H2(i + 1)], 0, fpst);
+        d[H2(i)] = float16_muladd(e2, e1, d[H2(i)], 0, fpst);
+        d[H2(i + 1)] = float16_muladd(e4, e3, d[H2(i + 1)], 0, fpst);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
@@ -357,13 +357,13 @@ void HELPER(gvec_fcmlas)(void *vd, void *vn, void *vm,
     neg_imag <<= 31;

     for (i = 0; i < opr_sz / 4; i += 2) {
-        float32 e1 = n[H4(i + flip)];
-        float32 e2 = m[H4(i + flip)] ^ neg_real;
-        float32 e3 = e1;
-        float32 e4 = m[H4(i + 1 - flip)] ^ neg_imag;
+        float32 e2 = n[H4(i + flip)];
+        float32 e1 = m[H4(i + flip)] ^ neg_real;
+        float32 e4 = e2;
+        float32 e3 = m[H4(i + 1 - flip)] ^ neg_imag;

-        d[H4(i)] = float32_muladd(e1, e2, d[H4(i)], 0, fpst);
-        d[H4(i + 1)] = float32_muladd(e3, e4, d[H4(i + 1)], 0, fpst);
+        d[H4(i)] = float32_muladd(e2, e1, d[H4(i)], 0, fpst);
+        d[H4(i + 1)] = float32_muladd(e4, e3, d[H4(i + 1)], 0, fpst);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
@@ -380,21 +380,21 @@ void HELPER(gvec_fcmlas_idx)(void *vd, void *vn, void *vm,
     uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
     uint32_t neg_real = flip ^ neg_imag;
     uintptr_t i;
-    float32 e2 = m[H4(flip)];
-    float32 e4 = m[H4(1 - flip)];
+    float32 e1 = m[H4(flip)];
+    float32 e3 = m[H4(1 - flip)];

     /* Shift boolean to the sign bit so we can xor to negate.  */
     neg_real <<= 31;
     neg_imag <<= 31;
-    e2 ^= neg_real;
-    e4 ^= neg_imag;
+    e1 ^= neg_real;
+    e3 ^= neg_imag;

     for (i = 0; i < opr_sz / 4; i += 2) {
-        float32 e1 = n[H4(i + flip)];
-        float32 e3 = e1;
+        float32 e2 = n[H4(i + flip)];
+        float32 e4 = e2;

-        d[H4(i)] = float32_muladd(e1, e2, d[H4(i)], 0, fpst);
-        d[H4(i + 1)] = float32_muladd(e3, e4, d[H4(i + 1)], 0, fpst);
+        d[H4(i)] = float32_muladd(e2, e1, d[H4(i)], 0, fpst);
+        d[H4(i + 1)] = float32_muladd(e4, e3, d[H4(i + 1)], 0, fpst);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
@@ -417,13 +417,13 @@ void HELPER(gvec_fcmlad)(void *vd, void *vn, void *vm,
     neg_imag <<= 63;

     for (i = 0; i < opr_sz / 8; i += 2) {
-        float64 e1 = n[i + flip];
-        float64 e2 = m[i + flip] ^ neg_real;
-        float64 e3 = e1;
-        float64 e4 = m[i + 1 - flip] ^ neg_imag;
+        float64 e2 = n[i + flip];
+        float64 e1 = m[i + flip] ^ neg_real;
+        float64 e4 = e2;
+        float64 e3 = m[i + 1 - flip] ^ neg_imag;

-        d[i] = float64_muladd(e1, e2, d[i], 0, fpst);
-        d[i + 1] = float64_muladd(e3, e4, d[i + 1], 0, fpst);
+        d[i] = float64_muladd(e2, e1, d[i], 0, fpst);
+        d[i + 1] = float64_muladd(e4, e3, d[i + 1], 0, fpst);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }

which is a basically mechanical rename, and put it into target-arm.next.

thanks
-- PMM
