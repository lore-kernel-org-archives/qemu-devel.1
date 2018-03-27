Received: from eggs.gnu.org ([2001:4830:134:3::10]:58503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0s2K-0001iX-Fz
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 13:05:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0s2G-0005IO-0M
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 13:05:28 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:43365)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f0s2F-0005I5-NN
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 13:05:23 -0400
Date: Tue, 27 Mar 2018 13:05:22 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180327170522.GA2693@flamenco>
References: <1522128840-498-1-git-send-email-cota@braap.org>
	<1d2cdc9d-38f4-2274-8981-da47822ca569@mail.uni-paderborn.de>
	<f56a5272-9300-bb98-d845-563f39113c0e@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f56a5272-9300-bb98-d845-563f39113c0e@mail.uni-paderborn.de>
Subject: [Qemu-devel] [PATCH] softfloat: rename canonicalize to
 sf_canonicalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

On Tue, Mar 27, 2018 at 12:06:58 +0200, Bastian Koppelmann wrote:
> On 03/27/2018 11:56 AM, Bastian Koppelmann wrote:
> > When I try to build your tree with gcc version 7.3.1 20180312 (GCC), I get:
> > 
> >   CC      tricore-softmmu/fpu/softfloat.o
> > /home/kbastian/coding/upstream-qemu/qemu-fpu/fpu/softfloat.c:417:19:
> > error: conflicting types for ‘canonicalize’
> >  static FloatParts canonicalize(FloatParts part, const FloatFmt *parm,
> >                    ^~~~~~~~~~~~
> > In file included from /usr/include/features.h:423:0,
> >                  from /usr/include/bits/libc-header-start.h:33,
> >                  from /usr/include/math.h:27,
> >                  from
> > /home/kbastian/coding/upstream-qemu/qemu-fpu/fpu/softfloat.c:85:
> > /usr/include/bits/mathcalls.h:385:1: note: previous declaration of
> > ‘canonicalize’ was here
> >  __MATHDECL_1 (int, canonicalize,, (_Mdouble_ *__cx, const _Mdouble_ *__x));
> > 
> 
> git bisect points to fb1514a0104df6740e4a60c1b08b5daf173f9737
> 
> Author: Emilio G. Cota <cota@braap.org>
> Date:   Sat Mar 17 02:13:59 2018 -0400
> 
>     fpu: introduce hardfloat

Thanks for pointing this out.

Turns our glibc >= 2.25 defines canonicalize(), so when including math.h
we clash with theirs.

> commit eaf5ad0bc4a67bf40999e22db6f583ebc3a806ba
> Author: Joseph Myers <joseph@codesourcery.com>
> Date:   Wed Oct 26 23:14:31 2016 +0000
> 
>     Add canonicalize, canonicalizef, canonicalizel.
>     
>     TS 18661-1 defines canonicalize functions to produce a canonical
>     version of a floating-point representation.  This patch implements
>     these functions for glibc.

In v3 I'll rename our canonicalize() to sf_canonicalize(); patch
appended (you can apply this message as a patch with git am --scissors).
The patch should go before the one that includes math.h, i.e.
"fpu: introduce hardfloat".

Thanks,

		Emilio

--- 8< ---

glibc >= 2.25 defines canonicalize in commit eaf5ad0
(Add canonicalize, canonicalizef, canonicalizel., 2016-10-26).

Given that we'll be including libc's math.h soon, prepare
for this by prefixing our canonicalize() with sf_ to avoid
clashing with the libc's canonicalize().

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 fpu/softfloat.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index d0f1f65..901c507 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -414,8 +414,8 @@ static inline float64 float64_pack_raw(FloatParts p)
 }
 
 /* Canonicalize EXP and FRAC, setting CLS.  */
-static FloatParts canonicalize(FloatParts part, const FloatFmt *parm,
-                               float_status *status)
+static FloatParts sf_canonicalize(FloatParts part, const FloatFmt *parm,
+                                  float_status *status)
 {
     if (part.exp == parm->exp_max) {
         if (part.frac == 0) {
@@ -585,7 +585,7 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
 
 static FloatParts float16_unpack_canonical(float16 f, float_status *s)
 {
-    return canonicalize(float16_unpack_raw(f), &float16_params, s);
+    return sf_canonicalize(float16_unpack_raw(f), &float16_params, s);
 }
 
 static float16 float16_round_pack_canonical(FloatParts p, float_status *s)
@@ -603,7 +603,7 @@ static float16 float16_round_pack_canonical(FloatParts p, float_status *s)
 
 static FloatParts float32_unpack_canonical(float32 f, float_status *s)
 {
-    return canonicalize(float32_unpack_raw(f), &float32_params, s);
+    return sf_canonicalize(float32_unpack_raw(f), &float32_params, s);
 }
 
 static float32 float32_round_pack_canonical(FloatParts p, float_status *s)
@@ -621,7 +621,7 @@ static float32 float32_round_pack_canonical(FloatParts p, float_status *s)
 
 static FloatParts float64_unpack_canonical(float64 f, float_status *s)
 {
-    return canonicalize(float64_unpack_raw(f), &float64_params, s);
+    return sf_canonicalize(float64_unpack_raw(f), &float64_params, s);
 }
 
 static float64 float64_round_pack_canonical(FloatParts p, float_status *s)
-- 
2.7.4
