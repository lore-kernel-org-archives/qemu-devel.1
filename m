Received: from eggs.gnu.org ([2001:4830:134:3::10]:37282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gSfDc-000331-FS
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:36:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gSfDb-0008Sc-DU
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:36:16 -0500
Date: Fri, 30 Nov 2018 10:35:33 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181130093533.GB4195@caravaggio>
References: <20181129132428.333-1-sameo@linux.intel.com>
	<20181129132428.333-9-sameo@linux.intel.com>
	<20181129150743.rsrrtsplzvzqie7o@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129150743.rsrrtsplzvzqie7o@kamzik.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 8/8] hw: acpi: Remove AcpiRsdpDescriptor
 and fix tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Nov 29, 2018 at 04:07:43PM +0100, Andrew Jones wrote:
> On Thu, Nov 29, 2018 at 02:24:28PM +0100, Samuel Ortiz wrote:
> > The only remaining AcpiRsdpDescriptor users are the ACPI utils for the
> > BIOS table tests.
> > We remove that dependency and can thus remove the structure itself.
> > 
> > Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> > ---
> >  include/hw/acpi/acpi-defs.h | 13 -----------
> >  tests/acpi-utils.h          |  5 +++-
> >  tests/acpi-utils.c          | 46 ++++++++++++++++++++++++++++++-------
> >  tests/bios-tables-test.c    | 27 +++++++++++++++-------
> >  tests/vmgenid-test.c        |  8 ++++---
> >  5 files changed, 66 insertions(+), 33 deletions(-)
> > 
> > diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> > index 8425ecb8c6..5021cb9e79 100644
> > --- a/include/hw/acpi/acpi-defs.h
> > +++ b/include/hw/acpi/acpi-defs.h
> > @@ -40,19 +40,6 @@ enum {
> >      ACPI_FADT_F_LOW_POWER_S0_IDLE_CAPABLE,
> >  };
> >  
> > -struct AcpiRsdpDescriptor {        /* Root System Descriptor Pointer */
> > -    uint64_t signature;              /* ACPI signature, contains "RSD PTR " */
> > -    uint8_t  checksum;               /* To make sum of struct == 0 */
> > -    uint8_t  oem_id [6];             /* OEM identification */
> > -    uint8_t  revision;               /* Must be 0 for 1.0, 2 for 2.0 */
> > -    uint32_t rsdt_physical_address;  /* 32-bit physical address of RSDT */
> > -    uint32_t length;                 /* XSDT Length in bytes including hdr */
> > -    uint64_t xsdt_physical_address;  /* 64-bit physical address of XSDT */
> > -    uint8_t  extended_checksum;      /* Checksum of entire table */
> > -    uint8_t  reserved [3];           /* Reserved field must be 0 */
> > -} QEMU_PACKED;
> > -typedef struct AcpiRsdpDescriptor AcpiRsdpDescriptor;
> > -
> >  typedef struct AcpiRsdpData {
> >      uint8_t oem_id[6]; /* OEM identification */
> >      uint8_t revision;  /* Must be 0 for 1.0, 2 for 2.0 */
> > diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
> > index ac52abd0dd..c26c8976a6 100644
> > --- a/tests/acpi-utils.h
> > +++ b/tests/acpi-utils.h
> > @@ -82,6 +82,9 @@ typedef struct {
> >  
> >  uint8_t acpi_calc_checksum(const uint8_t *data, int len);
> >  uint32_t acpi_find_rsdp_address(void);
> > -void acpi_parse_rsdp_table(uint32_t addr, AcpiRsdpDescriptor *rsdp_table);
> > +uint32_t acpi_get_rsdt_address(uint8_t *rsdp_table);
> > +uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table);
> > +void acpi_parse_rsdp_table(uint32_t addr, uint8_t *rsdp_table,
> > +                           uint8_t revision);
> >  
> >  #endif  /* TEST_ACPI_UTILS_H */
> > diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
> > index 41dc1ea9b4..b1113bda8b 100644
> > --- a/tests/acpi-utils.c
> > +++ b/tests/acpi-utils.c
> > @@ -52,14 +52,44 @@ uint32_t acpi_find_rsdp_address(void)
> >      return off;
> >  }
> >  
> > -void acpi_parse_rsdp_table(uint32_t addr, AcpiRsdpDescriptor *rsdp_table)
> > +uint32_t acpi_get_rsdt_address(uint8_t *rsdp_table)
> >  {
> > -    ACPI_READ_FIELD(rsdp_table->signature, addr);
> > -    ACPI_ASSERT_CMP64(rsdp_table->signature, "RSD PTR ");
> > +    uint32_t rsdt_physical_address;
> > +    uint8_t revision = rsdp_table[15 /* Revision offset */];
> >  
> > -    ACPI_READ_FIELD(rsdp_table->checksum, addr);
> > -    ACPI_READ_ARRAY(rsdp_table->oem_id, addr);
> > -    ACPI_READ_FIELD(rsdp_table->revision, addr);
> > -    ACPI_READ_FIELD(rsdp_table->rsdt_physical_address, addr);
> > -    ACPI_READ_FIELD(rsdp_table->length, addr);
> > +    if (revision != 0) { /* ACPI 1.0 RSDP */
> > +        return 0;
> > +    }
> 
> So now we assume a zero offset can't be valid, which means we don't need
> pointers in the struct. Your answer that pointers are used for consistency
> is good enough for me though.
> 
> > +
> > +    memcpy(&rsdt_physical_address, &rsdp_table[16 /* RsdtAddress offset */], 4);
> > +    return le32_to_cpu(rsdt_physical_address);
> > +}
> > +
> > +uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table)
> > +{
> > +    uint64_t xsdt_physical_address;
> > +    uint8_t revision = rsdp_table[15 /* Revision offset */];
> > +
> > +    if (revision != 2) { /* ACPI 2.0+ RSDP */
> 
> revision < 2
> 
> > +        return 0;
> > +    }
> > +
> > +    memcpy(&xsdt_physical_address, &rsdp_table[24 /* XsdtAddress offset */], 8);
> > +    return le64_to_cpu(xsdt_physical_address);
> > +}
> > +
> > +void acpi_parse_rsdp_table(uint32_t addr, uint8_t *rsdp_table, uint8_t revision)
> > +{
> > +    switch (revision) {
> > +    case 0: /* ACPI 1.0 RSDP */
> > +        memread(addr, rsdp_table, 20);
> > +        break;
> > +    case 2: /* ACPI 2.0+ RSDP */
> > +        memread(addr, rsdp_table, 36);
> > +        break;
> > +    default:
> > +        g_assert_not_reached();
> > +    }
> > +
> > +    ACPI_ASSERT_CMP64(*((uint64_t *)(rsdp_table)), "RSD PTR ");
> >  }
> > diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> > index d661d9be62..84f1500920 100644
> > --- a/tests/bios-tables-test.c
> > +++ b/tests/bios-tables-test.c
> > @@ -27,7 +27,8 @@ typedef struct {
> >      const char *machine;
> >      const char *variant;
> >      uint32_t rsdp_addr;
> > -    AcpiRsdpDescriptor rsdp_table;
> > +    uint8_t rsdp_table[36 /* ACPI 2.0+ RSDP size */];
> > +    uint32_t rsdt_physical_address;
> 
> I don't see rsdt_physical_address getting used anyway.
Good catch, thanks. Removed in v3.

Cheers,
Samuel.
