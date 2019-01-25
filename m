Received: from eggs.gnu.org ([209.51.188.92]:56504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gmzs6-0002xW-7K
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gmzs5-00073O-EH
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59372
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gmzs5-000712-81
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:05 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0PBct5N013419
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 06:42:03 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q7ykneu3y-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 06:42:03 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 25 Jan 2019 11:42:01 -0000
References: <1548349076-350255-1-git-send-email-imammedo@redhat.com>
	<3b4eef57-dc27-356e-5487-0b9b53a75cb1@redhat.com>
	<20190125114026.66703a35@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 25 Jan 2019 12:41:57 +0100
MIME-Version: 1.0
In-Reply-To: <20190125114026.66703a35@redhat.com>
Content-Language: en-US
Message-Id: <ec195eb0-2d00-c4b4-60c4-1fff2f3eedfa@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
To: Igor Mammedov <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, pasic@linux.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com, rth@twiddle.net



On 25.01.2019 11:40, Igor Mammedov wrote:
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
> 
> I'm curious what are possible page sizes are possible on the host
> for file (hugepage) backed RAM and for anonymous RAM (malloc & co)

The hardware supports 4k, 1M and 2G pages. KVM supports 4k anonymous (and
also file backed) pages, as well as 1M hugetlbfs. No support for THP and
no support for 2G hugetlbfs today.
