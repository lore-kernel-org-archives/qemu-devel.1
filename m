Received: from eggs.gnu.org ([209.51.188.92]:54691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gswps-0005dO-3i
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 16:40:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gswpn-0006zS-Sf
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 16:40:22 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gswpn-0006yq-NJ
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 16:40:19 -0500
Received: by mail-ot1-x341.google.com with SMTP id 32so14345864ota.12
	for <qemu-devel@nongnu.org>; Sun, 10 Feb 2019 13:40:18 -0800 (PST)
MIME-Version: 1.0
References: <20190114011122.5995-1-richard.henderson@linaro.org>
	<20190114011122.5995-4-richard.henderson@linaro.org>
	<CAFEAcA-BEfqu=BU-2y+8dUBdXsyC4n2zhZm5nZ1MofUj3cE2Lg@mail.gmail.com>
	<c37e6649-b2f9-88cf-913d-d0394a635045@linaro.org>
In-Reply-To: <c37e6649-b2f9-88cf-913d-d0394a635045@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 10 Feb 2019 21:40:06 +0000
Message-ID: <CAFEAcA-TwEh74GuvafhqFUXP_xesqC9b1oixubj=ztNa8t4a2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 03/17] target/arm: Add MTE system registers
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

On Sun, 10 Feb 2019 at 01:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/5/19 11:27 AM, Peter Maydell wrote:
> >> +++ b/target/arm/translate-a64.c
> >> @@ -1668,6 +1668,17 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
> >>          s->base.is_jmp = DISAS_UPDATE;
> >>          break;
> >>
> >> +    case 0x1c: /* TCO */
> >> +        if (!dc_isar_feature(aa64_mte_insn_reg, s)) {
> >> +            goto do_unallocated;
> >> +        }
> >> +        if (crm & 1) {
> >> +            set_pstate_bits(PSTATE_TCO);
> >> +        } else {
> >> +            clear_pstate_bits(PSTATE_TCO);
> >> +        }
> >> +        break;
> > Don't we need to break the TB here or something to pick up
> > the new value of TCO when we generate code for a following
> > load or store ? (TCO is self-synchronizing so there is no
> > requirement for an ISB before it takes effect.)
>
> Actually, we already break the TB here by default.

Do we? I didn't see any code (apart from the handling
in the DAIFSet/Clear codepaths, which aren't used for TCO).

thanks
-- PMM
