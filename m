Received: from eggs.gnu.org ([2001:4830:134:3::10]:33944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f5VAS-0004aA-IO
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f5VAP-0007HQ-Fb
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:41:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1f5VAP-0007Gh-5W
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:40:57 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w39BdDkV038940
	for <qemu-devel@nongnu.org>; Mon, 9 Apr 2018 07:40:55 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h82tnvbf1-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 07:40:55 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 9 Apr 2018 12:40:52 +0100
References: <20180409113019.14568-1-david@redhat.com>
	<20180409113019.14568-3-david@redhat.com>
	<a82acbd9-3023-8f3a-c5a6-3fb5b5a0832c@de.ibm.com>
	<e6ee002c-373f-d619-a3e4-a3a6f56b2bda@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 9 Apr 2018 13:40:48 +0200
MIME-Version: 1.0
In-Reply-To: <e6ee002c-373f-d619-a3e4-a3a6f56b2bda@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <92f20c1c-5510-3e17-d186-be416635d1da@de.ibm.com>
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
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>



On 04/09/2018 01:36 PM, David Hildenbrand wrote:
> On 09.04.2018 13:35, Christian Borntraeger wrote:
>>
>>
>> On 04/09/2018 01:30 PM, David Hildenbrand wrote:
>>> Let's simplify it a bit. On some weird circumstances we would have tried
>>> to recompute watchpoints when running under KVM.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  target/s390x/helper.c | 10 ++++++----
>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
>>> index 615fa24ab9..e8548f340a 100644
>>> --- a/target/s390x/helper.c
>>> +++ b/target/s390x/helper.c
>>> @@ -103,16 +103,18 @@ void load_psw(CPUS390XState *env, uint64_t mask, uint64_t addr)
>>>
>>>      env->psw.addr = addr;
>>>      env->psw.mask = mask;
>>> -    if (tcg_enabled()) {
>>> -        env->cc_op = (mask >> 44) & 3;
>>> +
>>> +    /* KVM will handle all WAITs and trigger a WAIT exit on disabled_wait */
>>> +    if (!tcg_enabled()) {
>>> +        return;
>>>      }
>>> +    env->cc_op = (mask >> 44) & 3;
>>
>> Do we have any call path were KVM could call load_psw?
> 
> do_restart_interrupt()
> 
> SIGP while the target CPU is stopped.

makes sense. Can you add that to the patch description? that makes it easier to understand
what can really go wrong without this patch.

> 
>>
>>>
>>>      if ((old_mask ^ mask) & PSW_MASK_PER) {
>>>          s390_cpu_recompute_watchpoints(CPU(s390_env_get_cpu(env)));
>>>      }
>>>
>>> -    /* KVM will handle all WAITs and trigger a WAIT exit on disabled_wait */
>>> -    if (tcg_enabled() && (mask & PSW_MASK_WAIT)) {
>>> +    if (mask & PSW_MASK_WAIT) {
>>>          s390_handle_wait(s390_env_get_cpu(env));
>>>      }
>>>  }
>>>
>>
> 
> 
