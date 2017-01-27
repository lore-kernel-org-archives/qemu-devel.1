Received: from eggs.gnu.org ([2001:4830:134:3::10]:35604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cX72B-0007ld-N4
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:57:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cX726-0001F2-Q2
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:57:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cX726-0001E4-Hq
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:57:42 -0500
Date: Fri, 27 Jan 2017 14:57:37 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170127145737.3796d088@nial.brq.redhat.com>
In-Reply-To: <CAAibmn1j8819O1UbSOQphe=2-uAt29uYQXhOkCnc_BKiYovD9w@mail.gmail.com>
References: <1484739954-86833-1-git-send-email-phil@philjordan.eu>
	<20170118175335-mutt-send-email-mst@kernel.org>
	<CAAibmn3GJWWun69KCHp+0qCBo=fjg1_xg+R_o+Qyro48a7Y_zQ@mail.gmail.com>
	<20170123121204.547e6415@nial.brq.redhat.com>
	<CAAibmn1j8819O1UbSOQphe=2-uAt29uYQXhOkCnc_BKiYovD9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] acpi: add reset register to fadt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Thu, 26 Jan 2017 14:43:04 +0100
Phil Dennis-Jordan <phil@philjordan.eu> wrote:

> On 23 January 2017 at 12:12, Igor Mammedov <imammedo@redhat.com> wrote:
> >> For reference, my approach to filling out the Xdsdt/Xfacs fields in
> >> build_fadt() is essentially the same as for the 32-bit variants from
> >> rev1:
> >>
> >> unsigned xfacs_offset = (char *)&fadt->Xfacs - table_data->data;
> >> bios_linker_loader_add_pointer(linker,
> >>         ACPI_BUILD_TABLE_FILE, xfacs_offset, sizeof(fadt->Xfacs),
> >>         ACPI_BUILD_TABLE_FILE, facs_tbl_offset);
> >>
> >> Suggestions welcome.  
> > You are not supposed to fill in the same values in X_FOO as in FOO.
> > Spec says that only either one of above should be set.  
> 
> Thanks for clarifying that. I'd been looking at the ACPI 2.0 spec,
> which isn't clear on this point - the 5.0 one unambiguously agrees
> with you.
> 
> I've tested the FADT change through again. Leaving Xdsdt and Xfacs as
> 0 in the Rev3 does indeed allow macOS to boot, as previously reported.
> Rebooting also works, which is the whole point of the patch. I'm still
> no further with getting Windows 10 past the "ACPI BIOS ERROR"
> bluescreen, however, even after some more experimenting with the
> various fields.
> I've tried a Rev5 FADT too, the Win10 bootloader just hangs in this
> cace, I don't even get a bluescreen. macOS is still happy.
> I've dumped the ACPI tables that OVMF ultimately exports with an EFI
> shell utility, and it all looks ok to me there; I also added various
> debug output to OVMF's ACPI code, and again everything looks pretty
> sane there. I guess my problem is I don't know what I'm looking for as
> I haven't found a way for Windows to tell me exactly what it doesn't
> like.
> 
> I'm basically stumped on the Windows 10 issue, but I'd still like to
> fix macOS guest rebooting. Would a patch be acceptable that introduces
> a Rev3 FADT option? (or Rev5 - this'll be much less code as the struct
> already exists) If so, what nature should the option take?
> 
> For reference, my latest FADT Rev3 prototype patch follows, in case
> anyone can spot some obvious problem. (I've kept this as compact as
> possible as opposed to optimising code quality for upstreaming.) The
> Rev5 FADT is identical except it uses sizeof(*fadt) and of course 5 as
> the revision.
> 
> ---
>  hw/i386/acpi-build.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 1c928ab..19dde8b 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -271,7 +271,7 @@ build_facs(GArray *table_data, BIOSLinker *linker)
>  }
> 
>  /* Load chipset information in FADT */
> -static void fadt_setup(AcpiFadtDescriptorRev1 *fadt, AcpiPmInfo *pm)
> +static void fadt_setup(AcpiFadtDescriptorRev5_1 *fadt, AcpiPmInfo *pm)
>  {
>      fadt->model = 1;
>      fadt->reserved1 = 0;
> @@ -296,6 +296,11 @@ static void fadt_setup(AcpiFadtDescriptorRev1
> *fadt, AcpiPmInfo *pm)
>                                (1 << ACPI_FADT_F_SLP_BUTTON) |
>                                (1 << ACPI_FADT_F_RTC_S4));
>      fadt->flags |= cpu_to_le32(1 << ACPI_FADT_F_USE_PLATFORM_CLOCK);
> +    fadt->flags |= cpu_to_le32(1 << ACPI_FADT_F_RESET_REG_SUP);
> +    fadt->reset_value = 0xf;
> +    fadt->reset_register.space_id   = 1;
> +    fadt->reset_register.bit_width = 8;
> +    fadt->reset_register.address            = ICH9_RST_CNT_IOPORT;
cpu_to_le64

+ specify explicitly all fields of GAS structure: reset_register

+ is reset_register applicable only to q35 or to both machine types?
If it's only q35, you should do above only for it.

>      /* APIC destination mode ("Flat Logical") has an upper limit of 8 CPUs
>       * For more than 8 CPUs, "Clustered Logical" mode has to be used
>       */
> @@ -303,6 +308,15 @@ static void fadt_setup(AcpiFadtDescriptorRev1
> *fadt, AcpiPmInfo *pm)
>          fadt->flags |= cpu_to_le32(1 << ACPI_FADT_F_FORCE_APIC_CLUSTER_MODEL);
>      }
>      fadt->century = RTC_CENTURY;
> +
> +    fadt->xpm1a_event_block.address = cpu_to_le64(pm->io_base);
> +    fadt->xpm1a_event_block.space_id = 1;
> +    fadt->xpm1a_control_block.address = cpu_to_le64(pm->io_base + 0x04);
> +    fadt->xpm1a_control_block.space_id = 1;
> +    fadt->xpm_timer_block.address = cpu_to_le64(pm->io_base + 0x08);
> +    fadt->xpm_timer_block.space_id = 1;
> +    fadt->xgpe0_block.address = cpu_to_le64(pm->gpe0_blk);
> +    fadt->xgpe0_block.space_id = 1;
ditto: wrt all fields of xxx

>  }
> 
> 
> @@ -312,7 +326,7 @@ build_fadt(GArray *table_data, BIOSLinker *linker,
> AcpiPmInfo *pm,
>             unsigned facs_tbl_offset, unsigned dsdt_tbl_offset,
>             const char *oem_id, const char *oem_table_id)
>  {
> -    AcpiFadtDescriptorRev1 *fadt = acpi_data_push(table_data, sizeof(*fadt));
> +    AcpiFadtDescriptorRev5_1 *fadt = acpi_data_push(table_data, 244);
>      unsigned fw_ctrl_offset = (char *)&fadt->firmware_ctrl - table_data->data;
>      unsigned dsdt_entry_offset = (char *)&fadt->dsdt - table_data->data;
> 
> @@ -328,7 +342,7 @@ build_fadt(GArray *table_data, BIOSLinker *linker,
> AcpiPmInfo *pm,
>          ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
xdsdt field is mandatory per 5.1 spec, but I don't see you adding pointer to it.

> 
>      build_header(linker, table_data,
> -                 (void *)fadt, "FACP", sizeof(*fadt), 1, oem_id, oem_table_id);
> +                 (void *)fadt, "FACP", 244, 3, oem_id, oem_table_id);
>  }
> 
>  void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
> --
