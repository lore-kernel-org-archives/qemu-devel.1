Received: from eggs.gnu.org ([208.118.235.92]:55621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gCKTu-0004nj-0e
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 04:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gCKTo-0006DK-ML
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 04:13:32 -0400
References: <20181003193931.18096-1-richard.henderson@linaro.org>
	<20181003193931.18096-9-richard.henderson@linaro.org>
	<12df0e47-0105-a200-5ed8-0b0311d1b09f@redhat.com>
	<bbee3d45-5cf0-dab7-c2be-b104762e8dc5@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <05ed2143-b852-cb56-02d6-510ec85414a8@redhat.com>
Date: Tue, 16 Oct 2018 10:13:08 +0200
MIME-Version: 1.0
In-Reply-To: <bbee3d45-5cf0-dab7-c2be-b104762e8dc5@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 8/9] target/s390x: Skip
 wout, cout helpers if op helper does not return
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org

On 11/10/2018 18:47, Richard Henderson wrote:
> On 10/11/18 1:06 AM, David Hildenbrand wrote:
>> On 03/10/2018 21:39, Richard Henderson wrote:
>>> When op raises an exception, it may not have initialized the output
>>> temps that would be written back by wout or cout.
>>>
>>> Cc: qemu-s390x@nongnu.org
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>  target/s390x/translate.c | 12 +++++++-----
>>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
>>> index 7363aabf3a..7fad3ad8e9 100644
>>> --- a/target/s390x/translate.c
>>> +++ b/target/s390x/translate.c
>>> @@ -6164,11 +6164,13 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
>>>      if (insn->help_op) {
>>>          ret = insn->help_op(s, &o);
>>>      }
>>> -    if (insn->help_wout) {
>>> -        insn->help_wout(s, &f, &o);
>>> -    }
>>> -    if (insn->help_cout) {
>>> -        insn->help_cout(s, &o);
>>> +    if (ret != DISAS_NORETURN) {
>>> +        if (insn->help_wout) {
>>> +            insn->help_wout(s, &f, &o);
>>> +        }
>>> +        if (insn->help_cout) {
>>> +            insn->help_cout(s, &o);
>>> +        }
>>>      }
>>>  
>>>      /* Free any temporaries created by the helpers.  */
>>>
>>
>> What about things like LPSW/LPWSE ? They certainly don't imply that we
>> had an exception.
> 
> Exception in the tcg sense, not the guest architectural sense, in that we call
> cpu_loop_exit from the helper, which performs a longjmp.  (Incidentally,
> there's no reason to do that for load_psw -- we could just exit the tb normally.)
> 
>> (these two don't use wout/cout, so it is still fine, but I would prefer
>> a comment somewhere because otherwise it is really easy to miss that
>> DISAS_NORETURN makes us skip these handlers)
> 
> Where would you like me to place that comment?  In the DisasInsn definition?

That probably makes sense!

> 
> 
> r~
> 


-- 

Thanks,

David / dhildenb
