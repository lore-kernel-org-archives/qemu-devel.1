Received: from eggs.gnu.org ([2001:4830:134:3::10]:57963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g7jOO-000610-I6
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 11:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g7jOK-0000e5-IF
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 11:48:52 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:58087)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g7jOK-0000dI-45
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 11:48:48 -0400
Date: Wed, 3 Oct 2018 11:48:44 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181003154844.GA27366@flamenco>
References: <20181002212921.30982-1-cota@braap.org>
	<20181002212921.30982-3-cota@braap.org> <87h8i3l75j.fsf@linaro.org>
	<a01a9547-d182-daaf-724a-5a836dd9ff02@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a01a9547-d182-daaf-724a-5a836dd9ff02@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] cputlb: serialize tlb updates with
 env->tlb_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Wed, Oct 03, 2018 at 12:02:19 +0200, Paolo Bonzini wrote:
> On 03/10/2018 11:19, Alex Bennée wrote:
> >> Fix it by using tlb_lock, a per-vCPU lock. All updaters of tlb_table
> >> and the corresponding victim cache now hold the lock.
> >> The readers that do not hold tlb_lock must use atomic reads when
> >> reading .addr_write, since this field can be updated by other threads;
> >> the conversion to atomic reads is done in the next patch.
> > What about the inline TLB lookup code? The original purpose of the
> > cmpxchg was to ensure the inline code would either see a valid entry or
> > and invalid one, not a potentially torn read.
> > 
> 
> atomic_set also ensures that there are no torn reads.

Yes. On the reader side for inline TLB reads, we're emitting
appropriately sized loads that are guaranteed to be atomic
by the ISA. For oversized guests that isn't possible, so we
disable MTTCG.

>  However, here:
> 
> static void copy_tlb_helper_locked(CPUTLBEntry *d, const CPUTLBEntry *s)
> {
> #if TCG_OVERSIZED_GUEST
>     *d = *s;
> #else
>     if (atomic_set) {
>         d->addr_read = s->addr_read;
>         d->addr_code = s->addr_code;
>         atomic_set(&d->addend, atomic_read(&s->addend));
>         /* Pairs with flag setting in tlb_reset_dirty_range */
>         atomic_mb_set(&d->addr_write, atomic_read(&s->addr_write));
>     } else {
>         d->addr_read = s->addr_read;
>         d->addr_write = atomic_read(&s->addr_write);
>         d->addr_code = s->addr_code;
>         d->addend = atomic_read(&s->addend);
>     }
> #endif
> }
> 
> it's probably best to do all atomic_set instead of just the memberwise copy.

Atomics aren't necessary here, as long as the copy is protected by the
lock. This allows other vCPUs to see a consistent view of the data (since
they always acquire the TLB lock), and since copy_tlb is only called
by the vCPU that owns the TLB, regular reads from this vCPU will always
see consistent data.

Thanks,

		Emilio
