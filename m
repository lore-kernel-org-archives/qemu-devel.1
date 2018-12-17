Received: from eggs.gnu.org ([2001:4830:134:3::10]:39192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ1w8-00072T-DC
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:04:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ1w7-0003mx-6H
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:04:32 -0500
Date: Mon, 17 Dec 2018 18:04:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181217180208-mutt-send-email-mst@kernel.org>
References: <20181217104838.18957-1-sameo@linux.intel.com>
	<20181217104838.18957-8-sameo@linux.intel.com>
	<20181217132028.4e387d2d@Igors-MacBook-Pro.local>
	<20181217134959.GB4456@caravaggio>
	<20181217163536.034fd13c@Igors-MacBook-Pro.local>
	<20181217164648.GG4456@caravaggio>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181217164648.GG4456@caravaggio>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 7/8] hw: acpi: Export and share the ARM
 RSDP build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>, qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Dec 17, 2018 at 05:46:48PM +0100, Samuel Ortiz wrote:
> On Mon, Dec 17, 2018 at 04:35:36PM +0100, Igor Mammedov wrote:
> > On Mon, 17 Dec 2018 14:49:59 +0100
> > Samuel Ortiz <sameo@linux.intel.com> wrote:
> >=20
> > > On Mon, Dec 17, 2018 at 01:20:28PM +0100, Igor Mammedov wrote:
> > > > On Mon, 17 Dec 2018 11:48:37 +0100
> > > > Samuel Ortiz <sameo@linux.intel.com> wrote:
> > > >=20
> > > > > Now that build_rsdp() supports building both legacy and current=
 RSDP
