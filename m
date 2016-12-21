Received: from eggs.gnu.org ([2001:4830:134:3::10]:49333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cJaQL-0005NH-JP
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 01:30:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cJaQI-0006ZH-6G
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 01:30:49 -0500
References: <1478094287-15009-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1478094287-15009-2-git-send-email-caoj.fnst@cn.fujitsu.com>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <585A22A7.6000203@cn.fujitsu.com>
Date: Wed, 21 Dec 2016 14:35:19 +0800
MIME-Version: 1.0
In-Reply-To: <1478094287-15009-2-git-send-email-caoj.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/2] util/mmap-alloc: check parameter
 before using
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: peter.maydell@linaro.org, thuth@redhat.com, armbru@redhat.com, mst@redhat.com

ping

On 11/02/2016 09:44 PM, Cao jin wrote:
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>  util/mmap-alloc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> index 5a85aa3..d713a72 100644
> --- a/util/mmap-alloc.c
> +++ b/util/mmap-alloc.c
> @@ -12,6 +12,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/mmap-alloc.h"
> +#include "qemu/host-utils.h"
>  
>  #define HUGETLBFS_MAGIC       0x958458f6
>  
> @@ -61,18 +62,18 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
>  #else
>      void *ptr = mmap(0, total, PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>  #endif
> -    size_t offset = QEMU_ALIGN_UP((uintptr_t)ptr, align) - (uintptr_t)ptr;
> +    size_t offset;
>      void *ptr1;
>  
>      if (ptr == MAP_FAILED) {
>          return MAP_FAILED;
>      }
>  
> -    /* Make sure align is a power of 2 */
> -    assert(!(align & (align - 1)));
> +    assert(is_power_of_2(align));
>      /* Always align to host page size */
>      assert(align >= getpagesize());
>  
> +    offset = QEMU_ALIGN_UP((uintptr_t)ptr, align) - (uintptr_t)ptr;
>      ptr1 = mmap(ptr + offset, size, PROT_READ | PROT_WRITE,
>                  MAP_FIXED |
>                  (fd == -1 ? MAP_ANONYMOUS : 0) |
> 

-- 
Sincerely,
Cao jin
