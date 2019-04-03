Received: from eggs.gnu.org ([209.51.188.92]:34261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1hBgeO-0007mp-F3
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 10:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1hBgeN-0007oA-0g
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 10:14:00 -0400
References: <20190325125142.11628-1-zhengxiang9@huawei.com>
	<CAFEAcA-O5+A0Q=14k2vrBg3KNM7MmqbcyhBoZZOe=AsyE-UDbw@mail.gmail.com>
	<19929558-9f2d-148a-4357-d48b46f8b62b@huawei.com>
	<87va06kvm6.fsf@dusky.pond.sub.org>
	<59f100b4-f6e9-973d-532b-58fb172a7009@redhat.com>
	<87imw5fv45.fsf@dusky.pond.sub.org>
	<abe1d9cd-85bb-2ef8-630f-af28cae6378c@redhat.com>
	<8736n9eb4s.fsf@dusky.pond.sub.org>
From: Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <bf2decd3-b3cb-08eb-3449-b66f023b084a@huawei.com>
Date: Wed, 3 Apr 2019 22:12:39 +0800
MIME-Version: 1.0
In-Reply-To: <8736n9eb4s.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] hw/arm/virt: use variable size of
 flash device to save memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Heyi Guo <guoheyi@huawei.com>, wanghaibin.wang@huawei.com

Hi Laszlo and Markus,

Thanks for your useful suggestions and comments! :)

On 2019/3/27 2:36, Markus Armbruster wrote:
> Laszlo Ersek <lersek@redhat.com> writes:
> 
>> On 03/26/19 17:39, Markus Armbruster wrote:
>>> Laszlo Ersek <lersek@redhat.com> writes:
>>
>>>> With the dynamic sizing in QEMU (which, IIRC, I had originally
>>>> introduced still in the 1MB times, due to the split between the
>>>> executable and varstore parts), both the 1MB->2MB switch, and the
>>>> 2MB->4MB switch in the firmware caused zero pain in QEMU. And right now,
>>>> 4MB looks like a "sweet spot", with some elbow room left.
>>>
>>> Explicit configuration would've been exactly as painless.  Even with
>>> pflash sizes restricted to powers of two.
>>
>> I wrote the patch that ended up as commit 637a5acb46b3 -- with your R-b
>> -- in 2013. I'm unsure if machine type properties existed back then, but
>> even if they did, do you think I knew about them? :)
>>
>> You are right, of course; it's just that we can't tell the future.
> 
> True!  All we can do is continue to design as well as we can given the
> information, experience and resources we have, and when the inevitable
> design mistakes become apparent, limit their impact.
> 
> Some of the things we now consider mistakes we just didn't see.  Others
> we saw (e.g. multiple pflash devices, unlike physical hardware), but
> underestimated their impact.
> 

I thought about your comments and wrote the following patch (just for test)
which uses a file mapping to replace the anonymous mapping. UEFI seems to work
fine. So why not use a file mapping to read or write a pflash device?

Except this way, I don't know how to share the pflash memory among VMs or
reduce the consumption for resource. :(

---8>---

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ce2664a..12c78f2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -898,6 +898,7 @@ static void create_one_flash(const char *name, hwaddr flashbase,
     qdev_prop_set_uint16(dev, "id2", 0x00);
     qdev_prop_set_uint16(dev, "id3", 0x00);
     qdev_prop_set_string(dev, "name", name);
+    qdev_prop_set_bit(dev, "prealloc", false);
     qdev_init_nofail(dev);

     memory_region_add_subregion(sysmem, flashbase,
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 16dfae1..23a85bc 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -92,6 +92,7 @@ struct PFlashCFI01 {
     void *storage;
     VMChangeStateEntry *vmstate;
     bool old_multiple_chip_handling;
+    bool prealloc;
 };

 static int pflash_post_load(void *opaque, int version_id);
@@ -731,11 +732,21 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
     }
     device_len = sector_len_per_device * blocks_per_device;

-    memory_region_init_rom_device(
-        &pfl->mem, OBJECT(dev),
-        &pflash_cfi01_ops,
-        pfl,
-        pfl->name, total_len, &local_err);
+    if (pfl->blk && !pfl->prealloc) {
+        memory_region_init_rom_device_from_file(
+            &pfl->mem, OBJECT(dev),
+            &pflash_cfi01_ops,
+            pfl,
+            pfl->name, total_len,
+            blk_is_read_only(pfl->blk) ? RAM_SHARED : RAM_PMEM,
+            blk_bs(pfl->blk)->filename, &local_err);
+    } else {
+        memory_region_init_rom_device(
+            &pfl->mem, OBJECT(dev),
+            &pflash_cfi01_ops,
+            pfl,
+            pfl->name, total_len, &local_err);
+    }
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -899,6 +910,7 @@ static Property pflash_cfi01_properties[] = {
     DEFINE_PROP_STRING("name", PFlashCFI01, name),
     DEFINE_PROP_BOOL("old-multiple-chip-handling", PFlashCFI01,
                      old_multiple_chip_handling, false),
+    DEFINE_PROP_BOOL("prealloc", PFlashCFI01, prealloc, true),
     DEFINE_PROP_END_OF_LIST(),
 };

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 1625913..1b16d3b 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -804,6 +804,16 @@ void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
                                              uint64_t size,
                                              Error **errp);

+void memory_region_init_rom_device_from_file(MemoryRegion *mr,
+                                             struct Object *owner,
+                                             const MemoryRegionOps *ops,
+                                             void *opaque,
+                                             const char *name,
+                                             uint64_t size,
+                                             uint32_t ram_flags,
+                                             const char *path,
+                                             Error **errp);
+
 /**
  * memory_region_init_iommu: Initialize a memory region of a custom type
  * that translates addresses
diff --git a/memory.c b/memory.c
index 9fbca52..905956b 100644
--- a/memory.c
+++ b/memory.c
@@ -1719,6 +1719,36 @@ void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
     }
 }

+void memory_region_init_rom_device_from_file(MemoryRegion *mr,
+                                             Object *owner,
+                                             const MemoryRegionOps *ops,
+                                             void *opaque,
+                                             const char *name,
+                                             uint64_t size,
+                                             uint32_t ram_flags,
+                                             const char *path,
+                                             Error **errp)
+{
+    DeviceState *owner_dev;
+    Error *err = NULL;
+    assert(ops);
+    memory_region_init(mr, owner, name, size);
+    mr->ops = ops;
+    mr->opaque = opaque;
+    mr->terminates = true;
+    mr->rom_device = true;
+    mr->destructor = memory_region_destructor_ram;
+    mr->ram_block = qemu_ram_alloc_from_file(size, mr, ram_flags, path, &err);
+    if (err) {
+        mr->size = int128_zero();
+        object_unparent(OBJECT(mr));
+        error_propagate(errp, err);
+        return ;
+    }
+    owner_dev = DEVICE(owner);
+    vmstate_register_ram(mr, owner_dev);
+}
+
 void memory_region_init_iommu(void *_iommu_mr,
                               size_t instance_size,
                               const char *mrtypename,
-- 
1.8.3.1




-- 

Thanks,
Xiang
