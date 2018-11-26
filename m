Received: from eggs.gnu.org ([2001:4830:134:3::10]:58158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gRE1p-0002lB-NG
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 05:22:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gRE1l-0007N9-PU
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 05:22:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gRE1l-0007Lx-J1
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 05:22:05 -0500
Date: Mon, 26 Nov 2018 11:21:57 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181126112157.4ec7e06e@redhat.com>
In-Reply-To: <20181123110106-mutt-send-email-mst@kernel.org>
References: <1542882574-109418-1-git-send-email-imammedo@redhat.com>
	<1542882574-109418-2-git-send-email-imammedo@redhat.com>
	<20181123110106-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] pc: acpi: use correct RSDT length for
 checksum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, sameo@linux.intel.com, drjones@redhat.com, peter.maydell@linaro.org

On Fri, 23 Nov 2018 11:10:01 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Nov 22, 2018 at 11:29:33AM +0100, Igor Mammedov wrote:
> > AcpiRsdpDescriptor describes revision 2 RSDP table so using sizeof(*rsdp)
> > for checksum calculation isn't correct since we are adding extra 16 bytes.
> > But acpi_data_push() zeroes out table, so just by luck we are summing up
> > exta zeros which still yelds correct checksum.
> > 
> > Fix it up by explicitly stating table size instead of using
> > pointer arithmetics on stucture.
> > 
> > PS:
> > Extra 16 bytes are still wasted, but droping them will break migration
> > for machines older than 2.3 due to size mismatch, for 2.3 and older it's
> > not an issue since they are using resizable memory regions (a1666142d)
> > for ACPI blobs. So keep wasting memory to avoid breaking old machines.  
> 
> I'd like this explanation in code comments please.
sure, I'll move it there

> > Fixes: 72c194f7e (i386: ACPI table generation code from seabios)
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > there is no changes to the current RSDP content caused by this patch
> > ---
> >  hw/i386/acpi-build.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 236a20e..131c565 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -2567,7 +2567,7 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
> >  
> >      /* Checksum to be filled by Guest linker */
> >      bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
> > -        (char *)rsdp - rsdp_table->data, sizeof *rsdp,
> > +        (char *)rsdp - rsdp_table->data, 20 /* ACPI rev 1.0 RSDP size */,
> >          (char *)&rsdp->checksum - rsdp_table->data);
> >  
> >      return rsdp_table;  
> 
> I dislike hard-coded size math like this.
I thought we had a consensus on this point. i.e.
replace all packed structures with build_append_int_noprefix() API
and use spec defined values directly (with comments), so whenever
we compare spec definition with qemu code it would be 1:1 match.

> How about a sub-structure for RSDPv1?
Structure won't be used for long, this patch fixes immediate error
and Samuel is preparing series that's generalizing build_rsdp() switching
to build_append_int_noprefix() API and dropping no longer used structure
so it couldn't be misused.

> > -- 
> > 2.7.4  
