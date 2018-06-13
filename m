Received: from eggs.gnu.org ([2001:4830:134:3::10]:53503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fT8fZ-0005CT-JA
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fT8fW-0001C9-Dd
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:30:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55630 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fT8fW-0001AX-58
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:30:46 -0400
Date: Wed, 13 Jun 2018 18:30:42 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180613183042.2ce134a6@redhat.com>
In-Reply-To: <20180612150425.hjydg5cbtlllzh67@HZ>
References: <e74aee54657de6f8d643a92ba21f467db149c2c8.1528714312.git.yi.z.zhang@linux.intel.com>
	<20180611162630.GH17756@stefanha-x1.localdomain>
	<CAPcyv4jJSYiCu_qNWgU8KR3sFQE032Uu6LCQq-CTxF0jpkooiA@mail.gmail.com>
	<20180612150425.hjydg5cbtlllzh67@HZ>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Haozhong Zhang <hzzhan9@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Zhang Yi <yi.z.zhang@linux.intel.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Michael S. Tsirkin" <mst@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, yu.c.zhang@linux.intel.com, Stefan Hajnoczi <stefanha@redhat.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>

On Tue, 12 Jun 2018 23:04:25 +0800
Haozhong Zhang <hzzhan9@gmail.com> wrote:

> On 06/11/18 19:55, Dan Williams wrote:
> > On Mon, Jun 11, 2018 at 9:26 AM, Stefan Hajnoczi <stefanha@redhat.com> wrote:  
> > > On Mon, Jun 11, 2018 at 06:54:25PM +0800, Zhang Yi wrote:  
> > >> Nvdimm driver use Memory hot-plug APIs to map it's pmem resource,
> > >> which at a section granularity.
> > >>
> > >> When QEMU emulated the vNVDIMM device, decrease the label-storage,
> > >> QEMU will put the vNVDIMMs directly next to one another in physical
> > >> address space, which means that the boundary between them won't
> > >> align to the 128 MB memory section size.  
> > >
> > > I'm having a hard time parsing this.
> > >
> > > Where does the "128 MB memory section size" come from?  ACPI?
> > > A chipset-specific value?
> > >  
> > 
> > The devm_memremap_pages() implementation use the memory hotplug core
> > to allocate the 'struct page' array/map for persistent memory. Memory
> > hotplug can only be performed in terms of sections, 128MB on x86_64.  
> 
> IIUC, it also affects the normal RAM hotplug to a Linux VM on QEMU. If
> that is the case, it will be helpful to lift this option to pc-dimm.

Default alignment on page size boundary is implemented for the reason
that QEMU has no idea about guest os alignments req. and these requirements
might vary greatly depending on guest os running.
With some guests it works just fine even with 2M alignments/dimm sizes.

So it's up to upper layers which know what guest os is running to pick
plugged dimm sizes. So if a particular linux version minimum block size
is 128, then mgmt needs to plug dimm with size which is multiple of that.
That should satisfy whatever alignment req guest os has.

In case of nvdimm we need to fix address allocation in QEMU to account
for label size which broke above rule leading to "overlap" over label
area of nvdimm which isn't mapped into guest address space, but that's
probably it.

PS:
not related to patch question.
Intel guys contributed most of the code to nvdimm and continue actively
to develop it. Can we have a designated maintainer for nvdimm part from
Intel in addition to authors who just code/merge feature and disappear
(not reachable) shortly after that?


> Thanks,
> Haozhong
> 
> > There is some limited support for allowing devm_memremap_pages() to
> > overlap 'System RAM' within a given section, but it does not currently
> > support multiple devm_memremap_pages() calls overlapping within the
> > same section. There is currently a kernel bug where we do not handle
> > this unsupported configuration gracefully. The fix will cause
> > configurations configurations that try to overlap 2 persistent memory
> > ranges in the same section to fail.
> > 
> > The proposed fix is trying to make sure that QEMU does not run afoul
> > of this constraint.
> > 
> > There is currently no line of sight to reduce the minimum memory
> > hotplug alignment size to less than 128M. Also, as other architectures
> > outside of x86_64 add devm_memremap_pages() support, the minimum
> > section alignment constraint might change and is a property of a guest
> > OS. My understanding is that some guest OSes might expect an even
> > larger persistent memory minimum alignment.
> >   
