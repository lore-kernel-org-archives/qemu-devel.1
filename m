Received: from eggs.gnu.org ([2001:4830:134:3::10]:45864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eHBsN-0000LS-8q
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 11:58:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eHBsI-0002bo-AQ
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 11:58:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:6935)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eHBsI-0002bX-1A
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 11:58:18 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DEE1F37E6E
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 16:58:16 +0000 (UTC)
Date: Tue, 21 Nov 2017 17:58:12 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171121175812.6f922e2e@redhat.com>
In-Reply-To: <20171121182432-mutt-send-email-mst@kernel.org>
References: <1510834622-28800-1-git-send-email-thuth@redhat.com>
	<20171120175522.76bf71c3@redhat.com>
	<20171120223048-mutt-send-email-mst@kernel.org>
	<20171121142639.3e6d2e79@redhat.com>
	<20171121164254-mutt-send-email-mst@kernel.org>
	<20171121165809.1ec4362a@redhat.com>
	<20171121180202-mutt-send-email-mst@kernel.org>
	<20171121172236.618c8e08@redhat.com>
	<20171121182432-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On Tue, 21 Nov 2017 18:31:19 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Nov 21, 2017 at 05:22:36PM +0100, Igor Mammedov wrote:
> > > > > > > > probably it's been discussed but, why not do
> > > > > > > >  leXX_to_cpu()
> > > > > > > > here, instead of making each place that access read field
> > > > > > > > to do leXX_to_cpu() manually.?
> > > > > > > > 
> > > > > > > > Beside of keeping access to structure in natural host order,
> > > > > > > > it should also be less error-prone as field users don't
> > > > > > > > have to worry about endianness.        
> > > > > > > 
> > > > > > > Yes, I suggested that.
> > > > > > > The issue is that we don't byte-swap all of the tables
> > > > > > > (we can't, that would require a full ACPI parser).
> > > > > > > So when byte-swapping we end up with a mixed host/LE
> > > > > > > structures.      
> > > > ...    
> > > > > > What tables/use-cases do you have in mind where we'd need full
> > > > > > ACPI parser /whatever it is/?      
> > > > > 
> > > > > We dump ACPI tables for parsing by iasl.    
> > > > I don't really see a problem here (i.e. how dumping blobs for
> > > > iasl would require byte-swap all of the tables).    
> > > 
> > > It's not all the tables. We would need to track what is and
> > > what isn't swapped.  
> > Why we need track swapping at all?
> > Why not just convert everything to host order and work with that
> > in C code, so we won't have to deal with mixed endianness anywhere
> > in code beside of accessors wrappers?   
> 
> It's a tooling issue really.
> 
> Consider any structure, e.g. AcpiRsdtDescriptorRev1.  We want its fields
> to have specific endian-ness so we can use static checking for that down
> the line.
> 
> So it must be LE since we use it to format guest tables.
> 
> Therefore this change:
> -    uint32_t addr = data->rsdp_table.rsdt_physical_address;
> +    uint32_t addr = le32_to_cpu(data->rsdp_table.rsdt_physical_address);
> 
> is really a requirement, otherwise we end up with converting
> field format in-place and static checkers can't support that
> right now.

I didn't really used static checker for this purpose but in my humble
experience of writing portable cross platform code, mixed endianness
always was a source of bugs and reviewing corresponding code is much
harder and a way to reduce/simplify code was isolate byte-swapping to
accessors while the the rest of the code works with native encoding.

it seems a bit wrong to make code twisted (when we don't have) for
the sake of some tooling to work.

anyways, if you prefer having mixed endianness here, I won't mind much,
as impact of test case is much smaller so we'll see down the road
if it became any better. (as far as we continue going in direction
of using host byteorder within main qemu acpi code, which we were
doing by gradually converting acpi structures to build_append_foo API)

> 
> >    
> > > > Where bios-tables-test.c is concerned we should just read
> > > > a blob from qemu (get its location/len/name) and dump it to
> > > > disk without changing anything in it.    
> > > 
> > > Exactly.
> > >   
> > > > > >       
> > > > > > > Keeping it all LE seems cleaner.
> > > > > > > 
> > > > > > >       
