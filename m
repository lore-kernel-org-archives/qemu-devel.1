Received: from eggs.gnu.org ([209.51.188.92]:42617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cdupontd@redhat.com>) id 1gwOtb-0003gL-P1
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:14:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cdupontd@redhat.com>) id 1gwOta-0000HB-09
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:14:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cdupontd@redhat.com>) id 1gwOtZ-0000GV-Nv
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:14:29 -0500
Received: by mail-wm1-f68.google.com with SMTP id q187so5998409wme.5
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 02:14:28 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
From: Christophe de Dinechin <cdupontd@redhat.com>
In-Reply-To: <20190220075849.GE16456@joy-OptiPlex-7040>
Date: Wed, 20 Feb 2019 11:14:24 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <84DDB595-B107-414A-A69E-627C0B07D0B8@redhat.com>
References: <1550566254-3545-1-git-send-email-yan.y.zhao@intel.com>
	<1550566380-3788-1-git-send-email-yan.y.zhao@intel.com>
	<90191758-F4EF-4937-B721-09F7C775D2BA@redhat.com>
	<20190220075849.GE16456@joy-OptiPlex-7040>
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
To: Zhao Yan <yan.y.zhao@intel.com>
Cc: cjia@nvidia.com, KVM list <kvm@vger.kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, yi.l.liu@intel.com, Erik Skultety <eskultet@redhat.com>, ziye.yang@intel.com, mlevitsk@redhat.com, Halil Pasic <pasic@linux.ibm.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, felipe@nutanix.com, Ken.Xue@amd.com, "Tian, Kevin" <kevin.tian@intel.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, intel-gvt-dev@lists.freedesktop.org, changpeng.liu@intel.com, Cornelia Huck <cohuck@redhat.com>, Zhi Wang <zhi.a.wang@intel.com>, jonathan.davies@nutanix.com



