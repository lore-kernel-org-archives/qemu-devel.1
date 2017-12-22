Received: from eggs.gnu.org ([2001:4830:134:3::10]:45316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eSSbP-0002al-N1
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 14:03:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eSSbE-0005Uw-FY
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 14:03:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eSSbE-0005Ty-4C
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 14:03:16 -0500
Date: Fri, 22 Dec 2017 20:03:05 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171222200305.171cd7fb@igors-macbook-pro.local>
In-Reply-To: <20171222172513.4157adcc@igors-macbook-pro.local>
References: <1513327555-17520-1-git-send-email-jianjay.zhou@huawei.com>
	<1513327555-17520-2-git-send-email-jianjay.zhou@huawei.com>
	<20171222172513.4157adcc@igors-macbook-pro.local>
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
To: Jay Zhou <jianjay.zhou@huawei.com>
Cc: weidong.huang@huawei.com, mst@redhat.com, wangxinxin.wang@huawei.com, qemu-devel@nongnu.org, gary.liuzhe@huawei.com, dgilbert@redhat.com, arei.gonglei@huawei.com

On Fri, 22 Dec 2017 17:25:13 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Fri, 15 Dec 2017 16:45:54 +0800
> Jay Zhou <jianjay.zhou@huawei.com> wrote:
[...]

> > +static void vhost_user_set_used_memslots(struct vhost_dev *dev)
> > +{
> > +    int counter = 0;
> > +    int i;
> > +
> > +    for (i = 0; i < dev->mem->nregions; ++i) {
> > +        struct vhost_memory_region *reg = dev->mem->regions + i;
> > +        ram_addr_t offset;
> > +        MemoryRegion *mr;
> > +        int fd;
> > +
> > +        assert((uintptr_t)reg->userspace_addr == reg->userspace_addr);
> > +        mr = memory_region_from_host((void *)(uintptr_t)reg->userspace_addr,
> > +                                    &offset);
> > +        fd = memory_region_get_fd(mr);
> > +        if (fd > 0) {
> > +            counter++;
> > +        }
> > +    }
> vhost_user_set_mem_table() already does the same counting,
> there is no point in duplicating it, just drop vhost_set_used_memslots callback
> 
> > +    vhost_user_used_memslots = counter;
> and update this value from vhost_user_set_mem_table()
never mind, updating it from vhost_user_set_mem_table() as it's called only when
device is started which is not the case when backend is initialized,
so the way you did it should work for both cases


> 
> > +}
> > +
[...]
