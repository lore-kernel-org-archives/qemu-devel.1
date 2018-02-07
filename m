Received: from eggs.gnu.org ([2001:4830:134:3::10]:46118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ejOEG-0003vN-Qw
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:49:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ejOED-0001cp-Ld
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:49:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57818 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ejOED-0001cf-Ew
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:49:29 -0500
Date: Wed, 7 Feb 2018 11:49:11 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180207114910.GC2665@work-vm>
References: <20180207073331.14158-1-haozhong.zhang@intel.com>
	<20180207073331.14158-7-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207073331.14158-7-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/8] migration/ram: ensure write
 persistence on loading normal pages to PMEM
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
> When loading a normal page to persistent memory, load its data by
> libpmem function pmem_memcpy_nodrain() instead of memcpy(). Combined
> with a call to pmem_drain() at the end of memory loading, we can
> guarantee all those normal pages are persistenly loaded to PMEM.
> 
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---
>  include/migration/qemu-file-types.h |  1 +
>  include/qemu/pmem.h                 |  6 ++++++
>  migration/qemu-file.c               | 41 ++++++++++++++++++++++++++++---------
>  migration/ram.c                     |  6 +++++-
>  4 files changed, 43 insertions(+), 11 deletions(-)
> 
> diff --git a/include/migration/qemu-file-types.h b/include/migration/qemu-file-types.h
> index bd6d7dd7f9..bb5c547498 100644
> --- a/include/migration/qemu-file-types.h
> +++ b/include/migration/qemu-file-types.h
> @@ -34,6 +34,7 @@ void qemu_put_be16(QEMUFile *f, unsigned int v);
>  void qemu_put_be32(QEMUFile *f, unsigned int v);
>  void qemu_put_be64(QEMUFile *f, uint64_t v);
>  size_t qemu_get_buffer(QEMUFile *f, uint8_t *buf, size_t size);
> +size_t qemu_get_buffer_to_pmem(QEMUFile *f, uint8_t *buf, size_t size);
>  
>  int qemu_get_byte(QEMUFile *f);
>  
> diff --git a/include/qemu/pmem.h b/include/qemu/pmem.h
> index 861d8ecc21..77ee1fc4eb 100644
> --- a/include/qemu/pmem.h
> +++ b/include/qemu/pmem.h
> @@ -26,6 +26,12 @@ pmem_memcpy_persist(void *pmemdest, const void *src, size_t len)
>      return memcpy(pmemdest, src, len);
>  }
>  
> +static inline void *
> +pmem_memcpy_nodrain(void *pmemdest, const void *src, size_t len)
> +{
> +    return memcpy(pmemdest, src, len);
> +}
> +
>  static inline void *pmem_memset_nodrain(void *pmemdest, int c, size_t len)
>  {
>      return memset(pmemdest, c, len);
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 2ab2bf362d..7e573010d9 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -26,6 +26,7 @@
>  #include "qemu-common.h"
>  #include "qemu/error-report.h"
>  #include "qemu/iov.h"
> +#include "qemu/pmem.h"
>  #include "migration.h"
>  #include "qemu-file.h"
>  #include "trace.h"
> @@ -471,15 +472,8 @@ size_t qemu_peek_buffer(QEMUFile *f, uint8_t **buf, size_t size, size_t offset)
>      return size;
>  }
>  
> -/*
> - * Read 'size' bytes of data from the file into buf.
> - * 'size' can be larger than the internal buffer.
> - *
> - * It will return size bytes unless there was an error, in which case it will
> - * return as many as it managed to read (assuming blocking fd's which
> - * all current QEMUFile are)
> - */
> -size_t qemu_get_buffer(QEMUFile *f, uint8_t *buf, size_t size)
> +static size_t
> +qemu_get_buffer_common(QEMUFile *f, uint8_t *buf, size_t size, bool is_pmem)
>  {
>      size_t pending = size;
>      size_t done = 0;
> @@ -492,7 +486,11 @@ size_t qemu_get_buffer(QEMUFile *f, uint8_t *buf, size_t size)
>          if (res == 0) {
>              return done;
>          }
> -        memcpy(buf, src, res);
> +        if (!is_pmem) {
> +            memcpy(buf, src, res);
> +        } else {
> +            pmem_memcpy_nodrain(buf, src, res);
> +        }

I see why you're doing it, but again I'm surprised it's ended up having
to modify qemu-file.

>          qemu_file_skip(f, res);
>          buf += res;
>          pending -= res;
> @@ -501,6 +499,29 @@ size_t qemu_get_buffer(QEMUFile *f, uint8_t *buf, size_t size)
>      return done;
>  }
>  
> +/*
> + * Read 'size' bytes of data from the file into buf.
> + * 'size' can be larger than the internal buffer.
> + *
> + * It will return size bytes unless there was an error, in which case it will
> + * return as many as it managed to read (assuming blocking fd's which
> + * all current QEMUFile are)
> + */
> +size_t qemu_get_buffer(QEMUFile *f, uint8_t *buf, size_t size)
> +{
> +    return qemu_get_buffer_common(f, buf, size, false);
> +}
> +
> +/*
> + * Mostly the same as qemu_get_buffer(), except that
> + * 1) it's for the case that 'buf' is in the persistent memory, and
> + * 2) it takes necessary operations to ensure the data persistence in 'buf'.
> + */
> +size_t qemu_get_buffer_to_pmem(QEMUFile *f, uint8_t *buf, size_t size)
> +{
> +    return qemu_get_buffer_common(f, buf, size, true);
> +}
> +
>  /*
>   * Read 'size' bytes of data from the file.
>   * 'size' can be larger than the internal buffer.
> diff --git a/migration/ram.c b/migration/ram.c
> index 5a0e503818..5a79bbff64 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2950,7 +2950,11 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>              break;
>  
>          case RAM_SAVE_FLAG_PAGE:
> -            qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
> +            if (!is_pmem) {
> +                qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
> +            } else {
> +                qemu_get_buffer_to_pmem(f, host, TARGET_PAGE_SIZE);
> +            }

can you just expose qemu_get_buffer_common instead of making it static
and just pass in the is_pmem flag.

Dave

>              break;
>  
>          case RAM_SAVE_FLAG_COMPRESS_PAGE:
> -- 
> 2.14.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
