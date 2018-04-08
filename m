Received: from eggs.gnu.org ([2001:4830:134:3::10]:51973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f5FsW-0000st-Ks
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 15:21:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f5FsS-0003eN-Kz
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 15:21:28 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:39901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f5FsS-0003eF-GE
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 15:21:24 -0400
Received: by mail-qk0-x242.google.com with SMTP id j73so6961635qke.6
	for <qemu-devel@nongnu.org>; Sun, 08 Apr 2018 12:21:24 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180405012241.25714-1-f4bug@amsat.org>
	<20180405012241.25714-3-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9d0fe3a6-2791-9578-0706-9bcce133b47b@amsat.org>
Date: Sun, 8 Apr 2018 16:21:18 -0300
MIME-Version: 1.0
In-Reply-To: <20180405012241.25714-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [NOTFORMERGE PATCH v2 2/4] memory: Fix
 access_with_adjusted_size() when size < access_size_min
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, KONRAD Frederic <frederic.konrad@adacore.com>
Cc: qemu-devel@nongnu.org

On 04/04/2018 10:22 PM, Philippe Mathieu-Daudé wrote:
> ASan reported:
> 
>     shift exponent 4294967280 is too large for 64-bit type 'long unsigned int'
>     ...
>     runtime error: shift exponent -16 is negative
> 
> This can occurs when MemoryRegionOps .valid.min_access_size < .impl.min_access_size,
> for example if a guest uses a 16-bit operand to access a 32-bit register.
> 
> The current code is limited to right shifting.
> Use a signed shift, to allow shifting left when the value is negative.
> 
> Reported-by: AddressSanitizer
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  memory.c | 74 +++++++++++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 52 insertions(+), 22 deletions(-)
> 
> diff --git a/memory.c b/memory.c
> index 51d27b7b26..e77f9e4036 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -404,7 +404,7 @@ static MemTxResult memory_region_oldmmio_read_accessor(MemoryRegion *mr,
>                                                         hwaddr addr,
>                                                         uint64_t *value,
>                                                         unsigned size,
> -                                                       unsigned shift,
> +                                                       signed shift,
>                                                         uint64_t mask,
>                                                         MemTxAttrs attrs)
>  {
> @@ -422,7 +422,11 @@ static MemTxResult memory_region_oldmmio_read_accessor(MemoryRegion *mr,
>          hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
>          trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp, size);
>      }
> -    *value |= (tmp & mask) << shift;
> +    if (likely(shift >= 0)) {
> +        *value |= (tmp & mask) << shift;
> +    } else {
> +        *value |= (tmp >> -shift) & mask;
> +    }
>      return MEMTX_OK;
>  }
>  
> @@ -430,7 +434,7 @@ static MemTxResult  memory_region_read_accessor(MemoryRegion *mr,
>                                                  hwaddr addr,
>                                                  uint64_t *value,
>                                                  unsigned size,
> -                                                unsigned shift,
> +                                                signed shift,
>                                                  uint64_t mask,
>                                                  MemTxAttrs attrs)
>  {
> @@ -448,7 +452,11 @@ static MemTxResult  memory_region_read_accessor(MemoryRegion *mr,
>          hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
>          trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp, size);
>      }
> -    *value |= (tmp & mask) << shift;
> +    if (likely(shift >= 0)) {
> +        *value |= (tmp & mask) << shift;
> +    } else {
> +        *value |= (tmp >> -shift) & mask;
> +    }
>      return MEMTX_OK;
>  }
>  
> @@ -456,7 +464,7 @@ static MemTxResult memory_region_read_with_attrs_accessor(MemoryRegion *mr,
>                                                            hwaddr addr,
>                                                            uint64_t *value,
>                                                            unsigned size,
> -                                                          unsigned shift,
> +                                                          signed shift,
>                                                            uint64_t mask,
>                                                            MemTxAttrs attrs)
>  {
> @@ -475,7 +483,11 @@ static MemTxResult memory_region_read_with_attrs_accessor(MemoryRegion *mr,
>          hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
>          trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp, size);
>      }
> -    *value |= (tmp & mask) << shift;
> +    if (likely(shift >= 0)) {
> +        *value |= (tmp & mask) << shift;
> +    } else {
> +        *value |= (tmp >> -shift) & mask;
> +    }
>      return r;
>  }
>  
> @@ -483,13 +495,17 @@ static MemTxResult memory_region_oldmmio_write_accessor(MemoryRegion *mr,
>                                                          hwaddr addr,
>                                                          uint64_t *value,
>                                                          unsigned size,
> -                                                        unsigned shift,
> +                                                        signed shift,
>                                                          uint64_t mask,
>                                                          MemTxAttrs attrs)
>  {
>      uint64_t tmp;
>  
> -    tmp = (*value >> shift) & mask;
> +    if (likely(shift >= 0)) {
> +        tmp = (*value >> shift) & mask;
> +    } else {
> +        tmp = (*value & mask) << -shift;
> +    }
>      if (mr->subpage) {
>          trace_memory_region_subpage_write(get_cpu_index(), mr, addr, tmp, size);
>      } else if (mr == &io_mem_notdirty) {
> @@ -509,13 +525,17 @@ static MemTxResult memory_region_write_accessor(MemoryRegion *mr,
>                                                  hwaddr addr,
>                                                  uint64_t *value,
>                                                  unsigned size,
> -                                                unsigned shift,
> +                                                signed shift,
>                                                  uint64_t mask,
>                                                  MemTxAttrs attrs)
>  {
>      uint64_t tmp;
>  
> -    tmp = (*value >> shift) & mask;
> +    if (likely(shift >= 0)) {
> +        tmp = (*value >> shift) & mask;
> +    } else {
> +        tmp = (*value & mask) << -shift;
> +    }
>      if (mr->subpage) {
>          trace_memory_region_subpage_write(get_cpu_index(), mr, addr, tmp, size);
>      } else if (mr == &io_mem_notdirty) {
> @@ -535,13 +555,17 @@ static MemTxResult memory_region_write_with_attrs_accessor(MemoryRegion *mr,
>                                                             hwaddr addr,
>                                                             uint64_t *value,
>                                                             unsigned size,
> -                                                           unsigned shift,
> +                                                           signed shift,
>                                                             uint64_t mask,
>                                                             MemTxAttrs attrs)
>  {
>      uint64_t tmp;
>  
> -    tmp = (*value >> shift) & mask;
> +    if (likely(shift >= 0)) {
> +        tmp = (*value >> shift) & mask;
> +    } else {
> +        tmp = (*value & mask) << -shift;
> +    }
>      if (mr->subpage) {
>          trace_memory_region_subpage_write(get_cpu_index(), mr, addr, tmp, size);
>      } else if (mr == &io_mem_notdirty) {
> @@ -566,7 +590,7 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
>                                                     hwaddr addr,
>                                                     uint64_t *value,
>                                                     unsigned size,
> -                                                   unsigned shift,
> +                                                   signed shift,
>                                                     uint64_t mask,
>                                                     MemTxAttrs attrs),
>                                        MemoryRegion *mr,
> @@ -574,7 +598,9 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
>  {
>      uint64_t access_mask;
>      unsigned access_size;
> -    unsigned i;
> +    hwaddr access_addr;
> +    unsigned offset;
> +    signed shift;
>      MemTxResult r = MEMTX_OK;
>  
>      if (!access_size_min) {
> @@ -586,16 +612,20 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
>  
>      /* FIXME: support unaligned access? */
>      access_size = MAX(MIN(size, access_size_max), access_size_min);
> -    access_mask = -1ULL >> (64 - access_size * 8);
> -    if (memory_region_big_endian(mr)) {
> -        for (i = 0; i < size; i += access_size) {
> -            r |= access_fn(mr, addr + i, value, access_size,
> -                        (size - access_size - i) * 8, access_mask, attrs);
> +    access_mask = -1ULL >> (64 - size * 8);
> +    access_addr = addr & ~(access_size - 1);
> +    if (likely(size >= access_size)) {
> +        offset = addr & (access_size - 1);
> +        shift = access_size - size - offset;
> +        if (!memory_region_big_endian(mr)) {
> +            shift = -shift;
>          }

Please disregard this patch, I hope the next respin will make more sens.

> +        r = access_fn(mr, access_addr, value, access_size,
> +                      shift * 8, access_mask, attrs);
>      } else {
> -        for (i = 0; i < size; i += access_size) {
> -            r |= access_fn(mr, addr + i, value, access_size, i * 8,
> -                        access_mask, attrs);
> +        for (offset = 0; offset < size; offset += access_size) {
> +            r |= access_fn(mr, access_addr + offset, value, access_size,
> +                           offset * 8, access_mask, attrs);
>          }
>      }
>      return r;
> 
