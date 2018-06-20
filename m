Received: from eggs.gnu.org ([2001:4830:134:3::10]:56502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVesO-0005Lc-JO
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVesN-0001Pd-KJ
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:18:28 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:41365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVesN-0001PV-Ee
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:18:27 -0400
Received: by mail-oi0-x241.google.com with SMTP id a141-v6so3344870oii.8
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 08:18:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180619204237.9931-1-jusual@mail.ru>
References: <20180619204237.9931-1-jusual@mail.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 16:18:06 +0100
Message-ID: <CAFEAcA9+GMnqBqKv0Edb3WJQy7882Qez9VpsHgGxTo6ZnELWaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Set strict alignment for
 ARMv6-M load/store
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>

On 19 June 2018 at 21:42, Julia Suvorova <jusual@mail.ru> wrote:
> Unlike ARMv7-M, ARMv6-M only supports naturally aligned memory accesses
> for 16-bit halfword and 32-bit word accesses using the LDR, LDRH,
> LDRSH, STR and STRH instructions.
>
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  target/arm/translate.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index b988d379e7..d923cbe98e 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -1100,7 +1100,14 @@ static inline TCGv gen_aa32_addr(DisasContext *s, TCGv_i32 a32, TCGMemOp op)
>  static void gen_aa32_ld_i32(DisasContext *s, TCGv_i32 val, TCGv_i32 a32,
>                              int index, TCGMemOp opc)
>  {
> -    TCGv addr = gen_aa32_addr(s, a32, opc);
> +    TCGv addr;
> +
> +    if (arm_dc_feature(s, ARM_FEATURE_M) &&
> +        !arm_dc_feature(s, ARM_FEATURE_V7)) {
> +        opc |= MO_ALIGN;
> +    }

Hi; I think this is a good point to introduce a
ARM_FEATURE_M_MAIN feature bit, because this is one
of those places where v8M baseline and v6M are the same.
Basically:
 * add a line to the enum arm_features:
    ARM_FEATURE_M_MAIN, /* M profile Main Extension */
 * add set_feature() calls to cortex_m3/m4/m33_initfn()
   which set that feature
 * don't set the feature for the cortex-m0
 * in these checks, use
      if (arm_dc_feature(s, ARM_FEATURE_M) &&
          !arm_dc_feature(s, ARM_FEATURE_M_MAIN)) {

A lot of the v6M checks are going to also apply for v8M
baseline, so it'll be time saved later to use the feature
bit.

(Alignment checks are a bit more complicated as strictly
v7M has a config register bit to allow turning them on,
but let's not worry about that. We can refactor the code
later if we ever care about implementing that.)

thanks
-- PMM
