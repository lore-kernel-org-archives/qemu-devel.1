Received: from eggs.gnu.org ([2001:4830:134:3::10]:37670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eHBSI-0001r3-0F
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 11:31:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eHBSD-000544-Si
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 11:31:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eHBSD-00053T-Lf
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 11:31:21 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BF661FC7BC
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 16:31:20 +0000 (UTC)
Date: Tue, 21 Nov 2017 18:31:19 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171121182432-mutt-send-email-mst@kernel.org>
References: <1510834622-28800-1-git-send-email-thuth@redhat.com>
	<20171120175522.76bf71c3@redhat.com>
	<20171120223048-mutt-send-email-mst@kernel.org>
	<20171121142639.3e6d2e79@redhat.com>
	<20171121164254-mutt-send-email-mst@kernel.org>
	<20171121165809.1ec4362a@redhat.com>
	<20171121180202-mutt-send-email-mst@kernel.org>
	<20171121172236.618c8e08@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171121172236.618c8e08@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] tests/bios-tables-test: Fix endianess
 problems when passing data to iasl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On Tue, Nov 21, 2017 at 05:22:36PM +0100, Igor Mammedov wrote:
> > > > > > > probably it's been discussed but, why not do
> > > > > > >  leXX_to_cpu()
> > > > > > > here, instead of making each place that access read field
> > > > > > > to do leXX_to_cpu() manually.?
> > > > > > > 
> > > > > > > Beside of keeping access to structure in natural host order,
> > > > > > > it should also be less error-prone as field users don't
> > > > > > > have to worry about endianness.      
> > > > > > 
> > > > > > Yes, I suggested that.
> > > > > > The issue is that we don't byte-swap all of the tables
> > > > > > (we can't, that would require a full ACPI parser).
> > > > > > So when byte-swapping we end up with a mixed host/LE
> > > > > > structures.    
> > > ...  
> > > > > What tables/use-cases do you have in mind where we'd need full
> > > > > ACPI parser /whatever it is/?    
> > > > 
> > > > We dump ACPI tables for parsing by iasl.  
> > > I don't really see a problem here (i.e. how dumping blobs for
> > > iasl would require byte-swap all of the tables).  
> > 
> > It's not all the tables. We would need to track what is and
> > what isn't swapped.
> Why we need track swapping at all?
> Why not just convert everything to host order and work with that
> in C code, so we won't have to deal with mixed endianness anywhere
> in code beside of accessors wrappers? 

It's a tooling issue really.

Consider any structure, e.g. AcpiRsdtDescriptorRev1.  We want its fields
to have specific endian-ness so we can use static checking for that down
the line.

So it must be LE since we use it to format guest tables.

Therefore this change:
-    uint32_t addr = data->rsdp_table.rsdt_physical_address;
+    uint32_t addr = le32_to_cpu(data->rsdp_table.rsdt_physical_address);

is really a requirement, otherwise we end up with converting
field format in-place and static checkers can't support that
right now.


>  
> > > Where bios-tables-test.c is concerned we should just read
> > > a blob from qemu (get its location/len/name) and dump it to
> > > disk without changing anything in it.  
> > 
> > Exactly.
> > 
> > > > >     
> > > > > > Keeping it all LE seems cleaner.
> > > > > > 
> > > > > >     
