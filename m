Received: from eggs.gnu.org ([2001:4830:134:3::10]:46269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1fSc3S-0007jY-DX
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 01:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1fSc3N-0001kQ-H9
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 01:41:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:3730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1fSc3N-0001ZK-84
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 01:41:13 -0400
Message-ID: <1528810024.3385.15.camel@linux.intel.com>
From: "Zhang,Yi" <yi.z.zhang@linux.intel.com>
Date: Tue, 12 Jun 2018 21:27:04 +0800
In-Reply-To: <CAPcyv4jJSYiCu_qNWgU8KR3sFQE032Uu6LCQq-CTxF0jpkooiA@mail.gmail.com>
References: <e74aee54657de6f8d643a92ba21f467db149c2c8.1528714312.git.yi.z.zhang@linux.intel.com>
	<20180611162630.GH17756@stefanha-x1.localdomain>
	<CAPcyv4jJSYiCu_qNWgU8KR3sFQE032Uu6LCQq-CTxF0jpkooiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] nvdimm: let qemu requiring section
 alignment of pmem resource.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Williams <dan.j.williams@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Qemu Developers <qemu-devel@nongnu.org>, yu.c.zhang@linux.intel.com, Igor Mammedov <imammedo@redhat.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>

On 一, 2018-06-11 at 19:55 -0700, Dan Williams wrote:
> On Mon, Jun 11, 2018 at 9:26 AM, Stefan Hajnoczi <stefanha@redhat.com
> > wrote:
> > 
> > On Mon, Jun 11, 2018 at 06:54:25PM +0800, Zhang Yi wrote:
> > > 
> > > Nvdimm driver use Memory hot-plug APIs to map it's pmem resource,
> > > which at a section granularity.
> > > 
> > > When QEMU emulated the vNVDIMM device, decrease the label-
> > > storage,
> > > QEMU will put the vNVDIMMs directly next to one another in
> > > physical
> > > address space, which means that the boundary between them won't
> > > align to the 128 MB memory section size.
> > I'm having a hard time parsing this.
> > 
> > Where does the "128 MB memory section size" come from?  ACPI?
> > A chipset-specific value?
> > 
> The devm_memremap_pages() implementation use the memory hotplug core
> to allocate the 'struct page' array/map for persistent memory. Memory
> hotplug can only be performed in terms of sections, 128MB on x86_64.
> There is some limited support for allowing devm_memremap_pages() to
> overlap 'System RAM' within a given section, but it does not
> currently
> support multiple devm_memremap_pages() calls overlapping within the
> same section. There is currently a kernel bug where we do not handle
> this unsupported configuration gracefully. The fix will cause
> configurations configurations that try to overlap 2 persistent memory
> ranges in the same section to fail.
> 
> The proposed fix is trying to make sure that QEMU does not run afoul
> of this constraint.
> 
> There is currently no line of sight to reduce the minimum memory
> hotplug alignment size to less than 128M. Also, as other
> architectures
> outside of x86_64 add devm_memremap_pages() support, the minimum
> section alignment constraint might change and is a property of a
> guest
> OS. My understanding is that some guest OSes might expect an even
> larger persistent memory minimum alignment.
> 
Thanks Dan's explanation, I still have a question that why we
overlapping
the un-align area  instead of drop it? and let it align to the next
section. 
