Received: from eggs.gnu.org ([2001:4830:134:3::10]:36500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ebUy4-0007jt-BX
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:24:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ebUy1-0000T6-9G
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:24:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ebUy1-0000Pk-2c
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:24:09 -0500
Date: Tue, 16 Jan 2018 10:23:39 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180116102339.7ad44e48@w520.home>
In-Reply-To: <20171222064151.29266-4-tiwei.bie@intel.com>
References: <20171222064151.29266-1-tiwei.bie@intel.com>
	<20171222064151.29266-4-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 3/3] vhost-user: add VFIO based accelerators
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com

On Fri, 22 Dec 2017 14:41:51 +0800
Tiwei Bie <tiwei.bie@intel.com> wrote:

> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
>  docs/interop/vhost-user.txt    |  57 ++++++
>  hw/vfio/common.c               |   2 +-
>  hw/virtio/vhost-user.c         | 381 ++++++++++++++++++++++++++++++++++++++++-
>  hw/virtio/vhost.c              |   3 +-
>  hw/virtio/virtio-pci.c         |   8 -
>  hw/virtio/virtio-pci.h         |   8 +
>  include/hw/vfio/vfio.h         |   2 +
>  include/hw/virtio/vhost-user.h |  26 +++
>  8 files changed, 476 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 7b2924c0ef..53d8700581 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -49,7 +49,7 @@ struct vfio_as_head vfio_address_spaces =
>   * initialized, this file descriptor is only released on QEMU exit and
>   * we'll re-use it should another vfio device be attached before then.
>   */
> -static int vfio_kvm_device_fd = -1;
> +int vfio_kvm_device_fd = -1;
>  #endif

It seems troublesome for vhost to maintain it's own list of groups and
register them with the vfio-kvm device.  These should likely be made
into services provided by vfio/common.c such that we can have a single
group list and interfaces for adding and deleting them.  Thanks,

Alex
