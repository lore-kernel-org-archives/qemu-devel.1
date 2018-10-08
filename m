Received: from eggs.gnu.org ([2001:4830:134:3::10]:50554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9WGo-0001jR-39
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9WGk-0001K0-Md
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:12:26 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33977)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g9WGk-0001JN-GB
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:12:22 -0400
Date: Mon, 8 Oct 2018 10:12:19 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181008141219.GB19899@flamenco>
References: <20181005211450.847-1-cota@braap.org>
	<20181005211450.847-4-cota@braap.org> <8736tgo81t.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8736tgo81t.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v3 3/4] cputlb: serialize tlb updates with
 env->tlb_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Oct 08, 2018 at 14:57:18 +0100, Alex Bennée wrote:
> Emilio G. Cota <cota@braap.org> writes:
> > The readers that do not hold tlb_lock must use atomic reads when
> > reading .addr_write, since this field can be updated by other threads;
> > the conversion to atomic reads is done in the next patch.
> 
> We don't enforce this for the TCG code - but rely on the backend ISA's
> to avoid torn reads from updates from cputlb that could invalidate an
> entry.

We do enforce it though; the TLB reads we emit in TCG backend
code are appropriately sized to guarantee atomic reads.

> > -/* For atomic correctness when running MTTCG we need to use the right
> > - * primitives when copying entries */
> > -static inline void copy_tlb_helper(CPUTLBEntry *d, CPUTLBEntry *s,
> > -                                   bool atomic_set)
> > +/* Called with tlb_lock held */
> > +static inline void copy_tlb_helper_locked(CPUTLBEntry *d, const CPUTLBEntry *s)
> >  {
> > -#if TCG_OVERSIZED_GUEST
> >      *d = *s;
> 
> In general I'm happy with the patch set but what ensures that this
> always DRT with respect to the TCG code reads that race with it?

copy_tlb_helper is only called by the "owner" CPU, so it cannot
race with TCG code (i.e. the owner thread cannot race with itself).

I wanted to add an assert_cpu_is_self(cpu) here, but that needs
a CPUState pointer. Maybe I should just get rid of the function?
All the callers have the assert, so that might make the code
clearer.

Thanks,

		Emilio
