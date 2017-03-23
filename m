Received: from eggs.gnu.org ([2001:4830:134:3::10]:53679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cqsDx-0001a4-CK
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 22:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cqsDr-0005QZ-2E
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 22:11:35 -0400
Received: from [59.151.112.132] (port=54541 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cqsDq-0005Pu-MN
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 22:11:30 -0400
References: <1490178863-14806-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170322143058-mutt-send-email-mst@kernel.org>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <58D330D7.3090908@cn.fujitsu.com>
Date: Thu, 23 Mar 2017 10:20:07 +0800
MIME-Version: 1.0
In-Reply-To: <20170322143058-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5] vfio error recovery: kernel support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, alex.williamson@redhat.com



On 03/22/2017 09:10 PM, Michael S. Tsirkin wrote:
> Minor comments on commit log below.
> 
> On Wed, Mar 22, 2017 at 06:34:23PM +0800, Cao jin wrote:
>> From: "Michael S. Tsirkin" <mst@redhat.com>
>>

> 
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
>> ---
>>
>> v5 changelog:
>> 1. Add another new eventfd passive_reset_trigger & the boilerplate code,
>>    used in slot_reset. Add comment for slot_reset().
>> 2. Rewrite the commit log.
>>
>>  drivers/vfio/pci/vfio_pci.c         | 49 +++++++++++++++++++++++++++++++++++--
>>  drivers/vfio/pci/vfio_pci_intrs.c   | 38 ++++++++++++++++++++++++++++
>>  drivers/vfio/pci/vfio_pci_private.h |  2 ++
>>  include/uapi/linux/vfio.h           |  2 ++
>>  4 files changed, 89 insertions(+), 2 deletions(-)
>>

> 
> 
>> +static pci_ers_result_t vfio_pci_aer_slot_reset(struct pci_dev *pdev)
>> +{
>> +	struct vfio_pci_device *vdev;
>> +	struct vfio_device *device;
>> +	static pci_ers_result_t err = PCI_ERS_RESULT_NONE;
>> +
>> +	device = vfio_device_get_from_dev(&pdev->dev);
>> +	if (!device)
>> +		goto err_dev;
>> +
>> +	vdev = vfio_device_data(device);
>> +	if (!vdev)
>> +		goto err_data;
>> +
>> +	mutex_lock(&vdev->igate);
>> +
>> +	if (vdev->passive_reset_trigger)
>> +		eventfd_signal(vdev->passive_reset_trigger, 1);
>> +	else if (vdev->err_trigger)
>> +		eventfd_signal(vdev->err_trigger, 1);
> 
> why is this chunk here? why not just do
> 
> 	if (vdev->passive_reset_trigger)
> 		eventfd_signal(vdev->passive_reset_trigger, 1);
> 
> without a fallback?
> 
> 

I thought it is one way of "passing maximum info to userspace and let it
decide."

-- 
Sincerely,
Cao jin
