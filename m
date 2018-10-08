Received: from eggs.gnu.org ([208.118.235.92]:47176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9WmD-0001DP-Rn
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:45:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9Wk9-0003VV-BL
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:42:51 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56737)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g9Wk8-0003Uq-PA
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:42:45 -0400
Date: Mon, 8 Oct 2018 10:42:42 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181008144242.GC19899@flamenco>
References: <20181006214508.5331-1-cota@braap.org>
	<20181006214508.5331-3-cota@braap.org>
	<4dc1591e-adc9-eaaa-deea-07fd7f3470a4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dc1591e-adc9-eaaa-deea-07fd7f3470a4@linaro.org>
Subject: Re: [Qemu-devel] [RFC 2/6] cputlb: do not evict invalid entries to
 the vtlb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Pranith Kumar <bobby.prani@gmail.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Sun, Oct 07, 2018 at 19:09:01 -0700, Richard Henderson wrote:
> On 10/6/18 2:45 PM, Emilio G. Cota wrote:
> > Currently we evict an entry to the victim TLB when it doesn't match
> > the current address. But it could be that there's no match because
> > the current entry is invalid. Do not evict the entry to the vtlb
> > in that case.
> > 
> > This change will help us keep track of the TLB's use rate.
> > 
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> > ---
> >  include/exec/cpu-all.h | 14 ++++++++++++++
> >  accel/tcg/cputlb.c     |  2 +-
> >  2 files changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> > index 117d2fbbca..d938dedafc 100644
> > --- a/include/exec/cpu-all.h
> > +++ b/include/exec/cpu-all.h
> > @@ -362,6 +362,20 @@ static inline bool tlb_hit(target_ulong tlb_addr, target_ulong addr)
> >      return tlb_hit_page(tlb_addr, addr & TARGET_PAGE_MASK);
> >  }
> >  
> > +/**
> > + * tlb_is_valid - return true if at least one of the addresses is valid
> > + * @te: pointer to CPUTLBEntry
> > + *
> > + * This is useful when we don't have a particular address to compare against,
> > + * and we just want to know whether any entry holds valid data.
> > + */
> > +static inline bool tlb_is_valid(const CPUTLBEntry *te)
> > +{
> > +    return !(te->addr_read & TLB_INVALID_MASK) ||
> > +           !(te->addr_write & TLB_INVALID_MASK) ||
> > +           !(te->addr_code & TLB_INVALID_MASK);
> > +}
> 
> No, I think you misunderstand.
> 
> First, TLB_INVALID_MASK is only ever set for addr_write, in response to
> PAGE_WRITE_INV.  Second, an entry that is invalid for write is still valid for
> read+exec.  So there is benefit to swapping it out to the victim cache.
> 
> This is used by the s390x target to make the "lowpage" read-only, which is a
> special architected 512 byte range within pages 0 and 1.  This is done by
> forcing writes, but not reads, back through tlb_fill.

Aah I see. The point is to avoid pushing to the victim cache
an entry that is all invalid, not just partially invalid.

Thanks for the clarification!

		Emilio
