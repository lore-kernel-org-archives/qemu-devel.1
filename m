Received: from eggs.gnu.org ([2001:4830:134:3::10]:50319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eK43L-0002Kq-SL
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:13:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eK43H-0007LH-Si
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:13:35 -0500
References: <20171128203326.6062-1-david@redhat.com>
	<20171128203326.6062-2-david@redhat.com>
	<20171129155558.2a2de0cc.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <10fcbe4f-c7a8-ecd4-f6da-c3e69704e4a3@redhat.com>
Date: Wed, 29 Nov 2017 16:13:28 +0100
MIME-Version: 1.0
In-Reply-To: <20171129155558.2a2de0cc.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 01/15] s390x/tcg: introduce and
 use program_interrupt_ra()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On 29.11.2017 15:55, Cornelia Huck wrote:
> On Tue, 28 Nov 2017 21:33:11 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Allows to easily convert more callers of program_interrupt() and to
>> easily introduce new exceptions without forgetting about the cpu state
>> reset.
>>
>> Use program_interrupt_ra() in places where we already had the same
>> pattern.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/cpu.h           |  2 ++
>>  target/s390x/crypto_helper.c |  7 ++-----
>>  target/s390x/excp_helper.c   |  5 +----
>>  target/s390x/interrupt.c     | 13 +++++++++++++
>>  target/s390x/mem_helper.c    | 35 +++++++++++------------------------
>>  target/s390x/misc_helper.c   |  3 +--
>>  6 files changed, 30 insertions(+), 35 deletions(-)
> 
>> diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
>> index ce6177c141..6ce06bb549 100644
>> --- a/target/s390x/interrupt.c
>> +++ b/target/s390x/interrupt.c
>> @@ -53,6 +53,19 @@ void program_interrupt(CPUS390XState *env, uint32_t code, int ilen)
>>      }
>>  }
>>  
>> +void program_interrupt_ra(CPUS390XState *env, uint32_t code, int ilen,
>> +                          uintptr_t ra)
>> +{
>> +    S390CPU *cpu = s390_env_get_cpu(env);
> 
> Move this under the if?
> 

Indeed, thanks.

-- 

Thanks,

David / dhildenb
