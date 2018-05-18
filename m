Received: from eggs.gnu.org ([2001:4830:134:3::10]:33700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fJl6U-0002Ks-F1
	for qemu-devel@nongnu.org; Fri, 18 May 2018 15:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fJl6R-000870-C8
	for qemu-devel@nongnu.org; Fri, 18 May 2018 15:31:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:56196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ross.zwisler@linux.intel.com>)
	id 1fJl6R-00086G-2a
	for qemu-devel@nongnu.org; Fri, 18 May 2018 15:31:47 -0400
Date: Fri, 18 May 2018 13:31:45 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Message-ID: <20180518193145.GA29547@linux.intel.com>
References: <20180517050024.20101-1-ross.zwisler@linux.intel.com>
	<20180517050024.20101-4-ross.zwisler@linux.intel.com>
	<AT5PR8401MB11697DD6A19AA3F499ACDDBAAB910@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
	<20180518152306.GA3413@linux.intel.com>
	<AT5PR8401MB11694A7F7825A488105AEFADAB900@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AT5PR8401MB11694A7F7825A488105AEFADAB900@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
Subject: Re: [Qemu-devel] [qemu PATCH v2 3/4] nvdimm,
 acpi: support NFIT platform capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
Cc: 'Ross Zwisler' <ross.zwisler@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, May 18, 2018 at 04:37:10PM +0000, Elliott, Robert (Persistent Memory) wrote:
> 
> 
> ...
> > Would it help to show them in hex?
> > 
> >   As of ACPI 6.2 Errata A, the following values are valid for the bottom
> >   two bits:
> > 
> >   0x2 - Memory Controller Flush to NVDIMM Durability on Power Loss Capable.
> >   0x3 - CPU Cache Flush to NVDIMM Durability on Power Loss Capable.
> 
> Yes, that helps (unless the parser for that command-line does not 
> accept hex values).
> 
> It would also help to make the text be:
> 	"CPU Cache and Memory Controller Flush"

Yea, let me check on that.  I'll update the wording regardless to try and make
it more clear.

> ...
> > > So, there should be a way to specify a highest_cap value to convey that
> > > some of the upper capabilities bits are valid and contain 0.
> > 
> > Right, I'll make this dynamic based on the capabilities value passed in by
> > the user.  That's a much better solution, thanks.  This should cover all the
> > same cases as you have outlined above, without burdening the user with yet
> > another input value.
> 
> Automatically determining the highest bit that the user wants to set to 1
> should be easy, and will probably be the most common case.
> 
> It's harder to let the user set some upper bits to 0 but also have them
> within the highest_cap range.  Since this will be less common, the syntax
> could be more convoluted, like an optional highest_cap argument
> to override the automatically generated value.
> 
> For example, to report bits 7, 1 and 0 are all set to 1:
> 	-machine pc,accel=kvm,nvdimm,nvdimm-cap=0x83
> would automatically set highest_cap to 7.
> 
> To report bit 7 set to 0 while bits 1 and 0 are set to 1:
> 	-machine pc,accel=kvm,nvdimm,nvdimm-cap=0x3,nvdimm-highest-cap=7

Yea, I agree that this is how we could do it, but I don't think this is
necessary right now.  We currently only have 3 bits in the Capabilities field,
and right now there is never a case where there is a difference between "I
don't know about this bit" and "I know about this bit, and it's value is 0".

So, really for now we could essentially just say the highest_cap = 31 and be
fine.

Let's put off the nvdimm-highest-cap argument complexity until we actually
have a use case where it adds value.