> On 20 Feb 2019, at 08:58, Zhao Yan <yan.y.zhao@intel.com> wrote:
>=20
> On Tue, Feb 19, 2019 at 03:42:36PM +0100, Christophe de Dinechin =
wrote:
>>=20
>>=20
>>> On 19 Feb 2019, at 09:53, Yan Zhao <yan.y.zhao@intel.com> wrote:
>>>=20
>>> If a device has device memory capability, save/load data from device =
memory
>>> in pre-copy and stop-and-copy phases.
>>>=20
>>> LOGGING state is set for device memory for dirty page logging:
>>> in LOGGING state, get device memory returns whole device memory =
snapshot;
>>> outside LOGGING state, get device memory returns dirty data since =
last get
>>> operation.
>>>=20
>>> Usually, device memory is very big, qemu needs to chunk it into =
several
>>> pieces each with size of device memory region.
>>>=20
>>> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
>>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>>> ---
>>> hw/vfio/migration.c | 235 =
++++++++++++++++++++++++++++++++++++++++++++++++++--
>>> hw/vfio/pci.h       |   1 +
>>> 2 files changed, 231 insertions(+), 5 deletions(-)
>>>=20
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index 16d6395..f1e9309 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -203,6 +203,201 @@ static int =
vfio_load_data_device_config(VFIOPCIDevice *vdev,
>>>    return 0;
>>> }
>>>=20
>>> +static int vfio_get_device_memory_size(VFIOPCIDevice *vdev)
>>> +{
>>> +    VFIODevice *vbasedev =3D &vdev->vbasedev;
>>> +    VFIORegion *region_ctl =3D
>>> +        &vdev->migration->region[VFIO_DEVSTATE_REGION_CTL];
>>> +    uint64_t len;
>>> +    int sz;
>>> +
>>> +    sz =3D sizeof(len);
>>> +    if (pread(vbasedev->fd, &len, sz,
>>> +                region_ctl->fd_offset +
>>> +                offsetof(struct vfio_device_state_ctl, =
device_memory.size))
>>> +            !=3D sz) {
>>> +        error_report("vfio: Failed to get length of device =
memory=E2=80=9D);
>>=20
>> s/length/size/ ? (to be consistent with function name)
>=20
> ok. thanks
>>> +        return -1;
>>> +    }
>>> +    vdev->migration->devmem_size =3D len;
>>> +    return 0;
>>> +}
>>> +
>>> +static int vfio_set_device_memory_size(VFIOPCIDevice *vdev, =
uint64_t size)
>>> +{
>>> +    VFIODevice *vbasedev =3D &vdev->vbasedev;
>>> +    VFIORegion *region_ctl =3D
>>> +        &vdev->migration->region[VFIO_DEVSTATE_REGION_CTL];
>>> +    int sz;
>>> +
>>> +    sz =3D sizeof(size);
>>> +    if (pwrite(vbasedev->fd, &size, sz,
>>> +                region_ctl->fd_offset +
>>> +                offsetof(struct vfio_device_state_ctl, =
device_memory.size))
>>> +            !=3D sz) {
>>> +        error_report("vfio: Failed to set length of device =
comemory=E2=80=9D);
>>=20
>> What is comemory? Typo?
>=20
> Right, typo. should be "memory" :)
>>=20
>> Same comment about length vs size
>>=20
> got it. thanks
>=20
>>> +        return -1;
>>> +    }
>>> +    vdev->migration->devmem_size =3D size;
>>> +    return 0;
>>> +}
>>> +
>>> +static
>>> +int vfio_save_data_device_memory_chunk(VFIOPCIDevice *vdev, =
QEMUFile *f,
>>> +                                    uint64_t pos, uint64_t len)
>>> +{
>>> +    VFIODevice *vbasedev =3D &vdev->vbasedev;
>>> +    VFIORegion *region_ctl =3D
>>> +        &vdev->migration->region[VFIO_DEVSTATE_REGION_CTL];
>>> +    VFIORegion *region_devmem =3D
>>> +        =
&vdev->migration->region[VFIO_DEVSTATE_REGION_DATA_DEVICE_MEMORY];
>>> +    void *dest;
>>> +    uint32_t sz;
>>> +    uint8_t *buf =3D NULL;
>>> +    uint32_t action =3D VFIO_DEVICE_DATA_ACTION_GET_BUFFER;
>>> +
>>> +    if (len > region_devmem->size) {
>>=20
>> Is it intentional that there is no error_report here?
>>=20
> an error_report here may be better.
>>> +        return -1;
>>> +    }
>>> +
>>> +    sz =3D sizeof(pos);
>>> +    if (pwrite(vbasedev->fd, &pos, sz,
>>> +                region_ctl->fd_offset +
>>> +                offsetof(struct vfio_device_state_ctl, =
device_memory.pos))
>>> +            !=3D sz) {
>>> +        error_report("vfio: Failed to set save buffer pos");
>>> +        return -1;
>>> +    }
>>> +    sz =3D sizeof(action);
>>> +    if (pwrite(vbasedev->fd, &action, sz,
>>> +                region_ctl->fd_offset +
>>> +                offsetof(struct vfio_device_state_ctl, =
device_memory.action))
>>> +            !=3D sz) {
>>> +        error_report("vfio: Failed to set save buffer action");
>>> +        return -1;
>>> +    }
>>> +
>>> +    if (!vfio_device_state_region_mmaped(region_devmem)) {
>>> +        buf =3D g_malloc(len);
>>> +        if (buf =3D=3D NULL) {
>>> +            error_report("vfio: Failed to allocate memory for =
migrate=E2=80=9D);
>> s/migrate/migration/ ?
>=20
> yes, thanks
>>> +            return -1;
>>> +        }
>>> +        if (pread(vbasedev->fd, buf, len, region_devmem->fd_offset) =
!=3D len) {
>>> +            error_report("vfio: error load device memory =
buffer=E2=80=9D);
>> s/load/loading/ ?
> error to load? :)

I=E2=80=99d check with a native speaker, but I believe it=E2=80=99s =
=E2=80=9Cerror loading=E2=80=9D.

To me (to be checked), the two sentences don=E2=80=99t have the same =
meaning:

=E2=80=9CIt is an error to load device memory buffer=E2=80=9D -> =E2=80=9C=
You are not allowed to do that=E2=80=9D
=E2=80=9CI had an error loading device memory buffer=E2=80=9D -> =E2=80=9C=
I tried, but it failed"

>=20
>>> +            return -1;
>>> +        }
>>> +        qemu_put_be64(f, len);
>>> +        qemu_put_be64(f, pos);
>>> +        qemu_put_buffer(f, buf, len);
>>> +        g_free(buf);
>>> +    } else {
>>> +        dest =3D region_devmem->mmaps[0].mmap;
>>> +        qemu_put_be64(f, len);
>>> +        qemu_put_be64(f, pos);
>>> +        qemu_put_buffer(f, dest, len);
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>> +static int vfio_save_data_device_memory(VFIOPCIDevice *vdev, =
QEMUFile *f)
>>> +{
>>> +    VFIORegion *region_devmem =3D
>>> +        =
&vdev->migration->region[VFIO_DEVSTATE_REGION_DATA_DEVICE_MEMORY];
>>> +    uint64_t total_len =3D vdev->migration->devmem_size;
>>> +    uint64_t pos =3D 0;
>>> +
>>> +    qemu_put_be64(f, total_len);
>>> +    while (pos < total_len) {
>>> +        uint64_t len =3D region_devmem->size;
>>> +
>>> +        if (pos + len >=3D total_len) {
>>> +            len =3D total_len - pos;
>>> +        }
>>> +        if (vfio_save_data_device_memory_chunk(vdev, f, pos, len)) =
{
>>> +            return -1;
>>> +        }
>>=20
>> I don=E2=80=99t see where pos is incremented in this loop
>>=20
> yes, missing one line "pos +=3D len;"
> Currently, code is not verified in hardware with device memory cap on.
> Thanks:)
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static
>>> +int vfio_load_data_device_memory_chunk(VFIOPCIDevice *vdev, =
QEMUFile *f,
>>> +                                uint64_t pos, uint64_t len)
>>> +{
>>> +    VFIODevice *vbasedev =3D &vdev->vbasedev;
>>> +    VFIORegion *region_ctl =3D
>>> +        &vdev->migration->region[VFIO_DEVSTATE_REGION_CTL];
>>> +    VFIORegion *region_devmem =3D
>>> +        =
&vdev->migration->region[VFIO_DEVSTATE_REGION_DATA_DEVICE_MEMORY];
>>> +
>>> +    void *dest;
>>> +    uint32_t sz;
>>> +    uint8_t *buf =3D NULL;
>>> +    uint32_t action =3D VFIO_DEVICE_DATA_ACTION_SET_BUFFER;
>>> +
>>> +    if (len > region_devmem->size) {
>>=20
>> error_report?
>=20
> seems better to add error_report.
>>> +        return -1;
>>> +    }
>>> +
>>> +    sz =3D sizeof(pos);
>>> +    if (pwrite(vbasedev->fd, &pos, sz,
>>> +                region_ctl->fd_offset +
>>> +                offsetof(struct vfio_device_state_ctl, =
device_memory.pos))
>>> +            !=3D sz) {
>>> +        error_report("vfio: Failed to set device memory buffer =
pos");
>>> +        return -1;
>>> +    }
>>> +    if (!vfio_device_state_region_mmaped(region_devmem)) {
>>> +        buf =3D g_malloc(len);
>>> +        if (buf =3D=3D NULL) {
>>> +            error_report("vfio: Failed to allocate memory for =
migrate");
>>> +            return -1;
>>> +        }
>>> +        qemu_get_buffer(f, buf, len);
>>> +        if (pwrite(vbasedev->fd, buf, len,
>>> +                    region_devmem->fd_offset) !=3D len) {
>>> +            error_report("vfio: Failed to load devie memory =
buffer");
>>> +            return -1;
>>> +        }
>>> +        g_free(buf);
>>> +    } else {
>>> +        dest =3D region_devmem->mmaps[0].mmap;
>>> +        qemu_get_buffer(f, dest, len);
>>> +    }
>>> +
>>> +    sz =3D sizeof(action);
>>> +    if (pwrite(vbasedev->fd, &action, sz,
>>> +                region_ctl->fd_offset +
>>> +                offsetof(struct vfio_device_state_ctl, =
device_memory.action))
>>> +            !=3D sz) {
>>> +        error_report("vfio: Failed to set load device memory buffer =
action");
>>> +        return -1;
>>> +    }
>>> +
>>> +    return 0;
>>> +
>>> +}
>>> +
>>> +static int vfio_load_data_device_memory(VFIOPCIDevice *vdev,
>>> +                        QEMUFile *f, uint64_t total_len)
>>> +{
>>> +    uint64_t pos =3D 0, len =3D 0;
>>> +
>>> +    vfio_set_device_memory_size(vdev, total_len);
>>> +
>>> +    while (pos + len < total_len) {
>>> +        len =3D qemu_get_be64(f);
>>> +        pos =3D qemu_get_be64(f);
>>=20
>> Nit: load reads len/pos in the loop, whereas save does it in the
>> inner function (vfio_save_data_device_memory_chunk)
> right, load has to read len/pos in the loop.
>>=20
>>> +
>>> +        vfio_load_data_device_memory_chunk(vdev, f, pos, len);
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +
>>> static int vfio_set_dirty_page_bitmap_chunk(VFIOPCIDevice *vdev,
>>>        uint64_t start_addr, uint64_t page_nr)
>>> {
>>> @@ -377,6 +572,10 @@ static void vfio_save_live_pending(QEMUFile *f, =
void *opaque,
>>>        return;
>>>    }
>>>=20
>>> +    /* get dirty data size of device memory */
>>> +    vfio_get_device_memory_size(vdev);
>>> +
>>> +    *res_precopy_only +=3D vdev->migration->devmem_size;
>>>    return;
>>> }
>>>=20
>>> @@ -388,7 +587,9 @@ static int vfio_save_iterate(QEMUFile *f, void =
*opaque)
>>>        return 0;
>>>    }
>>>=20
>>> -    return 0;
>>> +    qemu_put_byte(f, VFIO_SAVE_FLAG_DEVMEMORY);
>>> +    /* get dirty data of device memory */
>>> +    return vfio_save_data_device_memory(vdev, f);
>>> }
>>>=20
>>> static void vfio_pci_load_config(VFIOPCIDevice *vdev, QEMUFile *f)
>>> @@ -458,6 +659,10 @@ static int vfio_load_state(QEMUFile *f, void =
*opaque, int version_id)
>>>            len =3D qemu_get_be64(f);
>>>            vfio_load_data_device_config(vdev, f, len);
>>>            break;
>>> +        case VFIO_SAVE_FLAG_DEVMEMORY:
>>> +            len =3D qemu_get_be64(f);
>>> +            vfio_load_data_device_memory(vdev, f, len);
>>> +            break;
>>>        default:
>>>            ret =3D -EINVAL;
>>>        }
>>> @@ -503,6 +708,13 @@ static int vfio_save_complete_precopy(QEMUFile =
*f, void *opaque)
>>>    VFIOPCIDevice *vdev =3D opaque;
>>>    int rc =3D 0;
>>>=20
>>> +    if (vfio_device_data_cap_device_memory(vdev)) {
>>> +        qemu_put_byte(f, VFIO_SAVE_FLAG_DEVMEMORY | =
VFIO_SAVE_FLAG_CONTINUE);
>>> +        /* get dirty data of device memory */
>>> +        vfio_get_device_memory_size(vdev);
>>> +        rc =3D vfio_save_data_device_memory(vdev, f);
>>> +    }
>>> +
>>>    qemu_put_byte(f, VFIO_SAVE_FLAG_PCI | VFIO_SAVE_FLAG_CONTINUE);
>>>    vfio_pci_save_config(vdev, f);
>>>=20
>>> @@ -515,12 +727,22 @@ static int vfio_save_complete_precopy(QEMUFile =
*f, void *opaque)
>>>=20
>>> static int vfio_save_setup(QEMUFile *f, void *opaque)
>>> {
>>> +    int rc =3D 0;
>>>    VFIOPCIDevice *vdev =3D opaque;
>>> -    qemu_put_byte(f, VFIO_SAVE_FLAG_SETUP);
>>> +
>>> +    if (vfio_device_data_cap_device_memory(vdev)) {
>>> +        qemu_put_byte(f, VFIO_SAVE_FLAG_SETUP | =
VFIO_SAVE_FLAG_CONTINUE);
>>> +        qemu_put_byte(f, VFIO_SAVE_FLAG_DEVMEMORY);
>>> +        /* get whole snapshot of device memory */
>>> +        vfio_get_device_memory_size(vdev);
>>> +        rc =3D vfio_save_data_device_memory(vdev, f);
>>> +    } else {
>>> +        qemu_put_byte(f, VFIO_SAVE_FLAG_SETUP);
>>> +    }
>>>=20
>>>    vfio_set_device_state(vdev, VFIO_DEVICE_STATE_RUNNING |
>>>            VFIO_DEVICE_STATE_LOGGING);
>>> -    return 0;
>>> +    return rc;
>>> }
>>>=20
>>> static int vfio_load_setup(QEMUFile *f, void *opaque)
>>> @@ -576,8 +798,11 @@ int vfio_migration_init(VFIOPCIDevice *vdev, =
Error **errp)
>>>        goto error;
>>>    }
>>>=20
>>> -    if (vfio_device_data_cap_device_memory(vdev)) {
>>> -        error_report("No suppport of data cap device memory Yet");
>>> +    if (vfio_device_data_cap_device_memory(vdev) &&
>>> +            vfio_device_state_region_setup(vdev,
>>> +              =
&vdev->migration->region[VFIO_DEVSTATE_REGION_DATA_DEVICE_MEMORY],
>>> +              VFIO_REGION_SUBTYPE_DEVICE_STATE_DATA_MEMORY,
>>> +              "device-state-data-device-memory")) {
>>>        goto error;
>>>    }
>>>=20
>>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>>> index 4b7b1bb..a2cc64b 100644
>>> --- a/hw/vfio/pci.h
>>> +++ b/hw/vfio/pci.h
>>> @@ -69,6 +69,7 @@ typedef struct VFIOMigration {
>>>    uint32_t data_caps;
>>>    uint32_t device_state;
>>>    uint64_t devconfig_size;
>>> +    uint64_t devmem_size;
>>>    VMChangeStateEntry *vm_state;
>>> } VFIOMigration;
>>>=20
>>> --=20
>>> 2.7.4
>>>=20
>>> _______________________________________________
>>> intel-gvt-dev mailing list
>>> intel-gvt-dev@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev
>>=20
>> _______________________________________________
>> intel-gvt-dev mailing list
>> intel-gvt-dev@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev
