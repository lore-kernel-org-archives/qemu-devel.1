Received: from eggs.gnu.org ([209.51.188.92]:42940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h1iA2-0001qp-Ha
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 20:49:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h1iA1-0000sr-Ij
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 20:49:26 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:48553)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1h1iA0-0000sI-OQ
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 20:49:25 -0500
Date: Wed, 6 Mar 2019 20:49:22 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190307014922.GA15870@flamenco>
References: <5F2C0013-1D18-44A9-ADAF-F86EC6FD1174@oberlin.edu>
	<CAFEAcA8VzJRMSThWQ=CgNbB8BY0EAmi77oAJuHQt5iQnkiZmzg@mail.gmail.com>
	<63A30600-CCE3-4412-A3EB-8D535A8B21B3@oberlin.edu>
	<4F8E4327-9F59-4F50-A22D-20A3F939899F@oberlin.edu>
	<9108923c-076b-034c-9d68-af355861ae0c@linaro.org>
	<1FBF59F3-F256-4680-B2AD-199C197814C9@oberlin.edu>
	<013f91f0-1968-1400-84b2-4d4fe2ece9a6@linaro.org>
	<8F89FA7E-E952-425F-A587-66BEECF4A295@oberlin.edu>
	<a244b0af-9b69-3760-0663-dbf9a0315789@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a244b0af-9b69-3760-0663-dbf9a0315789@linaro.org>
Subject: Re: [Qemu-devel] x86 segment limits enforcement with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Stephen Checkoway <stephen.checkoway@oberlin.edu>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Feb 28, 2019 at 10:05:02 -0800, Richard Henderson wrote:
> On 2/28/19 9:18 AM, Stephen Checkoway wrote:
> > I wonder if it would make sense to maintain a small cache of TLBs. The
> > majority of cases are likely to involving setting segment registers to one
> > of a handful of segments (e.g., setting es to ds or ss). So it might be nice
> > to avoid the flushes entirely.
> Hmm.
> 
> The straight-forward approach to this would change the mapping between segment
> and mmu index, which would need to force a new translation (since mmu indexes
> are built into the generated code as constants).  It would be easy for this
> scheme to generate too many translations and slow down the system as a whole.
> 
> However, since the change to dynamic tlbs, the actual tlb is now a pointer.  So
> it might not be out of the question to simply swap TLB contents around when
> changing segment registers.  All you would need is N+1 tlbs to support the
> (easy?) case of es swapping.
> 
> With some additional work in cputlb, it might even be possible to have
> different mmu indexes share the same backing tlb.  This would be tricky to
> manage during a tlb resize, but perhaps not impossible.
> 
> Emilio, do you have any thoughts here?

I like the approach you propose. If I understood correctly, we could:

- Let target code manipulate the pointer in TLB[mmu_idx]. This way the
  target can keep for each idx a set of tables, indexed by segment register
  value. The target would detect changes to segment registers and
  update the pointer in TLB[mmu_idx].

- Add a hook from cputlb to target-specific code, so that the latter
  is notified of flushes and can therefore flush the set of tables.
  Note that resizes only occur during flushes, which makes things
  simpler.

Seems like a reasonable amount of work and won't affect much the
common path (i.e. no segmentation) -- at worst it will add the overhead
of using helpers for a small number of instructions.

Thanks,

		Emilio
