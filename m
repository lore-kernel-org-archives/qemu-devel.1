Received: from eggs.gnu.org ([2001:4830:134:3::10]:46045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dhRtW-00063p-59
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 22:47:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dhRtT-0008Bi-3o
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 22:47:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dhRtS-0008BJ-Tr
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 22:47:47 -0400
Date: Tue, 15 Aug 2017 05:47:44 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170815054627-mutt-send-email-mst@kernel.org>
References: <20170811151138.29405-1-anthony.perard@citrix.com>
	<20170811151138.29405-2-anthony.perard@citrix.com>
	<20170811201006-mutt-send-email-mst@kernel.org>
	<20170814145550.GA1475@perard.uk.xensource.com>
	<20170814185150-mutt-send-email-mst@kernel.org>
	<20170814164502.GB1475@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170814164502.GB1475@perard.uk.xensource.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/2] hw/acpi: Call
 acpi_set_pci_info when no ACPI tables needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Bruce Rogers <brogers@suse.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Mon, Aug 14, 2017 at 05:45:02PM +0100, Anthony PERARD wrote:
> On Mon, Aug 14, 2017 at 06:53:14PM +0300, Michael S. Tsirkin wrote:
> > On Mon, Aug 14, 2017 at 03:55:50PM +0100, Anthony PERARD wrote:
> > > On Fri, Aug 11, 2017 at 08:18:28PM +0300, Michael S. Tsirkin wrote:
> > > > On Fri, Aug 11, 2017 at 04:11:37PM +0100, Anthony PERARD wrote:
> > > > > To do PCI passthrough with Xen, the property acpi-pcihp-bsel needs to be
> > > > > set, but this was done only when ACPI tables are built which is not
> > > > > needed for a Xen guest. The need for the property starts with commit
> > > > > "pc: pcihp: avoid adding ACPI_PCIHP_PROP_BSEL twice"
> > > > > (f0c9d64a68b776374ec4732424a3e27753ce37b6).
> > > > > 
> > > > > Set pci info before checking for the needs to build ACPI tables.
> > > > > 
> > > > > Reported-by: Sander Eikelenboom <linux@eikelenboom.it>
> > > > > Tested-by: Sander Eikelenboom <linux@eikelenboom.it>
> > > > > Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> > > > 
> > > > I am worried that Xen will come to depend on specific
> > > > assignment of bsel which isn't guaranteed. Thoughts on
> > > > how to avoid that?
> > > 
> > > Is it possible to have a different BSEL than 0 with PIIX ?
> > 
> > With PCI to PCI bridges, yes.
> > 
> > > Also, I don't known if having more than on PCI bus is going to work on
> > > Xen, there is nothing in our ACPI tables beyond _SB.PCI0, and nothing to
> > > use a different BSEL.
> > 
> > My worry is someone might decide to implement hotplug for pci to pci
> > bridges on Xen. If doing that, it's important to use the qemu supplied
> > acpi tables.
> 
> I can always add assert((xen_enable() && !bsel) || !xen_enable()) in
> acpi_set_bsel(), so if someone was going to make any change, he would
> find out about bsel quicker. But I don't see Xen using QEMU supplied
> ACPI tables anytime soon.

In that case I'd prefer assigning bsel 0 just for the root bus on xen.

-- 
MST
