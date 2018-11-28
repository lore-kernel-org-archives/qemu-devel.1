Received: from eggs.gnu.org ([2001:4830:134:3::10]:48257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gRwjd-0005ru-5q
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 05:06:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gRwjb-0002iu-6g
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 05:06:21 -0500
Date: Wed, 28 Nov 2018 11:05:36 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181128100536.GC5677@caravaggio>
References: <20181126162942.21258-1-sameo@linux.intel.com>
	<20181126162942.21258-5-sameo@linux.intel.com>
	<20181127162551.29608eeb@redhat.com>
	<20181127154218.GA5677@caravaggio>
	<20181127172749.75a036b4@redhat.com>
	<20181127221515-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127221515-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH 4/8] hw: arm: Carry RSDP specific data
 through AcpiRsdpData
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Ben Warren <ben@skyportsystems.com>, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>

Hi Michael,

On Tue, Nov 27, 2018 at 10:26:30PM -0500, Michael S. Tsirkin wrote:
> On Tue, Nov 27, 2018 at 05:27:49PM +0100, Igor Mammedov wrote:
> > On Tue, 27 Nov 2018 16:42:18 +0100
> > Samuel Ortiz <sameo@linux.intel.com> wrote:
> > 
> > > Hi Igor,
> > > 
> > > On Tue, Nov 27, 2018 at 04:25:51PM +0100, Igor Mammedov wrote:
> > > > On Mon, 26 Nov 2018 17:29:37 +0100
> > > > Samuel Ortiz <sameo@linux.intel.com> wrote:
> > > >   
> > > > > That will allow us to generalize the ARM build_rsdp() routine to support
> > > > > both legacy RSDP (The current i386 implementation) and extended RSDP
> > > > > (The ARM implementation).
> > > > > 
> > > > > Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> > > > > ---
> > > > >  include/hw/acpi/acpi-defs.h | 11 +++++++++++
> > > > >  hw/arm/virt-acpi-build.c    | 27 ++++++++++++++++++++++-----
> > > > >  2 files changed, 33 insertions(+), 5 deletions(-)
> > > > > 
> > > > > diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> > > > > index af8e023968..e7fd24c6c5 100644
> > > > > --- a/include/hw/acpi/acpi-defs.h
> > > > > +++ b/include/hw/acpi/acpi-defs.h
> > > > > @@ -53,6 +53,17 @@ struct AcpiRsdpDescriptor {        /* Root System Descriptor Pointer */
> > > > >  } QEMU_PACKED;
> > > > >  typedef struct AcpiRsdpDescriptor AcpiRsdpDescriptor;
> > > > >  
> > > > > +typedef struct AcpiRsdpData {
> > > > > +    uint8_t oem_id[6]; /* OEM identification */
> > > > > +    uint8_t revision;  /* Must be 0 for 1.0, 2 for 2.0 */
> > > > > +
> > > > > +    unsigned *rsdt_tbl_offset;
> > > > > +    unsigned *xsdt_tbl_offset;
> > > > > +} AcpiRsdpData;
> > > > > +  
> > > >   
> > > > > +#define ACPI_RSDP_REV_1 0
> > > > > +#define ACPI_RSDP_REV_2 2  
> > > > it's one time used spec defined values so just use values directly
> > > > in place with a comment, so reader won't have to jump around code
> > > > when comparing to spec.  
> > > It's also used in the ACPI tests fix patch.
> > it's better to use in test it's own version (we just opencode them there)
> > see fadt_fetch_facs_and_dsdt_ptrs()/sanitize_fadt_ptrs()
> > same applies for length.
> > that way if we break it in qemu's code test would catch the thing
> > 
> > > Also the 0 for revision 1 is a little confusing, I feel the above
> > > definition is clearer.
> > that's confusion is in the spec, so we just mimic it, no need to add more on top
> 
> To be more precise, there is a huge number of constants in ACPI
> such that adding defines for them all would be a huge burden,
I find that defining a set of well named constants is a lot less painful
than maintaining code with at least the same amount of hard coded
constants. That's a personal opinion, for sure.

> and will not make it easy to check values against the
> spec at all (case in point ACPI_RSDP_REV_2 is actually wrong,
> 2 is version 3 and up).
I may be misreading the spec, but I understand 0 is for ACPI 1.0 and 2
is for ACPI 2.0+. The latest spec is a little confusing with regard to
this field, but when looking at the 2.0a ACPI spec for RSDP:

"The ACPI version 1.0 revision number of this table is zero. The ACPI 2.0
value for this field is 2."

> Thus the preferred style is to add a comment near the value
> matching spec name verbatim, so one can copy it and
> look it up in the spec. Sometimes one needs to reference
> specific spec version.
> 
> 0 /* Revision: ACPI version 1.0 */
> 
> and
> 
> 1 /* Revision: ACPI 2.0 */
> 
> and
> 
> 2 /* Revision: ACPI 3.0a */
> 
> For style consistency, if the value is used multiple times, we avoid
> duplication by using an inline function and not a macro.
Not entirely sure how this materializes. Do you mean that e.g. if I want
to check for an RSDP revision I'd have to define inline functions of
that kind:

bool is_rsdp_revision_0(uint8_t *rsdp_table);
bool is_rsdp_revision_2(uint8_t *rsdp_table);

or do you have something else in mind?

Cheers,
Samuel.
