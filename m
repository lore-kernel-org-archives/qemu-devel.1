Received: from eggs.gnu.org ([2001:4830:134:3::10]:36354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f5VE3-0006N7-J0
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f5VE0-0001LS-HI
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:44:43 -0400
References: <20180409113019.14568-1-david@redhat.com>
	<20180409113019.14568-3-david@redhat.com>
	<a82acbd9-3023-8f3a-c5a6-3fb5b5a0832c@de.ibm.com>
	<e6ee002c-373f-d619-a3e4-a3a6f56b2bda@redhat.com>
	<92f20c1c-5510-3e17-d186-be416635d1da@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b387527b-2851-5cb6-d9a5-65020d8800f6@redhat.com>
Date: Mon, 9 Apr 2018 13:44:30 +0200
MIME-Version: 1.0
In-Reply-To: <92f20c1c-5510-3e17-d186-be416635d1da@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 2/2] s390x: load_psw() should
 only exchange the PSW for KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>

On 09.04.2018 13:40, Christian Borntraeger wrote:
> 
> 
> On 04/09/2018 01:36 PM, David Hildenbrand wrote:
>> On 09.04.2018 13:35, Christian Borntraeger wrote:
>>>
>>>
>>> On 04/09/2018 01:30 PM, David Hildenbrand wrote:
>>>> Let's simplify it a bit. On some weird circumstances we would have tried
>>>> to recompute watchpoints when running under KVM.



>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>  target/s390x/helper.c | 10 ++++++----
>>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
>>>> index 615fa24ab9..e8548f340a 100644
>>>> --- a/target/s390x/helper.c
>>>> +++ b/target/s390x/helper.c
>>>> @@ -103,16 +103,18 @@ void load_psw(CPUS390XState *env, uint64_t mask, uint64_t addr)
>>>>
>>>>      env->psw.addr = addr;
>>>>      env->psw.mask = mask;
>>>> -    if (tcg_enabled()) {
>>>> -        env->cc_op = (mask >> 44) & 3;
>>>> +
>>>> +    /* KVM will handle all WAITs and trigger a WAIT exit on disabled_wait */
>>>> +    if (!tcg_enabled()) {
>>>> +        return;
>>>>      }
>>>> +    env->cc_op = (mask >> 44) & 3;
>>>
>>> Do we have any call path were KVM could call load_psw?
>>
>> do_restart_interrupt()
>>
>> SIGP while the target CPU is stopped.
> 
> makes sense. Can you add that to the patch description? that makes it easier to understand
> what can really go wrong without this patch.

Sure!

Conny, when (and if ;) ) picking this up, can you change the description to

"Let's simplify it a bit. On some weird circumstances we would have
tried to recompute watchpoints when running under KVM. load_psw() is
called from do_restart_interrupt() during a SIGP RESTART if the target
CPU is STOPPED. Let's touch watchpoints only in the TCG case - where
they are used for PER emulation."


-- 

Thanks,

David / dhildenb
