Received: from eggs.gnu.org ([2001:4830:134:3::10]:42495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fBcXE-0001Mk-2g
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 04:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fBcXC-0002OR-Tp
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 04:45:48 -0400
Message-ID: <1524732340.23669.21.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 26 Apr 2018 10:45:40 +0200
In-Reply-To: <20180426005555.GA8800@umbus.fritz.box>
References: <20180419062917.31486-1-david@gibson.dropbear.id.au>
	<1524151804.3017.9.camel@redhat.com>
	<20180420023542.GD2434@umbus.fritz.box>
	<1524216670.3017.11.camel@redhat.com>
	<20180420102117.GQ2434@umbus.fritz.box>
	<1524672566.23669.15.camel@redhat.com>
	<20180426005555.GA8800@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC for-2.13 0/7] spapr: Clean up pagesize
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: groug@kaod.org, aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org

On Thu, 2018-04-26 at 10:55 +1000, David Gibson wrote:
> On Wed, Apr 25, 2018 at 06:09:26PM +0200, Andrea Bolognani wrote:
> > The new parameter would make it possible to make sure you will
> > actually be able to use the page size you're interested in inside
> > the guest, by preventing it from starting at all if the host didn't
> > provide big enough backing pages;
> 
> That's right
> 
> > it would also ensure the guest
> > gets access to different page sizes when running using TCG as an
> > accelerator instead of KVM.
> 
> Uh.. it would ensure the guest *doesn't* get access to different page
> sizes in TCG vs. KVM.  Is that what you meant to say?

Oops, looks like I accidentally a word there. Of course you got it
right and I meant exactly the opposite of what I actually wrote :/

> > For a KVM guest running on a POWER8 host, the matrix would look
> > like
> > 
> >     b \ m | 64 KiB |  2 MiB | 16 MiB |  1 GiB | 16 GiB |
> >   -------- -------- -------- -------- -------- --------
> >    64 KiB | 64 KiB | 64 KiB |        |        |        |
> >   -------- -------- -------- -------- -------- --------
> >    16 MiB | 64 KiB | 64 KiB | 16 MiB | 16 MiB |        |
> >   -------- -------- -------- -------- -------- --------
> >    16 GiB | 64 KiB | 64 KiB | 16 MiB | 16 MiB | 16 GiB |
> >   -------- -------- -------- -------- -------- --------
> > 
> > with backing page sizes from top to bottom, requested max page
> > sizes from left to right, actual max page sizes in the cells and
> > empty cells meaning the guest won't be able to start; on a POWER9
> > machine, the matrix would look like
> > 
> >     b \ m | 64 KiB |  2 MiB | 16 MiB |  1 GiB | 16 GiB |
> >   -------- -------- -------- -------- -------- --------
> >    64 KiB | 64 KiB | 64 KiB |        |        |        |
> >   -------- -------- -------- -------- -------- --------
> >     2 MiB | 64 KiB | 64 KiB |        |        |        |
> >   -------- -------- -------- -------- -------- --------
> >     1 GiB | 64 KiB | 64 KiB | 16 MiB | 16 MiB |        |
> >   -------- -------- -------- -------- -------- --------
> > 
> > instead, and finally on TCG the backing page size wouldn't matter
> > and you would simply have
> > 
> >     b \ m | 64 KiB |  2 MiB | 16 MiB |  1 GiB | 16 GiB |
> >   -------- -------- -------- -------- -------- --------
> >           | 64 KiB | 64 KiB | 16 MiB | 16 MiB | 16 GiB |
> >   -------- -------- -------- -------- -------- --------
> > 
> > Does everything up until here make sense?
> 
> Yes, that all looks right.

Cool.

Unfortunately, that pretty much seals the deal on libvirt *not* being
able to infer the value from other guest settings :(

The only reasonable candidate would be the size of host pages used for
backing guest memory; however

  * TCG, RPT and KVM PR guests can't infer anything from it, as they
    are not tied to it. Having different behaviors for TCG and KVM
    would be easy, but differentiating between HPT KVM HV guest and
    all other kinds is something we can't do at the moment, and that
    in the past have actively resisted doing;

  * the user might want to limit things further, eg. preventing an
    HPT KVM HV guest backed by 16 MiB pages or an HPT TCG guest from
    using hugepages.

With the second use case in mind: would it make sense, or even be
possible, to make it so the capability works for RPT guests too?

Thinking even further, what about other architectures? Is this
something they might want to do too? The scenario I have in mind is
guests backed by regular pages being prevented from using hugepages
with the rationale that they wouldn't have the same performance
characteristics as if they were backed by hugepages; on the opposite
side of the spectrum, you might want to ensure the pages used to
back guest memory are as big as the biggest page you plan to use in
the guest, in order to guarantee the performance characteristics
fully match expectations.

> > While trying to figure out this, one of the things I attempted to
> > do was run a guest in POWER8 compatibility mode on a POWER9 host
> > and use hugepages for backing, but that didn't seem to work at
> > all, possibly hinting at the fact that not all of the above is
> > actually accurate and I need you to correct me :)
> > [...]
> 
> Ok, so note that the scheme I'm talking about here is *not* merged as
> yet.  The above command line will run the guest with 2MiB backing.
> 
> With the existing code that should work, but the guest will only be
> able to use 64kiB pages.

Understood: even without the ability to limit it further, the max
guest page size is obviously still capped by the backing page size.

> If it didn't work at all.. there was a bug
> fixed relatively recently that broke all hugepage backing, so you
> could try updating to a more recent host kernel.

That was probably it then!

I'll see whether I can get a newer kernel running on the host, but
my primary concern was not having gotten the command line (or the
concepts above) completely wrong :)

-- 
Andrea Bolognani / Red Hat / Virtualization
