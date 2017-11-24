Received: from eggs.gnu.org ([2001:4830:134:3::10]:53052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eILCL-0004AB-7G
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 16:07:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eILCH-0004Fi-7Z
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 16:07:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eILCH-0004ES-0m
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 16:07:41 -0500
Date: Fri, 24 Nov 2017 23:07:36 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171124230416-mutt-send-email-mst@kernel.org>
References: <33183CC9F5247A488A2544077AF19020DA4A4429@DGGEMA505-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA4A4429@DGGEMA505-MBS.china.huawei.com>
Subject: Re: [Qemu-devel] [Questions] about the VHOST_MEMORY_MAX_NREGIONS of
 vhost-user backend?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Jason Wang <jasowang@redhat.com>, "n.nikolaev@virtualopensystems.com" <n.nikolaev@virtualopensystems.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dev@dpdk.org" <dev@dpdk.org>, Fanhenglong <fanhenglong@huawei.com>, "Lianxueguo (Albert)" <lianxueguo@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>

On Fri, Nov 24, 2017 at 10:28:48AM +0000, Gonglei (Arei) wrote:
> Hi,
> 
> Currently, the maximum number of supported memory regions for vhost-user backends is 8, 
> and the maximum supported memory regions for vhost-net backends is determined by 
> " /sys/module/vhost/parameters/max_mem_regions". 
> 
> In many scenarios, the vhost-user NIC will cause the memory region to become a bottleneck, reports
>  "a used vhost backend has no free memory slots left". 
> 
> Such as memory hotplug (need to support multiple memory slots), 
> and GPU pass-through (need to register multiple bar regions) and so on.
> 
> So, my questions are: Why definition vhost-user memory card memory region up to 8?
> Does it have any side effects if we increase the VHOST_MEMORY_MAX_NREGIONS? 
> What about cross-version migration?
> 
> #define VHOST_MEMORY_MAX_NREGIONS    8

I think we can extend it with a protocol flag.


> static int vhost_user_memslots_limit(struct vhost_dev *dev)
> {
>     return VHOST_MEMORY_MAX_NREGIONS;
> }
> 
> Which is introduced by 
> commit 5f6f6664bf24dc53f4bf98ba812d55ca93684cd5
> Author: Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>
> Date:   Tue May 27 15:06:02 2014 +0300
> 
>     Add vhost-user as a vhost backend.
>     
>     The initialization takes a chardev backed by a unix domain socket.
>     It should implement qemu_fe_set_msgfds in order to be able to pass
>     file descriptors to the remote process.
>     
>     Each ioctl request of vhost-kernel has a vhost-user message equivalent,
>     which is sent over the control socket.
>     
>     The general approach is to copy the data from the supplied argument
>     pointer to a designated field in the message. If a file descriptor is
>     to be passed it will be placed in the fds array for inclusion in
>     the sendmsg control header.
>     
>     VHOST_SET_MEM_TABLE ignores the supplied vhost_memory structure and scans
>     the global ram_list for ram blocks with a valid fd field set. This would
>     be set when the '-object memory-file' option with share=on property is used.
>     
>     Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
>     Signed-off-by: Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>
>     Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> 
> Thanks,
> -Gonglei
> 
