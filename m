Received: from eggs.gnu.org ([209.51.188.92]:42531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gz2Jk-0002PC-EQ
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 11:44:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gz2JX-0008JQ-Rk
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 11:44:16 -0500
Date: Wed, 27 Feb 2019 17:42:50 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190227174250.11376886@redhat.com>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA8392D6875@lhreml524-mbs.china.huawei.com>
References: <20190128110545.20644-1-shameerali.kolothum.thodi@huawei.com>
	<3a6bf5ea-5b48-18c2-8a2c-0ced777be816@redhat.com>
	<892e3eb7-66f5-92a3-5891-de8665fc984a@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA8392D6875@lhreml524-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 0/4] ARM virt: ACPI memory hotplug
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Auger Eric <eric.auger@redhat.com>, "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei (O)" <xuwei5@huawei.com>, Linuxarm <linuxarm@huawei.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Leif
	Lindholm (Linaro address)" <leif.lindholm@linaro.org>

On Wed, 27 Feb 2019 12:55:18 +0000
Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

> Hi Laszlo,
> 
> > -----Original Message-----
> > From: Shameerali Kolothum Thodi
> > Sent: 25 February 2019 09:54
> > To: 'Laszlo Ersek' <lersek@redhat.com>; Auger Eric <eric.auger@redhat.com>;
> > shannon.zhaosl@gmail.com; peter.maydell@linaro.org;
> > imammedo@redhat.com; qemu-devel@nongnu.org; qemu-arm@nongnu.org
> > Cc: xuwei (O) <xuwei5@huawei.com>; Linuxarm <linuxarm@huawei.com>; Ard
> > Biesheuvel <ard.biesheuvel@linaro.org>; Leif Lindholm (Linaro address)
> > <leif.lindholm@linaro.org>
> > Subject: RE: [RFC PATCH 0/4] ARM virt: ACPI memory hotplug support  
> 
> [...]
>  
> > > >> The root cause seems to be EDK2 ACPI table checksum failure
> > > >> as NFIT table is getting updated on hot-add. This needs further
> > > >> investigation.  
> > > > + Ard, Leif, Laszlo if they have any idea of what is missing/wrong.  
> > >
> > > Huh, very interesting; I usually don't expect my sanity checks to fire
> > > in practice. :)
> > >
> > > The message
> > >
> > >   ProcessCmdAddChecksum: invalid checksum range in "etc/acpi/tables"
> > >
> > > is logged by OVMF's and ArmVirtQemu's ACPI Platform DXE Driver when it
> > > finds an invalid COMMAND_ADD_CHECKSUM command in QEMU's ACPI
> > > linker/loader script.
> > >
> > > Please see the command definition in QEMU's
> > > "hw/acpi/bios-linker-loader.c". In particular, please refer to the
> > > function bios_linker_loader_add_checksum(), which builds the command
> > > structure, and documents the fields.
> > >
> > > (You may also refer to QEMU_LOADER_ADD_CHECKSUM in file
> > > "OvmfPkg/AcpiPlatformDxe/QemuLoader.h" in the edk2 source tree, for the
> > > same information.)
> > >
> > > The error message is logged if:
> > > - the offset at which the checksum should be stored falls outside of the
> > > size of the fw_cfg blob, or
> > > - the range over which the checksum should be calculated falls outside
> > > (at least in part) of the fw_cfg blob.
> > >
> > > To me this suggests that QEMU generates an invalid
> > > COMMAND_ADD_CHECKSUM
> > > command for the firmware.
> > >
> > > ... I've tried to skim the patches briefly. I think there must be an
> > > error in the DSDT building logic that is only active on reboot if an
> > > nvdimm module was hot-added before the reboot.  
> > 
> > Thanks for taking a look and the pointers. I will debug this further
> > and get back.  
> 
> The root cause of the issue seems to be UEFI not seeing the updated acpi
> table blob size on reboot once a new NFIT table is added(nvdimm hot added).
> 
> Please see the debug logs below,
> 
> Initial Guest boot
> ---------------------------
> 
> Debug logs from Qemu:
> 
> build_header: acpi sig DSDT len 0x5127
> build_header: acpi sig FACP len 0x10c
> build_header: acpi sig APIC len 0xa8
> build_header: acpi sig GTDT len 0x60
> build_header: acpi sig MCFG len 0x3c
> build_header: acpi sig SPCR len 0x50
> build_header: acpi sig SRAT len 0x92
> build_header: acpi sig SSDT len 0x38f
> build_header: acpi sig XSDT len 0x5c
> virt_acpi_build: acpi table_blob len 0x5844
> 
> Debug logs from UEFI:
> 
> ProcessCmdAddChecksum: File="etc/acpi/tables" ResultOffset=0x9 Start=0x0 Length=0x5127 Blob->Size=0x5844
> ProcessCmdAddChecksum: File="etc/acpi/tables" ResultOffset=0x5130 Start=0x5127 Length=0x10C Blob->Size=0x5844
> ProcessCmdAddChecksum: File="etc/acpi/tables" ResultOffset=0x523C Start=0x5233 Length=0xA8 Blob->Size=0x5844
> ProcessCmdAddChecksum: File="etc/acpi/tables" ResultOffset=0x52E4 Start=0x52DB Length=0x60 Blob->Size=0x5844
> ProcessCmdAddChecksum: File="etc/acpi/tables" ResultOffset=0x5344 Start=0x533B Length=0x3C Blob->Size=0x5844
> ProcessCmdAddChecksum: File="etc/acpi/tables" ResultOffset=0x5380 Start=0x5377 Length=0x50 Blob->Size=0x5844
> ProcessCmdAddChecksum: File="etc/acpi/tables" ResultOffset=0x53D0 Start=0x53C7 Length=0x92 Blob->Size=0x5844
> ProcessCmdAddChecksum: File="etc/acpi/tables" ResultOffset=0x5462 Start=0x5459 Length=0x38F Blob->Size=0x5844
> ProcessCmdAddChecksum: File="etc/acpi/tables" ResultOffset=0x57F1 Start=0x57E8 Length=0x5C Blob->Size=0x5844
> ProcessCmdAddChecksum: File="etc/acpi/rsdp" ResultOffset=0x8 Start=0x0 Length=0x14 Blob->Size=0x24
> ProcessCmdAddChecksum: File="etc/acpi/rsdp" ResultOffset=0x20 Start=0x0 Length=0x24 Blob->Size=0x24
> InstallQemuFwCfgTables: installed 8 tables
> 
> Guest Reboot after ndimm hot added
> ------------------------------------
> 
> Debug logs from Qemu:
> 
> build_header: acpi sig DSDT len 0x5127
> build_header: acpi sig FACP len 0x10c
> build_header: acpi sig APIC len 0xa8
> build_header: acpi sig GTDT len 0x60
> build_header: acpi sig MCFG len 0x3c
> build_header: acpi sig SPCR len 0x50
> build_header: acpi sig SRAT len 0x92
> build_header: acpi sig SSDT len 0x38f
> build_header: acpi sig NFIT len 0xe0  -->New
> build_header: acpi sig XSDT len 0x64
> virt_acpi_build: acpi table_blob len 0x592c -->blob len updated
> 
> Debug logs from UEFI:
> 
> ProcessCmdAddChecksum: File="etc/acpi/tables" ResultOffset=0x9 Start=0x0 Length=0x5127 Blob->Size=0x5844  -->Wrong blob size.
> ProcessCmdAddChecksum: File="etc/acpi/tables" ResultOffset=0x5130 Start=0x5127 Length=0x10C Blob->Size=0x5844
> ProcessCmdAddChecksum: File="etc/acpi/tables" ResultOffset=0x523C Start=0x5233 Length=0xA8 Blob->Size=0x5844
> ProcessCmdAddChecksum: File="etc/acpi/tables" ResultOffset=0x52E4 Start=0x52DB Length=0x60 Blob->Size=0x5844
> ProcessCmdAddChecksum: File="etc/acpi/tables" ResultOffset=0x5344 Start=0x533B Length=0x3C Blob->Size=0x5844
> ProcessCmdAddChecksum: File="etc/acpi/tables" ResultOffset=0x5380 Start=0x5377 Length=0x50 Blob->Size=0x5844
> ProcessCmdAddChecksum: File="etc/acpi/tables" ResultOffset=0x53D0 Start=0x53C7 Length=0x92 Blob->Size=0x5844
> ProcessCmdAddChecksum: File="etc/acpi/tables" ResultOffset=0x5462 Start=0x5459 Length=0x38F Blob->Size=0x5844
> ProcessCmdAddChecksum: File="etc/acpi/tables" ResultOffset=0x57F1 Start=0x57E8 Length=0xE0 Blob->Size=0x5844
> ProcessCmdAddChecksum: invalid checksum range in "etc/acpi/tables"
> OnRootBridgesConnected: InstallAcpiTables: Protocol Error
> 
> 
> To me it seems on ARM vit acpi path, the blob len is calculated based
> on actual tables and is updated only in virt_acpi_setup() --> acpi_add_rom_blob()
> path. I had a look at the x86 code and it looks like, there, the blob len gets updated
> with an additional buffer to take care of table resizing[1].
> 
> As a hack i added the same to ARM virt and it seems to resolve the issue.
> I am not sure this is the best approach to fix this though.
> 
> Please let me know your thoughts.
> 
> Thanks,
> Shameer
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 132414c..4291553 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -50,6 +50,8 @@
>  #define ARM_SPI_BASE 32
>  #define ACPI_POWER_BUTTON_DEVICE "PWRB"
> 
> +#define ACPI_BUILD_TABLE_SIZE    0x20000
> +
>  static void acpi_dsdt_add_cpus(Aml *scope, int smp_cpus)
>  {
>      uint16_t i;
> @@ -886,6 +888,10 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>          build_rsdp(tables->rsdp, tables->linker, &rsdp_data);
>      }
> 
> +    /* Make sure we have a buffer in case we need to resize the tables. */
> +    g_array_set_size(tables_blob, ROUND_UP(acpi_data_len(tables_blob),
> +                     ACPI_BUILD_TABLE_SIZE));
not sure fixup is correct approach.

On reset (on QEMU level), it's upto to QEMU to rebuild tables and it's
upto firmware to reread those.
Maybe issue existed before hotplug it's just that hotplug exposes it.
(something is missing compared to x86 or we have the same issue
there too just no one have triggered it yet).
I suggest to find root cause first before we start paper over it. 

> +
>      /* Cleanup memory that's no longer used. */
>      g_array_free(table_offsets, true);
>  }
> 
> [1] https://github.com/qemu/qemu/blob/master/hw/i386/acpi-build.c#L2792
> 
> 
> 
> 
> 
> 
