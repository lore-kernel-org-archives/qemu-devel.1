Received: from eggs.gnu.org ([2001:4830:134:3::10]:36933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ePnGs-0000gr-GO
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:31:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ePnGp-0003Vu-BY
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:31:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:55559)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1ePnGp-0003UM-2X
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:31:11 -0500
Message-ID: <5A33A4EA.7010204@intel.com>
Date: Fri, 15 Dec 2017 18:33:14 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <CAJSP0QUAqCzFgVtM1cg_KybdyrZa_FRUHhDN7oLfRjZ2ZVkp4g@mail.gmail.com>
	<286AC319A985734F985F78AFA26841F73937E001@shsmsx102.ccr.corp.intel.com>
	<20171211111147.GF13593@stefanha-x1.localdomain>
	<286AC319A985734F985F78AFA26841F73937EEED@shsmsx102.ccr.corp.intel.com>
	<20171212101440.GB6985@stefanha-x1.localdomain>
	<5A30E0C1.3070905@intel.com>
	<20171213123521.GL16782@stefanha-x1.localdomain>
	<20171213165142-mutt-send-email-mst@kernel.org>
	<CAJSP0QWHJBL4APkeMt8-P8PFaPF=Vbi0NSnJtU7YX67fJrW=hw@mail.gmail.com>
	<20171213222102-mutt-send-email-mst@kernel.org>
	<20171214150609.GQ14433@stefanha-x1.localdomain>
In-Reply-To: <20171214150609.GQ14433@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM
 communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>

On 12/14/2017 11:06 PM, Stefan Hajnoczi wrote:
> On Wed, Dec 13, 2017 at 10:59:10PM +0200, Michael S. Tsirkin wrote:
>>>   * VHOST_USER_SET_VRING_KICK
>>>
>>>     Set up vring kick doorbell (unless bit 8 is set) before sending
>>>     VHOST_USER_SET_VRING_KICK to the guest.
>> But guest can't use it, now can it?
>>
>> What guest needs is a mapping to interrupts.
> ...
>>>   * VHOST_USER_SET_VRING_CALL
>>>
>>>     Set up the vring call doorbell (unless bit 8 is set) before sending
>>>     VHOST_USER_SET_VRING_CALL to the guest.
>> Same here. what guest needs is mapping from io to notifications,
>> right?
> The PCI device should contain a BAR with doorbell registers.  I don't
> think a fancy mapping is necessary, instead the device spec should
> define the BAR layout.
>
> When the guest vhost-user slave receives this message it knows it can
> now begin using the doorbell register.

Not really. A doorbell will cause an interrupt to be injected to the 
master device driver, which is not ready to work at that time. The slave 
driver isn't expected to use the doorbell until the master is ready by 
sending the last message VHOST_USER_SET_VHOST_PCI to link UP the slave 
device.

So I think passing the fd msg to guest doesn't have a value in terms of 
functionality.

Best,
Wei
