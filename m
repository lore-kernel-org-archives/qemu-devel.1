Received: from eggs.gnu.org ([2001:4830:134:3::10]:46068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gSYOp-0003ew-IF
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 21:19:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gSYOj-0006kx-KM
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 21:19:23 -0500
Received: from gate.crashing.org ([63.228.1.57]:51128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <benh@kernel.crashing.org>)
	id 1gSYOh-0006iy-Ij
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 21:19:17 -0500
Message-ID: <3689b566fb9de9f95af1993299e5d5f1df23c91f.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 30 Nov 2018 13:18:51 +1100
In-Reply-To: <b8130aae-5158-bb31-73c0-82beee0ad176@linaro.org>
References: <f4349b9ee95cbd9d5b16e9033fdf0d7c9e99aebf.camel@kernel.crashing.org>
	<a9dd602b-9eb1-f57a-ef21-31f08fc18729@linaro.org>
	<408ef3b1c0bab7d26cffeb366a5ee87bb8448fa4.camel@kernel.crashing.org>
	<b8130aae-5158-bb31-73c0-82beee0ad176@linaro.org>
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

On Thu, 2018-11-29 at 16:12 -0800, Richard Henderson wrote:
> On 11/29/18 2:54 PM, Benjamin Herrenschmidt wrote:
> > >      pdpe_addr = (pml4e & PG_ADDRESS_MASK) +
> > >                  (((gphys >> 30) & 0x1ff) << 3);
> > >      pdpe = x86_ldq_phys(cs, pdpe_addr);
> > >      do {
> > >          if (!(pdpe & PG_PRESENT_MASK)) {
> > >              goto do_fault;
> > >          }
> > >          if (pdpe & rsvd_mask) {
> > >              goto do_fault_rsvd;
> > >          }
> > >          if (pdpe & PG_ACCESSED_MASK) {
> > >              break;
> > >          }
> > >      } while (!update_entry(cs, pdpe_addr, &pdpe, PG_ACCESSED_MASK));
> > >      ptep &= pdpe ^ PG_NX_MASK;
> > > 
> > > ....
> > 
> > Hrm.. I see. So not re-do the full walk. Not sure it's really worth it
> > though, how often do we expect to hit the failing case ?
> 
> It is probably rare-ish, I admit.
> 
> I suppose we could also signal "success" from update_entry if the cmpxchg
> fails, but the value that was reloaded only differs in setting PG_ACCESSED_MASK

The latter optimization is trivial. As for the former, replacing my
"goto restart" with those loops, it will make the patch significantly
bigger, though not adding another goto has its perks and the end result
might be slightly nicer ...

What way do you prefer ?

Cheers,
Ben.
