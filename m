Received: from eggs.gnu.org ([2001:4830:134:3::10]:40291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1sIE-0002Nt-G8
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 07:01:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1sI6-0005WR-Sa
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 07:01:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e1sI6-0005W2-K2
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 07:01:38 -0400
References: <CAFEAcA_qCmsekM+bQT8qa7hceSSm2vcoYs-eTzKyH_BOpiVVcw@mail.gmail.com>
	<87zi8z9vng.fsf@linaro.org>
	<CAFEAcA92r=9F=1TTj3YznUSGZR_zzmThfPWvx=ryLjhJFmj__w@mail.gmail.com>
	<09da157a-0f6a-3641-5aba-9bdd020c9a13@redhat.com>
	<CAFEAcA8V5c4RWCpu8Qq5WqKA7sh8yPysB=KKcMc3oR8RNg2gXw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8f1b9b71-6654-a4d2-7cd2-aae9da588985@redhat.com>
Date: Tue, 10 Oct 2017 13:01:34 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8V5c4RWCpu8Qq5WqKA7sh8yPysB=KKcMc3oR8RNg2gXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] tcg/translate-all.c:169: tb_lock: Assertion
 `!have_tb_lock' failed when doing cpu_restore_state in usermode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 10/10/2017 12:52, Peter Maydell wrote:
> On 10 October 2017 at 11:41, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> I've seen the same on x86.  Using the program counter from translate.c
>> here looks very fishy:
>>
>>     /* Now we have a real cpu fault.  Since this is the exact location of
>>      * the exception, we must undo the adjustment done by cpu_restore_state
>>      * for handling call return addresses.  */
>>     cpu_restore_state(cpu, pc + GETPC_ADJ);
> 
> This is the right thing if the signal happened directly from
> translated code (as it will for guest reads/writes). This
> bit of code expects that cpu_restore_state() will just do nothing
> if the pc value isn't actually in a TB.

Yes, it is right if it happens from translated code.  But
cpu_restore_code currently expects either retaddr == 0 or retaddr from a
TB.  And generalizing those expectations...

>> and cpu_restore_state would just return false because tb_find_pc fails.  Maybe
>> something like this?
>>
>> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
>> index 492ea0826c..66a4351b96 100644
>> --- a/accel/tcg/user-exec.c
>> +++ b/accel/tcg/user-exec.c
>> @@ -119,10 +119,13 @@ static inline int handle_cpu_signal(uintptr_t pc, unsigned long address,
>>          return 1; /* the MMU fault was handled without causing real CPU fault */
>>      }
>>
>> -    /* Now we have a real cpu fault.  Since this is the exact location of
>> -     * the exception, we must undo the adjustment done by cpu_restore_state
>> -     * for handling call return addresses.  */
>> -    cpu_restore_state(cpu, pc + GETPC_ADJ);
>> +    if (pc >= (uintptr_t)tcg_ctx.code_gen_buffer &&
>> +        pc < (uintptr_t)tcg_ctx.code_gen_ptr) {
>> +        /* Now we have a real cpu fault.  Since this is the exact location of
>> +         * the exception, we must undo the adjustment done by cpu_restore_state
>> +         * for handling call return addresses.  */
>> +        cpu_restore_state(cpu, pc + GETPC_ADJ);
>> +    }
> 
> I think that would be better inside cpu_restore_state(), because it's
> an internal detail of the TCG accelerator that it happens to put
> all its code inside those bounds.

... makes sense too, and it can replace the existing check for !retaddr
(introduced in commit d8b2239bcd, "translate-all: exit cpu_restore_state
early if translating", 2017-03-09) which only works for softmmu.

Thanks,

Paolo
