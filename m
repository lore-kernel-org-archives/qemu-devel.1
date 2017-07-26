Received: from eggs.gnu.org ([2001:4830:134:3::10]:58538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1daNIF-0006KL-2I
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1daNIB-0003MF-3E
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:28:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1daNIA-0003LX-QP
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:28:03 -0400
Date: Wed, 26 Jul 2017 16:27:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170726162754.2e445d9a@nial.brq.redhat.com>
In-Reply-To: <20170726140114.GF20793@localhost.localdomain>
References: <1501049917-4701-1-git-send-email-wang.yi59@zte.com.cn>
	<1501049917-4701-2-git-send-email-wang.yi59@zte.com.cn>
	<20170726140114.GF20793@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] hmp: dump ids including socket-id,
 core-id and so on for 'info registers'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Yi Wang <wang.yi59@zte.com.cn>, dgilbert@redhat.com, armbru@redhat.com, pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, Liu.Jianjun3@zte.com.cn, liu.yunh@zte.com.cn

On Wed, 26 Jul 2017 11:01:14 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Wed, Jul 26, 2017 at 02:18:36AM -0400, Yi Wang wrote:
> > This patch add output of CPUs' socket-id, core-id, thread-id and
> > apic-id for 'info registers', which can be used for querying other
> > hmp commands.
> > 
> > Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> > Signed-off-by: Yun Liu <liu.yunh@zte.com.cn>
> > ---
> >  target/i386/helper.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/target/i386/helper.c b/target/i386/helper.c
> > index f63eb3d..a52f300 100644
> > --- a/target/i386/helper.c
> > +++ b/target/i386/helper.c
> > @@ -416,6 +416,14 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
> >      int eflags, i, nb;
> >      char cc_op_name[32];
> >      static const char *seg_name[6] = { "ES", "CS", "SS", "DS", "FS", "GS" };
> > +    APICCommonState *s = APIC_COMMON(cpu->apic_state);
> > +
> > +    if (!s) {
> > +        cpu_fprintf(f, "local apic state not available\n");
> > +        return;
> > +    } 
> 
> This breaks "info registers" on 486:
> 
>   $ ./x86_64-softmmu/qemu-system-x86_64 -cpu 486 -display none -monitor stdio
>   QEMU 2.9.90 monitor - type 'help' for more information
>   (qemu) info registers
>   local apic state not available
>   (qemu)
> 
> You can simply use X86CPU::apic_id.  The field is set to a consistent value
> even if there's no guest-visible APIC, because we use it as a VCPU identifier
> internally.
> 
> However, I'm not sure "info registers" is the right place to print this info.
> I think "info cpus" would be a more obvious place, but it would probably make
> its output too long.
> We could implement something like "info cpus -v", but: the "apic-id" info would
> be redundant as soon as we replace "CPU #<cpu_index>" with "CPU #<arch_id>",
lets do it in 'info registers' for now, it looks like obvious place to display
yet another cpu register.


> and other details like socket/core/thread could just appear on "info qtree".
cpus are not displayed in 'info qtree'

> 
> 
> > +    cpu_fprintf(f, "(socket-id:%d core-id:%d thread-id:%d apic-id:%d)\n",
> > +            cpu->socket_id, cpu->core_id, cpu->thread_id, s->id);
> >  
> >      eflags = cpu_compute_eflags(env);
> >  #ifdef TARGET_X86_64
> > -- 
> > 1.8.3.1
> > 
> >   
> 
