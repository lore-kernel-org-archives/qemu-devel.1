Received: from eggs.gnu.org ([2001:4830:134:3::10]:33906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG5nL-0000KG-Cx
	for qemu-devel@nongnu.org; Tue, 08 May 2018 12:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG5nK-0001ga-5U
	for qemu-devel@nongnu.org; Tue, 08 May 2018 12:48:55 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:36532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fG5nJ-0001fp-W4
	for qemu-devel@nongnu.org; Tue, 08 May 2018 12:48:54 -0400
Received: by mail-oi0-x244.google.com with SMTP id v2-v6so28952254oif.3
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 09:48:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180508151437.4232-8-richard.henderson@linaro.org>
References: <20180508151437.4232-1-richard.henderson@linaro.org>
	<20180508151437.4232-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 May 2018 17:48:32 +0100
Message-ID: <CAFEAcA9YdzrU7gpu3XUmGJL+QXOk+R9PaYNOxuCQVyLjt7L=hQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 07/10] target/arm: Introduce
 ARM_FEATURE_V8_ATOMICS and initial decode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 8 May 2018 at 16:14, Richard Henderson <richard.henderson@linaro.org> wrote:
> The insns in the ARMv8.1-Atomics are added to the existing
> load/store exclusive and load/store reg opcode spaces.
> Rearrange the top-level decoders for these to accomodate.
> The Atomics insns themselves still generate Unallocated.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h           |   2 +
>  linux-user/elfload.c       |   1 +
>  target/arm/translate-a64.c | 182 +++++++++++++++++++++++++++----------
>  3 files changed, 139 insertions(+), 46 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 44e6b77151..f71a78d908 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1449,6 +1449,8 @@ enum arm_features {
>      ARM_FEATURE_V8_SHA3, /* implements SHA3 part of v8 Crypto Extensions */
>      ARM_FEATURE_V8_SM3, /* implements SM3 part of v8 Crypto Extensions */
>      ARM_FEATURE_V8_SM4, /* implements SM4 part of v8 Crypto Extensions */
> +    ARM_FEATURE_V8_1,
> +    ARM_FEATURE_V8_ATOMICS = ARM_FEATURE_V8_1, /* mandatory extension */

This isn't the way we handle "this bit of the spec is mandatory
for architecture version X" for existing features. We have
a feature bit for the arch version X, and a feature bit for
the portion of the spec, and arm_cpu_realizefn() sets the
spec-portion feature bit if the version-X bit is set.
Doing it the way you have here means we can't model a
v8.0 CPU that also has the atomics extension but not the rest
of v8.1. (A v8.x implementation can include any arbitrary
subset of the v8.(x+1) features, so this is a legal combination.)

In fact we already have a mandatory-in-v8.1 feature:
ARM_FEATURE_V8_RDM, which we've just given its own feature bit.

I can apply this to target-arm.next with this change squashed in:

--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1449,8 +1449,7 @@ enum arm_features {
     ARM_FEATURE_V8_SHA3, /* implements SHA3 part of v8 Crypto Extensions */
     ARM_FEATURE_V8_SM3, /* implements SM3 part of v8 Crypto Extensions */
     ARM_FEATURE_V8_SM4, /* implements SM4 part of v8 Crypto Extensions */
-    ARM_FEATURE_V8_1,
-    ARM_FEATURE_V8_ATOMICS = ARM_FEATURE_V8_1, /* mandatory extension */
+    ARM_FEATURE_V8_ATOMICS, /* ARMv8.1-Atomics feature */
     ARM_FEATURE_V8_RDM, /* implements v8.1 simd round multiply */
     ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
     ARM_FEATURE_V8_FCMA, /* has complex number part of v8.3 extensions.  */

Is that OK?


We can have a separate patch which adds ARM_FEATURE_V8_1 and the
code in realizefn to do
    if (arm_feature(env, ARM_FEATURE_V8_1)) {
        set_feature(env, ARM_FEATURE_V8);
        set_feature(env, ARM_FEATURE_V8_ATOMICS);
        set_feature(env, ARM_FEATURE_V8_RDM);
    }

thanks
-- PMM
