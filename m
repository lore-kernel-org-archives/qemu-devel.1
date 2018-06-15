Received: from eggs.gnu.org ([2001:4830:134:3::10]:55441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fTqnp-00064Q-Qa
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:38:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fTqnk-0005Qk-UL
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:38:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1fTqnk-0005Q8-NW
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:38:12 -0400
Date: Fri, 15 Jun 2018 08:38:09 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20180615144221.GD2165@perard.uk.xensource.com>
Message-ID: <alpine.DEB.2.10.1806150837580.14695@sstabellini-ThinkPad-X260>
References: <20180601175910.28146-1-peter.maydell@linaro.org>
	<20180605165507.GB2165@perard.uk.xensource.com>
	<CAFEAcA_X2V-YkM1ZeCHMPW3cQBk2=ZQ4BAgtcg67Eb+OuADbgQ@mail.gmail.com>
	<20180615144221.GD2165@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [RFC] xen: Don't use
 memory_region_init_ram_nomigrate() in pci_assign_dev_load_option_rom()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, "open list:X86" <xen-devel@lists.xenproject.org>

On Fri, 15 Jun 2018, Anthony PERARD wrote:
> On Fri, Jun 15, 2018 at 11:06:47AM +0100, Peter Maydell wrote:
> > On 5 June 2018 at 17:55, Anthony PERARD <anthony.perard@citrix.com> wrote:
> > > On Fri, Jun 01, 2018 at 06:59:10PM +0100, Peter Maydell wrote:
> > >> The xen pci_assign_dev_load_option_rom() currently creates a RAM
> > >> memory region with memory_region_init_ram_nomigrate(), and then
> > >> manually registers it with vmstate_register_ram(). In fact for
> > >> its only callsite, the 'owner' pointer we use for the init call
> > >> and the '&dev->qdev' pointer we use for the vmstate_register_ram()
> > >> call refer to the same object. Simplify the function to only
> > >> take a pointer to the device once instead of twice, and use
> > >> memory_region_init_ram() which automatically does the vmstate
> > >> register for us.
> > >>
> > >> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > >> ---
> > >> This is a fairly trivial no-behaviour-change code cleanup, but
> > >> I've marked it as RFC because I don't have a setup for doing
> > >> more than just compile-testing Xen related patches.
> > >> This was found as part of a sweep through for code using
> > >> the _nomigrate versions of functions.
> > >
> > > That patch looks fine, and seams fine after hacking my way into testing
> > > the change.
> > >
> > > Acked-by: Anthony PERARD <anthony.perard@citrix.com>
> > 
> > Thanks for the review. Stefano, do you want to take it via the
> > xen subtree?
> 
> Hi Peter,
> 
> We don't have any other patch for xen, so feel free to commit this
> one.

Yep, go ahead
