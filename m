Received: from eggs.gnu.org ([2001:4830:134:3::10]:45408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQsS8-0000w4-13
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQsS3-0000Iu-4x
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:47:36 -0400
References: <20180525113708.29856-1-david@redhat.com>
	<20180525113708.29856-7-david@redhat.com>
	<20180604140903.2629d329.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <cd4912c2-5169-4a46-3434-6767c24fc386@redhat.com>
Date: Thu, 7 Jun 2018 12:47:28 +0200
MIME-Version: 1.0
In-Reply-To: <20180604140903.2629d329.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 6/7] s390x/tcg: rearm the
 CKC timer during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, "Collin L . Walling" <walling@linux.ibm.com>, Richard Henderson <rth@twiddle.net>

On 04.06.2018 14:09, Cornelia Huck wrote:
> On Fri, 25 May 2018 13:37:07 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> If the CPU data is migrated after the TOD clock, the CKC timer of a CPU
>> is not rearmed. Let's rearm it when loading the CPU state.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/machine.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/target/s390x/machine.c b/target/s390x/machine.c
>> index 84b4928755..53d226ff48 100644
>> --- a/target/s390x/machine.c
>> +++ b/target/s390x/machine.c
>> @@ -34,6 +34,13 @@ static int cpu_post_load(void *opaque, int version_id)
>>          return kvm_s390_vcpu_interrupt_post_load(cpu);
>>      }
>>  
>> +#ifdef CONFIG_TCG
>> +    if (tcg_enabled()) {
>> +        /* Rearm the CKC timer if necessary */
>> +        tcg_s390_tod_updated(CPU(cpu), RUN_ON_CPU_NULL);
> 
> Stub this out so the explicit CONFIG_TCG is not required? But I don't
> care too much.


Yes, can do!

-- 

Thanks,

David / dhildenb
