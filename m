Received: from eggs.gnu.org ([209.51.188.92]:49287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1ghP4r-0005Ze-Qo
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 20:24:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1ghP4q-00043w-MI
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 20:24:09 -0500
Received: from mga17.intel.com ([192.55.52.151]:5351)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
	id 1ghP4q-0003u2-Bd
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 20:24:08 -0500
Date: Wed, 9 Jan 2019 20:19:22 -0500
From: Zhao Yan <yan.y.zhao@intel.com>
Message-ID: <20190110011922.GA10707@joy-OptiPlex-7040>
References: <20190108060348.3359-1-yan.y.zhao@intel.com>
	<20190108060348.3359-2-yan.y.zhao@intel.com>
	<20190108100911.6e089f8c@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190108100911.6e089f8c@x1.home>
Subject: Re: [Qemu-devel] [PATCH] vfio: assign idstr for VFIO's mmaped
 regions for migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Tue, Jan 08, 2019 at 10:09:11AM -0700, Alex Williamson wrote:
> On Tue,  8 Jan 2019 01:03:48 -0500
> Zhao Yan <yan.y.zhao@intel.com> wrote:
> 
> > if multiple regions in vfio are mmaped, their corresponding ramblocks
> > are like below, i.e. their idstrs are "".
> > 
> > (qemu) info ramblock
> > Block Name  PSize       Offset               Used            Total
> > pc.ram      4 KiB  0x0000000000000000 0x0000000020000000 0x0000000020000000
> >             4 KiB  0x0000000021100000 0x0000000020000000 0x0000000020000000
> >             4 KiB  0x0000000020900000 0x0000000000800000 0x0000000000800000
> >             4 KiB  0x0000000020240000 0x0000000000687000 0x0000000000687000
> >             4 KiB  0x00000000200c0000 0x0000000000178000 0x0000000000178000
> > pc.bios     4 KiB  0x0000000020000000 0x0000000000040000 0x0000000000040000
> > pc.rom      4 KiB  0x0000000020040000 0x0000000000020000 0x0000000000020000
> > 
> > This is because ramblocks' idstr are assigned by calling
> > vmstate_register_ram(), but memory region of type ram device ptr does not
> > call vmstate_register_ram().
> > vfio_region_mmap
> >         |->memory_region_init_ram_device_ptr
> >                |-> memory_region_init_ram_ptr
> > 
> > Without empty idstrs will cause problem to snapshot copying during
> > migration, because it uses ramblocks' idstr to identify ramblocks.
> > ram_save_setup {
> >   …
> >   RAMBLOCK_FOREACH(block) {
> >       qemu_put_byte(f, strlen(block->idstr));
> >       qemu_put_buffer(f, (uint8_t *)block->idstr,strlen(block->idstr));
> >       qemu_put_be64(f, block->used_length);
> >   }
> >   …
> > }
> > ram_load() {
> >     block = qemu_ram_block_by_name(id);
> >     if (block) {
> >         if (length != block->used_length) {
> >             qemu_ram_resize(block, length, &local_err);
> >         }
> >      ….
> >    }
> > }
> > 
> > Therefore, in this patch,
> > vmstate_register_ram() is called for memory region of type ram ptr,
> > also a unique vfioid is assigned to vfio devices across source
> > and target vms.
> > e.g. in source vm, use qemu parameter
> > -device
> > vfio-pci,sysfsdev=/sys/bus/pci/devices/0000:00:02.0/
> > 882cc4da-dede-11e7-9180-078a62063ab1,vfioid=igd
> > 
> > and in target vm, use qemu paramter
> > -device
> > vfio-pci,sysfsdev=/sys/bus/pci/devices/0000:00:02.0/
> > 5ac1fb20-2bbf-4842-bb7e-36c58c3be9cd,vfioid=igd
> 
> Why wouldn't we just use the id= (DeviceState.id) value instead of
> adding yet another one?  I can't imagine anyone, especially libvirt,
> wants to deal with a vfio specific id for a device.
>
hi Alex
You are right! DeviceState.id can be used here. Thanks for your suggestion.


> > Signed-off-by: Zhao Yan <yan.y.zhao@intel.com>
> > ---
> >  hw/vfio/pci.c                 | 8 +++++++-
> >  include/hw/vfio/vfio-common.h | 1 +
> >  memory.c                      | 4 ++++
> >  3 files changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index c0cb1ec289..7bc2ed0752 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -2533,7 +2533,12 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
> >      }
> >  
> >      for (i = VFIO_PCI_BAR0_REGION_INDEX; i < VFIO_PCI_ROM_REGION_INDEX; i++) {
> > -        char *name = g_strdup_printf("%s BAR %d", vbasedev->name, i);
> > +        char *name;
> > +        if (vbasedev->vfioid) {
> > +            name = g_strdup_printf("%s BAR %d", vbasedev->vfioid, i);
> > +        } else {
> > +            name = g_strdup_printf("%s BAR %d", vbasedev->name, i);
> > +        }
> >  
> >          ret = vfio_region_setup(OBJECT(vdev), vbasedev,
> >                                  &vdev->bars[i].region, i, name);
> > @@ -3180,6 +3185,7 @@ static void vfio_instance_init(Object *obj)
> >  static Property vfio_pci_dev_properties[] = {
> >      DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
> >      DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
> > +    DEFINE_PROP_STRING("vfioid", VFIOPCIDevice, vbasedev.vfioid),
> >      DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
> >                              display, ON_OFF_AUTO_OFF),
> >      DEFINE_PROP_UINT32("x-intx-mmap-timeout-ms", VFIOPCIDevice,
> > diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> > index 1b434d02f6..84bab94f52 100644
> > --- a/include/hw/vfio/vfio-common.h
> > +++ b/include/hw/vfio/vfio-common.h
> > @@ -108,6 +108,7 @@ typedef struct VFIODevice {
> >      struct VFIOGroup *group;
> >      char *sysfsdev;
> >      char *name;
> > +    char *vfioid;
> >      DeviceState *dev;
> >      int fd;
> >      int type;
> > diff --git a/memory.c b/memory.c
> > index d14c6dec1d..dbb29fa989 100644
> > --- a/memory.c
> > +++ b/memory.c
> > @@ -1588,6 +1588,7 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
> >                                  uint64_t size,
> >                                  void *ptr)
> >  {
> > +    DeviceState *owner_dev;
> >      memory_region_init(mr, owner, name, size);
> >      mr->ram = true;
> >      mr->terminates = true;
> > @@ -1597,6 +1598,9 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
> >      /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
> >      assert(ptr != NULL);
> >      mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_fatal);
> > +
> > +    owner_dev = DEVICE(owner);
> > +    vmstate_register_ram(mr, owner_dev);
> 
> Where does the corresponding vmstate_unregister_ram() call occur when
> unplugged?  Thanks,
>
sorry, I just updated my qemu code base and found that in migration/ram.c
now it will not save/restore ramblocks who do not call
vmstate_regitser_ram().
therefore, the vmstate_register_ram() may not be necessary for memory
region mapped to device resources, as it's better to save/restore that part
of memory from vendor driver side.
So, do you think it's ok to just call qemu_ram_set_idstr() to set idstr for
ramblocks of mmaped region?

Thanks
Yan

> Alex
> 
> >  }
> >  
> >  void memory_region_init_ram_device_ptr(MemoryRegion *mr,
> 