> > > > > tables, we can move it to a generic folder (hw/acpi) and have t=
he i386
> > > > > ACPI code reuse it in order to reduce code duplication.
> > > > >=20
> > > > > Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> > > > > Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > > > > Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > > > > Reviewed-by: Andrew Jones <drjones@redhat.com>
> > > > > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > > > for future reference, if one changes patch in a significant way,
> > > > one is supposed to drop Tested/Reviewed-by tags so that reviewers
> > > > would look at it again and we by mistake won't merge not actually
> > > > reviewed changes.
> > > >=20
> > > > [...]
> > > >=20
> > > > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > > > index fb877648ac..846cb6d755 100644
> > > > > --- a/hw/i386/acpi-build.c
> > > > > +++ b/hw/i386/acpi-build.c
> > > > > @@ -2547,35 +2547,6 @@ build_amd_iommu(GArray *table_data, BIOS=
Linker *linker)
> > > > >                   "IVRS", table_data->len - iommu_start, 1, NUL=
L, NULL);
> > > > >  }
> > > > > =20
> > > > > -static void
> > > > > -build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rs=
dt_tbl_offset)
> > > > > -{
> > > > > -    /* AcpiRsdpDescriptor describes revision 2 RSDP table and =
as result we
> > > > > -     * allocate extra 16 bytes for pc/q35 RSDP rev1 as well. K=
eep extra 16 bytes
> > > > > -     * wasted to make sure we won't breake migration for machi=
ne types older
> > > > > -     * than 2.3 due to size mismatch.
> > > > > -     */
> > > > > -    AcpiRsdpDescriptor *rsdp =3D acpi_data_push(rsdp_table, si=
zeof *rsdp);
> > > > > -    unsigned rsdt_pa_size =3D sizeof(rsdp->rsdt_physical_addre=
ss);
> > > > > -    unsigned rsdt_pa_offset =3D
> > > > > -        (char *)&rsdp->rsdt_physical_address - rsdp_table->dat=
a;
> > > > > -
> > > > > -    bios_linker_loader_alloc(linker, ACPI_BUILD_RSDP_FILE, rsd=
p_table, 16,
> > > > > -                             true /* fseg memory */);
> > > > > -
> > > > > -    memcpy(&rsdp->signature, "RSD PTR ", 8);
> > > > > -    memcpy(rsdp->oem_id, ACPI_BUILD_APPNAME6, 6);
> > > > > -    /* Address to be filled by Guest linker */
> > > > > -    bios_linker_loader_add_pointer(linker,
> > > > > -        ACPI_BUILD_RSDP_FILE, rsdt_pa_offset, rsdt_pa_size,
> > > > > -        ACPI_BUILD_TABLE_FILE, rsdt_tbl_offset);
> > > > > -
> > > > > -    /* Checksum to be filled by Guest linker */
> > > > > -    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FI=
LE,
> > > > > -        (char *)rsdp - rsdp_table->data, 20 /* ACPI rev 1.0 RS=
DP size */,
> > > > > -        (char *)&rsdp->checksum - rsdp_table->data);
> > > > > -}
> > > > > -
> > > > >  typedef
> > > > >  struct AcpiBuildState {
> > > > >      /* Copy of table in RAM (for patching). */
> > > > > @@ -2732,7 +2703,25 @@ void acpi_build(AcpiBuildTables *tables,=
 MachineState *machine)
> > > > >                 slic_oem.id, slic_oem.table_id);
> > > > > =20
> > > > >      /* RSDP is in FSEG memory, so allocate it separately */
> > > > > -    build_rsdp(tables->rsdp, tables->linker, rsdt);
> > > > > +    {
> > > > > +        AcpiRsdpData rsdp_data =3D {
> > > > > +            .revision =3D 0,
> > > > > +            .oem_id =3D ACPI_BUILD_APPNAME6,
> > > > > +            .xsdt_tbl_offset =3D NULL,
> > > > > +            .rsdt_tbl_offset =3D &rsdt,
> > > > > +        };
> > > > > +        build_rsdp(tables->rsdp, tables->linker, &rsdp_data);
> > > > > +        if (!pcmc->rsdp_in_ram) {
> > > > > +            /*
> > > > > +             * Legacy machine types (2.2 and older) expect to =
get a complete
> > > > > +             * revision 2 RSDP table, even though they only lo=
ok at the
> > > > not true, rev is set to 0 for pc machines,
> > > Rev is set to 0 but they effectively expect to get a structure whic=
h
> > > size is the rev 2 one. That's what I meant.
> > >=20
> > > > the point of the original comment was
> > > > that we allocate extra 16 bytes but not actually using them and w=
hy it's bad
> > > > to drop it suddenly.
> > > >
> > > > > +             * revision 0 fields (xsdt pointer is not set). So=
 in order to
> > > > > +             * not break migration to those machine types we w=
aste 16 bytes
> > > > > +             * that we amend to the RSDP revision 0 structure.
> > > >                           ^^^ added
> > > > > +             */
> > > > Perhaps amended original comment would be clearer:
> > > >=20
> > > >    /* We used to allocate extra space for RSDP rev 2 but used onl=
y space for
> > > >     * legacy RSDP and extra bytes were zeroed out. Keep wasting e=
xtra 16 bytes
> > > >     * to make sure we won't breake migration for machine types 2.=
2 and older
> > > >     * due to RSDP blob size mismatch.
> > > >     */
> > > >=20
> > > > > +            build_append_int_noprefix(tables->rsdp, 0, 16);
> > Looks like I've haven't noticed, it might work but are you sure?
> > 0 here is uint64_t and then it's shifted 16 times which is sort of gr=
ay area (undefined behavior)
> AFAIK shifting by N bits when N > width(left operand) is undefined but
> that's not the case here. build_append_int_noprefix(foo, 0, 16) shift a=
 64 bits
> wide unsigned int by 8 bits, for each iterations of a 16 iterations
> loop. So we're doing 16 iterations of properly defined behaviour.
>=20
> Cheers,
> Samuel.

It works fine but is IMHO unnecessarily tricky. Simple

	for (i =3D 0; i < 16; ++i)
		build_append_byte(tables->rsdp, 0)

is imho clearer.
