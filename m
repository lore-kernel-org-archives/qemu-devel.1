Received: from eggs.gnu.org ([2001:4830:134:3::10]:40549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPPMD-0006Si-Si
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:26:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPPMC-0000Xd-DO
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:26:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dPPMC-0000XA-48
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:26:52 -0400
Date: Mon, 26 Jun 2017 09:26:42 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170626082642.GA495@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1496975122-16999-1-git-send-email-cota@braap.org>
	<1496975122-16999-3-git-send-email-cota@braap.org>
	<87poeaog5b.fsf@frigg.lan> <87zicwieu2.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zicwieu2.fsf@frigg.lan>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 2/7] cpu: allocate cpu->trace_dstate in
 place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@redhat.com>

On Sun, Jun 25, 2017 at 12:41:57PM +0300, Llu=C3=ADs Vilanova wrote:
> Llu=C3=ADs Vilanova writes:
>=20
> > Emilio G Cota writes:
> >> There's little point in dynamically allocating the bitmap if we
> >> know at compile-time the max number of events we want to support.
> >> Thus, make room in the struct for the bitmap, which will make things
> >> easier later: this paves the way for upcoming changes, in which
> >> we'll use a u32 to fully capture cpu->trace_dstate.
>=20
> >> This change also increases performance by saving a dereference and
> >> improving locality--note that this is important since upcoming work
> >> makes reading this bitmap fairly common.
>=20
> >> Signed-off-by: Emilio G. Cota <cota@braap.org>
>=20
> > Reviewed-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>=20
> BTW, I think this partially undoes Daniel's changes in
> b7d48952c375842bd669460fd8384d90cc12286c.
>=20
> You should check with him (CC'ed).

That's ok - I only made those changes in order to remove the reliance on
the generated max vcpu event ID counter. Choosing to hardcode a fixed
limit on number of vcpu events instead is a fine alternative.

>=20
> Lluis
>=20
>=20
> >> ---
> >> include/qom/cpu.h | 9 +++------
> >> qom/cpu.c         | 8 --------
> >> trace/control.c   | 9 ++++++++-
> >> 3 files changed, 11 insertions(+), 15 deletions(-)
>=20
> >> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> >> index 89ddb68..bc6e20f 100644
> >> --- a/include/qom/cpu.h
> >> +++ b/include/qom/cpu.h
> >> @@ -259,6 +259,7 @@ typedef void (*run_on_cpu_func)(CPUState *cpu, r=
un_on_cpu_data data);
> >> struct qemu_work_item;
> =20
> >> #define CPU_UNSET_NUMA_NODE_ID -1
> >> +#define CPU_TRACE_DSTATE_MAX_EVENTS 32
> =20
> >> /**
> >> * CPUState:
> >> @@ -373,12 +374,8 @@ struct CPUState {
> >> struct KVMState *kvm_state;
> >> struct kvm_run *kvm_run;
> =20
> >> -    /*
> >> -     * Used for events with 'vcpu' and *without* the 'disabled' pro=
perties.
> >> -     * Dynamically allocated based on bitmap requried to hold up to
> >> -     * trace_get_vcpu_event_count() entries.
> >> -     */
> >> -    unsigned long *trace_dstate;
> >> +    /* Used for events with 'vcpu' and *without* the 'disabled' pro=
perties */
> >> +    DECLARE_BITMAP(trace_dstate, CPU_TRACE_DSTATE_MAX_EVENTS);
> =20
> >> /* TODO Move common fields from CPUArchState here. */
> >> int cpu_index; /* used by alpha TCG */
> >> diff --git a/qom/cpu.c b/qom/cpu.c
> >> index 5069876..69fbb9c 100644
> >> --- a/qom/cpu.c
> >> +++ b/qom/cpu.c
> >> @@ -382,7 +382,6 @@ static void cpu_common_unrealizefn(DeviceState *=
dev, Error **errp)
> =20
> >> static void cpu_common_initfn(Object *obj)
> >> {
> >> -    uint32_t count;
> >> CPUState *cpu =3D CPU(obj);
> >> CPUClass *cc =3D CPU_GET_CLASS(obj);
> =20
> >> @@ -397,18 +396,11 @@ static void cpu_common_initfn(Object *obj)
> >> QTAILQ_INIT(&cpu->breakpoints);
> >> QTAILQ_INIT(&cpu->watchpoints);
> =20
> >> -    count =3D trace_get_vcpu_event_count();
> >> -    if (count) {
> >> -        cpu->trace_dstate =3D bitmap_new(count);
> >> -    }
> >> -
> >> cpu_exec_initfn(cpu);
> >> }
> =20
> >> static void cpu_common_finalize(Object *obj)
> >> {
> >> -    CPUState *cpu =3D CPU(obj);
> >> -    g_free(cpu->trace_dstate);
> >> }
> =20
> >> static int64_t cpu_common_get_arch_id(CPUState *cpu)
> >> diff --git a/trace/control.c b/trace/control.c
> >> index 9b157b0..83740aa 100644
> >> --- a/trace/control.c
> >> +++ b/trace/control.c
> >> @@ -65,8 +65,15 @@ void trace_event_register_group(TraceEvent **even=
ts)
> >> size_t i;
> >> for (i =3D 0; events[i] !=3D NULL; i++) {
> >> events[i]->id =3D next_id++;
> >> -        if (events[i]->vcpu_id !=3D TRACE_VCPU_EVENT_NONE) {
> >> +        if (events[i]->vcpu_id =3D=3D TRACE_VCPU_EVENT_NONE) {
> >> +            continue;
> >> +        }
> >> +
> >> +        if (likely(next_vcpu_id < CPU_TRACE_DSTATE_MAX_EVENTS)) {
> >> events[i]->vcpu_id =3D next_vcpu_id++;
> >> +        } else {
> >> +            error_report("WARNING: too many vcpu trace events; drop=
ping '%s'",
> >> +                         events[i]->name);
> >> }

This should be an abort IMHO, as it would be considered a bug to have
added > 32 vcpu events.

I'd also suggest that the top level 'trace-events' file get a comment
added to the effect that we only support 32 events right now.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
