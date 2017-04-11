Received: from eggs.gnu.org ([2001:4830:134:3::10]:33955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cxrBA-0001Ep-RV
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 04:29:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cxrB5-0003R8-VF
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 04:29:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:20775)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1cxrB5-0003Qj-L9
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 04:29:31 -0400
Date: Tue, 11 Apr 2017 16:29:28 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20170411082928.kpzw3pd5cweqyjt5@hz-desktop>
References: <20170331084147.32716-1-haozhong.zhang@intel.com>
	<20170331084147.32716-3-haozhong.zhang@intel.com>
	<ad9c678b-5859-e54c-2eb6-06d458a41312@gmail.com>
	<20170411082237.4wd5anbqab6pzlz2@hz-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170411082237.4wd5anbqab6pzlz2@hz-desktop>
Subject: Re: [Qemu-devel] [RFC PATCH 2/4] nvdimm: add functions to
 initialize and perform flush on back store
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: qemu-devel@nongnu.org, dan.j.williams@intel.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 04/11/17 16:22 +0800, Haozhong Zhang wrote:
> On 04/06/17 19:52 +0800, Xiao Guangrong wrote:
> > 
> > 
> > On 03/31/2017 04:41 PM, Haozhong Zhang wrote:
> > > fsync() is used to persist modifications to the back store. If the
> > > host NVDIMM is used as the back store, fsync() on Linux will trigger
> > > the write to the host flush hint address.
> > > 
> > > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> > > ---
> > >  hw/mem/nvdimm.c         | 22 ++++++++++++++++++++++
> > >  include/hw/mem/nvdimm.h | 13 +++++++++++++
> > >  2 files changed, 35 insertions(+)
> > > 
> > > diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> > > index db896b0..484ab8b 100644
> > > --- a/hw/mem/nvdimm.c
> > > +++ b/hw/mem/nvdimm.c
> > > @@ -78,6 +78,26 @@ static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm)
> > >      return &nvdimm->nvdimm_mr;
> > >  }
> > > 
> > > +static void nvdimm_flush_init(NVDIMMDevice *nvdimm, MemoryRegion *hostmem_mr)
> > > +{
> > > +    if (nvdimm->flush_hint_enabled) {
> > > +        nvdimm->backend_fd = memory_region_get_fd(hostmem_mr);
> > 
> > Hmm, IIRC host-mem-file does not initalize backend_fd at all.
> 
> Oops, forgot to add this part. Thanks for remind.

Sorry, I replied too quick.

For hostmem-file, hostmem_mr->ram_block->fd is set in file_ram_alloc(),
which can be got by memory_region_get_fd() here.

Haozhong
