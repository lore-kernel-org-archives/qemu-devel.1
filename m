Received: from eggs.gnu.org ([2001:4830:134:3::10]:59092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d0vs0-0006JY-MZ
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 16:06:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d0vrx-0003MX-Hk
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 16:06:32 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:33322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d0vrx-0003M1-B4
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 16:06:29 -0400
Received: by mail-io0-x243.google.com with SMTP id k87so6854643ioi.0
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 13:06:29 -0700 (PDT)
Date: Thu, 20 Apr 2017 05:06:25 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20170419200625.GA2468@lianli.shorne-pla.net>
References: <cover.1492384862.git.shorne@gmail.com>
	<575d21dff52df4fa53d17e77728018453f82e8e5.1492384862.git.shorne@gmail.com>
	<382ab324-39c0-5549-ff01-3fe7cc1319de@twiddle.net>
	<20170418141846.GA2599@lianli.shorne-pla.net>
	<54fe7d09-7f47-2c7d-c0f5-2f90daf6caba@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54fe7d09-7f47-2c7d-c0f5-2f90daf6caba@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 1/7] target/openrisc: Fixes for memory
 debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, openrisc@lists.librecores.org

On Tue, Apr 18, 2017 at 08:00:06AM -0700, Richard Henderson wrote:
> On 04/18/2017 07:18 AM, Stafford Horne wrote:
> > On Tue, Apr 18, 2017 at 12:47:30AM -0700, Richard Henderson wrote:
> > > On 04/16/2017 04:23 PM, Stafford Horne wrote:
> > > > When debugging in gdb you might want to inspect instructions in mapped
> > > > pages or in exception vectors like 0x800 etc.  This was previously not
> > > > possible in qemu since the *get_phys_page_debug() routine only looked
> > > > into the data tlb.
> > > > 
> > > > Change to fall back to look into instruction tlb and plain physical
> > > > pages.
> > > > 
> > > > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > > 
> > > Oh the horrors of a software managed TLB.
> > > 
> > > You might do well to architecturally define an SPR that holds the page table
> > > base, even if for real hardware that's only used by the software refill to
> > > load up the address.
> > > 
> > > That would give qemu the option of performing a real page table walk.  This
> > > would fix this debug hook properly (so that you can examine pages that
> > > aren't in the TLB at all).  It would also optionally allow QEMU to skip the
> > > software refill, which *significantly* speeds up emulation.
> > 
> > Understood, I guess we would also need a way to represent which paging
> > model we are using (1 level, 2 level etc)?
> 
> I suppose.  You really have a 1-level lookup?  For huge pages only, or is
> this a virtual 2-level lookup with double-faulting to handle the second
> level?

We don't,  the linux kernel is implemented with basic 2-level lookup's with
single fault.  I was just thinking its not ideal for the emulator to assume
the paging model since it could change from kernel to kernel.

But I guess it will not change anytime soon.

-Stafford
