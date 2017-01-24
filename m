Received: from eggs.gnu.org ([2001:4830:134:3::10]:60993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cW3Mz-0002zU-Tw
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:50:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cW3Mz-0000XQ-5Q
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:50:53 -0500
References: <1485132904-17632-1-git-send-email-zhaoshenglong@huawei.com>
	<20170123180247-mutt-send-email-mst@kernel.org>
	<49fcc1e0-f439-9212-25f1-9b8dce6462cc@redhat.com>
	<20170123190257-mutt-send-email-mst@kernel.org>
	<5760ee8c-f567-0dfd-456f-65f8957b22e2@redhat.com>
	<20170124164204-mutt-send-email-mst@kernel.org>
	<9a61e616-9bf8-b4ff-43b9-68f1c908b910@redhat.com>
	<20170124170514-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f5af901b-d355-94e7-fdf1-ad1b88223bd7@redhat.com>
Date: Tue, 24 Jan 2017 16:50:44 +0100
MIME-Version: 1.0
In-Reply-To: <20170124170514-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2] virtio: Fix no interrupt when not
 creating msi controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Shannon Zhao <zhaoshenglong@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, christoffer.dall@linaro.org



On 24/01/2017 16:05, Michael S. Tsirkin wrote:
>>
>> So we have four cases:
>>
>> - assign with emulated irqfd + ISR
>> - assign with emulated irqfd
>> - assign with irqfd
>> - deassign
>>
>> Currently we don't distinguish the first two, so (which I don't like)
>> Shannon's patch ends up setting ISR twice.
> 
> I don't see this yet - where is it set twice?

Once in virtio_notify_irqfd, once in virtio_queue_guest_notifier_read.

Unfortunately, for virtio-blk + MSI + KVM + old Windows drivers we need
the one in virtio_notify_irqfd.  For virtio-net + vhost + INTx we need
the one in virtio_queue_guest_notifier_read.
