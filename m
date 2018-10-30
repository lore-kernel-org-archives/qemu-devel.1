Received: from eggs.gnu.org ([2001:4830:134:3::10]:36087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gHW8a-0007bs-VB
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:41:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gHW8L-0001rT-Gd
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:41:00 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:47615)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gHW8L-0001oB-0Z
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:40:45 -0400
Date: Tue, 30 Oct 2018 11:40:41 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181030154041.GA31885@flamenco>
References: <20181029155339.15280-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029155339.15280-1-richard.henderson@linaro.org>
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On Mon, Oct 29, 2018 at 15:53:35 +0000, Richard Henderson wrote:
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

I've tested this series and the one it depends on (tlb-dirty). I had
yesterday a guest running parallel compilation jobs for ~12h with
no issues. So

Tested-by: Emilio G. Cota <cota@braap.org>

for this and the tlb-dirty series.

Richard: the crash I reported on IRC must have been due to unrelated
changes. I was testing some TLB experiments over the weekend so I must
have forgotten to rebuild.

Thanks,

		Emilio
