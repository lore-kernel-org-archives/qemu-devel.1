Received: from eggs.gnu.org ([2001:4830:134:3::10]:33407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gPqgN-0005Lr-Gj
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 10:14:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gPqgL-00039M-CY
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 10:14:19 -0500
Date: Thu, 22 Nov 2018 16:13:59 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181122161359.246b5978@redhat.com>
In-Reply-To: <20181121144237.GF4426@caravaggio>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-2-sameo@linux.intel.com>
	<20181109152316.43b79217@redhat.com>
	<20181121144237.GF4426@caravaggio>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 01/24] hw: i386: Decouple the ACPI build
 from the PC machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael
	S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>

On Wed, 21 Nov 2018 15:42:37 +0100
Samuel Ortiz <sameo@linux.intel.com> wrote:

> Hi Igor,
> 
> On Fri, Nov 09, 2018 at 03:23:16PM +0100, Igor Mammedov wrote:
> > On Mon,  5 Nov 2018 02:40:24 +0100
> > Samuel Ortiz <sameo@linux.intel.com> wrote:
> >   
> > > ACPI tables are platform and machine type and even architecture
> > > agnostic, and as such we want to provide an internal ACPI API that
> > > only depends on platform agnostic information.
> > > 
> > > For the x86 architecture, in order to build ACPI tables independently
> > > from the PC or Q35 machine types, we are moving a few MachineState
> > > structure fields into a machine type agnostic structure called
> > > AcpiConfiguration. The structure fields we move are:  
> > 
> > It's not obvious why new structure is needed, especially at
> > the beginning of series. We probably should place this patch
> > much later in the series (if we need it at all) and try
> > generalize a much as possible without using it.  
> Patches order set aside, this new structure is needed to make the
> existing API not completely bound to the pc machine type anymore and
> "Decouple the ACPI build from the PC machine type".
> 
> It was either creating a structure to build ACPI tables in a machine
> type independent fashion, or pass custom structures (or potentially long
> list of arguments) to the existing APIs. See below.
> 
> 
> > And try to come up with an API that doesn't need centralized collection
> > of data somehow related to ACPI (most of the fields here are not generic
> > and applicable to a specific board/target).
> > 
> > For generic API, I'd prefer a separate building blocks
> > like build_fadt()/... that take as an input only parameters
> > necessary to compose a table/aml part with occasional board
> > interface hooks instead of all encompassing AcpiConfiguration
> > and board specific 'acpi_build' that would use them when/if needed.  
> Let's take build_madt as an example. With my patch we define:
> 
> void build_madt(GArray *table_data, BIOSLinker *linker,
>                 MachineState *ms, AcpiConfiguration *conf);
> 
> And you're suggesting we'd define:
> 
> void build_madt(GArray *table_data, BIOSLinker *linker,
>                 MachineState *ms, HotplugHandler *acpi_dev,
>                 bool apic_xrupt_override);
> 
> instead. Is that correct?
in general, yes
and let acpi_build() to fish out that info from board somehow.

In case of build_madt(), I doubt we can generalize it across targets.
What we can do with it though, is to generalize entries that are
placed into it. i.e. create helpers to create them instead of
open-codding them like now, something like:

void build_append_madt_apic(*table, uid, apic_id, flags);
void build_append_madt_x2apic(*table, uid, apic_id, flags);
void build_append_madt_ioapic(*table, io_apic_id, io_apic_addr, interrupt);
...
converting to build_append_int_noprefix() API ioapic entry example:

diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index af8e023..5911b94 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -242,16 +242,6 @@ struct AcpiMadtProcessorApic {
 } QEMU_PACKED;
 typedef struct AcpiMadtProcessorApic AcpiMadtProcessorApic;
 
-struct AcpiMadtIoApic {
-    ACPI_SUB_HEADER_DEF
-    uint8_t  io_apic_id;             /* I/O APIC ID */
-    uint8_t  reserved;               /* Reserved - must be zero */
-    uint32_t address;                /* APIC physical address */
-    uint32_t interrupt;              /* Global system interrupt where INTI
-                                 * lines start */
-} QEMU_PACKED;
-typedef struct AcpiMadtIoApic AcpiMadtIoApic;
-
 struct AcpiMadtIntsrcovr {
     ACPI_SUB_HEADER_DEF
     uint8_t  bus;
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 6c36903..b28c2ce 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -409,6 +409,9 @@ build_append_gas_from_struct(GArray *table, const struct AcpiGenericAddress *s)
                      s->access_width, s->address);
 }
 
