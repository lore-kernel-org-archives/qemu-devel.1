Received: from eggs.gnu.org ([2001:4830:134:3::10]:36452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cRlCF-0003KU-FJ
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 14:38:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cRlCA-0004zA-In
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 14:38:03 -0500
Received: from roura.ac.upc.es ([147.83.33.10]:39101)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cRlCA-0004yk-5K
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 14:37:58 -0500
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <148295045448.19871.9819696634619157347.stgit@fimbulvetr.bsc.es>
	<148295047061.19871.11792107348459066542.stgit@fimbulvetr.bsc.es>
	<20170109170156.GL30228@stefanha-x1.localdomain>
	<34ec95ff-7283-4e6f-fc07-7678424d0e13@redhat.com>
	<20170111161640.GA9269@stefanha-x1.localdomain>
Date: Thu, 12 Jan 2017 20:37:52 +0100
In-Reply-To: <20170111161640.GA9269@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Wed, 11 Jan 2017 16:16:40 +0000")
Message-ID: <8760lkt6gf.fsf@ac.upc.edu>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 3/7] trace: [tcg] Delay changes to
 dynamic state when translating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

Stefan Hajnoczi writes:

> On Tue, Jan 10, 2017 at 05:31:37PM +0100, Paolo Bonzini wrote:
>> On 09/01/2017 18:01, Stefan Hajnoczi wrote:
>> > Or use a simpler scheme:
>> > 
>> > struct CPUState {
>> >     ...
>> >     uint32_t dstate_update_count;
>> > };
>> > 
>> > In trace_event_set_vcpu_state_dynamic():
>> > 
>> >     if (state) {
>> >         trace_events_enabled_count++;
>> >         set_bit(vcpu_id, vcpu->trace_dstate_delayed);
>> > 	atomic_inc(&vcpu->dstate_update_count, 1);
>> >         (*ev->dstate)++;
>> >     } ...
>> > 
>> > In cpu_exec() and friends:
>> > 
>> >     last_dstate_update_count = atomic_read(&vcpu->dstate_update_count);
>> > 
>> >     tb = tb_find(cpu, last_tb, tb_exit);
>> >     cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit, &sc);
>> > 
>> >     /* apply and disable delayed dstate changes */
>> >     if (unlikely(atomic_read(&cpu->dstate_update_count) != last_dstate_update_count)) {
>> >         bitmap_copy(cpu->trace_dstate, cpu->trace_dstate_delayed,
>> >         trace_get_vcpu_event_count());
>> >     }
>> > 
>> > (You'll need to adjust the details but the update counter approach
>> > should be workable.)
>> 
>> Would it work to use async_run_on_cpu?

> I think so.

AFAIU we cannot use async_run_on_cpu(), since we need to reset the local
variable "last_tb" to avoid chaining TBs with different dstates, and we cannot
use cpu_loop_exit() inside the callback.

To make it work, we'd need to add some new boolean flag on the vCPU to control
when to reset "last_tb", and then we're just as good as implementing the async
work "protocol" manually for this specific case.

What I'll do is fix the race condition by simplifying that code (haven't looked
at the problem yet).


Thanks,
  Lluis
