Received: from eggs.gnu.org ([2001:4830:134:3::10]:35552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e7Ndz-000378-IM
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e7Ndv-0007XO-El
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:30:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1e7Ndv-0007Vs-5X
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:30:55 -0400
References: <20171020145437.18549-1-borntraeger@de.ibm.com>
	<d028d04a-9c28-af10-3410-f9007867cc05@de.ibm.com>
	<1ac27ce2-091d-e1b7-fc94-ebdf696a35e9@redhat.com>
	<9f4037d8-93a3-be0f-8cb4-4424158e236b@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1755e4d4-9e39-b77c-1c97-f01dccde1ac1@redhat.com>
Date: Wed, 25 Oct 2017 17:30:24 +0200
MIME-Version: 1.0
In-Reply-To: <9f4037d8-93a3-be0f-8cb4-4424158e236b@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH/QEMU] s390x/kvm: use cpu_model_available
 for guarded storage on compat machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Marc Hartmayer <mhartmay@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

On 25.10.2017 17:09, Boris Fiuczynski wrote:
> On 10/25/2017 12:23 PM, David Hildenbrand wrote:
>> On 25.10.2017 12:18, Christian Borntraeger wrote:
>>> Ping, I plan to submit belows patch for 2.11. We can then still look into
>>> a libvirt<->qemu interface for limiting host-model depending on machine versions
>>> (or not).
>>
>> I think this would be sufficient for now.
>>
>> Having different host models, depending on the the machine type sounds
>> wrong. But maybe we'll need it in the future.
>>
> 
> David, I disagree if your proposal is to generally tolerate new cpu 
> features in old machine types. This *might* work for gs but how do you 
> guaranty that guests do not behave differently/wrong when suddenly new 
> cpu features are made available to guest when (re-)starting them.
> That is my feedback for the qemu side of this mater.

My point would be that it seems to work for all existing architectures
(so far as I am aware) and this one problem is easily fixed (and stems
from old CPU feature compatibility handling). So my question would be,
are there any potential CPU features that make such handling necessary
right now or in the near future?

> 
> Regarding the libvirt side of this:
> When looking at https://libvirt.org/formatdomain.html#elementsCPU I 
> found the following sentence:
> Since the CPU definition is copied just before starting a domain, 
> exactly the same XML can be used on different hosts while still 
> providing the best guest CPU each host supports.
> 
> My interpretation of "the best guest CPU each host supports" is that 
> besides limiting factors like hardware, kernel and qemu capabilities the 
> requested machine type for the guest is a limiting factor as well.

I understand "what the host supports" as combination of hw+kernel+qemu.
But the definition can be interpreted differently. I don't think that
the requested machine has to be taken into account at this point.
(Again, do you have any real examples where this would be applicable?)

> 
> Nevertheless if my interpretation is found to be incorrect than we 
> should think about another new cpu mode that includes the machine type 
> into the "best guest CPU" detection.

Which use case? I just want to understand how the current solution could
be problematic? (besides the problem we had, which is easily fixed)

> My assumption is that we must not require the users to know which cpu 
> model they manually need to define to match a specific machine type
> AND we want to guarantee that guests run without risking any side 
> effects by tolerating any additional cpu features.

That's why I think CPU models should be independent of the used QEMU
machine. It just over complicates things as we have seen.

Especially suddenly having multiple "host" CPU models depending on the
machine type, confusing. If we can, we should keep it simple.

-- 

Thanks,

David