+void build_append_madt_ioapic(GArray *tbl, uint8_t id, uint32_t addr,
+                              uint32_t intr);
+
 void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
                        uint64_t len, int node, MemoryAffinityFlags flags);
 
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 1e43cd7..f0445df 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1655,6 +1655,23 @@ void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
 }
 
 /*
+ * ACPI 1.0b: 5.2.8.2 IO APIC
+   <--- earliest spec where structure was introduced, that's the way
+        we avoid writing extra docs for things that are described in spec -->
+ */
+void build_append_madt_ioapic(GArray *tbl, uint8_t id, uint32_t addr,
+                              uint32_t intr)
+{
+    // comments are verbatim copy of the field name from spec
+    build_append_int_noprefix(tbl, 1 /* I/O APIC structure */, 1); /* Type */
+    build_append_int_noprefix(tbl, 12, 1);    /* Length */
+    build_append_int_noprefix(tbl, id, 1);    /* I/O APIC ID */
+    build_append_int_noprefix(tbl, 0, 1);     /* Reserved */
+    build_append_int_noprefix(tbl, addr, 4);  /* I/O APIC Address */
+    build_append_int_noprefix(tbl, intr, 4); /* Global System Interrupt Base */
+}
+
+/*
  * ACPI spec 5.2.17 System Locality Distance Information Table
  * (Revision 2.0 or later)
  */
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 131c565..2f154c9 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -348,7 +348,6 @@ build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms)
     bool x2apic_mode = false;
 
     AcpiMultipleApicTable *madt;
-    AcpiMadtIoApic *io_apic;
     AcpiMadtIntsrcovr *intsrcovr;
     int i;
 
@@ -363,12 +362,8 @@ build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms)
         }
     }
 
-    io_apic = acpi_data_push(table_data, sizeof *io_apic);
-    io_apic->type = ACPI_APIC_IO;
-    io_apic->length = sizeof(*io_apic);
-    io_apic->io_apic_id = ACPI_BUILD_IOAPIC_ID;
-    io_apic->address = cpu_to_le32(IO_APIC_DEFAULT_ADDRESS);
-    io_apic->interrupt = cpu_to_le32(0);
+    build_append_madt_ioapic(table_data,
+        ACPI_BUILD_IOAPIC_ID, IO_APIC_DEFAULT_ADDRESS, 0);
 
     if (pcms->apic_xrupt_override) {
         intsrcovr = acpi_data_push(table_data, sizeof *intsrcovr);


....

Then build_madt() is reduced to quite readable several lines only
and if it makes sense having a custom board specific one, it is not
an issue as there aren't much duplication.
In case of i386/virt, one probably can throw away all legacy
stuff we have over there and have custom build_madt_virt().

> Pros for the latter is the fact that, as you said, we would not need to
> define a centralized structure holding all possibly needed ACPI related
> fields.
>
> Pros for the former is about defining a pointer to all needed ACPI
> fields once and for all and hiding the details of the API in the AML
> building implementation.

it's hard to create an maintain centralized structure for generic use,
for example this series ended up with a bunch of x86 specific fields there
and misplaced other fields that do not belong acpi but are used by it somehow.
If one would thing about possible future refactorings, then it gets
more difficult as changes to centralized structure affect whole codebase
instead of being localized.

I suggest to keep board and acpi code as separate as possible
and acpi_setup/acpi_build() being a glue that gets and feeds
board/target specific data to an ACPI primitives/table builders.
That way we would have a machine and in-depended acpi code,
and custom glue that ties all together.

One would have to give up on generic acpi_build and AcpiBuilder
callbacks, but acpi_build() is not a lot of code so it is not
an issue to have several different ones (we can generalize parts
of it is necessary).
Essentially this series would change from
----------
pc.c:
AcpiBuilder->build_a = pc_build_a;
AcpiBuilder->build_b = pc_build_b;
...

virt_pc.c:
AcpiBuilder->build_a = virt_pc_build_a;
AcpiBuilder->build_b = virt_pc_build_b;
...

acpi...c:
pc_acpi_build()
   AcpiBuilder->build_a()
   AcpiBuilder->build_b()
   // some legacy hacks here
   ...
virt_pc...c:
virt_acpi_build()
   AcpiBuilder->build_a()
   AcpiBuilder->build_b()
   ...

... same for arm since set of tables is different and board/target depended ...
---------------
acpi...c:
pc_acpi_build()
  pc_build_a()
  pc_build_b()
  ...

virt_pc_..c:
virt_acpi_build()
  virt_pc_build_a()
  virt_pc_build_b()
  ...
...

i.e. about the same  as the former but without indirection and
without headache how to generalize AcpiBuilder->build_foo()
interface to work for every target/board.

Once we have hw/i386/acpi_reduced.c, working and used by i386/virt
it would be easier to assess if we can generalize virt_pc_acpi_build()
to be usable by arm, but right now it looks like premature action.

> > We probably should split series into several smaller
> > (if possible independent) ones, so people won't be scared of
> > its sheer size and run away from reviewing it.  
> I will try to split it in smaller chunks if that helps.
> 
> Cheers,
> Samuel.
