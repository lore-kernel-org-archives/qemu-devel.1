Received: from eggs.gnu.org ([2001:4830:134:3::10]:34980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ckuRz-0000ww-Av
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:21:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ckuRu-0000sb-C8
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:21:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1ckuRu-0000r6-2L
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:21:22 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v26F8arO070043
	for <qemu-devel@nongnu.org>; Mon, 6 Mar 2017 10:21:19 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2917pm01n7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 10:21:19 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 6 Mar 2017 15:21:17 -0000
References: <20170302185942.76255-1-pasic@linux.vnet.ibm.com>
	<20170303132149.34e5906a.cornelia.huck@de.ibm.com>
	<aa9b9219-f3a6-165c-2d92-156a9295adbb@linux.vnet.ibm.com>
	<20170303135012.17edb640.cornelia.huck@de.ibm.com>
	<d00802cc-150a-2263-604d-9c2eaa5c19d1@linux.vnet.ibm.com>
	<20170306155625.5c426793.cornelia.huck@de.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 6 Mar 2017 16:21:13 +0100
MIME-Version: 1.0
In-Reply-To: <20170306155625.5c426793.cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <bf1f8af2-9d76-c148-24c5-7d00312c10d4@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] virtio: fail device if
 set_event_notifier fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>



On 03/06/2017 03:56 PM, Cornelia Huck wrote:
> On Fri, 3 Mar 2017 14:08:37 +0100
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> On 03/03/2017 01:50 PM, Cornelia Huck wrote:
>>> On Fri, 3 Mar 2017 13:43:32 +0100
>>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>>
>>>> On 03/03/2017 01:21 PM, Cornelia Huck wrote:
>>>>> On Thu,  2 Mar 2017 19:59:42 +0100
>>>>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
[...]
>> I admit, I did not investigate this thoroughly, also because the patch
>> is flawed regarding multi-thread anyway. After a quick investigation
>> it seems the linux guest won't auto-reset the device so the guest should
>> end up with a not working device. I think it's pretty likely that the
>> admin will check the logs if the device was important.
> 
> Thinking a bit more about this, it seems setting the device broken is
> not the right solution for exactly that reason. Setting the virtio
> device broken is a way to signal the guest to 'you did something
> broken; please reset the device and start anew' (and that's how current
> callers use it). In our case, this is not the guest's fault.

Do we have something to just say stuff broken without blaming the guest?
And device reset might not be that stupid at all in the given situation,
if we want to save what can be saved from the perspective of the guest.
(After reset stuff should work again until we hit the race again -- and
since turning ioeventfd on/off should not happen that often during normal
operation it could help limit damage suffered -- e.g. controlled shutdown).

> 
> Maybe go back to the assert 'solution'? But I'm not sure that's enough
> if production builds disable asserts...
> 

I will wait a bit, maybe other virtio folks are going to have an 
opinion too.

My concern about the assert solution is that for production it is
either too rigorous (kill off, hopefully with a dump) or not
enough (as you have mentioned, if NDEBUG assert does nothing).


I think there are setups where a loss of device does not have to be
fatal, and I would not like to be the one who makes it fatal (for the
guest).

Regards,
Halil
