Received: from eggs.gnu.org ([2001:4830:134:3::10]:34836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cgFQZ-0002NR-Jb
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:44:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cgFQV-0004AC-K2
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:44:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cgFQV-0004A6-BE
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:44:39 -0500
Date: Tue, 21 Feb 2017 11:44:35 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170221114435.2025350d@t450s.home>
In-Reply-To: <CAFEAcA-L-ofsPmyOMhnAxUnkhHy0Zs1j2uCbUVRHV6a+WG0Thw@mail.gmail.com>
References: <1487659615-15820-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<20170221092137.5b6cecbb@t450s.home>
	<27972408-a43b-60f9-86ad-e4e47f4f8f14@redhat.com>
	<CAFEAcA-L-ofsPmyOMhnAxUnkhHy0Zs1j2uCbUVRHV6a+WG0Thw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory: make ram device read/write endian
 sensitive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yongji Xie <xyjxie@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, zhong@linux.vnet.ibm.com

On Tue, 21 Feb 2017 18:09:04 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 21 February 2017 at 16:34, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> >
> > On 21/02/2017 17:21, Alex Williamson wrote:  
> >> On Tue, 21 Feb 2017 14:46:55 +0800
> >> Yongji Xie <xyjxie@linux.vnet.ibm.com> wrote:
> >>  
> >>> At the moment ram device's memory regions are NATIVE_ENDIAN. This does
> >>> not work on PPC64 because VFIO PCI device is little endian but PPC64
> >>> always defines static macro TARGET_WORDS_BIGENDIAN.
> >>>
> >>> This fixes endianness for ram device the same way as it is done
> >>> for VFIO region in commit 6758008e2c4e79fb6bd04fe8e7a41665fa583965.  
> >>
> >> The referenced commit was to vfio code where the endianness is fixed,
> >> here you're modifying shared generic code to assume the same
> >> endianness as vfio.  That seems wrong.  
> >
> > Is the goal to have the same endianness as VFIO?  Or is it just a trick
> > to ensure the number of swaps is always 0 or 2, so that they cancel away?
> >
> > In other words, would Yongji's patch just work if it used
> > DEVICE_BIG_ENDIAN and beNN_to_cpu/cpu_to_beNN?  If so, then I think the
> > patch is okay.  
> 
> I think any patch that proposes adding or removing one or more
> endianness related swaps should come with a commit message that
> states very clearly why this exact point in the stack is the
> correct place to do these swaps, from a design point of view.
> (This is so we can avoid the pitfall of putting in enough swaps
> to cancel each other out but at the wrong point in the design.)
> 
> In this instance I don't understand the patch. The ram_device
> mem-ops are there to deal with memory regions backed by a
> lump of RAM, right? Lumps of memory are always the endianness
> of the host CPU by definition, so DEVICE_NATIVE_ENDIAN and
> no swapping in the accessors seems like it ought to be the right
> thing...

I'm glad I'm not the only one confused.  The clarity I can add is that
for vfio, we define that any read/write to the vfio file descriptor is
little endian.  The kernel does cpu_to_leXX/leXX_to_cpu around the
ioreadXX/iowriteXX calls.  For better or worse, this gets us around the
implicit CPU endianness of the data there and gives us a standard
endianness.  mmaps are of course device native endian, but the point of
the ram device was that some devices (realtek NICs) don't respond well
to using memcpy through the mmap and we're better off using explicit
reads and writes.

The part where I get lost is that if PPC64 always sets the target
to big endian, then adjust_endianness() we will always bswap after a
read and before a write.  I don't follow how that bswap necessarily
gets us to QEMU CPU endian such that the cpu_to_leXX/leXX_to_cpu in the
access functions always do the right thing.  I know we do this
elsewhere in vfio, perhaps I've deferred to someone convincing me it
was the right thing at the time, but I'm not able to derive it myself
currently.

To answer Paolo's question, if PPC64 sets TARGET_WORDS_BIGENDIAN, which
is a compile time setting, then using DEVICE_BIG_ENDIAN would
deterministically remove the bswap from adjust_endianness(), but I
don't know how anything is deterministic about CPU-relative byte swaps
since (I think) PPC64 could actually be running in either.  +1 to being
very explicit about which swaps are occurring where.  Thanks,

Alex
