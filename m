Received: from eggs.gnu.org ([2001:4830:134:3::10]:59365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ebUhc-00086Y-UY
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:07:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ebUhZ-00066K-Pm
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:07:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ebUhZ-00064k-Be
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:07:09 -0500
References: <1516003315-17878-1-git-send-email-changpeng.liu@intel.com>
	<1516003315-17878-2-git-send-email-changpeng.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7711f157-5863-fc75-0730-a631362ffd06@redhat.com>
Date: Tue, 16 Jan 2018 18:06:56 +0100
MIME-Version: 1.0
In-Reply-To: <1516003315-17878-2-git-send-email-changpeng.liu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1] block/NVMe: introduce a new vhost NVMe
 host device to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>, qemu-devel@nongnu.org
Cc: james.r.harris@intel.com, keith.busch@intel.com, famz@redhat.com, stefanha@gmail.com, mst@redhat.com

On 15/01/2018 09:01, Changpeng Liu wrote:
> NVMe 1.3 specification introduces a new NVMe ADMIN command:
> doorbell buffer config, which can write shadow doorbell buffer
> instead of MMIO registers, so it can improve the Guest performance
> a lot for emulated NVMe devices inside VM.
> 
> Similar with existing vhost-user-scsi solution, this commit builds a
> new vhost_user_nvme host device to VM and the I/O is processed at
> the slave I/O target, so users can implement a user space NVMe driver
> in the slave I/O target.
> 
> Users can start QEMU with: -chardev socket,id=char0,path=/path/vhost.0 \
> -device vhost-user-nvme,chardev=char0,num_io_queues=2.

Hi Changpeng,

I have two comments on this series.

First, the new command in NVMe 1.3 is great.  However, please first add
support for the doorbell buffer config in hw/block/nvme.c.  There is no
need to tie support for the new command to a completely new external
server architecture.  Emulated NVMe can be enhanced to use iothreads and
(when the doorbell buffer is configured) ioeventfd, and that should come
before enhancements for external vhost-like servers.

Second, virtio-based vhost-user remains QEMU's preferred method for
high-performance I/O in guests.  Discard support is missing and that is
important for SSDs; that should be fixed in the virtio spec.  Are there
any other features where virtio-blk is lagging behind NVMe?

Thanks,

Paolo
