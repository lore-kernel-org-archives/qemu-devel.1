Received: from eggs.gnu.org ([2001:4830:134:3::10]:39711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daPoY-0000u5-Ah
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 13:09:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daPoU-00050y-D1
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 13:09:38 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1daPoU-0004v2-6J
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 13:09:34 -0400
Received: by mail-wm0-f42.google.com with SMTP id c184so84449149wmd.0
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 10:09:30 -0700 (PDT)
References: <20170726165326.10327-1-anthony.perard@citrix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <67ed1f24-0c35-0c65-d003-1e025a891e99@redhat.com>
Date: Wed, 26 Jul 2017 19:09:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170726165326.10327-1-anthony.perard@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10] exec: Add lock parameter to
 qemu_ram_ptr_length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Stefano Stabellini <sstabellini@kernel.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 26/07/2017 18:53, Anthony PERARD wrote:
> Commit 04bf2526ce87f21b32c9acba1c5518708c243ad0 (exec: use
> qemu_ram_ptr_length to access guest ram) start using qemu_ram_ptr_length
> instead of qemu_map_ram_ptr, but when used with Xen, the behavior of
> both function is different. They both call xen_map_cache, but one with
> "lock", meaning the mapping of guest memory is never released
> implicitly, and the second one without, which means, mapping can be
> release later, when needed.
> 
> In the context of address_space_{read,write}_continue, the ptr to those
> mapping should not be locked because it is used immediatly and never
> used again.
> 
> The lock parameter make it explicit in which context qemu_ram_ptr_length
> is called.
> 
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks for implementing it.  I'll send a pull request for rc1.

Paolo

> ---
>  exec.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 01ac21e3cd..63508cd35e 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2203,7 +2203,7 @@ void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
>   * Called within RCU critical section.
>   */
>  static void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
> -                                 hwaddr *size)
> +                                 hwaddr *size, bool lock)
>  {
>      RAMBlock *block = ram_block;
>      if (*size == 0) {
> @@ -2222,10 +2222,10 @@ static void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
>           * In that case just map the requested area.
>           */
>          if (block->offset == 0) {
> -            return xen_map_cache(addr, *size, 1, true);
> +            return xen_map_cache(addr, *size, lock ? 1 : 0, lock);
>          }
>  
> -        block->host = xen_map_cache(block->offset, block->max_length, 1, true);
> +        block->host = xen_map_cache(block->offset, block->max_length, 1, lock);
>      }
>  
>      return ramblock_ptr(block, addr);
> @@ -2947,7 +2947,7 @@ static MemTxResult address_space_write_continue(AddressSpace *as, hwaddr addr,
>              }
>          } else {
>              /* RAM case */
> -            ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l);
> +            ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
>              memcpy(ptr, buf, l);
>              invalidate_and_set_dirty(mr, addr1, l);
>          }
> @@ -3038,7 +3038,7 @@ MemTxResult address_space_read_continue(AddressSpace *as, hwaddr addr,
>              }
>          } else {
>              /* RAM case */
> -            ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l);
> +            ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
>              memcpy(buf, ptr, l);
>          }
>  
> @@ -3349,7 +3349,7 @@ void *address_space_map(AddressSpace *as,
>  
>      memory_region_ref(mr);
>      *plen = address_space_extend_translation(as, addr, len, mr, xlat, l, is_write);
> -    ptr = qemu_ram_ptr_length(mr->ram_block, xlat, plen);
> +    ptr = qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
>      rcu_read_unlock();
>  
>      return ptr;
> 
