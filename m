Received: from eggs.gnu.org ([2001:4830:134:3::10]:38066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ejPT0-0003Fo-5i
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 08:08:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ejPSw-0002Jt-4R
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 08:08:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60046 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ejPSv-0002JQ-Vl
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 08:08:46 -0500
Date: Wed, 7 Feb 2018 13:08:27 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180207130827.GI2665@work-vm>
References: <20180207073331.14158-1-haozhong.zhang@intel.com>
	<20180207073331.14158-9-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207073331.14158-9-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 8/8] migration/ram: ensure write
 persistence on loading xbzrle pages to PMEM
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
> When loading a xbzrle encoded page to persistent memory, load the data
> via libpmem function pmem_memcpy_nodrain() instead of memcpy().
> Combined with a call to pmem_drain() at the end of memory loading, we
> can guarantee those xbzrle encoded pages are persistently loaded to PMEM.
> 
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---
>  migration/ram.c    | 15 ++++++++++-----
>  migration/xbzrle.c | 20 ++++++++++++++++++--
>  migration/xbzrle.h |  1 +
>  3 files changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 924d2b9537..87f977617d 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2388,10 +2388,10 @@ static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
>      }
>  }
>  
> -static int load_xbzrle(QEMUFile *f, ram_addr_t addr, void *host)
> +static int load_xbzrle(QEMUFile *f, ram_addr_t addr, void *host, bool is_pmem)
>  {
>      unsigned int xh_len;
> -    int xh_flags;
> +    int xh_flags, rc;
>      uint8_t *loaded_data;
>  
>      /* extract RLE header */
> @@ -2413,8 +2413,13 @@ static int load_xbzrle(QEMUFile *f, ram_addr_t addr, void *host)
>      qemu_get_buffer_in_place(f, &loaded_data, xh_len);
>  
>      /* decode RLE */
> -    if (xbzrle_decode_buffer(loaded_data, xh_len, host,
> -                             TARGET_PAGE_SIZE) == -1) {
> +    if (!is_pmem) {
> +        rc = xbzrle_decode_buffer(loaded_data, xh_len, host, TARGET_PAGE_SIZE);
> +    } else {
> +        rc = xbzrle_decode_buffer_to_pmem(loaded_data, xh_len, host,
> +                                          TARGET_PAGE_SIZE);
> +    }
> +    if (rc == -1) {
>          error_report("Failed to load XBZRLE page - decode error!");
>          return -1;
>      }
> @@ -2974,7 +2979,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>              break;
>  
>          case RAM_SAVE_FLAG_XBZRLE:
> -            if (load_xbzrle(f, addr, host) < 0) {
> +            if (load_xbzrle(f, addr, host, is_pmem) < 0) {
>                  error_report("Failed to decompress XBZRLE page at "
>                               RAM_ADDR_FMT, addr);
>                  ret = -EINVAL;
> diff --git a/migration/xbzrle.c b/migration/xbzrle.c
> index 1ba482ded9..499d8e1bfb 100644
> --- a/migration/xbzrle.c
> +++ b/migration/xbzrle.c
> @@ -12,6 +12,7 @@
>   */
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
> +#include "qemu/pmem.h"
>  #include "xbzrle.h"
>  
>  /*
> @@ -126,7 +127,8 @@ int xbzrle_encode_buffer(uint8_t *old_buf, uint8_t *new_buf, int slen,
>      return d;
>  }
>  
> -int xbzrle_decode_buffer(uint8_t *src, int slen, uint8_t *dst, int dlen)
> +static int xbzrle_decode_buffer_common(uint8_t *src, int slen, uint8_t *dst,
> +                                       int dlen, bool is_pmem)
>  {
>      int i = 0, d = 0;
>      int ret;
> @@ -167,10 +169,24 @@ int xbzrle_decode_buffer(uint8_t *src, int slen, uint8_t *dst, int dlen)
>              return -1;
>          }
>  
> -        memcpy(dst + d, src + i, count);
> +        if (!is_pmem) {
> +            memcpy(dst + d, src + i, count);
> +        } else {
> +            pmem_memcpy_nodrain(dst + d, src + i, count);
> +        }
>          d += count;
>          i += count;
>      }
>  
>      return d;
>  }
> +
> +int xbzrle_decode_buffer(uint8_t *src, int slen, uint8_t *dst, int dlen)
> +{
> +    return xbzrle_decode_buffer_common(src, slen, dst, dlen, false);
> +}
> +
> +int xbzrle_decode_buffer_to_pmem(uint8_t *src, int slen, uint8_t *dst, int dlen)
> +{
> +    return xbzrle_decode_buffer_common(src, slen, dst, dlen, true);
> +}

Again I wouldn't bother with these two wrappers, just add the is_pmem
flag or pointer to xbzrle_decode_buffer.  Note that in xbzrle load this
is doing lots of small copies; I'm not sure if this changes your needs.

Dave

> diff --git a/migration/xbzrle.h b/migration/xbzrle.h
> index a0db507b9c..ac5ae32666 100644
> --- a/migration/xbzrle.h
> +++ b/migration/xbzrle.h
> @@ -18,4 +18,5 @@ int xbzrle_encode_buffer(uint8_t *old_buf, uint8_t *new_buf, int slen,
>                           uint8_t *dst, int dlen);
>  
>  int xbzrle_decode_buffer(uint8_t *src, int slen, uint8_t *dst, int dlen);
> +int xbzrle_decode_buffer_to_pmem(uint8_t *src, int slen, uint8_t *dst, int dlen);
>  #endif
> -- 
> 2.14.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
