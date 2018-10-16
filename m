Received: from eggs.gnu.org ([2001:4830:134:3::10]:39383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gCR1q-0006LX-Ul
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:13:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gCR1m-0004A8-1D
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:13:02 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56479)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gCR1l-00044g-P3
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:12:57 -0400
Date: Tue, 16 Oct 2018 11:12:54 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181016151254.GA4169@flamenco>
References: <20181005211450.847-1-cota@braap.org>
	<20181005211450.847-5-cota@braap.org>
	<4f8df676-f854-e7fe-afed-51099a8abffe@linaro.org>
	<6ae5b4c7-3300-2059-b648-855d7ea00488@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ae5b4c7-3300-2059-b648-855d7ea00488@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/4] cputlb: read CPUTLBEntry.addr_write
 atomically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Tue, Oct 16, 2018 at 08:03:03 +0200, Paolo Bonzini wrote:
> On 16/10/2018 04:52, Richard Henderson wrote:
> > On 10/5/18 2:14 PM, Emilio G. Cota wrote:
> >> -    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
> >> +    target_ulong tlb_addr =
> >> +        atomic_read(&env->tlb_table[mmu_idx][index].addr_write);
> > 
> > This fails for 32-bit hosts emulating 64-bit hosts.
> > I think you need a separate helper function.  Perhaps
> > 
> > static inline target_ulong tlb_addr_write(CPUTLBEntry *ent)
> > {
> > #if TCG_OVERSIZED_GUEST
> >     return ent->addr_write;
> > #else
> >     return atomic_read(&ent->addr_write);
> > #endif
> > }

Ouch, yes.

> Or just atomic_read__nocheck.

I prefer special-casing oversized guests, otherwise we risk having
compile-time errors -- like the ones we got on mingw 32-bit when
not checking for CONFIG_ATOMIC64.

> > I'm going to drop this patch from my queue for now.
> > We can fix it up this week some time.

Sounds good. I'll send a patch on top of your current tcg-next
to avoid conflicts.

Thanks,

		Emilio
