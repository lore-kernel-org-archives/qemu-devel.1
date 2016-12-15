Received: from eggs.gnu.org ([2001:4830:134:3::10]:60716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cHYqL-0000vV-JG
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:25:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cHYqH-0002YO-Rb
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:25:17 -0500
Date: Thu, 15 Dec 2016 17:25:03 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20161215162503.35p4px2laz3gkkzg@kamzik.brq.redhat.com>
References: <20161213214522.25548-1-drjones@redhat.com>
	<20161213214522.25548-10-drjones@redhat.com>
	<20161215160822.79151aec@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161215160822.79151aec@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/11] hw/arm/virt-acpi-build: don't save
 VirtGuestInfo on AcpiBuildState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, zhaoshenglong@huawei.com, mst@redhat.com, ehabkost@redhat.com

On Thu, Dec 15, 2016 at 04:08:22PM +0100, Igor Mammedov wrote:
> On Tue, 13 Dec 2016 22:45:20 +0100
> Andrew Jones <drjones@redhat.com> wrote:
> 
> > We can get to VirtMachineState without the need for saving a pointer
> > on AcpiBuildState. This is the mach-virt equivalent to "acpi: Don't save
> > PcGuestInfo on AcpiBuildState"
> > 
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > ---
> >  hw/arm/virt-acpi-build.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index 7a1efd0dc538..137781646bec 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -706,7 +706,6 @@ struct AcpiBuildState {
> >      MemoryRegion *linker_mr;
> >      /* Is table patched? */
> >      bool patched;
> > -    VirtGuestInfo *guest_info;
> >  } AcpiBuildState;
> >  
> >  static
> > @@ -779,6 +778,8 @@ static void acpi_ram_update(MemoryRegion *mr, GArray *data)
> >  
> >  static void virt_acpi_build_update(void *build_opaque)
> >  {
> > +    MachineState *machine = MACHINE(qdev_get_machine());
> > +    VirtMachineState *vms = VIRT_MACHINE(machine);
> >      AcpiBuildState *build_state = build_opaque;
> >      AcpiBuildTables tables;
> >  
> > @@ -790,8 +791,7 @@ static void virt_acpi_build_update(void *build_opaque)
> >  
> >      acpi_build_tables_init(&tables);
> >  
> > -    virt_acpi_build(container_of(build_state->guest_info,
> > -                                 VirtMachineState, acpi_guest_info), &tables);
> > +    virt_acpi_build(vms, &tables);
> 
> virt_acpi_build(VIRT_MACHINE(qdev_get_machine()), &tables);
> 
> or even better do it inside of virt_acpi_build(&tables);

Sounds good.

Thanks,
drew

> 
> 
> >  
> >      acpi_ram_update(build_state->table_mr, tables.table_data);
> >      acpi_ram_update(build_state->rsdp_mr, tables.rsdp);
> > @@ -841,7 +841,6 @@ void virt_acpi_setup(VirtMachineState *vms)
> >      }
> >  
> >      build_state = g_malloc0(sizeof *build_state);
> > -    build_state->guest_info = guest_info;
> >  
> >      acpi_build_tables_init(&tables);
> >      virt_acpi_build(vms, &tables);
> 
