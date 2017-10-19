Received: from eggs.gnu.org ([2001:4830:134:3::10]:43483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e59Es-0004eo-Kv
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 07:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e59Eo-0003gZ-PD
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 07:43:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e59Eo-0003fo-JH
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 07:43:46 -0400
References: <1508390650-19115-1-git-send-email-changpeng.liu@intel.com>
	<1508390650-19115-5-git-send-email-changpeng.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <46402c4f-d702-5119-7b99-fa8abb778f66@redhat.com>
Date: Thu, 19 Oct 2017 13:43:35 +0200
MIME-Version: 1.0
In-Reply-To: <1508390650-19115-5-git-send-email-changpeng.liu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 4/4] contrib/vhost-user-blk: introduce a
 vhost-user-blk sample application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>, qemu-devel@nongnu.org
Cc: stefanha@gmail.com, mst@redhat.com, marcandre.lureau@redhat.com, felipe@nutanix.com, james.r.harris@intel.com

On 19/10/2017 07:24, Changpeng Liu wrote:
> 
> +}
> +
> +static void
> +vub_flush(VubReq *req)
> +{
> +    VubDev *vdev_blk = req->vdev_blk;
> +
> +    if (vdev_blk->blk_fd) {
> +        fsync(vdev_blk->blk_fd);
> +    }
> +}
> +

No need to check the file descriptor---vub_readv and vub_writev aren't
checking it either.  Also please use fdatasync instead of fsync.

> +static uint64_t
> +vub_get_features(VuDev *dev)
> +{
> +    return 1ull << VIRTIO_BLK_F_SIZE_MAX |
> +           1ull << VIRTIO_BLK_F_SEG_MAX |
> +           1ull << VIRTIO_BLK_F_TOPOLOGY |
> +           1ull << VIRTIO_BLK_F_BLK_SIZE |
> +           1ull << VIRTIO_F_VERSION_1 |
> +           1ull << VHOST_USER_F_PROTOCOL_FEATURES;
> +}

VIRTIO_BLK_F_FLUSH is missing.

Thanks,

Paolo
