Received: from eggs.gnu.org ([2001:4830:134:3::10]:53066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eiTdd-0000JU-4b
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 18:23:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eiTdb-0000rO-FW
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 18:23:57 -0500
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:33371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eiTdb-0000rA-84
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 18:23:55 -0500
Received: by mail-oi0-x230.google.com with SMTP id l8so19983072oig.0
	for <qemu-devel@nongnu.org>; Sun, 04 Feb 2018 15:23:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180204212932.GB24905@lst.de>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-12-git-send-email-mjc@sifive.com>
	<20180108143105.GC10273@lst.de>
	<CAHNT7Nss8ewkpgo2OTPpBV11WaisgU5a-h22-AbotyKdVqjxwg@mail.gmail.com>
	<20180204212932.GB24905@lst.de>
From: Michael Clark <mjc@sifive.com>
Date: Mon, 5 Feb 2018 12:23:53 +1300
Message-ID: <CAHNT7NuiD4jn2BoMy3KZGqd-8zxUs4K6XAi_hxUVp0BEjAXthw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 11/21] RISC-V HTIF Console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christoph Hellwig <hch@lst.de>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Mon, Feb 5, 2018 at 10:29 AM, Christoph Hellwig <hch@lst.de> wrote:

> On Mon, Feb 05, 2018 at 09:19:46AM +1300, Michael Clark wrote:
> > BTW I've created branches in my own personal trees for Privileged ISA
> > v1.9.1. These trees are what I use for v1.9.1 backward compatibility
> > testing in QEMU:
> >
> > - https://github.com/michaeljclark/riscv-linux/tree/riscv-linux-4.6.2
> > - https://github.com/michaeljclark/riscv-pk/tree/bbl-1.9.1
>
> What MMU-enabled chips that implement 1.9.1 are out there?  If there
> is enough we should support this with a compile time option in the
> Linux kernel as well.


It's very likely that there are only test chips that are not widely
available. It's likely not worth supporting in the latest version of
linux-kernel.

That said, we've kept priv 1.9.1 support in QEMU for other reasons. There
are a lot of other OS ports and not all of them have necessarily updated to
the new spec version at the same time. We have to draw a line in the sand
somewhere, where we've decided that we're not going to break things for
folk who don't have the magic set of commit hashes. i.e. how it was prior,
at least for riscv-qemu. I know of other emulators that are still on priv
v1.9.1.

We are also going to need to be careful about backwards incompatible
device-tree changes. i.e. if we change device tree, we should target these
changes at priv v1.11 and version the device tree nodes and attributes. Non
additive changes that are not optional need to go in the next version, not
the current version.


> > We need to be a little more disciplined with software releases,
> especially
> > when there are backward incompatible changes in the specification. The
> > repos need to be branched and tagged. It should be possible to somehow
> > derive the conformance level. Perhaps the SBI should have an API for
> this.
> > This is one of the driving reasons behind adding version conformance
> levels
> > to QEMU. Previously we had repos in a state of flux and if you didn't
> have
> > the magic commit ids you were out of luck. For example, when we have
> > priv isa v1.11 released, we will still need a priv isa v1.10 mode which
> > masks out all of the new features. Given there are no "feature bits"
> > besides the extensions "IMAFDSU", all we have to go on presently is the
> > privileged ISA spec version number.
>
> As far as I can tell privileged ISA changes post 1.10 should be backwards
> compatible and only implemement detectable optional CSRs and instructions.
>

At present there is no way that I know of, other that trapping on illegal
instructions, to detect whether a CSR is implemented or not. I've written a
little tool called riscv-probe, that does such. I'll post the sources at
some point. It may very well be possible to support priv v1.11 on priv
v1.10 with trap and emulate, however it may require running the Supervisor
in U mode. I guess we'll find out whether anything is missing if we tried
to implement it. It would definately require shadow paging, given there is
second level address translation.


> That being said I started a thread on that on the privileged spec list
> where I need to follow up on Andrews mail once I get back to my work
> mail after a little vacation.
>
