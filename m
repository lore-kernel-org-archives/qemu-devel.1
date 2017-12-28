Received: from eggs.gnu.org ([2001:4830:134:3::10]:42915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUW6g-0000TH-KV
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 06:12:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUW6d-0002Ju-E0
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 06:12:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eUW6d-0002Ic-4e
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 06:12:11 -0500
Date: Thu, 28 Dec 2017 12:11:55 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171228121155.0c1cc273@igors-macbook-pro.local>
In-Reply-To: <B2D15215269B544CADD246097EACE7473AB196EF@DGGEMM505-MBS.china.huawei.com>
References: <1513327555-17520-1-git-send-email-jianjay.zhou@huawei.com>
	<1513327555-17520-2-git-send-email-jianjay.zhou@huawei.com>
	<20171222172513.4157adcc@igors-macbook-pro.local>
	<20171222200305.171cd7fb@igors-macbook-pro.local>
	<B2D15215269B544CADD246097EACE7473AB196EF@DGGEMM505-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "Liuzhe (Cloud Open Labs,
	NFV)" <gary.liuzhe@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Gonglei (Arei)" <arei.gonglei@huawei.com>

On Sat, 23 Dec 2017 07:09:51 +0000
"Zhoujian (jay)" <jianjay.zhou@huawei.com> wrote:

> Hi Igor,
> 
> > -----Original Message-----
> > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > Sent: Saturday, December 23, 2017 3:03 AM
> > To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> > Cc: Huangweidong (C) <weidong.huang@huawei.com>; mst@redhat.com; wangxin
> > (U) <wangxinxin.wang@huawei.com>; qemu-devel@nongnu.org; Liuzhe (Cloud
> > Open Labs, NFV) <gary.liuzhe@huawei.com>; dgilbert@redhat.com; Gonglei
> > (Arei) <arei.gonglei@huawei.com>
> > Subject: Re: [Qemu-devel] [PATCH v2 1/2] vhost: add used memslot number
> > for vhost-user and vhost-kernel separately
> > 
> > On Fri, 22 Dec 2017 17:25:13 +0100
> > Igor Mammedov <imammedo@redhat.com> wrote:
> > 
> > > On Fri, 15 Dec 2017 16:45:54 +0800
> > > Jay Zhou <jianjay.zhou@huawei.com> wrote:
> > [...]
> > 
> > > > +static void vhost_user_set_used_memslots(struct vhost_dev *dev) {
> > > > +    int counter = 0;
> > > > +    int i;
> > > > +
> > > > +    for (i = 0; i < dev->mem->nregions; ++i) {
> > > > +        struct vhost_memory_region *reg = dev->mem->regions + i;
> > > > +        ram_addr_t offset;
> > > > +        MemoryRegion *mr;
> > > > +        int fd;
> > > > +
> > > > +        assert((uintptr_t)reg->userspace_addr == reg->userspace_addr);
> > > > +        mr = memory_region_from_host((void *)(uintptr_t)reg-
> > >userspace_addr,
> > > > +                                    &offset);
> > > > +        fd = memory_region_get_fd(mr);
> > > > +        if (fd > 0) {
> > > > +            counter++;
> > > > +        }
> > > > +    }
> > > vhost_user_set_mem_table() already does the same counting, there is no
> > > point in duplicating it, just drop vhost_set_used_memslots callback
> > >
> > > > +    vhost_user_used_memslots = counter;
> > > and update this value from vhost_user_set_mem_table()
> > never mind, updating it from vhost_user_set_mem_table() as it's called
> > only when device is started which is not the case when backend is
> > initialized, so the way you did it should work for both cases
> > 
> 
> How about do it like this(not sure whether the best way, any idea?):
> 
> Define a new function, e.g.
> 
> static void vhost_user_set_used_memslots_and_msgs(struct vhost_dev *dev,
>                             VhostUserMsg *msg, size_t *fd_num, int *fds)
s/vhost_user_set_used_memslots_and_msgs/vhost_user_prepare_msg/

> {
>     int num = 0;
>     int i;
> 
>     for (i = 0; i < dev->mem->nregions; ++i) {
>         struct vhost_memory_region *reg = dev->mem->regions + i;
>         ram_addr_t offset;
>         MemoryRegion *mr;
>         int fd;
> 
>         assert((uintptr_t)reg->userspace_addr == reg->userspace_addr);
>         mr = memory_region_from_host((void *)(uintptr_t)reg->userspace_addr,
>                                 &offset);
>         fd = memory_region_get_fd(mr);
>         if (fd > 0) {
>             if (msg && fd_num && fds) {
>                 msg->payload.memory.regions[num].userspace_addr
>                                         = reg->userspace_addr;
>                 msg->payload.memory.regions[num].memory_size
>                                         = reg->memory_size;
>                 msg->payload.memory.regions[num].guest_phys_addr
>                                         = reg->guest_phys_addr;
>                 msg->payload.memory.regions[num].mmap_offset = offset;
>                 assert(num < VHOST_MEMORY_MAX_NREGIONS);
there is no need to assert here function can return error.
 
>                 fds[num++] = fd;
Is num counting in wrong place?

   if (msg && fd_num && fds) => false
is the case vhost_user_set_used_memslots(), so it won't count 'num'
which is later used to intialize vhost_user_used_memslots.

>             }
>         }
>     }
>     vhost_user_used_memslots = num;
add comment here as it won't be obvious to reader why vhost_user_used_memslots is here


>     if (fd_num)
>         *fd_num = num;
msg.payload.memory.nregions can be used directly instead of num amd fd_num
and it's 1 less argument to pass out of function.

> }
> 
> And call it when the backend is initialized and the device is started
> respectively,
> 
> static void vhost_user_set_used_memslots(struct vhost_dev *dev)
static int

for return value

> {
> 	vhost_user_set_used_memslots_and_msgs(dev, NULL, NULL, NULL);
we can do here
        vhost_user_set_used_memslots_and_msgs(dev, &msg, &fd_num, fds);
and discard/ignore results, that way it will be less conditionals inside of called function

> }
> 
> static int vhost_user_set_mem_table(struct vhost_dev *dev,
> 						struct vhost_memory *mem)
> {
> 	[...]
> 
> 	vhost_user_set_used_memslots_and_msgs(dev, &msg, &fd_num, fds);
   rc = vhost_user_set_used_memslots_and_msgs(dev, &msg, &fd_num, fds);

and return error from vhost_user_set_mem_table(), caller should be able
to coupe with error.

> 
> 	[...]
> }
> 
> 
> Regards,
> Jay
> 
> > 
> > >
> > > > +}
> > > > +
> > [...]
> 
