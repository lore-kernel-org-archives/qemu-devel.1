Received: from eggs.gnu.org ([2001:4830:134:3::10]:58371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eOmBT-00082s-G4
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 10:09:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eOmBS-00050g-E8
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 10:09:27 -0500
Date: Tue, 12 Dec 2017 16:09:12 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20171212150912.b5oc4dz5hxcex22q@kamzik.brq.redhat.com>
References: <1512745328-5109-1-git-send-email-peter.maydell@linaro.org>
	<1512745328-5109-4-git-send-email-peter.maydell@linaro.org>
	<5A2F6ED9.5030605@huawei.com>
	<ac182406-8011-9f19-38e7-37328434095b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac182406-8011-9f19-38e7-37328434095b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/arm/virt-acpi-build: Add second
 UART to ACPI tables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Shannon Zhao <zhaoshenglong@huawei.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, "Jason A . Donenfeld" <Jason@zx2c4.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Andrea Bolognani <abologna@redhat.com>

On Tue, Dec 12, 2017 at 12:06:39PM +0100, Laszlo Ersek wrote:
> On 12/12/17 06:53, Shannon Zhao wrote:
> > 
> > 
> > On 2017/12/8 23:02, Peter Maydell wrote:
> >> Add the second UART to the ACPI tables.
> >>
> >> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >> ---
> >> Pure guesswork, as I don't have a UEFI setup to hand and
> >> am not familiar with ACPI table formats either...
> >> ---
> >>  hw/arm/virt-acpi-build.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> >> index 3d78ff6..a38287b 100644
> >> --- a/hw/arm/virt-acpi-build.c
> >> +++ b/hw/arm/virt-acpi-build.c
> >> @@ -689,6 +689,7 @@ static void build_fadt(GArray *table_data, BIOSLinker *linker,
> >>  static void
> >>  build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >>  {
> >> +    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
> >>      Aml *scope, *dsdt;
> >>      const MemMapEntry *memmap = vms->memmap;
> >>      const int *irqmap = vms->irqmap;
> >> @@ -706,6 +707,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >>      acpi_dsdt_add_cpus(scope, vms->smp_cpus);
> >>      acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
> >>                         (irqmap[VIRT_UART] + ARM_SPI_BASE));
> >> +    if (!vmc->no_second_uart) {
> >> +        acpi_dsdt_add_uart(scope, &memmap[VIRT_UART_2],
> >> +                           (irqmap[VIRT_UART_2] + ARM_SPI_BASE));
> >> +    }
> >>      acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
> >>      acpi_dsdt_add_fw_cfg(scope, &memmap[VIRT_FW_CFG]);
> >>      acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
> >>
> > Reviewed-by: Shannon Zhao <zhaoshenglong@huawei.com>
> > 
> 
> (Responding here so I don't have to manually update Shannon's email
> address while replying to patch 3/3 directly.)
> 
> acpi_dsdt_add_uart() does:
> 
>     Aml *dev = aml_device("COM0");
>     aml_append(dev, aml_name_decl("_HID", aml_string("ARMH0011")));
>     aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> 
> The device name should be unique. Plus, within the same _HID, the _UID
> should be unique as well. I suggest adding another unsigned parameter to
> acpi_dsdt_add_uart(), and hooking it into COMx and _UID.

Yes, I agree with Laszlo here (and confirmed with Igor). Also, if memory
serves me, the _ADR part of acpi_dsdt_add_uart() is only there to deal
with early Linux ACPI support not finding the console UART correctly.
I believe it does now, meaning the _ADR could even be removed for COM0,
and we certainly don't want it for COM1 because it's point is to find
COM0, so the new unsigned parameter should also be used as condition for
it. A later patch could remove it altogether.

Thanks,
drew
