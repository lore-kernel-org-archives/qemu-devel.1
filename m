Received: from eggs.gnu.org ([2001:4830:134:3::10]:40403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dc8r9-0005dA-Vg
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 07:27:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dc8r8-0003ot-TF
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 07:27:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dc8r8-0003nA-N4
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 07:27:26 -0400
Date: Mon, 31 Jul 2017 13:27:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170731112720.GA12064@localhost.localdomain>
References: <CAOMFOmXXRN02BT+8M+iKnrGmaTSR8uWoTYCu5A5gv+KTe9xAqg@mail.gmail.com>
	<20170730214231.GC16400@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170730214231.GC16400@localhost.localdomain>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

Am 30.07.2017 um 23:42 hat Eduardo Habkost geschrieben:
> CCing Alex, the original author of load_multiboot(), and Kevin,
> who touched multiboot code recently.

For some values of "recently". :-)

> On Fri, Jul 28, 2017 at 02:28:34PM -0700, Anatol Pomozov wrote:
> > Hi
> > 
> > I am looking at x86 multiboot code and trying to add "ELF section
> > header" info feature. This will let target to learn more about booted
> > binary and its sections.
> 
> Are there existing OSes that use that information?

You mean, like, relevant ones? I've used this feature before myself and
I think I've seen others use it for OSes that will never spread much
beyond their own computer, but from the more popular OSes that implement
Multiboot, it seems that at least NetBSD and the Hurd (or really GNU
Mach) are making some use of it.

> > I have a draft here
> > https://github.com/anatol/qemu/commit/ad943a6eb78feee048b6bb2a1e5f49f5b686e24c
> > 
> > My understanding is that qemu multiboot loads only TEXT/BSS/DATA
> > sections. Other stuff like symbols sections and ELF headers are not
> > available for target.
> > 
> > So I need to perform 2 things:
> > 
> >  - Load ELF section headers into target's memory. I did by appending
> > additional space to mbs.mb_buf and copying header data. Is it the best
> > way to do?

I think I would have done the same.

> >  - Next I need to load other ELF sections such as symbols (e.g.
> > .shstrtab) that store section names. What is the best way to do in
> > multiboo.c code? Would it make sense to load all ELF sections?

I think that the functions in include/hw/elf_ops.h (specifically
load_symbols32) might already do most of what you need. This file is
just a bit hard to navigate because the function names are composed by
preprocessor macros.

In the end it seems to fill a global variable struct syminfo *syminfos.
Maybe you can get the information you need from there, though it seems
to have been processed (keep only function symbols, sort the list). It
would be more correct to provide the original symbol table.

Kevin
