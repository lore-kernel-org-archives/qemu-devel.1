Received: from eggs.gnu.org ([2001:4830:134:3::10]:53547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1ejMn8-0004bA-Cw
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:17:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1ejMn5-00028R-7E
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:17:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1ejMn4-00027h-Uq
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:17:23 -0500
Date: Wed, 7 Feb 2018 05:17:20 -0500 (EST)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <1091122025.1148119.1517998640676.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180207073331.14158-6-haozhong.zhang@intel.com>
References: <20180207073331.14158-1-haozhong.zhang@intel.com>
	<20180207073331.14158-6-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/8] migration/ram: ensure write
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
Cc: qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, mst@redhat.com, Juan Quintela <quintela@redhat.com>, dgilbert@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Eduardo Habkost <ehabkost@redhat.com>


> 
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

Are you saying we don't need 'pmem_drain()'?

I can see its called in patch 5 in ram_load? But
I also see empty definition. Anything I am missing here?

Thanks,
Pankaj

> 
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---
>  include/qemu/pmem.h |  9 +++++++++
>  migration/ram.c     | 34 +++++++++++++++++++++++++++++-----
>  2 files changed, 38 insertions(+), 5 deletions(-)
> 
> diff --git a/include/qemu/pmem.h b/include/qemu/pmem.h
> index 9017596ff0..861d8ecc21 100644
> --- a/include/qemu/pmem.h
> +++ b/include/qemu/pmem.h
> @@ -26,6 +26,15 @@ pmem_memcpy_persist(void *pmemdest, const void *src,
> size_t len)
>      return memcpy(pmemdest, src, len);
>  }
>  
> +static inline void *pmem_memset_nodrain(void *pmemdest, int c, size_t len)
> +{
> +    return memset(pmemdest, c, len);
> +}
> +
> +static inline void pmem_drain(void)
> +{
> +}
> +
>  #endif /* CONFIG_LIBPMEM */
>  
>  #endif /* !QEMU_PMEM_H */
> diff --git a/migration/ram.c b/migration/ram.c
> index cb1950f3eb..5a0e503818 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -49,6 +49,7 @@
>  #include "qemu/rcu_queue.h"
>  #include "migration/colo.h"
>  #include "migration/block.h"
> +#include "qemu/pmem.h"
>  
>  /***********************************************************/
>  /* ram save/restore */
> @@ -2467,6 +2468,20 @@ static inline void
> *host_from_ram_block_offset(RAMBlock *block,
>      return block->host + offset;
>  }
>  
> +static void ram_handle_compressed_common(void *host, uint8_t ch, uint64_t
> size,
> +                                         bool is_pmem)
> +{
> +    if (!ch && is_zero_range(host, size)) {
> +        return;
> +    }
> +
> +    if (!is_pmem) {
> +        memset(host, ch, size);
> +    } else {
> +        pmem_memset_nodrain(host, ch, size);
> +    }
> +}
> +
>  /**
>   * ram_handle_compressed: handle the zero page case
>   *
> @@ -2479,9 +2494,7 @@ static inline void *host_from_ram_block_offset(RAMBlock
> *block,
>   */
>  void ram_handle_compressed(void *host, uint8_t ch, uint64_t size)
>  {
> -    if (ch != 0 || !is_zero_range(host, size)) {
> -        memset(host, ch, size);
> -    }
> +    return ram_handle_compressed_common(host, ch, size, false);
>  }
>  
>  static void *do_data_decompress(void *opaque)
> @@ -2823,6 +2836,7 @@ static int ram_load(QEMUFile *f, void *opaque, int
> version_id)
>      bool postcopy_running = postcopy_is_running();
>      /* ADVISE is earlier, it shows the source has the postcopy capability on
>      */
>      bool postcopy_advised = postcopy_is_advised();
> +    bool need_pmem_drain = false;
>  
>      seq_iter++;
>  
> @@ -2848,6 +2862,8 @@ static int ram_load(QEMUFile *f, void *opaque, int
> version_id)
>          ram_addr_t addr, total_ram_bytes;
>          void *host = NULL;
>          uint8_t ch;
> +        RAMBlock *block = NULL;
> +        bool is_pmem = false;
>  
>          addr = qemu_get_be64(f);
>          flags = addr & ~TARGET_PAGE_MASK;
> @@ -2864,7 +2880,7 @@ static int ram_load(QEMUFile *f, void *opaque, int
> version_id)
>  
>          if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
>                       RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)) {
> -            RAMBlock *block = ram_block_from_stream(f, flags);
> +            block = ram_block_from_stream(f, flags);
>  
>              host = host_from_ram_block_offset(block, addr);
>              if (!host) {
> @@ -2874,6 +2890,9 @@ static int ram_load(QEMUFile *f, void *opaque, int
> version_id)
>              }
>              ramblock_recv_bitmap_set(block, host);
>              trace_ram_load_loop(block->idstr, (uint64_t)addr, flags, host);
> +
> +            is_pmem = ramblock_is_pmem(block);
> +            need_pmem_drain = need_pmem_drain || is_pmem;
>          }
>  
>          switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
> @@ -2927,7 +2946,7 @@ static int ram_load(QEMUFile *f, void *opaque, int
> version_id)
>  
>          case RAM_SAVE_FLAG_ZERO:
>              ch = qemu_get_byte(f);
> -            ram_handle_compressed(host, ch, TARGET_PAGE_SIZE);
> +            ram_handle_compressed_common(host, ch, TARGET_PAGE_SIZE,
> is_pmem);
>              break;
>  
>          case RAM_SAVE_FLAG_PAGE:
> @@ -2970,6 +2989,11 @@ static int ram_load(QEMUFile *f, void *opaque, int
> version_id)
>      }
>  
>      wait_for_decompress_done();
> +
> +    if (need_pmem_drain) {
> +        pmem_drain();
> +    }
> +
>      rcu_read_unlock();
>      trace_ram_load_complete(ret, seq_iter);
>      return ret;
> --
> 2.14.1
> 
> 
> 
