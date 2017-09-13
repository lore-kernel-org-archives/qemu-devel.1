Received: from eggs.gnu.org ([2001:4830:134:3::10]:57724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dsBvj-0004Vo-6P
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 13:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dsBvg-0002Yf-3o
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 13:58:31 -0400
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505054255-2990-5-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170913071249.GI7550@umbus.fritz.box>
	<03027eb0-6528-22c6-dcc1-d20323399ec9@ilande.co.uk>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <ccacf611-c2e2-9cad-d927-67c0fcaa3ad6@redhat.com>
Date: Wed, 13 Sep 2017 19:58:23 +0200
MIME-Version: 1.0
In-Reply-To: <03027eb0-6528-22c6-dcc1-d20323399ec9@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>
Cc: aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 13/09/2017 19:11, Mark Cave-Ayland wrote:
> On 13/09/17 08:12, David Gibson wrote:
> 
>> This is subtly incorrect.  It sets the DECR on load to exactly the
>> value that was saved.  That effectively means that the DECR is frozen
>> for the migration downtime, which probably isn't what we want.
>>
>> Instead we need to save the DECR as an offset from the timebase, and
>> restore it relative to the (downtime adjusted) timebase on the
>> destination.
>>
>> The complication with that is that the timebase is generally migrated
>> at the machine level, not the cpu level: the timebase is generally
>> synchronized between cpus in the machine, and migrating it at the
>> individual cpu could break that.  Which means we probably need a
>> machine level hook to handle the decrementer too, even though it
>> logically *is* per-cpu, because otherwise we'll be trying to restore
>> it before the timebase is restored.
> 
> I know that we discussed this in-depth last year, however I was working
> along the lines that Laurent's patch fixed this along the lines of our
> previous discussion:
> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00338.html (and
> indeed Laurent's analysis at
> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg01489.html).
> 
> However looking again at the this patch in the context you mentioned
> above, I'm starting to wonder if the right solution now is for the
> machine init function for g3beige/mac99 to do the same as spapr, e.g.
> add cpu_ppc_clock_vm_state_change() as a vm_change_state_handler and
> then add VMSTATE_PPC_TIMEBASE_V from the machine PPCTimeBase into my new
> subsection?
> 
> Laurent, do you think that your state change handler would work
> correctly in this way?

I think all is explained in the second link you have mentioned, it seems 
we don't need a state handler as KVM DECR will no be updated by the migrated value:

hw/ppc/ppc.c

    736 static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
    737                                  QEMUTimer *timer,
    738                                  void (*raise_excp)(void *),
    739                                  void (*lower_excp)(PowerPCCPU *),
    740                                  uint32_t decr, uint32_t value)
    741 {
...
    749     if (kvm_enabled()) {
    750         /* KVM handles decrementer exceptions, we don't need our own timer */
    751         return;
    752     }
...

But this allows to migrate it for TCG. And it should be correct because in case of TCG I think [need to check] timebase is stopped too (so offset is 0)

David, do you agree with that?

Thanks,
Laurent
