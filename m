Received: from eggs.gnu.org ([209.51.188.92]:40784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gjoRw-0005qW-Ju
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:53:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gjoRv-0006bt-L0
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:53:56 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:41685)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gjoRv-0006ah-7B
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:53:55 -0500
Date: Wed, 16 Jan 2019 11:53:50 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190116165350.GA21932@flamenco>
References: <20190114165017.27298-1-cota@braap.org>
	<20190114165017.27298-2-cota@braap.org> <87fttszydz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fttszydz.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v6 1/3] cputlb: do not evict empty entries
 to the vtlb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>

On Wed, Jan 16, 2019 at 10:32:08 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > Currently we evict an entry to the victim TLB when it doesn't match
> > the current address. But it could be that there's no match because
> > the current entry is empty (i.e. all -1's, for instance via tlb_flush).
> > Do not evict the entry to the vtlb in that case.
> >
> > This change will help us keep track of the TLB's use rate, which
> > we'll use to implement a policy for dynamic TLB sizing.
> >
> > Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> > ---
> >  include/exec/cpu-all.h | 9 +++++++++
> >  accel/tcg/cputlb.c     | 2 +-
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> > index 117d2fbbca..e21140049b 100644
> > --- a/include/exec/cpu-all.h
> > +++ b/include/exec/cpu-all.h
> > @@ -362,6 +362,15 @@ static inline bool tlb_hit(target_ulong tlb_addr, target_ulong addr)
> >      return tlb_hit_page(tlb_addr, addr & TARGET_PAGE_MASK);
> >  }
> >
> > +/**
> > + * tlb_entry_is_empty - return true if the entry is not in use
> > + * @te: pointer to CPUTLBEntry
> > + */
> > +static inline bool tlb_entry_is_empty(const CPUTLBEntry *te)
> > +{
> > +    return te->addr_read == -1 && te->addr_write == -1 && te->addr_code == -1;
> > +}
> > +
> 
> This breaks on a --disable-tcg build. I think the whole block needs to
> be in a:
> 
>   #if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
> 
> now.

Good catch, thanks! I'll send a v7 with this fixed.

Thanks,

		E.
