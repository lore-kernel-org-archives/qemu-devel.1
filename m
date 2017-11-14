Received: from eggs.gnu.org ([2001:4830:134:3::10]:34412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEbLf-0002MR-Oq
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:33:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEbLd-0005pU-5G
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:33:55 -0500
Date: Tue, 14 Nov 2017 14:33:49 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171114133349.jqymk3jxore4muad@sirius.home.kraxel.org>
References: <AM5P194MB0132C46F9FCCF1DCF2FFC7D0C87A0@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
	<1506512087.25036.10.camel@redhat.com>
	<AM5P194MB013209976BC625983F3265D3C8780@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
	<AM5P194MB0132260A40AD097E2F67A4B2C8790@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
	<1506586050.6902.0.camel@redhat.com>
	<AM5P194MB0132CA048F3B648CB0A47DCDC8790@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5P194MB0132CA048F3B648CB0A47DCDC8790@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
Subject: Re: [Qemu-devel] ppce500 usb-ehci-pci issue on last uboot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: luigi burdo <intermediadc@hotmail.com>
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>

> >How can this be reproduced?
> 
> or just download my last e500 uboot build from here https://www.dropbox.com/s/xxlu6ivg3izlqvu/u-boot?dl=0
> 
> qemu-system-ppc64 -M ppce500 -cpu e5500 -m 512 -bios (path to the uboot image) -device usb-ehci (or another qemulated ehci pci device)  -serial stdio
> 
> when the machine  run and you have the uboot prompt just do "usb
> start" and you will see the hang for some second of the machine and
> after the report from uboot of an error of the ehci.

Finally found the time to look at this.  Seems to not be ehci-related at
all.  ehci doesn't see any mmio activity.

>From "info mtree" monitor command:

memory-region: pci bus memory
  0000000000000000-ffffffffffffffff (prio 0, i/o): pci bus memory
    0000000000080000-0000000000080fff (prio 1, i/o): ehci
    0000000c00004000-0000000c00007fff (prio 1, i/o): virtio-pci

memory-region: system
  0000000000000000-ffffffffffffffff (prio 0, i/o): system
    0000000000000000-000000001fffffff (prio 0, ram): mpc8544ds.ram
    0000000c00000000-0000000c1fffffff (prio 0, i/o): alias PCI Outbound Window 1 @pci bus memory 0000000c00000000-0000000c1fffffff

Seems the ehci mmio bar is mapped outside the pci window, so the cpu
can't access it ...

cheers,
  Gerd
