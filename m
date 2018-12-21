Received: from eggs.gnu.org ([2001:4830:134:3::10]:57975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gaR5G-0002wn-GL
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 15:07:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gaR5A-0006ie-Gr
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 15:07:46 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53711)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gaR5A-0006g3-7Q
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 15:07:40 -0500
Date: Fri, 21 Dec 2018 14:30:37 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181221193037.GB11197@flamenco>
References: <20181220111008.24954-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181220111008.24954-1-alex.bennee@linaro.org>
Subject: Re: [Qemu-devel] [RFC PATCH] fpu: add compile time check for old
 glibc/libm and fma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, laurent.desnogues@gmail.com, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>

On Thu, Dec 20, 2018 at 11:10:08 +0000, Alex Bennée wrote:
(snip)
> +#if defined(__GLIBC__) && (__GLIBC__ == 2 && __GLIBC_MINOR__ <= 12)
> +#define QEMU_HARDFLOAT_USE_FMA 0
> +#else
> +#define QEMU_HARDFLOAT_USE_FMA 1
> +#endif
> +#else
> +#define QEMU_HARDFLOAT_USE_FMA 1
> +#endif
> +
>  /*
>   * QEMU_HARDFLOAT_USE_ISINF chooses whether to use isinf() over
>   * float{32,64}_is_infinity when !USE_FP.
> @@ -1551,6 +1570,9 @@ float32_muladd(float32 xa, float32 xb, float32 xc, int flags, float_status *s)
>      ub.s = xb;
>      uc.s = xc;
>  
> +    if (!QEMU_HARDFLOAT_USE_FMA) {
> +        goto soft;
> +    }

I don't think this should be a compile-time check; if the QEMU binary
is run on a system with a newer, fixed glibc (or any other libc), then
we'll have disabled fma hardfloat unnecessarily.

What do you think about the following?

Laurent: if you want to test the below, you can pull it from
   https://github.com/cota/qemu/tree/fma-fix

Thanks,

		Emilio
---
commit ddeec29a2c33550c5d018aeea05d45a23579ae1b
Author: Emilio G. Cota <cota@braap.org>
Date:   Fri Dec 21 14:08:57 2018 -0500

    softfloat: enforce softfloat if the host's FMA is broken
    
    The added branch is marked as unlikely and therefore its impact
    on performance (measured with fp-bench) is within the noise range
    when measured on an Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz.
    
    Laurent Desnogues <laurent.desnogues@gmail.com>
    Signed-off-by: Emilio G. Cota <cota@braap.org>

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 59eac97d10..8b3670ca9d 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1542,6 +1542,8 @@ soft_f64_muladd(float64 a, float64 b, float64 c, int flags,
     return float64_round_pack_canonical(pr, status);
 }
 
+static bool host_fma_is_broken;
+
 float32 QEMU_FLATTEN
 float32_muladd(float32 xa, float32 xb, float32 xc, int flags, float_status *s)
 {
@@ -1562,6 +1564,11 @@ float32_muladd(float32 xa, float32 xb, float32 xc, int flags, float_status *s)
     if (unlikely(!f32_is_zon3(ua, ub, uc))) {
         goto soft;
     }
+
+    if (unlikely(host_fma_is_broken)) {
+        goto soft;
+    }
+
     /*
      * When (a || b) == 0, there's no need to check for under/over flow,
      * since we know the addend is (normal || 0) and the product is 0.
@@ -1623,6 +1630,11 @@ float64_muladd(float64 xa, float64 xb, float64 xc, int flags, float_status *s)
     if (unlikely(!f64_is_zon3(ua, ub, uc))) {
         goto soft;
     }
+
+    if (unlikely(host_fma_is_broken)) {
+        goto soft;
+    }
+
     /*
      * When (a || b) == 0, there's no need to check for under/over flow,
      * since we know the addend is (normal || 0) and the product is 0.
@@ -7974,3 +7986,25 @@ float128 float128_scalbn(float128 a, int n, float_status *status)
                                          , status);
 
 }
+
+static void __attribute__((constructor)) softfloat_init(void)
+{
+    union_float64 ua, ub, uc, ur;
+
+    if (QEMU_NO_HARDFLOAT) {
+        return;
+    }
+
+    /*
+     * Test that the host's FMA is not obviously broken. For example,
+     * glibc < 2.23 can perform an incorrect FMA on certain hosts; see
+     *   https://sourceware.org/bugzilla/show_bug.cgi?id=13304
+     */
+    ua.s = 0x0020000000000001;
+    ub.s = 0x3ca0000000000000;
+    uc.s = 0x0020000000000000;
+    ur.h = fma(ua.h, ub.h, uc.h);
+    if (ur.s != 0x0020000000000001) {
+        host_fma_is_broken = true;
+    }
+}
