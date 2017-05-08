Received: from eggs.gnu.org ([2001:4830:134:3::10]:38477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d7nO9-0001ta-PB
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d7nO6-0003p1-Ii
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:28:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1d7nO6-0003ng-AE
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:28:02 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v48IQ15Z121219
	for <qemu-devel@nongnu.org>; Mon, 8 May 2017 14:28:01 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2aakg4y8g1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 14:27:56 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 8 May 2017 19:27:54 +0100
References: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
	<20170505173507.74077-7-pasic@linux.vnet.ibm.com>
	<20170508173650.GJ2120@work-vm>
	<877c80d1-fa63-0fd1-e394-fb649281aea1@linux.vnet.ibm.com>
	<20170508175906.GK2120@work-vm>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 8 May 2017 20:27:51 +0200
MIME-Version: 1.0
In-Reply-To: <20170508175906.GK2120@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <b69e0df0-120f-6634-d7ff-4bea9ccb4e31@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 06/10] virtio-ccw: use vmstate way for
 config migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org



On 05/08/2017 07:59 PM, Dr. David Alan Gilbert wrote:
>>>>  const VMStateDescription vmstate_virtio_ccw_dev = {
>>>>      .name = "s390_virtio_ccw_dev",
>>>>      .version_id = 1,
>>>> @@ -67,6 +93,14 @@ const VMStateDescription vmstate_virtio_ccw_dev = {
>>>>          VMSTATE_PTR_TO_IND_ADDR(indicators, VirtioCcwDevice),
>>>>          VMSTATE_PTR_TO_IND_ADDR(indicators2, VirtioCcwDevice),
>>>>          VMSTATE_PTR_TO_IND_ADDR(summary_indicator, VirtioCcwDevice),
>>>> +        {
>>>> +        /*
>>>> +         * Ugly hack because VirtIODevice does not migrate itself.
>>>> +         * This also makes legacy via vmstate_save_state possible.
>>>> +         */
>>>> +            .name         = "virtio/config_vector",
>>>> +            .info         = &vmstate_info_config_vector,
>>>> +        },
>>> I'm a bit confused - isn't just this bit the bit going
>>> through the vdev->load_config hook?
>>>
>> Exactly! If you examine the part underscored with ============== in
>> virtio_ccw_(load|save)_config  (that is what is behind vdev->load_config)
>> you should see that we use vmstate_virtio_ccw_dev (that is this
>> VMStateDescription to implement these function. 
>>
>> Actually virtio_ccw_(load|save)_config won't do anything after patch 9
>> and for new machines since the VirtIOCcwDevice is going to migrate
>> itself via DeviceClass.vmsd like other "normal" devices, and we fall
>> back to the VirtIO specific callbacks only in "legacy mode".
>>
>> I hope this helps!
> Hmm, still confused!
> Why are you changing a Virtio device not to use the same migration
> oddities as all the other virtio devices?
> 
> I was assuming we'd have to change the virtio core code to
> solve that for all virtio devices.
> 

You can ask difficult questions ;). First I'm not aware of any
ongoing effort to solve this for all virtio devices by changing
the core, and probably breaking compatibility for all devices
(in a sense I break migration compatibility for all virtio-ccw
devices). To be honest, I have considered that move unlikely,
but the possibility is one of my reasons for seeking an upstream
discussion and having You and Michael on cc.

Why not use virtio oddities? Because they are oddities. I have
figured, it's a good idea to separate the migration of the 
proxy form the rest: we have two QEMU Device objects and it
should be good practice, that these are migrating themselves via
DeviceClass.vmsd. That's what I get with this patch set, 
for new machine versions (since we can not fix the past), and
with the notable difference of config_vector, because it is
defined as a common infrastructure (struct VirtIODevice) but
ain't migrated as a common virtio infrastructure.

Would you suggest to rather keep the oddities? Should I expect
to see a generic solution to the problem sometime soon?

Halil

> Dave
> 
