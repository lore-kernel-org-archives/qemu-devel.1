Received: from eggs.gnu.org ([2001:4830:134:3::10]:43440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1e32qw-0007X1-UT
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:30:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1e32qs-0001WK-0Q
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:30:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1e32qr-0001Vn-IT
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:30:21 -0400
Date: Fri, 13 Oct 2017 18:30:09 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20171013163009.wgrqhvy2peezw3a7@kamzik.brq.redhat.com>
References: <4cce2b8b-a411-bd5d-a06f-b0b80a5fb2f1@redhat.com>
	<CAFEAcA8yvST1fKaLjauz3OV=gRTEKsuLfWvJ3NgCA_weFy2cOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8yvST1fKaLjauz3OV=gRTEKsuLfWvJ3NgCA_weFy2cOg@mail.gmail.com>
Subject: Re: [Qemu-devel] dynamic DRAM base for ArmVirtQemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laszlo Ersek <lersek@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, libvirt devel <libvir-list@redhat.com>, edk2-devel-01 <edk2-devel@lists.01.org>, qemu devel list <qemu-devel@nongnu.org>, "Leif Lindholm (Linaro address)" <leif.lindholm@linaro.org>, Andrea Bolognani <abologna@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Fri, Oct 13, 2017 at 05:18:59PM +0100, Peter Maydell wrote:
> On 13 October 2017 at 13:51, Laszlo Ersek <lersek@redhat.com> wrote:
> > Another idea is to move *the* system DRAM base to a different guest-phys
> > address. (Likely using a different version of the "virt" machine type,
> > or even a different machine type entirely.) This would not be compatible
> > with current ArmVirtQemu, which hard-codes the system DRAM base in
> > several, quite brittle / sensitive, locations. (More on this later --
> > that's going to be the larger part of my email anyway.) In order to
> > handle the new base in ArmVirtQemu, two approaches are possible: change
> > the hard-coded address(es), or cope with the address dynamically.
> 
> I strongly don't want to move the DRAM base in the "virt" board.
> This is one of the few fixed things we've said that guest code
> can rely on without having to fish the information out of the
> device tree.

OK, if we take the base of DRAM as fixed, then we can either

 a) support a split memory for mach-virt, 1G at 1G and the
    rest starting at 4G.

or 

 b) create a new memory map for AArch64 where ECAM and GIC
    redistributors are above max-ram (256G), assuming there's
    no problem moving them up there.

I actually already started looking into (a), but it was starting
to snowball, which is why I started discussing moving the base
to 3G with Laszlo. I haven't looked at (b) yet, as I was sort
of assuming we'd want IO memory below 4G to avoid bumping into
any issues where drivers, etc. where making those kinds of
assumptions.

Thanks,
drew
