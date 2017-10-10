Received: from eggs.gnu.org ([2001:4830:134:3::10]:47249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e1vON-00049t-Po
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e1vOH-0007W2-Dd
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:20:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e1vOH-0007VR-4q
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:20:13 -0400
Date: Tue, 10 Oct 2017 16:20:06 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171010162006.4e541412.cohuck@redhat.com>
In-Reply-To: <cf1fd114-9b28-88b1-baac-669407631846@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-2-david@redhat.com>
	<cf1fd114-9b28-88b1-baac-669407631846@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/30] s390x/tcg: turn INTERRUPT_EXT
 into a mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org

On Fri, 6 Oct 2017 09:08:45 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 28.09.2017 22:36, David Hildenbrand wrote:
> > External interrupts are currently all handled like floating external
> > interrupts, they are queued. Let's prepare for a split of floating
> > and local interrupts by turning INTERRUPT_EXT into a mask.
> > 
> > While we can have various floating external interrupts of one kind, there
> > is usually only one (or a fixed number) of the local external interrupts.
> > 
> > So turn INTERRUPT_EXT into a mask and properly indicate the kind of
> > external interrupt. Floating interrupts will have to moved out of
> > one CPU instance later once we have SMP support.
> > 
> > The only floating external interrupts used right now are SERVICE
> > interrupts, so let's use that name. Following patches will clean up
> > SERVICE interrupt injection.
> > 
> > This get's rid of the ugly special handling for cpu timer and clock
> > comparator interrupts. And we really only store the parameters as
> > defined by the PoP.
> > 
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  target/s390x/cpu.h         | 13 ++++++----
> >  target/s390x/excp_helper.c | 63 +++++++++++++++++++++++-----------------------
> >  target/s390x/helper.c      | 12 ++-------
> >  target/s390x/internal.h    |  2 ++
> >  target/s390x/interrupt.c   | 18 ++++++++++++-
> >  5 files changed, 61 insertions(+), 47 deletions(-)  
> [...]
> > diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
> > index 058e219fe5..b9c30f86d7 100644
> > --- a/target/s390x/interrupt.c
> > +++ b/target/s390x/interrupt.c
> > @@ -71,7 +71,23 @@ void cpu_inject_ext(S390CPU *cpu, uint32_t code, uint32_t param,
> >      env->ext_queue[env->ext_index].param = param;
> >      env->ext_queue[env->ext_index].param64 = param64;
> >  
> > -    env->pending_int |= INTERRUPT_EXT;
> > +    env->pending_int |= INTERRUPT_EXT_SERVICE;
> > +    cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
> > +}
> > +
> > +void cpu_inject_clock_comparator(S390CPU *cpu)
> > +{
> > +    CPUS390XState *env = &cpu->env;
> > +
> > +    env->pending_int |= INTERRUPT_EXT_CLOCK_COMPARATOR;
> > +    cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
> > +}
> > +
> > +void cpu_inject_cpu_timer(S390CPU *cpu)
> > +{
> > +    CPUS390XState *env = &cpu->env;
> > +
> > +    env->pending_int |= INTERRUPT_EXT_CPU_TIMER;
> >      cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
> >  }  
> 
> The last two function look similar enough that you could merge the
> functions, e.g.:
> 
> void cpu_inject_ext_pending_bit(S390CPU *cpu, int bit)
> {
>     CPUS390XState *env = &cpu->env;
> 
>     env->pending_int |= bit;
>     cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
> }
> 
> ?
> 
> Apart from that, the patch looks fine to me.
> 
>  Thomas

FWIW, I'd prefer to keep these as separate functions.
