Received: from eggs.gnu.org ([2001:4830:134:3::10]:32985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1daGvL-0002K6-6o
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 03:40:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1daGvH-00017R-7C
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 03:40:03 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:35419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1daGvH-00015m-21
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 03:39:59 -0400
Received: by mail-ua0-f171.google.com with SMTP id d29so104816317uai.2
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 00:39:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170725162344-mutt-send-email-mst@kernel.org>
References: <1500629531-184026-1-git-send-email-imammedo@redhat.com>
	<20170721094955.GH17693@redhat.com>
	<20170721121048.44d617ea@nial.brq.redhat.com>
	<20170722023020-mutt-send-email-mst@kernel.org>
	<20170724084848.259c0bfc@nial.brq.redhat.com>
	<20170725162344-mutt-send-email-mst@kernel.org>
From: Ladi Prosek <lprosek@redhat.com>
Date: Wed, 26 Jul 2017 09:39:55 +0200
Message-ID: <CABdb735ET-AzGRtz44qX3avAY16PQOT2ENASmmyyT=_j_D=T6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] pc: acpi: force FADT rev1 for old i440fx
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Programmingkid <programmingkidx@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Phil Dennis-Jordan <lists@philjordan.eu>

On Tue, Jul 25, 2017 at 3:26 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Mon, Jul 24, 2017 at 08:48:48AM +0200, Igor Mammedov wrote:
>> On Sat, 22 Jul 2017 02:40:46 +0300
>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>
>> > On Fri, Jul 21, 2017 at 12:10:48PM +0200, Igor Mammedov wrote:
>> > > On Fri, 21 Jul 2017 10:49:55 +0100
>> > > "Daniel P. Berrange" <berrange@redhat.com> wrote:
>> > >
>> > > > On Fri, Jul 21, 2017 at 11:32:11AM +0200, Igor Mammedov wrote:
>> > > > > w2k used to boot on QEMU until we bumped revision of FADT to rev3
>> > > > > (commit 77af8a2b hw/i386: Use Rev3 FADT (ACPI 2.0) instead of Rev1 to improve guest OS support.)
>> > > > >
>> > > > > Considering that w2k is ancient and long time EOLed, leave default
>> > > > > rev3 but make pc-i440fx-2.9 and older machine types to force rev1
>> > > > > so old setups won't break (w2k could boot).
>> > > >
>> > > > There needs to be a machine type property added to control this
>> > > > feature. When provisioning new VMs, management apps need to be
>> > > > able to set the property explicitly - having them rely on picking
>> > > > particular machine type name+versions is not viable, because
>> > > > downstream vendors replace the machine types with their own
>> > > > names + versions.
>> > > having property doesn't really help here and we don't do it for every
>> > > compat tweak /ex: save_tsc_khz, linuxboot_dma_enabled/.
>> > >
>> > > Management would not benefit much from having property vs machine version
>> > > as it would have to encode somewhere that for w2k it should set
>> > > some machine property or pick a particular machine type.
>> >
>> > I think I'd disagree with that. If
>> > users might need this for compatibility with some guests,
>> > then it should be a property not just a machine type.
>> >
>> > But see below - I think we rushed it for the PC anyway.
>> >
>> > > Probably no one would worry about fixing virt-install or something
>> > > else for the sake of w2k and if they are going to fix it
>> > > it doesn't matter if they map machine type vs property.
>> > >
>> > > Also with new machine type deprecation policy we would be able
>> > > easily to phase out rev1 support along with 2.9 machine,
>> > > but if you expose property then removing it would break
>> > > CLI not only for 2.9 but possible later machines if it's set there.
>> > >
>> > > So I'm against adding properties/CLI options for unless we have to in this case,
>> > > and I'm not convinced that w2k deserves it.
>> >
>> > If I have to choose, I'd say Mac OSX is way less interesting than old
>> > windows versions. Lots of people have software that will only run on old
>> > windows and there's probably good money to be had running it on new
>> > hardware in VMs. And PC machine is all about compatibility - we have Q35
>> > for new stuff.  Besides OSX uses q35 anyway I think.
>> Question is for how long we are going to maintain legacy stuff,
>> ACPI spec periodically adds new stuff, which someday is going
>> to break legacy OSes. And maintaining 2 branches of or worse
>> a mix will cost us in time and future regressions, we need to
>> have some policy to cut off legacy features that hold us back,
>> like we are starting to do with machine types.
>> w2k has been EOLed in 2010 even if we drop its support now,
>> users still can use it as they have an option to use old QEMU
>> for that.
>
> Users can't normally get old QEMU, even if they could it is not
> a good idea because of security.
>
>> (Ladi said that w2k fails to install since 2.7).
>
> Bisect will likely find what's wrong.

