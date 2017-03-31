Received: from eggs.gnu.org ([2001:4830:134:3::10]:40551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ctuma-000502-KV
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ctumV-00017Q-O0
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:31:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ctumV-00017D-FC
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:31:51 -0400
References: <20170307155054.5833-1-alex.bennee@linaro.org>
	<001801d29bf5$dcba37d0$962ea770$@ru> <8760jdqpv2.fsf@linaro.org>
	<000101d29cbc$b8df1ca0$2a9d55e0$@ru> <87tw6vq43b.fsf@linaro.org>
	<000001d29e30$138e5700$3aab0500$@ru> <871stxpdzz.fsf@linaro.org>
	<002501d29e64$27b383c0$771a8b40$@ru> <87inn1xunu.fsf@linaro.org>
	<000601d2a852$ac5211d0$04f63570$@ru> <87vaqs4dxc.fsf@linaro.org>
	<001b01d2a94a$fe5c46a0$fb14d3e0$@ru> <87o9wj3phd.fsf@linaro.org>
	<000901d2a9ff$89fcdad0$9df69070$@ru> <87fuht4rpy.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <829ebb57-51b4-d6e1-4807-98b8ab65ae28@redhat.com>
Date: Fri, 31 Mar 2017 13:31:45 +0200
MIME-Version: 1.0
In-Reply-To: <87fuht4rpy.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/11] MTTCG fix-ups for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: peter.maydell@linaro.org, rth@twiddle.net, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com



On 31/03/2017 13:21, Alex Benn=C3=A9e wrote:
> Anyway I think I'm getting closer to narrowing it down. On record I see
> replay_current_step jump backwards with this:
>=20
> /* A common event print, called when reading or saving an event */
> static void print_event(uint8_t event)
> {
>     static int event_count;
>     static uint64_t last_step;
>     uint64_t this_step =3D replay_get_current_step();
>=20
>     fprintf(stderr, "replay: event %d is %d @ step=3D%#" PRIx64 "\n",
>             event_count, event, this_step);
>=20
>     if (this_step < last_step) {
>         fprintf(stderr,"%s: !!! step %d went backwards %#"PRIx64"=3D>%#=
"PRIx64"!!!\n",
>                 __func__, event_count, last_step, this_step);
>         abort();
>     }
>     last_step =3D this_step;
>     event_count++;
> }
>=20
> void replay_put_event(uint8_t event)
> {
>     assert(event < EVENT_COUNT);
>     replay_put_byte(event);
>     print_event(event);
> }
>=20
> The jump back is fairly consistent in my case (event 66 in the vexpress
> run) but I'm fairly sure that is the bug. I can't see any reason for th=
e
> step count to go backwards - indeed that breaks the premise of .

Good catch!  I suspect it's the "else" case in cpu_get_icount_raw:

    icount =3D timers_state.qemu_icount;
    if (cpu) {
        if (!cpu->can_do_io) {
            fprintf(stderr, "Bad icount read\n");
            exit(1);
        }
        icount -=3D (cpu->icount_decr.u16.low + cpu->icount_extra);
    }

Between

        timers_state.qemu_icount +=3D count;

and

        timers_state.qemu_icount -=3D (cpu->icount_decr.u16.low
                                    + cpu->icount_extra);

the I/O thread can read a value that is later rolled back.  I think you
need to do this the other way round: add something to icount in
cpu_get_icount_raw rather than taking it off:

    icount =3D timers_state.qemu_icount;
    if (cpu) {
        if (!cpu->can_do_io) {
            fprintf(stderr, "Bad icount read\n");
            exit(1);
        }
        icount +=3D cpu->pending_icount
            - (cpu->icount_decr.u16.low + cpu->icount_extra);
    }

where cpu->pending_icount is set before cpu_exec, and folded into
timers_state.qemu_icount afterwards.

Also, here:

    if (use_icount) {
        int64_t count;
        int decr;
        timers_state.qemu_icount -=3D (cpu->icount_decr.u16.low
                                    + cpu->icount_extra);
        cpu->icount_decr.u16.low =3D 0;
        cpu->icount_extra =3D 0;

this should be dead code because tcg_cpu_exec also clears the two
decrementer fields.  So if you can replace the three assignments with
assertions on cpu->icount_decr.u16.low and cpu->icount_extra, that would
also simplify the code and remove race opportunities.

Paolo

>>>>>> - replay puts back unexecuted instructions (qemu_icount -=3D count=
er)
>>>>>>
>>>>>> But virtual timer cannot take in account non-executed instructions=
 (counter) and
>>>>>> therefore it reads only qemu_icount, which provides incorrect time=
.
>>>>>>
>>>>>>> But the timers are all enabled:
>>>>>>>
>>>>>>>   (gdb) qemu timers
>>>>>>>   Processing Realtime timers
>>>>>>>     clock QEMU_CLOCK_REALTIME is enabled:true, last:-922337203685=
4775808
>>>>>>>   Processing Virtual timers
>>>>>>>     clock QEMU_CLOCK_VIRTUAL is enabled:true, last:-9223372036854=
775808
>>>>>>>       timer 34297350016/1 (cb:0x555555a2e952 <ptimer_tick>)
>>>>>>>       timer 503290000000/1000000 (cb:0x555555bd4d1d <ra_timer_han=
dler>)
>>>>>>>   Processing Host timers
>>>>>>>     clock QEMU_CLOCK_HOST is enabled:true, last:14901913192701340=
00
>>>>>>>   Processing Virtual RT timers
>>>>>>>     clock QEMU_CLOCK_VIRTUAL_RT is enabled:true, last:-9223372036=
854775808
>>>>>>
>>>>>> Timers are processed only at checkpoints recorded in the log.
>>>>>> When replay is stuck, probably there is a pending checkpoint in th=
e log
>>>>>> and pending instructions in CPU (because iothread breaks its
>>>>>> synchronization).
>>>>>
>>>>> How does this work for instructions that sleep (like WFI)? The WFI =
will
>>>>> cause us to exit the loop but I assume we need a "real" timer to tr=
igger
>>>>> a firing of whatever the WFI is waiting for as time according to ic=
ount
>>>>> isn't advancing.
>>>>
>>>> This is virtual_rt for. It advances even when vCPU is stopped.
>>>
>>> So I'm not seeing this happen:
>>>
>>>   process_icount_data: icount not increased 117302332749=3D>117302332=
749 RT:-1
>>>
>>> I wonder if the advance of virtual_rt has been deadlocked? The -1
>>> suggests its not even setup.
>>
>> qemu_start_warp_timer says that it is setup only when there are active=
 virtual timers.
>>
>>
>>>> By the way, I made small description of the replay log format
>>>> to be later included into docs/replay.txt:
>>>>
>>> Thanks. That's really useful.
>>>
>>> Do you think it would be worth including the dumper script I wrote in
>>> ./scripts/? I mainly wrote it to aid my understanding of the code flo=
w
>>> but it might be useful in future investigations?
>>
>> Usually I get human-readable logs in record and replay modes to find
>> divergence between them, but I think your script might be useful in so=
me cases.
>=20
> Cool. I'll include it in the icount series once I have something to pos=
t
> (fingers crossed I'm getting close).
>=20
> --
> Alex Benn=C3=A9e
>=20
