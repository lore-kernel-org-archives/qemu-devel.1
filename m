Received: from eggs.gnu.org ([2001:4830:134:3::10]:57111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1f2oUz-0005jS-7t
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 21:43:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1f2oUv-0005fM-AS
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 21:43:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:8665)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1f2oUu-0005eC-W9
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 21:43:01 -0400
Date: Mon, 2 Apr 2018 09:42:57 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20180402014257.bmjdz6cqdqu22u3z@hz-desktop>
References: <20180228072558.7434-1-haozhong.zhang@intel.com>
	<20180228072558.7434-6-haozhong.zhang@intel.com>
	<20180329185909.GG2982@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329185909.GG2982@work-vm>
Subject: Re: [Qemu-devel] [PATCH v4 5/8] migration/ram: ensure write
 persistence on loading zero pages to PMEM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Juan Quintela <quintela@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>

On 03/29/18 19:59 +0100, Dr. David Alan Gilbert wrote:
> * Haozhong Zhang (haozhong.zhang@intel.com) wrote:
> > When loading a zero page, check whether it will be loaded to
> > persistent memory If yes, load it by libpmem function
> > pmem_memset_nodrain().  Combined with a call to pmem_drain() at the
> > end of RAM loading, we can guarantee all those zero pages are
> > persistently loaded.
> > 
> > Depending on the host HW/SW configurations, pmem_drain() can be
> > "sfence".  Therefore, we do not call pmem_drain() after each
> > pmem_memset_nodrain(), or use pmem_memset_persist() (equally
> > pmem_memset_nodrain() + pmem_drain()), in order to avoid unnecessary
> > overhead.
> > 
> > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> 
> I'm still thinking this is way too invasive;  especially the next patch
> that touches qemu_file.
> 
> One thing that would help a little, but not really enough, would be
> to define a :
> 
> struct MemOps {
>   void (*copy)(like a memcpy);
>   void (*set)(like a memset);
> }
> 
> then you could have:
> 
> struct MemOps normalops = {memcpy, memset};
> struct MemOps pmem_nodrain_ops = { pmem_memcopy_nodrain, pmem_memset_nodrain };
> 
> then things like ram_handle_compressed would be:
> 
> void ram_handle_compressed(void *host, uint8_t ch, uint64_t size, const struct MemOps *mem)
> {
>     if (ch != 0 || !is_zero_range(host, size)) {
>         mem->set(host, ch,size);
>     }
> }
> 
> which means the change is pretty tiny to each function.

This looks much better than mine.

I'm also considering Stefan's comment that flushing at the end of all
memory migration rather than invasively change every types of copy in
migration stream. We are going to perform some microbenchmarks on the
real hardware, and then decide which way to take.

> 
> > diff --git a/migration/rdma.c b/migration/rdma.c
> > index da474fc19f..573bcd2cb0 100644
> > --- a/migration/rdma.c
> > +++ b/migration/rdma.c
> > @@ -3229,7 +3229,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f, void *opaque)
> >              host_addr = block->local_host_addr +
> >                              (comp->offset - block->offset);
> >  
> > -            ram_handle_compressed(host_addr, comp->value, comp->length);
> > +            ram_handle_compressed(host_addr, comp->value, comp->length, false);
> 
> Is that right? Is RDMA not allowed to work on PMEM?
> (and anyway this call is a normal clear rather than an actual RDMA op).
>

Well, this patch exclude RMDA case intentionally. Once it's clear how
to guarantee the persistence of remote PMEM write in RDMA, we will
propose additional patch to add support in QEMU.

Thanks,
Haozhong

> Dave
> 
> >              break;
> >  
> >          case RDMA_CONTROL_REGISTER_FINISHED:
> > diff --git a/stubs/pmem.c b/stubs/pmem.c
> > index 03d990e571..a65b3bfc6b 100644
> > --- a/stubs/pmem.c
> > +++ b/stubs/pmem.c
> > @@ -17,3 +17,12 @@ void *pmem_memcpy_persist(void *pmemdest, const void *src, size_t len)
> >  {
> >      return memcpy(pmemdest, src, len);
> >  }
> > +
> > +void *pmem_memset_nodrain(void *pmemdest, int c, size_t len)
> > +{
> > +    return memset(pmemdest, c, len);
> > +}
> > +
> > +void pmem_drain(void)
> > +{
> > +}
> > -- 
> > 2.14.1
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
