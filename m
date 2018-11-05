Received: from eggs.gnu.org ([2001:4830:134:3::10]:46857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJhm9-0000lN-9X
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:30:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJhm7-0007zb-Nk
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:30:53 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39530)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJhm7-0007qs-82
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:30:51 -0500
Received: by mail-ot1-x342.google.com with SMTP id g27so8529043oth.6
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 08:30:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181029155339.15280-1-richard.henderson@linaro.org>
References: <20181029155339.15280-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 16:30:25 +0000
Message-ID: <CAFEAcA9=a_V+NCeN63sXMX++oyApEArRRrQV1LBpP3J4BFBQSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/4] target/arm: Minimize TLB flushing for
 ASID changes
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

On 29 October 2018 at 15:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> In http://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg04181.html
> (already upstream) I added a check for ASID changes without realizing
> that TTBCR_EL1 has the A1 bit, controlling which register actually
> contains the active ASID.
>
> In http://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg04182.html
> I suggested a set of mmu_idx to flush when the ASID does change.  In
> follow-up, Peter suggested more.
>
> I now choose secure vs non-secure mmu_idx based on which register is being
> modified, not the current state of the cpu.  Unless I am mistaken, secure
> state can write to the non-secure registers.  Which means that the current
> state of the cpu is irrelevant and only the register matters.
>
> Peter suggested flushing S1E3 when changing ttbr0_s.  I can see how this
> is overlapped onto the EL3 (Secure Monitor) state, but I cannot see how
> the ASID is used from EL3.  The best evidence I can find for this is that
> there is no TLBIASID* register that is applicable to flushing EL3; that's
> not conclusive proof though.  So while I'm not sure it's necessary, I'm
> also not sure it isn't necessary, and so I've included S1E3 in the flush.
>
> I now also use the VMID to conditionally invalidate the stage 2 translation
> state.  This shows how I anticipaged @depmap to be used in patch 1.

Hi; just a note that I'm deferring this series to 4.0, so may
not get to reviewing it for a bit.

thanks
-- PMM
