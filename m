Received: from eggs.gnu.org ([2001:4830:134:3::10]:57328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fcfYK-0001f9-Hk
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 19:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fcfYJ-0005hy-95
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 19:26:44 -0400
Date: Tue, 10 Jul 2018 02:26:35 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180710022532-mutt-send-email-mst@kernel.org>
References: <20180705235305.124423-1-mst@redhat.com>
	<20180709175232.5e768dfb@redhat.com>
	<20180709200456-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709200456-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH] acpi: generalize aml_package /
 aml_varpackage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

On Mon, Jul 09, 2018 at 08:19:17PM +0300, Michael S. Tsirkin wrote:
> On Mon, Jul 09, 2018 at 05:52:32PM +0200, Igor Mammedov wrote:
> > On Fri, 6 Jul 2018 02:53:09 +0300
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > VarPackage can accept an expression evaluating to int, not just an int.
> > > Change the API to make it more generic.
> > > Further, rather than have users call the correct API depending on
> > > value passed, use either PackageOp or VarPackageOp automatically.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  include/hw/acpi/aml-build.h |  4 ++--
> > >  hw/acpi/aml-build.c         | 18 ++++++++++++++----
> > >  hw/acpi/cpu_hotplug.c       | 11 ++---------
> > >  hw/arm/virt-acpi-build.c    |  2 +-
> > >  4 files changed, 19 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> > > index 10c7946028..7cf2cf64bf 100644
> > > --- a/include/hw/acpi/aml-build.h
> > > +++ b/include/hw/acpi/aml-build.h
> > > @@ -360,7 +360,7 @@ Aml *aml_method(const char *name, int arg_count, AmlSerializeFlag sflag);
> > >  Aml *aml_if(Aml *predicate);
> > >  Aml *aml_else(void);
> > >  Aml *aml_while(Aml *predicate);
> > > -Aml *aml_package(uint8_t num_elements);
> > > +Aml *aml_package(uint64_t num_elements);
> > >  Aml *aml_buffer(int buffer_size, uint8_t *byte_list);
> > >  Aml *aml_resource_template(void);
> > >  Aml *aml_field(const char *name, AmlAccessType type, AmlLockRule lock,
> > > @@ -373,7 +373,7 @@ Aml *aml_create_field(Aml *srcbuf, Aml *bit_index, Aml *num_bits,
> > >                        const char *name);
> > >  Aml *aml_create_dword_field(Aml *srcbuf, Aml *index, const char *name);
> > >  Aml *aml_create_qword_field(Aml *srcbuf, Aml *index, const char *name);
> > > -Aml *aml_varpackage(uint32_t num_elements);
> > > +Aml *aml_varpackage(Aml *num_elements);
> > maybe drop it from header and make static so only aml_package() would be
> > left as public API like in spec?
> 
> There are places in the spec that say VarPackage.
> E.g. _CST: Return Value: A variable-length Package.
> 
> We probably want to keep aml_varpackage around for these
> cases.

And thinking more about this, if you want a package with
# of elements that isn't a constant, you want aml_varpackage.
If it's a constant you have the handy aml_package shortcut.

> > 
> > >  Aml *aml_touuid(const char *uuid);
> > >  Aml *aml_unicode(const char *str);
> > >  Aml *aml_refof(Aml *arg);
> > > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> > > index def62b3112..1996768b40 100644
> > > --- a/hw/acpi/aml-build.c
> > > +++ b/hw/acpi/aml-build.c
> > > @@ -1016,9 +1016,19 @@ Aml *aml_buffer(int buffer_size, uint8_t *byte_list)
> > >  }
> > >  
> > >  /* ACPI 1.0b: 16.2.5.4 Type 2 Opcodes Encoding: DefPackage */
> > > -Aml *aml_package(uint8_t num_elements)
> > > +/* Note: The ability to create variable-sized packages was first
> > > + * introduced in ACPI 2.0. ACPI 1.0 only allowed fixed-size packages
> > > + * with up to 255 elements. Windows guests up to win2k8 fail when
> > > + * VarPackageOp is used.
> > > + */
> > > +Aml *aml_package(uint64_t num_elements)
> > >  {
> > > -    Aml *var = aml_bundle(0x12 /* PackageOp */, AML_PACKAGE);
> > > +    Aml *var;
> > > +
> > > +    if (num_elements > 0xFF)
> > > +        return aml_varpackage(aml_int(num_elements));
> > > +
> > > +    var = aml_bundle(0x12 /* PackageOp */, AML_PACKAGE);
> > >      build_append_byte(var->buf, num_elements);
> > >      return var;
> > >  }
> > > @@ -1136,10 +1146,10 @@ Aml *aml_local(int num)
> > >  }
> > >  
> > >  /* ACPI 2.0a: 17.2.2 Data Objects Encoding: DefVarPackage */
> > > -Aml *aml_varpackage(uint32_t num_elements)
> > > +Aml *aml_varpackage(Aml *num_elements)
> > >  {
> > >      Aml *var = aml_bundle(0x13 /* VarPackageOp */, AML_PACKAGE);
> > > -    build_append_int(var->buf, num_elements);
> > > +    aml_append(var, num_elements);
> > >      return var;
> > >  }
> > >  
> > > diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
> > > index 5243918125..f8246fca6f 100644
> > > --- a/hw/acpi/cpu_hotplug.c
> > > +++ b/hw/acpi/cpu_hotplug.c
> > > @@ -309,15 +309,8 @@ void build_legacy_cpu_hotplug_aml(Aml *ctx, MachineState *machine,
> > >      }
> > >      aml_append(sb_scope, method);
> > >  
> > > -    /* build "Name(CPON, Package() { One, One, ..., Zero, Zero, ... })"
> > > -     *
> > > -     * Note: The ability to create variable-sized packages was first
> > > -     * introduced in ACPI 2.0. ACPI 1.0 only allowed fixed-size packages
> > > -     * ith up to 255 elements. Windows guests up to win2k8 fail when
> > > -     * VarPackageOp is used.
> > > -     */
> > > -    pkg = pcms->apic_id_limit <= 255 ? aml_package(pcms->apic_id_limit) :
> > > -                                       aml_varpackage(pcms->apic_id_limit);
> > > +    /* build "Name(CPON, Package() { One, One, ..., Zero, Zero, ... })" */
> > > +    pkg = aml_package(pcms->apic_id_limit);
> > >  
> > >      for (i = 0, apic_idx = 0; i < apic_ids->len; i++) {
> > >          int apic_id = apic_ids->cpus[i].arch_id;
> > > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > > index 6ea47e2588..2adb1de378 100644
> > > --- a/hw/arm/virt-acpi-build.c
> > > +++ b/hw/arm/virt-acpi-build.c
> > > @@ -174,7 +174,7 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
> > >      aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
> > >  
> > >      /* Declare the PCI Routing Table. */
> > > -    Aml *rt_pkg = aml_varpackage(nr_pcie_buses * PCI_NUM_PINS);
> > > +    Aml *rt_pkg = aml_package(nr_pcie_buses * PCI_NUM_PINS);
> > >      for (bus_no = 0; bus_no < nr_pcie_buses; bus_no++) {
> > >          for (i = 0; i < PCI_NUM_PINS; i++) {
> > >              int gsi = (i + bus_no) % PCI_NUM_PINS;
