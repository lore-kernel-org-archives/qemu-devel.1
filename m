Received: from eggs.gnu.org ([2001:4830:134:3::10]:54630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cu2Xs-000416-1K
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 15:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cu2Xo-0007fF-T8
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 15:49:16 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cu2Xo-0007eN-JP
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 15:49:12 -0400
Received: by mail-wr0-x22c.google.com with SMTP id l43so115414311wre.1
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 12:49:12 -0700 (PDT)
References: <20170307155054.5833-1-alex.bennee@linaro.org>
	<001801d29bf5$dcba37d0$962ea770$@ru> <8760jdqpv2.fsf@linaro.org>
	<000101d29cbc$b8df1ca0$2a9d55e0$@ru> <87tw6vq43b.fsf@linaro.org>
	<000001d29e30$138e5700$3aab0500$@ru> <871stxpdzz.fsf@linaro.org>
	<002501d29e64$27b383c0$771a8b40$@ru> <87inn1xunu.fsf@linaro.org>
	<000601d2a852$ac5211d0$04f63570$@ru> <87vaqs4dxc.fsf@linaro.org>
	<001b01d2a94a$fe5c46a0$fb14d3e0$@ru> <87o9wj3phd.fsf@linaro.org>
	<000901d2a9ff$89fcdad0$9df69070$@ru> <87fuht4rpy.fsf@linaro.org>
	<829ebb57-51b4-d6e1-4807-98b8ab65ae28@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <829ebb57-51b4-d6e1-4807-98b8ab65ae28@redhat.com>
Date: Fri, 31 Mar 2017 20:49:09 +0100
Message-ID: <87d1cx447e.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 00/11] MTTCG fix-ups for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>, peter.maydell@linaro.org, rth@twiddle.net, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 31/03/2017 13:21, Alex Bennée wrote:
>> Anyway I think I'm getting closer to narrowing it down. On record I see
>> replay_current_step jump backwards with this:
>>
>> /* A common event print, called when reading or saving an event */
>> static void print_event(uint8_t event)
>> {
>>     static int event_count;
>>     static uint64_t last_step;
>>     uint64_t this_step = replay_get_current_step();
>>
>>     fprintf(stderr, "replay: event %d is %d @ step=%#" PRIx64 "\n",
>>             event_count, event, this_step);
>>
>>     if (this_step < last_step) {
>>         fprintf(stderr,"%s: !!! step %d went backwards %#"PRIx64"=>%#"PRIx64"!!!\n",
>>                 __func__, event_count, last_step, this_step);
>>         abort();
>>     }
>>     last_step = this_step;
>>     event_count++;
>> }
>>
>> void replay_put_event(uint8_t event)
>> {
>>     assert(event < EVENT_COUNT);
>>     replay_put_byte(event);
>>     print_event(event);
>> }
>>
>> The jump back is fairly consistent in my case (event 66 in the vexpress
>> run) but I'm fairly sure that is the bug. I can't see any reason for the
>> step count to go backwards - indeed that breaks the premise of .
>
> Good catch!  I suspect it's the "else" case in cpu_get_icount_raw:
>
>     icount = timers_state.qemu_icount;
>     if (cpu) {
>         if (!cpu->can_do_io) {
>             fprintf(stderr, "Bad icount read\n");
>             exit(1);
>         }
>         icount -= (cpu->icount_decr.u16.low + cpu->icount_extra);
>     }
>
> Between
>
>         timers_state.qemu_icount += count;
>
> and
>
>         timers_state.qemu_icount -= (cpu->icount_decr.u16.low
>                                     + cpu->icount_extra);
>
> the I/O thread can read a value that is later rolled back.  I think you
> need to do this the other way round: add something to icount in
> cpu_get_icount_raw rather than taking it off:
>
>     icount = timers_state.qemu_icount;
>     if (cpu) {
>         if (!cpu->can_do_io) {
>             fprintf(stderr, "Bad icount read\n");
>             exit(1);
>         }
>         icount += cpu->pending_icount
>             - (cpu->icount_decr.u16.low + cpu->icount_extra);
>     }
>
> where cpu->pending_icount is set before cpu_exec, and folded into
> timers_state.qemu_icount afterwards.
>
> Also, here:
>
>     if (use_icount) {
>         int64_t count;
>         int decr;
>         timers_state.qemu_icount -= (cpu->icount_decr.u16.low
>                                     + cpu->icount_extra);
>         cpu->icount_decr.u16.low = 0;
>         cpu->icount_extra = 0;
>
> this should be dead code because tcg_cpu_exec also clears the two
> decrementer fields.  So if you can replace the three assignments with
> assertions on cpu->icount_decr.u16.low and cpu->icount_extra, that would
> also simplify the code and remove race opportunities.

I'll have a look at that on Monday. I wrote this before I saw your
email:

  https://github.com/stsquad/qemu/tree/mttcg/debug-record-replay-v1

It fixes the race so time only ever goes forward. Combined with the
following patches it also makes the record/replay streams tolerant of
"missing the boat". With this I can do a initrd run of the vexpress
kernel in both record and playback.

I'm not sure it counts as deterministic though - the vCPU and main-loop
thread seem to figure it out as the go along but I suspect if we really
want to be sure we push the replay_lock() further up. This would ensure
all related events from whichever thread are pushed together.

This is very much a come back on Monday and see if it still seems like a
good idea in the cold light of morning ;-)

--
Alex Bennée
