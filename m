Received: from eggs.gnu.org ([2001:4830:134:3::10]:36351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1frftN-0003mA-Lm
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:50:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1frftK-00071N-Dm
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:50:29 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:50880
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1frftJ-000711-Td
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:50:26 -0400
References: <20180817114619.22354-1-peter.maydell@linaro.org>
	<20180817114619.22354-3-peter.maydell@linaro.org>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <11256311-a834-5fcd-fccf-bd079d1b1a1a@adacore.com>
Date: Mon, 20 Aug 2018 10:50:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180817114619.22354-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] memory: Remove MMIO request_ptr APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

Le 08/17/2018 =C3=A0 01:46 PM, Peter Maydell a =C3=A9crit=C2=A0:
> Remove the obsolete MMIO request_ptr APIs; they have no
> users now.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>

> ---
>   include/exec/memory.h |  35 --------------
>   memory.c              | 110 -----------------------------------------=
-
>   2 files changed, 145 deletions(-)
>=20
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 448d41a7529..68636561821 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -141,15 +141,6 @@ struct MemoryRegionOps {
>                                       uint64_t data,
>                                       unsigned size,
>                                       MemTxAttrs attrs);
> -    /* Instruction execution pre-callback:
> -     * @addr is the address of the access relative to the @mr.
> -     * @size is the size of the area returned by the callback.
> -     * @offset is the location of the pointer inside @mr.
> -     *
> -     * Returns a pointer to a location which contains guest code.
> -     */
> -    void *(*request_ptr)(void *opaque, hwaddr addr, unsigned *size,
> -                         unsigned *offset);
>  =20
>       enum device_endian endianness;
>       /* Guest-visible constraints: */
> @@ -1667,32 +1658,6 @@ void memory_global_dirty_log_stop(void);
>   void mtree_info(fprintf_function mon_printf, void *f, bool flatview,
>                   bool dispatch_tree, bool owner);
>  =20
> -/**
> - * memory_region_request_mmio_ptr: request a pointer to an mmio
> - * MemoryRegion. If it is possible map a RAM MemoryRegion with this po=
inter.
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
> - * memory_region_invalidate_mmio_ptr: invalidate the pointer to an mmi=
o
> - * previously requested.
> - * In the end that means that if something wants to execute from this =
area it
> - * will need to request the pointer again.
> - *
> - * @mr: #MemoryRegion associated to the pointer.
> - * @offset: offset within the memory region
> - * @size: size of that area.
> - */
> -void memory_region_invalidate_mmio_ptr(MemoryRegion *mr, hwaddr offset=
,
> -                                       unsigned size);
> -
>   /**
>    * memory_region_dispatch_read: perform a read directly to the specif=
ied
>    * MemoryRegion.
> diff --git a/memory.c b/memory.c
> index 2ea16e7bfb0..8b44672c132 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -29,7 +29,6 @@
>   #include "exec/ram_addr.h"
>   #include "sysemu/kvm.h"
>   #include "sysemu/sysemu.h"
> -#include "hw/misc/mmio_interface.h"
>   #include "hw/qdev-properties.h"
>   #include "migration/vmstate.h"
>  =20
> @@ -2680,115 +2679,6 @@ void memory_listener_unregister(MemoryListener =
*listener)
>       listener->address_space =3D NULL;
>   }
>  =20
> -bool memory_region_request_mmio_ptr(MemoryRegion *mr, hwaddr addr)
> -{
> -    void *host;
> -    unsigned size =3D 0;
> -    unsigned offset =3D 0;
> -    Object *new_interface;
> -
> -    if (!mr || !mr->ops->request_ptr) {
> -        return false;
> -    }
> -
> -    /*
> -     * Avoid an update if the request_ptr call
> -     * memory_region_invalidate_mmio_ptr which seems to be likely when=
 we use
> -     * a cache.
> -     */
> -    memory_region_transaction_begin();
> -
> -    host =3D mr->ops->request_ptr(mr->opaque, addr - mr->addr, &size, =
&offset);
> -
> -    if (!host || !size) {
> -        memory_region_transaction_commit();
> -        return false;
> -    }
> -
> -    new_interface =3D object_new("mmio_interface");
> -    qdev_prop_set_uint64(DEVICE(new_interface), "start", offset);
> -    qdev_prop_set_uint64(DEVICE(new_interface), "end", offset + size -=
 1);
> -    qdev_prop_set_bit(DEVICE(new_interface), "ro", true);
> -    qdev_prop_set_ptr(DEVICE(new_interface), "host_ptr", host);
> -    qdev_prop_set_ptr(DEVICE(new_interface), "subregion", mr);
> -    object_property_set_bool(OBJECT(new_interface), true, "realized", =
NULL);
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
> -static MMIOPtrInvalidate mmio_ptr_invalidate_list[MAX_MMIO_INVALIDATE]=
;
> -
> -static void memory_region_do_invalidate_mmio_ptr(CPUState *cpu,
> -                                                 run_on_cpu_data data)
> -{
> -    MMIOPtrInvalidate *invalidate_data =3D (MMIOPtrInvalidate *)data.h=
ost_ptr;
> -    MemoryRegion *mr =3D invalidate_data->mr;
> -    hwaddr offset =3D invalidate_data->offset;
> -    unsigned size =3D invalidate_data->size;
> -    MemoryRegionSection section =3D memory_region_find(mr, offset, siz=
e);
> -
> -    qemu_mutex_lock_iothread();
> -
> -    /* Reset dirty so this doesn't happen later. */
> -    cpu_physical_memory_test_and_clear_dirty(offset, size, 1);
> -
> -    if (section.mr !=3D mr) {
> -        /* memory_region_find add a ref on section.mr */
> -        memory_region_unref(section.mr);
> -        if (MMIO_INTERFACE(section.mr->owner)) {
> -            /* We found the interface just drop it. */
> -            object_property_set_bool(section.mr->owner, false, "realiz=
ed",
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
> -        invalidate_data->busy =3D 0;
> -    }
> -}
> -
> -void memory_region_invalidate_mmio_ptr(MemoryRegion *mr, hwaddr offset=
,
> -                                       unsigned size)
> -{
> -    size_t i;
> -    MMIOPtrInvalidate *invalidate_data =3D NULL;
> -
> -    for (i =3D 0; i < MAX_MMIO_INVALIDATE; i++) {
> -        if (atomic_cmpxchg(&(mmio_ptr_invalidate_list[i].busy), 0, 1) =
=3D=3D 0) {
> -            invalidate_data =3D &mmio_ptr_invalidate_list[i];
> -            break;
> -        }
> -    }
> -
> -    if (!invalidate_data) {
> -        invalidate_data =3D g_malloc0(sizeof(MMIOPtrInvalidate));
> -        invalidate_data->allocated =3D 1;
> -    }
> -
> -    invalidate_data->mr =3D mr;
> -    invalidate_data->offset =3D offset;
> -    invalidate_data->size =3D size;
> -
> -    async_safe_run_on_cpu(first_cpu, memory_region_do_invalidate_mmio_=
ptr,
> -                          RUN_ON_CPU_HOST_PTR(invalidate_data));
> -}
> -
>   void address_space_init(AddressSpace *as, MemoryRegion *root, const c=
har *name)
>   {
>       memory_region_ref(root);
>=20
