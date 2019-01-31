Received: from eggs.gnu.org ([209.51.188.92]:40058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gpJdF-0003XG-Dv
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:12:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gpJdE-0000vA-NA
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:12:21 -0500
References: <20190130155733.32742-1-david@redhat.com>
	<20190130155733.32742-6-david@redhat.com>
	<8f4b29e0-80c7-05f9-375b-842607d86131@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a79693fa-0589-4467-4f83-f7f038de0600@redhat.com>
Date: Thu, 31 Jan 2019 22:12:17 +0100
MIME-Version: 1.0
In-Reply-To: <8f4b29e0-80c7-05f9-375b-842607d86131@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 5/6] s390x/pci: Drop
 release timer and replace it with a flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 31.01.19 21:33, Collin Walling wrote:
> On 1/30/19 10:57 AM, David Hildenbrand wrote:
>> Let's handle it similar to x86 ACPI PCI code and don't use a timer.
>> Instead, remember if an unplug request is pending and keep it pending
>> for eternity. (a follow up patch will process the request on
>> reboot).
>>
>> We expect that a guest that is up and running, will process the unplug
>> request and trigger the unplug. This is normal operation, no timer needed.
>>
>> If the guest does not react, this usually means something in the guest
>> is going wrong. Simply removing the device after 30 seconds does not
>> really sound like a good idea. It might sometimes be wanted, but I
>> consider this rather an "opt-in" decision as it might harm a guest not
>> prepared for it.
>>
>> If we ever actually want a "forced/surprise removal", we will have to
>> implement something on top of the existing "device_del" framework. E.g.
>> also x86 might want to do a forced/surprise removal of PCI devices under
>> some conditions. "device_del X, forced=true" could be an option and will
>> require changes to the hotplug handler infrastructure.
>>
>> This will then move the responsibility on when to do a forced removal
>> to a higher level. Doing a forced removal right now overcomplicates
> 
> nit: "over-complicates" or "over complicates"
> 
>> things and doesn't really.
> 
> "...and doesn't really." sounds odd to me :)

Hmm, I guess this was meant to be

"and doesn't really seem to be required." :)

> 
>>
>> Let's allow to send multiple requests.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
> 
> Just a quick clean up of the commit message, and all is good.
> 

Thanks!

> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> 


-- 

Thanks,

David / dhildenb
