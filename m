Received: from eggs.gnu.org ([2001:4830:134:3::10]:38093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcXou-0005vU-F8
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcXoq-0001Qo-9s
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:06:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dcXoq-0001Pt-3t
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:06:44 -0400
Date: Tue, 1 Aug 2017 16:06:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170801140639.GD4257@localhost.localdomain>
References: <CAOMFOmXXRN02BT+8M+iKnrGmaTSR8uWoTYCu5A5gv+KTe9xAqg@mail.gmail.com>
	<20170730214231.GC16400@localhost.localdomain>
	<CAOMFOmUwi+jF4w7ve4iV_rrPt2uAqZDe6PMZ0r0W047yjFi-gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMFOmUwi+jF4w7ve4iV_rrPt2uAqZDe6PMZ0r0W047yjFi-gw@mail.gmail.com>
Subject: Re: [Qemu-devel] How to make ELF headers/symbol sections available
 for multiboot?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

Am 31.07.2017 um 19:21 hat Anatol Pomozov geschrieben:
> ELF sections info is needed for an OS to map address space properly.
> 
> I do not know much about production-grade OS but multiboot protocol is
> quite popular among newly created and hobby OS. Multiboot provide some
> useful information that need to be found somewhere else (e.g. by
> requesting info from BIOS).
> 
> Here is an example of Phil's Rust OS that uses multiboot to read ELF
> section information. https://os.phil-opp.com/allocating-frames/ They
> use GRUB that loads all ELF sections into memory and provides ELF info
> via multiboot structure.
> 
> It is interesting to see how LittleKernel tries to find the sections
> information by using _start/_end markers in their linker script
> https://github.com/littlekernel/lk/blob/master/arch/x86/64/kernel.ld
> And while it works, in fact it just tries to recover ELF sections
> information. And that is why I think it would be more useful if qemu
> implemented ELF sections feature from Multiboot.

Why would you calculate something at runtime by looping through the
section table when you could do this once and for all at link time?
This sounds completely inefficient and is probably a bad idea. What
littlekernel does is pretty much the standard way to do things.

This doesn't mean that the Multiboot feature is useless, but just that
the real use cases are different. Having symbol names in stack traces
is one of them.

And anyway, the feature is in the spec and QEMU implements this spec, so
I think we don't have to discuss whether having the feature would be
good. It just needs a clean implementation.

Kevin
