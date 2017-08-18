Received: from eggs.gnu.org ([2001:4830:134:3::10]:44093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=396451df5=anthony.perard@citrix.com>)
	id 1dihMp-00047s-8o
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=396451df5=anthony.perard@citrix.com>)
	id 1dihMk-0001rE-O2
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:31:15 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:40021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=396451df5=anthony.perard@citrix.com>)
	id 1dihMk-0001qk-Fg
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:31:10 -0400
Date: Fri, 18 Aug 2017 14:31:07 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170818133107.GG1475@perard.uk.xensource.com>
References: <20170817162347.1590-1-anthony.perard@citrix.com>
	<20170817162347.1590-3-anthony.perard@citrix.com>
	<20170818043655-mutt-send-email-mst@kernel.org>
	<20170818113734.181332ad@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20170818113734.181332ad@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 v3 2/3] hw/acpi: Move
 acpi_set_pci_info to pcihp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Bruce Rogers <brogers@suse.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On Fri, Aug 18, 2017 at 11:37:34AM +0200, Igor Mammedov wrote:
> On Fri, 18 Aug 2017 04:40:02 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Aug 17, 2017 at 05:23:46PM +0100, Anthony PERARD wrote:
> > > This means that the function will be call and the property
> > > acpi-pcihp-bsel will be set even if ACPI build is disable.
> > > 
> > > To do PCI passthrough with Xen, the property acpi-pcihp-bsel needs to be
> > > set, but this was done only when ACPI tables are built which is not
> > > needed for a Xen guest. The need for the property starts with commit
> > > "pc: pcihp: avoid adding ACPI_PCIHP_PROP_BSEL twice"
> > > (f0c9d64a68b776374ec4732424a3e27753ce37b6).
> > > 
> > > Reported-by: Sander Eikelenboom <linux@eikelenboom.it>
> > > Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> > > 
> > > ---
> > > Changes in V3:
> > >   - move acpi_set_pci_info to pcihp instead
> > > 
> > > Changes in V2:
> > >   - check for acpi_enabled before calling acpi_set_pci_info.
> > >   - set the property on the root bus only.
> > > 
> > > This patch would be a canditade to backport to 2.9, along with
> > > "hw/acpi: Limit hotplug to root bus on legacy mode"
> > > 
> > > CC: Stefano Stabellini <sstabellini@kernel.org>
> > > CC: Bruce Rogers <brogers@suse.com>
> > > ---
> > >  hw/acpi/pcihp.c      | 31 +++++++++++++++++++++++++++++++
> > >  hw/i386/acpi-build.c | 32 --------------------------------
> > >  2 files changed, 31 insertions(+), 32 deletions(-)
> > > 
> > > diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> > > index 9db3c2eaf2..44e8842db8 100644
> > > --- a/hw/acpi/pcihp.c
> > > +++ b/hw/acpi/pcihp.c
> > > @@ -75,6 +75,36 @@ static int acpi_pcihp_get_bsel(PCIBus *bus)
> > >      }
> > >  }
> > >  
> > > +/* Assign BSEL property to all buses.  In the future, this can be changed
> > > + * to only assign to buses that support hotplug.
> > > + */
> > > +static void *acpi_set_bsel(PCIBus *bus, void *opaque)
> > > +{
> > > +    unsigned *bsel_alloc = opaque;
> > > +    unsigned *bus_bsel;
> > > +
> > > +    if (qbus_is_hotpluggable(BUS(bus))) {
> > > +        bus_bsel = g_malloc(sizeof *bus_bsel);
> > > +
> > > +        *bus_bsel = (*bsel_alloc)++;
> > > +        object_property_add_uint32_ptr(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
> > > +                                       bus_bsel, &error_abort);
> > > +    }
> > > +
> > > +    return bsel_alloc;
> > > +}
> > > +
> > > +static void acpi_set_pci_info(void)
> > > +{
> > > +    PCIBus *bus = find_i440fx(); /* TODO: Q35 support */
> > > +    unsigned bsel_alloc = ACPI_PCIHP_BSEL_DEFAULT;
> > > +
> > > +    if (bus) {
> > > +        /* Scan all PCI buses. Set property to enable acpi based hotplug. */
> > > +        pci_for_each_bus_depth_first(bus, acpi_set_bsel, NULL, &bsel_alloc);
> > > +    }
> > > +}
> > > +
> > >  static void acpi_pcihp_test_hotplug_bus(PCIBus *bus, void *opaque)
> > >  {
> > >      AcpiPciHpFind *find = opaque;
> > > @@ -177,6 +207,7 @@ static void acpi_pcihp_update(AcpiPciHpState *s)
> > >  
> > >  void acpi_pcihp_reset(AcpiPciHpState *s)
> > >  {
> > > +    acpi_set_pci_info();
> > >      acpi_pcihp_update(s);
> > >  }  
> > 
> > IIUC doing this on reset will add property over and over again leaking
> > memory.
> in v2 I've explicitly suggested to call it once, like:

Sorry I misunderstood. I'll fix it.

> acpi_set_pci_info() {
> 
>    static bool bsel_is set;
> 
>    if (bsel_is set)
>        return;
>    bsel_is set = true;
> 
>    ...
> }
> 
> not patch related:
> BTW bsel assignment is not stable in hotplug + migration use case,
> and we probably should fix it up in 2.11 (CCing Marcel)
> 
> > I think that we need to do it on machine done.
> > 
> > Igor,  I think reordering acpi-build like earlier version did
> > is less intrusive and more appropriate for 2.10.
> > 
> > For 2.10 I would like to see ideally some changes that
> > are all if (xen) making it obvious non xen is not
> > affected. I can then ack it and it will be merged in xen tree.
> it didn't work before so I'd just push fix to 2.11 without
> intermediate fix.
> But if you guys think it's worth to fix in 2.10, I'm fine with v2
> for it if Anthony will take care of it (rebase this series)
> in 2.11 merge window.

Yes, I can take care of this series for 2.11, and find out how to build
the mips-softmmu target which does not build because it's missing
find_i440fx.

> > 
> > Clean it up after 2.10.
> > 

So is the v2 good enough or do I need to resend it?

Thanks,

-- 
Anthony PERARD
