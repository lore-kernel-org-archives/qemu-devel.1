Received: from eggs.gnu.org ([2001:4830:134:3::10]:46148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eVAXU-0005y6-Ix
	for qemu-devel@nongnu.org; Sat, 30 Dec 2017 01:22:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eVAXR-00047E-T1
	for qemu-devel@nongnu.org; Sat, 30 Dec 2017 01:22:36 -0500
Received: from [45.249.212.255] (port=50476 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1eVAXR-00042P-GB
	for qemu-devel@nongnu.org; Sat, 30 Dec 2017 01:22:33 -0500
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Sat, 30 Dec 2017 06:22:15 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473AB1F09B@DGGEMM505-MBS.china.huawei.com>
References: <1514574360-31788-1-git-send-email-jianjay.zhou@huawei.com>
In-Reply-To: <1514574360-31788-1-git-send-email-jianjay.zhou@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4] vhost: set used memslots for vhost-user
 and vhost-kernel respectively
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Liuzhe (Cloud Open Labs, NFV)" <gary.liuzhe@huawei.com>



> -----Original Message-----
> From: Zhoujian (jay)
> Sent: Saturday, December 30, 2017 3:06 AM
> To: qemu-devel@nongnu.org
> Cc: mst@redhat.com; imammedo@redhat.com; Huangweidong (C)
> <weidong.huang@huawei.com>; wangxin (U) <wangxinxin.wang@huawei.com>;
> Gonglei (Arei) <arei.gonglei@huawei.com>; Zhoujian (jay)
> <jianjay.zhou@huawei.com>; Liuzhe (Cloud Open Labs, NFV)
> <gary.liuzhe@huawei.com>
> Subject: [PATCH v4] vhost: set used memslots for vhost-user and vhost-
> kernel respectively
>=20
> Used_memslots is equal to dev->mem->nregions now, it is true for vhost
> kernel, but not for vhost user, which uses the memory regions that have
> file descriptor. In fact, not all of the memory regions have file
> descriptor.
> It is usefully in some scenarios, e.g. used_memslots is 8, and only
> 5 memory slots can be used by vhost user, it is failed to hotplug a new
> DIMM memory because vhost_has_free_slot just returned false, however we
> can hotplug it safely in fact.
>=20
> Meanwhile, instead of asserting in vhost_user_set_mem_table(), error
> number is used to gracefully prevent device to start. This fixed the VM
> crash issue.
>=20
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> Signed-off-by: Zhe Liu <gary.liuzhe@huawei.com>

The email address of liuzhe will be updated to liuzhe13@huawei.com

[...]

>=20
> +static int vhost_user_prepare_msg(struct vhost_dev *dev, VhostUserMemory
> *mem,
> +                                  int *fds) {
> +    int i, fd;
> +

Sorry about forgetting to add "vhost_user_free_memslots =3D true;" here.
Indeed, it is necessary. If vhost_user_free_memslots is false now,
it will be true if we hot-unplug some DIMMs, will resend v4.

Regards,
Jay

> +    for (i =3D 0, mem->nregions =3D 0; i < dev->mem->nregions; ++i) {
> +        struct vhost_memory_region *reg =3D dev->mem->regions + i;
> +        ram_addr_t offset;
> +        MemoryRegion *mr;
> +
> +        assert((uintptr_t)reg->userspace_addr =3D=3D reg->userspace_addr=
);
> +        mr =3D memory_region_from_host((void *)(uintptr_t)reg-
> >userspace_addr,
> +                                     &offset);
> +        fd =3D memory_region_get_fd(mr);
> +        if (fd > 0) {
> +            if (mem->nregions =3D=3D VHOST_MEMORY_MAX_NREGIONS) {
> +                vhost_user_free_memslots =3D false;
> +                return -1;
> +            }
> +
> +            mem->regions[mem->nregions].userspace_addr =3D reg-
> >userspace_addr;
> +            mem->regions[mem->nregions].memory_size =3D reg->memory_size=
;
> +            mem->regions[mem->nregions].guest_phys_addr =3D reg-
> >guest_phys_addr;
> +            mem->regions[mem->nregions].mmap_offset =3D offset;
> +            fds[mem->nregions++] =3D fd;
> +        }
> +    }
> +
> +    return 0;
> +}
> +

[...]
