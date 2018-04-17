Received: from eggs.gnu.org ([2001:4830:134:3::10]:48928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1f8WTv-0005jP-Mb
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 15:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1f8WTs-0003pc-II
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 15:41:35 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
	id 1f8WTs-0003nH-CD
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 15:41:32 -0400
References: <1523340193-9024-1-git-send-email-yulei.zhang@intel.com>
	<a4bfe3d3-d9a0-565e-800c-c4493e328d87@nvidia.com>
	<01FDBDDE256B79498DC57789713132D46A18E835@SHSMSX101.ccr.corp.intel.com>
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <c0b5be42-6574-a47e-4b4e-477de4f3926e@nvidia.com>
Date: Wed, 18 Apr 2018 01:11:22 +0530
MIME-Version: 1.0
In-Reply-To: <01FDBDDE256B79498DC57789713132D46A18E835@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH V4 3/4] vfio: Add SaveVMHanlders for
 VFIO device to support live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhang, Yulei" <yulei.zhang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>, "Wang, Zhi A" <zhi.a.wang@intel.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>



On 4/17/2018 1:31 PM, Zhang, Yulei wrote:

>>> +static SaveVMHandlers savevm_vfio_handlers = {
>>> +    .save_setup = vfio_save_setup,
>>> +    .save_live_pending = vfio_save_live_pending,
>>> +    .save_live_complete_precopy = vfio_save_complete,
>>> +    .load_state = vfio_load,
>>> +};
>>> +
>>
>> Isn't .is_active, .save_live_iterate and .cleanup required?
>> What is vendor driver have large amount of data in device's memory which
>> vendor driver is aware of? and vendor driver would required multiple
>> iterations to send that data to QEMU to save complete state of device?
>>
> I suppose the vendor driver will copy the device's memory to the device
> region iteratively, and let qemu read from the device region and transfer
> the data to the target side in pre-copy stage, isn't it? 
> 


As Dave mentioned in other mail in this thread, all data will not be
copied only in pre-copy state. Some static data would be copied in
pre-copy state but there could be significant amount of data in
stop-and-copy state where iterations would be required. .is_active and
.save_live_iterate would be required for that iterations.

.cleanup is required to provide an indication to vendor driver that
migration is complete and vendor driver can cleanup all the extra
allocations done for migration.

Thanks,
Kirti
