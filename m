Received: from eggs.gnu.org ([2001:4830:134:3::10]:47128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTopD-0003mz-IG
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTopC-0005GG-Ly
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:31:35 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:40394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTopC-0005FQ-DR
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:31:34 -0400
Received: by mail-oi0-x241.google.com with SMTP id f79-v6so8787264oib.7
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 06:31:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180612204632.28780-1-jusual@mail.ru>
References: <20180612204632.28780-1-jusual@mail.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 14:31:13 +0100
Message-ID: <CAFEAcA-aODbEXPZEEGaRTLxYfrRdx5OxBQk5f4g9mvntrfLAJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Allow ARMv6-M Thumb2
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>

On 12 June 2018 at 21:46, Julia Suvorova <jusual@mail.ru> wrote:
> @@ -10085,10 +10091,25 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
>      int conds;
>      int logic_cc;
>
> -    /* The only 32 bit insn that's allowed for Thumb1 is the combined
> -     * BL/BLX prefix and suffix.
> +    /*
> +     * ARMv6-M supports a limited subset of Thumb2 instructions.
> +     * Other Thumb1 architectures allow only 32-bit
> +     * combined BL/BLX prefix and suffix.
>       */
> -    if ((insn & 0xf800e800) != 0xf000e800) {
> +    if (arm_dc_feature(s, ARM_FEATURE_M) && arm_dc_feature(s, ARM_FEATURE_V6)) {

I realized during testing that this accidentally breaks v7M and v8M,
because those cores define both ARM_FEATURE_V6 and _V7 (and _V8 for v8M),
so this condition is true and we undef on the non-v6M insns for
v7M and v8M too. I've fixed this in target-arm.next by changing the
condition to
    +    if (arm_dc_feature(s, ARM_FEATURE_M) &&
    +        !arm_dc_feature(s, ARM_FEATURE_V7)) {

thanks
-- PMM
