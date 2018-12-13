Received: from eggs.gnu.org ([2001:4830:134:3::10]:57413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gXaZa-0001is-0L
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 18:39:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gXaZU-0000qs-Ro
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 18:39:17 -0500
Received: from gate.crashing.org ([63.228.1.57]:39643)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <benh@kernel.crashing.org>)
	id 1gXaZU-0000iT-2g
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 18:39:12 -0500
Message-ID: <62acd980b74d7c6fd325e19890e4f9f25a74bf5d.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 14 Dec 2018 10:39:01 +1100
In-Reply-To: <a9dd602b-9eb1-f57a-ef21-31f08fc18729@linaro.org>
References: <f4349b9ee95cbd9d5b16e9033fdf0d7c9e99aebf.camel@kernel.crashing.org>
	<a9dd602b-9eb1-f57a-ef21-31f08fc18729@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC/PATCH] i386: Atomically update PTEs with mttcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On Thu, 2018-11-29 at 11:04 -0800, Richard Henderson wrote:
> 
> While I know the existing code just updates the low 32-bits, I'd rather update
> the whole entry, and make use of the old value returned from the cmpxchg.

So I had to put this on the back burner for a bit, but I'm back to it
now.

I've tried the above but it gets messy again. The i386 code can have
either 32 or 64 bits PDE/PTEs. The udpate code for the PTE is designed
so a single code path can work with either by exploiting that LE trick,
so changing that would involve more re-factoring and I'd rather avoid
changing more than strictly needed in there.

As for this:

>    pdpe = x86_ldq_phys(cs, pdpe_addr);
>     do {
>         if (!(pdpe & PG_PRESENT_MASK)) {
>             goto do_fault;
>         }
>         if (pdpe & rsvd_mask) {
>             goto do_fault_rsvd;
>         }
>         if (pdpe & PG_ACCESSED_MASK) {
>             break;
>         }
>     } while (!update_entry(cs, pdpe_addr, &pdpe, PG_ACCESSED_MASK));
>     ptep &= pdpe ^ PG_NX_MASK;

While that form of construct is nicer than the current goto restart in
my patch, in a similar way, it works for the intermediary cases but
would require some serious refactoring of the whole function for the
final PTE case.

At this point I'd rather not take chances and introduce more bugs, so
I'll post an updated variant with a few fixes but will postpone more
refactoring unless you really really want them now :)

Cheers,
Ben.
