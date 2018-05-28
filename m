Received: from eggs.gnu.org ([2001:4830:134:3::10]:47624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNAcm-0001E8-1R
	for qemu-devel@nongnu.org; Mon, 28 May 2018 01:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNAcg-000689-T8
	for qemu-devel@nongnu.org; Mon, 28 May 2018 01:23:16 -0400
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:52108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNAcg-000641-Io
	for qemu-devel@nongnu.org; Mon, 28 May 2018 01:23:10 -0400
Received: from player687.ha.ovh.net (unknown [10.109.120.1])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 2F0771654E
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 07:23:00 +0200 (CEST)
References: <20180426150901.30278-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <03045d77-94bd-3686-2f80-00abf55b4373@kaod.org>
Date: Mon, 28 May 2018 07:22:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180426150901.30278-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] mmio-exec: Make device return
 MemoryRegion rather than host pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, KONRAD Frederic <frederic.konrad@adacore.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "Emilio G. Cota" <cota@braap.org>

On 04/26/2018 05:09 PM, Peter Maydell wrote:
> Our current interface for allowing a device to support execution from
> MMIO regions has the device return a pointer into host memory
> containing the contents to be used for execution.  Unfortunately the
> obvious implementation this encourages (and which our only in-tree
> user uses) is to have a single buffer which is reused for each new
> request_ptr call.  This doesn't work, because RCU means that removal
> of the old RAMBlock based on the host pointer may be deferred until a
> point after a new RAMBlock with the same pointer has been added to
> the list.  The RAMBlock APIs assume that the host-pointer to ram_addr
> mapping is unique, and mmio-exec is breaking that assumption.

yes. I have run into the same problem while implementing mmio-exec 
for the aspeed fmc controllers. 

The FW (U-boot) in some configuration does a CRC calculation which 
jumps from one code section to another. This trashes the MMIO cache 
a very large number of times and the RAM block list can contain up 
to 40 occurrences of the same cache ... it is nearly impossible not 
to hit the bug you describe.

This patch fixes the issue but maybe an another approach could be to 
introduce a cache allocator which would make sure that host-pointers
are unique ?

Thanks,

C. 

