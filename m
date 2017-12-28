Received: from eggs.gnu.org ([2001:4830:134:3::10]:48573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUWEH-0003bJ-3T
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 06:20:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUWEC-0002kE-K7
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 06:20:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eUWEC-0002ix-Bq
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 06:20:00 -0500
Date: Thu, 28 Dec 2017 12:19:49 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171228121949.0d3f7d77@igors-macbook-pro.local>
In-Reply-To: <B2D15215269B544CADD246097EACE7473AB19758@DGGEMM505-MBS.china.huawei.com>
References: <1513327555-17520-1-git-send-email-jianjay.zhou@huawei.com>
	<1513327555-17520-3-git-send-email-jianjay.zhou@huawei.com>
	<20171222194855.6d1139f1@igors-macbook-pro.local>
	<B2D15215269B544CADD246097EACE7473AB19758@DGGEMM505-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] vhost: double check used memslots
 number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Liuzhe (Cloud Open Labs,
	NFV)" <gary.liuzhe@huawei.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>

On Sat, 23 Dec 2017 08:27:25 +0000
"Zhoujian (jay)" <jianjay.zhou@huawei.com> wrote:

> 
> 
> > -----Original Message-----
> > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > Sent: Saturday, December 23, 2017 2:49 AM
> > To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> > Cc: qemu-devel@nongnu.org; mst@redhat.com; Huangweidong (C)
> > <weidong.huang@huawei.com>; Gonglei (Arei) <arei.gonglei@huawei.com>;
> > wangxin (U) <wangxinxin.wang@huawei.com>; Liuzhe (Cloud Open Labs, NFV)
> > <gary.liuzhe@huawei.com>; dgilbert@redhat.com
> > Subject: Re: [PATCH v2 2/2] vhost: double check used memslots number
> > 
> > On Fri, 15 Dec 2017 16:45:55 +0800
> > Jay Zhou <jianjay.zhou@huawei.com> wrote:
> > 
> > > If the VM already has N(N>8) available memory slots for vhost user,
> > > the VM will be crashed in vhost_user_set_mem_table if we try to
> > > hotplug the first vhost user NIC.
> > > This patch checks if memslots number exceeded or not after updating
> > > vhost_user_used_memslots.
> > Can't understand commit message, pls rephrase (what is being fixed, and
> > how it's fixed) also include reproducing steps for crash and maybe
> > describe call flow/backtrace that triggers crash.
> 
> Sorry about my pool english
> 
> > 
> > PS:
> > I wasn't able to reproduce crash
> 
> Steps to reproduce:
> (1) start up a VM successfully without any vhost device
> (2) hotplug 8 DIMM memory successfully
> (3) hotplug a vhost-user NIC, the VM crashed, it asserted
>     at the line
>         assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
quick fix for this crash could be:

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 093675ed98..07a37537dd 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -321,7 +321,9 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
             msg.payload.memory.regions[fd_num].memory_size  = reg->memory_size;
             msg.payload.memory.regions[fd_num].guest_phys_addr = reg->guest_phys_addr;
             msg.payload.memory.regions[fd_num].mmap_offset = offset;
-            assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
+            if (fd_num == VHOST_MEMORY_MAX_NREGIONS) {
+                return -1;
+            }
             fds[fd_num++] = fd;
         }
     }

it should gracefully prevent device to start.

>     in vhost_user_set_mem_table()
> 
> Regards,
> Jay
[...]
