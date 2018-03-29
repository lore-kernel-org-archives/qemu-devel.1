Received: from eggs.gnu.org ([2001:4830:134:3::10]:46824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f1cle-0001Vv-OD
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 14:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f1clc-0000Eh-5K
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 14:59:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34008 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f1clb-0000Db-Nj
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 14:59:20 -0400
Date: Thu, 29 Mar 2018 19:59:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180329185909.GG2982@work-vm>
References: <20180228072558.7434-1-haozhong.zhang@intel.com>
	<20180228072558.7434-6-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228072558.7434-6-haozhong.zhang@intel.com>
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
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Juan Quintela <quintela@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>

* Haozhong Zhang (haozhong.zhang@intel.com) wrote:
> When loading a zero page, check whether it will be loaded to
> persistent memory If yes, load it by libpmem function
> pmem_memset_nodrain().  Combined with a call to pmem_drain() at the
> end of RAM loading, we can guarantee all those zero pages are
> persistently loaded.
> 
> Depending on the host HW/SW configurations, pmem_drain() can be
> "sfence".  Therefore, we do not call pmem_drain() after each
> pmem_memset_nodrain(), or use pmem_memset_persist() (equally
> pmem_memset_nodrain() + pmem_drain()), in order to avoid unnecessary
> overhead.
> 
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>

I'm still thinking this is way too invasive;  especially the next patch
that touches qemu_file.

One thing that would help a little, but not really enough, would be
to define a :

struct MemOps {
  void (*copy)(like a memcpy);
  void (*set)(like a memset);
}

then you could have:

struct MemOps normalops = {memcpy, memset};
struct MemOps pmem_nodrain_ops = { pmem_memcopy_nodrain, pmem_memset_nodrain };

then things like ram_handle_compressed would be:

void ram_handle_compressed(void *host, uint8_t ch, uint64_t size, const struct MemOps *mem)
{
    if (ch != 0 || !is_zero_range(host, size)) {
        mem->set(host, ch,size);
    }
}

which means the change is pretty tiny to each function.

> diff --git a/migration/rdma.c b/migration/rdma.c
> index da474fc19f..573bcd2cb0 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3229,7 +3229,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f, void *opaque)
>              host_addr = block->local_host_addr +
>                              (comp->offset - block->offset);
>  
> -            ram_handle_compressed(host_addr, comp->value, comp->length);
> +            ram_handle_compressed(host_addr, comp->value, comp->length, false);

Is that right? Is RDMA not allowed to work on PMEM?
(and anyway this call is a normal clear rather than an actual RDMA op).

Dave

>              break;
>  
>          case RDMA_CONTROL_REGISTER_FINISHED:
> diff --git a/stubs/pmem.c b/stubs/pmem.c
> index 03d990e571..a65b3bfc6b 100644
> --- a/stubs/pmem.c
> +++ b/stubs/pmem.c
> @@ -17,3 +17,12 @@ void *pmem_memcpy_persist(void *pmemdest, const void *src, size_t len)
>  {
>      return memcpy(pmemdest, src, len);
>  }
> +
> +void *pmem_memset_nodrain(void *pmemdest, int c, size_t len)
> +{
> +    return memset(pmemdest, c, len);
> +}
> +
> +void pmem_drain(void)
> +{
> +}
> -- 
> 2.14.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