I still intend to find the issue. Unlike this FADT revision/length
problem, setup fails after a long time, basically at the very end of
the process. I tried to speed up bisecting it by saving the state of
the VM before the failure and running just the problematic part but it
didn't work. I'll just have to bite the bullet and run setup from the
beginning every time.

>> >
>> > So maybe the right thing to do is to
>> > - switch default for PC back to rev 1
>> > - keep default for Q35 at rev 3
>> >
>> > No machinetype hacks.
>> it's still machine hack pc vs q35 and an extra branch to look
>> after but it's better than an option, I'll respin patch.
>>
>> >
>> > > > >
>> > > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> > > > > ---
>> > > > > CC: Programmingkid <programmingkidx@gmail.com>
>> > > > > CC: Phil Dennis-Jordan <lists@philjordan.eu>
>> > > > > CC: "Michael S. Tsirkin" <mst@redhat.com>
>> > > > >
>> > > > > Only compile test since I don't have w2k to test with
>> > > > >
>> > > > > ---
>> > > > >  include/hw/i386/pc.h |  1 +
>> > > > >  hw/i386/acpi-build.c | 26 +++++++++++++++++++-------
>> > > > >  hw/i386/pc_piix.c    |  2 ++
>> > > > >  3 files changed, 22 insertions(+), 7 deletions(-)
>> > > > >
>> > > > > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>> > > > > index d80859b..d6f65dd 100644
>> > > > > --- a/include/hw/i386/pc.h
>> > > > > +++ b/include/hw/i386/pc.h
>> > > > > @@ -122,6 +122,7 @@ struct PCMachineClass {
>> > > > >      bool rsdp_in_ram;
>> > > > >      int legacy_acpi_table_size;
>> > > > >      unsigned acpi_data_size;
>> > > > > +    bool force_rev1_fadt;
>> > > > >
>> > > > >      /* SMBIOS compat: */
>> > > > >      bool smbios_defaults;
>> > > > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> > > > > index 6b7bade..227f9ad 100644
>> > > > > --- a/hw/i386/acpi-build.c
>> > > > > +++ b/hw/i386/acpi-build.c
>> > > > > @@ -272,7 +272,7 @@ build_facs(GArray *table_data, BIOSLinker *linker)
>> > > > >  }
>> > > > >
>> > > > >  /* Load chipset information in FADT */
>> > > > > -static void fadt_setup(AcpiFadtDescriptorRev3 *fadt, AcpiPmInfo *pm)
>> > > > > +static void fadt_setup(AcpiFadtDescriptorRev3 *fadt, AcpiPmInfo *pm, bool rev1)
>> > > > >  {
>> > > > >      fadt->model = 1;
>> > > > >      fadt->reserved1 = 0;
>> > > > > @@ -304,6 +304,9 @@ static void fadt_setup(AcpiFadtDescriptorRev3 *fadt, AcpiPmInfo *pm)
>> > > > >          fadt->flags |= cpu_to_le32(1 << ACPI_FADT_F_FORCE_APIC_CLUSTER_MODEL);
>> > > > >      }
>> > > > >      fadt->century = RTC_CENTURY;
>> > > > > +    if (rev1) {
>> > > > > +        return;
>> > > > > +    }
>> > > > >
>> > > > >      fadt->flags |= cpu_to_le32(1 << ACPI_FADT_F_RESET_REG_SUP);
>> > > > >      fadt->reset_value = 0xf;
>> > > > > @@ -335,6 +338,7 @@ static void fadt_setup(AcpiFadtDescriptorRev3 *fadt, AcpiPmInfo *pm)
>> > > > >  /* FADT */
>> > > > >  static void
>> > > > >  build_fadt(GArray *table_data, BIOSLinker *linker, AcpiPmInfo *pm,
>> > > > > +           MachineState *machine,
>> > > > >             unsigned facs_tbl_offset, unsigned dsdt_tbl_offset,
>> > > > >             const char *oem_id, const char *oem_table_id)
>> > > > >  {
>> > > > > @@ -342,6 +346,9 @@ build_fadt(GArray *table_data, BIOSLinker *linker, AcpiPmInfo *pm,
>> > > > >      unsigned fw_ctrl_offset = (char *)&fadt->firmware_ctrl - table_data->data;
>> > > > >      unsigned dsdt_entry_offset = (char *)&fadt->dsdt - table_data->data;
>> > > > >      unsigned xdsdt_entry_offset = (char *)&fadt->x_dsdt - table_data->data;
>> > > > > +    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(machine);
>> > > > > +    int fadt_size = sizeof(*fadt);
>> > > > > +    int rev = 3;
>> > > > >
>> > > > >      /* FACS address to be filled by Guest linker */
>> > > > >      bios_linker_loader_add_pointer(linker,
>> > > > > @@ -349,16 +356,21 @@ build_fadt(GArray *table_data, BIOSLinker *linker, AcpiPmInfo *pm,
>> > > > >          ACPI_BUILD_TABLE_FILE, facs_tbl_offset);
>> > > > >
>> > > > >      /* DSDT address to be filled by Guest linker */
>> > > > > -    fadt_setup(fadt, pm);
>> > > > > +    fadt_setup(fadt, pm, pcmc->force_rev1_fadt);
>> > > > >      bios_linker_loader_add_pointer(linker,
>> > > > >          ACPI_BUILD_TABLE_FILE, dsdt_entry_offset, sizeof(fadt->dsdt),
>> > > > >          ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
>> > > > > -    bios_linker_loader_add_pointer(linker,
>> > > > > -        ACPI_BUILD_TABLE_FILE, xdsdt_entry_offset, sizeof(fadt->x_dsdt),
>> > > > > -        ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
>> > > > > +    if (pcmc->force_rev1_fadt) {
>> > > > > +        rev = 1;
>> > > > > +        fadt_size = offsetof(typeof(*fadt), reset_register);
>> > > > > +    } else {
>> > > > > +        bios_linker_loader_add_pointer(linker,
>> > > > > +            ACPI_BUILD_TABLE_FILE, xdsdt_entry_offset, sizeof(fadt->x_dsdt),
>> > > > > +            ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
>> > > > > +    }
>> > > > >
>> > > > >      build_header(linker, table_data,
>> > > > > -                 (void *)fadt, "FACP", sizeof(*fadt), 3, oem_id, oem_table_id);
>> > > > > +                 (void *)fadt, "FACP", fadt_size, rev, oem_id, oem_table_id);
>> > > > >  }
>> > > > >
>> > > > >  void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
>> > > > > @@ -2667,7 +2679,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>> > > > >      /* ACPI tables pointed to by RSDT */
>> > > > >      fadt = tables_blob->len;
>> > > > >      acpi_add_table(table_offsets, tables_blob);
>> > > > > -    build_fadt(tables_blob, tables->linker, &pm, facs, dsdt,
>> > > > > +    build_fadt(tables_blob, tables->linker, &pm, machine, facs, dsdt,
>> > > > >                 slic_oem.id, slic_oem.table_id);
>> > > > >      aml_len += tables_blob->len - fadt;
>> > > > >
>> > > > > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> > > > > index 11b4336..bc61332 100644
>> > > > > --- a/hw/i386/pc_piix.c
>> > > > > +++ b/hw/i386/pc_piix.c
>> > > > > @@ -449,9 +449,11 @@ DEFINE_I440FX_MACHINE(v2_10, "pc-i440fx-2.10", NULL,
>> > > > >
>> > > > >  static void pc_i440fx_2_9_machine_options(MachineClass *m)
>> > > > >  {
>> > > > > +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>> > > > >      pc_i440fx_2_10_machine_options(m);
>> > > > >      m->is_default = 0;
>> > > > >      m->alias = NULL;
>> > > > > +    pcmc->force_rev1_fadt = true;
>> > > > >      SET_MACHINE_COMPAT(m, PC_COMPAT_2_9);
>> >
>> > whatever switch we use for this option, I think it makes
>> > sense to add comments to document why we keep this around.
>> ok
>>
>> >
>> >
>> > > > >  }
>> > > > >
>> > > > > --
>> > > > > 2.7.4
>> > > > >
>> > > > >
>> > > >
>> > > > Regards,
>> > > > Daniel
>> >
>
