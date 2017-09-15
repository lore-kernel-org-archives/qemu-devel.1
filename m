Received: from eggs.gnu.org ([2001:4830:134:3::10]:34275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dsq06-0003LY-8k
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 08:45:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dsq02-0004qC-U8
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 08:45:42 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505054255-2990-5-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170913071249.GI7550@umbus.fritz.box>
	<03027eb0-6528-22c6-dcc1-d20323399ec9@ilande.co.uk>
	<ccacf611-c2e2-9cad-d927-67c0fcaa3ad6@redhat.com>
	<20170914035259.GK3972@umbus.fritz.box>
Message-ID: <56298dd2-eabe-5075-61b3-c27a0eaf4579@ilande.co.uk>
Date: Fri, 15 Sep 2017 13:45:11 +0100
MIME-Version: 1.0
In-Reply-To: <20170914035259.GK3972@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/4] ppc: ensure we update the decrementer
 value during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>
Cc: aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 14/09/17 04:52, David Gibson wrote:

> On Wed, Sep 13, 2017 at 07:58:23PM +0200, Laurent Vivier wrote:
>> On 13/09/2017 19:11, Mark Cave-Ayland wrote:
>>> On 13/09/17 08:12, David Gibson wrote:
>>>
>>>> This is subtly incorrect.  It sets the DECR on load to exactly the
>>>> value that was saved.  That effectively means that the DECR is frozen
>>>> for the migration downtime, which probably isn't what we want.
>>>>
>>>> Instead we need to save the DECR as an offset from the timebase, and
>>>> restore it relative to the (downtime adjusted) timebase on the
>>>> destination.
>>>>
>>>> The complication with that is that the timebase is generally migrated
>>>> at the machine level, not the cpu level: the timebase is generally
>>>> synchronized between cpus in the machine, and migrating it at the
>>>> individual cpu could break that.  Which means we probably need a
>>>> machine level hook to handle the decrementer too, even though it
>>>> logically *is* per-cpu, because otherwise we'll be trying to restore
>>>> it before the timebase is restored.
>>>
>>> I know that we discussed this in-depth last year, however I was working
>>> along the lines that Laurent's patch fixed this along the lines of our
>>> previous discussion:
>>> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00338.html (and
>>> indeed Laurent's analysis at
>>> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg01489.html).
>>>
>>> However looking again at the this patch in the context you mentioned
>>> above, I'm starting to wonder if the right solution now is for the
>>> machine init function for g3beige/mac99 to do the same as spapr, e.g.
>>> add cpu_ppc_clock_vm_state_change() as a vm_change_state_handler and
>>> then add VMSTATE_PPC_TIMEBASE_V from the machine PPCTimeBase into my new
>>> subsection?
>>>
>>> Laurent, do you think that your state change handler would work
>>> correctly in this way?
>>
>> I think all is explained in the second link you have mentioned, it seems 
>> we don't need a state handler as KVM DECR will no be updated by the migrated value:
>>
>> hw/ppc/ppc.c
>>
>>     736 static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
>>     737                                  QEMUTimer *timer,
>>     738                                  void (*raise_excp)(void *),
>>     739                                  void (*lower_excp)(PowerPCCPU *),
>>     740                                  uint32_t decr, uint32_t value)
>>     741 {
>> ...
>>     749     if (kvm_enabled()) {
>>     750         /* KVM handles decrementer exceptions, we don't need our own timer */
>>     751         return;
>>     752     }
>> ...
>>
>> But this allows to migrate it for TCG. And it should be correct because in case of TCG I think [need to check] timebase is stopped too (so offset is 0)
>>
>> David, do you agree with that?
> 
> Yes, I think so.  Some details might be different, but the basic idea
> of migrating the timebase and decrementers at machine level should be
> the same for pseries and g3beige/whatever.

>From my perspective, I'd really like to bury all of the timebase
migration logic into timebase_load()/timebase_save() so then as you
suggest above, everything will work regardless of the machine type and host.

Playing around with these functions I can see that they are very
PPC-specific - for example cpu_get_host_ticks() can only ever work
correctly migrating between 2 PPC hosts because here on Intel the value
returned is the TSC register which is completely unrelated to the
timebase frequency. Hence the calculated values are nonsense and the
guest inevitably ends up freezing.

I've had a go at converting this back to using the host clock to
calculate the required adjustment to tb_offset (see
https://github.com/mcayland/qemu/commit/68e31f0455a79d41b2ab703364c74ceb4d513154)
but then even that struck me as incorrect since unless there are other
host CPUs with an equivalent of tb_offset, this whole section of code
should only ever run if the host CPU is PPC, and maybe even only under KVM.

My current thoughts are now as follows:

- The existing timebase_load() should never adjust tb_offset unless the
host CPU is also PPC (how do we actually determine this?). Otherwise it
should always be 0.

- The per-CPU decrementer values should be *stored* in the normal
vmstate SPR array as per my latest patch at
https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg02346.html.

BUT:

- The per-CPU decrementer values should be *restored* in timebase_load()
but again should not be adjusted by tb_offset unless the host CPU is
also PPC.

The real question is whether tb_offset is used for a TCG PPC guest on a
PPC host or whether it also remains at 0 as it does here on an Intel
host? If it does remain at 0 for a TCG PPC guest on a PPC host then we
don't need to work out whether we are running on a PPC host at all: we
can just skip the timebase adjustments made by timebase_load() if
!kvm_enabled() and everything should just work.

If this all seems reasonable then what I need to do for the PPC
g3beige/mac99 machines is add the relevant machine state, include the
existing vmstate_change_handler and then add the code to timebase_load()
to set the decrementer. I'm happy to do this as long as everyone agrees
this is a sensible approach?


ATB,

Mark.
