Received: from eggs.gnu.org ([2001:4830:134:3::10]:42094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gOkLE-00022W-Ij
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:15:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gOkLB-0005eC-VC
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:15:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gOkLA-0005bo-QI
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:15:53 -0500
Date: Mon, 19 Nov 2018 15:15:43 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181119141543.o6xl4vfptajuksi3@sirius.home.kraxel.org>
References: <CAGxU2F658=XjoHnF6Qq5FqBZAE68BBtMFt-6HcKp_PVxTynOnw@mail.gmail.com>
	<20181119084855.uyira2lpu73mu2fo@sirius.home.kraxel.org>
	<CAGxU2F4O4aKzrJky7EFeWaHFuBKPwi_Z-j7G7m+ENRojVG_5vA@mail.gmail.com>
	<20181119130713.GB6443@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119130713.GB6443@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] SeaBIOS booting time optimization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Rob Bradford <robert.bradford@intel.com>, seabios@seabios.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Nov 19, 2018 at 01:07:13PM +0000, Stefan Hajnoczi wrote:
> On Mon, Nov 19, 2018 at 11:42:28AM +0100, Stefano Garzarella wrote:
> > On Mon, Nov 19, 2018 at 9:49 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > 
> > > Why at runtime?  What is bad with two images?  With a runtime option
> > > you probably need some way to enable the "fastboot" hint for seabios,
> > > because some optimizations (like skipping ps/2 initialization) breaks
> > > functionality.  So it must be opt-in so you can enable it if you know
> > > your use case is fine with that.  But "qemu -boot fast=on" isn't much
> > > different from "qemu -bios seabios-fastboot.bin" after all ...
> > >
> > 
> > You are right, but maybe having a single image can be simpler to distribute,
> > and we can implement something (eg. using fw_cfg) to selectively enable
> > features needed.
> > Anyway, as the first step, I'll try to build a separate image of SeaBIOS.
> 
> Gerd, you may be right that explicit an command-line option like -boot
> fast=on is required.  I was hoping SeaBIOS improvements could
> automatically detect cases where no functionality is lost and would not
> require new command-line options for users or management tools (e.g.
> libvirt).

Will probably be possible to a certain degree, but I expect you can't
get 100% of the qboot savings without something like -boot fast=on.

> For example, if SeaBIOS sees -kernel, is it necessary to follow the full
> BIOS boot process including loading option ROMs?

Well, right now -kernel loading is actually implemented by an option rom ...

> This way we could avoid scanning PCI devices.

That has consequences for the acpi tables, because qemu checks where the
firmware mapped the pci bars when generating the tables.

Also it is not a given that skipping pci initialization in seabios is a
win in the end.  The linux kernel has to handle pci bar configuration
then so it might be we just shift around boot times.

> Admittedly I don't know the answer to how transparent we can make this,
> but I hope Stefano will identify how far we can go.

Yes, lets see.

cheers,
  Gerd
