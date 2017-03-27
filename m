Received: from eggs.gnu.org ([2001:4830:134:3::10]:59019)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <hch@lst.de>)
	id 1csW4O-0001HV-Ea
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hch@lst.de>) id 1csW4K-0001N5-Gh
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:56:32 -0400
Received: from verein.lst.de ([213.95.11.211]:38246 helo=newverein.lst.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hch@lst.de>) id 1csW4K-0001Kv-AH
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:56:28 -0400
Date: Mon, 27 Mar 2017 16:56:26 +0200
From: Christoph Hellwig <hch@lst.de>
Message-ID: <20170327145625.GA24952@lst.de>
References: <1490690365-21109-1-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490690365-21109-1-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-blk: add DISCARD support to
 virtio-blk driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, hch@lst.de, qemu-devel@nongnu.org

On Tue, Mar 28, 2017 at 04:39:25PM +0800, Changpeng Liu wrote:
> Currently virtio-blk driver does not provide discard feature flag, so the
> filesystems which built on top of the block device will not send discard
> command. This is okay for HDD backend, but it will impact the performance
> for SSD backend.
> 
> Add a feature flag VIRTIO_BLK_F_DISCARD and command VIRTIO_BLK_T_DISCARD
> to extend exist virtio-blk protocol. virtio-blk protocol uses a single
> 8 bytes descriptor containing type,reserved and sector, currently Linux
> uses the reserved field as IO priority, here we also re-use the reserved
> field as number of discard sectors.

Do you have a link to the specification for this feature?  At least
virtio-v1.0 does not seem to specify a discard feature.

Note that Linux 4.11 and later have support for multi-range discard
ala ATA TRIM, SCSI UNMAP and NVMe deallocate which might be useful
here, too.

> +		q->limits.discard_zeroes_data = 0;

No need to clear this.  Also hopefully this field goes away for 4.12

> +		blk_queue_max_discard_segments(q, 1);

No need to set this.
