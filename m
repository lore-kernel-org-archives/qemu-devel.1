Received: from eggs.gnu.org ([2001:4830:134:3::10]:54263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gNa6r-0001rU-U6
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 04:08:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gNa6n-0000tZ-IU
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 04:08:17 -0500
Date: Fri, 16 Nov 2018 10:07:51 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181116090751.272tyagevqwvosy6@kamzik.brq.redhat.com>
References: <20181115141003.r6imovu25ymatm4w@kamzik.brq.redhat.com>
	<201811160945428164241@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201811160945428164241@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH V6 5/6] hw/arm/virt: add pvpanic device
 invirt acpi table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peng.hao2@zte.com.cn
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, philmd@redhat.com, qemu-devel@nongnu.org

On Fri, Nov 16, 2018 at 09:45:42AM +0800, peng.hao2@zte.com.cn wrote:
> >> add pvpanic device in virt acpi table, so when kenrel command line uses
> >> acpi=force, kernel can get info from acpi table in aarch64.
> 
> [...]
> 
> >>
> >> +static void acpi_dsdt_add_pvpanic(Aml *scope, const MemMapEntry *pvpanic_memmap)
> >> +{
> >> +    Aml *dev = aml_device("PANC");
> >
> >Shouldn't this be "PEVT" ("panic event"), like it is for x86?
> >
> yeah, I will change it.
> >> +    aml_append(dev, aml_name_decl("_HID", aml_string("QEMU0001")));
> >> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> >
> >Why add _UID? Also, I see x86 had some issues with not having _STA and
> >then having a _STA without the UI flag. It now has _STA=0xf
> >(PRESENT|ENABLED|UI|FUNCTIONING). I'm not saying we need to do that to,
> >but I'd like to know if it was considered and decided we don't need to.
> >
> The way the kernel code processes _STA is that if _STA is not found, the default 
> setting is (PRESENT|ENABLED|UI|FUNCTIONING). So I think it is not necessary
>  to add it. It is only parsed in the pvpanic driver. 

Good enough for me.

> for _UID, I think it is used for device index. I just fill it with 0 because there is 
> only one pvpanic device.

OK, but I'm still not sure it's necessary.

> 
> by the way, How to get the value of ACPI conveniently? how dou you get the 
> value of _STA?

Not sure what you mean here. From where do you want to check the value?
If you mean from guest userspace, then there's nothing convenient that I
know of. You'll have to disassemble the tables you extract from sysfs,
afaik.

Thanks,
drew

> 
> Thanks.
> >> +
> >> +    Aml *crs = aml_resource_template();
> >> +    aml_append(crs, aml_memory32_fixed(pvpanic_memmap->base,
> >> +                                       pvpanic_memmap->size, AML_READ_WRITE));
> >> +
> >> +    aml_append(dev, aml_name_decl("_CRS", crs));
> >> +
> >> +    aml_append(scope, dev);
> >> +}
> >> +
> >>  static void acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
> >>                                             uint32_t uart_irq)
> >>  {
> >> @@ -770,6 +785,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >>      acpi_dsdt_add_cpus(scope, vms->smp_cpus);
> >>      acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
> >>                         (irqmap[VIRT_UART] + ARM_SPI_BASE));
> >> +    acpi_dsdt_add_pvpanic(scope, &memmap[VIRT_PVPANIC]);
> >>      acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
> >>      acpi_dsdt_add_fw_cfg(scope, &memmap[VIRT_FW_CFG]);
> >>      acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
> >> --
> >> 1.8.3.1
> >>
> >>
> >
> >Thanks,
> >drew
