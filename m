Received: from eggs.gnu.org ([2001:4830:134:3::10]:35702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fcg3n-00005r-8k
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 19:59:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fcg3k-0000oO-44
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 19:59:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fcg3j-0000oF-TT
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 19:59:12 -0400
Date: Mon, 9 Jul 2018 20:59:03 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180709235903.GE7451@localhost.localdomain>
References: <20180709203731.19865-1-ehabkost@redhat.com>
	<20180710025155-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710025155-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH for-3.0] pc: Use "3.0+" constant as default
 SMBIOS version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Wei Huang <wei@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>

On Tue, Jul 10, 2018 at 02:54:12AM +0300, Michael S. Tsirkin wrote:
> On Mon, Jul 09, 2018 at 05:37:31PM -0300, Eduardo Habkost wrote:
> > Every time we create new PC machine-types in QEMU, the defaults
> > for SMBIOS fields change unnecessarily because the version field
> > defaults to MachineClass::name.
> > 
> > This can cause unexpected side-effects, like triggering license
> > reactivation on guest software, or changing the VM memory layout
> > because of BIOS table size changes.
> > 
> > Change the SMBIOS version string for pc-*-3.0 to "3.0+" to avoid
> > doing this on every QEMU release, and keep compatible version
> > strings on older machine-types using a new
> > MachineClass::smbios_version field.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > I just noticed that we started using mc->name on arm/virt since
> > commit dfadc3bfb458efefb72e13a57b62f138c464a577.
> > Should arm/virt start using "3.0+" too?
> > ---
> >  include/hw/i386/pc.h | 3 +++
> >  hw/i386/pc.c         | 1 +
> >  hw/i386/pc_piix.c    | 5 +++--
> >  hw/i386/pc_q35.c     | 3 ++-
> >  4 files changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index 4d99d69681..aea0fcaadb 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -134,6 +134,9 @@ struct PCMachineClass {
> >  
> >      /* use DMA capable linuxboot option rom */
> >      bool linuxboot_dma_enabled;
> > +
> > +    /* Version field for SMBIOS Type 1, Type 2, Type 3, and Type 4 structs */
> > +    const char *smbios_version;
> >  };
> >  
> >  #define TYPE_PC_MACHINE "generic-pc-machine"
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 50d5553991..47877e7071 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -2379,6 +2379,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
> >      pcmc->acpi_data_size = 0x20000 + 0x8000;
> >      pcmc->save_tsc_khz = true;
> >      pcmc->linuxboot_dma_enabled = true;
> > +    pcmc->smbios_version = "3.0+";
> >      assert(!mc->get_hotplug_handler);
> >      mc->get_hotplug_handler = pc_get_hotpug_handler;
> >      mc->cpu_index_to_instance_props = pc_cpu_index_to_props;
> 
> I suspect 3.00 is cleaner for tools that happen to
> parse the version as a numeral as it always was in the past,
> even if it's not exact.

It was never a numeral.  It was "pc-q35-X.Y" or "pc-i440fx-X.Y".

-- 
Eduardo
