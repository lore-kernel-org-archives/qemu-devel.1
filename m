Received: from eggs.gnu.org ([2001:4830:134:3::10]:43064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eIBKE-00049b-NZ
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 05:35:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eIBKA-0004r8-DA
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 05:35:14 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:4370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eIBK9-0004eH-Qo
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 05:35:10 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 24 Nov 2017 10:28:48 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA4A4429@DGGEMA505-MBS.china.huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [Questions] about the VHOST_MEMORY_MAX_NREGIONS of
 vhost-user backend?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "mst@redhat.com" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "n.nikolaev@virtualopensystems.com" <n.nikolaev@virtualopensystems.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dev@dpdk.org" <dev@dpdk.org>, Fanhenglong <fanhenglong@huawei.com>, "Lianxueguo (Albert)" <lianxueguo@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>

Hi,

Currently, the maximum number of supported memory regions for vhost-user ba=
ckends is 8,=20
and the maximum supported memory regions for vhost-net backends is determin=
ed by=20
" /sys/module/vhost/parameters/max_mem_regions".=20

In many scenarios, the vhost-user NIC will cause the memory region to becom=
e a bottleneck, reports
 "a used vhost backend has no free memory slots left".=20

Such as memory hotplug (need to support multiple memory slots),=20
and GPU pass-through (need to register multiple bar regions) and so on.

So, my questions are: Why definition vhost-user memory card memory region u=
p to 8?
Does it have any side effects if we increase the VHOST_MEMORY_MAX_NREGIONS?=
=20
What about cross-version migration?

#define VHOST_MEMORY_MAX_NREGIONS    8

static int vhost_user_memslots_limit(struct vhost_dev *dev)
{
    return VHOST_MEMORY_MAX_NREGIONS;
}

Which is introduced by=20
commit 5f6f6664bf24dc53f4bf98ba812d55ca93684cd5
Author: Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>
Date:   Tue May 27 15:06:02 2014 +0300

    Add vhost-user as a vhost backend.
   =20
    The initialization takes a chardev backed by a unix domain socket.
    It should implement qemu_fe_set_msgfds in order to be able to pass
    file descriptors to the remote process.
   =20
    Each ioctl request of vhost-kernel has a vhost-user message equivalent,
    which is sent over the control socket.
   =20
    The general approach is to copy the data from the supplied argument
    pointer to a designated field in the message. If a file descriptor is
    to be passed it will be placed in the fds array for inclusion in
    the sendmsg control header.
   =20
    VHOST_SET_MEM_TABLE ignores the supplied vhost_memory structure and sca=
ns
    the global ram_list for ram blocks with a valid fd field set. This woul=
d
    be set when the '-object memory-file' option with share=3Don property i=
s used.
   =20
    Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
    Signed-off-by: Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>
    Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


Thanks,
-Gonglei
