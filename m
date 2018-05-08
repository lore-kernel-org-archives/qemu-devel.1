Received: from eggs.gnu.org ([2001:4830:134:3::10]:54557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fG2Zj-0005fO-Ht
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:22:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fG2Zg-00062y-UT
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:22:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45572 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fG2Zg-000622-QA
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:22:36 -0400
Date: Tue, 8 May 2018 15:22:34 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180508132234.yegmw442swuofykh@sirius.home.kraxel.org>
References: <152541524728.557.4600864098110042577.malonedeb@gac.canonical.com>
	<152577650854.21921.3043264133804855985.malone@soybean.canonical.com>
	<20180508112338.GI2500@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508112338.GI2500@work-vm>
Subject: Re: [Qemu-devel] [Bug 1769053] Re: Cannot start a guest with more
 than 1TB of RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1769053 <1769053@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org

  Hi,

>   d) For smaller amount of RAM it might still fail if
> RAM+rounding+pci+hotplug space goes over the limit.
>      Figuring that limit out is tricky (and I thought it
>      might be BIOS/EFI dependent as well depending where they
>      decide to put their PCI devices)

Both seabios and ovmf try to not go too high in address space.  Reason
is exactly the phys-bits issue.  Using 40 here by default does not only
limit the memory to 1TB.  It also has the problem that the guest thinks
it has 1TB of address space but in reality it might be less.  Even
recent skylake machines have phys-bits=39 (512G) only, and trying to use
the physical address space above 512G in the guest just doesn't work
because the phys-bits=39 limit applies to EPT too.

So checking phys-bits in the firmware, for example to place pci bars as
high as possible in physical address space, is not going to work.

IIRC ovmf uses a 32G sized region with 32G alignment by default, which
will land below 64G (aka phys-bits=36 address space) unless the guest
has more than 30 (q35) or 31 (piix4) GB of memory.

seabios will not map pci bars above 4G unless it runs out of space below
4G.  If needed 64bit PCI bars will be placed right above ram, with
gigabyte alignment.

cheers,
  Gerd
