Received: from eggs.gnu.org ([209.51.188.92]:45928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gwMrV-0003aW-Uk
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 03:04:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gwMrU-0005xu-5h
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 03:04:13 -0500
Received: from mga18.intel.com ([134.134.136.126]:4266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
	id 1gwMrT-0005vy-O6
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 03:04:12 -0500
Date: Wed, 20 Feb 2019 02:58:49 -0500
From: Zhao Yan <yan.y.zhao@intel.com>
Message-ID: <20190220075849.GE16456@joy-OptiPlex-7040>
References: <1550566254-3545-1-git-send-email-yan.y.zhao@intel.com>
	<1550566380-3788-1-git-send-email-yan.y.zhao@intel.com>
	<90191758-F4EF-4937-B721-09F7C775D2BA@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90191758-F4EF-4937-B721-09F7C775D2BA@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] vfio/migration: support device memory
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe de Dinechin <cdupontd@redhat.com>
Cc: cjia@nvidia.com, KVM list <kvm@vger.kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, yi.l.liu@intel.com, Erik Skultety <eskultet@redhat.com>, ziye.yang@intel.com, mlevitsk@redhat.com, Halil Pasic <pasic@linux.ibm.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, felipe@nutanix.com, Ken.Xue@amd.com, "Tian, Kevin" <kevin.tian@intel.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, intel-gvt-dev@lists.freedesktop.org, changpeng.liu@intel.com, Cornelia Huck <cohuck@redhat.com>, Zhi Wang <zhi.a.wang@intel.com>, jonathan.davies@nutanix.com

On Tue, Feb 19, 2019 at 03:42:36PM +0100, Christophe de Dinechin wrote:
> 
> 
> > On 19 Feb 2019, at 09:53, Yan Zhao <yan.y.zhao@intel.com> wrote:
> > 
> > If a device has device memory capability, save/load data from device memory
> > in pre-copy and stop-and-copy phases.
> > 
> > LOGGING state is set for device memory for dirty page logging:
> > in LOGGING state, get device memory returns whole device memory snapshot;
> > outside LOGGING state, get device memory returns dirty data since last get
> > operation.
> > 
> > Usually, device memory is very big, qemu needs to chunk it into several
> > pieces each with size of device memory region.
> > 
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > ---
> > hw/vfio/migration.c | 235 ++++++++++++++++++++++++++++++++++++++++++++++++++--
> > hw/vfio/pci.h       |   1 +
> > 2 files changed, 231 insertions(+), 5 deletions(-)
> > 
> > diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> > index 16d6395..f1e9309 100644
> > --- a/hw/vfio/migration.c
> > +++ b/hw/vfio/migration.c
> > @@ -203,6 +203,201 @@ static int vfio_load_data_device_config(VFIOPCIDevice *vdev,
> >     return 0;
> > }
> > 
> > +static int vfio_get_device_memory_size(VFIOPCIDevice *vdev)
> > +{
> > +    VFIODevice *vbasedev = &vdev->vbasedev;
> > +    VFIORegion *region_ctl =
> > +        &vdev->migration->region[VFIO_DEVSTATE_REGION_CTL];
> > +    uint64_t len;
> > +    int sz;
> > +
> > +    sz = sizeof(len);
> > +    if (pread(vbasedev->fd, &len, sz,
> > +                region_ctl->fd_offset +
> > +                offsetof(struct vfio_device_state_ctl, device_memory.size))
> > +            != sz) {
> > +        error_report("vfio: Failed to get length of device memory”);
> 
> s/length/size/ ? (to be consistent with function name)

ok. thanks
> > +        return -1;
> > +    }
> > +    vdev->migration->devmem_size = len;
> > +    return 0;
> > +}
> > +
> > +static int vfio_set_device_memory_size(VFIOPCIDevice *vdev, uint64_t size)
> > +{
> > +    VFIODevice *vbasedev = &vdev->vbasedev;
> > +    VFIORegion *region_ctl =
> > +        &vdev->migration->region[VFIO_DEVSTATE_REGION_CTL];
> > +    int sz;
> > +
> > +    sz = sizeof(size);
> > +    if (pwrite(vbasedev->fd, &size, sz,
> > +                region_ctl->fd_offset +
> > +                offsetof(struct vfio_device_state_ctl, device_memory.size))
> > +            != sz) {
> > +        error_report("vfio: Failed to set length of device comemory”);
> 
> What is comemory? Typo?

Right, typo. should be "memory" :)
> 
> Same comment about length vs size
>
got it. thanks

> > +        return -1;
> > +    }
> > +    vdev->migration->devmem_size = size;
> > +    return 0;
> > +}
> > +
> > +static
> > +int vfio_save_data_device_memory_chunk(VFIOPCIDevice *vdev, QEMUFile *f,
> > +                                    uint64_t pos, uint64_t len)
> > +{
> > +    VFIODevice *vbasedev = &vdev->vbasedev;
> > +    VFIORegion *region_ctl =
> > +        &vdev->migration->region[VFIO_DEVSTATE_REGION_CTL];
> > +    VFIORegion *region_devmem =
> > +        &vdev->migration->region[VFIO_DEVSTATE_REGION_DATA_DEVICE_MEMORY];
> > +    void *dest;
> > +    uint32_t sz;
> > +    uint8_t *buf = NULL;
> > +    uint32_t action = VFIO_DEVICE_DATA_ACTION_GET_BUFFER;
> > +
> > +    if (len > region_devmem->size) {
> 
> Is it intentional that there is no error_report here?
>
an error_report here may be better.
> > +        return -1;
> > +    }
> > +
> > +    sz = sizeof(pos);
> > +    if (pwrite(vbasedev->fd, &pos, sz,
> > +                region_ctl->fd_offset +
> > +                offsetof(struct vfio_device_state_ctl, device_memory.pos))
> > +            != sz) {
> > +        error_report("vfio: Failed to set save buffer pos");
> > +        return -1;
> > +    }
> > +    sz = sizeof(action);
> > +    if (pwrite(vbasedev->fd, &action, sz,
> > +                region_ctl->fd_offset +
> > +                offsetof(struct vfio_device_state_ctl, device_memory.action))
> > +            != sz) {
> > +        error_report("vfio: Failed to set save buffer action");
> > +        return -1;
> > +    }
> > +
> > +    if (!vfio_device_state_region_mmaped(region_devmem)) {
> > +        buf = g_malloc(len);
> > +        if (buf == NULL) {
> > +            error_report("vfio: Failed to allocate memory for migrate”);
> s/migrate/migration/ ?

yes, thanks
> > +            return -1;
> > +        }
> > +        if (pread(vbasedev->fd, buf, len, region_devmem->fd_offset) != len) {
> > +            error_report("vfio: error load device memory buffer”);
> s/load/loading/ ?
error to load? :)

> > +            return -1;
> > +        }
> > +        qemu_put_be64(f, len);
> > +        qemu_put_be64(f, pos);
> > +        qemu_put_buffer(f, buf, len);
> > +        g_free(buf);
> > +    } else {
> > +        dest = region_devmem->mmaps[0].mmap;
> > +        qemu_put_be64(f, len);
> > +        qemu_put_be64(f, pos);
> > +        qemu_put_buffer(f, dest, len);
> > +    }
> > +    return 0;
> > +}
> > +
> > +static int vfio_save_data_device_memory(VFIOPCIDevice *vdev, QEMUFile *f)
> > +{
> > +    VFIORegion *region_devmem =
> > +        &vdev->migration->region[VFIO_DEVSTATE_REGION_DATA_DEVICE_MEMORY];
> > +    uint64_t total_len = vdev->migration->devmem_size;
> > +    uint64_t pos = 0;
> > +
> > +    qemu_put_be64(f, total_len);
> > +    while (pos < total_len) {
> > +        uint64_t len = region_devmem->size;
> > +
> > +        if (pos + len >= total_len) {
> > +            len = total_len - pos;
> > +        }
> > +        if (vfio_save_data_device_memory_chunk(vdev, f, pos, len)) {
> > +            return -1;
> > +        }
> 
> I don’t see where pos is incremented in this loop
> 
yes, missing one line "pos += len;"
Currently, code is not verified in hardware with device memory cap on.
Thanks:)
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static
> > +int vfio_load_data_device_memory_chunk(VFIOPCIDevice *vdev, QEMUFile *f,
> > +                                uint64_t pos, uint64_t len)
> > +{
> > +    VFIODevice *vbasedev = &vdev->vbasedev;
> > +    VFIORegion *region_ctl =
> > +        &vdev->migration->region[VFIO_DEVSTATE_REGION_CTL];
> > +    VFIORegion *region_devmem =
> > +        &vdev->migration->region[VFIO_DEVSTATE_REGION_DATA_DEVICE_MEMORY];
> > +
> > +    void *dest;
> > +    uint32_t sz;
> > +    uint8_t *buf = NULL;
> > +    uint32_t action = VFIO_DEVICE_DATA_ACTION_SET_BUFFER;
> > +
> > +    if (len > region_devmem->size) {
> 
> error_report?

seems better to add error_report.
> > +        return -1;
> > +    }
> > +
> > +    sz = sizeof(pos);
> > +    if (pwrite(vbasedev->fd, &pos, sz,
> > +                region_ctl->fd_offset +
> > +                offsetof(struct vfio_device_state_ctl, device_memory.pos))
> > +            != sz) {
> > +        error_report("vfio: Failed to set device memory buffer pos");
> > +        return -1;
> > +    }
> > +    if (!vfio_device_state_region_mmaped(region_devmem)) {
> > +        buf = g_malloc(len);
> > +        if (buf == NULL) {
> > +            error_report("vfio: Failed to allocate memory for migrate");
> > +            return -1;
> > +        }
> > +        qemu_get_buffer(f, buf, len);
> > +        if (pwrite(vbasedev->fd, buf, len,
> > +                    region_devmem->fd_offset) != len) {
> > +            error_report("vfio: Failed to load devie memory buffer");
> > +            return -1;
> > +        }
> > +        g_free(buf);
> > +    } else {
> > +        dest = region_devmem->mmaps[0].mmap;
> > +        qemu_get_buffer(f, dest, len);
> > +    }
> > +
> > +    sz = sizeof(action);
> > +    if (pwrite(vbasedev->fd, &action, sz,
> > +                region_ctl->fd_offset +
> > +                offsetof(struct vfio_device_state_ctl, device_memory.action))
> > +            != sz) {
> > +        error_report("vfio: Failed to set load device memory buffer action");
> > +        return -1;
> > +    }
> > +
> > +    return 0;
> > +
> > +}
> > +
> > +static int vfio_load_data_device_memory(VFIOPCIDevice *vdev,
> > +                        QEMUFile *f, uint64_t total_len)
> > +{
> > +    uint64_t pos = 0, len = 0;
> > +
> > +    vfio_set_device_memory_size(vdev, total_len);
> > +
> > +    while (pos + len < total_len) {
> > +        len = qemu_get_be64(f);
> > +        pos = qemu_get_be64(f);
> 
> Nit: load reads len/pos in the loop, whereas save does it in the
> inner function (vfio_save_data_device_memory_chunk)
right, load has to read len/pos in the loop.
> 
> > +
> > +        vfio_load_data_device_memory_chunk(vdev, f, pos, len);
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +
> > static int vfio_set_dirty_page_bitmap_chunk(VFIOPCIDevice *vdev,
> >         uint64_t start_addr, uint64_t page_nr)
> > {
> > @@ -377,6 +572,10 @@ static void vfio_save_live_pending(QEMUFile *f, void *opaque,
> >         return;
> >     }
> > 
> > +    /* get dirty data size of device memory */
> > +    vfio_get_device_memory_size(vdev);
> > +
> > +    *res_precopy_only += vdev->migration->devmem_size;
> >     return;
> > }
> > 
> > @@ -388,7 +587,9 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
> >         return 0;
> >     }
> > 
> > -    return 0;
> > +    qemu_put_byte(f, VFIO_SAVE_FLAG_DEVMEMORY);
> > +    /* get dirty data of device memory */
> > +    return vfio_save_data_device_memory(vdev, f);
> > }
> > 
> > static void vfio_pci_load_config(VFIOPCIDevice *vdev, QEMUFile *f)
> > @@ -458,6 +659,10 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
> >             len = qemu_get_be64(f);
> >             vfio_load_data_device_config(vdev, f, len);
> >             break;
> > +        case VFIO_SAVE_FLAG_DEVMEMORY:
> > +            len = qemu_get_be64(f);
> > +            vfio_load_data_device_memory(vdev, f, len);
> > +            break;
> >         default:
> >             ret = -EINVAL;
> >         }
> > @@ -503,6 +708,13 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
> >     VFIOPCIDevice *vdev = opaque;
> >     int rc = 0;
> > 
> > +    if (vfio_device_data_cap_device_memory(vdev)) {
> > +        qemu_put_byte(f, VFIO_SAVE_FLAG_DEVMEMORY | VFIO_SAVE_FLAG_CONTINUE);
> > +        /* get dirty data of device memory */
> > +        vfio_get_device_memory_size(vdev);
> > +        rc = vfio_save_data_device_memory(vdev, f);
> > +    }
> > +
> >     qemu_put_byte(f, VFIO_SAVE_FLAG_PCI | VFIO_SAVE_FLAG_CONTINUE);
> >     vfio_pci_save_config(vdev, f);
> > 
> > @@ -515,12 +727,22 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
> > 
> > static int vfio_save_setup(QEMUFile *f, void *opaque)
> > {
> > +    int rc = 0;
> >     VFIOPCIDevice *vdev = opaque;
> > -    qemu_put_byte(f, VFIO_SAVE_FLAG_SETUP);
> > +
> > +    if (vfio_device_data_cap_device_memory(vdev)) {
> > +        qemu_put_byte(f, VFIO_SAVE_FLAG_SETUP | VFIO_SAVE_FLAG_CONTINUE);
> > +        qemu_put_byte(f, VFIO_SAVE_FLAG_DEVMEMORY);
> > +        /* get whole snapshot of device memory */
> > +        vfio_get_device_memory_size(vdev);
> > +        rc = vfio_save_data_device_memory(vdev, f);
> > +    } else {
> > +        qemu_put_byte(f, VFIO_SAVE_FLAG_SETUP);
> > +    }
> > 
> >     vfio_set_device_state(vdev, VFIO_DEVICE_STATE_RUNNING |
> >             VFIO_DEVICE_STATE_LOGGING);
> > -    return 0;
> > +    return rc;
> > }
> > 
> > static int vfio_load_setup(QEMUFile *f, void *opaque)
> > @@ -576,8 +798,11 @@ int vfio_migration_init(VFIOPCIDevice *vdev, Error **errp)
> >         goto error;
> >     }
> > 
> > -    if (vfio_device_data_cap_device_memory(vdev)) {
> > -        error_report("No suppport of data cap device memory Yet");
> > +    if (vfio_device_data_cap_device_memory(vdev) &&
> > +            vfio_device_state_region_setup(vdev,
> > +              &vdev->migration->region[VFIO_DEVSTATE_REGION_DATA_DEVICE_MEMORY],
> > +              VFIO_REGION_SUBTYPE_DEVICE_STATE_DATA_MEMORY,
> > +              "device-state-data-device-memory")) {
> >         goto error;
> >     }
> > 
> > diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> > index 4b7b1bb..a2cc64b 100644
> > --- a/hw/vfio/pci.h
> > +++ b/hw/vfio/pci.h
> > @@ -69,6 +69,7 @@ typedef struct VFIOMigration {
> >     uint32_t data_caps;
> >     uint32_t device_state;
> >     uint64_t devconfig_size;
> > +    uint64_t devmem_size;
> >     VMChangeStateEntry *vm_state;
> > } VFIOMigration;
> > 
> > -- 
> > 2.7.4
> > 
> > _______________________________________________
> > intel-gvt-dev mailing list
> > intel-gvt-dev@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev
> 
> _______________________________________________
> intel-gvt-dev mailing list
> intel-gvt-dev@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev
