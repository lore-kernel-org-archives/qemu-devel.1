Received: from eggs.gnu.org ([2001:4830:134:3::10]:34487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1gZJbc-0008NH-Ju
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:56:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1gZJbT-00025o-0g
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:56:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38182
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.ibm.com>)
	id 1gZJbL-0001sA-R7
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:56:17 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBIHrY4h085777
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 12:56:14 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2pf3bqxpa1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 12:56:14 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
	Tue, 18 Dec 2018 17:56:13 -0000
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181122165432.4437-2-cohuck@redhat.com>
	<d3442c5d-06e9-d87a-3bc3-903f40b0cedf@linux.ibm.com>
	<20181218182400.6305b061.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Tue, 18 Dec 2018 12:56:08 -0500
MIME-Version: 1.0
In-Reply-To: <20181218182400.6305b061.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <af4e2915-2ac0-8c44-92d0-16d381bf9dd8@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] vfio-ccw: add capabilities chain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>



On 12/18/2018 12:24 PM, Cornelia Huck wrote:
> On Mon, 17 Dec 2018 16:53:34 -0500
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> On 11/22/2018 11:54 AM, Cornelia Huck wrote:
>>
>> ...snip...
>>
>>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>>> index 813102810f53..565669f95534 100644
>>> --- a/include/uapi/linux/vfio.h
>>> +++ b/include/uapi/linux/vfio.h
>>> @@ -297,6 +297,7 @@ struct vfio_region_info_cap_type {
>>>    
>>>    #define VFIO_REGION_TYPE_PCI_VENDOR_TYPE	(1 << 31)
>>>    #define VFIO_REGION_TYPE_PCI_VENDOR_MASK	(0xffff)
>>> +#define VFIO_REGION_TYPE_CCW			(1 << 30)
>>
>> Oof.  So the existing VFIO_REGION_TYPE_PCI_VENDOR_TYPE gets OR'd with
>> another value (e.g., 8086).  But in 4.20, there was a
>> VFIO_REGION_TYPE_GFX is added as simply "1" ... Which direction are
>> these definitions being added from?  I guess asked another way, is
>> _TYPE_CCW going to be OR'd with anything else that necessitates its
>> presence as an identifier with some Other Thing, or should this follow
>> the TYPE_GFX enumeration?  Perhaps the type field needs to be tidied up
>> to help this sit more cleanly now?  (Sorry!)
> 
> The semantics of that type stuff are really a bit unclear to me :(

+1

I was confused when I first looked at this.  When I applied it to 4.20, 
I got another level of confusion.  ;)

> 
> I don't think we'll ever do any fancy mask handling for ccw. It is
> probably enough to have any kind of uniqueness within the different
> types, so maybe counting up would be indeed enough...

Considering the subtype space, I think it would be fine too.  But wanted 
to ask in case I've been out of the loop on something.

> 
>>
>>    - Eric
>>
>>>    
>>>    /* 8086 Vendor sub-types */
>>>    #define VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION	(1)
>>>    
>>
> 
