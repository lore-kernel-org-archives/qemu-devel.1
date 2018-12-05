Received: from eggs.gnu.org ([2001:4830:134:3::10]:44405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gUavM-0001pQ-5a
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:25:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gUavF-0003GZ-Li
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:25:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gUavE-0003F0-VC
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:25:17 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB5HOLA1018144
	for <qemu-devel@nongnu.org>; Wed, 5 Dec 2018 12:25:15 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p6har5t1p-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 12:25:15 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 5 Dec 2018 17:25:13 -0000
References: <20181205145131.28467-1-cohuck@redhat.com>
	<0d97dcf5-de40-3f18-64fc-7b2eb1799a84@redhat.com>
	<20181205174508.3e2452af.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 5 Dec 2018 18:25:08 +0100
MIME-Version: 1.0
In-Reply-To: <20181205174508.3e2452af.cohuck@redhat.com>
Content-Language: en-US
Message-Id: <55928716-cd64-735b-ae66-64b370997e22@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH RFC] vfio-ap: flag as compatible with
 balloon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org



On 05.12.2018 17:45, Cornelia Huck wrote:
> On Wed, 5 Dec 2018 17:38:22 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 05.12.18 15:51, Cornelia Huck wrote:
>>> vfio-ap devices do not pin any pages in the host. Therefore, they
>>> are belived to be compatible with memory ballooning.
>>>
>>> Flag them as compatible, so both vfio-ap and a balloon can be
>>> used simultaneously.
>>>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>
>>> As briefly discussed on IRC. RFC as I do not have easy access to
>>> hardware I can test this with.
>>>
>>> ---
>>>  hw/vfio/ap.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>>> index 65de952f44..3bf48eed28 100644
>>> --- a/hw/vfio/ap.c
>>> +++ b/hw/vfio/ap.c
>>> @@ -104,6 +104,14 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>>>      vapdev->vdev.name = g_strdup_printf("%s", mdevid);
>>>      vapdev->vdev.dev = dev;
>>>  
>>> +    /*
>>> +     * vfio-ap devices are believed to operate in a way compatible with
>>> +     * memory ballooning, as no pages are pinned in the host.
>>> +     * This needs to be set before vfio_get_device() for vfio common to
>>> +     * handle the balloon inhibitor.
>>> +     */
>>> +    vapdev->vdev.balloon_allowed = true;
>>> +
>>>      ret = vfio_get_device(vfio_group, mdevid, &vapdev->vdev, &local_err);
>>>      if (ret) {
>>>          goto out_get_dev_err;
>>>   
>>
>> What happens if this ever changes? Shouldn't we have an API to at least
>> check what the vfio device can guarantee?
>>
>> "are believed to operate" doesn't sound like guarantees to me :)

I would actually remove that comment or fix it. We either know or we dont.
In the way vfio-works I see no reason to disallow balloon. Even if the guest does
something wrong (e.g. crypto I/O on freed pages) the host would handle that the
same as it would for normal page accesses. From a host point of view the crypto
instructions are just CISC instructions with load/store semantics.

> 
> It's the same for ccw :)
> 
> While such an API definitely sounds like a good idea, it is probably
> overkill to introduce it for this case (do we envision changing the way
> vfio-ap operates in the future to make that statement non-true?)

agreed. 
> 
