Received: from eggs.gnu.org ([2001:4830:134:3::10]:39265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gPbdM-0000LP-0o
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 18:10:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gPbdL-0005h6-1U
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 18:10:12 -0500
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 21 Nov 2018 15:10:05 -0800
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20181121231005.GB1421@roeck-us.net>
References: <CAKmqyKNpSWpaUVzJobNPvB=_T+tXhGdiWPTkWmQxdKQf8SHbig@mail.gmail.com>
	<mhng-dc5c5bfa-47d8-41c6-8240-fdb97d24555e@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-dc5c5bfa-47d8-41c6-8240-fdb97d24555e@palmer-si-x1c4>
Subject: Re: [Qemu-devel] [PATCH for-3.2 v7 5/6] hw/riscv/sifive_u: Connect
 the Xilinx PCIe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: alistair23@gmail.com, logang@deltatee.com, qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org, abologna@redhat.com

On Wed, Nov 21, 2018 at 02:36:22PM -0800, Palmer Dabbelt wrote:
> On Wed, 21 Nov 2018 14:23:13 PST (-0800), alistair23@gmail.com wrote:
> >On Wed, Nov 21, 2018 at 2:15 PM Palmer Dabbelt <palmer@sifive.com> wrote:
> >>
> >>On Wed, 21 Nov 2018 13:49:53 PST (-0800), alistair23@gmail.com wrote:
> >>> On Wed, Nov 21, 2018 at 1:26 PM Palmer Dabbelt <palmer@sifive.com> wrote:
> >>>>
> >>>> On Wed, 21 Nov 2018 10:32:45 PST (-0800), alistair23@gmail.com wrote:
> >>>> > On Wed, Nov 21, 2018 at 10:05 AM Logan Gunthorpe <logang@deltatee.com> wrote:
> >>>> >>
> >>>> >>
> >>>> >>
> >>>> >> On 2018-11-21 10:02 a.m., Alistair Francis wrote:
> >>>> >> > Connect the Xilinx PCIe device based on the information in the device
> >>>> >> > tree stored in the ROM of the HiFish Unleashed board.
> >>>> >>
> >>>> >> I only briefly tested this patch but could not get any PCI devices to
> >>>> >> come up with the sifive_u machine. Depending on the kernel I tried, it
> >>>> >> either failed to initialize a Xilinx PCIe (likely due to a mismatch with
> >>>> >> the DT) or it appears to successfully initialize a Microsemi device but
> >>>> >> did not enumerate any devices underneath.
> >>>> >
> >>>> > That seems like either a kernel or bbl issue.
> >>>> >
> >>>> > You need to make sure that bbl doesn't edit the device tree (to add
> >>>> > the Microsemi device or remove the Xilinx one) and ensure your kernel
> >>>> > supports the Xilinx one.
> >>>> >
> >>>> >>
> >>>> >> In any case, it would be nice if the Microsemi/Xilinx confusion was at
> >>>> >> least explained in the commit message.
> >>>> >
> >>>> > What should we say? The QEMU machine accurately models the real
> >>>> > hardware which reports a Xilinx PCIe. The confusion generally appears
> >>>> > above QEMU where people are used to using the MicroSemi one.
> >>>>
> >>>> I think the real issue here is that "sifive_u" doesn't actually fully describe
> >>>> the device we're trying to emulate.  Is it a:
> >>>>
> >>>> * Generic SiFive U core?  In that case we just have a 64-bit core and
> >>>>   essentially no devices.  This is kind of useless.
> >>>> * A HiFive Unleashed?  In that case there's no PCIe, as it requires an
> >>>>   expansion board.
> >>>> * A HiFive Unleashed + VC707?  Here we have Xilinx PCIe.
> >>>> * A HiFive Unleashed + Microsemi Expansion?  Here have Microsemi PCIe.
> >>>
> >>> This isn't even always consistent. For example the sifive_u machine
> >>> exists for 32-bit cores, but the PCIe address reported by the hardware
> >>> only works for 64-bit machines.
> >>>
> >>> So we need a trade off between accurately modelling the hardware or
> >>> having 32-bit support.
> >>
> >>Yep, there's another issue.
> >>
> >>>> There's a tradeoff between accurately emulating the hardware and blowing up the
> >>>> amount of targets we support in QEMU.  We went through this discussion before
> >>>> and ended up where we are now, but maybe it's best to go have the discussion
> >>>> again?
> >>>
> >>> Up to you, it is your board :)
> >>>
> >>> I think it makes more sense to remove these generic boards (that is
> >>> what the virt board is for) and model real hardware boards.
> >>
> >>That seems reasonable to me.  Is removing boards allowed?  If so I'd be OK
> >
> >It's possible, but takes some releases and deprecation warnings.
> >
> >You can see info about it here:
> >https://qemu.weilnetz.de/doc/qemu-doc.html#Deprecated-features
> >
> >As it sounds like no one uses sifive u board (you can't specify a
> >rootFS) it probably isn't that bad to remove.
> 
FWIW, I absoutely agree. If the board can only be used to boot an initrd,
it is quite pointless to have it around. Actually it is worse than pointless,
since it will result in people wasting their time trying to get it to work.

Guenter

> OK, I'll write a patch.
> 
> >>renaming these to "sifive-hifive1" and "sifive-hifive-unleashed", and possibly
> >>adding a "sifive-hifive-unleashed-vc707" as it's possible to emulate most of
> >>that.  Then we at least have accurate names for the boards.
> >
> >That sounds good to me.
> >
> >>
> >>We do have an issue where I'd like to be able to have some system by which we
> >>can configure the memory map of the target, but maybe that's separate
> >>discussion.
> >
> >Yeah, that would also be nice, but I think is separate.
> >
> >Alistair
