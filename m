Received: from eggs.gnu.org ([2001:4830:134:3::10]:50380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dWlJA-0003ma-00
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 11:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dWlJ8-0005D3-HE
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 11:18:08 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:54460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dWlJ8-0005CZ-AB
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 11:18:06 -0400
Date: Sun, 16 Jul 2017 17:18:02 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170716151802.cmaz3zhucqlgaq5r@aurel32.net>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-7-rth@twiddle.net>
	<20170715221412.3yprwf5i3te4gdxa@aurel32.net>
	<65cb9165-42a1-9648-7519-0bd893c1ac13@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65cb9165-42a1-9648-7519-0bd893c1ac13@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 06/27] target/sh4: Handle user-space
 atomics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

On 2017-07-15 16:30, Richard Henderson wrote:
> On 07/15/2017 12:14 PM, Aurelien Jarno wrote:
> > On 2017-07-06 16:20, Richard Henderson wrote:
> > > For uniprocessors, SH4 uses optimistic restartable atomic sequences.
> > > Upon an interrupt, a real kernel would simply notice magic values in
> > > the registers and reset the PC to the start of the sequence.
> > > 
> > > For QEMU, we cannot do this in quite the same way.  Instead, we notice
> > > the normal start of such a sequence (mov #-x,r15), and start a new TB
> > > that can be executed under cpu_exec_step_atomic.
> > 
> > Do you have actually have a good documentation about gUSA? I have found
> > a few documents (some of them in Japanese), the most complete one being
> > the LinuxTag paper. The ABI is also described in the kernel and the
> > glibc. That said I am missing the following informations:
> 
> Kernel sources and glibc are good.  The description in GCC is pretty good as well:
> 
> https://gcc.gnu.org/viewcvs/gcc/trunk/gcc/config/sh/sync.md?revision=243994&view=markup#l53

Thanks for the pointer.

> > - What kind of instructions are allowed in the atomic sequence? Your
> >    patch takes into account branches, but are there allowed? used in
> >    practice? What about FP instructions?
> 
> Any sequence that can be restarted.

Ok. So I guess it means a sequence with branch taken or not taken is
possible. The same way I guess that another instruction than a mov to
set a negative stack pointer and start the sequence is also possible,
also not emitted by glibc or gcc.

Therefore we should consider this patchset to cover 99% of the
most common case. Of course the 1% remaining cases are not handled as
atomic, but besides that kept being correctly emulated.

> > - Does the atomic sequence is actually allowed to cross pages?
> 
> I don't see why not.  It would be restarted on a page fault, but assuming
> that a process can have 2 pages in ram doesn't seem onerous.

Ok. Same comment as above.

> > - Is there any alignement required? The paper mention adding a nop to
> >    gUSA_exchange_and_add to align the end point to 4 bytes.
> 
> That's about the mov.l instruction that computes the address.

I guess you mean mova. That make senses, and actually doesn't impact
QEMU.
 
> > This looks fine. I guess this can be improved in a another patch by
> > changing the caller to pass a single target address and if the condition
> > is true or false. This would avoid having to detect that here, and would
> > not make the code below more complicated.
> 
> Sure.
> 
> > > +    if (ctx->tbflags & GUSA_EXCLUSIVE) {
> > > +        /* Regardless of single-stepping or the end of the page,
> > > +           we must complete execution of the gUSA region while
> > > +           holding the exclusive lock.  */
> > > +        *pmax_insns = max_insns;
> > > +        return 0;
> > >       }
> > 
> > What are the consequence of not stopping the translation when crossing
> > the page in user mode? If it doesn't have any, we should probably change
> > the code to never stop when crossing pages.
> 
> The only consequence is recognizing a segv "too early".  It's a quirk that,
> frankly, I'm willing to accept.

Ok.

> > > +    if (ctx.tbflags & GUSA_EXCLUSIVE) {
> > > +        /* Ending the region of exclusivity.  Clear the bits.  */
> > > +        ctx.envflags &= ~GUSA_MASK;
> > > +    }
> > > +
> > 
> > IIUC this assumes the number of instructions in the sequence is always
> > executed. I guess this is not correct if the TCG op buffer is full. Some
> > non-privileged instructions might also stop the translation, but they
> > are all FPU instructions, so I guess the section is simply not valid in
> > that case.
> 
> The TCG op buffer is always empty when we begin the sequence.  Since we're
> limited to 128 bytes, or 64 instructions, I'm not concerned about running
> out. I attempt to make sure that all of the paths out -- like exceptions and
> branches -- that don't do what we want have GUSA state zapped.
> 
> At which point ya gets what ya gets.  Not atomic, but not really wrong either.
> 

Thanks for all the details, things are much clearer now. Therefore:

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>


That said for further improvements did you consider decoding the gUSA
section in a helper. It might avoid having to emulate the atomic
sequence with 3 TBs in the worst case (the original one, the one to
decode the sequence and the one holding the exclusive lock). The helper
should directly have access to the r0 value, can decode the atomic 
sequence and translate it into a call to the corresponding atomic
helpers. In the best case that means the sequence can be done in the
same TB. In the worst case, where the gUSA sequence is not recognized
it means two TB.

I am might have forgotten something though.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
