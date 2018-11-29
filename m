Received: from eggs.gnu.org ([2001:4830:134:3::10]:58298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gSQQs-0000hU-Qx
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:49:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gSQQm-0006sR-0i
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:48:56 -0500
Date: Thu, 29 Nov 2018 18:48:01 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181129174801.GA4195@caravaggio>
References: <20181129132428.333-1-sameo@linux.intel.com>
	<20181129132428.333-7-sameo@linux.intel.com>
	<20181129144243.so22d2igis7a24xp@kamzik.brq.redhat.com>
	<20181129145942.GB4691@caravaggio>
	<20181129150947.hqsnpf653vs53uci@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129150947.hqsnpf653vs53uci@kamzik.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/8] hw: arm: Support both legacy and
 current RSDP build
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

On Thu, Nov 29, 2018 at 04:09:47PM +0100, Andrew Jones wrote:
> On Thu, Nov 29, 2018 at 03:59:42PM +0100, Samuel Ortiz wrote:
> > On Thu, Nov 29, 2018 at 03:42:43PM +0100, Andrew Jones wrote:
> > > On Thu, Nov 29, 2018 at 02:24:26PM +0100, Samuel Ortiz wrote:
> > > > We add the ability to build legacy or current RSDP tables, based on the
> > > > AcpiRsdpData revision field passed to build_rsdp().
> > > > Although arm/virt only uses RSDP v2, adding that capability to
> > > > build_rsdp will allow us to share the RSDP build code between ARM and x86.
> > > > 
> > > > Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> > > > ---
> > > >  hw/arm/virt-acpi-build.c | 37 ++++++++++++++++++++++++++-----------
> > > >  1 file changed, 26 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > > > index 4782aea4fe..e1338b6f5a 100644
> > > > --- a/hw/arm/virt-acpi-build.c
> > > > +++ b/hw/arm/virt-acpi-build.c
> > > > @@ -378,23 +378,38 @@ build_rsdp(GArray *tbl, BIOSLinker *linker, AcpiRsdpData *rsdp_data)
> > > >      g_array_append_vals(tbl, rsdp_data->oem_id, 6); /* OEMID */
> > > >      build_append_int_noprefix(tbl, rsdp_data->revision, 1); /* Revision */
> > > >      build_append_int_noprefix(tbl, 0, 4); /* RsdtAddress */
> > > > -    build_append_int_noprefix(tbl, 36, 4); /* Length */
> > > > -
> > > > -    /* XSDT address to be filled by guest linker */
> > > > -    build_append_int_noprefix(tbl, 0, 8); /* XsdtAddress */
> > > > -    bios_linker_loader_add_pointer(linker, ACPI_BUILD_RSDP_FILE,
> > > > -                                   24, 8,
> > > > -                                   ACPI_BUILD_TABLE_FILE,
> > > > -                                   *rsdp_data->xsdt_tbl_offset);
> > > > -
> > > > -    build_append_int_noprefix(tbl, 0, 1); /* Extended Checksum */
> > > > -    build_append_int_noprefix(tbl, 0, 3); /* Reserved */
> > > > +    if (rsdp_data->rsdt_tbl_offset) {
> > > 
> > > I see why a pointer was used now. Using a pointer ensures a zero
> > > offset won't fail this test. However the test could be replaced with
> > > rsdp_data->revision == 0.
> > > 
> > > > +        /* RSDT address to be filled by guest linker */
> > > > +        bios_linker_loader_add_pointer(linker,
> > > > +                                       ACPI_BUILD_RSDP_FILE, 16, 4,
> > > > +                                       ACPI_BUILD_TABLE_FILE,
> > > > +                                       *rsdp_data->rsdt_tbl_offset);
> > > > +    }
> > > >  
> > > >      /* Checksum to be filled by guest linker */
> > > >      bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
> > > >                                      0, 20, /* ACPI rev 1.0 RSDP size */
> > > >                                      8);
> > > >  
> > > > +    if (rsdp_data->revision == 0) {
> > > > +        /* ACPI 1.0 RSDP, we're done */
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    /* The RSDP revision is 2 and later, we must have an XSDT pointer */
> > > > +    g_assert(rsdp_data->xsdt_tbl_offset != NULL);
> > > 
> > > So here's the justification for the pointers. We sanity check the callers.
> > We could sanity check the callers without pointers as well, I don't
> > think there's a strong advantage for pointers here, except consistence.
> > 
> > 
> > > We're missing the (rsdp_data->revision == 0 && rsdp_data->rsdt_tbl_offset)
> > > sanity check though.
> > I think there's nothing preventing a caller to include both rsdt and
> > xsdt if it wants to be able to run on both < 2.0 and 2.0+ platforms with
> > the same table. So if rsdt is set we should add it, regardless of the revision.
> 
> True, but if revision is zero, then we *must* have it. Otherwise we'll
> silently return from this function with neither an rsdt nor xsdt linked.
Correct, thanks. With v3 I'm adding a small piece of code at the start
of build_rsdp() that checks for valid rsdt and xsdt pointers (for rev 0
and 2, respectively).

Cheers,
Samuel.
