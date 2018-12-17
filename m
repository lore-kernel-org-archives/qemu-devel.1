Received: from eggs.gnu.org ([2001:4830:134:3::10]:45576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1gYqwW-0002w1-A5
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 06:20:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1gYqwS-0006ES-LO
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 06:20:12 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:50129 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1gYqwR-00068E-9c
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 06:20:07 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 17 Dec 2018 11:19:49 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DB1D1315@dggeml531-mbs.china.huawei.com>
References: <1542746383-18288-1-git-send-email-kwankhede@nvidia.com>
	<1542746383-18288-4-git-send-email-kwankhede@nvidia.com>
In-Reply-To: <1542746383-18288-4-git-send-email-kwankhede@nvidia.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 3/5] Add migration functions for VFIO
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirti Wankhede <kwankhede@nvidia.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "cjia@nvidia.com" <cjia@nvidia.com>
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "eskultet@redhat.com" <eskultet@redhat.com>, "ziye.yang@intel.com" <ziye.yang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "zhi.a.wang@intel.com" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>, "eauger@redhat.com" <eauger@redhat.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "changpeng.liu@intel.com" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>, "Zhao,
	Yan Y" <yan.y.zhao@intel.com>, "Hu, Robert" <robert.hu@intel.com>, Huangzhichao <huangzhichao@huawei.com>, "Liujinsong (Paul)" <liu.jinsong@huawei.com>

Hi,

It's great to see this patch series, which is a very important step, althou=
gh=20
currently only consider GPU mdev devices to support hot migration.=20

However, this is based on the VFIO framework after all, so we expect=20
that we can make this live migration framework more general.

For example, the vfio_save_pending() callback is used to obtain device
memory (such as GPU memory), but if the device (such as network card)=20
has no special proprietary memory, but only system memory?=20
It is too much to perform a null operation for this kind of device by writi=
ng
memory to the vendor driver of kernel space.=20

I think we can acquire the capability from the vendor driver before using t=
his.=20
If there is device memory that needs iterative copying, the vendor driver r=
eturn
ture, otherwise return false. Then QEMU implement the specific logic,=20
otherwise return directly. Just like getting the capability list of KVM
module, can we?


Regards,
-Gonglei


> -----Original Message-----
> From: Qemu-devel
> [mailto:qemu-devel-bounces+arei.gonglei=3Dhuawei.com@nongnu.org] On
> Behalf Of Kirti Wankhede
> Sent: Wednesday, November 21, 2018 4:40 AM
> To: alex.williamson@redhat.com; cjia@nvidia.com
> Cc: Zhengxiao.zx@Alibaba-inc.com; kevin.tian@intel.com; yi.l.liu@intel.co=
m;
> eskultet@redhat.com; ziye.yang@intel.com; qemu-devel@nongnu.org;
> cohuck@redhat.com; shuangtai.tst@alibaba-inc.com; dgilbert@redhat.com;
> zhi.a.wang@intel.com; mlevitsk@redhat.com; pasic@linux.ibm.com;
> aik@ozlabs.ru; Kirti Wankhede <kwankhede@nvidia.com>;
> eauger@redhat.com; felipe@nutanix.com; jonathan.davies@nutanix.com;
> changpeng.liu@intel.com; Ken.Xue@amd.com
> Subject: [Qemu-devel] [PATCH 3/5] Add migration functions for VFIO device=
s
>=20
> - Migration function are implemented for VFIO_DEVICE_TYPE_PCI device.
> - Added SaveVMHandlers and implemented all basic functions required for l=
ive
>   migration.
> - Added VM state change handler to know running or stopped state of VM.
> - Added migration state change notifier to get notification on migration =
state
>   change. This state is translated to VFIO device state and conveyed to v=
endor
>   driver.
> - VFIO device supportd migration or not is decided based of migration reg=
ion
>   query. If migration region query is successful then migration is suppor=
ted
>   else migration is blocked.
> - Structure vfio_device_migration_info is mapped at 0th offset of migrati=
on
>   region and should always trapped by VFIO device's driver. Added both ty=
pe of
>   access support, trapped or mmapped, for data section of the region.
> - To save device state, read data offset and size using structure
>   vfio_device_migration_info.data, accordingly copy data from the region.
> - To restore device state, write data offset and size in the structure an=
d write
>   data in the region.
> - To get dirty page bitmap, write start address and pfn count then read c=
ount of
>   pfns copied and accordingly read those from the rest of the region or
> mmaped
>   part of the region. This copy is iterated till page bitmap for all requ=
ested
>   pfns are copied.
>=20
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/Makefile.objs         |   2 +-
>  hw/vfio/migration.c           | 729
> ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/vfio/vfio-common.h |  23 ++
>  3 files changed, 753 insertions(+), 1 deletion(-)
>  create mode 100644 hw/vfio/migration.c
>=20
[skip]

> +
> +static SaveVMHandlers savevm_vfio_handlers =3D {
> +    .save_setup =3D vfio_save_setup,
> +    .save_live_iterate =3D vfio_save_iterate,
> +    .save_live_complete_precopy =3D vfio_save_complete_precopy,
> +    .save_live_pending =3D vfio_save_pending,
> +    .save_cleanup =3D vfio_save_cleanup,
> +    .load_state =3D vfio_load_state,
> +    .load_setup =3D vfio_load_setup,
> +    .load_cleanup =3D vfio_load_cleanup,
> +    .is_active_iterate =3D vfio_is_active_iterate,
> +};
> +

=20
