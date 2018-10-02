Received: from eggs.gnu.org ([2001:4830:134:3::10]:57534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g7P7K-00087n-M9
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 14:09:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g7P7H-0006Cv-Ej
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 14:09:54 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40977)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g7P7H-0006Cp-7v
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 14:09:51 -0400
Date: Tue, 2 Oct 2018 14:09:48 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181002180948.GA19889@flamenco>
References: <20180919175423.GA25553@flamenco> <87va71uijc.fsf@linaro.org>
	<20181001183423.GA27555@flamenco> <87k1n0lu8b.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k1n0lu8b.fsf@linaro.org>
Subject: Re: [Qemu-devel] ideas for improving TLB performance (help with TCG
 backend wanted)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Pranith Kumar <bobby.prani@gmail.com>, Richard Henderson <richard.henderson@linaro.org>

On Tue, Oct 02, 2018 at 07:48:20 +0100, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > On Thu, Sep 20, 2018 at 01:19:51 +0100, Alex Bennée wrote:
> >> If we are going to have an indirection then we can also drop the
> >> requirement to scale the TLB according to the number of MMU indexes we
> >> have to support. It's fairly wasteful when a bunch of them are almost
> >> never used unless you are running stuff that uses them.
> >
> > So with dynamic TLB sizing, what you're suggesting here is to resize
> > each MMU array independently (depending on their use rate) instead
> > of using a single "TLB size" for all MMU indexes. Am I understanding
> > your point correctly?
> 
> Not quite - I think it would overly complicate the lookup to have a
> differently sized TLB lookup for each mmu index - even if their usage
> patterns are different.

It just adds a load to get the mask, which will most likely be
in the L1. The value is not used after 3 instructions later, when
the L1 read will have completed.

> I just meant that if we already have the cost of an indirection we don't
> have to ensure:
> 
>     CPUTLBEntry tlb_table[NB_MMU_MODES][CPU_TLB_SIZE];
>     CPUIOTLBEntry iotlb[NB_MMU_MODES][CPU_TLB_SIZE];
> 
> restrict their sizes so any entry in the 2D array can be indexed
> directly from env. Currently CPU_TLB_SIZE/CPU_TLB_BITS is restricted by
> the number of NB_MMU_MODES we have to support. But if each can be
> flushed and managed separately we can have:
> 
>     CPUTLBEntry *tlb_table[NB_MMU_MODES];
> 
> And size CPU_TLB_SIZE for the maximum offset we can mange in the lookup
> code. This is mainly driven by the varying
> TCG_TARGET_TLB_DISPLACEMENT_BITS each backend has available to it.

What I implemented is what you suggest, but with dynamic resizing based
on usage. I'm keeping the current CPU_TLB_SIZE as the minimum size, and
took Pranith's TCG_TARGET_TLB_MAX_INDEX_BITS definitions (from 2017)
to limit the max tlb size per mmu.

I'll prepare an RFC.

Thanks,

		Emilio
