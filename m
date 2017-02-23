Received: from eggs.gnu.org ([2001:4830:134:3::10]:55808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paulus@ozlabs.org>) id 1ch2w4-0003Xc-9p
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 18:36:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paulus@ozlabs.org>) id 1ch2w1-00010e-4V
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 18:36:32 -0500
Received: from ozlabs.org ([103.22.144.67]:58103)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <paulus@ozlabs.org>) id 1ch2w0-0000zs-Pa
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 18:36:29 -0500
Date: Fri, 24 Feb 2017 10:36:15 +1100
From: Paul Mackerras <paulus@ozlabs.org>
Message-ID: <20170223233615.GA18157@fergus.ozlabs.ibm.com>
References: <5a0773de-6bc7-474a-82ab-2edd37ce8a93@redhat.com>
	<CAFEAcA99xi4k57h2XGw2deGO24E95AS5jyGL+4GzjqNgMb9wcg@mail.gmail.com>
	<92580ca9-47fe-a943-7720-d3cb1fc6d2eb@redhat.com>
	<CAFEAcA8769a_8xwk57FS6Ko+Lioud20+70JRSafeEic6GB_RAw@mail.gmail.com>
	<3d5e7b5e-4501-86b7-093d-47fb09af585e@redhat.com>
	<CAFEAcA9gcArSqhbRi6-YdR=5eE9dtq66C7N0qTbCuBiY_Zr+tA@mail.gmail.com>
	<41630a89-e645-7d7e-b7c2-356fd6dcadee@redhat.com>
	<CAFEAcA_Mh9ZrJeu4f==ko1k2yLkfPe2AwNbUHcxkmS6Lzuvk0Q@mail.gmail.com>
	<2565ef99-9c16-e836-08c6-0915f5d4b0f8@redhat.com>
	<CAFEAcA_BgiXrjW9aRNFkXEEjS+kjibJ_UisJtiLgrPh=0re5qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_BgiXrjW9aRNFkXEEjS+kjibJ_UisJtiLgrPh=0re5qA@mail.gmail.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Yongji Xie <xyjxie@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, zhong@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

On Thu, Feb 23, 2017 at 03:29:53PM +0000, Peter Maydell wrote:
> On 23 February 2017 at 15:21, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> >
> > On 23/02/2017 15:35, Peter Maydell wrote:
> >> On 23 February 2017 at 12:53, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>>
> >>>
> >>> On 23/02/2017 13:26, Peter Maydell wrote:
> >>>> On 23 February 2017 at 11:43, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>>>> On 23/02/2017 12:34, Peter Maydell wrote:
> >>>>>> We should probably update the doc comment to note that the
> >>>>>> pointer is to host-endianness memory (and that this is not
> >>>>>> like normal RAM which is target-endian)...
> >>>>>
> >>>>> I wouldn't call it host-endianness memory, and I disagree that normal
> >>>>> RAM is target-endian---in both cases it's just a bunch of bytes.
> >>>>>
> >>>>> However, the access done by the MemoryRegionOps callbacks needs to match
> >>>>> the endianness declared by the MemoryRegionOps themselves.
> >>>>
> >>>> Well, if the guest stores a bunch of integers to the memory, which
> >>>> way round do you see them when you look at the bunch of bytes?
> >>>
> >>> You see them in whatever endianness the guest used.
> >>
> >> I'm confused. I said "normal RAM and this ramdevice memory are
> >> different", and you seem to be saying they're the same. I don't
> >> think they are (in particular I think with a BE guest on an
> >> LE host they'll look different).
> >
> > No, they look entirely the same.  The only difference is that they go
> > through MemoryRegionOps instead of memcpy.
> 
> Then we have a different problem, because the thing this patch
> is claiming to fix is that the memory the device is backed by
> (from vfio) is little-endian and we're not accessing it right.
> 
> RAM of the usual sort is target-endian (by which I mean "when the guest
> does a write of 32-bits 0x12345678, and you look at the memory byte
> by byte then the order of bytes is either 0x12 0x34 0x56 0x78 if
> TARGET_LITTLE_ENDIAN or 0x78 0x56 0x34 0x12 if TARGET_BIG_ENDIAN").
> 
> AIUI what we want for this VFIO case is "when the guest does
> a 32-bit write of 0x12345678 then the bytes are 0x12 0x34 0x56 0x78
> regardless of whether TARGET_BIG_ENDIAN or not".

At least in the case of KVM and MMIO emulation (which is the case
here), run->mmio.data should be considered as a byte stream without
endianness, and what is needed is for QEMU to transfer data between
run->mmio.data and the device (or whatever is backing the MMIO region)
without any net byte swap.

So if QEMU is doing a 32-bit host-endian load from run->mmio.data
(for an MMIO store), then it needs to do a 32-bit host-endian store
into the device memory.  In other words, the RAM memory region needs
to be considered host endian to match run->mmio.data being considered
host endian.

Paul.
