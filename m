Received: from eggs.gnu.org ([209.51.188.92]:36649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ggush-0000s7-Py
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:09:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ggusW-00014K-2z
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:09:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ggusQ-0000pu-0U
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:09:19 -0500
Date: Tue, 8 Jan 2019 10:09:11 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190108100911.6e089f8c@x1.home>
In-Reply-To: <20190108060348.3359-2-yan.y.zhao@intel.com>
References: <20190108060348.3359-1-yan.y.zhao@intel.com>
	<20190108060348.3359-2-yan.y.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: Zhao Yan <yan.y.zhao@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Tue,  8 Jan 2019 01:03:48 -0500
Zhao Yan <yan.y.zhao@intel.com> wrote:

> if multiple regions in vfio are mmaped, their corresponding ramblocks
> are like below, i.e. their idstrs are "".
>=20
> (qemu) info ramblock
> Block Name  PSize       Offset               Used            Total
> pc.ram      4 KiB  0x0000000000000000 0x0000000020000000 0x00000000200000=
00
>             4 KiB  0x0000000021100000 0x0000000020000000 0x00000000200000=
00
>             4 KiB  0x0000000020900000 0x0000000000800000 0x00000000008000=
00
>             4 KiB  0x0000000020240000 0x0000000000687000 0x00000000006870=
00
>             4 KiB  0x00000000200c0000 0x0000000000178000 0x00000000001780=
00
> pc.bios     4 KiB  0x0000000020000000 0x0000000000040000 0x00000000000400=
00
> pc.rom      4 KiB  0x0000000020040000 0x0000000000020000 0x00000000000200=
00
>=20
> This is because ramblocks' idstr are assigned by calling
> vmstate_register_ram(), but memory region of type ram device ptr does not
> call vmstate_register_ram().
> vfio_region_mmap
>         |->memory_region_init_ram_device_ptr
>                |-> memory_region_init_ram_ptr
>=20
> Without empty idstrs will cause problem to snapshot copying during
> migration, because it uses ramblocks' idstr to identify ramblocks.
> ram_save_setup {
>   =E2=80=A6
>   RAMBLOCK_FOREACH(block) {
>       qemu_put_byte(f, strlen(block->idstr));
>       qemu_put_buffer(f, (uint8_t *)block->idstr,strlen(block->idstr));
>       qemu_put_be64(f, block->used_length);
>   }
>   =E2=80=A6
> }
> ram_load() {
>     block =3D qemu_ram_block_by_name(id);
>     if (block) {
>         if (length !=3D block->used_length) {
>             qemu_ram_resize(block, length, &local_err);
>         }
>      =E2=80=A6.
>    }
> }
>=20
> Therefore, in this patch,
> vmstate_register_ram() is called for memory region of type ram ptr,
> also a unique vfioid is assigned to vfio devices across source
> and target vms.
> e.g. in source vm, use qemu parameter
> -device
> vfio-pci,sysfsdev=3D/sys/bus/pci/devices/0000:00:02.0/
> 882cc4da-dede-11e7-9180-078a62063ab1,vfioid=3Digd
>=20
> and in target vm, use qemu paramter
> -device
> vfio-pci,sysfsdev=3D/sys/bus/pci/devices/0000:00:02.0/
> 5ac1fb20-2bbf-4842-bb7e-36c58c3be9cd,vfioid=3Digd

Why wouldn't we just use the id=3D (DeviceState.id) value instead of
adding yet another one?  I can't imagine anyone, especially libvirt,
wants to deal with a vfio specific id for a device.

> Signed-off-by: Zhao Yan <yan.y.zhao@intel.com>
> ---
>  hw/vfio/pci.c                 | 8 +++++++-
>  include/hw/vfio/vfio-common.h | 1 +
>  memory.c                      | 4 ++++
>  3 files changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c0cb1ec289..7bc2ed0752 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2533,7 +2533,12 @@ static void vfio_populate_device(VFIOPCIDevice *vd=
ev, Error **errp)
>      }
> =20
>      for (i =3D VFIO_PCI_BAR0_REGION_INDEX; i < VFIO_PCI_ROM_REGION_INDEX=
; i++) {
> -        char *name =3D g_strdup_printf("%s BAR %d", vbasedev->name, i);
> +        char *name;
> +        if (vbasedev->vfioid) {
> +            name =3D g_strdup_printf("%s BAR %d", vbasedev->vfioid, i);
> +        } else {
> +            name =3D g_strdup_printf("%s BAR %d", vbasedev->name, i);
> +        }
> =20
>          ret =3D vfio_region_setup(OBJECT(vdev), vbasedev,
>                                  &vdev->bars[i].region, i, name);
> @@ -3180,6 +3185,7 @@ static void vfio_instance_init(Object *obj)
>  static Property vfio_pci_dev_properties[] =3D {
>      DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
>      DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
> +    DEFINE_PROP_STRING("vfioid", VFIOPCIDevice, vbasedev.vfioid),
>      DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
>                              display, ON_OFF_AUTO_OFF),
>      DEFINE_PROP_UINT32("x-intx-mmap-timeout-ms", VFIOPCIDevice,
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 1b434d02f6..84bab94f52 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -108,6 +108,7 @@ typedef struct VFIODevice {
>      struct VFIOGroup *group;
>      char *sysfsdev;
>      char *name;
> +    char *vfioid;
>      DeviceState *dev;
>      int fd;
>      int type;
> diff --git a/memory.c b/memory.c
> index d14c6dec1d..dbb29fa989 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1588,6 +1588,7 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
>                                  uint64_t size,
>                                  void *ptr)
>  {
> +    DeviceState *owner_dev;
>      memory_region_init(mr, owner, name, size);
>      mr->ram =3D true;
>      mr->terminates =3D true;
> @@ -1597,6 +1598,9 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
>      /* qemu_ram_alloc_from_ptr cannot fail with ptr !=3D NULL.  */
>      assert(ptr !=3D NULL);
>      mr->ram_block =3D qemu_ram_alloc_from_ptr(size, ptr, mr, &error_fata=
l);
> +
> +    owner_dev =3D DEVICE(owner);
> +    vmstate_register_ram(mr, owner_dev);

Where does the corresponding vmstate_unregister_ram() call occur when
unplugged?  Thanks,

Alex

>  }
> =20
>  void memory_region_init_ram_device_ptr(MemoryRegion *mr,
