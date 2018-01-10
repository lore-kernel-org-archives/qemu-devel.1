Received: from eggs.gnu.org ([2001:4830:134:3::10]:38813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eZElk-0001F9-GY
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 06:42:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eZEle-0003md-Ka
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 06:42:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eZEle-0003kY-BJ
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 06:42:02 -0500
Date: Wed, 10 Jan 2018 12:41:52 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180110124152.10896011@igors-macbook-pro.local>
In-Reply-To: <20180110132751-mutt-send-email-mst@kernel.org>
References: <1515506288-32291-1-git-send-email-mst@redhat.com>
	<20180110122535.3cc0d223@igors-macbook-pro.local>
	<20180110132751-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] acpi: switch to a dummy SSDT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, stefanb@linux.vnet.ibm.com

On Wed, 10 Jan 2018 13:29:09 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Jan 10, 2018 at 12:25:34PM +0100, Igor Mammedov wrote:
> > On Tue, 9 Jan 2018 15:58:11 +0200
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > We prefer not changing table sizes depending on parameters,
> > > that's why we create a dummy table rather than just drop
> > > the MCFG table.
> > > 
> > > However, a table named "QEMU" could be put to a better
> > > use than just a stub, e.g. we could use it to pass
> > > some QEMU specific info to guests.
> > > 
> > > Replace with an SSDT and pad with the Nop opcode
> > > to preserve the length.
> > Not sure it's useful, do you have patches on top of that, which will use this?
> 
> Yes but not me - Stefan (Cc'd) wants to add a custom table.
Re-purposing dummy table that might become not dummy doesn't look like good approach.
What if later the guest enables MCFG and reboots, DUMMY SSDT would be replaced by MCFG? 

It'd be cleaner if Stefan would just use his own dedicated SSDT.

> > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  hw/i386/acpi-build.c | 17 ++++++++++++-----
> > >  1 file changed, 12 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > index 73519ab..d0afb31e 100644
> > > --- a/hw/i386/acpi-build.c
> > > +++ b/hw/i386/acpi-build.c
> > > @@ -2419,6 +2419,8 @@ build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
> > >  {
> > >      AcpiTableMcfg *mcfg;
> > >      const char *sig;
> > > +    const char *oem;
> > > +    const char *oem_id;
> > >      int len = sizeof(*mcfg) + 1 * sizeof(mcfg->allocation[0]);
> > >  
> > >      mcfg = acpi_data_push(table_data, len);
> > > @@ -2431,16 +2433,21 @@ build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
> > >      /* MCFG is used for ECAM which can be enabled or disabled by guest.
> > >       * To avoid table size changes (which create migration issues),
> > >       * always create the table even if there are no allocations,
> > > -     * but set the signature to a reserved value in this case.
> > > -     * ACPI spec requires OSPMs to ignore such tables.
> > > +     * but fill it with Noop values.
> > > +     * OSPMs ignore such tables.
> > >       */
> > >      if (info->mcfg_base == PCIE_BASE_ADDR_UNMAPPED) {
> > > -        /* Reserved signature: ignored by OSPM */
> > > -        sig = "QEMU";
> > > +        sig = "SSDT";
> > > +        oem = "QEMU ";
> > > +        oem_id = "NOOP";
> > > +        /* 0xa3 - NoopOp */
> > > +        memset(&mcfg->reserved, 0xa3, len - offsetof(AcpiTableMcfg, reserved));
> > >      } else {
> > >          sig = "MCFG";
> > > +        oem = NULL;
> > > +        oem_id = NULL;
> > >      }
> > > -    build_header(linker, table_data, (void *)mcfg, sig, len, 1, NULL, NULL);
> > > +    build_header(linker, table_data, (void *)mcfg, sig, len, 1, oem, oem_id);
> > >  }
> > >  
> > >  /*
