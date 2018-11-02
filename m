Received: from eggs.gnu.org ([2001:4830:134:3::10]:38516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gIWhB-0007xf-PI
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 06:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gIWcO-0008Q6-Me
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 06:23:58 -0400
Date: Fri, 2 Nov 2018 11:23:47 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181102112347.7af1cdc5@redhat.com>
In-Reply-To: <c88b4769-a517-36da-b181-e59a4380bcea@gmail.com>
References: <20181101102303.16439-1-sameo@linux.intel.com>
	<20181101102303.16439-6-sameo@linux.intel.com>
	<c88b4769-a517-36da-b181-e59a4380bcea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 05/23] hw: arm: Switch to the AML build
 RSDP building routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <shannon.zhaosl@gmail.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM ACPI Subsystem" <qemu-arm@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, 2 Nov 2018 17:35:06 +0800
Shannon Zhao <shannon.zhaosl@gmail.com> wrote:

> On 2018/11/1 18:22, Samuel Ortiz wrote:
> > We make the ARM virt ACPI code use the now shared build_rsdp() API from
> > aml-build.c. By doing so we fix a bug where the ARM implementation was
> > missing adding both the legacy and extended checksums, which was
> > building an invalid RSDP table.
> > 
> > Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> > ---
> >   hw/arm/virt-acpi-build.c | 31 +------------------------------
> >   1 file changed, 1 insertion(+), 30 deletions(-)
> > 
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index 0ed132b79b..0a6a88380a 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -35,6 +35,7 @@
> >   #include "target/arm/cpu.h"
> >   #include "hw/acpi/acpi-defs.h"
> >   #include "hw/acpi/acpi.h"
> > +#include "hw/acpi/aml-build.h"
> >   #include "hw/nvram/fw_cfg.h"
> >   #include "hw/acpi/bios-linker-loader.h"
> >   #include "hw/loader.h"
> > @@ -366,36 +367,6 @@ static void acpi_dsdt_add_power_button(Aml *scope)
> >       aml_append(scope, dev);
> >   }
> >   
> > -/* RSDP */
> > -static void
> > -build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)  
> Note: here we use xsdt table not rsdt for ARM. After your change which 
> assigns xsdt table address to rsdt_physical_address, it doesn't work.
Hi Shannon,

I do not really like how this series organized/split and doing refactoring
backwards but that's another story and I'll do suggestions how to make it
better on per patch review later.

But as far as I see this change should only add legacy checksum over
the current rsdp, which is bug fix and makes table spec compliant.

Could you point out why it doesn't work and what exactly breaks?


> IIRC, we discussed this before that ARM virt uses xsdt while pc/q35 uses 
> rsdt. So this patch is not necessary I think.
> 
> Thanks,
> Shannon
> > -{
> > -    AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
> > -    unsigned xsdt_pa_size = sizeof(rsdp->xsdt_physical_address);
> > -    unsigned xsdt_pa_offset =
> > -        (char *)&rsdp->xsdt_physical_address - rsdp_table->data;
> > -
> > -    bios_linker_loader_alloc(linker, ACPI_BUILD_RSDP_FILE, rsdp_table, 16,
> > -                             true /* fseg memory */);
> > -
> > -    memcpy(&rsdp->signature, "RSD PTR ", sizeof(rsdp->signature));
> > -    memcpy(rsdp->oem_id, ACPI_BUILD_APPNAME6, sizeof(rsdp->oem_id));
> > -    rsdp->length = cpu_to_le32(sizeof(*rsdp));
> > -    rsdp->revision = 0x02;
> > -
> > -    /* Address to be filled by Guest linker */
> > -    bios_linker_loader_add_pointer(linker,
> > -        ACPI_BUILD_RSDP_FILE, xsdt_pa_offset, xsdt_pa_size,
> > -        ACPI_BUILD_TABLE_FILE, xsdt_tbl_offset);
> > -
> > -    /* Checksum to be filled by Guest linker */
> > -    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
> > -        (char *)rsdp - rsdp_table->data, sizeof *rsdp,
> > -        (char *)&rsdp->checksum - rsdp_table->data);
> > -
> > -    return rsdp_table;
> > -}
> > -
> >   static void
> >   build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >   {
> >   
