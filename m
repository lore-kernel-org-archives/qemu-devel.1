Received: from eggs.gnu.org ([2001:4830:134:3::10]:53040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cmPK3-0002HK-DC
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 13:31:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cmPK0-0000kT-Oa
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 13:31:27 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:63151)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1cmPK0-0000kA-Ek
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 13:31:24 -0500
References: <1479509016-8673-1-git-send-email-hpoussin@reactos.org>
	<2eee690a-04b0-4fc1-3a1b-17232d1ed09f@reactos.org>
	<eaf447af-33e7-be5e-392a-d289b32245b1@reactos.org>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <3d0ac339-6d31-2889-75f9-2cee28d0359f@reactos.org>
Date: Fri, 10 Mar 2017 19:31:09 +0100
MIME-Version: 1.0
In-Reply-To: <eaf447af-33e7-be5e-392a-d289b32245b1@reactos.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.8] dma/rc4030: translate memory
 accesses only when they occur
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-devel@nongnu.org
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Peter Maydell <peter.maydell@linaro.org>

Ping again.

Le 26/02/2017 =C3=A0 20:19, Herv=C3=A9 Poussineau a =C3=A9crit :
> Ping again.
>
> Le 22/02/2017 =C3=A0 07:19, Herv=C3=A9 Poussineau a =C3=A9crit :
>> Ping?
>>
>> Le 18/11/2016 =C3=A0 23:43, Herv=C3=A9 Poussineau a =C3=A9crit :
>>> This simplifies the code a lot, and this fixes big memory leaks
>>> introduced in a3d586f704609a45b6037534cb2f34da5dfd8895
>>>
>>> Windows NT is now able to boot without using gigabytes of ram on the =
host.
>>>
>>> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>>> ---
>>>  hw/dma/rc4030.c | 158 +++++++++++++---------------------------------=
----------
>>>  1 file changed, 36 insertions(+), 122 deletions(-)
>>>
>>> diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
>>> index 41fc043..5f10b9d 100644
>>> --- a/hw/dma/rc4030.c
>>> +++ b/hw/dma/rc4030.c
>>> @@ -34,8 +34,6 @@
>>>  /********************************************************/
>>>  /* rc4030 emulation                                     */
>>>
>>> -#define MAX_TL_ENTRIES 512
>>> -
>>>  typedef struct dma_pagetable_entry {
>>>      int32_t frame;
>>>      int32_t owner;
>>> @@ -91,14 +89,8 @@ typedef struct rc4030State
>>>      qemu_irq timer_irq;
>>>      qemu_irq jazz_bus_irq;
>>>
>>> -    /* biggest translation table */
>>> -    MemoryRegion dma_tt;
>>> -    /* translation table memory region alias, added to system RAM */
>>> -    MemoryRegion dma_tt_alias;
>>>      /* whole DMA memory region, root of DMA address space */
>>>      MemoryRegion dma_mr;
>>> -    /* translation table entry aliases, added to DMA memory region *=
/
>>> -    MemoryRegion dma_mrs[MAX_TL_ENTRIES];
>>>      AddressSpace dma_as;
>>>
>>>      MemoryRegion iomem_chipset;
>>> @@ -256,96 +248,6 @@ static uint64_t rc4030_read(void *opaque, hwaddr=
 addr, unsigned int size)
>>>      return val;
>>>  }
>>>
>>> -static void rc4030_dma_as_update_one(rc4030State *s, int index, uint=
32_t frame)
>>> -{
>>> -    if (index < MAX_TL_ENTRIES) {
>>> -        memory_region_set_enabled(&s->dma_mrs[index], false);
>>> -    }
>>> -
>>> -    if (!frame) {
>>> -        return;
>>> -    }
>>> -
>>> -    if (index >=3D MAX_TL_ENTRIES) {
>>> -        qemu_log_mask(LOG_UNIMP,
>>> -                      "rc4030: trying to use too high "
>>> -                      "translation table entry %d (max allowed=3D%d)=
",
>>> -                      index, MAX_TL_ENTRIES);
>>> -        return;
>>> -    }
>>> -    memory_region_set_alias_offset(&s->dma_mrs[index], frame);
>>> -    memory_region_set_enabled(&s->dma_mrs[index], true);
>>> -}
>>> -
>>> -static void rc4030_dma_tt_write(void *opaque, hwaddr addr, uint64_t =
data,
>>> -                                unsigned int size)
>>> -{
>>> -    rc4030State *s =3D opaque;
>>> -
>>> -    /* write memory */
>>> -    memcpy(memory_region_get_ram_ptr(&s->dma_tt) + addr, &data, size=
);
>>> -
>>> -    /* update dma address space (only if frame field has been writte=
n) */
>>> -    if (addr % sizeof(dma_pagetable_entry) =3D=3D 0) {
>>> -        int index =3D addr / sizeof(dma_pagetable_entry);
>>> -        memory_region_transaction_begin();
>>> -        rc4030_dma_as_update_one(s, index, (uint32_t)data);
>>> -        memory_region_transaction_commit();
>>> -    }
>>> -}
>>> -
>>> -static const MemoryRegionOps rc4030_dma_tt_ops =3D {
>>> -    .write =3D rc4030_dma_tt_write,
>>> -    .impl.min_access_size =3D 4,
>>> -    .impl.max_access_size =3D 4,
>>> -};
>>> -
>>> -static void rc4030_dma_tt_update(rc4030State *s, uint32_t new_tl_bas=
e,
>>> -                                 uint32_t new_tl_limit)
>>> -{
>>> -    int entries, i;
>>> -    dma_pagetable_entry *dma_tl_contents;
>>> -
>>> -    if (s->dma_tl_limit) {
>>> -        /* write old dma tl table to physical memory */
>>> -        memory_region_del_subregion(get_system_memory(), &s->dma_tt_=
alias);
>>> -        cpu_physical_memory_write(s->dma_tl_limit & 0x7fffffff,
>>> -                                  memory_region_get_ram_ptr(&s->dma_=
tt),
>>> -                                  memory_region_size(&s->dma_tt_alia=
s));
>>> -    }
>>> -    object_unparent(OBJECT(&s->dma_tt_alias));
>>> -
>>> -    s->dma_tl_base =3D new_tl_base;
>>> -    s->dma_tl_limit =3D new_tl_limit;
>>> -    new_tl_base &=3D 0x7fffffff;
>>> -
>>> -    if (s->dma_tl_limit) {
>>> -        uint64_t dma_tt_size;
>>> -        if (s->dma_tl_limit <=3D memory_region_size(&s->dma_tt)) {
>>> -            dma_tt_size =3D s->dma_tl_limit;
>>> -        } else {
>>> -            dma_tt_size =3D memory_region_size(&s->dma_tt);
>>> -        }
>>> -        memory_region_init_alias(&s->dma_tt_alias, OBJECT(s),
>>> -                                 "dma-table-alias",
>>> -                                 &s->dma_tt, 0, dma_tt_size);
>>> -        dma_tl_contents =3D memory_region_get_ram_ptr(&s->dma_tt);
>>> -        cpu_physical_memory_read(new_tl_base, dma_tl_contents, dma_t=
t_size);
>>> -
>>> -        memory_region_transaction_begin();
>>> -        entries =3D dma_tt_size / sizeof(dma_pagetable_entry);
>>> -        for (i =3D 0; i < entries; i++) {
>>> -            rc4030_dma_as_update_one(s, i, dma_tl_contents[i].frame)=
;
>>> -        }
>>> -        memory_region_add_subregion(get_system_memory(), new_tl_base=
,
>>> -                                    &s->dma_tt_alias);
>>> -        memory_region_transaction_commit();
>>> -    } else {
>>> -        memory_region_init(&s->dma_tt_alias, OBJECT(s),
>>> -                           "dma-table-alias", 0);
>>> -    }
>>> -}
>>> -
>>>  static void rc4030_write(void *opaque, hwaddr addr, uint64_t data,
>>>                           unsigned int size)
>>>  {
>>> @@ -362,11 +264,11 @@ static void rc4030_write(void *opaque, hwaddr a=
ddr, uint64_t data,
>>>          break;
>>>      /* DMA transl. table base */
>>>      case 0x0018:
>>> -        rc4030_dma_tt_update(s, val, s->dma_tl_limit);
>>> +        s->dma_tl_base =3D val;
>>>          break;
>>>      /* DMA transl. table limit */
>>>      case 0x0020:
>>> -        rc4030_dma_tt_update(s, s->dma_tl_base, val);
>>> +        s->dma_tl_limit =3D val;
>>>          break;
>>>      /* DMA transl. table invalidated */
>>>      case 0x0028:
>>> @@ -586,6 +488,38 @@ static const MemoryRegionOps jazzio_ops =3D {
>>>      .endianness =3D DEVICE_NATIVE_ENDIAN,
>>>  };
>>>
>>> +static IOMMUTLBEntry rc4030_dma_translate(MemoryRegion *iommu, hwadd=
r addr,
>>> +                                          bool is_write)
>>> +{
>>> +    rc4030State *s =3D container_of(iommu, rc4030State, dma_mr);
>>> +    IOMMUTLBEntry ret =3D {
>>> +        .target_as =3D &address_space_memory,
>>> +        .iova =3D addr & ~(DMA_PAGESIZE - 1),
>>> +        .translated_addr =3D 0,
>>> +        .addr_mask =3D DMA_PAGESIZE - 1,
>>> +        .perm =3D IOMMU_NONE,
>>> +    };
>>> +    uint64_t i, entry_address;
>>> +    dma_pagetable_entry entry;
>>> +
>>> +    i =3D addr / DMA_PAGESIZE;
>>> +    if (i < s->dma_tl_limit / sizeof(entry)) {
>>> +        entry_address =3D (s->dma_tl_base & 0x7fffffff) + i * sizeof=
(entry);
>>> +        if (address_space_read(ret.target_as, entry_address,
>>> +                               MEMTXATTRS_UNSPECIFIED, (unsigned cha=
r *)&entry,
>>> +                               sizeof(entry)) =3D=3D MEMTX_OK) {
>>> +            ret.translated_addr =3D entry.frame & ~(DMA_PAGESIZE - 1=
);
>>> +            ret.perm =3D IOMMU_RW;
>>> +        }
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static const MemoryRegionIOMMUOps rc4030_dma_ops =3D {
>>> +    .translate =3D rc4030_dma_translate,
>>> +};
>>> +
>>>  static void rc4030_reset(DeviceState *dev)
>>>  {
>>>      rc4030State *s =3D RC4030(dev);
>>> @@ -596,7 +530,6 @@ static void rc4030_reset(DeviceState *dev)
>>>      s->invalid_address_register =3D 0;
>>>
>>>      memset(s->dma_regs, 0, sizeof(s->dma_regs));
>>> -    rc4030_dma_tt_update(s, 0, 0);
>>>
>>>      s->remote_failed_address =3D s->memory_failed_address =3D 0;
>>>      s->cache_maint =3D 0;
>>> @@ -735,7 +668,6 @@ static void rc4030_realize(DeviceState *dev, Erro=
r **errp)
>>>  {
>>>      rc4030State *s =3D RC4030(dev);
>>>      Object *o =3D OBJECT(dev);
>>> -    int i;
>>>
>>>      s->periodic_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>>>                                       rc4030_periodic_timer, s);
>>> @@ -745,37 +677,19 @@ static void rc4030_realize(DeviceState *dev, Er=
ror **errp)
>>>      memory_region_init_io(&s->iomem_jazzio, NULL, &jazzio_ops, s,
>>>                            "rc4030.jazzio", 0x00001000);
>>>
>>> -    memory_region_init_rom_device(&s->dma_tt, o,
>>> -                                  &rc4030_dma_tt_ops, s, "dma-table"=
,
>>> -                                  MAX_TL_ENTRIES * sizeof(dma_pageta=
ble_entry),
>>> -                                  NULL);
>>> -    memory_region_init(&s->dma_tt_alias, o, "dma-table-alias", 0);
>>> -    memory_region_init(&s->dma_mr, o, "dma", INT32_MAX);
>>> -    for (i =3D 0; i < MAX_TL_ENTRIES; ++i) {
>>> -        memory_region_init_alias(&s->dma_mrs[i], o, "dma-alias",
>>> -                                 get_system_memory(), 0, DMA_PAGESIZ=
E);
>>> -        memory_region_set_enabled(&s->dma_mrs[i], false);
>>> -        memory_region_add_subregion(&s->dma_mr, i * DMA_PAGESIZE,
>>> -                                    &s->dma_mrs[i]);
>>> -    }
>>> +    memory_region_init_iommu(&s->dma_mr, o, &rc4030_dma_ops,
>>> +                             "rc4030.dma", UINT32_MAX);
>>>      address_space_init(&s->dma_as, &s->dma_mr, "rc4030-dma");
>>>  }
>>>
>>>  static void rc4030_unrealize(DeviceState *dev, Error **errp)
>>>  {
>>>      rc4030State *s =3D RC4030(dev);
>>> -    int i;
>>>
>>>      timer_free(s->periodic_timer);
>>>
>>>      address_space_destroy(&s->dma_as);
>>> -    object_unparent(OBJECT(&s->dma_tt));
>>> -    object_unparent(OBJECT(&s->dma_tt_alias));
>>>      object_unparent(OBJECT(&s->dma_mr));
>>> -    for (i =3D 0; i < MAX_TL_ENTRIES; ++i) {
>>> -        memory_region_del_subregion(&s->dma_mr, &s->dma_mrs[i]);
>>> -        object_unparent(OBJECT(&s->dma_mrs[i]));
>>> -    }
>>>  }
>>>
>>>  static void rc4030_class_init(ObjectClass *klass, void *class_data)
>>>
>>
>
