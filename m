Received: from eggs.gnu.org ([2001:4830:134:3::10]:56860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNLeW-0000XT-NB
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 12:42:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNLeV-0006Kc-IU
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 12:42:04 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNLeV-0006DC-5d
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 12:42:03 -0500
Received: by mail-oi1-x242.google.com with SMTP id y23so8313407oia.4
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 09:42:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181102134112.26370-4-richard.henderson@linaro.org>
References: <20181102134112.26370-1-richard.henderson@linaro.org>
	<20181102134112.26370-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Nov 2018 17:41:41 +0000
Message-ID: <CAFEAcA-96EyPc3RnR5-EveW=F+SgatMw52M0W_A=Dk0fCkOypg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.0 3/4] target/arm: Implement the
 ARMv8.1-HPD extension
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

On 2 November 2018 at 13:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Since the TCR_*.HPD bits were RES0 in ARMv8.0, we can simply
> interpret the bits as if ARMv8.1-HPD is present without checking.
> We will need a slightly different check for hpd for aarch32.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Another way to write the tail end of the loop would be
to move the nstable handling up, so:

        if (mmu_idx == ARMMMUIdx_S2NS) {
            /* Stage 2 table descriptors do not include any attribute fields */
            break;
        }
        /* Merge in attributes from table descriptors */
        attrs |= nstable << 3; /* NS */
        if (!hpd) {
            /* HPD disables all the table attributes except NSTable */
            break;
        }
        attrs |= extract32(tableattrs, 0, 2) << 11; /* XN, PXN */
        attrs |= extract32(tableattrs, 3, 1) << 5; /* APTable[1] => AP[2] */
        /* The sense of AP[1] vs APTable[0] is reversed, as APTable[0] == 1
         * means "force PL1 access only", which means forcing AP[1] to 0.
         */
        if (extract32(tableattrs, 2, 1)) {
            attrs &= ~(1 << 4);
        }
        attrs |= nstable << 3; /* NS */
        break;

which would then make the hpd handling use the same
approach we already have for "don't merge attributes if
this is a stage 2 table". But don't bother changing your
patch unless you think that's actually better.

thanks
-- PMM
