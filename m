Received: from eggs.gnu.org ([2001:4830:134:3::10]:48458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d19jJ-0001lW-Sl
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 06:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d19jG-00080G-Qr
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 06:54:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1d19jG-0007yx-HB
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 06:54:26 -0400
Date: Thu, 20 Apr 2017 12:54:19 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170420125419.0c0bf21f@nial.brq.redhat.com>
In-Reply-To: <20170411085700.3cgrvorievwcpc6r@hz-desktop>
References: <20170331084147.32716-1-haozhong.zhang@intel.com>
	<20170331084147.32716-2-haozhong.zhang@intel.com>
	<20170406102416.GA21895@stefanha-x1.localdomain>
	<20170406104649.jh263v7zijdxsywl@hz-desktop>
	<20170407134641.GH16146@stefanha-x1.localdomain>
	<20170411085700.3cgrvorievwcpc6r@hz-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/4] pc-dimm: add 'reserved-size' to
 reserve address range after the ending address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, dan.j.williams@intel.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, 11 Apr 2017 16:57:00 +0800
Haozhong Zhang <haozhong.zhang@intel.com> wrote:

> On 04/07/17 14:46 +0100, Stefan Hajnoczi wrote:
> > On Thu, Apr 06, 2017 at 06:46:49PM +0800, Haozhong Zhang wrote:  
> > > On 04/06/17 11:24 +0100, Stefan Hajnoczi wrote:  
> > > > On Fri, Mar 31, 2017 at 04:41:44PM +0800, Haozhong Zhang wrote:  
> > > > > If option 'reserved-size=RSVD' is present, QEMU will reserve an
> > > > > address range of size 'RSVD' after the ending address of pc-dimm
> > > > > device.
> > > > > 
> > > > > For the following example,
> > > > >     -object memory-backend-file,id=mem0,size=4G,...
> > > > >     -device nvdimm,id=dimm0,memdev=mem0,reserved-size=4K,...  
> > > > 
> > > > "reserved-size" is not a clear name.  I suggest calling the property
> > > > "num-flush-hints" (default 0).  QEMU can calculate the actual size in
> > > > bytes.
> > > > 
> > > >   -device nvdimm,num-flush-hints=1
I'm for this approach as well

I see that in patchset you hardcode cache line size to 64 for pc/q35
machines. What you could do is to introduce machine or cpu callback to
fetch cache line size and then you can calculate needed MMIO region size
using it and num-flush-hints in target independent way

> > > > 
> > > > QEMU will use one flush hint and reserve enough space (e.g. 1 page) for
> > > > the MMIO region.
> > > >  
> > > 
> > > Each flush hint can be as small as one cache line size which is also
> > > the size used in this patch series.
> > > 
> > > We need to calculate the size of all flush hints in pc_dimm_memory_plug(),
> > > because when building the flush hint address structure we need to know
> > > the address of flush hints.
> > > 
> > > IIUC, pc_dimm_memory_plug() is not specific to x86, so it's better
> > > take a general way to get the vcpu cache line size in pc_dimm_memory_plug(),
> > > which seemingly lacks in QEMU (though I believe it should be doable).
> > > 
> > > To make things simple, I leave the size decision to users, and check
> > > whether it's large enough when building the flush hint address
> > > structures in patch 4.  
> > 
> > Do you see my concern that "reserved-size" is not a good property?
> > 
> >  * How does the user choose a sensible value?  
> 
> A user has to calculate the size by himself by multiplying the number
> of flush hint address (currently it's hardcoded to 1) with the cache
> line size (e.g. 64 bytes on x86) and properly align it, or simply uses
> 4KB or even a larger value.
> 
> In case the reserved-size is too small, QEMU will complain and abort,
> so the user still has chance to know what goes wrong.
> 
> > 
> >  * Why is it called "reserved-size" instead of "flush-hints-size"?
> >  
> 
> This property is made as a property of pc-dimm rather than nvdimm,
> which could be used for other purposes, e.g. adjust the alignment the
> base address of hotplugged pc-dimm (I remember old linux kernels on
> x86-64 requires hotplugged memory chunk be 128MB aligned).
it would be rather awkward to use with pc-dimm:
 1: it would affect not the dimm for which it's specified but the following one
 2: to set it to correct value that would align base address of the next dimm
    to need value, the user first would have to know (set manually) a base address
    of dimm for which reserved-size is provided.

Users would be better off if he/she just provided properly aligned base address
instead of reserved-size.

> Of course,
> it can be limited to be a nvdimm-only property, and renamed to
> 'flush-hints-size' in that case.
pls move this property to nvdimm

> 
> Thanks,
> Haozhong
