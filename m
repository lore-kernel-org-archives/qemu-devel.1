Received: from eggs.gnu.org ([2001:4830:134:3::10]:48628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eD97T-0001xK-Fa
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:13:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eD97O-0002Xg-Cn
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:13:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eD97O-0002VB-0k
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:13:10 -0500
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
	<20171031112644.10516.1734.stgit@pasha-VirtualBox>
	<a8979594-78e4-13dc-2958-f7b4444a1bb0@redhat.com>
	<001501d353cd$29099010$7b1cb030$@ru>
	<18ddcf7c-0198-a0ce-c2cc-992131512897@redhat.com>
	<fbda6d5e-aee1-ec74-faf4-e2dde0003588@redhat.com>
	<001201d3547d$929156c0$b7b40440$@ru>
	<954d2fb6-ce56-3000-f395-404c238eb040@redhat.com>
	<000301d359fc$c168fc30$443af490$@ru>
	<331c5386-e0a9-8b85-66fb-cdd82eef8ece@redhat.com>
	<000701d35a1f$9a2e7be0$ce8b73a0$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0d21b0e1-976f-1088-b6d4-e452b38d4d03@redhat.com>
Date: Fri, 10 Nov 2017 14:12:58 +0100
MIME-Version: 1.0
In-Reply-To: <000701d35a1f$9a2e7be0$ce8b73a0$@ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 19/26] cpu-exec: reset exit flag before
 calling cpu_exec_nocache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, boost.lists@gmail.com, alex.bennee@linaro.org

On 10/11/2017 13:29, Pavel Dovgalyuk wrote:
>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>>>>>
>>>>> I tried this approach and it didn't work.
>>>>> I think iothread sets u16.high flag after resetting it in cpu_handle_interrupt.
>>>>
>>>> But why is this a problem?  The TB would exit immediately and go again
>>>> to cpu_handle_interrupt.  cpu_handle_interrupt returns true and
>>>> cpu_handle_exception causes the exception via cpu_exec_nocache.
>>>
>>> I've tested your variant more thoroughly.
>>> It seems, that iothread calls cpu_exec between atomic_set(&cpu->icount_decr.u16.high, 0);
>>> in cpu_handle_interrupt and cpu_exec_nocache in cpu_handle_exception.
>>> I see no other reason, because this happens not for the every time.
>>> And cpu_handle_interrupt is not called again, because cpu_handle_exception returns true.
>>> Therefore we have an infinite loop, because no other code here resets cpu-
>>> icount_decr.u16.high.
>>
>> Then returning true unconditionally is wrong in the cpu_exec_nocache
>> case.  What if you do:
>>
>> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>> index 61297f8f4a..fb5446be3e 100644
>> --- a/accel/tcg/cpu-exec.c
>> +++ b/accel/tcg/cpu-exec.c
>> @@ -470,7 +470,19 @@ static inline void cpu_handle_debug_exception(CPUState *cpu)
>>
>>  static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
>>  {
>> -    if (cpu->exception_index >= 0) {
>> +    if (cpu->exception_index < 0) {
>> +#ifndef CONFIG_USER_ONLY
>> +        if (replay_has_exception()
>> +            && cpu->icount_decr.u16.low + cpu->icount_extra == 0) {
>> +            /* try to cause an exception pending in the log */
>> +            cpu_exec_nocache(cpu, 1, tb_find(cpu, NULL, 0, curr_cflags()), true);
>> +        }
>> +#endif
>> +        if (cpu->exception_index < 0) {
>> +            return;
> 
> return false, I guess?
> This approach allows iterating in case of races
> and QEMU does not hangs anymore at replay.

Great, can you put this change the next time you send your series?
There are some parts that can definitely go in for 2.11.

Thanks,

Paolo

>> +        }
>> +    }
>> +
>>          if (cpu->exception_index >= EXCP_INTERRUPT) {
>>              /* exit request from the cpu execution loop */
>>              *ret = cpu->exception_index;
>> @@ -505,16 +517,6 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
>>              }
>>  #endif
>>          }
>> -#ifndef CONFIG_USER_ONLY
>> -    } else if (replay_has_exception()
>> -               && cpu->icount_decr.u16.low + cpu->icount_extra == 0) {
>> -        /* try to cause an exception pending in the log */
>> -        cpu_exec_nocache(cpu, 1, tb_find(cpu, NULL, 0, curr_cflags()), true);
>> -        *ret = -1;
>> -        return true;
>> -#endif
>> -    }
>> -
>>      return false;
>>  }
>>
> 
> 
> Pavel Dovgalyuk
> 
