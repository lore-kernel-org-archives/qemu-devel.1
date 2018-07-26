Received: from eggs.gnu.org ([2001:4830:134:3::10]:53728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fikIp-0005Dc-G4
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 13:43:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fikIl-0002d1-J6
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 13:43:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43168 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fikIl-0002aU-E1
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 13:43:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB0AC4067F19
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 17:43:46 +0000 (UTC)
Date: Thu, 26 Jul 2018 20:43:44 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180726203955-mutt-send-email-mst@kernel.org>
References: <20180710000024.542612-1-mst@redhat.com>
	<20180710000024.542612-7-mst@redhat.com>
	<20180725144205.67dc24c0@redhat.com>
	<20180725155031-mutt-send-email-mst@kernel.org>
	<20180725163928.418a485c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725163928.418a485c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH hack dontapply v2 6/7] acpi: aml generation
 for _CST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, pbonzini@redhat.com

On Wed, Jul 25, 2018 at 04:39:28PM +0200, Igor Mammedov wrote:
> > > > +void cst_register(FWCfgState *s, uint16_t ioport)
> > > > +{
> > > > +    cst_ssdt_setup();
> > > > +
> > > > +    /* Allocate guest scratch memory for the table */
> > > > +    cst_scratch = g_array_new(false, true, 1);
> > > > +    acpi_data_push(cst_scratch, 4096);
> > > > +    fw_cfg_add_file(s, ACPI_SCRATCH_BUFFER_NAME, cst_scratch->data,
> > > > +                    cst_scratch->len);
> > > > +
> > > > +    /* setup io to trigger updates */
> > > > +    memory_region_init_io(&cst_mr, NULL, &cst_ops, NULL, "cst-update-request", 4);
> > > > +    memory_region_add_subregion(get_system_io(), ioport, &cst_mr);  
> > > it eats yet another IO port and a 4K page just for CST.  
> > 
> > 4K is a scratch pad we can reuse for any dynamic table.
> > 
> > Address is in fact 4K aligned - what if we reuse low bits in the io port
> > for signal type?  This way we won't burn more ports for the next dynamic
> > table.
> yep, and we already use it for nvdimm's NFIT table.
> Earlier I've commented on HMAT series that tried to allocate another
> IO&4K page that we should generalize and reuse NFIT implementation.

That's a good point, I forgot about NFIT.

I agree there's no good reason to burn up more IO ports and memory,
I'll look into reusing NFIT buffer and ports.

-- 
MST