> Instead, change the API so that the device is responsible for
> allocating a new RAM MemoryRegion and populating it.  The
> MemoryRegion will be g_free()d when the region is eventually
> invalidated or otherwise unneeded.
> 
> HACKS:
>  * Note that in order for the refcounting to work correctly without
>    having to manufacture a device purely to be the owner of the
>    MemoryRegion, we must pass OBJECT(newmr) as the owner (so the MR is
>    its own owner!) and NULL as the name (or the property created on the
>    owner causes the refcount to go negative during finalization)...
> 
> QUESTIONS:
>  * do we really need to postpone things from
>    memory_region_invalidate_mmio_ptr() to
>    memory_region_do_invalidate_mmio_ptr(), given that the deletion of
>    the memory region and ramblock is RCU-deferred anyway?
>  * should we add the subregion at elevated prio so it definitely hits
>    first?  I've left it the way the existing code does for the
>    moment...
>  * is there any way to avoid the weird self-owning MemoryRegion
>    and corresponding need to pass a NULL name pointer?
> 
> NOTES:
>  * This change means that hw/misc/mmio_interface.c is no longer
>    used; if this gets beyond RFC stage then another patch to
>    delete it can follow.
>  * The "request_mmio_exec mustn't fail after it has called
>    memory_region_mmio_ptr_alloc()" requirement is a bit ugly, but
>    could probably be removed.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is decidedly RFC, but it is sufficient to get the xilinx-spips
> mmio-execution test case to run without crashing. Mostly looking for
> feedback on whether this is the right general direction or a load
> of rubbish :-)
> 
>  include/exec/memory.h | 44 ++++++++++++++++++++----
>  hw/ssi/xilinx_spips.c | 22 ++++++++----
>  memory.c              | 78 ++++++++++++++++++++++++++++---------------
>  3 files changed, 105 insertions(+), 39 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 31eae0a640..e55e06a166 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -139,14 +139,32 @@ struct MemoryRegionOps {
>                                      unsigned size,
>                                      MemTxAttrs attrs);
>      /* Instruction execution pre-callback:
> -     * @addr is the address of the access relative to the @mr.
> -     * @size is the size of the area returned by the callback.
> -     * @offset is the location of the pointer inside @mr.
> +     * @opaque is the opaque pointer for the MemoryRegion.
> +     * @alloc_token is a token to pass to memory_region_mmio_ptr_alloc()
> +     * @offset contains the address of the access relative to the @mr.
>       *
> -     * Returns a pointer to a location which contains guest code.
> +     * The request_mmio_exec callback must:
> +     *  - adjust the offset downwards as desired and determine the size
> +     *    of the region it wants to provide cached guest code for.
> +     *    This must start on a guest page boundary and be a multiple
> +     *    of a guest page in size.
> +     *  - call memory_region_mmio_ptr_alloc(@alloc_token, size)
> +     *  - fill in the contents of the RAM
> +     * Ownership of @newmr remains with the caller; it will be
> +     * automatically freed when no longer in use.
> +     *
> +     * If the callback cannot satisfy the request then it should
> +     * return false. Otherwise it must
> +     *  - update @offset to the offset of the memory within the MemoryRegion
> +     *    this is a callback for (ie the possibly rounded down value)
> +     *  - return true
> +     * Note that if you return false then execution of the guest is going
> +     * to go wrong, either by QEMU delivering a bus abort exception to the
> +     * guest, or by simply exiting as unable to handle the situation, in
> +     * the same way that it would if you did not provide a request_mmio_exec
> +     * callback at all.
>       */
> -    void *(*request_ptr)(void *opaque, hwaddr addr, unsigned *size,
> -                         unsigned *offset);
> +    bool (*request_mmio_exec)(void *opaque, void *alloc_token, hwaddr *offset);
>  
>      enum device_endian endianness;
>      /* Guest-visible constraints: */
> @@ -1569,6 +1587,20 @@ bool memory_region_request_mmio_ptr(MemoryRegion *mr, hwaddr addr);
>  void memory_region_invalidate_mmio_ptr(MemoryRegion *mr, hwaddr offset,
>                                         unsigned size);
>  
> +/**
> + * memory_region_mmio_ptr_alloc: allocate memory from request_mmio_exec callback
> + *
> + * This function should be called only from a MemoryRegion's request_mmio_exec
> + * callback function, in order to allocate the memory that should be filled
> + * with the cached contents to be executed.
> + * Note that once the request_mmio_exec callback calls this function it is
> + * committed to handling the request, and may not return false.
> + *
> + * @alloc_token: the argument passed into the request_mmio_exec callback
> + * @size: size in bytes to allocate
> + */
> +void *memory_region_mmio_ptr_alloc(void *alloc_token, uint64_t size);
> +
>  /**
>   * memory_region_dispatch_read: perform a read directly to the specified
>   * MemoryRegion.
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index 03f5faee4b..8bb049f797 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -1202,21 +1202,29 @@ static void lqspi_load_cache(void *opaque, hwaddr addr)
>      }
>  }
>  
> -static void *lqspi_request_mmio_ptr(void *opaque, hwaddr addr, unsigned *size,
> -                                    unsigned *offset)
> +static bool lqspi_request_mmio_exec(void *opaque, void *alloc_token,
> +                                    hwaddr *offset)
>  {
>      XilinxQSPIPS *q = opaque;
>      hwaddr offset_within_the_region;
> +    void *hostptr;
>  
>      if (!q->mmio_execution_enabled) {
> -        return NULL;
> +        return false;
>      }
>  
> -    offset_within_the_region = addr & ~(LQSPI_CACHE_SIZE - 1);
> +    /* This could perhaps be cleverer and avoid the memcpy by
> +     * caching directly into the allocated area.
> +     */
> +    offset_within_the_region = *offset & ~(LQSPI_CACHE_SIZE - 1);
>      lqspi_load_cache(opaque, offset_within_the_region);
> -    *size = LQSPI_CACHE_SIZE;
> +
> +    hostptr = memory_region_mmio_ptr_alloc(alloc_token, LQSPI_CACHE_SIZE);
> +
> +    memcpy(hostptr, q->lqspi_buf, LQSPI_CACHE_SIZE);
> +
>      *offset = offset_within_the_region;
> -    return q->lqspi_buf;
> +    return true;
>  }
>  
>  static uint64_t
> @@ -1240,7 +1248,7 @@ lqspi_read(void *opaque, hwaddr addr, unsigned int size)
>  
>  static const MemoryRegionOps lqspi_ops = {
>      .read = lqspi_read,
> -    .request_ptr = lqspi_request_mmio_ptr,
> +    .request_mmio_exec = lqspi_request_mmio_exec,
>      .endianness = DEVICE_NATIVE_ENDIAN,
>      .valid = {
>          .min_access_size = 1,
> diff --git a/memory.c b/memory.c
> index e70b64b8b9..71dec85156 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2653,41 +2653,74 @@ void memory_listener_unregister(MemoryListener *listener)
>  
>  bool memory_region_request_mmio_ptr(MemoryRegion *mr, hwaddr addr)
>  {
> -    void *host;
> -    unsigned size = 0;
> -    unsigned offset = 0;
> -    Object *new_interface;
> +    MemoryRegion *newmr;
> +    hwaddr offset;
>  
> -    if (!mr || !mr->ops->request_ptr) {
> +    if (!mr || !mr->ops->request_mmio_exec) {
>          return false;
>      }
>  
>      /*
> -     * Avoid an update if the request_ptr call
> -     * memory_region_invalidate_mmio_ptr which seems to be likely when we use
> -     * a cache.
> +     * Avoid an update if the request_mmio_exec hook calls
> +     * memory_region_invalidate_mmio_ptr, which it will do if the
> +     * device can only handle one outstanding MMIO exec region at once.
>       */
>      memory_region_transaction_begin();
>  
> -    host = mr->ops->request_ptr(mr->opaque, addr - mr->addr, &size, &offset);
> -
> -    if (!host || !size) {
> +    newmr = g_new0(MemoryRegion, 1);
> +    offset = addr - mr->addr;
> +    if (!mr->ops->request_mmio_exec(mr->opaque, newmr, &offset)) {
>          memory_region_transaction_commit();
> +        g_free(newmr);
>          return false;
>      }
>  
> -    new_interface = object_new("mmio_interface");
> -    qdev_prop_set_uint64(DEVICE(new_interface), "start", offset);
> -    qdev_prop_set_uint64(DEVICE(new_interface), "end", offset + size - 1);
> -    qdev_prop_set_bit(DEVICE(new_interface), "ro", true);
> -    qdev_prop_set_ptr(DEVICE(new_interface), "host_ptr", host);
> -    qdev_prop_set_ptr(DEVICE(new_interface), "subregion", mr);
> -    object_property_set_bool(OBJECT(new_interface), true, "realized", NULL);
> +    /* These requirements are because currently TCG needs a page sized
> +     * area to execute from.
> +     */
> +    assert((offset & ~TARGET_PAGE_MASK) == 0);
> +    assert((memory_region_size(newmr) & ~TARGET_PAGE_MASK) == 0);
>  
> +
> +    memory_region_add_subregion(mr, offset, newmr);
>      memory_region_transaction_commit();
> +
> +    /* Arrange that we automatically free this MemoryRegion when
> +     * its refcount goes to zero, which (once we've unrefed it here)
> +     * will happen when it is removed from the subregion.
> +     */
> +    OBJECT(newmr)->free = g_free;
> +    object_unref(OBJECT(newmr));
>      return true;
>  }
>  
> +void *memory_region_mmio_ptr_alloc(void *alloc_token, uint64_t size)
> +{
> +    /* Allocate and return memory for an mmio_ptr request. This
> +     * is a function intended to be called from a memory region's
> +     * request_mmio_exec function, and the opaque pointer is the
> +     * newmr MemoryRegion allocated in memory_region_request_mmio_ptr().
> +     */
> +    MemoryRegion *newmr = alloc_token;
> +    Error *err = NULL;
> +
> +    /* Note that in order for the refcounting to work correctly
> +     * without having to manufacture a device purely to be the
> +     * owner of the MemoryRegion, we must pass OBJECT(newmr) as
> +     * the owner (so the MR is its own owner!) and NULL as the name
> +     * (or the property created on the owner causes the refcount
> +     * to go negative during finalization)...
> +     */
> +    memory_region_init_ram_nomigrate(newmr, OBJECT(newmr), NULL,
> +                                     size, &err);
> +    if (err) {
> +        error_free(err);
> +        return NULL;
> +    }
> +
> +    return memory_region_get_ram_ptr(newmr);
> +}
> +
>  typedef struct MMIOPtrInvalidate {
>      MemoryRegion *mr;
>      hwaddr offset;
> @@ -2714,15 +2747,8 @@ static void memory_region_do_invalidate_mmio_ptr(CPUState *cpu,
>      cpu_physical_memory_test_and_clear_dirty(offset, size, 1);
>  
>      if (section.mr != mr) {
> -        /* memory_region_find add a ref on section.mr */
> +        memory_region_del_subregion(mr, section.mr);
>          memory_region_unref(section.mr);
> -        if (MMIO_INTERFACE(section.mr->owner)) {
> -            /* We found the interface just drop it. */
> -            object_property_set_bool(section.mr->owner, false, "realized",
> -                                     NULL);
> -            object_unref(section.mr->owner);
> -            object_unparent(section.mr->owner);
> -        }
>      }
>  
>      qemu_mutex_unlock_iothread();
> 
