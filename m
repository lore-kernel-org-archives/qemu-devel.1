Received: from eggs.gnu.org ([2001:4830:134:3::10]:43906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eSdwf-0002L2-NJ
	for qemu-devel@nongnu.org; Sat, 23 Dec 2017 02:10:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eSdwc-0005Mo-Hh
	for qemu-devel@nongnu.org; Sat, 23 Dec 2017 02:10:09 -0500
Received: from [45.249.212.255] (port=45917 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1eSdwc-0005Jn-5M
	for qemu-devel@nongnu.org; Sat, 23 Dec 2017 02:10:06 -0500
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Sat, 23 Dec 2017 07:09:51 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473AB196EF@DGGEMM505-MBS.china.huawei.com>
References: <1513327555-17520-1-git-send-email-jianjay.zhou@huawei.com>
	<1513327555-17520-2-git-send-email-jianjay.zhou@huawei.com>
	<20171222172513.4157adcc@igors-macbook-pro.local>
	<20171222200305.171cd7fb@igors-macbook-pro.local>
In-Reply-To: <20171222200305.171cd7fb@igors-macbook-pro.local>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 1/2] vhost: add used memslot number for
 vhost-user and vhost-kernel separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Liuzhe (Cloud Open Labs,
	NFV)" <gary.liuzhe@huawei.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>

Hi Igor,

> -----Original Message-----
> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: Saturday, December 23, 2017 3:03 AM
> To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> Cc: Huangweidong (C) <weidong.huang@huawei.com>; mst@redhat.com; wangxin
> (U) <wangxinxin.wang@huawei.com>; qemu-devel@nongnu.org; Liuzhe (Cloud
> Open Labs, NFV) <gary.liuzhe@huawei.com>; dgilbert@redhat.com; Gonglei
> (Arei) <arei.gonglei@huawei.com>
> Subject: Re: [Qemu-devel] [PATCH v2 1/2] vhost: add used memslot number
> for vhost-user and vhost-kernel separately
>=20
> On Fri, 22 Dec 2017 17:25:13 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> > On Fri, 15 Dec 2017 16:45:54 +0800
> > Jay Zhou <jianjay.zhou@huawei.com> wrote:
> [...]
>=20
> > > +static void vhost_user_set_used_memslots(struct vhost_dev *dev) {
> > > +    int counter =3D 0;
> > > +    int i;
> > > +
> > > +    for (i =3D 0; i < dev->mem->nregions; ++i) {
> > > +        struct vhost_memory_region *reg =3D dev->mem->regions + i;
> > > +        ram_addr_t offset;
> > > +        MemoryRegion *mr;
> > > +        int fd;
> > > +
> > > +        assert((uintptr_t)reg->userspace_addr =3D=3D reg->userspace_=
addr);
> > > +        mr =3D memory_region_from_host((void *)(uintptr_t)reg-
> >userspace_addr,
> > > +                                    &offset);
> > > +        fd =3D memory_region_get_fd(mr);
> > > +        if (fd > 0) {
> > > +            counter++;
> > > +        }
> > > +    }
> > vhost_user_set_mem_table() already does the same counting, there is no
> > point in duplicating it, just drop vhost_set_used_memslots callback
> >
> > > +    vhost_user_used_memslots =3D counter;
> > and update this value from vhost_user_set_mem_table()
> never mind, updating it from vhost_user_set_mem_table() as it's called
> only when device is started which is not the case when backend is
> initialized, so the way you did it should work for both cases
>=20

How about do it like this(not sure whether the best way, any idea?):

Define a new function, e.g.

static void vhost_user_set_used_memslots_and_msgs(struct vhost_dev *dev,
                            VhostUserMsg *msg, size_t *fd_num, int *fds)
{
    int num =3D 0;
    int i;

    for (i =3D 0; i < dev->mem->nregions; ++i) {
        struct vhost_memory_region *reg =3D dev->mem->regions + i;
        ram_addr_t offset;
        MemoryRegion *mr;
        int fd;

        assert((uintptr_t)reg->userspace_addr =3D=3D reg->userspace_addr);
        mr =3D memory_region_from_host((void *)(uintptr_t)reg->userspace_ad=
dr,
                                &offset);
        fd =3D memory_region_get_fd(mr);
        if (fd > 0) {
            if (msg && fd_num && fds) {
                msg->payload.memory.regions[num].userspace_addr
                                        =3D reg->userspace_addr;
                msg->payload.memory.regions[num].memory_size
                                        =3D reg->memory_size;
                msg->payload.memory.regions[num].guest_phys_addr
                                        =3D reg->guest_phys_addr;
                msg->payload.memory.regions[num].mmap_offset =3D offset;
                assert(num < VHOST_MEMORY_MAX_NREGIONS);
                fds[num++] =3D fd;
            }
        }
    }
    vhost_user_used_memslots =3D num;
    if (fd_num)
        *fd_num =3D num;
}

And call it when the backend is initialized and the device is started
respectively,

static void vhost_user_set_used_memslots(struct vhost_dev *dev)
{
	vhost_user_set_used_memslots_and_msgs(dev, NULL, NULL, NULL);
}

static int vhost_user_set_mem_table(struct vhost_dev *dev,
						struct vhost_memory *mem)
{
	[...]

	vhost_user_set_used_memslots_and_msgs(dev, &msg, &fd_num, fds);

	[...]
}


Regards,
Jay

>=20
> >
> > > +}
> > > +
> [...]
