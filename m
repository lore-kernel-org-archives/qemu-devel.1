Received: from eggs.gnu.org ([2001:4830:134:3::10]:32846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cRmro-00005A-6g
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 16:25:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cRmrn-0002Yl-AA
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 16:25:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cRmrn-0002XH-3x
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 16:25:03 -0500
References: <148295045448.19871.9819696634619157347.stgit@fimbulvetr.bsc.es>
	<148295047061.19871.11792107348459066542.stgit@fimbulvetr.bsc.es>
	<20170109170156.GL30228@stefanha-x1.localdomain>
	<34ec95ff-7283-4e6f-fc07-7678424d0e13@redhat.com>
	<20170111161640.GA9269@stefanha-x1.localdomain>
	<8760lkt6gf.fsf@ac.upc.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <205320cf-f0c9-536e-8220-7e18ffe08725@redhat.com>
Date: Thu, 12 Jan 2017 22:25:00 +0100
MIME-Version: 1.0
In-Reply-To: <8760lkt6gf.fsf@ac.upc.edu>
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
To: Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>



On 12/01/2017 20:37, Llu=C3=ADs Vilanova wrote:
> Stefan Hajnoczi writes:
>=20
>> On Tue, Jan 10, 2017 at 05:31:37PM +0100, Paolo Bonzini wrote:
>>> On 09/01/2017 18:01, Stefan Hajnoczi wrote:
>>>> Or use a simpler scheme:
>>>>
>>>> struct CPUState {
>>>>     ...
>>>>     uint32_t dstate_update_count;
>>>> };
>>>>
>>>> In trace_event_set_vcpu_state_dynamic():
>>>>
>>>>     if (state) {
>>>>         trace_events_enabled_count++;
>>>>         set_bit(vcpu_id, vcpu->trace_dstate_delayed);
>>>> 	atomic_inc(&vcpu->dstate_update_count, 1);
>>>>         (*ev->dstate)++;
>>>>     } ...
>>>>
>>>> In cpu_exec() and friends:
>>>>
>>>>     last_dstate_update_count =3D atomic_read(&vcpu->dstate_update_co=
unt);
>>>>
>>>>     tb =3D tb_find(cpu, last_tb, tb_exit);
>>>>     cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit, &sc);
>>>>
>>>>     /* apply and disable delayed dstate changes */
>>>>     if (unlikely(atomic_read(&cpu->dstate_update_count) !=3D last_ds=
tate_update_count)) {
>>>>         bitmap_copy(cpu->trace_dstate, cpu->trace_dstate_delayed,
>>>>         trace_get_vcpu_event_count());
>>>>     }
>>>>
>>>> (You'll need to adjust the details but the update counter approach
>>>> should be workable.)
>>>
>>> Would it work to use async_run_on_cpu?
>=20
>> I think so.
>=20
> AFAIU we cannot use async_run_on_cpu(), since we need to reset the loca=
l
> variable "last_tb" to avoid chaining TBs with different dstates, and we=
 cannot
> use cpu_loop_exit() inside the callback.

async_run_on_cpu would run as soon as the currently executing TB
finishes, and would leave cpu_exec completely, so there would be no
chaining.

Paolo

> To make it work, we'd need to add some new boolean flag on the vCPU to =
control
> when to reset "last_tb", and then we're just as good as implementing th=
e async
> work "protocol" manually for this specific case.
>=20
> What I'll do is fix the race condition by simplifying that code (haven'=
t looked
> at the problem yet).
>=20
>=20
> Thanks,
>   Lluis
>=20
