Received: from eggs.gnu.org ([2001:4830:134:3::10]:53545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eJUY3-0003vJ-Nv
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 20:18:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eJUY0-0007X0-Jl
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 20:18:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eJUY0-0007Ws-DU
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 20:18:52 -0500
Date: Mon, 27 Nov 2017 23:18:43 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171128011843.GF3037@localhost.localdomain>
References: <20171125151610.20547-1-ehabkost@redhat.com>
	<20171125151610.20547-7-ehabkost@redhat.com>
	<2d315ff7-ac0e-ed47-f632-b7af8f85829a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d315ff7-ac0e-ed47-f632-b7af8f85829a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/6] q35: Allow only supported dynamic
 sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, jgross@suse.com, Thomas Huth <thuth@redhat.com>, sstabellini@kernel.org, Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.a@redhat.com>

On Mon, Nov 27, 2017 at 10:44:34AM +0200, Marcel Apfelbaum wrote:
> On 25/11/2017 17:16, Eduardo Habkost wrote:
> > The only user-creatable sysbus devices in qemu-system-x86_64 are
> > amd-iommu, intel-iommu, and xen-backend.  xen-backend is handled
> > by xen_set_dynamic_sysbus(), so we only need to add amd-iommu and
> > intel-iommu.
> > 
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Marcel Apfelbaum <marcel.a@redhat.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > Changes series v1 -> v2:
> > * New patch added to series
> > ---
> >   hw/i386/pc_q35.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > index d0b0e5b422..db2bebb357 100644
> > --- a/hw/i386/pc_q35.c
> > +++ b/hw/i386/pc_q35.c
> > @@ -42,6 +42,8 @@
> >   #include "exec/address-spaces.h"
> >   #include "hw/i386/pc.h"
> >   #include "hw/i386/ich9.h"
> > +#include "hw/i386/amd_iommu.h"
> > +#include "hw/i386/intel_iommu.h"
> 
> Is a pity we have to add the AMD/Intel header files
> only for the type, maybe we should have a header only
> with the type names, anyway out of the scope of this series.

Another option is to use the type name strings directly instead
of the TYPE_* macros (which I never really liked).  But I don't
want to deviate from the current practice.

> 
> Another question, what about I440FX?
> I think the AMD vIOMMU can theoretically work with the
> conventional PCI machines, I am not sure if it was tested
> or intended to work with it.

i440fx still has has_dynamic_sysbus=false.  With this series, we
can now add amd-iommu to its allowed list, if somebody is willing
to support/test it.


> 
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks!

> 
> Thanks,
> Marcel
> 
> >   #include "hw/smbios/smbios.h"
> >   #include "hw/ide/pci.h"
> >   #include "hw/ide/ahci.h"
> > @@ -299,8 +301,8 @@ static void pc_q35_machine_options(MachineClass *m)
> >       m->default_machine_opts = "firmware=bios-256k.bin";
> >       m->default_display = "std";
> >       m->no_floppy = 1;
> > -    /*TODO: allow only sysbus devices that really work with this machine */
> > -    machine_class_allow_dynamic_sysbus_dev(m, TYPE_SYS_BUS_DEVICE);
> > +    machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
> > +    machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
> >       m->max_cpus = 288;
> >   }
> > 
> 

-- 
Eduardo
