Received: from eggs.gnu.org ([2001:4830:134:3::10]:47829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1gZLwr-0004Bh-QV
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 15:26:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1gZLwf-0004lN-Sf
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 15:26:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1gZLwf-0004Zs-I2
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 15:26:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so3947228wmb.3
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 12:26:24 -0800 (PST)
Date: Tue, 18 Dec 2018 21:26:14 +0100
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20181218212614.385f4b5b@thl530>
In-Reply-To: <alpine.BSF.2.21.9999.1812171247380.61996@zero.eik.bme.hu>
References: <20181216215210.29088-1-huth@tuxfamily.org>
	<alpine.BSF.2.21.9999.1812171247380.61996@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/sparc64: Create VGA device only if it
 has really been requested
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org

Am Mon, 17 Dec 2018 12:48:31 +0100 (CET)
schrieb BALATON Zoltan <balaton@eik.bme.hu>:

> On Sun, 16 Dec 2018, Thomas Huth wrote:
> > The sun4u/sun4v machine currently always creates a VGA device, even
> > if the user started QEMU with "-nodefaults" or "-vga none". That's
> > likely not what the users expect in this case, so add a check
> > whether the VGA adapter has really been requested.
> >
> > Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> > ---
> > hw/sparc64/sun4u.c | 10 +++++++++-
> > 1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> > index f76b19e4e9..ce7236c322 100644
> > --- a/hw/sparc64/sun4u.c
> > +++ b/hw/sparc64/sun4u.c
> > @@ -596,7 +596,15 @@ static void sun4uv_init(MemoryRegion
> > *address_space_mem, qdev_connect_gpio_out_named(DEVICE(ebus),
> > "isa-irq", 4, qdev_get_gpio_in_named(DEVICE(sabre), "pbm-irq",
> > OBIO_SER_IRQ));
> >
> > -    pci_dev = pci_create_simple(pci_busA, PCI_DEVFN(2, 0), "VGA");
> > +    switch (vga_interface_type) {
> > +    case VGA_STD:
> > +        pci_create_simple(pci_busA, PCI_DEVFN(2, 0), "VGA");
> > +        break;
> > +    case VGA_NONE:
> > +        break;
> > +    default:
> > +       abort();   /* Should not happen - types are checked in vl.c
> > already */  
> 
> Can't comment on the actual patch but looks like a whitespace is
> missing here.

Oops. Mark, can you fix it up when applying the patch (if you don't
object it)? Or shall I resend?

By the way, would it make sense to enable virtio-vga for the sun4u
machines, too?

 Thomas
