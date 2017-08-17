Received: from eggs.gnu.org ([2001:4830:134:3::10]:34312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=3958fb005=anthony.perard@citrix.com>)
	id 1diLhu-0001kF-V9
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 10:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=3958fb005=anthony.perard@citrix.com>)
	id 1diLhr-0003Mh-Ny
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 10:23:34 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:47564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=3958fb005=anthony.perard@citrix.com>)
	id 1diLhr-0003Lq-Eu
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 10:23:31 -0400
Date: Thu, 17 Aug 2017 15:23:27 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170817142327.GE1475@perard.uk.xensource.com>
References: <20170815111549.6232-1-anthony.perard@citrix.com>
	<20170815111549.6232-2-anthony.perard@citrix.com>
	<20170815140751.2d432a46@nial.brq.redhat.com>
	<20170815222133-mutt-send-email-mst@kernel.org>
	<20170816111046.7e0a935d@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20170816111046.7e0a935d@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 v2 1/2] hw/acpi: Call
 acpi_set_pci_info when no ACPI tables needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Bruce Rogers <brogers@suse.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, Aug 16, 2017 at 11:10:46AM +0200, Igor Mammedov wrote:
> On Tue, 15 Aug 2017 22:24:08 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Tue, Aug 15, 2017 at 02:07:51PM +0200, Igor Mammedov wrote:
> > > On Tue, 15 Aug 2017 12:15:48 +0100
> > > Anthony PERARD <anthony.perard@citrix.com> wrote:
> > >   
> > > > To do PCI passthrough with Xen, the property acpi-pcihp-bsel needs to be
> > > > set, but this was done only when ACPI tables are built which is not
> > > > needed for a Xen guest. The need for the property starts with commit
> > > > "pc: pcihp: avoid adding ACPI_PCIHP_PROP_BSEL twice"
> > > > (f0c9d64a68b776374ec4732424a3e27753ce37b6).
> > > > 
> > > > Set pci info before checking for the needs to build ACPI tables.
> > > > 
> > > > Assign bsel=0 property only to the root bus on Xen as there is no
> > > > support in the Xen ACPI tables for a different value.  
> > > 
> > > looking at hw/acpi/pcihp.c and bsel usage there it looks like
> > > bsel property is owned by it and not by ACPI tables, so instead of
> > > shuffling it in acpi_setup(), how about moving bsel initialization
> > > to hw/acpi/pcihp.c and initialize it there unconditionally?
> > > 
> > > It could be as simple as moving acpi_set_pci_info()/acpi_set_bsel()
> > > there and calling it from acpi_pcihp_reset().
> > > 
> > > Then there won't be need for Xen specific branches, as root bus
> > > will have bsel set automatically which is sufficient for Xen and
> > > the rest of bsel-s (bridges) will be just unused by Xen,
> > > which could later extend its ACPI table implementation to utilize them.   
> > 
> > Later is exactly what I'd like to try to avoid.
> > Whoever wants acpi hotplug for bridges needs to get
> > the bsel info from qemu supplied acpi tables.
> 
> I'd prefer to have only one behavior in QEMU (on hw interface)
> side and let Xen to maintain their own ACPI tables  dealing
> with issues that arise from it since they insist on doing job twice.
> 
> The point is bsel is so embedded in HW part of impl.
> that it should be allocated/manged there, otherwise it leads
> to hacks where acpi_setup() is called but does partial init
> and then bails out to fix code pcihp.c that depend on it being run,
> pcihp.c (hw part) shouldn't depend on on ACPI tables generation
> (bios part).
> 
> Anyway if you insist on capping Xen, it probably could be done
> with comat machinery, something like this:
> 
> (where the 1st hunk should been there since, we've introduced
> "acpi-pci-hotplug-with-bridge-support")
> 
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index c420a38..a55f022 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -273,7 +273,7 @@ static void pci_write(void *opaque, hwaddr addr, uint64_t data,
>                        addr, data);
>          break;
>      case PCI_SEL_BASE:
> -        s->hotplug_select = data;
> +        s->hotplug_select = s->legacy_piix ? 0 : data;
>          ACPI_PCIHP_DPRINTF("pcisel write %" HWADDR_PRIx " <== %" PRIu64 "\n",
>                        addr, data);
>      default:
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 22dbef6..81b8c3e 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -1117,6 +1117,13 @@ static void xenfv_machine_options(MachineClass *m)
>      m->max_cpus = HVM_MAX_VCPUS;
>      m->default_machine_opts = "accel=xen";
>      m->hot_add_cpu = pc_hot_add_cpu;
> +    SET_MACHINE_COMPAT(m,
> +        {\
> +            .driver   = "PIIX4_PM",\
> +            .property = "acpi-pci-hotplug-with-bridge-support",\
> +            .value    = "off",\

That property is actually already turned off for Xen, but this is done
in piix4_pm_init(). Also, having the property only for xenfv would not
be enought because we can use -machine pc,accel=xen.

Maybe we could use s->legacy_piix in acpi_pcihp_device_{,un}plug_cb() to
find out if the missing bsel property is an issue or not?


diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index c420a388ea..79b7ed9900 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -186,6 +186,9 @@ void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
     PCIDevice *pdev = PCI_DEVICE(dev);
     int slot = PCI_SLOT(pdev->devfn);
     int bsel = acpi_pcihp_get_bsel(pdev->bus);
+
+    if (bsel < 0 && s->legacy_piix)
+        bsel = 0;
     if (bsel < 0) {
         error_setg(errp, "Unsupported bus. Bus doesn't have property '"
                    ACPI_PCIHP_PROP_BSEL "' set");
@@ -209,6 +212,9 @@ void acpi_pcihp_device_unplug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
     PCIDevice *pdev = PCI_DEVICE(dev);
     int slot = PCI_SLOT(pdev->devfn);
     int bsel = acpi_pcihp_get_bsel(pdev->bus);
+
+    if (bsel < 0 && s->legacy_piix)
+        bsel = 0;
     if (bsel < 0) {
         error_setg(errp, "Unsupported bus. Bus doesn't have property '"
                    ACPI_PCIHP_PROP_BSEL "' set");

-- 
Anthony PERARD
