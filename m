Received: from eggs.gnu.org ([2001:4830:134:3::10]:34046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fqiNo-0003U8-4a
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fqiNm-0004MO-8g
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:17:56 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:36822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fqiNl-0004LG-Ej
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:17:53 -0400
Received: by mail-lj1-x241.google.com with SMTP id u7-v6so6940490lji.3
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 10:17:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180817114619.22354-3-peter.maydell@linaro.org>
References: <20180817114619.22354-1-peter.maydell@linaro.org>
	<20180817114619.22354-3-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Aug 2018 10:17:21 -0700
Message-ID: <CAKmqyKPmdw=dOMpgdceP8vSb5dvU5EgoVU_Aqn0U=ED8Ri2qnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/3] memory: Remove MMIO request_ptr APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On Fri, Aug 17, 2018 at 4:46 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> Remove the obsolete MMIO request_ptr APIs; they have no
> users now.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/exec/memory.h |  35 --------------
>  memory.c              | 110 ------------------------------------------
>  2 files changed, 145 deletions(-)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 448d41a7529..68636561821 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -141,15 +141,6 @@ struct MemoryRegionOps {
>                                      uint64_t data,
>                                      unsigned size,
>                                      MemTxAttrs attrs);
> -    /* Instruction execution pre-callback:
> -     * @addr is the address of the access relative to the @mr.
> -     * @size is the size of the area returned by the callback.
> -     * @offset is the location of the pointer inside @mr.
> -     *
> -     * Returns a pointer to a location which contains guest code.
> -     */
> -    void *(*request_ptr)(void *opaque, hwaddr addr, unsigned *size,
> -                         unsigned *offset);
>
>      enum device_endian endianness;
>      /* Guest-visible constraints: */
> @@ -1667,32 +1658,6 @@ void memory_global_dirty_log_stop(void);
>  void mtree_info(fprintf_function mon_printf, void *f, bool flatview,
>                  bool dispatch_tree, bool owner);
>
> -/**
> - * memory_region_request_mmio_ptr: request a pointer to an mmio
> - * MemoryRegion. If it is possible map a RAM MemoryRegion with this pointer.
> - * When the device wants to invalidate the pointer it will call
> - * memory_region_invalidate_mmio_ptr.
> - *
> - * @mr: #MemoryRegion to check
> - * @addr: address within that region
> - *
> - * Returns true on success, false otherwise.
> - */
> -bool memory_region_request_mmio_ptr(MemoryRegion *mr, hwaddr addr);
> -
> -/**
> - * memory_region_invalidate_mmio_ptr: invalidate the pointer to an mmio
> - * previously requested.
> - * In the end that means that if something wants to execute from this area it
> - * will need to request the pointer again.
> - *
> - * @mr: #MemoryRegion associated to the pointer.
> - * @offset: offset within the memory region
> - * @size: size of that area.
> - */
> -void memory_region_invalidate_mmio_ptr(MemoryRegion *mr, hwaddr offset,
> -                                       unsigned size);
> -
>  /**
>   * memory_region_dispatch_read: perform a read directly to the specified
>   * MemoryRegion.
> diff --git a/memory.c b/memory.c
> index 2ea16e7bfb0..8b44672c132 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -29,7 +29,6 @@
>  #include "exec/ram_addr.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/sysemu.h"
> -#include "hw/misc/mmio_interface.h"
>  #include "hw/qdev-properties.h"
>  #include "migration/vmstate.h"
>
> @@ -2680,115 +2679,6 @@ void memory_listener_unregister(MemoryListener *listener)
>      listener->address_space = NULL;
>  }
>
> -bool memory_region_request_mmio_ptr(MemoryRegion *mr, hwaddr addr)
> -{
> -    void *host;
> -    unsigned size = 0;
> -    unsigned offset = 0;
> -    Object *new_interface;
> -
> -    if (!mr || !mr->ops->request_ptr) {
> -        return false;
> -    }
> -
> -    /*
> -     * Avoid an update if the request_ptr call
> -     * memory_region_invalidate_mmio_ptr which seems to be likely when we use
> -     * a cache.
> -     */
> -    memory_region_transaction_begin();
> -
> -    host = mr->ops->request_ptr(mr->opaque, addr - mr->addr, &size, &offset);
> -
> -    if (!host || !size) {
> -        memory_region_transaction_commit();
> -        return false;
> -    }
> -
> -    new_interface = object_new("mmio_interface");
> -    qdev_prop_set_uint64(DEVICE(new_interface), "start", offset);
> -    qdev_prop_set_uint64(DEVICE(new_interface), "end", offset + size - 1);
> -    qdev_prop_set_bit(DEVICE(new_interface), "ro", true);
> -    qdev_prop_set_ptr(DEVICE(new_interface), "host_ptr", host);
> -    qdev_prop_set_ptr(DEVICE(new_interface), "subregion", mr);
> -    object_property_set_bool(OBJECT(new_interface), true, "realized", NULL);
> -
> -    memory_region_transaction_commit();
> -    return true;
> -}
> -
> -typedef struct MMIOPtrInvalidate {
> -    MemoryRegion *mr;
> -    hwaddr offset;
> -    unsigned size;
> -    int busy;
> -    int allocated;
> -} MMIOPtrInvalidate;
> -
> -#define MAX_MMIO_INVALIDATE 10
> -static MMIOPtrInvalidate mmio_ptr_invalidate_list[MAX_MMIO_INVALIDATE];
> -
> -static void memory_region_do_invalidate_mmio_ptr(CPUState *cpu,
> -                                                 run_on_cpu_data data)
> -{
> -    MMIOPtrInvalidate *invalidate_data = (MMIOPtrInvalidate *)data.host_ptr;
> -    MemoryRegion *mr = invalidate_data->mr;
> -    hwaddr offset = invalidate_data->offset;
> -    unsigned size = invalidate_data->size;
> -    MemoryRegionSection section = memory_region_find(mr, offset, size);
> -
> -    qemu_mutex_lock_iothread();
> -
> -    /* Reset dirty so this doesn't happen later. */
> -    cpu_physical_memory_test_and_clear_dirty(offset, size, 1);
> -
> -    if (section.mr != mr) {
> -        /* memory_region_find add a ref on section.mr */
> -        memory_region_unref(section.mr);
> -        if (MMIO_INTERFACE(section.mr->owner)) {
> -            /* We found the interface just drop it. */
> -            object_property_set_bool(section.mr->owner, false, "realized",
> -                                     NULL);
> -            object_unref(section.mr->owner);
> -            object_unparent(section.mr->owner);
> -        }
> -    }
> -
> -    qemu_mutex_unlock_iothread();
> -
> -    if (invalidate_data->allocated) {
> -        g_free(invalidate_data);
> -    } else {
> -        invalidate_data->busy = 0;
> -    }
> -}
> -
> -void memory_region_invalidate_mmio_ptr(MemoryRegion *mr, hwaddr offset,
> -                                       unsigned size)
> -{
> -    size_t i;
> -    MMIOPtrInvalidate *invalidate_data = NULL;
> -
> -    for (i = 0; i < MAX_MMIO_INVALIDATE; i++) {
> -        if (atomic_cmpxchg(&(mmio_ptr_invalidate_list[i].busy), 0, 1) == 0) {
> -            invalidate_data = &mmio_ptr_invalidate_list[i];
> -            break;
> -        }
> -    }
> -
> -    if (!invalidate_data) {
> -        invalidate_data = g_malloc0(sizeof(MMIOPtrInvalidate));
> -        invalidate_data->allocated = 1;
> -    }
> -
> -    invalidate_data->mr = mr;
> -    invalidate_data->offset = offset;
> -    invalidate_data->size = size;
> -
> -    async_safe_run_on_cpu(first_cpu, memory_region_do_invalidate_mmio_ptr,
> -                          RUN_ON_CPU_HOST_PTR(invalidate_data));
> -}
> -
>  void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
>  {
>      memory_region_ref(root);
> --
> 2.18.0
>
>
