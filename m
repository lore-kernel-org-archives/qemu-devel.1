Received: from eggs.gnu.org ([209.51.188.92]:34240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1go5Cc-0006Qc-9s
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:35:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1go5CY-00071Z-Ng
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:35:44 -0500
References: <1548349076-350255-1-git-send-email-imammedo@redhat.com>
	<3b4eef57-dc27-356e-5487-0b9b53a75cb1@redhat.com>
	<20190125114026.66703a35@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <02a14f4d-e3aa-643f-4462-97717b21ab49@redhat.com>
Date: Mon, 28 Jan 2019 12:28:43 +0100
MIME-Version: 1.0
In-Reply-To: <20190125114026.66703a35@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x: remove direct reference to mem_path
 global form s90x code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com, rth@twiddle.net

On 25.01.19 11:40, Igor Mammedov wrote:
> On Fri, 25 Jan 2019 09:03:49 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 24.01.19 17:57, Igor Mammedov wrote:
>>> I plan to deprecate -mem-path option and replace it with memory-backend,
>>> for that it's necessary to get rid of mem_path global variable.
>>> Do it for s390x case, replacing it with alternative way to enable
>>> 1Mb hugepages capability.
>>>
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> ---
>>> PS:
>>> Original code nor the new one probably is not entirely correct when
>>> huge pages are enabled in case where mixed initial RAM and memory
>>> backends are used, backend's page size might not match initial RAM's
>>> so I'm not sure if enabling 1MB cap is correct in this case on s390
>>> (should it be the same for all RAM???).
>>> With new approach 1Mb cap is not enabled if the smallest page size
>>> is not 1Mb.  
>>
>> There is no memory hotplug (DIMM/NVDIMM), so there really only is
>> initial memory.
> Ok, but what about coming up virtio-mem?

virtio-mem will at least initially only support !huge pages. But
longterm it is indeed possible.

But hotplugging will require runtime checks (if 1mb was not enabled, we
must not allow hotplugging 1mb via any mechanism). We can do such checks
in the machine hotplug handler than.

> 
> 
>>> ---
>>>  target/s390x/kvm.c | 37 ++++++++++++++++---------------------
>>>  1 file changed, 16 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>>> index 2ebf26a..22e868a 100644
>>> --- a/target/s390x/kvm.c
>>> +++ b/target/s390x/kvm.c
>>> @@ -285,33 +285,28 @@ void kvm_s390_crypto_reset(void)
>>>      }
>>>  }
>>>  
>>> -static int kvm_s390_configure_mempath_backing(KVMState *s)
>>> +static int kvm_s390_configure_hugepage_backing(KVMState *s)
>>>  {
>>> -    size_t path_psize = qemu_mempath_getpagesize(mem_path);
>>> +    size_t psize = qemu_getrampagesize();
>>>  
>>> -    if (path_psize == 4 * KiB) {  
>>
>> if you keep this (modified) check you have to do minimal changes in the
>> code below. (e.g. not indent error messages)
> Do you mean to keep this function as is and only 
>  s/qemu_mempath_getpagesize(mem_path)/qemu_getrampagesize()/

Basically yes, but whatever you prefer.

Thanks!

-- 

Thanks,

David / dhildenb
