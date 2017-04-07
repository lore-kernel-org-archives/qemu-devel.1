Received: from eggs.gnu.org ([2001:4830:134:3::10]:37162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cwSAx-0007qB-Mw
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 07:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cwSAu-0003O4-Kk
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 07:35:35 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cwSAu-0003No-Dv
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 07:35:32 -0400
Received: by mail-wr0-x236.google.com with SMTP id o21so75189205wrb.2
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 04:35:32 -0700 (PDT)
References: <20170405132503.32125-1-alex.bennee@linaro.org>
	<20170405132503.32125-12-alex.bennee@linaro.org>
	<5ee6d2cb-d3e5-8b28-6a73-2d84c44ce614@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <5ee6d2cb-d3e5-8b28-6a73-2d84c44ce614@redhat.com>
Date: Fri, 07 Apr 2017 12:35:29 +0100
Message-ID: <87k26wa1ry.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 11/12] cpus: call cpu_update_icount on
 read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: dovgaluk@ispras.ru, rth@twiddle.net, peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 05/04/2017 15:25, Alex Bennée wrote:
>> This ensures each time the vCPU thread reads the icount we update the
>> master timer_state.qemu_icount field. This way as long as updates are
>> in BQL protected sections (which they should be) the main-loop can
>> never come to update the log and find time has gone backwards.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>  cpus.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/cpus.c b/cpus.c
>> index ff75af449a..63de033cc8 100644
>> --- a/cpus.c
>> +++ b/cpus.c
>> @@ -246,19 +246,17 @@ void cpu_update_icount(CPUState *cpu)
>>
>>  int64_t cpu_get_icount_raw(void)
>>  {
>> -    int64_t icount;
>>      CPUState *cpu = current_cpu;
>>
>> -    icount = atomic_read(&timers_state.qemu_icount);
>>      if (cpu && cpu->running) {
>>          if (!cpu->can_do_io) {
>>              fprintf(stderr, "Bad icount read\n");
>>              exit(1);
>>          }
>>          /* Take into account what has run */
>> -        icount += cpu_get_icount_executed(cpu);
>> +        cpu_update_icount(cpu);
>>      }
>> -    return icount;
>> +    return atomic_read(&timers_state.qemu_icount);
>>  }
>>
>>  /* Return the virtual CPU time, based on the instruction counter.  */
>>
>
> Maybe the update should be done in gen_io_start instead.  There
> shouldn't be any interference between vCPU and I/O threads except
> between gen_io_start and gen_io_end.

I'm not sure I follow. gen_io_start is a translation time thing. At
least here we ensure we update whenever the value is read.


--
Alex Bennée
