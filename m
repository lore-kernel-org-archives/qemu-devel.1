Received: from eggs.gnu.org ([209.51.188.92]:59600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ggwWu-0003xO-GW
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 13:55:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ggwWs-0001t9-IN
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 13:55:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:20971)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1ggwWs-0001iN-Bi
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 13:55:10 -0500
References: <20190102141603.3681-1-lvivier@redhat.com>
	<ea341cde-f1d6-1a25-e64f-3426adc10c3b@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <ac0fd4eb-b148-7854-80e9-e37d441f3116@redhat.com>
Date: Tue, 8 Jan 2019 19:47:05 +0100
MIME-Version: 1.0
In-Reply-To: <ea341cde-f1d6-1a25-e64f-3426adc10c3b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] cpus: ignore ESRCH in
 qemu_cpu_kick_thread()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 08/01/2019 00:02, Paolo Bonzini wrote:
> On 02/01/19 15:16, Laurent Vivier wrote:
>> We can have a race condition between qemu_cpu_kick_thread() and
>> qemu_kvm_cpu_thread_fn() when we hotunplug a CPU. In this case,
>> qemu_cpu_kick_thread() can try to kick a thread that is exiting.
>> pthread_kill() returns an error and qemu is stopped by an exit(1).
>>
>>    qemu:qemu_cpu_kick_thread: No such process
>>
>> We can ignore safely this error.
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>  cpus.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/cpus.c b/cpus.c
>> index 0ddeeefc14..4717490bd0 100644
>> --- a/cpus.c
>> +++ b/cpus.c
>> @@ -1778,7 +1778,7 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
>>      }
>>      cpu->thread_kicked = true;
>>      err = pthread_kill(cpu->thread->thread, SIG_IPI);
>> -    if (err) {
>> +    if (err && err != ESRCH) {
>>          fprintf(stderr, "qemu:%s: %s", __func__, strerror(err));
>>          exit(1);
>>      }
>>
> 
> You could in principle be sending the signal to another thread, so the
> fix is a bit hackish.  However, I don't have a better idea that is not
> racy. :(
> 
> The problem is that qemu_cpu_kick does not use any spinlock or mutex to
> synchronize against cpu_remove_sync's qemu_thread_join.  I think once
> the you reach qemu_cpu_kick in cpu_remove_sync (so if cpu->unplug) you
> do not need to reset cpu->thread_kicked anymore, but I don't think
> that's enough to fix it.

Will you take the patch through one of your pull requests or should I
add it to the trivial-patches branch?

Thanks,
Laurent
