Received: from eggs.gnu.org ([2001:4830:134:3::10]:42616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cS899-0003Wy-WA
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:08:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cS896-0006kS-SN
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:08:23 -0500
Received: from roura.ac.upc.edu ([147.83.33.10]:58444 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cS896-0006i4-GD
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:08:20 -0500
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <148295045448.19871.9819696634619157347.stgit@fimbulvetr.bsc.es>
	<148295047061.19871.11792107348459066542.stgit@fimbulvetr.bsc.es>
	<20170109170156.GL30228@stefanha-x1.localdomain>
	<34ec95ff-7283-4e6f-fc07-7678424d0e13@redhat.com>
	<20170111161640.GA9269@stefanha-x1.localdomain>
	<8760lkt6gf.fsf@ac.upc.edu>
	<205320cf-f0c9-536e-8220-7e18ffe08725@redhat.com>
Date: Fri, 13 Jan 2017 21:08:12 +0100
In-Reply-To: <205320cf-f0c9-536e-8220-7e18ffe08725@redhat.com> (Paolo
	Bonzini's message of "Thu, 12 Jan 2017 22:25:00 +0100")
Message-ID: <87k29y7mfn.fsf@ac.upc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

Paolo Bonzini writes:

> On 12/01/2017 20:37, Llu=C3=ADs Vilanova wrote:
>> Stefan Hajnoczi writes:
>>=20
>>> On Tue, Jan 10, 2017 at 05:31:37PM +0100, Paolo Bonzini wrote:
>>>> On 09/01/2017 18:01, Stefan Hajnoczi wrote:
>>>>> Or use a simpler scheme:
>>>>>=20
>>>>> struct CPUState {
>>>>> ...
>>>>> uint32_t dstate_update_count;
>>>>> };
>>>>>=20
>>>>> In trace_event_set_vcpu_state_dynamic():
>>>>>=20
>>>>> if (state) {
>>>>> trace_events_enabled_count++;
>>>>> set_bit(vcpu_id, vcpu->trace_dstate_delayed);
>>>>> atomic_inc(&vcpu->dstate_update_count, 1);
>>>>> (*ev->dstate)++;
>>>>> } ...
>>>>>=20
>>>>> In cpu_exec() and friends:
>>>>>=20
>>>>> last_dstate_update_count =3D atomic_read(&vcpu->dstate_update_count);
>>>>>=20
>>>>> tb =3D tb_find(cpu, last_tb, tb_exit);
>>>>> cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit, &sc);
>>>>>=20
>>>>> /* apply and disable delayed dstate changes */
>>>>> if (unlikely(atomic_read(&cpu->dstate_update_count) !=3D last_dstate_=
update_count)) {
>>>>> bitmap_copy(cpu->trace_dstate, cpu->trace_dstate_delayed,
>>>>> trace_get_vcpu_event_count());
>>>>> }
>>>>>=20
>>>>> (You'll need to adjust the details but the update counter approach
>>>>> should be workable.)
>>>>=20
>>>> Would it work to use async_run_on_cpu?
>>=20
>>> I think so.
>>=20
>> AFAIU we cannot use async_run_on_cpu(), since we need to reset the local
>> variable "last_tb" to avoid chaining TBs with different dstates, and we =
cannot
>> use cpu_loop_exit() inside the callback.

> async_run_on_cpu would run as soon as the currently executing TB
> finishes, and would leave cpu_exec completely, so there would be no
> chaining.

Aha, I've re-read the internals used by async and that'll be sufficient.


Thanks,
  Lluis
