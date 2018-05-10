Received: from eggs.gnu.org ([2001:4830:134:3::10]:38422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGl0W-0003eB-VQ
	for qemu-devel@nongnu.org; Thu, 10 May 2018 08:49:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGl0V-000178-Up
	for qemu-devel@nongnu.org; Thu, 10 May 2018 08:49:17 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:39250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fGl0V-00016p-Py
	for qemu-devel@nongnu.org; Thu, 10 May 2018 08:49:15 -0400
Received: by mail-oi0-x244.google.com with SMTP id n65-v6so1632242oig.6
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 05:49:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180510094206.15354-3-alex.bennee@linaro.org>
References: <20180510094206.15354-1-alex.bennee@linaro.org>
	<20180510094206.15354-3-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 13:48:54 +0100
Message-ID: <CAFEAcA_8OCa_gCWzhTNhWAoabCVVNoNiN9H7zbJ1=6KJAFveSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/5] fpu/softfloat: re-factor float to
 float conversions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 10 May 2018 at 10:42, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> This allows us to delete a lot of additional boilerplate code which is
> no longer needed. Currently the ieee flag is ignored (everything is
> assumed to be ieee). Handling for ARM AHP will be in the next patch.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> ---
> v2
>   - pass FloatFmt to float_to_float instead of sizes
>   - split AHP handling to another patch
>   - use rth's suggested re-packing (+ setting .exp)
> v3
>   - also rm extractFloat16Sign
> ---
>  fpu/softfloat-specialize.h |  40 ----
>  fpu/softfloat.c            | 452 +++++++------------------------------
>  include/fpu/softfloat.h    |   8 +-
>  3 files changed, 88 insertions(+), 412 deletions(-)

This introduces a regression where we don't get tininess-before-rounding
for double/single to halfprec conversions. This is because we're
now using the fp_status_f16 status field, and it has not had
the detect_tininess setting initialized. This fixes it:

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d175c5e94f..7939c6b8ae 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -324,6 +324,8 @@ static void arm_cpu_reset(CPUState *s)
                               &env->vfp.fp_status);
     set_float_detect_tininess(float_tininess_before_rounding,
                               &env->vfp.standard_fp_status);
+    set_float_detect_tininess(float_tininess_before_rounding,
+                              &env->vfp.fp_status_f16);
 #ifndef CONFIG_USER_ONLY
     if (kvm_enabled()) {
         kvm_arm_reset_vcpu(cpu);

(You can see this if you try something like fcvt h1, d0 where
d0 =3D=3D 0x3f0f_ffff_ffff_ffff -- we get the right answer of 0x0400
but fail to set Underflow as well as Inexact.)

thanks
-- PMM
